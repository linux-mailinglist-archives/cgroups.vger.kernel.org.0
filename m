Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51726476E1
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 20:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLHT6B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 14:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiLHT57 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 14:57:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D83F5C744
        for <cgroups@vger.kernel.org>; Thu,  8 Dec 2022 11:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670529423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s03T6k1fAEZ5y4Sx1FORStjPoY8HDaI7yoRA/+1yXuc=;
        b=OgbjEUyNUAl5rBdOMCLahf1u4OA4qC+P+Ep/Nuj51yXy3oASa7RkAlJKLCTTnYGudEwRlS
        +O3cxkqUS2+rC4Pnl2ENhAGQBfwt1W3ZSNbWhw8fGUFdSD6oJ6BvpukNVT/T0yo+fuoa0L
        guiXBNQdvSNdK7hHeGiJ1BWKszfvJ2s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-he_nquLLOEqRq0Qhs5-jNg-1; Thu, 08 Dec 2022 14:57:00 -0500
X-MC-Unique: he_nquLLOEqRq0Qhs5-jNg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAF63858F13;
        Thu,  8 Dec 2022 19:56:59 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9D45492B05;
        Thu,  8 Dec 2022 19:56:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] cgroup/cpuset: Make percpu cpuset_rwsem operation depending on DYNMODS state
Date:   Thu,  8 Dec 2022 14:56:34 -0500
Message-Id: <20221208195634.2604362-3-longman@redhat.com>
In-Reply-To: <20221208195634.2604362-1-longman@redhat.com>
References: <20221208195634.2604362-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

With commit 6a010a49b63a ("cgroup: Make !percpu threadgroup_rwsem
operations optional"), users can determine if they favor optimizing
for efficiently moving processes between cgroups frequently or for
a more static usage pattern where moving processes among cgroups are
relatively rare.

The percpu cpuset_rwsem is in the same boat as percpu_threadgroup_rwsem
since moving processes among cpusets will have the same latency impact
depending on whether percpu operation in cpuset_rwsem is disabled or not.

Ideally cpuset_bind() is the best place to check if the
cpuset_rwsem should have its reader fast path disabled like
percpu_threadgroup_rwsem so that it gets to be re-evaluated every
time the cpuset is rebound. Unfortunately, cgroup_favor_dynmods()
that sets the CGRP_ROOT_FAVOR_DYNMODS flag is called after the bind()
method call. Instead, the newly added cpuset_check_dynmods() function
is called at the first cpuset_css_online() call after a cpuset_bind()
call when the first child cpuset is created.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 800c65de5daa..daf8ca948176 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -255,6 +255,7 @@ typedef enum {
 	CS_SCHED_LOAD_BALANCE,
 	CS_SPREAD_PAGE,
 	CS_SPREAD_SLAB,
+	CS_FAVOR_DYNMODS,	/* top_cpuset only */
 } cpuset_flagbits_t;
 
 /* convenient tests for these bits */
@@ -3049,6 +3050,27 @@ static struct cftype dfl_files[] = {
 	{ }	/* terminate */
 };
 
+static bool dynmods_checked __read_mostly;
+static void cpuset_check_dynmods(struct cgroup_root *root)
+{
+	bool favor_dynmods;
+
+	lockdep_assert_held(&cgroup_mutex);
+	percpu_rwsem_assert_held(&cpuset_rwsem);
+
+	/*
+	 * Check the CGRP_ROOT_FAVOR_DYNMODS of the cgroup root to find out
+	 * if we need to enable or disable reader fast path of cpuset_rwsem.
+	 */
+	favor_dynmods = test_bit(CS_FAVOR_DYNMODS, &top_cpuset.flags);
+	if (favor_dynmods && !(root->flags & CGRP_ROOT_FAVOR_DYNMODS)) {
+		rcu_sync_exit(&cpuset_rwsem.rss);
+		clear_bit(CS_FAVOR_DYNMODS, &top_cpuset.flags);
+	} else if (!favor_dynmods && (root->flags & CGRP_ROOT_FAVOR_DYNMODS)) {
+		rcu_sync_enter(&cpuset_rwsem.rss);
+		set_bit(CS_FAVOR_DYNMODS, &top_cpuset.flags);
+	}
+}
 
 /*
  *	cpuset_css_alloc - allocate a cpuset css
@@ -3099,6 +3121,14 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	cpus_read_lock();
 	percpu_down_write(&cpuset_rwsem);
 
+	/*
+	 * Check dynmod state on the first css_online() call.
+	 */
+	if (unlikely(!dynmods_checked)) {
+		cpuset_check_dynmods(cpuset_cgrp_subsys.root);
+		dynmods_checked = true;
+	}
+
 	set_bit(CS_ONLINE, &cs->flags);
 	if (is_spread_page(parent))
 		set_bit(CS_SPREAD_PAGE, &cs->flags);
@@ -3201,6 +3231,12 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
 
 static void cpuset_bind(struct cgroup_subsys_state *root_css)
 {
+	/*
+	 * Reset dynmods_checked to be evaluated again in the next
+	 * cpuset_css_online()
+	 */
+	dynmods_checked = false;
+
 	percpu_down_write(&cpuset_rwsem);
 	spin_lock_irq(&callback_lock);
 
-- 
2.31.1

