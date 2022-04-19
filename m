Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23B7507BF5
	for <lists+cgroups@lfdr.de>; Tue, 19 Apr 2022 23:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358028AbiDSVf5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Apr 2022 17:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358017AbiDSVfs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Apr 2022 17:35:48 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC831FA5B;
        Tue, 19 Apr 2022 14:33:04 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id e128so12448705qkd.7;
        Tue, 19 Apr 2022 14:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/2A26v8BYg4XGR0A4AftHu79JJJI4dmWW5Xn/YADuRg=;
        b=fd5U0+LRU6i9zidW5nAcV0bXjO5g9Qokp+YrrwzIWpsCLGPLBn3UOuuiwz8iYm7dll
         W0QTzc/2HolE7BL55V1UGjWQyXyjdhuAR2u4LASq2dNY6LZsHnE5qmIs10AqxfN4enSI
         e2XOxqRdzU3Z2m0pOUTU6ew7gboCpKwQMENocVhx0OGrzdeTGj+OGVEIkN8u0TD4h5ab
         SkD8aqcivrJFMKpL9W3Av4cuZ14I7kCXVXtnUN6RtJT5jeJQ6Y8PMcUzRGaPqXoACYl9
         HdT98WgcW1tSdCX+beRzL4mf0wxyEpeATrsGLheYOLe7xSgKIhi9/28hA20QPFKphSIk
         5EJQ==
X-Gm-Message-State: AOAM533xYdeVzu9goBp82YTqx590+dXhB5oXUlsByQ4+y5y6ajn95sxU
        Mob83Q75Z/XMyevk1nCcEGJdPyYi7jE=
X-Google-Smtp-Source: ABdhPJyrLxnX3OXIU3UQh5W6o2MTspMjiZzHAFalEiCdFAFMfrc6KuMTVpF5wfh62qvSHgvecbcUlQ==
X-Received: by 2002:a05:620a:198f:b0:69e:953c:1843 with SMTP id bm15-20020a05620a198f00b0069e953c1843mr7654783qkb.209.1650403983770;
        Tue, 19 Apr 2022 14:33:03 -0700 (PDT)
Received: from localhost (fwdproxy-ash-000.fbsv.net. [2a03:2880:20ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id q27-20020a05620a039b00b0069c8307d9c4sm578265qkm.18.2022.04.19.14.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:33:03 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 3/4] cgroup: Add test_cgcpu_weight_overprovisioned() testcase
Date:   Tue, 19 Apr 2022 14:32:44 -0700
Message-Id: <20220419213244.2104972-4-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419213244.2104972-1-void@manifault.com>
References: <20220419213244.2104972-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

test_cpu.c includes testcases that validate the cgroup cpu controller.
This patch adds a new testcase called test_cgcpu_weight_overprovisioned()
that verifies the expected behavior of creating multiple processes with
different cpu.weight, on a system that is overprovisioned.

So as to avoid code duplication, this patch also updates cpu_hog_func_param
to take a new hog_clock_type enum which informs how time is counted in
hog_cpus_timed() (either process time or wall clock time).

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c |  12 ++
 tools/testing/selftests/cgroup/cgroup_util.h |   1 +
 tools/testing/selftests/cgroup/test_cpu.c    | 138 ++++++++++++++++++-
 3 files changed, 144 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 0cf7e90c0052..b690fdc8b4cd 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -190,6 +190,18 @@ int cg_write(const char *cgroup, const char *control, char *buf)
 	return -1;
 }
 
