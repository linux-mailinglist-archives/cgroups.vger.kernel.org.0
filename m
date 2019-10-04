Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E06CB8C1
	for <lists+cgroups@lfdr.de>; Fri,  4 Oct 2019 12:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfJDK6N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Oct 2019 06:58:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:55174 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729086AbfJDK6H (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 4 Oct 2019 06:58:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA2F9AD17;
        Fri,  4 Oct 2019 10:58:04 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 4/5] selftests: cgroup: Add task migration tests
Date:   Fri,  4 Oct 2019 12:57:42 +0200
Message-Id: <20191004105743.363-5-mkoutny@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191004105743.363-1-mkoutny@suse.com>
References: <20191004105743.363-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add two new tests that verify that thread and threadgroup migrations
work as expected.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/Makefile      |   2 +-
 tools/testing/selftests/cgroup/cgroup_util.c |  26 ++++
 tools/testing/selftests/cgroup/cgroup_util.h |   2 +
 tools/testing/selftests/cgroup/test_core.c   | 146 +++++++++++++++++++
 4 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 8d369b6a2069..1c9179400be0 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -Wall
+CFLAGS += -Wall -pthread
 
 all:
 
diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index f6573eac1365..8f7131dcf1ff 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -158,6 +158,22 @@ long cg_read_key_long(const char *cgroup, const char *control, const char *key)
 	return atol(ptr + strlen(key));
 }
 
+long cg_read_lc(const char *cgroup, const char *control)
+{
+	char buf[PAGE_SIZE];
+	const char delim[] = "\n";
+	char *line;
+	long cnt = 0;
+
+	if (cg_read(cgroup, control, buf, sizeof(buf)))
+		return -1;
+
+	for (line = strtok(buf, delim); line; line = strtok(NULL, delim))
+		cnt++;
+
+	return cnt;
+}
+
 int cg_write(const char *cgroup, const char *control, char *buf)
 {
 	char path[PATH_MAX];
@@ -424,3 +440,13 @@ ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t
 
 	return read_text(path, buf, size);
 }
+
+int proc_read_strstr(int pid, bool thread, const char *item, const char *needle)
+{
+	char buf[PAGE_SIZE];
+
+	if (proc_read_text(pid, thread, item, buf, sizeof(buf)) < 0)
+		return -1;
+
+	return strstr(buf, needle) ? 0 : -1;
+}
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 27ff21d82af1..49c54fbdb229 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -30,6 +30,7 @@ extern int cg_read_strstr(const char *cgroup, const char *control,
 			  const char *needle);
 extern long cg_read_long(const char *cgroup, const char *control);
 long cg_read_key_long(const char *cgroup, const char *control, const char *key);
+extern long cg_read_lc(const char *cgroup, const char *control);
 extern int cg_write(const char *cgroup, const char *control, char *buf);
 extern int cg_run(const char *cgroup,
 		  int (*fn)(const char *cgroup, void *arg),
@@ -48,3 +49,4 @@ extern int set_oom_adj_score(int pid, int score);
 extern int cg_wait_for_proc_count(const char *cgroup, int count);
 extern int cg_killall(const char *cgroup);
 extern ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size);
+extern int proc_read_strstr(int pid, bool thread, const char *item, const char *needle);
diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index 79053a4f4783..c5ca669feb2b 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -5,6 +5,9 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <errno.h>
+#include <signal.h>
+#include <string.h>
+#include <pthread.h>
 
 #include "../kselftest.h"
 #include "cgroup_util.h"
@@ -354,6 +357,147 @@ static int test_cgcore_internal_process_constraint(const char *root)
 	return ret;
 }
 
