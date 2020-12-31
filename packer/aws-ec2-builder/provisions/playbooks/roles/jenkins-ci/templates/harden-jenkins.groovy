#!groovy

import jenkins.model.Jenkins
import jenkins.security.s2m.*
import hudson.security.csrf.DefaultCrumbIssuer

Jenkins jenkins = Jenkins.getInstance()

jenkins.setCrumbIssuer(new DefaultCrumbIssuer(true))

// Disable CLI remote
jenkins.getDescriptor("jenkins.CLI").get().setEnabled(false)

jenkins.injector.getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false);

// Disable old Non-Encrypted protocols
HashSet<String> newProtocols = new HashSet<>(jenkins.getAgentProtocols());
newProtocols.removeAll(Arrays.asList("JNLP2-connect", "JNLP-connect"));
jenkins.setAgentProtocols(newProtocols);
jenkins.save()