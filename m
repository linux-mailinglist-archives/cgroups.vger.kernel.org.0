Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDF250CC0C
	for <lists+cgroups@lfdr.de>; Sat, 23 Apr 2022 17:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiDWQAO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Apr 2022 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbiDWQAJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 23 Apr 2022 12:00:09 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79955115D;
        Sat, 23 Apr 2022 08:57:12 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id hf18so7622929qtb.0;
        Sat, 23 Apr 2022 08:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Tpzhq0+TI5H5bdvK5Vbm+VLYv/+B/98xqWutaPHg68=;
        b=YalIeLBAMpRNzq8xlnQ2CIEV933BYDUGRMwJlLIrAfPD5SjOv77i8IYwxj3s9JBJYr
         OKgnL3MJxmopPCgecn9FLF76gXTfJFzDCZFPVu1HUrW5N7RClSB9/Cn3cXI7u4ppdeGq
         7vPkNDWpvExDHO/fsz4OBoYkgdduEXQKJi49PaOUi6nt2uRl4HEWFGjO1wkVZYYnnxQj
         GR0kK5qKwE4sYVmx+WrkSCiBGNzxU6TBpuOx5rQd8JFMNjQnDRtm/2scq2Q9HKSlUEt9
         54OYRPOQhqm7P9XxFLnqLGKqo7XWPVQ4N9QNTaffaKufAbUpljlYaiMnbFLCWL4N7ycy
         awJg==
X-Gm-Message-State: AOAM531E6Uv/D2C2hd9bU7qcQNdC+xhcXdjUO2bPmEkqVtp3mWiBLydA
        FoP4JU19Cs4expT117FgOGU=
X-Google-Smtp-Source: ABdhPJy3crThvLR/oO0Mz5YJCL0+y4Sy/Jx7i2E9UGDNE2Y8oLiSfFfMWXH4+Nf8j3wVjv8GhAHcBA==
X-Received: by 2002:ac8:7a8a:0:b0:2f1:de6a:c044 with SMTP id x10-20020ac87a8a000000b002f1de6ac044mr6873334qtr.243.1650729431500;
        Sat, 23 Apr 2022 08:57:11 -0700 (PDT)
Received: from localhost (fwdproxy-ash-006.fbsv.net. [2a03:2880:20ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id w15-20020ac857cf000000b002f33f220c76sm2959583qta.32.2022.04.23.08.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 08:57:11 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com, void@manifault.com
Subject: [PATCH v2 3/5] cgroup: Account for memory_localevents in test_memcg_oom_group_leaf_events()
Date:   Sat, 23 Apr 2022 08:56:20 -0700
Message-Id: <20220423155619.3669555-4-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220423155619.3669555-1-void@manifault.com>
References: <20220423155619.3669555-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The test_memcg_oom_group_leaf_events() testcase in the cgroup memcg tests
validates that processes in a group that perform allocations exceeding
memory.oom.group are killed. It also validates that the
memory.events.oom_kill events are properly propagated in this case.  Commit
06e11c907ea4 ("kselftests: memcg: update the oom group leaf events test")
fixed test_memcg_oom_group_leaf_events() to account for the fact that the
memory.events.oom_kill events in a child cgroup is propagated up to its
parent. This behavior can actually be configured by the memory_localevents
mount option, so this patch updates the testcase to properly account for
the possible presence of this mount option.

Signed-off-by: David Vernet <void@manifault.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 .../selftests/cgroup/test_memcontrol.c        | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index d37e8dfb1248..e899b3f28c22 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -21,6 +21,7 @@
 #include "../kselftest.h"
 #include "cgroup_util.h"
 
+static bool has_localevents;
 static bool has_recursiveprot;
 
 /*
@@ -1091,6 +1092,7 @@ static int test_memcg_oom_group_leaf_events(const char *root)
 {
 	int ret = KSFT_FAIL;
 	char *parent, *child;
+	long parent_oom_events;
 
 	parent = cg_name(root, "memcg_test_0");
 	child = cg_name(root, "memcg_test_0/memcg_test_1");
@@ -1128,10 +1130,16 @@ static int test_memcg_oom_group_leaf_events(const char *root)
 	if (cg_read_key_long(child, "memory.events", "oom_kill ") <= 0)
 		goto cleanup;
 
-	if (cg_read_key_long(parent, "memory.events", "oom_kill ") <= 0)
-		goto cleanup;
-
-	ret = KSFT_PASS;
+	parent_oom_events = cg_read_key_long(
+			parent, "memory.events", "oom_kill ");
+	/*
+	 * If memory_localevents is not enabled (the default), the parent should
+	 * count OOM events in its children groups. Otherwise, it should not
+	 * have observed any events.
+	 */
+	if ((has_localevents && parent_oom_events == 0) ||
+	    parent_oom_events > 0)
+		ret = KSFT_PASS;
 
 cleanup:
 	if (child)
@@ -1298,6 +1306,11 @@ int main(int argc, char **argv)
 		ksft_exit_skip("Failed to query cgroup mount option\n");
 	has_recursiveprot = proc_status;
 
+	proc_status = proc_mount_contains("memory_localevents");
+	if (proc_status < 0)
+		ksft_exit_skip("Failed to query cgroup mount option\n");
+	has_localevents = proc_status;
+
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		switch (tests[i].fn(root)) {
 		case KSFT_PASS:
-- 
2.30.2

