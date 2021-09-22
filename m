Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DD4415396
	for <lists+cgroups@lfdr.de>; Thu, 23 Sep 2021 00:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbhIVWvj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Sep 2021 18:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbhIVWvj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Sep 2021 18:51:39 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4F0C061756
        for <cgroups@vger.kernel.org>; Wed, 22 Sep 2021 15:50:08 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id d2-20020a17090a2a4200b001994a2b5092so6281606pjg.3
        for <cgroups@vger.kernel.org>; Wed, 22 Sep 2021 15:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fYT2H3FnVzXmjkC8XwE06RYc4twnR3x9ZhWA5eYW5cM=;
        b=rH+lVrWvrauGyiUwv5CSwXopm3CgX3XPqpRDHpOOCjDUe+yvZkUEaNfH6ZQ2UYO+Ek
         7TEMmGYaBrPb96sMk+TKXY21cu3ellnypTef268Klog7veZGxSSD8h0dVJbmTXk2clr2
         0dFJgysUBwznrfNhSvprOIVnJDciDtVgTRGZuj5rA6lLhpuuyYlQbsEggPRNrqFdfy+g
         zGBAY2bQIFDS64BERxlmoUUih3bidH8IrEzFZukq+Uewj9fuyIm/Fi/C3l7z/6ilMLy4
         1Q02afBkMQj88St/gnheNtf3i2b1TX4e/LQYpiUbSCYqEv6nmNOXbgFu4isIOQO99liN
         68uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fYT2H3FnVzXmjkC8XwE06RYc4twnR3x9ZhWA5eYW5cM=;
        b=DgbI2HYovE+XCK8F4vgNmSOBi9Y9711lHEf57jPm5kFImV4aJr/YaAw4M6gYqbPNNI
         ObNzWj7BAZ2evIYLjUlM2djgg4dsMZmXh/7jFXl4C57bMZQbWNNoLI0TuH2AnbjPKvy3
         HxoxHN4DV/64p2bWWiugTgelIFJdFfP/zm/onUEjA2O7Xe76LqL5ejnj7ab0QaqQG2Qr
         wCchhQfWK8kae/DuPy9KT/RPeMRjHuME7fQxupBY9MKx3scdX0MOeYoMMvGynhzPjeT4
         hTpJmyKgtuxFkFrrwrDrj7kBejHiTjN+WtbeE8iTCS9hC277Gokt1ETPZVYT4Re1RLUa
         tVqw==
X-Gm-Message-State: AOAM532xAmfI264L3mqq1uaJHn4KhvRIzBeEhzeSTR8l3v96RJPXK4gV
        0+f0OkRboYYefZPjWEDpA1yYu2+grt0vdw==
X-Google-Smtp-Source: ABdhPJznY6PL1nh29qPs0zhG801cikn0glY0dATnTSJNV1ctf+V5pzXrBNDRXS/pyVgnIRtlqYYio0ssmI9pNA==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:d448:5a1d:9294:788])
 (user=shakeelb job=sendgmr) by 2002:a65:508a:: with SMTP id
 r10mr1259313pgp.96.1632351008138; Wed, 22 Sep 2021 15:50:08 -0700 (PDT)
Date:   Wed, 22 Sep 2021 15:49:06 -0700
Message-Id: <20210922224906.676151-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH] memcg: flush lruvec stats in the refault
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Feng Tang <feng.tang@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Prior to the commit 7e1c0d6f5820 ("memcg: switch lruvec stats to rstat")
and the commit aa48e47e3906 ("memcg: infrastructure to flush memcg
stats"), each lruvec memcg stats can be off by (nr_cgroups * nr_cpus *
32) at worst and for unbounded amount of time. The commit aa48e47e3906
moved the lruvec stats to rstat infrastructure and the commit
7e1c0d6f5820 bounded the error for all the lruvec stats to (nr_cpus *
32) at worst for at most 2 seconds. More specifically it decoupled the
number of stats and the number of cgroups from the error rate.

