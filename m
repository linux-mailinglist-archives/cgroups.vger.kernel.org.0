Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F99F54A203
	for <lists+cgroups@lfdr.de>; Tue, 14 Jun 2022 00:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiFMWTz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jun 2022 18:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiFMWTy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jun 2022 18:19:54 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7A22DAB6;
        Mon, 13 Jun 2022 15:19:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u2so6975627pfc.2;
        Mon, 13 Jun 2022 15:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4oO06QHRa7Tsa9zm7yhX8grvQoZfHrAKdmnnG2E3EUg=;
        b=fCPXCHcn8I7ifG6jP2CRX5lMEiSLQ0x948pBLjar0krjXGUer2CxSlVoo3YDhaOJlZ
         v/BSI2azQubR+V2w++UDp6dqxDVLj9LGRHe5Z8Q/V3VhGW7thltL7zTfgIkeWPne+GjF
         BQmyyvss/72q7MDKOc2vUtkVSRclkdSBTG0awLiN0ZeGG+nZPv+uxNlkjci861MutsOq
         9A3ctAvKRJvTb2MIdx4/R45leHsmgiyxrdPQ8KOanjIJNSHB5jhGspniiWFU0CyD6A2q
         4Vo20uTTcR7DBm577KShMF9oyVgkyJ5l2r9zo3GCDvXT2qicAqeaqv0rr5C8KYt8D1nI
         5bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4oO06QHRa7Tsa9zm7yhX8grvQoZfHrAKdmnnG2E3EUg=;
        b=VnzG12T6pMhG46iM49qVgH6PUwzHONKV4XPXeUpbCaLiG6vggrx6ESSX1+onN43xLW
         wjUqKE5WJ4rKu1BE+bl7RSKSiaK8Gq++OKMNYO3/PC3fB3k6n8/IuB3jC6LNMXloKHRC
         LcVtdfbUP0w2Y9i+Z+D5/jItz6wSf+G154+y+gFGg7Yxt3X/3LSUobiMcZCqZeZA0Ipz
         OjeEilaCe71AP27UEE94/AguuFrecSNCOkoE3U/KW3pZeYvjul9yjuqT+bNwhcuiVubB
         scnegrcPhP60IQ3n/8e8WS4z0ip7bLh3BtQH3uTtHx7EK98ENWC+GmReC2F3A4nZbwgD
         A15w==
X-Gm-Message-State: AOAM532tdBqzUoH9Nqc5l6jxnUgaj39FT+/otlOlFuWEwys8cksUNIIH
        K1HNbuzd2E5X3lnLCJuyZ+k=
X-Google-Smtp-Source: ABdhPJzI888D6k1A7qS0MNiMEh0GoQoEVDwhHcf03ZDwWHMw7tSegtC6pRsf12VELcfKeiXMmpRwSg==
X-Received: by 2002:a05:6a00:1305:b0:512:ebab:3b20 with SMTP id j5-20020a056a00130500b00512ebab3b20mr1467769pfu.82.1655158792415;
        Mon, 13 Jun 2022 15:19:52 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:b964])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0015edc07dcf3sm5661261pll.21.2022.06.13.15.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:19:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Jun 2022 12:19:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     paulmck@kernel.org, lkml <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org, brauner@kernel.org, hannes@cmpxchg.org,
        shisiyuan <shisiyuan19870131@gmail.com>,
        Li Zefan <lizefan@huawei.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: [PATCH cgroup/for-5.19-fixes] cgroup: Use separate src/dst nodes
 when preloading css_sets for migration
Message-ID: <Yqe4BjMZRohur3UM@slm.duckdns.org>
References: <549de740-1356-7ad2-3ee5-c52bc355fd99@quicinc.com>
 <Yh+RGIJ0f3nrqIiN@slm.duckdns.org>
 <8d21e655-4ce9-c7b3-2010-e484161bdbe9@quicinc.com>
 <20220516203417.GY1790663@paulmck-ThinkPad-P17-Gen-1>
 <9a93cf2d-0efe-5a46-dcd5-7dcd8f173188@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a93cf2d-0efe-5a46-dcd5-7dcd8f173188@quicinc.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Each cset (css_set) is pinned by its tasks. When we're moving tasks around
across csets for a migration, we need to hold the source and destination
csets to ensure that they don't go away while we're moving tasks about. This
is done by linking cset->mg_preload_node on either the
mgctx->preloaded_dst_csets or mgctx->preloaded_dst_csets list. Using the
same cset->mg_preload_node for both the src and dst lists was deemed okay as
a cset can't be both the source and destination at the same time.

