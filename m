Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD36526821
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 19:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382396AbiEMRSp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 13:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350593AbiEMRSn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 13:18:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB063B29D;
        Fri, 13 May 2022 10:18:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 70FEF1F96F;
        Fri, 13 May 2022 17:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652462320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUNLA0b9x+opMHbbbhr08H0E2VJuSYLLBACnTDB2Dic=;
        b=jb9MD5Dx2uj8Ra4tPKcdtm21RdiH59On2nRWt3KLR5yIMokq5InGJ0Me7K1WdoDvZBC2ZY
        zWsgYYllnjV6ltlOF3IV5MCvYdvHCVSb7KTJC8uLvviBasGsuJrQ1NRwKajHsCRlyGf4z0
        rPOe2JadH7U6cfMsJOUbH0R9cxIDwUE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E07113B3D;
        Fri, 13 May 2022 17:18:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wCFLCvCSfmIeUgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 13 May 2022 17:18:40 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     void@manifault.com
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, mkoutny@suse.com, roman.gushchin@linux.dev,
        shakeelb@google.com, tj@kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: [PATCH 1/4] selftests: memcg: Fix compilation
Date:   Fri, 13 May 2022 19:18:08 +0200
Message-Id: <20220513171811.730-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220513171811.730-1-mkoutny@suse.com>
References: <20220512174452.tr34tuh4k5jm6qjs@dev0025.ash9.facebook.com>
 <20220513171811.730-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This fixes mis-applied changes from commit 72b1e03aa725 ("cgroup:
account for memory_localevents in test_memcg_oom_group_leaf_events()").

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 .../selftests/cgroup/test_memcontrol.c        | 25 +++++++++++--------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 6ab94317c87b..4958b42201a9 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -1241,7 +1241,16 @@ static int test_memcg_oom_group_leaf_events(const char *root)
 	if (cg_read_key_long(child, "memory.events", "oom_kill ") <= 0)
 		goto cleanup;
 
-	if (cg_read_key_long(parent, "memory.events", "oom_kill ") <= 0)
+	parent_oom_events = cg_read_key_long(
+			parent, "memory.events", "oom_kill ");
+	/*
+	 * If memory_localevents is not enabled (the default), the parent should
+	 * count OOM events in its children groups. Otherwise, it should not
+	 * have observed any events.
+	 */
+	if (has_localevents && parent_oom_events != 0)
+		goto cleanup;
+	else if (!has_localevents && parent_oom_events <= 0)
 		goto cleanup;
 
 	ret = KSFT_PASS;
@@ -1349,20 +1358,14 @@ static int test_memcg_oom_group_score_events(const char *root)
 	if (!cg_run(memcg, alloc_anon, (void *)MB(100)))
 		goto cleanup;
 
-	parent_oom_events = cg_read_key_long(
-			parent, "memory.events", "oom_kill ");
-	/*
-	 * If memory_localevents is not enabled (the default), the parent should
-	 * count OOM events in its children groups. Otherwise, it should not
-	 * have observed any events.
-	 */
-	if ((has_localevents && parent_oom_events == 0) ||
-	     parent_oom_events > 0)
-		ret = KSFT_PASS;
+	if (cg_read_key_long(memcg, "memory.events", "oom_kill ") != 3)
+		FAIL(cleanup);
 
 	if (kill(safe_pid, SIGKILL))
 		goto cleanup;
 
+	ret = KSFT_PASS;
+
 cleanup:
 	if (memcg)
 		cg_destroy(memcg);
-- 
2.35.3

