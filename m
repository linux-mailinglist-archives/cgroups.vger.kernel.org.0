Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DA750BED3
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 19:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiDVRjT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 13:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiDVRjT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 13:39:19 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4058EBB918;
        Fri, 22 Apr 2022 10:36:16 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id s4so6347874qkh.0;
        Fri, 22 Apr 2022 10:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jd8Of3UQ/tKXQyCAU+TY/4BZIiO1B8v+E8NTO3SRV0g=;
        b=67bewfq4JSiGMNkH3BxEaaEXNeRZuT29zbFLi9nBMlL2JaBNpVuy9Jbvda99CJAftg
         ImEs19az89q9OJ3Dt1/kDy7/8Zp/Ehz/ntv+WDZAh+aLqAK3XIj92MaEhKdK8Zhl+R01
         XKhgvsYqWL16Iz+5+n/at02WDnMAxurhKUeHpwD64c2an6zYcW6a+1UXQ7nhnqNhSg1A
         tTWA7Sa2u0jX89UkC4izO5QsZLlOsNjFeyn78k1mSj34JK+W8lr0v528rwy6WXrXr2/4
         5xro1gMm8tdO1ud3H3VIUIYF/+R/Ei2DRAbmAtnnxXxpToUzr9+YlFv6SKre85unQbNW
         cdng==
X-Gm-Message-State: AOAM532NU0K5E64U3q2TDPbijDRtiq4+4/HC/VeNqqclQ3YTfRk+q+fU
        l5t29EcgqtvssKwKi1+plX06mDa1hOgGSQ==
X-Google-Smtp-Source: ABdhPJyTT4O6pc8bwgHjfFEarWkws8V3+iMpizSW91UzeSI3fpGVsB8It4W5bxvliPVaK4ljqNmCDw==
X-Received: by 2002:a05:620a:d4e:b0:69b:f2e5:b8cd with SMTP id o14-20020a05620a0d4e00b0069bf2e5b8cdmr3390200qkl.535.1650648870591;
        Fri, 22 Apr 2022 10:34:30 -0700 (PDT)
Received: from localhost (fwdproxy-ash-009.fbsv.net. [2a03:2880:20ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id h5-20020a05622a170500b002f33ec7a932sm1632660qtk.79.2022.04.22.10.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:34:30 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 3/4] cgroup: Add test_cpucg_weight_overprovisioned() testcase
Date:   Fri, 22 Apr 2022 10:33:52 -0700
Message-Id: <20220422173349.3394844-4-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220422173349.3394844-1-void@manifault.com>
References: <20220422173349.3394844-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

test_cpu.c includes testcases that validate the cgroup cpu controller.
This patch adds a new testcase called test_cpucg_weight_overprovisioned()
that verifies the expected behavior of creating multiple processes with
different cpu.weight, on a system that is overprovisioned.

So as to avoid code duplication, this patch also updates cpu_hog_func_param
to take a new hog_clock_type enum which informs how time is counted in
hog_cpus_timed() (either process time or wall clock time).

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c |  12 ++
 tools/testing/selftests/cgroup/cgroup_util.h |   1 +
 tools/testing/selftests/cgroup/test_cpu.c    | 135 ++++++++++++++++++-
 3 files changed, 145 insertions(+), 3 deletions(-)

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
index 3bd61964a262..8d901c06c79d 100644
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
 	struct timespec ts;
+	enum hog_clock_type clock_type;
 };
 
 /*
@@ -118,8 +128,13 @@ static int hog_cpus_timed(const char *cgroup, void *arg)
 		(struct cpu_hog_func_param *)arg;
 	struct timespec ts_run = param->ts;
 	struct timespec ts_remaining = ts_run;
+	struct timespec ts_start;
 	int i, ret;
 
+	ret = clock_gettime(CLOCK_MONOTONIC, &ts_start);
+	if (ret != 0)
+		return ret;
+
 	for (i = 0; i < param->nprocs; i++) {
 		pthread_t tid;
 
@@ -135,9 +150,19 @@ static int hog_cpus_timed(const char *cgroup, void *arg)
 		if (ret && errno != EINTR)
 			return ret;
 
-		ret = clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts_total);
-		if (ret != 0)
-			return ret;
+		if (param->clock_type == CPU_HOG_CLOCK_PROCESS) {
+			ret = clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts_total);
+			if (ret != 0)
+				return ret;
+		} else {
+			struct timespec ts_current;
+
+			ret = clock_gettime(CLOCK_MONOTONIC, &ts_current);
+			if (ret != 0)
+				return ret;
+
+			ts_total = timespec_sub(&ts_current, &ts_start);
+		}
 
 		ts_remaining = timespec_sub(&ts_run, &ts_total);
 	}
@@ -176,6 +201,7 @@ static int test_cpucg_stats(const char *root)
 			.tv_sec = usage_seconds,
 			.tv_nsec = 0,
 		},
+		.clock_type = CPU_HOG_CLOCK_PROCESS,
 	};
 	if (cg_run(cpucg, hog_cpus_timed, (void *)&param))
 		goto cleanup;
@@ -197,6 +223,108 @@ static int test_cpucg_stats(const char *root)
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
+static int test_cpucg_weight_overprovisioned(const char *root)
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
+	parent = cg_name(root, "cpucg_test_0");
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
+		children[i].cgroup = cg_name_indexed(parent, "cpucg_child", i);
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
+			.ts = {
+				.tv_sec = usage_seconds,
+				.tv_nsec = 0,
+			},
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
 struct cpucg_test {
 	int (*fn)(const char *root);
@@ -204,6 +332,7 @@ struct cpucg_test {
 } tests[] = {
 	T(test_cpucg_subtree_control),
 	T(test_cpucg_stats),
+	T(test_cpucg_weight_overprovisioned),
 };
 #undef T
 
-- 
2.30.2

