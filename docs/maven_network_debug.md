# Troubleshooting Maven Dependency Resolution

When Maven cannot download dependencies, the issue is usually network related. Maven Central is normally reachable at the following canonical URLs:

| What you need | Copy-paste URL |
|---------------|---------------|
| Maven Central root &mdash; the repo every `pom.xml` calls `central` | https://repo.maven.apache.org/maven2/ |
| Same repo, old alias that some firewalls still whitelist | https://repo1.maven.org/maven2/ |
| `maven-resources-plugin` `3.3.1` POM | https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-resources-plugin/3.3.1/maven-resources-plugin-3.3.1.pom |
| `maven-resources-plugin` `3.3.1` JAR | https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-resources-plugin/3.3.1/maven-resources-plugin-3.3.1.jar |

To verify connectivity you can run a quick sanity check:

```bash
curl -I https://repo.maven.apache.org/maven2/org/apache/maven/plugins/maven-resources-plugin/3.3.1/maven-resources-plugin-3.3.1.jar
```

You should see `HTTP/1.1 200 OK` without redirects. If that response never arrives, your network, proxy or DNS settings are blocking outbound HTTPS to Maven Central.

