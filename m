Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAECF50BED0
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 19:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiDVRjF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 13:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiDVRjA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 13:39:00 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE08D5548;
        Fri, 22 Apr 2022 10:35:51 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id d198so6283454qkc.12;
        Fri, 22 Apr 2022 10:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0DSWbnn0fhVndljQbawmD94d+TjvuiqLmSnohT7FsPA=;
        b=HZHwFORWyaCg5tUTlXM3nOsJbcia5kew7VHjz5ht4rIAlGQUa/p7z4+SNKU6Z3t4rr
         0PVeoXIcsJXIGFC3EAAeB19fwMChnLK2V4gs27ciFHE4qZk46CDoXkufgfkUOxudQgk4
         s631MSb9FHCp+pNEJab4/SOh1K2DEWR/vEvgJeKcdDMuo7LHZpARNpCI+N1JpeANjG+/
         VuxzP4CYXn1P8Q37KjXzpElgoVNFTzkzrcPdW35Ly4Um99WPa4dHM4ZE5EjB4wZI0cIq
         1cDK0s3DQ9Dtq12LI7WdnjbR+RZFhQGvsjwsN/z65KQiuVcZv2XaTTdzO9EK7bfHWhK0
         dGwA==
X-Gm-Message-State: AOAM530u5RMH1ox3J69aRbIxS/tEqm/c1M50qgQhjL22M1SnX906Khn9
        0uf20iBiP8uERc6NT+53hyk=
X-Google-Smtp-Source: ABdhPJwprj8tGc/FLZJ7x9LSgD1YITitei6i6hU3Csv/3S7k2n2Y7Niaj5cPexfM/6JKvYjqB0EHmg==
X-Received: by 2002:a37:aa92:0:b0:69c:89c4:e6ee with SMTP id t140-20020a37aa92000000b0069c89c4e6eemr3390371qke.22.1650648868855;
        Fri, 22 Apr 2022 10:34:28 -0700 (PDT)
Received: from localhost (fwdproxy-ash-021.fbsv.net. [2a03:2880:20ff:15::face:b00c])
        by smtp.gmail.com with ESMTPSA id d22-20020a05622a101600b002f1f139d83bsm1445521qte.84.2022.04.22.10.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:34:28 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/4] cgroup: Add test_cpucg_stats() testcase to cgroup cpu selftests
Date:   Fri, 22 Apr 2022 10:33:51 -0700
Message-Id: <20220422173349.3394844-3-void@manifault.com>
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
This patch adds a new testcase called test_cpucg_stats() that verifies the
expected behavior of the cpu.stat interface. In doing so, we define a
new hog_cpus_timed() function which takes a cpu_hog_func_param struct
that configures how many CPUs it uses, and how long it runs. Future
patches will also spawn threads that hog CPUs, so this function will
eventually serve those use-cases as well.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/cgroup/cgroup_util.h |   3 +
 tools/testing/selftests/cgroup/test_cpu.c    | 128 +++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 4f66d10626d2..1df13dc8b8aa 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -8,6 +8,9 @@
 
 #define MB(x) (x << 20)
 
+#define USEC_PER_SEC	1000000L
+#define NSEC_PER_SEC	1000000000L
+
 /*
  * Checks if two given values differ by less than err% of their sum.
  */
diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index a724bff00d07..3bd61964a262 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -2,11 +2,19 @@
 
 #define _GNU_SOURCE
 #include <linux/limits.h>
+#include <errno.h>
+#include <pthread.h>
 #include <stdio.h>
+#include <time.h>
 
 #include "../kselftest.h"
 #include "cgroup_util.h"
 
