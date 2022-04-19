Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBA3507BF8
	for <lists+cgroups@lfdr.de>; Tue, 19 Apr 2022 23:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358025AbiDSVgA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Apr 2022 17:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358024AbiDSVfz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Apr 2022 17:35:55 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B7037023;
        Tue, 19 Apr 2022 14:33:06 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id f22so4061948qtp.13;
        Tue, 19 Apr 2022 14:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d/Ucq9GPy/+6d7dpHjxvay/RmHJPJU/gWJXLA2RvJP4=;
        b=f3R6/pepxyNxbeQJmifygfFFshnz/ZL8HqiMWcfrI4eJOAMjEbJHMQqLf/6zLAnqsg
         b2gtrTgvmZ/JBgv36nIy6A9qqR+jvSqT1RZ0bRK3MRtlqPdkHF65Bn7LT3PfrZsWo1UW
         22JtaKAHVtonbwht2IbWZrRw+BojAOrr9/e98ECNOddWwhNQVM+DLa3MKCVz5/riP7cj
         kwV3KVCeDav06zy+dT/IAdyOxWdKALTfi1n4KvLZRybVXRFT39QE91AlQlUQRkADKh6s
         qtLit6Zbd7u0LTx+vAfeq2bxoUoRGyqbmmIpSPucPCHkgcdp2sItNWKp0oPkkcyA7EM+
         IIHA==
X-Gm-Message-State: AOAM532uGEL0ZGcmQosA2kojZqOkFTo7cUVvVjfqghLTlNIyunpVM4Ty
        QURgEHdU+Sf7ZJWJQjBEhYw=
X-Google-Smtp-Source: ABdhPJyviHhLP1ZxOY8SzwMXUDlMghJ5K2SboMxk2Hjkom+7xsrW91sCo9uwMIzz4TeiwF7LkZBZoQ==
X-Received: by 2002:ac8:1191:0:b0:2ed:bb6:ab07 with SMTP id d17-20020ac81191000000b002ed0bb6ab07mr12064899qtj.418.1650403985357;
        Tue, 19 Apr 2022 14:33:05 -0700 (PDT)
