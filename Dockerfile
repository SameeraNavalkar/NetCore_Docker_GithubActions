#This first image will be created to build the .Net application using sdk
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /source
COPY . .
RUN dotnet publish -c release -o /app

#This second image will used to run the application in container during production, hence we are getting the runtime asp.net 7
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "MyWebApp.dll"]
