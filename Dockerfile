FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src
COPY BooksApi/BooksApi.csproj BooksApi/
RUN dotnet restore BooksApi/BooksApi.csproj
COPY BooksApi/ BooksApi/
RUN dotnet publish BooksApi/BooksApi.csproj -c Release -o /app/publish --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "BooksApi.dll"]
