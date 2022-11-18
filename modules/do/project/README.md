# Digital Ocean Project.

Provides a DigitalOcean Project resource. Projects allow you to organize your resources into groups that fit the way you work. You can group resources (like Droplets, Spaces, Load Balancers, domains, and Floating IPs) in ways that align with the applications you host on DigitalOcean.

## Variables.

- `name` (required): Name of the project 
- `description` (optional): A description for the project
- `purpose` (optional, default: Web Application): Purpose of the project. 
- `environment` (required): Environment asociated to the project.
_ `is_default` (optional, default: false): Sets the project as default. One project has to be the default project.

The `purpose` variable can be set to any string-based value, but DigitalOcean provide some prebuilt values (Just trying out DigitalOcean, Class project / Educational purposes, Website or blog, Web Application, Service or API, Mobile Application, Machine learning / AI / Data processing, IoT, Operational / Developer tooling, Other), if it doesn't fit any of them, Other will be selected with an additional string value in accordance with the value passed. 

The `environment` variable value has to be one of the following: Development, Staging or Production. Otherwise an error will raise and the resource will no be created in the cloud.

## Outputs.

- `id`: The ID of the project.
- `owner_uuid`: The UUID of the user owner of the project.
- `owner_id`: The UUID of the user owner of the project.
- `created_at`: The date and time when the project was created.
- `updated_at`: The date and time when the project was last updated.
_ `is_default`: A boolean value that shows the project is marked as default. Resources without associated project are created in the default project.
- `resources`: A list of the resources associated to the project.

## Usage.

````
module "project" {
    source = <SOURCE_TO_MODULE>
    name = "Test project"
    environment = "Development"
}
````


## References
- Terraform registry: https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project