+static void *dummy_thread_fn(void *arg)
+{
+	return (void *)(size_t)pause();
+}
+
+/*
+ * Test threadgroup migration.
+ * All threads of a process are migrated together.
+ */
+static int test_cgcore_proc_migration(const char *root)
+{
+	int ret = KSFT_FAIL;
+	int t, c_threads, n_threads = 13;
+	char *src = NULL, *dst = NULL;
+	pthread_t threads[n_threads];
+
+	src = cg_name(root, "cg_src");
+	dst = cg_name(root, "cg_dst");
+	if (!src || !dst)
+		goto cleanup;
+
+	if (cg_create(src))
+		goto cleanup;
+	if (cg_create(dst))
+		goto cleanup;
+
+	if (cg_enter_current(src))
+		goto cleanup;
+
+	for (c_threads = 0; c_threads < n_threads; ++c_threads) {
+		if (pthread_create(&threads[c_threads], NULL, dummy_thread_fn, NULL))
+			goto cleanup;
+	}
+
+	cg_enter_current(dst);
+	if (cg_read_lc(dst, "cgroup.threads") != n_threads + 1)
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	for (t = 0; t < c_threads; ++t) {
+		pthread_cancel(threads[t]);
+	}
+
+	for (t = 0; t < c_threads; ++t) {
+		pthread_join(threads[t], NULL);
+	}
+
+	cg_enter_current(root);
+
+	if (dst)
+		cg_destroy(dst);
+	if (src)
+		cg_destroy(src);
+	free(dst);
+	free(src);
+	return ret;
+}
+
+static void *migrating_thread_fn(void *arg)
+{
+	int g, i, n_iterations = 1000;
+	char **grps = arg;
+	char lines[3][PATH_MAX];
+
+	for (g = 1; g < 3; ++g)
+		snprintf(lines[g], sizeof(lines[g]), "0::%s", grps[g] + strlen(grps[0]));
+
+	for (i = 0; i < n_iterations; ++i) {
+		cg_enter_current_thread(grps[(i % 2) + 1]);
+
+		if (proc_read_strstr(0, 1, "cgroup", lines[(i % 2) + 1]))
+			return (void *)-1;
+	}
+	return NULL;
+}
+
+/*
+ * Test single thread migration.
+ * Threaded cgroups allow successful migration of a thread.
+ */
+static int test_cgcore_thread_migration(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *dom = NULL;
+	char line[PATH_MAX];
+	char *grps[3] = { (char *)root, NULL, NULL };
+	pthread_t thr;
+	void *retval;
+
+	dom = cg_name(root, "cg_dom");
+	grps[1] = cg_name(root, "cg_dom/cg_src");
+	grps[2] = cg_name(root, "cg_dom/cg_dst");
+	if (!grps[1] || !grps[2] || !dom)
+		goto cleanup;
+
+	if (cg_create(dom))
+		goto cleanup;
+	if (cg_create(grps[1]))
+		goto cleanup;
+	if (cg_create(grps[2]))
+		goto cleanup;
+
+	if (cg_write(grps[1], "cgroup.type", "threaded"))
+		goto cleanup;
+	if (cg_write(grps[2], "cgroup.type", "threaded"))
+		goto cleanup;
+
+	if (cg_enter_current(grps[1]))
+		goto cleanup;
+
+	if (pthread_create(&thr, NULL, migrating_thread_fn, grps))
+		goto cleanup;
+
+	if (pthread_join(thr, &retval))
+		goto cleanup;
+
+	if (retval)
+		goto cleanup;
+
+	snprintf(line, sizeof(line), "0::%s", grps[1] + strlen(grps[0]));
+	if (proc_read_strstr(0, 1, "cgroup", line))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_enter_current(root);
+	if (grps[2])
+		cg_destroy(grps[2]);
+	if (grps[1])
+		cg_destroy(grps[1]);
+	if (dom)
+		cg_destroy(dom);
+	free(grps[2]);
+	free(grps[1]);
+	free(dom);
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct corecg_test {
 	int (*fn)(const char *root);
@@ -366,6 +510,8 @@ struct corecg_test {
 	T(test_cgcore_parent_becomes_threaded),
 	T(test_cgcore_invalid_domain),
 	T(test_cgcore_populated),
+	T(test_cgcore_proc_migration),
+	T(test_cgcore_thread_migration),
 };
 #undef T
 
-- 
2.21.0

