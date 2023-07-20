Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B9A75A74C
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 09:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjGTHIv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 03:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGTHIi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 03:08:38 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2592686
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 00:08:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56fffdea2d0so5420727b3.1
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 00:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689836915; x=1692428915;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwRzTa1HWBGDz2y6kKmJLG3qmZZBS7SfdYMDl6S6pYU=;
        b=buokeDrFKzaUQNx7mhOgxc7yhdstiZpTj86UXwGCh3nTqt6qszmfeuRufu8Lj7sJoB
         FZ8d+MffXHna2mt12Y1ia8+ZNaiYEL4KKqiWl5QyksN4EKDtA5MmamlaJzubK1L4iKoj
         JnIOyZVRWPOZEDrLS+Z7GpFAMpF6YowvDF+xXDYfmorPwNBAYyVmDpwyqMhca813Xnoe
         RKGYMhZTq7+fZsmgRNH21NnT88RSM7deT4LXZ9ISfVkZGDcZnSBTWZjY2y9bjfmsBNsN
         UTtLHPVn8pgWNVg/M6uRpXBrkyjKtRhGZuuMQmP3rtFreh0ZALGBo7Ltyu1x30E1hL2z
         2vZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689836915; x=1692428915;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwRzTa1HWBGDz2y6kKmJLG3qmZZBS7SfdYMDl6S6pYU=;
        b=kgNeZ4H2mCnchwQIturxhCbDoj2lQE5UZPb95u70LJT1c3CQuuePjUsHeoVhjHXswd
         p5uV+JPXlScl9W8dSUMexpOcDS1sRhkx9AOdYJEfP6J8hCPLMdewfltX+LP99CA4XbwP
         IniTl8q6gUUTCpTD27x8n5s6yVx6MLZP+AG7DSGpmAroi+67o10BYXB0d5FYy1f8IoC6
         3vITedqV1+B227jhwIavfai/Y2YsR73wjxjXs4q9iWCqLlwzk4mYquThuPpRMyafpAmz
         dOSgDXJb107KmfpvybM+bqVIBFfzWS87jZPL1xHKe+IYa0u/sYrysg/i8ITSdnv2Iyni
         Ge5A==
X-Gm-Message-State: ABy/qLbn9XOCN7neXdA5v8svkFAbpnNOsS5L9/r/G23EaS956JdX8qti
        7/EMZyxa1uyicYv/AqUZJJ3D+dh/e83z6+Si
X-Google-Smtp-Source: APBJJlE07xGsF+T8VwpNf+vzMb7xCWgMW2wkAUXSoba/cYRX8PQTLWxD8xY/UgGAeecgR6Yrkm/cfEiUn0RQpzi8
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:8d51:0:b0:579:fa4c:1f22 with SMTP
 id w17-20020a818d51000000b00579fa4c1f22mr224500ywj.6.1689836915238; Thu, 20
 Jul 2023 00:08:35 -0700 (PDT)
Date:   Thu, 20 Jul 2023 07:08:21 +0000
In-Reply-To: <20230720070825.992023-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720070825.992023-5-yosryahmed@google.com>
Subject: [RFC PATCH 4/8] memcg: support deferred memcg recharging
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The previous patch added support for memcg recharging for mapped folios
when a memcg goes offline. For unmapped folios, it is not straighforward
to find a rightful memcg to recharge the folio to. Hence, add support
for deferred recharging.

Deferred recharging provides a hook that can be added in data access
paths: folio_memcg_deferred_recharge().

folio_memcg_deferred_recharge() will check if the memcg that the folio
is charged to is offline. If so, it will queue an asynchronous worker to
attempt to recharge the folio to the memcg of the process accessing the
folio. An asynchronous worker is used for 2 reasons:
(a) Avoid expensive operations on the data access path.
(b) Acquring some locks (e.g. folio lock, lruvec lock) is not safe to do
    from all contexts.

Deferring recharging will not cause an OOM kill in the target memcg. If
recharging fails for any reason, the worker reschedules itself to retry,
unless the folio is freed or the target memcg goes offline.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/memcontrol.h |   6 ++
 mm/memcontrol.c            | 125 +++++++++++++++++++++++++++++++++++--
 2 files changed, 126 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b41d69685ead..59b653d4a76e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -956,6 +956,8 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 void folio_memcg_lock(struct folio *folio);
 void folio_memcg_unlock(struct folio *folio);
 
+void folio_memcg_deferred_recharge(struct folio *folio);
+
 void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
 
 /* try to stablize folio_memcg() for all the pages in a memcg */
@@ -1461,6 +1463,10 @@ static inline void mem_cgroup_unlock_pages(void)
 	rcu_read_unlock();
 }
 
+static inline void folio_memcg_deferred_recharge(struct folio *folio)
+{
+}
+
 static inline void mem_cgroup_handle_over_high(void)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a46bc8f000c8..cf9fb51ecfcc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6398,6 +6398,7 @@ static bool mem_cgroup_recharge_folio(struct folio *folio,
 }
 
 struct folio_memcg_rmap_recharge_arg {
+	struct mem_cgroup *memcg;
 	bool recharged;
 };
 
