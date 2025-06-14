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

## Common fixes

If you do run into a *network is unreachable* or similar error when Maven tries
to talk to Central, here are some known solutions:

1. **Try an alternate mirror.** You can temporarily point the `central`
   repository to the legacy domain `https://repo1.maven.org/maven2/` or to the
   Google-hosted mirror at
   `https://maven-central.storage-download.googleapis.com/maven2`. Add a
   `<mirror>` section in your `~/.m2/settings.xml` to override the default.
2. **Check DNS resolution.** Verify that `repo.maven.apache.org` resolves using
   `nslookup` or `dig`. Switching to a public resolver like `8.8.8.8` or
   `1.1.1.1` can clear up bad cached entries.
3. **Force IPv4 if IPv6 is broken.** Maven may attempt IPv6 first, which can
   fail with `Network is unreachable` if your ISP does not provide IPv6. Run
   Maven with `-Djava.net.preferIPv4Stack=true` or disable IPv6 system-wide.
4. **Validate proxy settings.** A stale or empty proxy configuration in
   `settings.xml` can block all outbound connections. Remove proxy entries if
   your network does not require them.

These steps resolve the majority of reported connectivity issues.


