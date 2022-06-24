# Terraform Learning



## Notes and good-to-know

### Other important commands:
- `taint`: marks a resource as having been manually changed/"tampered with". When the `apply` runs, the resource will be deleted and recreated
- `graph`: provides a visual representation of your architecture
- `plan`
- - `out <path>`: Saves the terraform plan to a seperate file that can be applied (e.g. `terraform apply <path>'`) later
- - `target <resourse>`: Specify that the `plan` only gets applied to a specific resource