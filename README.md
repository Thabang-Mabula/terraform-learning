# Terraform Learning



## Notes and good-to-know
### Other resources:
- `null_resource`: A resource that really doesn't act on anything. It's mostly used for doing misc. local and remote execs 
- - `trigger`: This argument allows you to run code every time there's a change in some or other string. It does this by replacing the `null_resource`
### Other important commands:
- `taint`: marks a resource as having been manually changed/"tampered with". When the `apply` runs, the resource will be deleted and recreated
- `graph`: provides a visual representation of your architecture
- `plan`
- - `out <path>`: Saves the terraform plan to a seperate file that can be applied (e.g. `terraform apply <path>'`) later
- - `target <resourse>`: Specify that the `plan` only gets applied to a specific resource