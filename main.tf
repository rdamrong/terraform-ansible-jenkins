terraform {
  required_providers {
    ansible = {
      version = "~> 1.1.0"
      source  = "ansible/ansible"
    }
  }
}

resource "ansible_playbook" "playbook" {
  playbook   = "test.yaml"
  name       = "localhost"
}

output "result" {
 value = ansible_playbook.playbook.ansible_playbook_stdout
}
