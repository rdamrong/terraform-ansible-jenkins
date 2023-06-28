terraform {
  required_providers {
    ansible = {
      version = "~> 1.1.0"
      source  = "ansible/ansible"
    }
  }
}
variable vm_name {}
resource "ansible_playbook" "playbook" {
  playbook   = "test.yaml"
  name       = "localhost"
  extra_vars = {
    vm_name = var.vm_name
  }
}

output "result" {
 value = ansible_playbook.playbook.ansible_playbook_stdout
}
