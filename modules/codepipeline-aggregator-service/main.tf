#################################################
############### Aggregator Service ##############
#################################################

resource "aws_codepipeline" "aggregator_service_pipeline" {
  #name     = "${var.env}-aggregator-service"
  name     = "${var.env}-${var.service_name}-service"
  role_arn = var.role_arn
  tags = {
    Environment = var.env
  }

  artifact_store {
    location = var.artifacts_bucket_name
    type     = "S3"
  }

  stage {
    name = "Source"


     action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact"]
      
      configuration = {
        ConnectionArn    = var.ConnectionArn
        FullRepositoryId = "sb-ebukaanene/Python-Service-2"
        #Owner                = "AB2D"
        #PollForSourceChanges = "false"
        #Repo                 = "Python-Service-2"
        BranchName               = "main"
        #OAuthToken           = data.aws_ssm_parameter.oauth.value
      }
    }
  }
  stage {
    name = "Build"

    action {
      category = "Build"
      configuration = {
        "EnvironmentVariables" = jsonencode(
          [
            {
              name  = "environment"
              type  = "PLAINTEXT"
              value = var.env
            },
            {
              name  = "AWS_DEFAULT_REGION"
              type  = "PLAINTEXT"
              value = var.aws_region
            },
            {
              name  = "AWS_ACCOUNT_ID"
              type  = "PARAMETER_STORE"
              value = var.aws_account_number
            },
            {
              name  = "IMAGE_REPO_NAME"
              type  = "PLAINTEXT"
              value = "${var.env}-services"
            },
            {
              name  = "IMAGE_TAG"
              type  = "PLAINTEXT"
              value = "aggregator-service"
            },
            {
              name  = "CONTAINER_NAME"
              type  = "PLAINTEXT"
              value = "aggregator-service-container"
            },
          ]
        )
        "ProjectName" = var.ProjectName
      }
      input_artifacts = [
        "SourceArtifact"
      ]
      name = "Build"
      output_artifacts = [
        "BuildArtifact"
      ]
      owner     = "AWS"
      provider  = "CodeBuild"
      run_order = 1
      version   = "1"
    }
  }
  stage {
    name = "Deploy"

    action {
      category = "Deploy"
      configuration = {
        "ClusterName" = var.aws_ecs_cluster_name
        "ServiceName" = "ab2d-aggregator-service"
        "FileName"    = "imagedefinitions.json"
        #"DeploymentTimeout" = "15"
      }
      input_artifacts = [
        "BuildArtifact"
      ]
      name             = "Deploy"
      output_artifacts = []
      owner            = "AWS"
      provider         = "ECS"
      run_order        = 1
      version          = "1"
    }
  }
}

