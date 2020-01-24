Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33A414841A
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2020 12:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392082AbgAXLkn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Jan 2020 06:40:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:50954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392074AbgAXLkm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 24 Jan 2020 06:40:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5475CABED;
        Fri, 24 Jan 2020 11:40:39 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     alex.shi@linux.alibaba.com, guro@fb.com, hannes@cmpxchg.org,
        kernel-team@android.com, linger.lee@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-mediatek@lists.infradead.org, lizefan@huawei.com,
        matthias.bgg@gmail.com, shuah@kernel.org, surenb@google.com,
        tj@kernel.org, tomcherry@google.com
Subject: [PATCH v2 3/3] kselftest/cgroup: add cgroup destruction test
Date:   Fri, 24 Jan 2020 12:40:17 +0100
Message-Id: <20200124114017.8363-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124114017.8363-1-mkoutny@suse.com>
References: <20200120145635.GA30904@blackbody.suse.cz>
 <20200124114017.8363-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Suren Baghdasaryan <surenb@google.com>

Add new test to verify that a cgroup with dead processes can be destroyed.
The test spawns a child process which allocates and touches 100MB of RAM
to ensure prolonged exit. Subsequently it kills the child, waits until
the cgroup containing the child is empty and destroys the cgroup.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
[mkoutny@suse.com: Fix typo in test_cgcore_destroy comment]
Acked-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/test_core.c | 113 +++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index c5ca669feb2b..76c9dd578ba5 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -2,7 +2,10 @@
 
 #include <linux/limits.h>
 #include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
 #include <unistd.h>
+#include <fcntl.h>
 #include <stdio.h>
 #include <errno.h>
 #include <signal.h>
@@ -12,6 +15,115 @@
 #include "../kselftest.h"
 #include "cgroup_util.h"
 
+static int touch_anon(char *buf, size_t size)
+{
+	int fd;
+	char *pos = buf;
+
+	fd = open("/dev/urandom", O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	while (size > 0) {
+		ssize_t ret = read(fd, pos, size);
+
+		if (ret < 0) {
+			if (errno != EINTR) {
+				close(fd);
+				return -1;
+			}
+		} else {
+			pos += ret;
+			size -= ret;
+		}
+	}
+	close(fd);
+
+	return 0;
+}
+
+static int alloc_and_touch_anon_noexit(const char *cgroup, void *arg)
+{
+	int ppid = getppid();
+	size_t size = (size_t)arg;
+	void *buf;
+
+	buf = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON,
+		   0, 0);
+	if (buf == MAP_FAILED)
+		return -1;
+
+	if (touch_anon((char *)buf, size)) {
+		munmap(buf, size);
+		return -1;
+	}
+
+	while (getppid() == ppid)
+		sleep(1);
+
+	munmap(buf, size);
+	return 0;
+}
+
+/*
+ * Create a child process that allocates and touches 100MB, then waits to be
+ * killed. Wait until the child is attached to the cgroup, kill all processes
+ * in that cgroup and wait until "cgroup.procs" is empty. At this point try to
+ * destroy the empty cgroup. The test helps detect race conditions between
+ * dying processes leaving the cgroup and cgroup destruction path.
+ */
+static int test_cgcore_destroy(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg_test = NULL;
+	int child_pid;
+	char buf[PAGE_SIZE];
+
+	cg_test = cg_name(root, "cg_test");
+
+	if (!cg_test)
+		goto cleanup;
+
+	for (int i = 0; i < 10; i++) {
+		if (cg_create(cg_test))
+			goto cleanup;
+
+		child_pid = cg_run_nowait(cg_test, alloc_and_touch_anon_noexit,
+					  (void *) MB(100));
+
+		if (child_pid < 0)
+			goto cleanup;
+
+		/* wait for the child to enter cgroup */
+		if (cg_wait_for_proc_count(cg_test, 1))
+			goto cleanup;
+
+		if (cg_killall(cg_test))
+			goto cleanup;
+
+		/* wait for cgroup to be empty */
+		while (1) {
+			if (cg_read(cg_test, "cgroup.procs", buf, sizeof(buf)))
+				goto cleanup;
+			if (buf[0] == '\0')
+				break;
+			usleep(1000);
+		}
+
+		if (rmdir(cg_test))
+			goto cleanup;
+
+		if (waitpid(child_pid, NULL, 0) < 0)
+			goto cleanup;
+	}
+	ret = KSFT_PASS;
+cleanup:
+	if (cg_test)
+		cg_destroy(cg_test);
+	free(cg_test);
+	return ret;
+}
+
 /*
  * A(0) - B(0) - C(1)
  *        \ D(0)
@@ -512,6 +624,7 @@ struct corecg_test {
 	T(test_cgcore_populated),
 	T(test_cgcore_proc_migration),
 	T(test_cgcore_thread_migration),
+	T(test_cgcore_destroy),
 };
 #undef T
 
-- 
2.24.1

