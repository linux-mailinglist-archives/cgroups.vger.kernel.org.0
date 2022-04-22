Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7F750BC52
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 17:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449623AbiDVQAr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 12:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445236AbiDVQAo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 12:00:44 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F72D5DA7D;
        Fri, 22 Apr 2022 08:57:50 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id kj29so1732538qvb.8;
        Fri, 22 Apr 2022 08:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B3B1dGnzOmkr3L8TkEmHq2fqLk42IndbueuBAtAlDZs=;
        b=n6qQIsjGcz8EUS1w/9x585HqxDwKbOrOzYf9+ohpG/Iylj4DfCp6Dnmj6hr1D+iOzt
         2TDoX8/jpW5v/WErpRxJ6ZCZ+Ke83aXylH4/Rppg9C+iU8DT8eQDMlsf3ail4lPMuMGS
         qm6NJwt92L6KrXpWBZGnVeU6ISXaOojm7Xx6IJwra9Iqd8i0AmcR6l9Zf4L2gUB3d8ep
         F72mhsiJz8yZdzE/b3EQpB496KRrwKCN6A3ZkzFJxFPR2QuNtUhHLxPJVEjVeI2a+UK2
         l25k38gl0juczRdFI3E0e6/H7jyrd33Pt4bodmsLyesm5eH2mir3kXgT8shQj6oO1/yZ
         3AGw==
X-Gm-Message-State: AOAM533d/jPnewfBJE3EhPjWuMe5PAdtX2jPEZlprx1plYSG4abJxeIV
        Lr3HT2vePNF3sw/dGd7fI3w=
X-Google-Smtp-Source: ABdhPJwkKpkXUXCGxEyQQ7dOCDVgeo3GrLKYQUje6jc+8FcwPX60dYm6Q9j05eHfCzT3CfeDA+rTMQ==
X-Received: by 2002:a05:6214:2a8e:b0:443:8a10:c1ca with SMTP id jr14-20020a0562142a8e00b004438a10c1camr3917627qvb.88.1650643069480;
        Fri, 22 Apr 2022 08:57:49 -0700 (PDT)
Received: from localhost (fwdproxy-ash-011.fbsv.net. [2a03:2880:20ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id f11-20020a05620a12eb00b0069c88d15b6asm1043746qkl.68.2022.04.22.08.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:57:49 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com, void@manifault.com
Subject: [PATCH 3/5] cgroup: Account for memory_localevents in test_memcg_oom_group_leaf_events()
Date:   Fri, 22 Apr 2022 08:57:27 -0700
Message-Id: <20220422155728.3055914-4-void@manifault.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220422155728.3055914-1-void@manifault.com>
References: <20220422155728.3055914-1-void@manifault.com>
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
---
 .../testing/selftests/cgroup/test_memcontrol.c  | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index ea2fd27e52df..d88e0ca3f3d1 100644
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
@@ -1128,7 +1130,15 @@ static int test_memcg_oom_group_leaf_events(const char *root)
 	if (cg_read_key_long(child, "memory.events", "oom_kill ") <= 0)
 		goto cleanup;
 
-	if (cg_read_key_long(parent, "memory.events", "oom_kill ") <= 0)
+	parent_oom_events = cg_read_key_long(
+			parent, "memory.events", "oom_kill ");
+	// If memory_localevents is not enabled (the default), the parent should
+	// count OOM events in its children groups. Otherwise, it should not
+	// have observed any events.
+	if (has_localevents) {
+		if (parent_oom_events != 0)
+			goto cleanup;
+	} else if (parent_oom_events <= 0)
 		goto cleanup;
 
 	ret = KSFT_PASS;
@@ -1298,6 +1308,11 @@ int main(int argc, char **argv)
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

