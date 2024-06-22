Return-Path: <cgroups+bounces-3274-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58CB9131D9
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 05:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663A8284C48
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 03:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFAABA20;
	Sat, 22 Jun 2024 03:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3GPzTvF"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B39E1804A
	for <cgroups@vger.kernel.org>; Sat, 22 Jun 2024 03:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719028741; cv=none; b=syNhBnV+3FGFmQtTHpmrVXiBbfE1vxBVg4bF+dCgWygd2Px1BGhei/njn+Wnz973JPm4k38pIjtOt245qRWLZjIXS3GS6vDVnvCaTKIrByHBVMpR3AY1Pp5Qz2LlFzFToDhTHgBfArF3QWS3y8MSMfw1H3Mq33Iw8lnFiWOk5Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719028741; c=relaxed/simple;
	bh=tHDi41RRtMNvwBdvauB8kKNY5rC479lW69KRFNCaPX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIt2oTbLA6scQwvay/andPyhti+XsS46z9GbdM8xCdwFoRta2hwtkNWOBycHwWJ3JlT98doltftGUWpfZ2Cs00XpsVoJhp6IWfWbqZanOgP4UXCRsuwFW2RlaN4H4uf2nMDKf3D6Niqp9ENvRxiO3M3eWQ/ppKntycKKftIEWPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3GPzTvF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719028739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kqjqAcyBF16xwLE61W3REKh7p8uOAAMqSPa12WNm3GE=;
	b=H3GPzTvF/BbzPbQByvKECxq6117YpVphymNwbN+teNK8e8plkTyrqDlhhgOBSFIkJhb9M4
	pHz5vX/FcC6PT43gE2q3NVjgUVPDVDXChjeBXziN+l/4hjndxnQBAREzOLz8wwDJKANS1D
	eJc/0GbQ25Mw6V9aoMR4nJRYPINVKYo=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-bIz1RFHxPlKJfG0GgDjm5Q-1; Fri, 21 Jun 2024 23:58:57 -0400
X-MC-Unique: bIz1RFHxPlKJfG0GgDjm5Q-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6e4d1605a03so3040585a12.3
        for <cgroups@vger.kernel.org>; Fri, 21 Jun 2024 20:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719028736; x=1719633536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqjqAcyBF16xwLE61W3REKh7p8uOAAMqSPa12WNm3GE=;
        b=Nu7dgXODioxlQfcyiu1T3Ahz9lsp9aZ5nCJOtBD2V0GrvfzV1fQQgN+xWmavqW14Rb
         9K6kIcEiHxUcDobJSyTE/zC95Yar/fdnEFvsu8hyIkM0MAgh04QZBJ2kLz3qxiPmVo+v
         gfuneQlje9T1KdcrfWPPVKGxoxv7+PofcM35YP/7C+xY+gOQU1kMHe7lxyd86/SLHhh8
         ibGR9/rrDCsBAyoOZt8RuICX1znJxf2pnE2M0PqLL/VO2D5S4VVNM9jbVKgrKPJcX9ZK
         vxNfxzTcs83ieTaJFhB/YIrtpmLPuyw9J2WvC48ryYKupRBsH4ikY39271QSyp5WJp/+
         T5Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWLJ5fmcDiU5fW/jBaUhT6W3NRPAStU6ukCl0MnN3EH3+N1978ehX+ALnrMpL+1vtUUDsnmm/2aKizCojM8mnhVATwoH4XqvQ==
X-Gm-Message-State: AOJu0YyJ9z3fTb41fuag0sGdfQQTP3Yl14HpVTHC5ykxUY4m5YYyKUjL
	JK70Jqq0OdbeVwgpzVLzw3d6xFdSMzWXnndxC40sOTpwjggt+7gRv/1sxOwTWkozP+6fOREezYb
	/a7hFaZeEQ59mwZSImYbdBGs5rxzyLZvHRFbS2pv0GhwRT7GIl9uuyiM=
X-Received: by 2002:a17:903:1cf:b0:1f6:92f1:b01c with SMTP id d9443c01a7336-1f9aa481248mr125471835ad.69.1719028736459;
        Fri, 21 Jun 2024 20:58:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsa/g3e768QiFMvXJv3hzlQlYWrPA/q475LVIhwI75gKqm/BT5XtIgr5pD5KmuF/MDMe+IuQ==
X-Received: by 2002:a17:903:1cf:b0:1f6:92f1:b01c with SMTP id d9443c01a7336-1f9aa481248mr125471745ad.69.1719028736115;
        Fri, 21 Jun 2024 20:58:56 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a801:c138:e21d:3579:5747:ad1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb32b9edsm21832365ad.118.2024.06.21.20.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 20:58:55 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 3/4] memcontrol: apply new queue_percpu_work_on() interface
Date: Sat, 22 Jun 2024 00:58:11 -0300
Message-ID: <20240622035815.569665-4-leobras@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622035815.569665-1-leobras@redhat.com>
References: <20240622035815.569665-1-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of the new qpw_{un,}lock*() and queue_percpu_work_on()
interface to improve performance & latency on PREEMTP_RT kernels.

