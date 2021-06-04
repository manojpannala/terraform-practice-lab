resource "aws_iam_user" "adminuser1" {
    name = "adminuser1"
}

resource "aws_iam_user" "adminuser2" {
    name = "adminuser2"
}

resource "aws_iam_group" "admingroup" {
    name = "admingroup"
}

resource "aws_iam_group_membership" "admin-users" {
    name = "admin-users"
    users = [ 
        aws_iam_user.adminuser1.name,
        aws_iam_user.adminuser2.name
     ]
     group = aws_iam_group.admingroup.name
}

# Policy for AWS Group
resource "aws_iam_group_policy_attachment" "admin-users-attach" {
    # name = "admin-users-attach"
    group = aws_iam_group.admingroup.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  
}