resource "aws_instance" "public-server" {
  ami           = "ami-0b0dcb5067f052a63" 
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids  = [aws_security_group.allow_web.id]
  subnet_id = aws_subnet.public_subnet.id
  key_name = "sugar-test"

}
resource "aws_instance" "public-server2" {
  ami           = "ami-0b0dcb5067f052a63" 
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids  = [aws_security_group.allow_web.id]
  subnet_id = aws_subnet.public_subnet.id
  key_name = "sugar-test"
  
}
resource "aws_instance" "private-server" {
  ami           = "ami-0b0dcb5067f052a63" 
  instance_type = "t2.micro"
  associate_public_ip_address = false
  vpc_security_group_ids  = [aws_security_group.allow_web.id]
  subnet_id = aws_subnet.private_subnet.id
  key_name = "sugar-test"

}
resource "aws_instance" "private-server2" {
  ami           = "ami-0b0dcb5067f052a63" 
  instance_type = "t2.micro"
  associate_public_ip_address = false
  vpc_security_group_ids  = [aws_security_group.allow_web.id]
  subnet_id = aws_subnet.private_subnet.id
  key_name = "sugar-test"
  
}