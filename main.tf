

# data "aws_codecommit_repository" "nodeapp_repo" {
#   repository_name = var.nodejs_project_repository_name
# }
# data "aws_codecommit_repository" "pythonapp_repo" {
#   repository_name = var.python_project_repository_name
# }
# data "aws_codecommit_repository" "goapp_repo" {
#   repository_name = var.golang_project_repository_name
# }


# resource "aws_s3_bucket" "cicd_bucket" {
#   bucket = var.artifacts_bucket_name 
 
# }

###################
# GitHub Connection
###################

resource "aws_codestarconnections_connection" "ab2d-github-connection" {
  name          = "GITHUB-connection"
  provider_type = "GitHub"

}
##################
# PipeLine-Modules
##################
 
module "codepipeline-aggregator-service" {
  source = "./modules/codepipeline-aggregator-service"
  aws_region = var.aws_region
  service_name = "aggregator"
  env = var.env
  aws_account_number = var.aws_account_number
  aws_ecs_cluster_name = var.aws_ecs_cluster_name
  artifacts_bucket_name = var.artifacts_bucket_name
  role_arn =  aws_iam_role.apps_codepipeline_role.arn
  ProjectName = aws_codebuild_project.containerAppBuild.name
  ConnectionArn = aws_codestarconnections_connection.ab2d-github-connection.arn
}

# Pipeline-2
module "codepipeline-api-service" {
  source = "./modules/codepipeline-aggregator-service"
  aws_region = var.aws_region
  service_name = "api"
  env = var.env
  aws_account_number = var.aws_account_number
  aws_ecs_cluster_name = var.aws_ecs_cluster_name
  artifacts_bucket_name = var.artifacts_bucket_name
  role_arn =  aws_iam_role.apps_codepipeline_role.arn
  ProjectName = aws_codebuild_project.containerAppBuild.name
  ConnectionArn = aws_codestarconnections_connection.ab2d-github-connection.arn
}

# Pipeline-3
module "codepipeline-audit-service" {
  source = "./modules/codepipeline-aggregator-service"
  aws_region = var.aws_region
  env = var.env
  service_name = "audit"
  aws_account_number = var.aws_account_number
  
  aws_ecs_cluster_name = var.aws_ecs_cluster_name
  artifacts_bucket_name = var.artifacts_bucket_name
  role_arn =  aws_iam_role.apps_codepipeline_role.arn
  ProjectName = aws_codebuild_project.containerAppBuild.name
  ConnectionArn = aws_codestarconnections_connection.ab2d-github-connection.arn
}

# Pipeline-4
module "codepipeline-contract-service" {
  source = "./modules/codepipeline-aggregator-service"
  aws_region = var.aws_region
  env = var.env
  service_name = "contract"
  aws_account_number = var.aws_account_number
  aws_ecs_cluster_name = var.aws_ecs_cluster_name
  artifacts_bucket_name = var.artifacts_bucket_name
  role_arn =  aws_iam_role.apps_codepipeline_role.arn
  ProjectName = aws_codebuild_project.containerAppBuild.name
  ConnectionArn = aws_codestarconnections_connection.ab2d-github-connection.arn
}

# Pipeline-5
module "codepipeline-coverage-service" {
  source = "./modules/codepipeline-aggregator-service"
  aws_region = var.aws_region
  env = var.env
  service_name = "coverage"
  aws_account_number = var.aws_account_number
  aws_ecs_cluster_name = var.aws_ecs_cluster_name
  artifacts_bucket_name = var.artifacts_bucket_name
  role_arn =  aws_iam_role.apps_codepipeline_role.arn
  ProjectName = aws_codebuild_project.containerAppBuild.name
  ConnectionArn = aws_codestarconnections_connection.ab2d-github-connection.arn
}

# Pipeline-6
module "codepipeline-eob-fetcher-service" {
  source = "./modules/codepipeline-aggregator-service"
  aws_region = var.aws_region
  env = var.env
  service_name = "eob-fetcher"
  aws_account_number = var.aws_account_number
  aws_ecs_cluster_name = var.aws_ecs_cluster_name
  artifacts_bucket_name = var.artifacts_bucket_name
  role_arn =  aws_iam_role.apps_codepipeline_role.arn
  ProjectName = aws_codebuild_project.containerAppBuild.name
  ConnectionArn = aws_codestarconnections_connection.ab2d-github-connection.arn
}

# Pipeline-7
module "codepipeline-events-service" {
  source = "./modules/codepipeline-aggregator-service"
  aws_region = var.aws_region
  env = var.env
  service_name = "events"
  aws_account_number = var.aws_account_number
  aws_ecs_cluster_name = var.aws_ecs_cluster_name
  artifacts_bucket_name = var.artifacts_bucket_name
  role_arn =  aws_iam_role.apps_codepipeline_role.arn
  ProjectName = aws_codebuild_project.containerAppBuild.name
  ConnectionArn = aws_codestarconnections_connection.ab2d-github-connection.arn
}

# Pipeline-8
module "codepipeline-jobs-service" {
  source = "./modules/codepipeline-aggregator-service"
  aws_region = var.aws_region
  env = var.env
  service_name = "jobs"
  aws_account_number = var.aws_account_number
  aws_ecs_cluster_name = var.aws_ecs_cluster_name
  artifacts_bucket_name = var.artifacts_bucket_name
  role_arn =  aws_iam_role.apps_codepipeline_role.arn
  ProjectName = aws_codebuild_project.containerAppBuild.name
  ConnectionArn = aws_codestarconnections_connection.ab2d-github-connection.arn
}

# Pipeline-9
module "codepipeline-parameter-service" {
  source = "./modules/codepipeline-aggregator-service"
  aws_region = var.aws_region
  env = var.env
  service_name = "parameter"
  aws_account_number = var.aws_account_number
  aws_ecs_cluster_name = var.aws_ecs_cluster_name
  artifacts_bucket_name = var.artifacts_bucket_name
  role_arn =  aws_iam_role.apps_codepipeline_role.arn
  ProjectName = aws_codebuild_project.containerAppBuild.name
  ConnectionArn = aws_codestarconnections_connection.ab2d-github-connection.arn
}