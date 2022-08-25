Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9805A16E6
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 18:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242731AbiHYQmV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 12:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242791AbiHYQmF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 12:42:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3585B9FBA;
        Thu, 25 Aug 2022 09:42:00 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661445701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBDIufscYHVsHmPufaPAl/Vqv2LLB/GPVe+GUwmXUq8=;
        b=dwt4gAjuVE7mnQU8NsSY1OdNQ0rEZBIOo7TJBp+JnuKFR/KIJGimsOnnoMrAmxV7Ig+JT7
        O249Q23IW3M+loKcYaWWeCCbHsG9iBRknQ60mgpEXPa4N+Eode7esLr9CsWoLpckIV1KzI
        ayi8JaUVrbuLHKvfTbkZw3UEWBw409RJLoheWD5IzDo/LyyVLw6mJMQH2W1WsMcD3Dh2VU
        y0AoX+D8MvMAnXdwKQNdlX2Uq1K1KYhECqVDrC126boDaX4wUq6U9kgnOZqzw/EZZ46Kw8
        ahdSsDX24EgjlJ4uN9GjqVIcF/W2re4OGiNrAhu80st4X6zaYkG+ENS6mRRj9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661445701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBDIufscYHVsHmPufaPAl/Vqv2LLB/GPVe+GUwmXUq8=;
        b=/xWS01iGeCi7ocDyLNA4wcA1jGESk+49fcLFDvz6piEFCTHy/Cap5+B9ZdmwZa5+akYuxh
        YMeWgbw07cXCjbBw==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 5/8] mm/memcontrol: Replace the PREEMPT_RT conditionals
Date:   Thu, 25 Aug 2022 18:41:28 +0200
Message-Id: <20220825164131.402717-6-bigeasy@linutronix.de>
In-Reply-To: <20220825164131.402717-1-bigeasy@linutronix.de>
References: <20220825164131.402717-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Use VM_WARN_ON_IRQS_ENABLED() and preempt_disable/enable_nested() to
replace the CONFIG_PREEMPT_RT #ifdeffery.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/memcontrol.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b69979c9ced5c..d35b6fa560f0a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -597,25 +597,18 @@ static u64 flush_next_time;
  */
 static void memcg_stats_lock(void)
 {
-#ifdef CONFIG_PREEMPT_RT
-      preempt_disable();
-#else
-      VM_BUG_ON(!irqs_disabled());
-#endif
+	preempt_disable_nested();
+	VM_WARN_ON_IRQS_ENABLED();
 }
=20
 static void __memcg_stats_lock(void)
 {
-#ifdef CONFIG_PREEMPT_RT
-      preempt_disable();
-#endif
+	preempt_disable_nested();
 }
=20
 static void memcg_stats_unlock(void)
 {
-#ifdef CONFIG_PREEMPT_RT
-      preempt_enable();
-#endif
+	preempt_enable_nested();
 }
=20
 static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
@@ -715,7 +708,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, en=
um node_stat_item idx,
 	 * interrupt context while other caller need to have disabled interrupt.
 	 */
 	__memcg_stats_lock();
-	if (IS_ENABLED(CONFIG_DEBUG_VM) && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
 		switch (idx) {
 		case NR_ANON_MAPPED:
 		case NR_FILE_MAPPED:
@@ -725,7 +718,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, en=
um node_stat_item idx,
 			WARN_ON_ONCE(!in_task());
 			break;
 		default:
-			WARN_ON_ONCE(!irqs_disabled());
+			VM_WARN_ON_IRQS_ENABLED();
 		}
 	}
=20
--=20
2.37.2

