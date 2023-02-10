resource "azuread_user" "david" {
  user_principal_name = "david@email.com"
  display_name        = "David"
  password            = "david.password"
}

resource "azuread_user" "ibrahim" {
  user_principal_name = "ibrahim@email.com"
  display_name        = "Ibrahim"
  password            = "ibrahim.password"
  force_password_change = true
}


resource "aws_iam_user" "four-users" {
    for_each = toset(var.users)
    name = each.value
}
