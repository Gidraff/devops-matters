#!groovy

import jenkins.model.*
import hudson.security.*

def env = System.getenv()

def instance = Jenkins.getInstance()
def hudsonRealm = new HudsonPrivateSecurityRealm(false)

hudsonRealm.createAccount(env.JENKINS_USER, env.JENKINS_PASS)
instance.setSecurityRealm(hudsonRealm)


def strategy = new GlobalMatrixAuthorizationStrategy()
strategy.add(Jenkins.ADMINISTER, env.JENKINS_USER)
instance.setAuthorizationStrategy(strategy)

instance.save()