For functions that may be scheduled in a different cpu, replace
local_{un,}lock*() by qpw_{un,}lock*(), and replace schedule_work_on() by
queue_percpu_work_on().

This change requires allocation of qpw_structs instead of a work_structs.

This should bring no relevant performance impact on non-RT kernels:
For functions that may be scheduled in a different cpu, the local_*lock's
this_cpu_ptr() becomes a per_cpu_ptr(smp_processor_id()).

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 mm/memcontrol.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 71fe2a95b8bd..18a987f8c998 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -59,20 +59,21 @@
 #include <linux/swap_cgroup.h>
 #include <linux/cpu.h>
 #include <linux/oom.h>
 #include <linux/lockdep.h>
 #include <linux/file.h>
 #include <linux/resume_user_mode.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
 #include <linux/sched/isolation.h>
 #include <linux/kmemleak.h>
+#include <linux/qpw.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
 #include "slab.h"
 #include "swap.h"
 
 #include <linux/uaccess.h>
 
 #include <trace/events/vmscan.h>
 
@@ -2415,21 +2416,21 @@ struct memcg_stock_pcp {
 	unsigned int nr_pages;
 
 #ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *cached_objcg;
 	struct pglist_data *cached_pgdat;
 	unsigned int nr_bytes;
 	int nr_slab_reclaimable_b;
 	int nr_slab_unreclaimable_b;
 #endif
 
-	struct work_struct work;
+	struct qpw_struct qpw;
 	unsigned long flags;
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
 	.stock_lock = INIT_LOCAL_LOCK(stock_lock),
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
 
 #ifdef CONFIG_MEMCG_KMEM
 static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock);
@@ -2503,39 +2504,40 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 		if (do_memsw_account())
 			page_counter_uncharge(&old->memsw, stock_pages);
 
 		WRITE_ONCE(stock->nr_pages, 0);
 	}
 
 	css_put(&old->css);
 	WRITE_ONCE(stock->cached, NULL);
 }
 
-static void drain_local_stock(struct work_struct *dummy)
+static void drain_local_stock(struct work_struct *w)
 {
 	struct memcg_stock_pcp *stock;
 	struct obj_cgroup *old = NULL;
 	unsigned long flags;
+	int cpu = qpw_get_cpu(w);
 
 	/*
 	 * The only protection from cpu hotplug (memcg_hotplug_cpu_dead) vs.
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	qpw_lock_irqsave(&memcg_stock.stock_lock, flags, cpu);
 
-	stock = this_cpu_ptr(&memcg_stock);
+	stock = per_cpu_ptr(&memcg_stock, cpu);
 	old = drain_obj_stock(stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	qpw_unlock_irqrestore(&memcg_stock.stock_lock, flags, cpu);
 	obj_cgroup_put(old);
 }
 
 /*
  * Cache charges(val) to local per_cpu area.
  * This will be consumed by consume_stock() function, later.
  */
 static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
@@ -2592,23 +2594,23 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 		if (memcg && READ_ONCE(stock->nr_pages) &&
 		    mem_cgroup_is_descendant(memcg, root_memcg))
 			flush = true;
 		else if (obj_stock_flush_required(stock, root_memcg))
 			flush = true;
 		rcu_read_unlock();
 
 		if (flush &&
 		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
 			if (cpu == curcpu)
-				drain_local_stock(&stock->work);
+				drain_local_stock(&stock->qpw.work);
 			else if (!cpu_is_isolated(cpu))
-				schedule_work_on(cpu, &stock->work);
+				queue_percpu_work_on(cpu, system_wq, &stock->qpw);
 		}
 	}
 	migrate_enable();
 	mutex_unlock(&percpu_charge_mutex);
 }
 
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
 	struct memcg_stock_pcp *stock;
 
@@ -7956,22 +7958,22 @@ static int __init mem_cgroup_init(void)
 	 * used for per-memcg-per-cpu caching of per-node statistics. In order
 	 * to work fine, we should make sure that the overfill threshold can't
 	 * exceed S32_MAX / PAGE_SIZE.
 	 */
 	BUILD_BUG_ON(MEMCG_CHARGE_BATCH > S32_MAX / PAGE_SIZE);
 
 	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
 				  memcg_hotplug_cpu_dead);
 
 	for_each_possible_cpu(cpu)
-		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
-			  drain_local_stock);
+		INIT_QPW(&per_cpu_ptr(&memcg_stock, cpu)->qpw,
+			 drain_local_stock, cpu);
 
 	for_each_node(node) {
 		struct mem_cgroup_tree_per_node *rtpn;
 
 		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
 
 		rtpn->rb_root = RB_ROOT;
 		rtpn->rb_rightmost = NULL;
 		spin_lock_init(&rtpn->lock);
 		soft_limit_tree.rb_tree_per_node[node] = rtpn;
-- 
2.45.2


