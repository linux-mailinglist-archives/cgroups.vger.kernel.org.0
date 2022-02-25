Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD974C4F56
	for <lists+cgroups@lfdr.de>; Fri, 25 Feb 2022 21:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiBYUNo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Feb 2022 15:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbiBYUNn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Feb 2022 15:13:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28306181E78
        for <cgroups@vger.kernel.org>; Fri, 25 Feb 2022 12:13:11 -0800 (PST)
Date:   Fri, 25 Feb 2022 21:13:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645819989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/BpWwwa3UrrnGqWsSuMc0gDmuI2beFCWr4sjiH+86Ao=;
        b=s6tT3aqsGpNGkByofJ8qal7wMVDI0W7iqVOV12HqnDaiKUsxmrIOKh3k0eljr0PexTw4Gm
        Wu1Fdg2TsNtx7y51zvh0+DbStqHXUiilKWQh9EwkgqQm+5c3zraEfrWRJkwQNu1Jo8HTYj
        uGw3enVlEnmaWJHY3ohrmPWxjPvpuG5v5btCTtNfGodOYSm6Vjcpd7D6psCLzCRWY6DQ3r
        TxhrjGOCKAqbD5dXqReq4XvRlLbrxCsNaUrm5ag5LIMP0REukScBEoWJtRYLJ1w6lbG7mL
        2z9yGNPPUOQBQnxkdVF9XsCTm6oy/AQzvnCQ7pCiEI3iszSHkqJ3007RQT4ICQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645819989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/BpWwwa3UrrnGqWsSuMc0gDmuI2beFCWr4sjiH+86Ao=;
        b=bC/EK5l9Fp6eX5seGNFdGpmEbBkH3Jm745DF9MTAVqVkRNXhRpaxYCDISco2G5pQxZu47l
        ZXgnBdR98uPNi+AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 6/6] mm/memcg: Disable migration instead of preemption in
 drain_all_stock().
Message-ID: <Yhk4UzA++ucRDwNk@linutronix.de>
References: <20220221182540.380526-1-bigeasy@linutronix.de>
 <20220221182540.380526-7-bigeasy@linutronix.de>
 <YhSzWXyPe14vOaGa@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YhSzWXyPe14vOaGa@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Before the for-each-CPU loop, preemption is disabled so that so that
drain_local_stock() can be invoked directly instead of scheduling a
worker. Ensuring that drain_local_stock() completed on the local CPU is
not correctness problem. It _could_ be that the charging path will be
forced to reclaim memory because cached charges are still waiting for
their draining.

Disabling preemption before invoking drain_local_stock() is problematic
on PREEMPT_RT due to the sleeping locks involved. To ensure that no CPU
migrations happens across for_each_online_cpu() it is enouhg to use
migrate_disable() which disables migration and keeps context preemptible
to a sleeping lock can be acquired.
A race with CPU hotplug is not a problem because pcp data is not going away.
In the worst case we just schedule draining of an empty stock.

Use migrate_disable() instead of get_cpu() around the
for_each_online_cpu() loop.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Michal Hocko <mhocko@suse.com>
---
v4=E2=80=A6v5: Added Michal's notes regarding CPU hotplug.

 mm/memcontrol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3d7ccb104374c..9c29b1a0e6bec 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2293,7 +2293,8 @@ static void drain_all_stock(struct mem_cgroup *root_m=
emcg)
 	 * as well as workers from this path always operate on the local
 	 * per-cpu data. CPU up doesn't touch memcg_stock at all.
 	 */
-	curcpu =3D get_cpu();
+	migrate_disable();
+	curcpu =3D smp_processor_id();
 	for_each_online_cpu(cpu) {
 		struct memcg_stock_pcp *stock =3D &per_cpu(memcg_stock, cpu);
 		struct mem_cgroup *memcg;
@@ -2316,7 +2317,7 @@ static void drain_all_stock(struct mem_cgroup *root_m=
emcg)
 				schedule_work_on(cpu, &stock->work);
 		}
 	}
-	put_cpu();
+	migrate_enable();
 	mutex_unlock(&percpu_charge_mutex);
 }
=20
--=20
2.35.1

