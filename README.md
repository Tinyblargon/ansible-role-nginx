# Ansible Role: nginx

Install and configure nginx

## Requirements

N/A

## Role Variables

### Defaults

| **Variable Name**| **Type**| **Default Value**| **Description**|
| :----------------| :------:| :---------------:| :--------------|
| nginx_state:     | string  | "present"        | When `"present"` nginx will be installed and configured, when `"absent"` nginx will be removed.|

## Dependencies

N/A

## Example Playbook

```yaml
- hosts: all
  roles:
    - role: Tinyblargon.nginx
      vars:
        nginx_state: "present"
```

## License

MIT
