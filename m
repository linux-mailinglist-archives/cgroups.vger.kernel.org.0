Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A851D626C29
	for <lists+cgroups@lfdr.de>; Sat, 12 Nov 2022 23:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiKLWVJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Nov 2022 17:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbiKLWVI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Nov 2022 17:21:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F8FFACF
        for <cgroups@vger.kernel.org>; Sat, 12 Nov 2022 14:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668291613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BEeh1aXYPMoNUSRUbgR3jz4w6CXvrkqhiV75ZDaEEV4=;
        b=VMaPu/swM6kzar+0Dt6GoE2NqA4csKODRgCS3V8ecFfYx31rW/EIIkWOYJReunfJn+UOi2
        ydWJwB1hh2tSt3hVZq1/5xl8i9WmD6Gjq8Sb0LQJT2Y9m6spUv1HaOLvlztFcFZ/a9kOZz
        /NQnXmYSbc4coMLPwtOScMnH4fkoHJc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-8zaKV3QnNFCJ7_2jNM1Ukw-1; Sat, 12 Nov 2022 17:20:09 -0500
X-MC-Unique: 8zaKV3QnNFCJ7_2jNM1Ukw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F25DE3806703;
        Sat, 12 Nov 2022 22:20:08 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A31B8C15BB2;
        Sat, 12 Nov 2022 22:20:08 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] cgroup/cpuset: Skip spread flags update on v2
Date:   Sat, 12 Nov 2022 17:19:38 -0500
Message-Id: <20221112221939.1272764-2-longman@redhat.com>
In-Reply-To: <20221112221939.1272764-1-longman@redhat.com>
References: <20221112221939.1272764-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Cpuset v2 has no spread flags to set. So we can skip spread
flags update if cpuset v2 is being used. Also change the name to
cpuset_update_task_spread_flags() to indicate that there are multiple
spread flags.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b474289c15b8..2525905cdf48 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -550,11 +550,15 @@ static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 /*
  * update task's spread flag if cpuset's page/slab spread flag is set
  *
- * Call with callback_lock or cpuset_rwsem held.
+ * Call with callback_lock or cpuset_rwsem held. The check can be skipped
+ * if on default hierarchy.
  */
-static void cpuset_update_task_spread_flag(struct cpuset *cs,
+static void cpuset_update_task_spread_flags(struct cpuset *cs,
 					struct task_struct *tsk)
 {
+	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
+		return;
+
 	if (is_spread_page(cs))
 		task_set_spread_page(tsk);
 	else
@@ -2153,7 +2157,7 @@ static void update_tasks_flags(struct cpuset *cs)
 
 	css_task_iter_start(&cs->css, 0, &it);
 	while ((task = css_task_iter_next(&it)))
-		cpuset_update_task_spread_flag(cs, task);
+		cpuset_update_task_spread_flags(cs, task);
 	css_task_iter_end(&it);
 }
 
@@ -2530,7 +2534,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 		WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
 
 		cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
-		cpuset_update_task_spread_flag(cs, task);
+		cpuset_update_task_spread_flags(cs, task);
 	}
 
 	/*
-- 
2.31.1

