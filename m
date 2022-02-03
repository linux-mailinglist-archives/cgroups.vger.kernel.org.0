Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050434A7E56
	for <lists+cgroups@lfdr.de>; Thu,  3 Feb 2022 04:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349084AbiBCDbW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Feb 2022 22:31:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348776AbiBCDbW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Feb 2022 22:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643859081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wc8dl729Kfw/oo6FN8HrQApuGc0MHf1g6N7P5YsZBDw=;
        b=IdeG2VNr99Zpj4+6sgCVyBC+dBR2S1g+88Q1ELFgOstq7FWc9Kh1Eg9NKwdIVQLRIVg7Cx
        i9bYlYUvao9DVX3M5mLrZSyEqaRVnt5mui/2lXpqubUzRPHY3M3HCMIqMhIZGHFTfLk6gc
        bifAvrOI+tTkA0OMg66iUb3jWvf6O5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-JeR_pqIVP4G6vqxcweJlNA-1; Wed, 02 Feb 2022 22:31:20 -0500
X-MC-Unique: JeR_pqIVP4G6vqxcweJlNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A7938015C6;
        Thu,  3 Feb 2022 03:31:19 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2450156F63;
        Thu,  3 Feb 2022 03:31:18 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup/cpuset: Fix "suspicious RCU usage" lockdep warning
Date:   Wed,  2 Feb 2022 22:31:03 -0500
Message-Id: <20220203033103.773030-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It was found that a "suspicious RCU usage" lockdep warning was issued
with the rcu_read_lock() call in update_sibling_cpumasks().  It is
because the update_cpumasks_hier() function may sleep. So we have
to release the RCU lock, call update_cpumasks_hier() and reacquire
it afterward.

Also add a percpu_rwsem_assert_held() in update_sibling_cpumasks()
instead of stating that in the comment.

Fixes: 4716909cc5c5 ("cpuset: Track cpusets that use parent's effective_cpus")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index dc653ab26e50..b147acece984 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1522,10 +1522,15 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	struct cpuset *sibling;
 	struct cgroup_subsys_state *pos_css;
 
+	percpu_rwsem_assert_held(&cpuset_rwsem);
+
 	/*
 	 * Check all its siblings and call update_cpumasks_hier()
 	 * if their use_parent_ecpus flag is set in order for them
 	 * to use the right effective_cpus value.
+	 *
+	 * The update_cpumasks_hier() function may sleep. So we have to
+	 * release the RCU read lock before calling it.
 	 */
 	rcu_read_lock();
 	cpuset_for_each_child(sibling, pos_css, parent) {
@@ -1533,8 +1538,13 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 			continue;
 		if (!sibling->use_parent_ecpus)
 			continue;
+		if (!css_tryget_online(&sibling->css))
+			continue;
 
+		rcu_read_unlock();
 		update_cpumasks_hier(sibling, tmp);
+		rcu_read_lock();
+		css_put(&sibling->css);
 	}
 	rcu_read_unlock();
 }
-- 
2.27.0

