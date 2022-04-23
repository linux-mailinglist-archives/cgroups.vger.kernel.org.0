Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A7350C9ED
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 14:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiDWMfQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 08:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbiDWMfO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 08:35:14 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE19819FA93;
        Sat, 23 Apr 2022 05:32:17 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id 204so7657218qkg.5;
        Sat, 23 Apr 2022 05:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RfF93pFWroVkLzTdcDyVYc0Jv8i0fqg3Dx4eMfuJd68=;
        b=6zNbcuy0cZvye2vcmFWbAM8eJkd1qRKbaHUCDbHsEf5LybsSNLPAnY1Ti+Rv5BHVPl
         L/b6R/BDNquNfCBgu3qXYdSkkJxSu8eunYDtquoNo6Y8m2lbpwea6EyJHrB38LvWVtEI
         aEIIoB/h9noizaBb7emUMJlXErGM50b/1f4zIzBZ0sLUwTlkHt7Ii55cN2KQVFgp56Nz
         orMIKzPmMWbkSu4UZJErpJVLpoNKnxWZ5YLJwSUbhDIpGwZMiT5LhTHtaw2tc2QEqsb9
         NhOdsHAbGwPE1nqkxp0aPFemAexnzyrmpgYY6OQkjxKgVwMdPR8DnNT/pNS5TNTKtzOc
         l5cQ==
X-Gm-Message-State: AOAM531rji8ozbcP0Oajnj2n9vy4kj0m46XRwxlW3v1OVpSpdHZJVC72
        49Cn8WgWrJhQqDKmtzb37/Q=
X-Google-Smtp-Source: ABdhPJx+XXDSVirAu1kyW61lzxcejn5ovL3SULX6JUroOFF2Op4s5Ax8JfcIZ6mw2LOJES2sJl0oyw==
X-Received: by 2002:ae9:dfc3:0:b0:69c:41f2:c067 with SMTP id t186-20020ae9dfc3000000b0069c41f2c067mr5426000qkf.299.1650717136929;
        Sat, 23 Apr 2022 05:32:16 -0700 (PDT)
Received: from localhost (fwdproxy-ash-012.fbsv.net. [2a03:2880:20ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id s19-20020a05622a179300b002e1ceeb21d0sm2905666qtk.97.2022.04.23.05.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 05:32:16 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/5] cgroup: Add test_cpucg_max() testcase
Date:   Sat, 23 Apr 2022 05:30:52 -0700
Message-Id: <20220423123053.2982931-3-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220423123053.2982931-1-void@manifault.com>
References: <20220423123053.2982931-1-void@manifault.com>
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

The cgroup cpu controller test suite has a number of testcases that
validate the expected behavior of the cpu.weight knob, but none for
cpu.max. This testcase fixes that by adding a testcase for cpu.max as well.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/cgroup/test_cpu.c | 54 +++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index de6289814c23..715922c15c78 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -564,6 +564,59 @@ test_cpucg_nested_weight_underprovisioned(const char *root)
 	return run_cpucg_nested_weight_test(root, false);
 }
 
+/*
+ * This test creates a cgroup with some maximum value within a period, and
+ * verifies that a process in the cgroup is not overscheduled.
+ */
+static int test_cpucg_max(const char *root)
+{
+	int ret = KSFT_FAIL;
+	long usage_usec, user_usec;
+	long usage_seconds = 1;
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
+	if (cg_write(cpucg, "cpu.max", "1000"))
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
+	if (cg_run(cpucg, hog_cpus_timed, (void *)&param))
+		goto cleanup;
+
+	usage_usec = cg_read_key_long(cpucg, "cpu.stat", "usage_usec");
+	user_usec = cg_read_key_long(cpucg, "cpu.stat", "user_usec");
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
+	cg_destroy(cpucg);
+	free(cpucg);
+
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct cpucg_test {
 	int (*fn)(const char *root);
@@ -575,6 +628,7 @@ struct cpucg_test {
 	T(test_cpucg_weight_underprovisioned),
 	T(test_cpucg_nested_weight_overprovisioned),
 	T(test_cpucg_nested_weight_underprovisioned),
+	T(test_cpucg_max),
 };
 #undef T
 
-- 
2.30.2