Received: from localhost (fwdproxy-ash-022.fbsv.net. [2a03:2880:20ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id b22-20020a05620a0f9600b0069e8ab5034dsm558131qkn.1.2022.04.19.14.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:33:05 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 4/4] cgroup: Add test_cgcpu_weight_underprovisioned() testcase
Date:   Tue, 19 Apr 2022 14:32:45 -0700
Message-Id: <20220419213244.2104972-5-void@manifault.com>
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
This patch adds a new testcase called test_cgcpu_weight_underprovisioned()
that verifies that processes with different cpu.weight that are all running
on an underprovisioned system, still get roughly the same amount of cpu
time.

Because test_cgcpu_weight_underprovisioned() is very similar to
test_cgcpu_weight_overprovisioned(), this patch also pulls the common logic
into a separate helper function that is invoked from both testcases, and
which uses function pointers to invoke the unique portions of the
testcases.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/cgroup/test_cpu.c | 149 +++++++++++++++++-----
 1 file changed, 114 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index 2afac9f9e1e2..7adeadba88c4 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -19,6 +19,12 @@ enum hog_clock_type {
 	CPU_HOG_CLOCK_WALL,
 };
 
+struct cpu_hogger {
+	char *cgroup;
+	pid_t pid;
+	long usage;
+};
+
 struct cpu_hog_func_param {
 	int nprocs;
 	long runtime_nsec;
@@ -198,31 +204,15 @@ static int test_cgcpu_stats(const char *root)
 	return ret;
 }
 
-/*
- * First, this test creates the following hierarchy:
- * A
- * A/B     cpu.weight = 50
- * A/C     cpu.weight = 100
- * A/D     cpu.weight = 150
- *
- * A separate process is then created for each child cgroup which spawns as
- * many threads as there are cores, and hogs each CPU as much as possible
- * for some time interval.
- *
- * Once all of the children have exited, we verify that each child cgroup
- * was given proportional runtime as informed by their cpu.weight.
- */
-static int test_cgcpu_weight_overprovisioned(const char *root)
+static int
+run_cgcpu_weight_test(
+		const char *root,
+		pid_t (*spawn_child)(const struct cpu_hogger *child),
+		int (*validate)(const struct cpu_hogger *children, int num_children))
 {
-	struct child {
-		char *cgroup;
-		pid_t pid;
-		long usage;
-	};
 	int ret = KSFT_FAIL, i;
 	char *parent = NULL;
-	struct child children[3] = {NULL};
-	long usage_seconds = 10;
+	struct cpu_hogger children[3] = {NULL};
 
 	parent = cg_name(root, "cgcpu_test_0");
 	if (!parent)
@@ -248,13 +238,7 @@ static int test_cgcpu_weight_overprovisioned(const char *root)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(children); i++) {
-		struct cpu_hog_func_param param = {
-			.nprocs = get_nprocs(),
-			.runtime_nsec = usage_seconds * NSEC_PER_SEC,
-			.clock_type = CPU_HOG_CLOCK_WALL,
-		};
-		pid_t pid = cg_run_nowait(children[i].cgroup, hog_cpus_timed,
-				(void *)&param);
+		pid_t pid = spawn_child(&children[i]);
 		if (pid <= 0)
 			goto cleanup;
 		children[i].pid = pid;
@@ -274,7 +258,43 @@ static int test_cgcpu_weight_overprovisioned(const char *root)
 		children[i].usage = cg_read_key_long(children[i].cgroup,
 				"cpu.stat", "usage_usec");
 
-	for (i = 0; i < ARRAY_SIZE(children) - 1; i++) {
+	if (validate(children, ARRAY_SIZE(children)))
+		goto cleanup;
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
+static pid_t weight_hog_ncpus(const struct cpu_hogger *child, int ncpus)
+{
+	long usage_seconds = 10;
+	struct cpu_hog_func_param param = {
+		.nprocs = ncpus,
+		.runtime_nsec = usage_seconds * NSEC_PER_SEC,
+		.clock_type = CPU_HOG_CLOCK_WALL,
+	};
+	return cg_run_nowait(child->cgroup, hog_cpus_timed, (void *)&param);
+}
+
+static pid_t weight_hog_all_cpus(const struct cpu_hogger *child)
+{
+	return weight_hog_ncpus(child, get_nprocs());
+}
+
+static int
+overprovision_validate(const struct cpu_hogger *children, int num_children)
+{
+	int ret = KSFT_FAIL, i;
+
+	for (i = 0; i < num_children - 1; i++) {
 		long delta;
 
 		if (children[i + 1].usage <= children[i].usage)
@@ -287,16 +307,74 @@ static int test_cgcpu_weight_overprovisioned(const char *root)
 
 	ret = KSFT_PASS;
 cleanup:
-	for (i = 0; i < ARRAY_SIZE(children); i++) {
-		cg_destroy(children[i].cgroup);
-		free(children[i].cgroup);
+	return ret;
+}
+
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
+	return run_cgcpu_weight_test(root, weight_hog_all_cpus,
+			overprovision_validate);
+}
+
+static pid_t weight_hog_one_cpu(const struct cpu_hogger *child)
+{
+	return weight_hog_ncpus(child, 1);
+}
+
+static int
+underprovision_validate(const struct cpu_hogger *children, int num_children)
+{
+	int ret = KSFT_FAIL, i;
+
+	for (i = 0; i < num_children - 1; i++) {
+		if (!values_close(children[i + 1].usage, children[0].usage, 15))
+			goto cleanup;
 	}
-	cg_destroy(parent);
-	free(parent);
 
+	ret = KSFT_PASS;
+cleanup:
 	return ret;
 }
 
+/*
+ * First, this test creates the following hierarchy:
+ * A
+ * A/B     cpu.weight = 50
+ * A/C     cpu.weight = 100
+ * A/D     cpu.weight = 150
+ *
+ * A separate process is then created for each child cgroup which spawns a
+ * single thread that hogs a CPU. The testcase is only run on systems that
+ * have at least one core per-thread in the child processes.
+ *
+ * Once all of the children have exited, we verify that each child cgroup
+ * had roughly the same runtime despite having different cpu.weight.
+ */
+static int test_cgcpu_weight_underprovisioned(const char *root)
+{
+	// Only run the test if there are enough cores to avoid overprovisioning
+	// the system.
+	if (get_nprocs() < 4)
+		return KSFT_SKIP;
+
+	return run_cgcpu_weight_test(root, weight_hog_one_cpu,
+			underprovision_validate);
+}
+
 #define T(x) { x, #x }
 struct cgcpu_test {
 	int (*fn)(const char *root);
@@ -305,6 +383,7 @@ struct cgcpu_test {
 	T(test_cgcpu_subtree_control),
 	T(test_cgcpu_stats),
 	T(test_cgcpu_weight_overprovisioned),
+	T(test_cgcpu_weight_underprovisioned),
 };
 #undef T
 
-- 
2.30.2