+struct cpu_hog_func_param {
+	int nprocs;
+	struct timespec ts;
+};
+
 /*
  * This test creates two nested cgroups with and without enabling
  * the cpu controller.
@@ -70,12 +78,132 @@ static int test_cpucg_subtree_control(const char *root)
 	return ret;
 }
 
+static void *hog_cpu_thread_func(void *arg)
+{
+	while (1)
+		;
+
+	return NULL;
+}
+
+static struct timespec
+timespec_sub(const struct timespec *lhs, const struct timespec *rhs)
+{
+	struct timespec zero = {
+		.tv_sec = 0,
+		.tv_nsec = 0,
+	};
+	struct timespec ret;
+
+	if (lhs->tv_sec < rhs->tv_sec)
+		return zero;
+
+	ret.tv_sec = lhs->tv_sec - rhs->tv_sec;
+
+	if (lhs->tv_nsec < rhs->tv_nsec) {
+		if (ret.tv_sec == 0)
+			return zero;
+
+		ret.tv_sec--;
+		ret.tv_nsec = NSEC_PER_SEC - rhs->tv_nsec + lhs->tv_nsec;
+	} else
+		ret.tv_nsec = lhs->tv_nsec - rhs->tv_nsec;
+
+	return ret;
+}
+
+static int hog_cpus_timed(const char *cgroup, void *arg)
+{
+	const struct cpu_hog_func_param *param =
+		(struct cpu_hog_func_param *)arg;
+	struct timespec ts_run = param->ts;
+	struct timespec ts_remaining = ts_run;
+	int i, ret;
+
+	for (i = 0; i < param->nprocs; i++) {
+		pthread_t tid;
+
+		ret = pthread_create(&tid, NULL, &hog_cpu_thread_func, NULL);
+		if (ret != 0)
+			return ret;
+	}
+
+	while (ts_remaining.tv_sec > 0 || ts_remaining.tv_nsec > 0) {
+		struct timespec ts_total;
+
+		ret = nanosleep(&ts_remaining, NULL);
+		if (ret && errno != EINTR)
+			return ret;
+
+		ret = clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts_total);
+		if (ret != 0)
+			return ret;
+
+		ts_remaining = timespec_sub(&ts_run, &ts_total);
+	}
+
+	return 0;
+}
+
+/*
+ * Creates a cpu cgroup, burns a CPU for a few quanta, and verifies that
+ * cpu.stat shows the expected output.
+ */
+static int test_cpucg_stats(const char *root)
+{
+	int ret = KSFT_FAIL;
+	long usage_usec, user_usec, system_usec;
+	long usage_seconds = 2;
+	long expected_usage_usec = usage_seconds * USEC_PER_SEC;
+	char *cpucg;
+
+	cpucg = cg_name(root, "cpucg_test");
+	if (!cpucg)
+		goto cleanup;
+
+	if (cg_create(cpucg))
+		goto cleanup;
+
+	usage_usec = cg_read_key_long(cpucg, "cpu.stat", "usage_usec");
+	user_usec = cg_read_key_long(cpucg, "cpu.stat", "user_usec");
+	system_usec = cg_read_key_long(cpucg, "cpu.stat", "system_usec");
+	if (usage_usec != 0 || user_usec != 0 || system_usec != 0)
+		goto cleanup;
+
+	struct cpu_hog_func_param param = {
+		.nprocs = 1,
+		.ts = {
+			.tv_sec = usage_seconds,
+			.tv_nsec = 0,
+		},
+	};
+	if (cg_run(cpucg, hog_cpus_timed, (void *)&param))
+		goto cleanup;
+
+	usage_usec = cg_read_key_long(cpucg, "cpu.stat", "usage_usec");
+	user_usec = cg_read_key_long(cpucg, "cpu.stat", "user_usec");
+	if (user_usec <= 0)
+		goto cleanup;
+
+	if (!values_close(usage_usec, expected_usage_usec, 1))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_destroy(cpucg);
+	free(cpucg);
+
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct cpucg_test {
 	int (*fn)(const char *root);
 	const char *name;
 } tests[] = {
 	T(test_cpucg_subtree_control),
+	T(test_cpucg_stats),
 };
 #undef T
 
-- 
2.30.2

