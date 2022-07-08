data "template_file" "inventory" {
  template = "${file("${path.module}/templates/hosts.tpl")}"
  vars = {
    ip =  "${join("\n", [for i in aws_instance.ec2 :  i.public_ip ])}" 
  }
}

resource "local_file" "save_inventory" {
  content  = "${data.template_file.inventory.rendered}"
  filename = "./inventory"
}
