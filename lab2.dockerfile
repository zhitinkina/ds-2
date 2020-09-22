FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY src/lab2/*.csproj .
COPY src/Protos/. ../Protos/
RUN dotnet restore

# copy everything else and build app
COPY src/lab2/. .
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "lab2.dll"]