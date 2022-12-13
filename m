Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B37964BC44
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 19:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbiLMSps (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 13:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbiLMSpp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 13:45:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768EA2495B
        for <cgroups@vger.kernel.org>; Tue, 13 Dec 2022 10:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670957104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XKtEb7DX5sCj2p62DhFAWIKVGv8SYAUBUDgGPKa8O/0=;
        b=PJiPMKHq8PkC7GUFEER6EhtUZjfUqT+kKI4DoyG2X36ih9XAW/DxLOm4KZtRl8ZOPr0xe5
        tRwRet7J5NDkLV0nDE1mGyzkxnozIDkwQaEKBCngjHqo2Le7IfXjixHoevukoWx6O7yRLK
        dMuCcw2kwxbupPWA283JAtbM+lZm1xs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-QAxSZuDjMui-EVsI4VfzIg-1; Tue, 13 Dec 2022 13:44:59 -0500
X-MC-Unique: QAxSZuDjMui-EVsI4VfzIg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9962D3C10147;
        Tue, 13 Dec 2022 18:44:58 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F370BC15BA0;
        Tue, 13 Dec 2022 18:44:57 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH-block v3 1/2] bdi, blk-cgroup: Fix potential UAF of blkcg
Date:   Tue, 13 Dec 2022 13:44:45 -0500
Message-Id: <20221213184446.50181-2-longman@redhat.com>
In-Reply-To: <20221213184446.50181-1-longman@redhat.com>
References: <20221213184446.50181-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Commit 59b57717fff8 ("blkcg: delay blkg destruction until after
writeback has finished") delayed call to blkcg_destroy_blkgs() to
cgwb_release_workfn(). However, it is done after a css_put() of blkcg
which may be the final put that causes the blkcg to be freed as RCU
read lock isn't held.

Another place where blkcg_destroy_blkgs() can be called indirectly via
blkcg_unpin_online() is from the offline_css() function called from
css_killed_work_fn(). Over there, the potentially final css_put() call
is issued after offline_css().

By adding a css_tryget() into blkcg_destroy_blkgs() and warning its
failure, the following stack trace was produced in a test system on
bootup.

[   34.254240] RIP: 0010:blkcg_destroy_blkgs+0x16a/0x1a0
      :
[   34.339943] Call Trace:
[   34.344510]  blkcg_unpin_online+0x38/0x60
[   34.348523]  cgwb_release_workfn+0x6a/0x200
[   34.352708]  process_one_work+0x1e5/0x3b0
[   34.360758]  worker_thread+0x50/0x3a0
[   34.368447]  kthread+0xd9/0x100
[   34.376386]  ret_from_fork+0x22/0x30

This confirms that a potential UAF situation can really happen in
cgwb_release_workfn().

Fix that by delaying the css_put() until after the blkcg_unpin_online()
call. Also use css_tryget() in blkcg_destroy_blkgs() and issue a warning
if css_tryget() fails.

The reproducing system can no longer produce a warning with this patch.
All the runnable block/0* tests including block/027 were run successfully
without failure.

Fixes: 59b57717fff8 ("blkcg: delay blkg destruction until after writeback has finished")
Suggested-by: Michal Koutný <mkoutny@suse.com>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 block/blk-cgroup.c | 7 +++++++
 mm/backing-dev.c   | 8 ++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 1bb939d3b793..ca28306aa1b1 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1084,6 +1084,13 @@ struct list_head *blkcg_get_cgwb_list(struct cgroup_subsys_state *css)
  */
 static void blkcg_destroy_blkgs(struct blkcg *blkcg)
 {
+	/*
+	 * blkcg_destroy_blkgs() shouldn't be called with all the blkcg
+	 * references gone.
+	 */
+	if (WARN_ON_ONCE(percpu_ref_is_zero(&blkcg->css.refcnt)))
+		return;
+
 	might_sleep();
 
 	spin_lock_irq(&blkcg->lock);
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index c30419a5e119..36f75b072325 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -390,11 +390,15 @@ static void cgwb_release_workfn(struct work_struct *work)
 	wb_shutdown(wb);
 
 	css_put(wb->memcg_css);
-	css_put(wb->blkcg_css);
 	mutex_unlock(&wb->bdi->cgwb_release_mutex);
 
-	/* triggers blkg destruction if no online users left */
+	/*
+	 * Triggers blkg destruction if no online users left
+	 * The final blkcg css_put() has to be done after blkcg_unpin_online()
+	 * to avoid use-after-free.
+	 */
 	blkcg_unpin_online(wb->blkcg_css);
+	css_put(wb->blkcg_css);
 
 	fprop_local_destroy_percpu(&wb->memcg_completions);
 
-- 
2.31.1

