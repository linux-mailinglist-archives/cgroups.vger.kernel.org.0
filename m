Return-Path: <cgroups+bounces-9275-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A76B2C28B
	for <lists+cgroups@lfdr.de>; Tue, 19 Aug 2025 14:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28611A0066B
	for <lists+cgroups@lfdr.de>; Tue, 19 Aug 2025 11:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9356335BD6;
	Tue, 19 Aug 2025 11:56:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CA8335BB1;
	Tue, 19 Aug 2025 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604602; cv=none; b=GQAeQRxWq5+2qWEif4asrv8C8a/RGo9WPIpe2XvyOMHOcRfeY2CLd2TpOHPf9hYZ9KSMrckJnT4C40tiE+AUp5Gc+r5iaV1XIQ8u5kp52jB9HZrVU/8zLd4qV1iXqDQoLQS+R0MOp0lCsPV+Xjiu8ib6Ta5ZnMQEdDqCI4ELqXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604602; c=relaxed/simple;
	bh=BBc4qktafzeeoB3et84zl/DrK/MKQK1W4gtygBAL5d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+bMJEyIg3vdfzA2cwETdyG8l8KluUdJX1dYjMa8acD/kWthmVdA2dJMoYAAxDmOhLGztfVGqmfI9Zw+4vAeL0lSwHX7sQwgn4gQXOd8PadiwP8bNtjTw+S5HaPfB9VuiRdhB64ZhVDX/D/cB9Z0T5jblkipLfHEE2uVIAkoYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
From: Maarten Lankhorst <dev@lankhorst.se>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?=27Thomas=20Hellstr=C3=B6m=27?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <dev@lankhorst.se>,
	Maxime Ripard <mripard@kernel.org>,
	Natalie Vock <natalie.vock@gmx.de>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?=27Michal=20Koutn=C3=BD=27?= <mkoutny@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"'Liam R . Howlett'" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Michal Hocko <mhocko@suse.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC 2/3] cgroup/dmem: Implement pinning device memory
Date: Tue, 19 Aug 2025 13:49:35 +0200
Message-ID: <20250819114932.597600-7-dev@lankhorst.se>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250819114932.597600-5-dev@lankhorst.se>
References: <20250819114932.597600-5-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function to pin, and to unipn memory and adjust the calculations
in dmem_cgroup_state_evict_valuable().

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 include/linux/cgroup_dmem.h |  2 ++
 kernel/cgroup/dmem.c        | 57 +++++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
index dd4869f1d736e..a981bb692ba22 100644
--- a/include/linux/cgroup_dmem.h
+++ b/include/linux/cgroup_dmem.h
@@ -21,6 +21,8 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 			   struct dmem_cgroup_pool_state **ret_pool,
 			   struct dmem_cgroup_pool_state **ret_limit_pool);
 void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size);
+int dmem_cgroup_try_pin(struct dmem_cgroup_pool_state *pool, u64 size);
+void dmem_cgroup_unpin(struct dmem_cgroup_pool_state *pool, u64 size);
 bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      struct dmem_cgroup_pool_state *test_pool,
 				      bool ignore_low, bool *ret_hit_low);
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 10b63433f0573..ec8b1ffec78de 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -147,6 +147,11 @@ static u64 get_resource_current(struct dmem_cgroup_pool_state *pool)
 	return pool ? page_counter_read(&pool->cnt) : 0;
 }
 
+static u64 get_resource_pinned(struct dmem_cgroup_pool_state *pool)
+{
+	return pool ? page_counter_pinned(&pool->cnt) : 0;
+}
+
 static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
 {
 	set_resource_min(rpool, 0);
@@ -270,7 +275,7 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 {
 	struct dmem_cgroup_pool_state *pool = test_pool;
 	struct page_counter *ctest;
-	u64 used, min, low;
+	u64 used, min, low, pinned;
 
 	/* Can always evict from current pool, despite limits */
 	if (limit_pool == test_pool)
@@ -296,16 +301,18 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 
 	ctest = &test_pool->cnt;
 
+	/* Protection is calculated without pinned memory */
 	dmem_cgroup_calculate_protection(limit_pool, test_pool);
 
 	used = page_counter_read(ctest);
-	min = READ_ONCE(ctest->emin);
+	pinned = page_counter_pinned(ctest);
+	min = READ_ONCE(ctest->emin) + pinned;
 
 	if (used <= min)
 		return false;
 
 	if (!ignore_low) {
-		low = READ_ONCE(ctest->elow);
+		low = READ_ONCE(ctest->elow) + pinned;
 		if (used > low)
 			return true;
 
@@ -641,6 +648,41 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 }
 EXPORT_SYMBOL_GPL(dmem_cgroup_try_charge);
 
+/**
+ * dmem_cgroup_unpin() - Unpin from a pool.
+ * @pool: Pool to unpin.
+ * @size: Size to unpin.
+ *
+ * Undoes the effects of dmem_cgroup_try_pin.
+ * Must be called with the returned pool as argument,
+ * and same @index and @size.
+ */
+void dmem_cgroup_unpin(struct dmem_cgroup_pool_state *pool, u64 size)
+{
+	if (pool)
+		page_counter_unpin(&pool->cnt, size);
+}
+EXPORT_SYMBOL_GPL(dmem_cgroup_unpin);
+
+/**
+ * dmem_cgroup_try_pin() - Try pinning an existing allocation to a region.
+ * @pool: dmem region to pin
+ * @size: Size (in bytes) to pin.
+ *
+ * This function pins in @pool for a size of @size bytes.
+ *
+ * If the function succeeds, the memory is succesfully accounted as being pinned.
+ * The memory may not be uncharged before unpin is called.
+ *
+ * Return: 0 on success, -EAGAIN on hitting a limit, or a negative errno on failure.
+ */
+int dmem_cgroup_try_pin(struct dmem_cgroup_pool_state *pool, u64 size)
+{
+	return page_counter_try_pin(&pool->cnt, size) ? 0 : -EAGAIN;
+
+}
+EXPORT_SYMBOL_GPL(dmem_cgroup_try_pin);
+
 static int dmem_cgroup_region_capacity_show(struct seq_file *sf, void *v)
 {
 	struct dmem_cgroup_region *region;
@@ -756,6 +798,11 @@ static int dmem_cgroup_region_current_show(struct seq_file *sf, void *v)
 	return dmemcg_limit_show(sf, v, get_resource_current);
 }
 
+static int dmem_cgroup_region_pinned_show(struct seq_file *sf, void *v)
+{
+	return dmemcg_limit_show(sf, v, get_resource_pinned);
+}
+
 static int dmem_cgroup_region_min_show(struct seq_file *sf, void *v)
 {
 	return dmemcg_limit_show(sf, v, get_resource_min);
@@ -799,6 +846,10 @@ static struct cftype files[] = {
 		.name = "current",
 		.seq_show = dmem_cgroup_region_current_show,
 	},
+	{
+		.name = "pinned",
+		.seq_show = dmem_cgroup_region_pinned_show,
+	},
 	{
 		.name = "min",
 		.write = dmem_cgroup_region_min_write,
-- 
2.50.0


