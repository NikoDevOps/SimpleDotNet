# ===== Build stage =====
FROM mcr.microsoft.com/dotnet/sdk:9.0-alpine AS build
WORKDIR /src

COPY src/HelloEnv/HelloEnv.csproj src/HelloEnv/
RUN dotnet restore src/HelloEnv/HelloEnv.csproj

COPY . .
RUN dotnet publish src/HelloEnv/HelloEnv.csproj \
    -c Release \
    -o /app/publish \
    -p:SelfContained=false \
    -p:UseAppHost=false \
    -p:PublishTrimmed=true \
    -p:InvariantGlobalization=true \
    -p:PublishReadyToRun=true

# ===== Runtime stage =====
FROM mcr.microsoft.com/dotnet/aspnet:9.0-alpine AS runtime
ENV ASPNETCORE_URLS=http://+:8080 \
    DOTNET_RUNNING_IN_CONTAINER=true

RUN adduser -D appuser && mkdir -p /app && chown -R appuser /app
USER appuser
WORKDIR /app

COPY --from=build /app/publish/ ./

EXPOSE 8080
ENTRYPOINT ["dotnet", "HelloEnv.dll"]