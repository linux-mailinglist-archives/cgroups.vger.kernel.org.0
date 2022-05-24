Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFB6532EF7
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 18:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbiEXQaQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 12:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiEXQaP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 12:30:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7ED38D95;
        Tue, 24 May 2022 09:30:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C2F641F91F;
        Tue, 24 May 2022 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653409811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TImBZ6/Xs1On34ZPG5L5wJ0F84vjqxu5LZFuNx3+3N8=;
        b=cUM6sQMiAS+T+jJH5GaZ2WL/vRUwXMV9p+YMI81jj/gzuGjLJ8S7g1TRdZj9qNixexgu3h
        q038pKLE0F292Oi/zJ2oHPrzyInRtrERWYhsgRxN69D238g+7y1RzuiJr7HM29Dx7pBSyL
        p7adX906CxWWY1HTXLLnvf2vspCZoZs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8757613B1E;
        Tue, 24 May 2022 16:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6PT9HxMIjWJaWgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 24 May 2022 16:30:11 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v3 1/5] selftests: memcg: Fix compilation
Date:   Tue, 24 May 2022 18:29:51 +0200
Message-Id: <20220524162955.8635-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220524162955.8635-1-mkoutny@suse.com>
References: <20220524162955.8635-1-mkoutny@suse.com>
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

Fixes: 72b1e03aa725 ("cgroup: account for memory_localevents in test_memcg_oom_group_leaf_events()")
Signed-off-by: Michal Koutný <mkoutny@suse.com>
Reviewed-by: David Vernet <void@manifault.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 .../selftests/cgroup/test_memcontrol.c        | 25 +++++++++++--------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 6ab94317c87b..c012db9d07d6 100644
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
+		goto cleanup;
 
 	if (kill(safe_pid, SIGKILL))
 		goto cleanup;
 
+	ret = KSFT_PASS;
+
 cleanup:
 	if (memcg)
 		cg_destroy(memcg);
-- 
2.35.3

