/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

ax_region = "us-east1"

apigee_instances = {
  useast1-instance = {
    region       = "us-east1"
    ip_range     = "10.0.0.0/22"
    environments = ["test", "dev"]
  }
}

apigee_environments = {
  test = {
    display_name = "Test"
    description  = "Environment created by apigee/terraform-modules"
    node_config  = {
        min_node_count = 2
        max_node_count = 2
    }
    iam          = null
    envgroups    = ["test"]
  }
  dev = {
    display_name = "Dev"
    description  = "Environment created by apigee/terraform-modules"
        node_config  = {
        min_node_count = 2
        max_node_count = 2
    }
    iam          = null
    envgroups    = ["dev"]
  }
}

apigee_envgroups = {
  test = {
    hostnames = [""]
  }
    dev = {
    hostnames = [""]
  }
}

network = "default"

psc_ingress_network = "default"

psc_ingress_subnets = [
  {
    name               = "apigee-psc"
    ip_cidr_range      = "10.100.0.0/24"
    region             = "us-east1"
    secondary_ip_range = null
  }
]

peering_range = "10.0.0.0/22"
support_range = "10.1.0.0/28"
