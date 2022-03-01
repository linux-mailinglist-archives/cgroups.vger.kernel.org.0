Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A144C8B70
	for <lists+cgroups@lfdr.de>; Tue,  1 Mar 2022 13:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiCAMWe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Mar 2022 07:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiCAMWe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Mar 2022 07:22:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4058AE66
        for <cgroups@vger.kernel.org>; Tue,  1 Mar 2022 04:21:51 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646137309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUBk7M1p4qT8w0880DAS1B5RVZj8zKAyQHnUzb2B04o=;
        b=yqfU0FGa/FFsP/tXBmGXAmkcVFEW6qwWKW7rdEDhMt9JcB/cBEMGMLiovt9W5I7aNSDgo6
        aHhXKGRVU6B7fcrzRh6JuA3hK8ZdDp2C2Q4xFaPOjBkinEgVDXKE1As8ps8773KO1PbXfN
        Kzgj4TVPIIMhzoc/GvGPbycuq2aLtQ5JD6tru1i7RhqOJeaZ8G5x33JXjPzu6RHiSIjSt9
        HYigFQ78i1/a2IMXWEd3mZjovq21sgcdqn7UWiuFZefv7OxWD2KWL4XqQmiyCuLoz0mvb0
        ezv1Y7rZPgfRKgAuw2xx/y98a64UzTMlfQ1uRWCliqr5go45v0RyNJAGoI+cWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646137309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUBk7M1p4qT8w0880DAS1B5RVZj8zKAyQHnUzb2B04o=;
        b=vEnEhqWH8/NN/WnJEWUI6fe60nLv7e3Whi+F6PRtEjJaHl38C8AqTyeu0NIwNYrWGajBZh
        UZ6Iw0A0X4fBfZBg==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] cgroup: Use irqsave in cgroup_rstat_flush_locked().
Date:   Tue,  1 Mar 2022 13:21:42 +0100
Message-Id: <20220301122143.1521823-2-bigeasy@linutronix.de>
In-Reply-To: <20220301122143.1521823-1-bigeasy@linutronix.de>
References: <[PATCH 0/2] Correct locking assumption on PREEMPT_RT>
 <20220301122143.1521823-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

All callers of cgroup_rstat_flush_locked() acquire cgroup_rstat_lock
either with spin_lock_irq() or spin_lock_irqsave().
cgroup_rstat_flush_locked() itself acquires cgroup_rstat_cpu_lock which
is a raw_spin_lock. This lock is also acquired in cgroup_rstat_updated()
in IRQ context and therefore requires _irqsave() locking suffix in
cgroup_rstat_flush_locked().
Since there is no difference between spin_lock_t and raw_spin_lock_t
on !RT lockdep does not complain here. On RT lockdep complains because
the interrupts were not disabled here and a deadlock is possible.

Acquire the raw_spin_lock_t with disabled interrupts.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/cgroup/rstat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 9d331ba44870a..53b771c20ee50 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -153,8 +153,9 @@ static void cgroup_rstat_flush_locked(struct cgroup *cg=
rp, bool may_sleep)
 		raw_spinlock_t *cpu_lock =3D per_cpu_ptr(&cgroup_rstat_cpu_lock,
 						       cpu);
 		struct cgroup *pos =3D NULL;
+		unsigned long flags;
=20
-		raw_spin_lock(cpu_lock);
+		raw_spin_lock_irqsave(cpu_lock, flags);
 		while ((pos =3D cgroup_rstat_cpu_pop_updated(pos, cgrp, cpu))) {
 			struct cgroup_subsys_state *css;
=20
@@ -166,7 +167,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cg=
rp, bool may_sleep)
 				css->ss->css_rstat_flush(css, cpu);
 			rcu_read_unlock();
 		}
-		raw_spin_unlock(cpu_lock);
+		raw_spin_unlock_irqrestore(cpu_lock, flags);
=20
 		/* if @may_sleep, play nice and yield if necessary */
 		if (may_sleep && (need_resched() ||
--=20
2.35.1

