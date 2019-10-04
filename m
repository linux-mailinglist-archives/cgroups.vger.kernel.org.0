Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7181CB8BE
	for <lists+cgroups@lfdr.de>; Fri,  4 Oct 2019 12:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfJDK6H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Oct 2019 06:58:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729065AbfJDK6G (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 4 Oct 2019 06:58:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56368AD12;
        Fri,  4 Oct 2019 10:58:04 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH 3/5] selftests: cgroup: Simplify task self migration
Date:   Fri,  4 Oct 2019 12:57:41 +0200
Message-Id: <20191004105743.363-4-mkoutny@suse.com>
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

Simplify task migration by being oblivious about its PID during
migration. This allows to easily migrate individual threads as well.
This change brings no functional change and prepares grounds for thread
granularity migrating tests.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c  | 16 +++++++++++-----
 tools/testing/selftests/cgroup/cgroup_util.h  |  4 +++-
 tools/testing/selftests/cgroup/test_freezer.c |  2 +-
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index bdb69599c4bd..f6573eac1365 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -282,10 +282,12 @@ int cg_enter(const char *cgroup, int pid)
 
 int cg_enter_current(const char *cgroup)
 {
-	char pidbuf[64];
+	return cg_write(cgroup, "cgroup.procs", "0");
+}
 
-	snprintf(pidbuf, sizeof(pidbuf), "%d", getpid());
-	return cg_write(cgroup, "cgroup.procs", pidbuf);
+int cg_enter_current_thread(const char *cgroup)
+{
+	return cg_write(cgroup, "cgroup.threads", "0");
 }
 
 int cg_run(const char *cgroup,
@@ -410,11 +412,15 @@ int set_oom_adj_score(int pid, int score)
 	return 0;
 }
 
-char proc_read_text(int pid, const char *item, char *buf, size_t size)
+ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size)
 {
 	char path[PATH_MAX];
 
-	snprintf(path, sizeof(path), "/proc/%d/%s", pid, item);
+	if (!pid)
+		snprintf(path, sizeof(path), "/proc/%s/%s",
+			 thread ? "thread-self" : "self", item);
+	else
+		snprintf(path, sizeof(path), "/proc/%d/%s", pid, item);
 
 	return read_text(path, buf, size);
 }
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index c72f28046bfa..27ff21d82af1 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <stdbool.h>
 #include <stdlib.h>
 
 #define PAGE_SIZE 4096
@@ -35,6 +36,7 @@ extern int cg_run(const char *cgroup,
 		  void *arg);
 extern int cg_enter(const char *cgroup, int pid);
 extern int cg_enter_current(const char *cgroup);
+extern int cg_enter_current_thread(const char *cgroup);
 extern int cg_run_nowait(const char *cgroup,
 			 int (*fn)(const char *cgroup, void *arg),
 			 void *arg);
@@ -45,4 +47,4 @@ extern int is_swap_enabled(void);
 extern int set_oom_adj_score(int pid, int score);
 extern int cg_wait_for_proc_count(const char *cgroup, int count);
 extern int cg_killall(const char *cgroup);
-extern char proc_read_text(int pid, const char *item, char *buf, size_t size);
+extern ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size);
diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
index 8219a30853d2..5896e35168cd 100644
--- a/tools/testing/selftests/cgroup/test_freezer.c
+++ b/tools/testing/selftests/cgroup/test_freezer.c
@@ -648,7 +648,7 @@ static int proc_check_stopped(int pid)
 	char buf[PAGE_SIZE];
 	int len;
 
-	len = proc_read_text(pid, "stat", buf, sizeof(buf));
+	len = proc_read_text(pid, 0, "stat", buf, sizeof(buf));
 	if (len == -1) {
 		debug("Can't get %d stat\n", pid);
 		return -1;
-- 
2.21.0

