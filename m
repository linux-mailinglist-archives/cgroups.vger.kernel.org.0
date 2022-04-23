Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9032C50C9F5
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 14:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbiDWMfQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 08:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbiDWMfP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 08:35:15 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F6F1A0B01;
        Sat, 23 Apr 2022 05:32:18 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id bz24so7297521qtb.2;
        Sat, 23 Apr 2022 05:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yElsKBK3uV3FIG02XGPOUL6cQVNqHPl51yiT0znHIN0=;
        b=oZejJCUC/bDG7FwxZDXgCXKZZ0FvGU7PxQpNwJjj1E9DWnPyywNUHExTQqvmBv9XPF
         hKYn487qXGUbjgWwHCYwyOCuJwO6lvZy5+vGtXyMKLG42z2cqJsSfIZ9AmO9yeorVQB+
         I6a5X1L7WihQW8kcuIBDdklczeMaGrUTccpRSamCB1rvP1YC+GBUabYjpJJ9etlUCkfp
         +jWLzkYk+v5hRDA5FbfKYOfhqq80c4OC3J+Y6keVTwSzS8wiHgmSwZ5dP1CwoTJO4M88
         5KWhcr+23vG0YlM7XOIU/Ye3S3XzFNzjXTkIYL8VWc/Ub7e87UREnaEtVPuxijPNUds+
         x3bw==
X-Gm-Message-State: AOAM531kw+DY/ADEUitaUJxjZt04KeX+JO5BFWRQSfRzqX4iYpUbZCer
        yx4qY3US6Vt/bhtd06nG0Jk=
X-Google-Smtp-Source: ABdhPJyc3rFST6AL32njAG7Hxk/Tew+Aq2t7XFVjfDdmi8Y7KhS/Y2lwMlUmGOzLV4fwziQ9Qo8prw==
X-Received: by 2002:ac8:5754:0:b0:2e1:eee8:be0b with SMTP id 20-20020ac85754000000b002e1eee8be0bmr6307255qtx.349.1650717137717;
        Sat, 23 Apr 2022 05:32:17 -0700 (PDT)
Received: from localhost (fwdproxy-ash-016.fbsv.net. [2a03:2880:20ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a0e8400b0067b1bcd081csm2131328qkm.66.2022.04.23.05.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 05:32:17 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/5] Add test_cpucg_max_nested() testcase
Date:   Sat, 23 Apr 2022 05:30:53 -0700
Message-Id: <20220423123053.2982931-4-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220423123053.2982931-1-void@manifault.com>
References: <20220423123053.2982931-1-void@manifault.com>
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

The cgroup cpu controller selftests have a test_cpucg_max() testcase
that validates the behavior of the cpu.max knob. Let's also add a
testcase that verifies that the behavior works correctly when set on a
nested cgroup.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/cgroup/test_cpu.c | 63 +++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index 715922c15c78..24020a2c68dc 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -617,6 +617,68 @@ static int test_cpucg_max(const char *root)
 	return ret;
 }
 
+/*
+ * This test verifies that a process inside of a nested cgroup whose parent
+ * group has a cpu.max value set, is properly throttled.
+ */
+static int test_cpucg_max_nested(const char *root)
+{
+	int ret = KSFT_FAIL;
+	long usage_usec, user_usec;
+	long usage_seconds = 1;
+	long expected_usage_usec = usage_seconds * USEC_PER_SEC;
+	char *parent, *child;
+
+	parent = cg_name(root, "cpucg_parent");
+	child = cg_name(parent, "cpucg_child");
+	if (!parent || !child)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+cpu"))
+		goto cleanup;
+
+	if (cg_create(child))
+		goto cleanup;
+
+	if (cg_write(parent, "cpu.max", "1000"))
+		goto cleanup;
+
+	struct cpu_hog_func_param param = {
+		.nprocs = 1,
+		.ts = {
+			.tv_sec = usage_seconds,
+			.tv_nsec = 0,
+		},
+		.clock_type = CPU_HOG_CLOCK_WALL,
+	};
+	if (cg_run(child, hog_cpus_timed, (void *)&param))
+		goto cleanup;
+
+	usage_usec = cg_read_key_long(child, "cpu.stat", "usage_usec");
+	user_usec = cg_read_key_long(child, "cpu.stat", "user_usec");
+	if (user_usec <= 0)
+		goto cleanup;
+
+	if (user_usec >= expected_usage_usec)
+		goto cleanup;
+
+	if (values_close(usage_usec, expected_usage_usec, 95))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
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
@@ -629,6 +691,7 @@ struct cpucg_test {
 	T(test_cpucg_nested_weight_overprovisioned),
 	T(test_cpucg_nested_weight_underprovisioned),
 	T(test_cpucg_max),
+	T(test_cpucg_max_nested),
 };
 #undef T
 
-- 
2.30.2

