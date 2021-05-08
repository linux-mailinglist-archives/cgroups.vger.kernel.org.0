Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE39437719A
	for <lists+cgroups@lfdr.de>; Sat,  8 May 2021 14:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhEHMRB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 8 May 2021 08:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230419AbhEHMRA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 8 May 2021 08:17:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D24EE61414;
        Sat,  8 May 2021 12:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620476159;
        bh=ewXB/kCFJJzEpgo9t/nzH5vqXTyZ4CIRgG/ZRGqNWeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uwav4gAtXeuz4SxWwLjIcXbQnGItJ+8+OWpcYbGtv0WBj29YrbeY5LkMgu5we6JkV
         M/lZKs0W5UUBA5wbjx+1qpEBgW6EoPyChYSIgrlG/axVNdfn9kKtbra5kYn4DkQuGL
         1S/EWg3mCy0VunN29EKOw4z8R7fQY4DGzUjfSNwboigTTcU+rufCUU3nEWrVIDM8sq
         v0pzZP0LGn/g0/jwMty+/3Ux+U3FPw1pGQjge51S0fVm5+wVBDoGGNJDmO15/mSpAc
         0End07hsaWH5nzEyDQ0m9HrKzmBIyLCXFKYVbGAvAcRMmInNBLMdWH9ZofnTIRxomG
         ATiTduCbTGI6Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 4/5] tests/cgroup: move cg_wait_for(), cg_prepare_for_wait()
Date:   Sat,  8 May 2021 14:15:41 +0200
Message-Id: <20210508121542.1269256-4-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210508121542.1269256-1-brauner@kernel.org>
References: <20210508121542.1269256-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=fA5wUlruY1z6kLoAHjGw3GW/sZkemshRip3ZaZh18WQ=; m=Qys/VL+CLw3Y8vE+UpfrF+dKFeGyJRsEq9xLQICMmWY=; p=6e/rmx93t75ZI9V2hWm2MswTGLxPQa6pArMTPJtQB0Q=; g=3329f29847a596dcba3a622b669675e5f574fafc
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYJaA0AAKCRCRxhvAZXjcoqqEAP9bhxx 2awwn2AY6cV6TIxa0hbAbcjvAEWf8hsb6aywiEwD8D2VZMDbU9xhzjsmbpNzXZeDGWfDA+r3gz7fC 8uaI2Aw=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

as they will be used by the tests for cgroup killing.

Link: https://lore.kernel.org/r/20210503143922.3093755-4-brauner@kernel.org
Cc: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
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

