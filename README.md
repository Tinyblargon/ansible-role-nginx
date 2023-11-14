# Ansible Role: nginx

Install and configure nginx.

This solution addresses the circular dependency problem between nginx and Letsencrypt's Certbot. If certificate files are missing, the system substitutes them with `nginx_default_cert:` and `nginx_default_key:` in the nginx configuration. Once the actual certificates are installed on the system, re-running this role will direct nginx to use these new certificates, replacing the temporary ones.

To safeguard your nginx configuration, a backup is created before any changes are made. If the nginx configuration test fails, the system will restore the configuration from the backup.

## Requirements

N/A

## Role Variables

### Defaults

| **Variable Name**   | **Type**| **Default Value**                       | **Description**|
| :-------------------| :------:| :--------------------------------------:| :--------------|
| nginx_vhosts:       | list map| []                                      | List of vhosts, see:[Nginx_vhosts](#nginx_vhosts).|
| nginx_vhosts_remove:| bool    | false                                   | When `true` all vhosts that are not in `nginx_vhosts:` will be removed.|
| nginx_state:        | string  | "present"                               | When `"present"` nginx will be installed and configured, when `"absent"` nginx will be removed.|
| nginx_backup:       | bool    | true                                    | When `true` the nginx config will be backed up prior to modification and restored when a config error is detected.|
| nginx_backup_file:  | string  | "/etc/nginx.backup/nginx.tar.gz"        | Location of the nginx backup archive.|
| nginx_default_cert: | string  | "/etc/ssl/certs/ssl-cert-snakeoil.pem"  | The path to the default cert file. When `ssl_certificate` has a nonexistent file configured it will be substituted for this cert.|
| nginx_default_key:  | string  | "/etc/ssl/private/ssl-cert-snakeoil.key"| The path to the default key file. When `ssl_certificate_key` has a nonexistent file configured it will be substituted for this key.|

### Nginx_vhosts

| **Variable Name**| **Required**| **Type**| **Default Value**| **Description**|
| :----------------| :----------:| :------:| :---------------:| :--------------|
| name:            | yes         | string  | ""               | This is the name of the vhost/config file and should be unique.|
| content:         | no          | string  | ""               | Normal nginx config is expected here and can be obtained with a file lookup.|
| enabled:         | no          | bool    | true             | If the vhost should be enabled or not.|
| state:           | no          | string  | "present"        | When `"present"` the vhost will be created, when `"absent"` the vhost will be removed.|

**Note:** `Content:` is only optional when `state:` is `"absent"`

## Dependencies

N/A

## Example Playbook

```yaml
- hosts: all
  roles:
    - role: Tinyblargon.nginx
      vars:
        nginx_vhosts:
          - name: "site-1"
            content: "{{ lookup('file', 'sites/site-1.nginx.conf') }}"
          - name: "site-2"
            content: "{{ lookup('file', 'sites/site-2.nginx.conf') }}"
            enabled: false
          - name: "default"
            state: "absent"
        nginx_vhosts_remove: true
        nginx_state: "present"
```

## License

MIT
