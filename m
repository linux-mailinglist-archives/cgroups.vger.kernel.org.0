Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EBA3716CE
	for <lists+cgroups@lfdr.de>; Mon,  3 May 2021 16:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhECOlY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 May 2021 10:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhECOlY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 3 May 2021 10:41:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C2E0611C2;
        Mon,  3 May 2021 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620052830;
        bh=tmch2PIT1C8gQWfauWKXwhbLVkYhCqnym9EO8BwGtf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qaXbOAjeeLrkrJ5MY/HoxFwFTzspOwiKy8xrxG5foxrg/6Pwlxt7k3xDgsWwNV47y
         /585IpmIdfZZIbk+I327Qh10zDNvSiP0eCWidJkERgK/HWzntCs823k8NyZrl7NkIy
         JilUUXW8Z/8ztmbQDgC53viTGt9a0eI9EbsPJStdKyGjcgOxpru/OOBUykYKSsmlU/
         EEeVdztLDLJhanb9B7lWcrTH2SncQTaFqkJTw7LZi9eC8BWMRqu2f5fAHLoY14UhoP
         c6MAN8wtKSWQVnS+jnFiLiXD1bwqRXL4QlTb//xN1VCOipKibwkqy8zTl1IRPkM+6S
         rPOIX3H5BSQqw==
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 5/5] tests/cgroup: test cgroup.kill
Date:   Mon,  3 May 2021 16:39:23 +0200
Message-Id: <20210503143922.3093755-5-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210503143922.3093755-1-brauner@kernel.org>
References: <20210503143922.3093755-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=oBIHbe+ijtHkI/43k7XYiClzsWtmNv8ACAd1Hl7Tjf8=; m=GL6pVTfDlcasRrJs3zAP4Et9ePmCqhO4Zpxn9QZoR+c=; p=5kAnjYrPMs11m2C7AJUHQbfh1+I4oz+ePfjXaKrI9+c=; g=4170d2494d01c59c2e7f222a43721cc7e5c91ae1
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYJAK7wAKCRCRxhvAZXjcojEqAQDu6Qk 55ftET/kdy0nVw3047ltApi5WFwo6g9KEM27CfAD/bs9E/NJY71HkuBpkF/WJZLCysfBwF2MkJFks 5aT7nAw=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Test that the new cgroup.kill feature works as intended.

Cc: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Remove debug logging (It wasn't very helpful in the first place.).
---
 tools/testing/selftests/cgroup/.gitignore  |   3 +-
 tools/testing/selftests/cgroup/Makefile    |   2 +
 tools/testing/selftests/cgroup/test_kill.c | 291 +++++++++++++++++++++
 3 files changed, 295 insertions(+), 1 deletion(-)
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
index f027d933595b..59e222460581 100644
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
+$(OUTPUT)/test_kill: cgroup_util.c ../clone3/clone3_selftests.h ../pidfd/pidfd.h
diff --git a/tools/testing/selftests/cgroup/test_kill.c b/tools/testing/selftests/cgroup/test_kill.c
new file mode 100644
index 000000000000..3e1132deed33
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_kill.c
@@ -0,0 +1,291 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <errno.h>
+#include <linux/limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+#include "../pidfd/pidfd.h"
+#include "cgroup_util.h"
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
+	if (ret)
+		goto out;
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
+	pid_t pids[100];
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
+		pids[i] = cg_run_nowait(cgroup, child_fn, NULL);
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
+	for (i = 0; i < 100; i++)
+		wait_for_pid(pids[i]);
+
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
+	pid_t pids[5];
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
+	pids[0] = cg_run_nowait(cgroup[2], child_fn, NULL);
+	pids[1] = cg_run_nowait(cgroup[7], child_fn, NULL);
+	pids[2] = cg_run_nowait(cgroup[9], child_fn, NULL);
+	pids[3] = cg_run_nowait(cgroup[9], child_fn, NULL);
+	pids[4] = cg_run_nowait(cgroup[9], child_fn, NULL);
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
+	ret = KSFT_PASS;
+
+cleanup:
+	for (i = 0; i < 5; i++)
+		wait_for_pid(pids[i]);
+
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
+	pid_t pid = -ESRCH;
+
+	cgroup = cg_name(root, "cg_forkbomb_test");
+	if (!cgroup)
+		goto cleanup;
+
+	if (cg_create(cgroup))
+		goto cleanup;
+
+	pid = cg_run_nowait(cgroup, forkbomb_fn, NULL);
+	if (pid < 0)
+		goto cleanup;
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
+	if (pid > 0)
+		wait_for_pid(pid);
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

