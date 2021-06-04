Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A834D39B01A
	for <lists+cgroups@lfdr.de>; Fri,  4 Jun 2021 03:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhFDB7D (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Jun 2021 21:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFDB7C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Jun 2021 21:59:02 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA49C06174A
        for <cgroups@vger.kernel.org>; Thu,  3 Jun 2021 18:57:09 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x7-20020a1709027c07b02900e6489d6231so3447960pll.6
        for <cgroups@vger.kernel.org>; Thu, 03 Jun 2021 18:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uh6gy4nZthBorhbRuZ4nfT30dGL+1kaEEjjmFJIUwIQ=;
        b=h7Se6qB/0cnnCs0FMOVwiNEYheVr2wFbzsatoLiYi1xkHnTgTljxG000R1EPRE5ksS
         U7kt5w744nMgfzzUltQKJlatxrPjqhQrX854XWGGw9u8WKzNKIw1cNdCphoH0IGL1TmS
         am3i4nOxfIT/O1nwzP4vL2sQFhbvB+BgMpB1gFQ0atXxtderGtY9fbqR3UkgUh7C9zLd
         XAX7q51IotP73K7SCw3RpR8taqAuzA9JYPJcC+onu5jJV0p06AfWOxlwtJIuhJWLJmHs
         ABfgbKc+cD+knNVJI6OUd42yvxwL65tayeQ0AD9qpxyRMjLJAGgL9eOixg6HpzneCLeW
         89Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uh6gy4nZthBorhbRuZ4nfT30dGL+1kaEEjjmFJIUwIQ=;
        b=K6YHMJ8JHwDWqb1hkqikLGwNTrpgen5U0vJ4aA1YkNR+vgi8HzA+ssLqnB7YhtydQu
         BOIr6ADDckY6aldbSgaQrKOJXi+rTVb4EfNgKwn8O+zaJ3tqZPwkgi6CiuhTylsmQNm9
         DfQLzoi+uKDNxulMqLMoc55AJgZ01mMQLWY/Xtp469k3O2VloYF2dM971/FVyAtA2+uI
         od4eUmtLGhUZbA7Qx83v9c7wOZOWnQimHsmo5k5Foch0gb//D0KmsvPOUIFry3tQMGET
         bPQ1O20NYc4P3xXf1Ne5zcORV87Q0o3+C8ijNXVEoke5cOe9vOmGb2K5bbfIa44RJbIq
         xqpw==
X-Gm-Message-State: AOAM5310hP66Nlz8Xbk5tV5fUFKJnuWJtY2ey0WKDeH/4IUt8WIbG4gp
        11bzvP4kp5VdGQlYLmn7P1XOi6iTKoAM+w==
X-Google-Smtp-Source: ABdhPJwz56m8TYUYhjbxzv/3S7nXuqm0Lfx263QneYGQ/2VvVbc6MN0OrIO1+l3D4W6MehEckGkiUK+GgvaeqQ==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:1d16:daf:7a47:a348])
 (user=shakeelb job=sendgmr) by 2002:a63:f40d:: with SMTP id
 g13mr2462876pgi.290.1622771828563; Thu, 03 Jun 2021 18:57:08 -0700 (PDT)
Date:   Thu,  3 Jun 2021 18:56:40 -0700
In-Reply-To: <20210604015640.2586269-1-shakeelb@google.com>
Message-Id: <20210604015640.2586269-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20210604015640.2586269-1-shakeelb@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 2/2] memcg: periodically flush the memcg stats
From:   Shakeel Butt <shakeelb@google.com>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

At the moment memcg stats are read in four contexts:

1. memcg stat user interfaces
2. dirty throttling
3. page fault
4. memory reclaim

Currently the kernel flushes the stats for first two cases. Flushing the
stats for remaining two casese may have performance impact. Always
flushing the memcg stats on the page fault code path may negatively
impacts the performance of the applications. In addition flushing in the
memory reclaim code path, though treated as slowpath, can become the
source of contention for the global lock taken for stat flushing because
when system or memcg is under memory pressure, many tasks may enter the
reclaim path.

Instead of synchronously flushing the stats, this patch adds support of
asynchronous periodic flushing of the memcg stats. For now the flushing
period is hardcoded to 2*HZ but that can be changed later through maybe
sysctl if need arise.

This patch does add the explicit flushing in the kswapd thread as the
number of kswapd threads which corresponds to the number of nodes on
realistic machines are usually low.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h | 10 ++++++++++
 mm/memcontrol.c            | 14 ++++++++++++++
 mm/vmscan.c                |  6 ++++++
 3 files changed, 30 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 81d65d32ec2a..222c00e76ef9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -991,6 +991,12 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return x;
 }
 
+static inline void mem_cgroup_flush_stats(void)
+{
+	if (!mem_cgroup_disabled())
+		cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
+}
+
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val);
 void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
@@ -1394,6 +1400,10 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return node_page_state(lruvec_pgdat(lruvec), idx);
 }
 
+static inline void mem_cgroup_flush_stats(void)
+{
+}
+
 static inline void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 					    enum node_stat_item idx, int val)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d48f727bec05..6c8578faa8b4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -96,6 +96,10 @@ bool cgroup_memory_noswap __read_mostly;
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 #endif
 
+/* Periodically flush memcg and lruvec stats. */
+static void flush_memcg_stats(struct work_struct *w);
+static DECLARE_DEFERRABLE_WORK(stats_flush, flush_memcg_stats);
+
 /* Whether legacy memory+swap accounting is active */
 static bool do_memsw_account(void)
 {
@@ -5230,6 +5234,10 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
+
+	if (unlikely(mem_cgroup_is_root(memcg)))
+		schedule_delayed_work(&stats_flush, round_jiffies(2UL*HZ));
+
 	return 0;
 }
 
@@ -5321,6 +5329,12 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	memcg_wb_domain_size_changed(memcg);
 }
 
+static void flush_memcg_stats(struct work_struct *w)
+{
+	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
+	schedule_delayed_work(&stats_flush, round_jiffies(2UL*HZ));
+}
+
 static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 60a19fd6ea3f..16546a5be922 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3872,6 +3872,12 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		sc.may_writepage = !laptop_mode && !nr_boost_reclaim;
 		sc.may_swap = !nr_boost_reclaim;
 
+		/*
+		 * Flush the memory cgroup stats, so that we read accurate
+		 * per-memcg lruvec stats for heuristics later.
+		 */
+		mem_cgroup_flush_stats();
+
 		/*
 		 * Do some background aging of the anon list, to give
 		 * pages a chance to be referenced before reclaiming. All
-- 
2.32.0.rc1.229.g3e70b5a671-goog

