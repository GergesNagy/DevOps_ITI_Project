# Creating IAM role for Kubernetes clusters to make calls to other AWS services on your behalf to manage the resources that you use with the service.

resource "aws_iam_role" "iam-role-eks-cluster" {
  name = "terraformekscluster"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

# Attaching the EKS-Cluster policies to the terraformekscluster role.

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam-role-eks-cluster.name
}


# Security group for network traffic to and from AWS EKS Cluster.

resource "aws_security_group" "eks-cluster" {
  name        = "SG-eks-cluster"
  vpc_id      = var.new_vpc_id  

# Egress allows Outbound traffic from the EKS cluster to the  Internet 

  egress {                   # Outbound Rule
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
# Ingress allows Inbound traffic to EKS cluster from the  Internet 

  ingress {                  # Inbound Rule
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.public1_subnet_cidr]
  }

  ingress {                  # Inbound Rule
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.public1_subnet_cidr]
  }

  ingress {                  # Inbound Rule
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.public1_subnet_cidr]
  }

}

# Creating the EKS cluster

resource "aws_eks_cluster" "eks_cluster" {
  name     = "gergesEKScluster"
  role_arn =  "${aws_iam_role.iam-role-eks-cluster.arn}"
  version  = "1.21"

# Adding VPC Configuration

  vpc_config { # Configure EKS with vpc and network settings 
   security_group_ids = ["${aws_security_group.eks-cluster.id}"]
   subnet_ids         = [var.private1_subnet_id,var.private2_subnet_id,var.public2_subnet_id,var.public1_subnet_id]
   #endpoint_private_access = true
   endpoint_public_access = true
    }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
    #aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy,
   ]
}

# Creating IAM role for EKS nodes to work with other AWS Services. 

resource "aws_iam_role" "eks_nodes" {
  name = "eks-node-group"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Attaching the different Policies to Node Members.

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}

# Create EKS cluster node group

resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "node_group1"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = [var.private1_subnet_id,var.private2_subnet_id]

  scaling_config {
    desired_size = 4
    max_size     = 4
    min_size     = 2
  }
  # launch_template {
  #   name = "ec2_eks"
  #   version = "$Latest"
  # }
  instance_types = ["t2.micro"]
  
  remote_access {
    ec2_ssh_key = var.key_name
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
