Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E290850C9EB
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 14:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiDWMfO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 08:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiDWMfN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 08:35:13 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127D119F52C;
        Sat, 23 Apr 2022 05:32:17 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id he8so39126qtb.9;
        Sat, 23 Apr 2022 05:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmuV6uC7742vbWxBxz4f2KL4s2GeIfbnuaz1eBVbmx0=;
        b=N+86osPToAoZvQxH6sKRbIeqyR+Lryx5ZEeqlHIFSkPOGPYZwWsgdoLytvDoPI8cqz
         4yWj9tOWXW4vJTMhkuo3gSUHD3nmm1mJf44ag2S4sUer84TAHhGDYgabGTJuDOtOXlSN
         8Otp7UMu1687F9SsgU9XxUEF4iZQMfOIfpAbPilYSuBiGauQw+mArY3bWelDOyQ89HwQ
         5ULrgmtJHF/oCmHEfGzJy3SlycFEdqHnEMGxuZuuScAM2M8x/zMRXsypiCwXr2s8NgYv
         OUi0FJBrhujpRD/s54V7K0GdbM8z4ADRkCS1UrRVoGQaAuAWGlZV06oTPHYErJLNdyBL
         cv7w==
X-Gm-Message-State: AOAM533t+8R8daEXNNy+ij0uHz2FRcDjIGFKmivdixYteFs2791wkX+h
        6orG8b3PS/TnfgoqCVpOjVw=
X-Google-Smtp-Source: ABdhPJwS9rcOlJGz05c30Z0xqlgGEsjuKsWX9+cQAailQviDg+UNOshJs7LESxfAYVxC1O9viCxqFw==
X-Received: by 2002:ac8:7387:0:b0:2f1:eb13:ceb2 with SMTP id t7-20020ac87387000000b002f1eb13ceb2mr6240360qtp.51.1650717136038;
        Sat, 23 Apr 2022 05:32:16 -0700 (PDT)
Received: from localhost (fwdproxy-ash-017.fbsv.net. [2a03:2880:20ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id g19-20020ac87f53000000b002f1c774a4cbsm3036635qtk.12.2022.04.23.05.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 05:32:15 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/5] cgroup: Add test_cpucg_nested_weight_underprovisioned() testcase
Date:   Sat, 23 Apr 2022 05:30:51 -0700
Message-Id: <20220423123053.2982931-2-void@manifault.com>
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

The cgroup cpu controller test suite currently contains a testcase called
test_cpucg_nested_weight_underprovisioned() which verifies the expected
behavior of cpu.weight when applied to nested cgroups. That first testcase
validated the expected behavior when the processes in the leaf cgroups
overcommitted the system. This patch adds a complementary
test_cpucg_nested_weight_underprovisioned() testcase which validates
behavior when those leaf cgroups undercommit the system.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/cgroup/test_cpu.c | 73 ++++++++++++++++++-----
 1 file changed, 57 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index fc90b4d0feb9..de6289814c23 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -403,22 +403,8 @@ static int test_cpucg_weight_underprovisioned(const char *root)
 			underprovision_validate);
 }
 
-/*
- * First, this test creates the following hierarchy:
- * A
- * A/B     cpu.weight = 1000
- * A/C     cpu.weight = 1000
- * A/C/D   cpu.weight = 5000
- * A/C/E   cpu.weight = 5000
- *
- * A separate process is then created for each leaf, which spawn nproc threads
- * that burn a CPU for a few seconds.
- *
- * Once all of those processes have exited, we verify that each of the leaf
- * cgroups have roughly the same usage from cpu.stat.
- */
 static int
-test_cpucg_nested_weight_overprovisioned(const char *root)
+run_cpucg_nested_weight_test(const char *root, bool overprovisioned)
 {
 	int ret = KSFT_FAIL, i;
 	char *parent = NULL, *child = NULL;
@@ -426,6 +412,16 @@ test_cpucg_nested_weight_overprovisioned(const char *root)
 	long nested_leaf_usage, child_usage;
 	int nprocs = get_nprocs();
 
+	if (!overprovisioned) {
+		if (nprocs < 4)
+			/*
+			 * Only run the test if there are enough cores to avoid overprovisioning
+			 * the system.
+			 */
+			return KSFT_SKIP;
+		nprocs /= 4;
+	}
+
 	parent = cg_name(root, "cpucg_test");
 	child = cg_name(parent, "cpucg_child");
 	if (!parent || !child)
@@ -501,9 +497,13 @@ test_cpucg_nested_weight_overprovisioned(const char *root)
 	}
 
 	nested_leaf_usage = leaf[1].usage + leaf[2].usage;
-	if (!values_close(leaf[0].usage, nested_leaf_usage, 15))
+	if (overprovisioned) {
+		if (!values_close(leaf[0].usage, nested_leaf_usage, 15))
+			goto cleanup;
+	} else if (!values_close(leaf[0].usage * 2, nested_leaf_usage, 15))
 		goto cleanup;
 
+
 	child_usage = cg_read_key_long(child, "cpu.stat", "usage_usec");
 	if (child_usage <= 0)
 		goto cleanup;
@@ -524,6 +524,46 @@ test_cpucg_nested_weight_overprovisioned(const char *root)
 	return ret;
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
+	return run_cpucg_nested_weight_test(root, true);
+}
+
+/*
+ * First, this test creates the following hierarchy:
+ * A
+ * A/B     cpu.weight = 1000
+ * A/C     cpu.weight = 1000
+ * A/C/D   cpu.weight = 5000
+ * A/C/E   cpu.weight = 5000
+ *
+ * A separate process is then created for each leaf, which nproc / 4 threads
+ * that burns a CPU for a few seconds.
+ *
+ * Once all of those processes have exited, we verify that each of the leaf
+ * cgroups have roughly the same usage from cpu.stat.
+ */
+static int
+test_cpucg_nested_weight_underprovisioned(const char *root)
+{
+	return run_cpucg_nested_weight_test(root, false);
+}
+
 #define T(x) { x, #x }
 struct cpucg_test {
 	int (*fn)(const char *root);
@@ -534,6 +574,7 @@ struct cpucg_test {
 	T(test_cpucg_weight_overprovisioned),
 	T(test_cpucg_weight_underprovisioned),
 	T(test_cpucg_nested_weight_overprovisioned),
+	T(test_cpucg_nested_weight_underprovisioned),
 };
 #undef T
 
-- 
2.30.2

