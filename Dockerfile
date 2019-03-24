FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /code

COPY *.sln .

#copy project files
COPY FeedService.Api/*.csproj ./FeedService.Api/

#restore
RUN dotnet restore

#copy all other files
COPY FeedService.Api/. ./FeedService.Api/

#create publish artifact
WORKDIR /code/FeedService.Api
RUN dotnet publish -c Release -o out

#prepare runtime
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS runtime
WORKDIR /app
COPY --from=build /code/FeedService.Api/out ./

EXPOSE 80
ENTRYPOINT [ "dotnet", "FeedService.Api.dll" ]