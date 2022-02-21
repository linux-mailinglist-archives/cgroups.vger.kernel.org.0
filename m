Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B843A4BDB90
	for <lists+cgroups@lfdr.de>; Mon, 21 Feb 2022 18:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357767AbiBUMRV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 07:17:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358272AbiBUMQy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 07:16:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7381275C7
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 04:12:58 -0800 (PST)
Date:   Mon, 21 Feb 2022 13:12:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645445577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yd/Pv+4yxzI82Y3+KCMMwqZi8uHiedOULtnxyEsK9t8=;
        b=m3j5uZqP2GnBz9hR9+ahcnj5LxQ2aWpUFQWTc7iK8aShO6qeDylvW3GDy0Y/y1umG/5PwK
        VxOLm+MUozqKrjqM0G04ESo/lBfFZ0h+ZMjVk4m88VhPuM48tw+0TYVWYDKEsdRpzXgEl5
        p5dzpEZ/O9sRbmkp+V1hQVvocMXOAUZL7/jpatstowYBwKVAMrwiANNR0YUbXLIqIxJwsW
        hYruaD48dcrYGwsXMmRo2GfzlU6sxZDRcNesCoaa2IA3cwHTNJrTRUlW7MA8NXa+WueGle
        zkN2DcDejQNJq3/tXQN9Ll9CxWj46szVpZ0p/Qf6Hiwma8poJcFCpCe1ZLEQvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645445577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yd/Pv+4yxzI82Y3+KCMMwqZi8uHiedOULtnxyEsK9t8=;
        b=6+LQBW68DRyoQknMvgtM57egwQzQtY3fDE2Hj5+0FOFcN17uowYcI+ITQiy/OpYjcowS1T
        upjLeYDCV0zU35Dw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3 3/5] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT where needed.
Message-ID: <YhOBxzv+4OuYMCqa@linutronix.de>
References: <20220217094802.3644569-1-bigeasy@linutronix.de>
 <20220217094802.3644569-4-bigeasy@linutronix.de>
 <CALvZod4eZWVfibhxu0P0ZQ35cB=vDbde=VNeXiBZfED=k3YPOQ@mail.gmail.com>
 <YhN4BSQ1RLomLoyl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhN4BSQ1RLomLoyl@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-02-21 12:31:18 [+0100], To Shakeel Butt wrote:
> > The call chains from rmap.c have not really disabled irqs. Actually
> > there is a comment in do_page_add_anon_rmap() "We use the irq-unsafe
> > __{inc|mod}_zone_page_stat because these counters are not modified in
> > interrupt context, and pte lock(a spinlock) is held, which implies
> > preemption disabled".
> > 
> > VM_BUG_ON(!irqs_disabled()) within memcg_stats_lock() would be giving
> > false error reports for CONFIG_PREEMPT_NONE kernels.
> 
> So three caller, including do_page_add_anon_rmap():
>    __mod_lruvec_page_state() -> __mod_lruvec_state() -> __mod_memcg_lruvec_state()
> 
> is affected. Here we get false warnings because interrupts may not be
> disabled and it is intended. Hmmm.
> The odd part is that this only affects certain idx so any kind of
> additional debugging would need to take this into account.
> What about memcg_rstat_updated()? It does:
> 
> |         x = __this_cpu_add_return(stats_updates, abs(val));
> |         if (x > MEMCG_CHARGE_BATCH) {
> |                 atomic_add(x / MEMCG_CHARGE_BATCH, &stats_flush_threshold);
> |                 __this_cpu_write(stats_updates, 0);
> |         }
> 
> The writes to stats_updates can happen from IRQ-context and with
> disabled preemption only. So this is not good, right?

So I made the following to avoid the wrong assert. Still not sure how
bad the hunk above.

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 97a88b63ee983..1bac4798b72ba 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -645,6 +645,13 @@ static void memcg_stats_lock(void)
 #endif
 }
 
+static void __memcg_stats_lock(void)
+{
+#ifdef CONFIG_PREEMPT_RT
+      preempt_disable();
+#endif
+}
+
 static void memcg_stats_unlock(void)
 {
 #ifdef CONFIG_PREEMPT_RT
@@ -728,7 +735,20 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
 
-	memcg_stats_lock();
+	/*
+	 * The caller from rmap relay on disabled preemption becase they never
+	 * update their counter from in-interrupt context. For these two
+	 * counters we check that the update is never performed from an
+	 * interrupt context while other caller need to have disabled interrupt.
+	 */
+	__memcg_stats_lock();
+	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
+		if (idx == NR_ANON_MAPPED || idx == NR_FILE_MAPPED)
+			WARN_ON_ONCE(!in_task());
+		else
+			WARN_ON_ONCE(!irqs_disabled());
+	}
+
 	/* Update memcg */
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
 

Sebastian
