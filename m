Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7CB507BF3
	for <lists+cgroups@lfdr.de>; Tue, 19 Apr 2022 23:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358004AbiDSVfp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Apr 2022 17:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346877AbiDSVfn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Apr 2022 17:35:43 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1222D27FEA;
        Tue, 19 Apr 2022 14:33:00 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d14so5328934qtw.5;
        Tue, 19 Apr 2022 14:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8G/ibBIrn0G3wVr557AIgTZhD6q0eUwk63lcPEE0+k=;
        b=lKoLNV1zNT5kktAzElOnCutYNXYOsWVcnzmK0HOjKxKiE83QiErA0aWih+IsEgXIAM
         A0ksdo4XQ+EQ7VfBe0dOWm0/BwUoS42qDZ9HjTCllamS6dzDChRnQmPYu/AzirI6Eapd
         YMnEjvhGSK1VKnmGfBEGwlw/sHNQh1aM6KfFPoEmFJGgaQLJcwaS4B3MGZm+9EMH0qBk
         BMbngJgYQLKG7tZv0OEp1cEtd12euLkETzgk4Ik/kXJSdxQjuIYjzFRL4ParOSGgGM7R
         fQnaxQiKYc9ELkeQYy8RrNSaE7r5I/49/ZKBq74UDm7uAOYYM5YTV+HHkV+1VBi8k5hG
         4jUA==
X-Gm-Message-State: AOAM532LVdsfs891go7KV9rlH+HiCsJ4UtPpBR86YT8BypLpdXR57gSI
        OxH63NsSaIFAxEu8KFQKVF4=
X-Google-Smtp-Source: ABdhPJwgWeJHL84yhLP90qLNwzu1Cx7Zvu+0rEnKk4A5dDJ/lDGBYQK3s4PNcKjjgeAHG7CpmnWhvw==
X-Received: by 2002:a05:622a:8:b0:2e1:cb36:9244 with SMTP id x8-20020a05622a000800b002e1cb369244mr11781499qtw.93.1650403979018;
        Tue, 19 Apr 2022 14:32:59 -0700 (PDT)
Received: from localhost (fwdproxy-ash-007.fbsv.net. [2a03:2880:20ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id u13-20020a05622a010d00b002f0c6664db1sm628991qtw.49.2022.04.19.14.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:32:58 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 1/4] cgroup: Add new test_cpu.c test suite in cgroup selftests
Date:   Tue, 19 Apr 2022 14:32:42 -0700
Message-Id: <20220419213244.2104972-2-void@manifault.com>
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
index 000000000000..4faa279bbab3
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
+static int test_cgcpu_subtree_control(const char *root)
+{
+	char *parent = NULL, *child = NULL, *parent2 = NULL, *child2 = NULL;
+	int ret = KSFT_FAIL;
+
+	// Create two nested cgroups with the cpu controller enabled.
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
+	child = cg_name(parent, "cgcpu_test_child");
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
+	parent2 = cg_name(root, "cgcpu_test_1");
+	if (!parent2)
+		goto cleanup;
+
+	if (cg_create(parent2))
+		goto cleanup;
+
+	child2 = cg_name(parent2, "cgcpu_test_child");
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
+struct cgcpu_test {
+	int (*fn)(const char *root);
+	const char *name;
+} tests[] = {
+	T(test_cgcpu_subtree_control),
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

