---
layout: default
title: 3.6 Jenkins Integration
parent: 3. Hauptteil
nav_order: 306
---

# 3.6 Jenkins Integration
Um die erstellte Methode in einer Jenkins Pipeline zu integrieren, werde ich das bereits bestehende Jenkinsfile anpassen.
Das bestehende Jenkinsfile ist aus meiner Firma exportiert und wird momentan aktiv genutzt.

[Quelle Vorarbeit - Jenkinsfile](../anhang/quellen.html#531-jenkinsfile-bash-scripts--makefile)

[Prework Ordner](https://github.com/Euthal02/SemArb2-DrawioToJPGPipeline/blob/main/prework/Jenkinsfile)

Um dies umzusetzen, bietet sich diese bereits erstellte Stage im Jenkinsfile an.

```bash
stage('Build') {
    steps {
        sh './build.sh'
    }
}
```

In dieser Stage wird ein einfaches Build Script aufgerufen. Ich kann dieses Build Script mit dem Command erweitern, welchen ich genutzt habe, um im ersten Sprint die Files zu konvertieren. 
Ich werde dieses Skript erweitern und dies dokumentieren.