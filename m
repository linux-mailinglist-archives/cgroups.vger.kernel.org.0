Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E066E3716CD
	for <lists+cgroups@lfdr.de>; Mon,  3 May 2021 16:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhECOlV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 May 2021 10:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229644AbhECOlU (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 3 May 2021 10:41:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F485611C0;
        Mon,  3 May 2021 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620052827;
        bh=5WPHlxGERL6nx/ZbX9Mn9/GhtNDaAzH+K5mPN/ZrKbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNc38QL8HygHvyQGOB0WIBLQD6t1PIRfua7AJVGIFCeZMoqmeXjjHEz5brlg6zWGG
         JACfyR7stMpSEqVO928z2Lt8jIKl22K0EDr18U/wyVpsxhH/+aP3/Sauvza3GEzuTQ
         DjH7F/hnK9lvNsotP5M4uul8S3wM86pEYgH4uEO+1eXY19AVTDmxBECHsnUmhooOa2
         pRLDL1vUHcJZxxTAlfpKYo23MhWvkr4UR4FckY7YuTkPfHCcYkTlTTHwP33pq61A84
         Pb6lDBXGk9RUKKNP0ojx3Ytvx3SuU+6G+uVEZ+7H6HDLujReesmrsfBJSZPOUJEGDf
         ROaXnMABG2Jhg==
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 4/5] tests/cgroup: move cg_wait_for(), cg_prepare_for_wait()
Date:   Mon,  3 May 2021 16:39:22 +0200
Message-Id: <20210503143922.3093755-4-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210503143922.3093755-1-brauner@kernel.org>
References: <20210503143922.3093755-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=fA5wUlruY1z6kLoAHjGw3GW/sZkemshRip3ZaZh18WQ=; m=rsZ54vKx4HFzWMH3x2J3U2tYIos8Cpxx5XjQYMQh0oY=; p=6e/rmx93t75ZI9V2hWm2MswTGLxPQa6pArMTPJtQB0Q=; g=3329f29847a596dcba3a622b669675e5f574fafc
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYJAK7wAKCRCRxhvAZXjcogcXAQD/mbu B2Jq68v4LpIoLr+kCZd628RdJk0m4wy1+vXHj8AD+IZvjQ/4i+alnCUaWOgsUkuWW02Ye3Z7eXkQC NrUo2w4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

as they will be used by the tests for cgroup killing.

Cc: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 tools/testing/selftests/cgroup/cgroup_util.c  | 47 +++++++++++++++
 tools/testing/selftests/cgroup/cgroup_util.h  |  2 +
 tools/testing/selftests/cgroup/test_freezer.c | 57 -------------------
 3 files changed, 49 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index f60f7d764690..623cec04ad42 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -5,10 +5,12 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/limits.h>
+#include <poll.h>
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/inotify.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -580,3 +582,48 @@ int clone_into_cgroup_run_wait(const char *cgroup)
 	(void)clone_reap(pid, WEXITED);
 	return 0;
 }
+
+int cg_prepare_for_wait(const char *cgroup)
+{
+	int fd, ret = -1;
+
+	fd = inotify_init1(0);
+	if (fd == -1)
+		return fd;
+
+	ret = inotify_add_watch(fd, cg_control(cgroup, "cgroup.events"),
+				IN_MODIFY);
+	if (ret == -1) {
+		close(fd);
+		fd = -1;
+	}
+
+	return fd;
+}
+
+int cg_wait_for(int fd)
+{
+	int ret = -1;
+	struct pollfd fds = {
+		.fd = fd,
+		.events = POLLIN,
+	};
+
+	while (true) {
+		ret = poll(&fds, 1, 10000);
+
+		if (ret == -1) {
+			if (errno == EINTR)
+				continue;
+
+			break;
+		}
+
+		if (ret > 0 && fds.revents & POLLIN) {
+			ret = 0;
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 5a1305dd1f0b..82e59cdf16e7 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -54,3 +54,5 @@ extern pid_t clone_into_cgroup(int cgroup_fd);
 extern int clone_reap(pid_t pid, int options);
 extern int clone_into_cgroup_run_wait(const char *cgroup);
 extern int dirfd_open_opath(const char *dir);
+extern int cg_prepare_for_wait(const char *cgroup);
+extern int cg_wait_for(int fd);
diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
index 23d8fa4a3e4e..ff519029f6f4 100644
--- a/tools/testing/selftests/cgroup/test_freezer.c
+++ b/tools/testing/selftests/cgroup/test_freezer.c
@@ -7,9 +7,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <errno.h>
-#include <poll.h>
 #include <stdlib.h>
-#include <sys/inotify.h>
 #include <string.h>
 #include <sys/wait.h>
 
@@ -54,61 +52,6 @@ static int cg_freeze_nowait(const char *cgroup, bool freeze)
 	return cg_write(cgroup, "cgroup.freeze", freeze ? "1" : "0");
 }
 
-/*
- * Prepare for waiting on cgroup.events file.
- */
-static int cg_prepare_for_wait(const char *cgroup)
-{
-	int fd, ret = -1;
-
-	fd = inotify_init1(0);
-	if (fd == -1) {
-		debug("Error: inotify_init1() failed\n");
-		return fd;
-	}
-
-	ret = inotify_add_watch(fd, cg_control(cgroup, "cgroup.events"),
-				IN_MODIFY);
-	if (ret == -1) {
-		debug("Error: inotify_add_watch() failed\n");
-		close(fd);
-		fd = -1;
-	}
-
-	return fd;
-}
-
-/*
- * Wait for an event. If there are no events for 10 seconds,
- * treat this an error.
- */
-static int cg_wait_for(int fd)
-{
-	int ret = -1;
-	struct pollfd fds = {
-		.fd = fd,
-		.events = POLLIN,
-	};
-
-	while (true) {
-		ret = poll(&fds, 1, 10000);
-
-		if (ret == -1) {
-			if (errno == EINTR)
-				continue;
-			debug("Error: poll() failed\n");
-			break;
-		}
-
-		if (ret > 0 && fds.revents & POLLIN) {
-			ret = 0;
-			break;
-		}
-	}
-
-	return ret;
-}
-
 /*
  * Attach a task to the given cgroup and wait for a cgroup frozen event.
  * All transient events (e.g. populated) are ignored.
-- 
2.27.0

