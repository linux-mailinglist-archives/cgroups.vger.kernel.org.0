Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE4867AB04
	for <lists+cgroups@lfdr.de>; Wed, 25 Jan 2023 08:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbjAYHhN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Jan 2023 02:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbjAYHg4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Jan 2023 02:36:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96A64902C
        for <cgroups@vger.kernel.org>; Tue, 24 Jan 2023 23:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674632166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cta4F9u/56j6UuYJx1HDD/ltBRbZgzhdAn9u+4PdIyQ=;
        b=PX8YfOcUQ9+4SqkymxPco8kbg9Q5hvtS/sv54cDrH/YEloZa3Wf9aLDfRKHh0LQ5t0htcf
        TML3pLGjtZkvua6rFoZUytr6W3EmSl3Yh9U+W+5dfAC8IgkQZBAdYZljKi3Hru0WQkwK61
        JCQwKwmbUNomzoIEoLRW+syeqiDDZ98=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-14-zo8wgKeUPpKvx2XKUZoRGA-1; Wed, 25 Jan 2023 02:36:05 -0500
X-MC-Unique: zo8wgKeUPpKvx2XKUZoRGA-1
Received: by mail-oi1-f199.google.com with SMTP id l1-20020aca1901000000b0036cd9d01876so5596682oii.19
        for <cgroups@vger.kernel.org>; Tue, 24 Jan 2023 23:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cta4F9u/56j6UuYJx1HDD/ltBRbZgzhdAn9u+4PdIyQ=;
        b=J9MFhBGFxahiX7ZxL2DIXom7rMQ//1Z8xfCeHikIyTuaRFNnkReA4ZIhR0OJAa8qOn
         HLXYXTh2oIPbAU4DM3a/ndp5ylWiw0dot96D5AvfQNc4mp5r520THllQ9pMHgniqWAyP
         sihgUrxk3VDti/OmEtCRAlBZPW1XdSTXoFOjjJs3U2e2IeMil/J6QQldZGZr0g832f3m
         UiWippBp340FVcF/KoNynI5V0vL78EJUW1M1dwf3g1P5Xfli4JzlyS23l/FRSt1iGmy9
         qyLPU95DDMKUnR259Vi1+igbpZ33ZwNg9Y4Qy2Y60DOSOwTviW/FbEM32uO1DviE8f2s
         dunQ==
X-Gm-Message-State: AFqh2ko6Hl5VxsUYB+BYlVjXFhD779bkVIy3XJw9jyM7d/6spi3+pqBd
        xuD1rGqX8D6n2SyDHDb/Si3FtCQlNF+4pzo6hZz2sGIGbJKRP0sFMFGcbl4RsvehfaqG2V7N/g8
        n6aUL0FM8vmPV1CkNBw==
X-Received: by 2002:a4a:d307:0:b0:4f5:2a03:b22a with SMTP id g7-20020a4ad307000000b004f52a03b22amr14131798oos.4.1674632164303;
        Tue, 24 Jan 2023 23:36:04 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsEUpYG3GHiKEkFMX0XaGUeQBQJBtt1RE/vEB6cze/oEgxS7/YGFSUZjjX5dJWUBMfQRU1UMg==
X-Received: by 2002:a4a:d307:0:b0:4f5:2a03:b22a with SMTP id g7-20020a4ad307000000b004f52a03b22amr14131784oos.4.1674632164048;
        Tue, 24 Jan 2023 23:36:04 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a800:14fa:9361:c141:6c70:c877])
        by smtp.gmail.com with ESMTPSA id x189-20020a4a41c6000000b0050dc79bb80esm1538802ooa.27.2023.01.24.23.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 23:36:03 -0800 (PST)
From:   Leonardo Bras <leobras@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Leonardo Bras <leobras@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] mm/memcontrol: Perform all stock drain in current CPU
Date:   Wed, 25 Jan 2023 04:35:01 -0300
Message-Id: <20230125073502.743446-5-leobras@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125073502.743446-1-leobras@redhat.com>
References: <20230125073502.743446-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When drain_all_stock() is called, some CPUs will be required to have their
per-CPU caches drained. This currently happens by scheduling a call to
drain_local_stock() to run in each affected CPU.

