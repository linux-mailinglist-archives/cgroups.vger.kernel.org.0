Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95CD4BEB2D
	for <lists+cgroups@lfdr.de>; Mon, 21 Feb 2022 20:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiBUS1s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 13:27:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiBUS0f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 13:26:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDB6215
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 10:26:12 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645467969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvKLAjshqPjuJx5ztcwEtexZwZtdDzb7fAKUE2HVkQU=;
        b=PEzb3aIxfpjcvav45uwZ/XAP5tsylptBaf3coAMien+gIDOi0YgXo5W4taoeELpQnpJoQG
        dQwtURHyc3f2B992/qnd7aSncUnevwjtF2DQyTpU5LXD6Wl7xRHEIpycSFxb/io7sZlB/H
        QCw1DctrICIXLOOj1FFz3rrHknrGZWyKHfwKfHhgAp2NjrekZJScmRrh0nQErd6rv4L10c
        Wl9YiTaqNcTbElCaUKxzb5UhpUeAfmGnwVG294T8xFTjlnlBhA8iltld2TleYSsFFAdMNl
        sUs/8ovN0BpRyW3awA/TUkX/pHzD11/0ubUQ9rJqtsGL/DxIx29YFtNrQ7s4Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645467969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvKLAjshqPjuJx5ztcwEtexZwZtdDzb7fAKUE2HVkQU=;
        b=HNtHCBGBc/LlVUnDbybDcjrsjJz/mWiGnlx9SA6zjIRlEJG006jryfCkj40bgGuuuO8Zqp
        gJRFgF773pmfxiCQ==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 6/6] mm/memcg: Disable migration instead of preemption in drain_all_stock().
Date:   Mon, 21 Feb 2022 19:25:40 +0100
Message-Id: <20220221182540.380526-7-bigeasy@linutronix.de>
In-Reply-To: <20220221182540.380526-1-bigeasy@linutronix.de>
References: <20220221182540.380526-1-bigeasy@linutronix.de>
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

Before the for-each-CPU loop, preemption is disabled so that so that
drain_local_stock() can be invoked directly instead of scheduling a
worker. Ensuring that drain_local_stock() completed on the local CPU is
not correctness problem. It _could_ be that the charging path will be
forced to reclaim memory because cached charges are still waiting for
their draining.

Disabling preemption before invoking drain_local_stock() is problematic
on PREEMPT_RT due to the sleeping locks involved. To ensure that no CPU
migrations happens across the for_each_online_cpu() it is enouhg to use
migrate_disable() which disables migration and keeps context preemptible
to a sleeping lock can be acquired.

Use migrate_disable() instead of get_cpu() around the
for_each_online_cpu() loop.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
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

