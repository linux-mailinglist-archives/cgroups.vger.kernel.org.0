Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0078815321E
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2020 14:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgBENoo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Feb 2020 08:44:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:52290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbgBENom (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 Feb 2020 08:44:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6B8DCAFBB;
        Wed,  5 Feb 2020 13:44:39 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/3] selftests: cgroup: Add basic tests for pids controller
Date:   Wed,  5 Feb 2020 14:44:26 +0100
Message-Id: <20200205134426.10570-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205134426.10570-1-mkoutny@suse.com>
References: <20191128172612.10259-1-mkoutny@suse.com>
 <20200205134426.10570-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This commit adds (and wires in) new test program for checking basic pids
controller functionality -- restricting tasks in a cgroup and correct
event counting.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/Makefile    |   8 +-
 tools/testing/selftests/cgroup/test_pids.c | 188 +++++++++++++++++++++
 2 files changed, 193 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/test_pids.c

diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 66aafe1f5746..15a8578f40b4 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -5,12 +5,14 @@ all:
 
 TEST_FILES     := with_stress.sh
 TEST_PROGS     := test_stress.sh
-TEST_GEN_PROGS = test_memcontrol
-TEST_GEN_PROGS += test_core
+TEST_GEN_PROGS = test_core
 TEST_GEN_PROGS += test_freezer
+TEST_GEN_PROGS += test_memcontrol
+TEST_GEN_PROGS += test_pids
 
 include ../lib.mk
 
-$(OUTPUT)/test_memcontrol: cgroup_util.c
 $(OUTPUT)/test_core: cgroup_util.c
 $(OUTPUT)/test_freezer: cgroup_util.c
+$(OUTPUT)/test_memcontrol: cgroup_util.c
+$(OUTPUT)/test_pids: cgroup_util.c
diff --git a/tools/testing/selftests/cgroup/test_pids.c b/tools/testing/selftests/cgroup/test_pids.c
new file mode 100644
index 000000000000..6545d81f2838
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_pids.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <linux/limits.h>
+#include <signal.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+#include "cgroup_util.h"
+
+static int run_success(const char *cgroup, void *arg)
+{
+	return 0;
+}
+
+static int run_pause(const char *cgroup, void *arg)
+{
+	return pause();
+}
+
+/*
+ * This test checks that pids.max prevents forking new children above the
+ * specified limit in the cgroup.
+ */
+static int test_pids_max(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg_pids;
+	int pid;
+
+
+	cg_pids = cg_name(root, "pids_test");
+	if (!cg_pids)
+		goto cleanup;
+
+	if (cg_create(cg_pids))
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_pids, "pids.max", "max\n"))
+		goto cleanup;
+
+	if (cg_write(cg_pids, "pids.max", "2"))
+		goto cleanup;
+
+	if (cg_enter_current(cg_pids))
+		goto cleanup;
+
+	pid = cg_run_nowait(cg_pids, run_pause, NULL);
+	if (pid < 0)
+		goto cleanup;
+
+	if (cg_run_nowait(cg_pids, run_success, NULL) != -1 || errno != EAGAIN)
+		goto cleanup;
+
+	if (kill(pid, SIGINT))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_enter_current(root);
+	cg_destroy(cg_pids);
+	free(cg_pids);
+
+	return ret;
+}
+
+/*
+ * This test checks that while pids.max prevents forking new children above the
+ * specified limit in the cgroup appropriate events are generated in the
+ * hiearchy.
+ */
+static int test_pids_events(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg_parent = NULL, *cg_child = NULL;
+	int pid;
+
+
+	cg_parent = cg_name(root, "pids_parent");
+	cg_child = cg_name(cg_parent, "pids_child");
+	if (!cg_parent || !cg_child)
+		goto cleanup;
+
+	if (cg_create(cg_parent))
+		goto cleanup;
+	if (cg_write(cg_parent, "cgroup.subtree_control", "+pids"))
+		goto cleanup;
+	if (cg_create(cg_child))
+		goto cleanup;
+
+	if (cg_write(cg_parent, "pids.max", "2"))
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_child, "pids.max", "max\n"))
+		goto cleanup;
+
+	if (cg_enter_current(cg_child))
+		goto cleanup;
+
+	pid = cg_run_nowait(cg_child, run_pause, NULL);
+	if (pid < 0)
+		goto cleanup;
+
+	if (cg_run_nowait(cg_child, run_success, NULL) != -1 || errno != EAGAIN)
+		goto cleanup;
+
+	if (kill(pid, SIGINT))
+		goto cleanup;
+
+
+	if (cg_read_key_long(cg_child, "pids.events", "max ") != 0)
+		goto cleanup;
+	if (cg_read_key_long(cg_child, "pids.events", "max.imposed ") != 1)
+		goto cleanup;
+
+	if (cg_read_key_long(cg_parent, "pids.events", "max ") != 1)
+		goto cleanup;
+	if (cg_read_key_long(cg_parent, "pids.events", "max.imposed ") != 1)
+		goto cleanup;
+
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_enter_current(root);
+	if (cg_child)
+		cg_destroy(cg_child);
+	if (cg_parent)
+		cg_destroy(cg_parent);
+	free(cg_child);
+	free(cg_parent);
+
+	return ret;
+}
+
+
+
+#define T(x) { x, #x }
+struct pids_test {
+	int (*fn)(const char *root);
+	const char *name;
+} tests[] = {
+	T(test_pids_max),
+	T(test_pids_events),
+};
+#undef T
+
+int main(int argc, char **argv)
+{
+	char root[PATH_MAX];
+	int i, ret = EXIT_SUCCESS;
+
+	if (cg_find_unified_root(root, sizeof(root)))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	/*
+	 * Check that pids controller is available:
+	 * pids is listed in cgroup.controllers
+	 */
+	if (cg_read_strstr(root, "cgroup.controllers", "pids"))
+		ksft_exit_skip("pids controller isn't available\n");
+
+	if (cg_read_strstr(root, "cgroup.subtree_control", "pids"))
+		if (cg_write(root, "cgroup.subtree_control", "+pids"))
+			ksft_exit_skip("Failed to set pids controller\n");
+
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
2.24.1

