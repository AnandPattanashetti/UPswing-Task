# IAM Policy Document for Assume Role
data "aws_iam_policy_document" "upswingtask_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# IAM Role for EKS Cluster
resource "aws_iam_role" "upswingtask_eks_cluster_role" {
  name               = "eks-cluster-cloud"
  assume_role_policy = data.aws_iam_policy_document.upswingtask_assume_role.json
}

# Attach AmazonEKSClusterPolicy to EKS Role
resource "aws_iam_role_policy_attachment" "upswingtask_eks_cluster_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.upswingtask_eks_cluster_role.name
}

#get vpc data
data "aws_vpc" "upswingtask_default_vpc" {
  default = true
}

#get public subnets for cluster
data "aws_subnets" "upswingtask_public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.upswingtask_default_vpc.id]
  }
}

# Create EKS Cluster
resource "aws_eks_cluster" "upswingtask_eks_cluster" {
  name     = "EKS_CLOUD"
  role_arn = aws_iam_role.upswingtask_eks_cluster_role.arn

  vpc_config {
    subnet_ids = data.aws_subnets.upswingtask_public_subnets.ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.upswingtask_eks_cluster_policy_attachment,
  ]
}

# IAM Role for EKS Node Group
resource "aws_iam_role" "upswingtask_eks_node_group_role" {
  name = "eks-node-group-cloud"

  assume_role_policy = jsonencode({
    Statement = [ {
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    } ]
    Version = "2012-10-17"
  })
}

# Attach policies to EKS Node Role
resource "aws_iam_role_policy_attachment" "upswingtask_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.upswingtask_eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "upswingtask_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.upswingtask_eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "upswingtask_ecs_readonly_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.upswingtask_eks_node_group_role.name
}

#create node group
resource "aws_eks_node_group" "upswingtask_eks_node_group" {
  cluster_name    = aws_eks_cluster.upswingtask_eks_cluster.name
  node_group_name = "Node-cloud"
  node_role_arn   = aws_iam_role.upswingtask_eks_node_group_role.arn
  subnet_ids      = data.aws_subnets.upswingtask_public_subnets.ids

  scaling_config {
    desired_size = 3
    max_size     = 4
    min_size     = 1
  }
  instance_types = ["t2.medium"]

  depends_on = [
    aws_iam_role_policy_attachment.upswingtask_eks_worker_node_policy,
    aws_iam_role_policy_attachment.upswingtask_eks_cni_policy,
    aws_iam_role_policy_attachment.upswingtask_ecs_readonly_policy,
  ]
}