+int cg_write_numeric(const char *cgroup, const char *control, long value)
+{
+	char buf[64];
+	int ret;
+
+	ret = sprintf(buf, "%lu", value);
+	if (ret < 0)
+		return ret;
+
+	return cg_write(cgroup, control, buf);
+}
+
 int cg_find_unified_root(char *root, size_t len)
 {
 	char buf[10 * PAGE_SIZE];
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 1df13dc8b8aa..0f79156697cf 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -35,6 +35,7 @@ extern long cg_read_long(const char *cgroup, const char *control);
 long cg_read_key_long(const char *cgroup, const char *control, const char *key);
 extern long cg_read_lc(const char *cgroup, const char *control);
 extern int cg_write(const char *cgroup, const char *control, char *buf);
+int cg_write_numeric(const char *cgroup, const char *control, long value);
 extern int cg_run(const char *cgroup,
 		  int (*fn)(const char *cgroup, void *arg),
 		  void *arg);
diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index 57f6308b1ef4..2afac9f9e1e2 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -2,6 +2,8 @@
 
 #define _GNU_SOURCE
 #include <linux/limits.h>
+#include <sys/sysinfo.h>
+#include <sys/wait.h>
 #include <errno.h>
 #include <pthread.h>
 #include <stdio.h>
@@ -10,9 +12,17 @@
 #include "../kselftest.h"
 #include "cgroup_util.h"
 
+enum hog_clock_type {
+	// Count elapsed time using the CLOCK_PROCESS_CPUTIME_ID clock.
+	CPU_HOG_CLOCK_PROCESS,
+	// Count elapsed time using system wallclock time.
+	CPU_HOG_CLOCK_WALL,
+};
+
 struct cpu_hog_func_param {
 	int nprocs;
 	long runtime_nsec;
+	enum hog_clock_type clock_type;
 };
 
 /*
@@ -90,8 +100,14 @@ static int hog_cpus_timed(const char *cgroup, void *arg)
 {
 	const struct cpu_hog_func_param *param =
 		(struct cpu_hog_func_param *)arg;
+	long start_time;
 	long nsecs_remaining = param->runtime_nsec;
 	int i, ret;
+	struct timespec ts;
+
+	ret = clock_gettime(CLOCK_MONOTONIC, &ts);
+	if (ret != 0)
+		return ret;
 
 	for (i = 0; i < param->nprocs; i++) {
 		pthread_t tid;
@@ -101,22 +117,29 @@ static int hog_cpus_timed(const char *cgroup, void *arg)
 			return ret;
 	}
 
+	start_time = ts.tv_nsec + ts.tv_sec * NSEC_PER_SEC;
 	while (nsecs_remaining > 0) {
-		long nsecs_so_far;
-		struct timespec ts = {
-			.tv_sec = nsecs_remaining / NSEC_PER_SEC,
-			.tv_nsec = nsecs_remaining % NSEC_PER_SEC,
-		};
+		long nsecs_so_far, baseline;
+		clockid_t clock_id;
 
+		ts.tv_sec = nsecs_remaining / NSEC_PER_SEC;
+		ts.tv_nsec = nsecs_remaining % NSEC_PER_SEC;
 		ret = nanosleep(&ts, NULL);
 		if (ret && errno != EINTR)
 			return ret;
 
-		ret = clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts);
+		if (param->clock_type == CPU_HOG_CLOCK_PROCESS) {
+			clock_id = CLOCK_PROCESS_CPUTIME_ID;
+			baseline = 0;
+		} else {
+			clock_id = CLOCK_MONOTONIC;
+			baseline = start_time;
+		}
+		ret = clock_gettime(clock_id, &ts);
 		if (ret != 0)
 			return ret;
 
-		nsecs_so_far = ts.tv_sec * NSEC_PER_SEC + ts.tv_nsec;
+		nsecs_so_far = ts.tv_sec * NSEC_PER_SEC + ts.tv_nsec - baseline;
 		nsecs_remaining = nsecs_so_far > param->runtime_nsec
 			? 0
 			: param->runtime_nsec - nsecs_so_far;
@@ -153,6 +176,7 @@ static int test_cgcpu_stats(const char *root)
 	struct cpu_hog_func_param param = {
 		.nprocs = 1,
 		.runtime_nsec = usage_seconds * NSEC_PER_SEC,
+		.clock_type = CPU_HOG_CLOCK_PROCESS,
 	};
 	if (cg_run(cgcpu, hog_cpus_timed, (void *)&param))
 		goto cleanup;
@@ -174,6 +198,105 @@ static int test_cgcpu_stats(const char *root)
 	return ret;
 }
 
+/*
+ * First, this test creates the following hierarchy:
+ * A
+ * A/B     cpu.weight = 50
+ * A/C     cpu.weight = 100
+ * A/D     cpu.weight = 150
+ *
+ * A separate process is then created for each child cgroup which spawns as
+ * many threads as there are cores, and hogs each CPU as much as possible
+ * for some time interval.
+ *
+ * Once all of the children have exited, we verify that each child cgroup
+ * was given proportional runtime as informed by their cpu.weight.
+ */
+static int test_cgcpu_weight_overprovisioned(const char *root)
+{
+	struct child {
+		char *cgroup;
+		pid_t pid;
+		long usage;
+	};
+	int ret = KSFT_FAIL, i;
+	char *parent = NULL;
+	struct child children[3] = {NULL};
+	long usage_seconds = 10;
+
+	parent = cg_name(root, "cgcpu_test_0");
+	if (!parent)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+cpu"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(children); i++) {
+		children[i].cgroup = cg_name_indexed(parent, "cgcpu_child", i);
+		if (!children[i].cgroup)
+			goto cleanup;
+
+		if (cg_create(children[i].cgroup))
+			goto cleanup;
+
+		if (cg_write_numeric(children[i].cgroup, "cpu.weight",
+					50 * (i + 1)))
+			goto cleanup;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(children); i++) {
+		struct cpu_hog_func_param param = {
+			.nprocs = get_nprocs(),
+			.runtime_nsec = usage_seconds * NSEC_PER_SEC,
+			.clock_type = CPU_HOG_CLOCK_WALL,
+		};
+		pid_t pid = cg_run_nowait(children[i].cgroup, hog_cpus_timed,
+				(void *)&param);
+		if (pid <= 0)
+			goto cleanup;
+		children[i].pid = pid;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(children); i++) {
+		int retcode;
+
+		waitpid(children[i].pid, &retcode, 0);
+		if (!WIFEXITED(retcode))
+			goto cleanup;
+		if (WEXITSTATUS(retcode))
+			goto cleanup;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(children); i++)
+		children[i].usage = cg_read_key_long(children[i].cgroup,
+				"cpu.stat", "usage_usec");
+
+	for (i = 0; i < ARRAY_SIZE(children) - 1; i++) {
+		long delta;
+
+		if (children[i + 1].usage <= children[i].usage)
+			goto cleanup;
+
+		delta = children[i + 1].usage - children[i].usage;
+		if (!values_close(delta, children[0].usage, 35))
+			goto cleanup;
+	}
+
+	ret = KSFT_PASS;
+cleanup:
+	for (i = 0; i < ARRAY_SIZE(children); i++) {
+		cg_destroy(children[i].cgroup);
+		free(children[i].cgroup);
+	}
+	cg_destroy(parent);
+	free(parent);
+
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct cgcpu_test {
 	int (*fn)(const char *root);
@@ -181,6 +304,7 @@ struct cgcpu_test {
 } tests[] = {
 	T(test_cgcpu_subtree_control),
 	T(test_cgcpu_stats),
+	T(test_cgcpu_weight_overprovisioned),
 };
 #undef T
 
-- 
2.30.2

