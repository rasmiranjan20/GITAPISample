Basic Information:
_________________________________
GITAPISample is a sample project for which provides Github repositories list.
1. Users need to provide the platform companyName Parameters to fetch the Repository list.
    Example: platform = ios, companyName = someorganisation.
2. This library can be used both in ObjectiveC and Swift Application.    
    
API Information:
_________________________________
1. GitHubService is the class accessible from hosting application
2. Call `GitHubService getRepoList` method and provide the platform and company name parameters.
    
Architecture:
_________________________________
1. We use SOLID principles to develops the libraries.  

Technical Information:
_________________________________
Xcode 14 Required for run this project.
Application developed in Swift 5.
Application deployment target is 14.0
Update the pod before run the project(Open project location in terminal run 'pod update' in terminal).
