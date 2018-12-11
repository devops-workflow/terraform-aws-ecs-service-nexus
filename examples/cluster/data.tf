data "aws_vpc" "vpc" {
  tags {
    Environment = "${var.environment}"
  }
}

data "aws_subnet_ids" "private_subnet_ids" {
  vpc_id = "${data.aws_vpc.vpc.id}"

  tags {
    Network = "private"
  }
}

data "aws_subnet" "private_subnets" {
  count = "${length(data.aws_subnet_ids.private_subnet_ids.ids)}"
  id    = "${data.aws_subnet_ids.private_subnet_ids.ids[count.index]}"
}

data "aws_subnet_ids" "public_subnet_ids" {
  vpc_id = "${data.aws_vpc.vpc.id}"

  tags {
    Network = "public"
  }
}

data "aws_subnet" "public_subnets" {
  count = "${length(data.aws_subnet_ids.public_subnet_ids.ids)}"
  id    = "${data.aws_subnet_ids.public_subnet_ids.ids[count.index]}"
}