Unfortunately, this overloading becomes problematic when multiple tasks are
involved in a migration and some of them are identity noop migrations while
others are actually moving across cgroups. For example, this can happen with
the following sequence on cgroup1:

 #1> mkdir -p /sys/fs/cgroup/misc/a/b
 #2> echo $$ > /sys/fs/cgroup/misc/a/cgroup.procs
 #3> RUN_A_COMMAND_WHICH_CREATES_MULTIPLE_THREADS &
 #4> PID=$!
 #5> echo $PID > /sys/fs/cgroup/misc/a/b/tasks
 #6> echo $PID > /sys/fs/cgroup/misc/a/cgroup.procs

#5 moves the group leader thread into a/b and then #6 moves all threads of
the process including the group leader back into a. In this final migration,
non-leader threads would be doing identity migration while the group leader
is doing an actual one.

After #3, let's say the whole process was in cset A, and that after #4, the
leader moves to cset B. Then, during #6, the following happens:

 1. cgroup_migrate_add_src() is called on B for the leader.

 2. cgroup_migrate_add_src() is called on A for the other threads.

 3. cgroup_migrate_prepare_dst() is called. It scans the src list.

 3. It notices that B wants to migrate to A, so it tries to A to the dst
    list but realizes that its ->mg_preload_node is already busy.

 4. and then it notices A wants to migrate to A as it's an identity
    migration, it culls it by list_del_init()'ing its ->mg_preload_node and
    putting references accordingly.

 5. The rest of migration takes place with B on the src list but nothing on
    the dst list.

This means that A isn't held while migration is in progress. If all tasks
leave A before the migration finishes and the incoming task pins it, the
cset will be destroyed leading to use-after-free.

This is caused by overloading cset->mg_preload_node for both src and dst
preload lists. We wanted to exclude the cset from the src list but ended up
inadvertently excluding it from the dst list too.

This patch fixes the issue by separating out cset->mg_preload_node into
->mg_src_preload_node and ->mg_dst_preload_node, so that the src and dst
preloadings don't interfere with each other.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
Reported-by: shisiyuan <shisiyuan19870131@gmail.com>
Link: http://lkml.kernel.org/r/1654187688-27411-1-git-send-email-shisiyuan@xiaomi.com
Link: https://www.spinics.net/lists/cgroups/msg33313.html
Fixes: f817de98513d ("cgroup: prepare migration path for unified hierarchy")
Cc: stable@vger.kernel.org # v3.16+
---
Hello,

Shisiyuan and Mukesh, can you guys please confirm that this fixes the
problem you're seeing? This is a different approach from Shisiyuan's patch
which most likely would work too but this is a bit more straightforward.

