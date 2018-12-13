import "tfplan"

# Get all AWS instances from all modules
get_aws_instances = func() {
    instances = []
    for tfplan.module_paths as path {
        instances += values(tfplan.module(path).resources.aws_instance) else []
    }
    return instances
}

# Allowed Types
allowed_types = [
  "t2.small",
  "t2.medium",
  "t2.large",
]

aws_instances = get_aws_instances()

# Rule to restrict instance types
instance_type_allowed = rule {
    all aws_instances as _, instances {
      all instances as index, r {
  	   r.applied.instance_type in allowed_types
      }
    }
}
  
# Main rule that requires other rules to be true
main = rule {
  (instance_type_allowed) else true
}