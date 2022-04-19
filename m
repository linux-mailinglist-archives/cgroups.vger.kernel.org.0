Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD25507BF1
	for <lists+cgroups@lfdr.de>; Tue, 19 Apr 2022 23:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358005AbiDSVfr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Apr 2022 17:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358008AbiDSVfq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Apr 2022 17:35:46 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC02331907;
        Tue, 19 Apr 2022 14:33:02 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id f22so4061853qtp.13;
        Tue, 19 Apr 2022 14:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IislFSHuxEloX/PvVR3ULKpFKGrJ80ALsCIDW418z0Y=;
        b=PEp3yM4G6qqNiN6yl2vXMF/2e4WNggCZ6Nd0v8ro5YczNKIfQZIaeFUQA4EqpLljI7
         IJplZIb7dkuuqycIZub241NaceNFRDn2dO1y50i5S7PQe9pgbfAd+G79t2iQsmKJfymz
         rAWmlWJbWNAJEGk9XcRyLro28XsOYysJvJwfehXAyUIvc3tqRTdmuEUZk/kVwDYwi8XJ
         yTc2LqBzIeKzGTEvcksGaAXUQBL/O5frhf4Q1letVP5zn+X6WiJfxlpXP2CS1RAYW3VQ
         rsmmIgQ7nlLLdQ0IkJLVukVfAIi87EiqUy5GntxxsG7hLoEvZZMfVdj0TQpBQh5k9e0y
         5cxg==
X-Gm-Message-State: AOAM530UQhNXhEnArPrSFfVFSXSaUZJe9xOI0OFucEnjPUwCCsOt7DLZ
        5G3Ych8byZY8FawfG0s8/oY=
X-Google-Smtp-Source: ABdhPJw+60SN/9RLN7t8BG6nXdGk1CtsGNWMY04yUNLlqVuNY2ENraBOB56yltq6kbjN3PH9bHsrsw==
X-Received: by 2002:ac8:7dc6:0:b0:2f2:1b0:524d with SMTP id c6-20020ac87dc6000000b002f201b0524dmr6861140qte.402.1650403981974;
        Tue, 19 Apr 2022 14:33:01 -0700 (PDT)
Received: from localhost (fwdproxy-ash-023.fbsv.net. [2a03:2880:20ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id t125-20020a372d83000000b0069c1df12422sm572472qkh.84.2022.04.19.14.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:33:01 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 2/4] cgroup: Add test_cgcpu_stats() testcase to cgroup cpu selftests
Date:   Tue, 19 Apr 2022 14:32:43 -0700
Message-Id: <20220419213244.2104972-3-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419213244.2104972-1-void@manifault.com>
References: <20220419213244.2104972-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

test_cpu.c includes testcases that validate the cgroup cpu controller.
This patch adds a new testcase called test_cgcpu_stats() that verifies the
expected behavior of the cpu.stat interface. In doing so, we define a
new hog_cpus_timed() function which takes a cpu_hog_func_param struct
that configures how many CPUs it uses, and how long it runs. Future
patches will also spawn threads that hog CPUs, so this function will
eventually serve those use-cases as well.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/cgroup/cgroup_util.h |   3 +
 tools/testing/selftests/cgroup/test_cpu.c    | 105 +++++++++++++++++++
 2 files changed, 108 insertions(+)

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
index 4faa279bbab3..57f6308b1ef4 100644
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
+	long runtime_nsec;
+};
+
 /*
  * This test creates two nested cgroups with and without enabling
  * the cpu controller.
@@ -70,12 +78,109 @@ static int test_cgcpu_subtree_control(const char *root)
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
+static int hog_cpus_timed(const char *cgroup, void *arg)
+{
+	const struct cpu_hog_func_param *param =
+		(struct cpu_hog_func_param *)arg;
+	long nsecs_remaining = param->runtime_nsec;
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
+	while (nsecs_remaining > 0) {
+		long nsecs_so_far;
+		struct timespec ts = {
+			.tv_sec = nsecs_remaining / NSEC_PER_SEC,
+			.tv_nsec = nsecs_remaining % NSEC_PER_SEC,
+		};
+
+		ret = nanosleep(&ts, NULL);
+		if (ret && errno != EINTR)
+			return ret;
+
+		ret = clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts);
+		if (ret != 0)
+			return ret;
+
+		nsecs_so_far = ts.tv_sec * NSEC_PER_SEC + ts.tv_nsec;
+		nsecs_remaining = nsecs_so_far > param->runtime_nsec
+			? 0
+			: param->runtime_nsec - nsecs_so_far;
+	}
+
+	return 0;
+}
+
+/*
+ * Creates a cpu cgroup, burns a CPU for a few quanta, and verifies that
+ * cpu.stats shows the expected output.
+ */
+static int test_cgcpu_stats(const char *root)
+{
+	int ret = KSFT_FAIL;
+	long usage_usec, user_usec, system_usec;
+	long usage_seconds = 2;
+	long expected_usage_usec = usage_seconds * USEC_PER_SEC;
+	char *cgcpu;
+
+	cgcpu = cg_name(root, "cgcpu_test");
+	if (!cgcpu)
+		goto cleanup;
+
+	if (cg_create(cgcpu))
+		goto cleanup;
+
+	usage_usec = cg_read_key_long(cgcpu, "cpu.stat", "usage_usec");
+	user_usec = cg_read_key_long(cgcpu, "cpu.stat", "user_usec");
+	system_usec = cg_read_key_long(cgcpu, "cpu.stat", "system_usec");
+	if (usage_usec != 0 || user_usec != 0 || system_usec != 0)
+		goto cleanup;
+
+	struct cpu_hog_func_param param = {
+		.nprocs = 1,
+		.runtime_nsec = usage_seconds * NSEC_PER_SEC,
+	};
+	if (cg_run(cgcpu, hog_cpus_timed, (void *)&param))
+		goto cleanup;
+
+	usage_usec = cg_read_key_long(cgcpu, "cpu.stat", "usage_usec");
+	user_usec = cg_read_key_long(cgcpu, "cpu.stat", "user_usec");
+	if (user_usec <= 0)
+		goto cleanup;
+
+	if (!values_close(usage_usec, expected_usage_usec, 1))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_destroy(cgcpu);
+	free(cgcpu);
+
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct cgcpu_test {
 	int (*fn)(const char *root);
 	const char *name;
 } tests[] = {
 	T(test_cgcpu_subtree_control),
+	T(test_cgcpu_stats),
 };
 #undef T
 
-- 
2.30.2

