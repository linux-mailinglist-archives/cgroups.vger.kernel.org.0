Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E8B36E9EC
	for <lists+cgroups@lfdr.de>; Thu, 29 Apr 2021 14:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhD2MCk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Apr 2021 08:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:46898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233922AbhD2MCj (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 29 Apr 2021 08:02:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C1F161418;
        Thu, 29 Apr 2021 12:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619697713;
        bh=rNYXiueStnMgi44cbI2dYKBwftygGCisRPGvQ9Zjv4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E/iuQWpjUfQgpvzTtXasGYeN+WfEAqYpcdptDk9GCXF0udWYOCZ5N06pgAOtbV7l7
         /akQNkZASYMMlqWvxYU5bMqzuDadzC6usAbovBezYw9ln9HZvJmVD+vU+m4LCiaE2T
         ePEActYgaUAFYsQKpg8S0RGfwFvd3zvt5LbCdTvZvNwU/unlrk6BdbzuL1X3h7J//j
         Qlq+yjAGCKJridPc3tLf3j5J8yX54VGjWCZDKJb8RxOf/hOKcEfx5+kWmSgsU4bt0j
         sINenjEtH3Z1x9zghcKn1tPflmoSb0VtGy9BgLgcubhsHRzzD40RNzgV/MS/VwMYYc
         m7KKLhc5ezERA==
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 5/5] tests/cgroup: test cgroup.kill
Date:   Thu, 29 Apr 2021 14:01:13 +0200
Message-Id: <20210429120113.2238065-5-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210429120113.2238065-1-brauner@kernel.org>
References: <20210429120113.2238065-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=oBIHbe+ijtHkI/43k7XYiClzsWtmNv8ACAd1Hl7Tjf8=; m=h2Q2SWl//Wo7SGgfLSG5VhXOswYec3OCjwZXX32UcBE=; p=bttJncTWy6PT2msx/rXL7dCt3gITPHGSPpeU2C+woyg=; g=fb5541b3ad98c40e437a764540241185d5d17999
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYIqfXQAKCRCRxhvAZXjcopsvAP9JOl/ Hr1vyp1q8PnXGGj2lu4vYRpmM0SkebeoRkx+SEQD9EOcJwJzvWWi1EDLrM6dUFp0UyqW3gMnLvgu6 W4U/hAY=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Test that the new cgroup.kill feature works as intended.

Cc: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 tools/testing/selftests/cgroup/.gitignore  |   3 +-
 tools/testing/selftests/cgroup/Makefile    |   2 +
 tools/testing/selftests/cgroup/test_kill.c | 293 +++++++++++++++++++++
 3 files changed, 297 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/cgroup/test_kill.c

diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
index 84cfcabea838..be9643ef6285 100644
--- a/tools/testing/selftests/cgroup/.gitignore
+++ b/tools/testing/selftests/cgroup/.gitignore
@@ -2,4 +2,5 @@
 test_memcontrol
 test_core
 test_freezer
-test_kmem
\ No newline at end of file
+test_kmem
+test_kill
diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index f027d933595b..87b7b0d90773 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -9,6 +9,7 @@ TEST_GEN_PROGS = test_memcontrol
 TEST_GEN_PROGS += test_kmem
 TEST_GEN_PROGS += test_core
 TEST_GEN_PROGS += test_freezer
+TEST_GEN_PROGS += test_kill
 
 include ../lib.mk
 
@@ -16,3 +17,4 @@ $(OUTPUT)/test_memcontrol: cgroup_util.c ../clone3/clone3_selftests.h
 $(OUTPUT)/test_kmem: cgroup_util.c ../clone3/clone3_selftests.h
 $(OUTPUT)/test_core: cgroup_util.c ../clone3/clone3_selftests.h
 $(OUTPUT)/test_freezer: cgroup_util.c ../clone3/clone3_selftests.h
