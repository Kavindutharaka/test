FROM tomcat:9.0-jdk17

# Create a group with a specific GID within the recommended range
RUN groupadd -g 10010 choreo

# Create a user with a specific UID within the recommended range and add them to the group
RUN useradd --no-create-home --uid 10011 -g choreo choreo

# Set environment variables
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Copy the .war file into the webapps directory
COPY target/oidc-sample-app.war $CATALINA_HOME/webapps/oidc-sample-app.war

# Change ownership of Tomcat files to the new user
RUN chown -R choreo:choreo $CATALINA_HOME

# Switch to the non-root user
USER choreo

# Expose the port on which Tomcat will run
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
