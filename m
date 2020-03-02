Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B76C61764F9
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2020 21:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgCBUbY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Mar 2020 15:31:24 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:48929 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCBUbY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Mar 2020 15:31:24 -0500
Received: by mail-yw1-f73.google.com with SMTP id o64so984234ywb.15
        for <cgroups@vger.kernel.org>; Mon, 02 Mar 2020 12:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=aihQYJyYU6rAhab/wfRsprbv1ChtTTWAtf4Gs/sLtew=;
        b=EmoWHNnC3GmmT1fQR4b+eNyOdqxc4dSP/L7Ck/cPjz+laobHXJTPYrpx6RnpfnaYg6
         jEMR+ZJHob86afxd2iTqe6yl770MccPz7Wh36Z4R4VrTdc+lLhVIEt5QhgGHfH3JKnMX
         LmIiCk/pzyCz5X/MBG+RRUZScnKlzLvV+MRsjaCSzrFr0TQHCz1s9Ukdrr7ysc4QXlWk
         9HBbsfEeNsl+HQ8ISF5IrV2CxIGOXxjfH1iLOvlp8vR61axv/mmUt3fUvD06zF4Mfe2E
         aTV/Gun0pcpO9Bgwg+qfQEOQP/kVby/EzuJDx7Nlt22XEx74ouhjFFP/INIB86ECjh0Z
         OtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=aihQYJyYU6rAhab/wfRsprbv1ChtTTWAtf4Gs/sLtew=;
        b=U1Txt4cv1kG0UITU/mnL5QDEG9N/PlDAbXIchWbOuX3tT8k1dhlct5Jgj4Lwicd+0k
         mY8eQv5PqsNt7VQiOOZHb9rbjJGhbHZOahsg372PsHeLABf4sj0B3MsmC9mOlKhs7AY/
         bOaeK1CQTCVs4rE0okxpzSoBgdo8zH65aDg80dOt+WVGW4hXgDUYQ2YUKmVePbqBjcIi
         0KlWDFliLcYoFksdjMV9Ygq3Zhd+8Ym5/V97vg7/PPR1HlADos6uYNal8tGZh+EZ7HYN
         abepzBv1MpZG0zqeguVIwlPexeqxhqQph6FsSbycTeOyxAUMBbXB+T4LzHE4KsAVc/pZ
         B4ig==
X-Gm-Message-State: ANhLgQ2492ZvpfIBrah3ib4jzKk3DdCd7HLbyAkz31h+hxHnSuG28sC/
        2lBcpfpznp1hVti7TBMN5zQRN+fYK3BnRA==
X-Google-Smtp-Source: ADFU+vsS9GknTSE+3+5xm2leEa0Ul9szOKAXYY5z95L1JXYZd0kbMTU4A5zCU2nnGu8RBpDng5OejBWzi04V9w==
X-Received: by 2002:a81:23d8:: with SMTP id j207mr1140477ywj.203.1583181081383;
 Mon, 02 Mar 2020 12:31:21 -0800 (PST)
Date:   Mon,  2 Mar 2020 12:31:09 -0800
Message-Id: <20200302203109.179417-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2] memcg: css_tryget_online cleanups
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently multiple locations in memcg code, css_tryget_online() is being
used. However it doesn't matter whether the cgroup is online for the
callers. Online used to matter when we had reparenting on offlining and
we needed a way to prevent new ones from showing up.

The failure case for couple of these css_tryget_online usage is to
fallback to root_mem_cgroup which kind of make bypassing the memcg
limits possible for some workloads. For example creating an inotify
group in a subcontainer and then deleting that container after moving the
process to a different container will make all the event objects
allocated for that group to the root_mem_cgroup. So, using
css_tryget_online() is dangerous for such cases.

Two locations still use the online version. The swapin of offlined
memcg's pages and the memcg kmem cache creation. The kmem cache indeed
needs the online version as the kernel does the reparenting of memcg
kmem caches. For the swapin case, it has been left for later as the
fallback is not really that concerning.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---

Changes since v1:
- replaced WARN_ON with WARN_ON_ONCE

 mm/memcontrol.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 62b574d0cd3c..75d8883bf975 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -656,7 +656,7 @@ __mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
 	 */
 	__mem_cgroup_remove_exceeded(mz, mctz);
 	if (!soft_limit_excess(mz->memcg) ||
-	    !css_tryget_online(&mz->memcg->css))
+	    !css_tryget(&mz->memcg->css))
 		goto retry;
 done:
 	return mz;
@@ -961,7 +961,8 @@ struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
 		return NULL;
 
 	rcu_read_lock();
-	if (!memcg || !css_tryget_online(&memcg->css))
+	/* Page should not get uncharged and freed memcg under us. */
+	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
 		memcg = root_mem_cgroup;
 	rcu_read_unlock();
 	return memcg;
@@ -974,10 +975,13 @@ EXPORT_SYMBOL(get_mem_cgroup_from_page);
 static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
 {
 	if (unlikely(current->active_memcg)) {
-		struct mem_cgroup *memcg = root_mem_cgroup;
+		struct mem_cgroup *memcg;
 
 		rcu_read_lock();
-		if (css_tryget_online(&current->active_memcg->css))
+		/* current->active_memcg must hold a ref. */
+		if (WARN_ON_ONCE(!css_tryget(&current->active_memcg->css)))
+			memcg = root_mem_cgroup;
+		else
 			memcg = current->active_memcg;
 		rcu_read_unlock();
 		return memcg;
@@ -6732,7 +6736,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 		goto out;
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg->tcpmem_active)
 		goto out;
-	if (css_tryget_online(&memcg->css))
+	if (css_tryget(&memcg->css))
 		sk->sk_memcg = memcg;
 out:
 	rcu_read_unlock();
-- 
2.25.0.265.gbab2e86ba0-goog