Thanks.

 include/linux/cgroup-defs.h |    3 ++-
 kernel/cgroup/cgroup.c      |   37 +++++++++++++++++++++++--------------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1bfcfb1af3524..d4427d0a0e187 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -264,7 +264,8 @@ struct css_set {
 	 * List of csets participating in the on-going migration either as
 	 * source or destination.  Protected by cgroup_mutex.
 	 */
-	struct list_head mg_preload_node;
+	struct list_head mg_src_preload_node;
+	struct list_head mg_dst_preload_node;
 	struct list_head mg_node;
 
 	/*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1779ccddb734d..13c8e91d78620 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -765,7 +765,8 @@ struct css_set init_css_set = {
 	.task_iters		= LIST_HEAD_INIT(init_css_set.task_iters),
 	.threaded_csets		= LIST_HEAD_INIT(init_css_set.threaded_csets),
 	.cgrp_links		= LIST_HEAD_INIT(init_css_set.cgrp_links),
-	.mg_preload_node	= LIST_HEAD_INIT(init_css_set.mg_preload_node),
+	.mg_src_preload_node	= LIST_HEAD_INIT(init_css_set.mg_src_preload_node),
+	.mg_dst_preload_node	= LIST_HEAD_INIT(init_css_set.mg_dst_preload_node),
 	.mg_node		= LIST_HEAD_INIT(init_css_set.mg_node),
 
 	/*
@@ -1240,7 +1241,8 @@ static struct css_set *find_css_set(struct css_set *old_cset,
 	INIT_LIST_HEAD(&cset->threaded_csets);
 	INIT_HLIST_NODE(&cset->hlist);
 	INIT_LIST_HEAD(&cset->cgrp_links);
-	INIT_LIST_HEAD(&cset->mg_preload_node);
+	INIT_LIST_HEAD(&cset->mg_src_preload_node);
+	INIT_LIST_HEAD(&cset->mg_dst_preload_node);
 	INIT_LIST_HEAD(&cset->mg_node);
 
 	/* Copy the set of subsystem state objects generated in
@@ -2597,21 +2599,27 @@ int cgroup_migrate_vet_dst(struct cgroup *dst_cgrp)
  */
 void cgroup_migrate_finish(struct cgroup_mgctx *mgctx)
 {
-	LIST_HEAD(preloaded);
 	struct css_set *cset, *tmp_cset;
 
 	lockdep_assert_held(&cgroup_mutex);
 
 	spin_lock_irq(&css_set_lock);
 
-	list_splice_tail_init(&mgctx->preloaded_src_csets, &preloaded);
-	list_splice_tail_init(&mgctx->preloaded_dst_csets, &preloaded);
+	list_for_each_entry_safe(cset, tmp_cset, &mgctx->preloaded_src_csets,
+				 mg_src_preload_node) {
+		cset->mg_src_cgrp = NULL;
+		cset->mg_dst_cgrp = NULL;
+		cset->mg_dst_cset = NULL;
+		list_del_init(&cset->mg_src_preload_node);
+		put_css_set_locked(cset);
+	}
 
-	list_for_each_entry_safe(cset, tmp_cset, &preloaded, mg_preload_node) {
+	list_for_each_entry_safe(cset, tmp_cset, &mgctx->preloaded_dst_csets,
+				 mg_dst_preload_node) {
 		cset->mg_src_cgrp = NULL;
 		cset->mg_dst_cgrp = NULL;
 		cset->mg_dst_cset = NULL;
-		list_del_init(&cset->mg_preload_node);
+		list_del_init(&cset->mg_dst_preload_node);
 		put_css_set_locked(cset);
 	}
 
@@ -2651,7 +2659,7 @@ void cgroup_migrate_add_src(struct css_set *src_cset,
 	if (src_cset->dead)
 		return;
 
-	if (!list_empty(&src_cset->mg_preload_node))
+	if (!list_empty(&src_cset->mg_src_preload_node))
 		return;
 
 	src_cgrp = cset_cgroup_from_root(src_cset, dst_cgrp->root);
@@ -2664,7 +2672,7 @@ void cgroup_migrate_add_src(struct css_set *src_cset,
 	src_cset->mg_src_cgrp = src_cgrp;
 	src_cset->mg_dst_cgrp = dst_cgrp;
 	get_css_set(src_cset);
-	list_add_tail(&src_cset->mg_preload_node, &mgctx->preloaded_src_csets);
+	list_add_tail(&src_cset->mg_src_preload_node, &mgctx->preloaded_src_csets);
 }
 
 /**
@@ -2689,7 +2697,7 @@ int cgroup_migrate_prepare_dst(struct cgroup_mgctx *mgctx)
 
 	/* look up the dst cset for each src cset and link it to src */
 	list_for_each_entry_safe(src_cset, tmp_cset, &mgctx->preloaded_src_csets,
-				 mg_preload_node) {
+				 mg_src_preload_node) {
 		struct css_set *dst_cset;
 		struct cgroup_subsys *ss;
 		int ssid;
@@ -2708,7 +2716,7 @@ int cgroup_migrate_prepare_dst(struct cgroup_mgctx *mgctx)
 		if (src_cset == dst_cset) {
 			src_cset->mg_src_cgrp = NULL;
 			src_cset->mg_dst_cgrp = NULL;
-			list_del_init(&src_cset->mg_preload_node);
+			list_del_init(&src_cset->mg_src_preload_node);
 			put_css_set(src_cset);
 			put_css_set(dst_cset);
 			continue;
@@ -2716,8 +2724,8 @@ int cgroup_migrate_prepare_dst(struct cgroup_mgctx *mgctx)
 
 		src_cset->mg_dst_cset = dst_cset;
 
-		if (list_empty(&dst_cset->mg_preload_node))
-			list_add_tail(&dst_cset->mg_preload_node,
+		if (list_empty(&dst_cset->mg_dst_preload_node))
+			list_add_tail(&dst_cset->mg_dst_preload_node,
 				      &mgctx->preloaded_dst_csets);
 		else
 			put_css_set(dst_cset);
@@ -2963,7 +2971,8 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 		goto out_finish;
 
 	spin_lock_irq(&css_set_lock);
-	list_for_each_entry(src_cset, &mgctx.preloaded_src_csets, mg_preload_node) {
+	list_for_each_entry(src_cset, &mgctx.preloaded_src_csets,
+			    mg_src_preload_node) {
 		struct task_struct *task, *ntask;
 
 		/* all tasks in src_csets need to be migrated */