+$(OUTPUT)/test_kill: cgroup_util.c ../clone3/clone3_selftests.h
diff --git a/tools/testing/selftests/cgroup/test_kill.c b/tools/testing/selftests/cgroup/test_kill.c
new file mode 100644
index 000000000000..c4e7b2e87395
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_kill.c
@@ -0,0 +1,293 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <stdbool.h>
+#include <linux/limits.h>
+#include <sys/ptrace.h>
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <errno.h>
+#include <poll.h>
+#include <stdlib.h>
+#include <sys/inotify.h>
+#include <string.h>
+#include <sys/wait.h>
+
+#include "../kselftest.h"
+#include "cgroup_util.h"
+
+#define DEBUG
+#ifdef DEBUG
+#define debug(args...) fprintf(stderr, args)
+#else
+#define debug(args...)
+#endif
+
+/*
+ * Kill the given cgroup and wait for the inotify signal.
+ * If there are no events in 10 seconds, treat this as an error.
+ * Then check that the cgroup is in the desired state.
+ */
+static int cg_kill_wait(const char *cgroup)
+{
+	int fd, ret = -1;
+
+	fd = cg_prepare_for_wait(cgroup);
+	if (fd < 0)
+		return fd;
+
+	ret = cg_write(cgroup, "cgroup.kill", "1");
+	if (ret) {
+		debug("Error: cg_write() failed\n");
+		goto out;
+	}
+
+	ret = cg_wait_for(fd);
+	if (ret)
+		goto out;
+
+	ret = cg_read_strcmp(cgroup, "cgroup.events", "populated 0\n");
+out:
+	close(fd);
+	return ret;
+}
+
+/*
+ * A simple process running in a sleep loop until being
+ * re-parented.
+ */
+static int child_fn(const char *cgroup, void *arg)
+{
+	int ppid = getppid();
+
+	while (getppid() == ppid)
+		usleep(1000);
+
+	return getppid() == ppid;
+}
+
+static int test_cgkill_simple(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cgroup = NULL;
+	int i;
+
+	cgroup = cg_name(root, "cg_test_simple");
+	if (!cgroup)
+		goto cleanup;
+
+	if (cg_create(cgroup))
+		goto cleanup;
+
+	for (i = 0; i < 100; i++)
+		cg_run_nowait(cgroup, child_fn, NULL);
+
+	if (cg_wait_for_proc_count(cgroup, 100))
+		goto cleanup;
+
+        if (cg_write(cgroup, "cgroup.kill", "1"))
+		goto cleanup;
+
+	if (cg_read_strcmp(cgroup, "cgroup.events", "populated 1\n"))
+		goto cleanup;
+
+	if (cg_kill_wait(cgroup))
+		goto cleanup;
+
+	if (cg_read_strcmp(cgroup, "cgroup.events", "populated 0\n"))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (cgroup)
+		cg_destroy(cgroup);
+	free(cgroup);
+	return ret;
+}
+
+/*
+ * The test creates the following hierarchy:
+ *       A
+ *    / / \ \
+ *   B  E  I K
+ *  /\  |
+ * C  D F
+ *      |
+ *      G
+ *      |
+ *      H
+ *
+ * with a process in C, H and 3 processes in K.
+ * Then it tries to kill the whole tree.
+ */
+static int test_cgkill_tree(const char *root)
+{
+	char *cgroup[10] = {0};
+	int ret = KSFT_FAIL;
+	int i;
+
+	cgroup[0] = cg_name(root, "cg_test_tree_A");
+	if (!cgroup[0])
+		goto cleanup;
+
+	cgroup[1] = cg_name(cgroup[0], "B");
+	if (!cgroup[1])
+		goto cleanup;
+
+	cgroup[2] = cg_name(cgroup[1], "C");
+	if (!cgroup[2])
+		goto cleanup;
+
+	cgroup[3] = cg_name(cgroup[1], "D");
+	if (!cgroup[3])
+		goto cleanup;
+
+	cgroup[4] = cg_name(cgroup[0], "E");
+	if (!cgroup[4])
+		goto cleanup;
+
+	cgroup[5] = cg_name(cgroup[4], "F");
+	if (!cgroup[5])
+		goto cleanup;
+
+	cgroup[6] = cg_name(cgroup[5], "G");
+	if (!cgroup[6])
+		goto cleanup;
+
+	cgroup[7] = cg_name(cgroup[6], "H");
+	if (!cgroup[7])
+		goto cleanup;
+
+	cgroup[8] = cg_name(cgroup[0], "I");
+	if (!cgroup[8])
+		goto cleanup;
+
+	cgroup[9] = cg_name(cgroup[0], "K");
+	if (!cgroup[9])
+		goto cleanup;
+
+	for (i = 0; i < 10; i++)
+		if (cg_create(cgroup[i]))
+			goto cleanup;
+
+	cg_run_nowait(cgroup[2], child_fn, NULL);
+	cg_run_nowait(cgroup[7], child_fn, NULL);
+	cg_run_nowait(cgroup[9], child_fn, NULL);
+	cg_run_nowait(cgroup[9], child_fn, NULL);
+	cg_run_nowait(cgroup[9], child_fn, NULL);
+
+	/*
+	 * Wait until all child processes will enter
+	 * corresponding cgroups.
+	 */
+
+	if (cg_wait_for_proc_count(cgroup[2], 1) ||
+	    cg_wait_for_proc_count(cgroup[7], 1) ||
+	    cg_wait_for_proc_count(cgroup[9], 3))
+		goto cleanup;
+
+	/*
+	 * Kill A and check that we get an empty notification.
+	 */
+	if (cg_kill_wait(cgroup[0]))
+		goto cleanup;
+
+	if (cg_read_strcmp(cgroup[0], "cgroup.events", "populated 0\n"))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	for (i = 9; i >= 0 && cgroup[i]; i--) {
+		cg_destroy(cgroup[i]);
+		free(cgroup[i]);
+	}
+
+	return ret;
+}
+
+static int forkbomb_fn(const char *cgroup, void *arg)
+{
+	int ppid;
+
+	fork();
+	fork();
+
+	ppid = getppid();
+
+	while (getppid() == ppid)
+		usleep(1000);
+
+	return getppid() == ppid;
+}
+
+/*
+ * The test runs a fork bomb in a cgroup and tries to kill it.
+ */
+static int test_cgkill_forkbomb(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cgroup = NULL;
+
+	cgroup = cg_name(root, "cg_forkbomb_test");
+	if (!cgroup)
+		goto cleanup;
+
+	if (cg_create(cgroup))
+		goto cleanup;
+
+	cg_run_nowait(cgroup, forkbomb_fn, NULL);
+
+	usleep(100000);
+
+	if (cg_kill_wait(cgroup))
+		goto cleanup;
+
+	if (cg_wait_for_proc_count(cgroup, 0))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (cgroup)
+		cg_destroy(cgroup);
+	free(cgroup);
+	return ret;
+}
+
+#define T(x) { x, #x }
+struct cgkill_test {
+	int (*fn)(const char *root);
+	const char *name;
+} tests[] = {
+	T(test_cgkill_simple),
+	T(test_cgkill_tree),
+	T(test_cgkill_forkbomb),
+};
+#undef T
+
+int main(int argc, char *argv[])
+{
+	char root[PATH_MAX];
+	int i, ret = EXIT_SUCCESS;
+
+	if (cg_find_unified_root(root, sizeof(root)))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		switch (tests[i].fn(root)) {
+		case KSFT_PASS:
+			ksft_test_result_pass("%s\n", tests[i].name);
+			break;
+		case KSFT_SKIP:
+			ksft_test_result_skip("%s\n", tests[i].name);
+			break;
+		default:
+			ret = EXIT_FAILURE;
+			ksft_test_result_fail("%s\n", tests[i].name);
+			break;
+		}
+	}
+
+	return ret;
+}
-- 
2.27.0