@@ -6415,10 +6416,12 @@ static bool folio_memcg_rmap_recharge_one(struct folio *folio,
 	 */
 	recharge_arg->recharged = false;
 	while (page_vma_mapped_walk(&pvmw)) {
-		memcg = get_mem_cgroup_from_mm(vma->vm_mm);
+		memcg = recharge_arg->memcg ?:
+			get_mem_cgroup_from_mm(vma->vm_mm);
 		if (mem_cgroup_recharge_folio(folio, memcg))
 			recharge_arg->recharged = true;
-		mem_cgroup_put(memcg);
+		if (!recharge_arg->memcg)
+			mem_cgroup_put(memcg);
 		page_vma_mapped_walk_done(&pvmw);
 		break;
 	}
@@ -6428,9 +6431,13 @@ static bool folio_memcg_rmap_recharge_one(struct folio *folio,
 }
 
 /* Returns true if recharging is successful */
-static bool folio_memcg_rmap_recharge(struct folio *folio)
+static bool folio_memcg_rmap_recharge(struct folio *folio,
+				      struct mem_cgroup *memcg)
 {
-	struct folio_memcg_rmap_recharge_arg arg = { .recharged = false };
+	struct folio_memcg_rmap_recharge_arg arg = {
+		.recharged = false,
+		.memcg = memcg,
+	};
 	struct rmap_walk_control rwc = {
 		.rmap_one = folio_memcg_rmap_recharge_one,
 		.arg = (void *)&arg,
@@ -6527,7 +6534,7 @@ static bool memcg_recharge_lruvec_list(struct lruvec *lruvec,
 			continue;
 		}
 
-		if (folio_memcg_rmap_recharge(folio))
+		if (folio_memcg_rmap_recharge(folio, NULL))
 			*nr_recharged += folio_nr_pages(folio);
 
 		folio_unlock(folio);
@@ -6587,6 +6594,114 @@ static void memcg_recharge_mapped_folios(struct mem_cgroup *memcg)
 	}
 }
 
+/* Result is only stable if @folio is locked */
+static bool should_do_deferred_recharge(struct folio *folio)
+{
+	struct mem_cgroup *memcg;
+	bool ret;
+
+	rcu_read_lock();
+	memcg = folio_memcg_rcu(folio);
+	ret = memcg && !!(memcg->css.flags & CSS_DYING);
+	rcu_read_unlock();
+
+	return ret;
+}
+
+struct deferred_recharge_work {
+	struct folio *folio;
+	struct mem_cgroup *memcg;
+	struct work_struct work;
+};
+
+static void folio_memcg_do_deferred_recharge(struct work_struct *work)
+{
+	struct deferred_recharge_work *recharge_work = container_of(work,
+					struct deferred_recharge_work, work);
+	struct folio *folio = recharge_work->folio;
+	struct mem_cgroup *new = recharge_work->memcg;
+	struct mem_cgroup *old;
+
+	/* We are holding the last ref to the folio, let it be freed */
+	if (unlikely(folio_ref_count(folio) == 1))
+		goto out;
+
+	if (!folio_isolate_lru(folio))
+		goto out;
+
+	if (unlikely(!folio_trylock(folio)))
+		goto out_putback;
+
+	/* @folio was already recharged since the worker was queued? */
+	if (unlikely(!should_do_deferred_recharge(folio)))
+		goto out_unlock;
+
+	/* @folio was already recharged to @new and it already went offline? */
+	old = folio_memcg(folio);
+	if (unlikely(old == new))
+		goto out_unlock;
+
+	/*
+	 * folio_mapped() must remain stable during the move. If the folio is
+	 * mapped, we must use rmap recharge to serialize against unmapping.
+	 * Otherwise, if the folio is unmapped, the folio lock is held so this
+	 * should prevent faults against the pagecache or swapcache to map it.
+	 */
+	mem_cgroup_start_move_charge(old);
+	if (folio_mapped(folio))
+		folio_memcg_rmap_recharge(folio, new);
+	else
+		mem_cgroup_recharge_folio(folio, new);
+	mem_cgroup_end_move_charge(old);
+
+out_unlock:
+	folio_unlock(folio);
+out_putback:
+	folio_putback_lru(folio);
+out:
+	folio_put(folio);
+	mem_cgroup_put(new);
+	kfree(recharge_work);
+}
+
+/*
+ * Queue deferred work to recharge @folio to current's memcg if needed.
+ */
+void folio_memcg_deferred_recharge(struct folio *folio)
+{
+	struct deferred_recharge_work *recharge_work = NULL;
+	struct mem_cgroup *memcg = NULL;
+
+	/* racy check, the async worker will check again with @folio locked */
+	if (likely(!should_do_deferred_recharge(folio)))
+		return;
+
+	if (unlikely(!memcg_recharge_wq))
+		return;
+
+	if (unlikely(!folio_try_get(folio)))
+		return;
+
+	memcg = get_mem_cgroup_from_mm(current->mm);
+	if (!memcg)
+		goto fail;
+
+	recharge_work = kmalloc(sizeof(*recharge_work), GFP_ATOMIC);
+	if (!recharge_work)
+		goto fail;
+
+	/* we hold refs to both the folio and the memcg we are charging to */
+	recharge_work->folio = folio;
+	recharge_work->memcg = memcg;
+	INIT_WORK(&recharge_work->work, folio_memcg_do_deferred_recharge);
+	queue_work(memcg_recharge_wq, &recharge_work->work);
+	return;
+fail:
+	kfree(recharge_work);
+	mem_cgroup_put(memcg);
+	folio_put(folio);
+}
+
 #ifdef CONFIG_LRU_GEN
 static void mem_cgroup_attach(struct cgroup_taskset *tset)
 {
-- 
2.41.0.255.g8b1d071c50-goog