However this reduction in error comes with the cost of triggering the
slowpath of stats update more frequently. Previously in the slowpath the
kernel adds the stats up the memcg tree. After aa48e47e3906, the kernel
triggers the asyn lruvec stats flush through queue_work(). This causes
regression reports from 0day kernel bot [1] as well as from phoronix
test suite [2].

We tried two options to fix the regression:

1) Increase the threshold to trigger the slowpath in lruvec stats update
codepath from 32 to 512.

2) Remove the slowpath from lruvec stats update codepath and instead
flush the stats in the page refault codepath. The assumption is that the
kernel timely flush the stats, so, the update tree would be small in the
refault codepath to not cause the preformance impact.

Following are the results of will-it-scale/page_fault[1|2|3] benchmark
on four settings i.e. (1) 5.15-rc1 as baseline (2) 5.15-rc1 with
aa48e47e3906 and 7e1c0d6f5820 reverted (3) 5.15-rc1 with option-1
(4) 5.15-rc1 with option-2.

test	(1)	(2)		(3)		(4)
pg_f1	368563	406277 (10.23%)	399693 (8.44%)	416398 (12.97%)
pg_f2	338399	372133 (9.96%)	369180 (9.09%)	381024 (12.59%)
pg_f3	500853	575399 (14.88%)	570388 (13.88%)	576083 (15.02%)

From the above result, it seems like the option-2 not only solves the
regression but also improves the performance for at least these
benchmarks.

Feng Tang (intel) ran the aim7 benchmark with these two options and
confirms that option-1 reduces the regression but option-2 removes the
regression.

Michael Larabel (phoronix) ran multiple benchmarks with these options
and reported the results at [3] and it shows for most benchmarks
option-2 removes the regression introduced by the commit aa48e47e3906
("memcg: infrastructure to flush memcg stats").

Based on the experiment results, this patch proposed the option-2 as the
solution to resolve the regression.

[1] https://lore.kernel.org/all/20210726022421.GB21872@xsang-OptiPlex-9020
[2] https://www.phoronix.com/scan.php?page=article&item=linux515-compile-regress
[3] https://openbenchmarking.org/result/2109226-DEBU-LINUX5104

Fixes: aa48e47e3906 ("memcg: infrastructure to flush memcg stats")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 10 ----------
 mm/workingset.c |  1 +
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b762215d73eb..6da5020a8656 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -106,9 +106,6 @@ static bool do_memsw_account(void)
 /* memcg and lruvec stats flushing */
 static void flush_memcg_stats_dwork(struct work_struct *w);
 static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
-static void flush_memcg_stats_work(struct work_struct *w);
-static DECLARE_WORK(stats_flush_work, flush_memcg_stats_work);
-static DEFINE_PER_CPU(unsigned int, stats_flush_threshold);
 static DEFINE_SPINLOCK(stats_flush_lock);
 
 #define THRESHOLDS_EVENTS_TARGET 128
@@ -682,8 +679,6 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 
 	/* Update lruvec */
 	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
-	if (!(__this_cpu_inc_return(stats_flush_threshold) % MEMCG_CHARGE_BATCH))
-		queue_work(system_unbound_wq, &stats_flush_work);
 }
 
 /**
@@ -5361,11 +5356,6 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, 2UL*HZ);
 }
 
-static void flush_memcg_stats_work(struct work_struct *w)
-{
-	mem_cgroup_flush_stats();
-}
-
 static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
diff --git a/mm/workingset.c b/mm/workingset.c
index d4268d8e9a82..d5b81e4f4cbe 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -352,6 +352,7 @@ void workingset_refault(struct page *page, void *shadow)
 
 	inc_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file);
 
+	mem_cgroup_flush_stats();
 	/*
 	 * Compare the distance to the existing workingset size. We
 	 * don't activate pages that couldn't stay resident even if
-- 
2.33.0.464.g1972c5931b-goog

