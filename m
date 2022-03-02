Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299174CA86B
	for <lists+cgroups@lfdr.de>; Wed,  2 Mar 2022 15:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbiCBOrE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Mar 2022 09:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiCBOrD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Mar 2022 09:47:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC051C627D
        for <cgroups@vger.kernel.org>; Wed,  2 Mar 2022 06:46:20 -0800 (PST)
Date:   Wed, 2 Mar 2022 15:46:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646232378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PpxvpaW7wGw/ZOsSQfgwEFQcmBDCMW9CjHzv6C/1/8s=;
        b=VAqsDfA05L/UKHxCLqWaMOIvNQh4FjZfmAqtPhVH65b1wOk4T3tV4WAmK7XY+1gAdk4qJg
        hr64GyLFSRmleqCMpjurxIdzY5xmsZRCF0iGlB/bXhM+xyJKU/R3AJk4M04DGsCWtu/b5V
        RqHDY0xXJkbe6I9f6/BAvqaQFqb/fKjnm+0DIT0hKsgfCBi+mQ9Mfw0ynrFC8EBevtWk2o
        /a/E8s6ozK7O8kK4ifEWpNx8w0Z7BFj7CrTZzVJp6FJZddvmrjLQ9CZUbcg28UbvqKKBOj
        Fq16Dq0ptToFuHv2KtH1F/C3vfU2FoYdX6ytpkL28y1Zmu2XeM4aqV/cdxz5Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646232378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PpxvpaW7wGw/ZOsSQfgwEFQcmBDCMW9CjHzv6C/1/8s=;
        b=4fKvI7QRhukl8Z2nIjFhR4UnkZXhUnIctHZf2n93YEcuHLFPDrGOejNEwmnME6IaTinIND
        UhA5AooQA+/4iJCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] cgroup: Add a comment to cgroup_rstat_flush_locked().
Message-ID: <Yh+DOK73hfVV5ThX@linutronix.de>
References: <[PATCH0/2]CorrectlockingassumptiononPREEMPT_RT>
 <20220301122143.1521823-1-bigeasy@linutronix.de>
 <20220301122143.1521823-2-bigeasy@linutronix.de>
 <Yh8Q+wjgk6dkDphR@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yh8Q+wjgk6dkDphR@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add a comment why spin_lock_irq() -> raw_spin_lock_irqsave() is needed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
On 2022-03-01 20:38:51 [-1000], Tejun Heo wrote:
> Hello,

Hello Tejun,

> Can you please add a comment explaining why irqsave is being used? As it
> stands, it just looks spurious.

Something like this?

 kernel/cgroup/rstat.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 53b771c20ee50..ba7a660184e41 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -155,6 +155,14 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 		struct cgroup *pos = NULL;
 		unsigned long flags;
 
+		/*
+		 * The _irqsave() is needed because cgroup_rstat_lock is
+		 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
+		 * this lock with the _irq() suffix only disables interrupts on
+		 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
+		 * interrupts on both configurations. The _irqsave() ensures
+		 * that interrupts are always disabled and later restored.
+		 */
 		raw_spin_lock_irqsave(cpu_lock, flags);
 		while ((pos = cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu))) {
 			struct cgroup_subsys_state *css;
-- 
2.35.1
