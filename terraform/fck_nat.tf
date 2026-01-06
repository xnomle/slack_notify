module "fck-nat" {
  source = "git::https://github.com/RaJiska/terraform-aws-fck-nat.git"

  name      = "fck-nat"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]
  # ha_mode              = true                 # Enables high-availability mode
  # eip_allocation_ids   = ["eipalloc-abc1234"] # Allocation ID of an existing EIP
  # use_cloudwatch_agent = true                 # Enables Cloudwatch agent and have metrics reported

  update_route_tables = true
  route_tables_ids = {
    "your-rtb-name-A" = module.vpc.private_route_table_ids[0]
    "your-rtb-name-B" = module.vpc.private_route_table_ids[1]
  }
}