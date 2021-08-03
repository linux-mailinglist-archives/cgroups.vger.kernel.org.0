Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD4D3DF434
	for <lists+cgroups@lfdr.de>; Tue,  3 Aug 2021 19:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbhHCRz4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Aug 2021 13:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238468AbhHCRzz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Aug 2021 13:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628013344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=TSdLbIa17Dn1sbXRatCyAZJSnstw1gwhMZIeM9izR74=;
        b=dObDnN88v7VkS6/uej3PMzBmEVht9Q6ox3jxUmfi6Tcdl+aU657qW7slqEfH4QXMfx6jQR
        PlcpOgRKFiPiTLCaoR/n7dtpaIRT/igG5POoSLFJtYAMs1eXOd7Fb87gSKLUZ7onBzMTnz
        EHHfJgXML+qIItjEw+3Q4O5PZMHDsnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-mJ0SJSudN9-XCPEmJb--rQ-1; Tue, 03 Aug 2021 13:55:43 -0400
X-MC-Unique: mJ0SJSudN9-XCPEmJb--rQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F91B190A7A0;
        Tue,  3 Aug 2021 17:55:41 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C560A19C44;
        Tue,  3 Aug 2021 17:55:35 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Luis Goncalves <lgoncalv@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/memcg: Disable task obj_stock for PREEMPT_RT
Date:   Tue,  3 Aug 2021 13:55:19 -0400
Message-Id: <20210803175519.22298-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For PREEMPT_RT kernel, preempt_disable() and local_irq_save()
are typically converted to local_lock() and local_lock_irqsave()
respectively. These two variants of local_lock() are essentially
the same. Thus, there is no performance advantage in choosing one
over the other.

As there is no point in maintaining two different sets of obj_stock,
it is simpler and more efficient to just disable task_obj and use
only irq_obj for PREEMPT_RT. However, task_obj will still be there
in the memcg_stock_pcp structure even though it is not used in this
configuration.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 87c883227f90..4f80770cb97b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2120,12 +2120,22 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
  * which is cheap in non-preempt kernel. The interrupt context object stock
  * can only be accessed after disabling interrupt. User context code can
  * access interrupt object stock, but not vice versa.
+ *
+ * For PREEMPT_RT kernel, preempt_disable() and local_irq_save() may have
+ * to be changed to variants of local_lock(). This eliminates the
+ * performance advantage of using preempt_disable(). Fall back to always
+ * use local_irq_save() and use only irq_obj for simplicity.
  */
+static inline bool use_task_obj_stock(void)
+{
+	return !IS_ENABLED(CONFIG_PREEMPT_RT) && likely(in_task());
+}
+
 static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
 {
 	struct memcg_stock_pcp *stock;
 
-	if (likely(in_task())) {
+	if (use_task_obj_stock()) {
 		*pflags = 0UL;
 		preempt_disable();
 		stock = this_cpu_ptr(&memcg_stock);
@@ -2139,7 +2149,7 @@ static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
 
 static inline void put_obj_stock(unsigned long flags)
 {
-	if (likely(in_task()))
+	if (use_task_obj_stock())
 		preempt_enable();
 	else
 		local_irq_restore(flags);
@@ -2212,7 +2222,7 @@ static void drain_local_stock(struct work_struct *dummy)
 
 	stock = this_cpu_ptr(&memcg_stock);
 	drain_obj_stock(&stock->irq_obj);
-	if (in_task())
+	if (use_task_obj_stock())
 		drain_obj_stock(&stock->task_obj);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
@@ -3217,7 +3227,7 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 {
 	struct mem_cgroup *memcg;
 
-	if (in_task() && stock->task_obj.cached_objcg) {
+	if (use_task_obj_stock() && stock->task_obj.cached_objcg) {
 		memcg = obj_cgroup_memcg(stock->task_obj.cached_objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
 			return true;
-- 
2.18.1