This, as a consequence, may end up scheduling work to CPUs that are
isolated, and therefore should have as little interruption as possible.

In order to avoid this, run all CPUs stock drain directly from the
current CPU. This should be fine as long as drain_all_stock() runs fast
enough so it don't often cause contention on consume_stock(),
refill_stock(), mod_objcg_state(), consume_obj_stock() or 
refill_obj_stock(). 

Also, since drain_all_stock() will be able to run on a remote CPU, protect
memcg_hotplug_cpu_dead() with stock_lock.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 mm/memcontrol.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 373fa78c4d881..5b7f7c2e0232f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2184,7 +2184,6 @@ struct memcg_stock_pcp {
 	int nr_slab_unreclaimable_b;
 #endif
 
-	struct work_struct work;
 	unsigned long flags;
 #define FLUSHING_CACHED_CHARGE	0
 };
@@ -2269,18 +2268,15 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 	stock->cached = NULL;
 }
 
-static void drain_local_stock(struct work_struct *dummy)
+static void drain_stock_from(struct memcg_stock_pcp *stock)
 {
-	struct memcg_stock_pcp *stock;
 	struct obj_cgroup *old = NULL;
 	unsigned long flags;
 
 	/*
-	 * The only protection from cpu hotplug (memcg_hotplug_cpu_dead) vs.
-	 * drain_stock races is that we always operate on local CPU stock
-	 * here with IRQ disabled
+	 * The protection from cpu hotplug (memcg_hotplug_cpu_dead) vs.
+	 * drain_stock races is stock_lock, a percpu spinlock.
 	 */
-	stock = this_cpu_ptr(&memcg_stock);
 	spin_lock_irqsave(&stock->stock_lock, flags);
 
 	old = drain_obj_stock(stock);
@@ -2329,7 +2325,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
  */
 static void drain_all_stock(struct mem_cgroup *root_memcg)
 {
-	int cpu, curcpu;
+	int cpu;
 
 	/* If someone's already draining, avoid adding running more workers. */
 	if (!mutex_trylock(&percpu_charge_mutex))
@@ -2341,7 +2337,6 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 	 * per-cpu data. CPU up doesn't touch memcg_stock at all.
 	 */
 	migrate_disable();
-	curcpu = smp_processor_id();
 	for_each_online_cpu(cpu) {
 		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
 		struct mem_cgroup *memcg;
@@ -2357,12 +2352,8 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 		rcu_read_unlock();
 
 		if (flush &&
-		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
-			if (cpu == curcpu)
-				drain_local_stock(&stock->work);
-			else
-				schedule_work_on(cpu, &stock->work);
-		}
+		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags))
+			drain_stock_from(stock);
 	}
 	migrate_enable();
 	mutex_unlock(&percpu_charge_mutex);
@@ -2373,7 +2364,9 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 	struct memcg_stock_pcp *stock;
 
 	stock = &per_cpu(memcg_stock, cpu);
+	spin_lock(&stock->stock_lock);
 	drain_stock(stock);
+	spin_unlock(&stock->stock_lock);
 
 	return 0;
 }
@@ -7328,7 +7321,7 @@ __setup("cgroup.memory=", cgroup_memory);
  */
 static int __init mem_cgroup_init(void)
 {
-	int cpu, node;
+	int node;
 
 	/*
 	 * Currently s32 type (can refer to struct batched_lruvec_stat) is
@@ -7341,10 +7334,6 @@ static int __init mem_cgroup_init(void)
 	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
 				  memcg_hotplug_cpu_dead);
 
-	for_each_possible_cpu(cpu)
-		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
-			  drain_local_stock);
-
 	for_each_node(node) {
 		struct mem_cgroup_tree_per_node *rtpn;
 
-- 
2.39.1

