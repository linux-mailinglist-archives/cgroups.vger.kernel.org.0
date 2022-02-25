Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391924C4894
	for <lists+cgroups@lfdr.de>; Fri, 25 Feb 2022 16:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiBYPSQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Feb 2022 10:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiBYPSP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Feb 2022 10:18:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1046437009
        for <cgroups@vger.kernel.org>; Fri, 25 Feb 2022 07:17:42 -0800 (PST)
Date:   Fri, 25 Feb 2022 16:17:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645802261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GRb+2qkiHEDDH9G/1JIbbgHYgu3fgWeEbLACig+UXdw=;
        b=3e7V0WReYycn9LxQofAy75Lu5aJjUV05vI3xjU35qX617bvbJFPUySzgha8//QWe+WlP7P
        TA/BMh1L+E4KS7erjIHkV309iIaqc44dAxwd4ZDExGolClsVazc1llmE9ZoaXg4LxZoK+4
        K49cZ4I40yT6pJZuZchklnlVIySURo9+CIDlqiimZjDW3GjuE1t2wU7EvF6N9bjWqGZZYN
        hBnmSQh6k6wYK7/ALRCH/HMphkeuHwlqmoUmdI3Dec6rct4YVA9QKzcUuz50AouBLtI1Dk
        r0w+ca/70Xq5A7/hcgz7uK838cEOtqzxb5HzUvCl45esaVIVJJne1ydI8RRWEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645802261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GRb+2qkiHEDDH9G/1JIbbgHYgu3fgWeEbLACig+UXdw=;
        b=tJIMaiB2JC3x804scY7JWnnQ0clm3NPSoZFdAxtMbTytHV83aV66p9NXIHhXgcH8dmq1gS
        BaWejrTh4lCo14BA==
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
Subject: [PATCH] mm/memcg: Add missing counter index which are not update in
 interrupt.
Message-ID: <YhjzE/8LgbULbj/C@linutronix.de>
References: <20220221182540.380526-1-bigeasy@linutronix.de>
 <20220221182540.380526-4-bigeasy@linutronix.de>
 <CALvZod7DfxHp+_NenW+NY81WN_Li4kEx4rDodb2vKhpC==sd5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALvZod7DfxHp+_NenW+NY81WN_Li4kEx4rDodb2vKhpC==sd5g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Shakeel Butt reported that I missed a few counters which are not updated
in-interrupt context and therefore disabling preemption is fine.

Please fold into:
     "Protect per-CPU counter by disabling preemption on PREEMPT_RT"

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/memcontrol.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9c29b1a0e6bec..7883e2f2af3e8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -743,10 +743,17 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	 */
 	__memcg_stats_lock();
 	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
-		if (idx == NR_ANON_MAPPED || idx == NR_FILE_MAPPED)
+		switch (idx) {
+		case NR_ANON_MAPPED:
+		case NR_FILE_MAPPED:
+		case NR_ANON_THPS:
+		case NR_SHMEM_PMDMAPPED:
+		case NR_FILE_PMDMAPPED:
 			WARN_ON_ONCE(!in_task());
-		else
+			break;
+		default:
 			WARN_ON_ONCE(!irqs_disabled());
+		}
 	}
 
 	/* Update memcg */
-- 
2.35.1

