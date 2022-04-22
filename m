Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174F550BEDB
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 19:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiDVRkR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 13:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbiDVRkM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 13:40:12 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDA2102CE5;
        Fri, 22 Apr 2022 10:37:07 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id hf18so6028930qtb.0;
        Fri, 22 Apr 2022 10:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYC9LwSf9hKtGt3gL+sG23+M8BOF30E6rBmugyKTlUE=;
        b=VuV2FLTMGQw6Y+kTZhRwh9YDTOVZOZ/JjSPmrQ5Y4KWg/cKqojH3EIznYBo1dofHjH
         +N3AgGOEkzJ/8vciWhqCJEL6PO/7TaNrSTr2oAMkG6IUgpsQN+9Z7E3G3Pv1xCExtFG5
         1KWnmZlfCzf16tPzoMBs2qH0uLjOUDDz/Jf4JR+QAf9Rw/bWeCDXEGDNUreYSEVF1CLF
         HC6ytcqUsiQamJq2RpUFrWdoDeCqDN0aWZkaCLKgqhgCRdgRmA+N3oPoT115lkBPTQL0
         rsL0shQpSWYbGcqZpMEnh8O+7NrDykUjJZdbhkvQhYVLgBNZhbWSPkEVW/tLK/2GP+Md
         DJyg==
X-Gm-Message-State: AOAM530CSKepuE9Vr+ipDFET4B67ho/tThgP4A6zDu7AvWrWqQFBF6QY
        QNt4i0qvokN8txrqvVxdKcQ=
X-Google-Smtp-Source: ABdhPJxV05PtSC4F9XnIhE3tcIEZz63GnTMA8Kee2UaPIk1OJaBtsC1fQSWWCviUoGpDgEs3wOxYoQ==
X-Received: by 2002:ac8:5795:0:b0:2f1:f9cd:4076 with SMTP id v21-20020ac85795000000b002f1f9cd4076mr4002801qta.549.1650648865242;
        Fri, 22 Apr 2022 10:34:25 -0700 (PDT)
Received: from localhost (fwdproxy-ash-116.fbsv.net. [2a03:2880:20ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a0d5500b0069c59fae1a5sm1134798qkl.96.2022.04.22.10.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:34:25 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/4] cgroup: Add new test_cpu.c test suite in cgroup selftests
Date:   Fri, 22 Apr 2022 10:33:49 -0700
Message-Id: <20220422173349.3394844-2-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220422173349.3394844-1-void@manifault.com>
References: <20220422173349.3394844-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The cgroup selftests suite currently contains tests that validate various
aspects of cgroup, such as validating the expected behavior for memory
controllers, the expected behavior of cgroup.procs, etc. There are no tests
that validate the expected behavior of the cgroup cpu controller.

This patch therefore adds a new test_cpu.c file that will contain cpu
controller testcases. The file currently only contains a single testcase
that validates creating nested cgroups with cgroup.subtree_control
including cpu. Future patches will add more sophisticated testcases that
validate functional aspects of the cpu controller.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/cgroup/.gitignore |   1 +
 tools/testing/selftests/cgroup/Makefile   |   2 +
 tools/testing/selftests/cgroup/test_cpu.c | 110 ++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_cpu.c

diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
index be9643ef6285..306ee1b01e72 100644
--- a/tools/testing/selftests/cgroup/.gitignore
+++ b/tools/testing/selftests/cgroup/.gitignore
@@ -4,3 +4,4 @@ test_core
 test_freezer
 test_kmem
 test_kill
+test_cpu
diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 745fe25fa0b9..478217cc1371 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -10,6 +10,7 @@ TEST_GEN_PROGS += test_kmem
 TEST_GEN_PROGS += test_core
 TEST_GEN_PROGS += test_freezer
 TEST_GEN_PROGS += test_kill
+TEST_GEN_PROGS += test_cpu
 
 LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
 
@@ -20,3 +21,4 @@ $(OUTPUT)/test_kmem: cgroup_util.c
 $(OUTPUT)/test_core: cgroup_util.c
 $(OUTPUT)/test_freezer: cgroup_util.c
 $(OUTPUT)/test_kill: cgroup_util.c
+$(OUTPUT)/test_cpu: cgroup_util.c
diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
new file mode 100644
index 000000000000..a724bff00d07
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <linux/limits.h>
+#include <stdio.h>
+
+#include "../kselftest.h"
+#include "cgroup_util.h"
+
+/*
+ * This test creates two nested cgroups with and without enabling
+ * the cpu controller.
+ */
+static int test_cpucg_subtree_control(const char *root)
+{
+	char *parent = NULL, *child = NULL, *parent2 = NULL, *child2 = NULL;
+	int ret = KSFT_FAIL;
+
+	// Create two nested cgroups with the cpu controller enabled.
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
+	child = cg_name(parent, "cpucg_test_child");
+	if (!child)
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_read_strstr(child, "cgroup.controllers", "cpu"))
+		goto cleanup;
+
+	// Create two nested cgroups without enabling the cpu controller.
+	parent2 = cg_name(root, "cpucg_test_1");
+	if (!parent2)
+		goto cleanup;
+
+	if (cg_create(parent2))
+		goto cleanup;
+
+	child2 = cg_name(parent2, "cpucg_test_child");
+	if (!child2)
+		goto cleanup;
+
+	if (cg_create(child2))
+		goto cleanup;
+
+	if (!cg_read_strstr(child2, "cgroup.controllers", "cpu"))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_destroy(child);
+	free(child);
+	cg_destroy(child2);
+	free(child2);
+	cg_destroy(parent);
+	free(parent);
+	cg_destroy(parent2);
+	free(parent2);
+
+	return ret;
+}
+
+#define T(x) { x, #x }
+struct cpucg_test {
+	int (*fn)(const char *root);
+	const char *name;
+} tests[] = {
+	T(test_cpucg_subtree_control),
+};
+#undef T
+
+int main(int argc, char *argv[])
+{
+	char root[PATH_MAX];
+	int i, ret = EXIT_SUCCESS;
+
+	if (cg_find_unified_root(root, sizeof(root)))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	if (cg_read_strstr(root, "cgroup.subtree_control", "cpu"))
+		if (cg_write(root, "cgroup.subtree_control", "+cpu"))
+			ksft_exit_skip("Failed to set cpu controller\n");
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
2.30.2

