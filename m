Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C2050C9EC
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 14:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbiDWMfO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 08:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiDWMfN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 08:35:13 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170E919F401;
        Sat, 23 Apr 2022 05:32:16 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d9so7269124qty.12;
        Sat, 23 Apr 2022 05:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvNakASAT0LQEom1pxuFRLCVN5J4xhsFoT1WWqDLdJ0=;
        b=K5IYAKQDeY5RyU0hyjF0+mojv39hz0nqCbupmhNJM0KRRM0CRm0XXOJv1RSWbV/PV5
         k3xCP8lxs30/FwgzotBbAewwBwDwJduVobc60Fym4pZotiH/AZU3aPgCU6w/5nAZnodB
         Ep9xOunxArkVcEgrB0n9a1G9EunTvcY3yst5lm5CUxmG/hJxyX7/X7QlY2Bwgf41KjPY
         jfx/HPVQTQbjCxjOFRT1c+sWtsFW/2VIU5Y1Xx9NfH+lKxXs1L6kFX722iR7LJjDkeJP
         UpO9asrki5EGRag2NmwfOnZZ/d4sxczck5WNiZOA0t5Ncy5p43MK1CftyLdGJfuDlJw2
         Xkmg==
X-Gm-Message-State: AOAM532vvnCTl99+tYs6mSbqoOZihBHT0yvGCvJ5v4xpGpQwuJJnocuI
        78LaY5S85MnRS3etxpKBzuU=
X-Google-Smtp-Source: ABdhPJyUQeEqywTEkrEGvntcVlCDW12Rj90hPx4Pp/Ph7Obok0XhKQPR9Lkn9zVWU7VekCQVhPgG3g==
X-Received: by 2002:ac8:7f0b:0:b0:2f3:643e:23da with SMTP id f11-20020ac87f0b000000b002f3643e23damr27787qtk.569.1650717135146;
        Sat, 23 Apr 2022 05:32:15 -0700 (PDT)
Received: from localhost (fwdproxy-ash-014.fbsv.net. [2a03:2880:20ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id t80-20020a37aa53000000b0069ec218b786sm2270325qke.126.2022.04.23.05.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 05:32:14 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/5] cgroup: Adding test_cpucg_nested_weight_overprovisioned() testcase
Date:   Sat, 23 Apr 2022 05:30:50 -0700
Message-Id: <20220423123053.2982931-1-void@manifault.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The cgroup cpu controller tests in
tools/testing/selftests/cgroup/test_cpu.c have some testcases that validate
the expected behavior of setting cpu.weight on cgroups, and then hogging
CPUs. What is still missing from the suite is a testcase that validates
nested cgroups. This patch adds test_cpucg_nested_weight_overprovisioned(),
which validates that a parent's cpu.weight will override its children if
they overcommit a host, and properly protect any sibling groups of that
parent.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/cgroup/test_cpu.c | 122 ++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index 64f9ce91c992..fc90b4d0feb9 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -403,6 +403,127 @@ static int test_cpucg_weight_underprovisioned(const char *root)
 			underprovision_validate);
 }
 
+/*
+ * First, this test creates the following hierarchy:
+ * A
+ * A/B     cpu.weight = 1000
+ * A/C     cpu.weight = 1000
+ * A/C/D   cpu.weight = 5000
+ * A/C/E   cpu.weight = 5000
+ *
+ * A separate process is then created for each leaf, which spawn nproc threads
+ * that burn a CPU for a few seconds.
+ *
+ * Once all of those processes have exited, we verify that each of the leaf
+ * cgroups have roughly the same usage from cpu.stat.
+ */
+static int
+test_cpucg_nested_weight_overprovisioned(const char *root)
+{
+	int ret = KSFT_FAIL, i;
+	char *parent = NULL, *child = NULL;
+	struct cpu_hogger leaf[3] = {NULL};
+	long nested_leaf_usage, child_usage;
+	int nprocs = get_nprocs();
+
+	parent = cg_name(root, "cpucg_test");
+	child = cg_name(parent, "cpucg_child");
+	if (!parent || !child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+	if (cg_write(parent, "cgroup.subtree_control", "+cpu"))
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+	if (cg_write(child, "cgroup.subtree_control", "+cpu"))
+		goto cleanup;
+	if (cg_write(child, "cpu.weight", "1000"))
+		goto cleanup;
+
+	for (i = 0; i < ARRAY_SIZE(leaf); i++) {
+		const char *ancestor;
+		long weight;
+
+		if (i == 0) {
+			ancestor = parent;
+			weight = 1000;
+		} else {
+			ancestor = child;
+			weight = 5000;
+		}
+		leaf[i].cgroup = cg_name_indexed(ancestor, "cpucg_leaf", i);
+		if (!leaf[i].cgroup)
+			goto cleanup;
+
+		if (cg_create(leaf[i].cgroup))
+			goto cleanup;
+
+		if (cg_write_numeric(leaf[i].cgroup, "cpu.weight", weight))
+			goto cleanup;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(leaf); i++) {
+		pid_t pid;
+		struct cpu_hog_func_param param = {
+			.nprocs = nprocs,
+			.ts = {
+				.tv_sec = 10,
+				.tv_nsec = 0,
+			},
+			.clock_type = CPU_HOG_CLOCK_WALL,
+		};
+
+		pid = cg_run_nowait(leaf[i].cgroup, hog_cpus_timed,
+				(void *)&param);
+		if (pid <= 0)
+			goto cleanup;
+		leaf[i].pid = pid;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(leaf); i++) {
+		int retcode;
+
+		waitpid(leaf[i].pid, &retcode, 0);
+		if (!WIFEXITED(retcode))
+			goto cleanup;
+		if (WEXITSTATUS(retcode))
+			goto cleanup;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(leaf); i++) {
+		leaf[i].usage = cg_read_key_long(leaf[i].cgroup,
+				"cpu.stat", "usage_usec");
+		if (leaf[i].usage <= 0)
+			goto cleanup;
+	}
+
+	nested_leaf_usage = leaf[1].usage + leaf[2].usage;
+	if (!values_close(leaf[0].usage, nested_leaf_usage, 15))
+		goto cleanup;
+
+	child_usage = cg_read_key_long(child, "cpu.stat", "usage_usec");
+	if (child_usage <= 0)
+		goto cleanup;
+	if (!values_close(child_usage, nested_leaf_usage, 1))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+cleanup:
+	for (i = 0; i < ARRAY_SIZE(leaf); i++) {
+		cg_destroy(leaf[i].cgroup);
+		free(leaf[i].cgroup);
+	}
+	cg_destroy(child);
+	free(child);
+	cg_destroy(parent);
+	free(parent);
+
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct cpucg_test {
 	int (*fn)(const char *root);
@@ -412,6 +533,7 @@ struct cpucg_test {
 	T(test_cpucg_stats),
 	T(test_cpucg_weight_overprovisioned),
 	T(test_cpucg_weight_underprovisioned),
+	T(test_cpucg_nested_weight_overprovisioned),
 };
 #undef T
 
-- 
2.30.2

