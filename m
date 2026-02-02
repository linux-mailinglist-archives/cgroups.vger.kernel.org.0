Return-Path: <cgroups+bounces-13599-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB7sDe6bgGl2/wIAu9opvQ
	(envelope-from <cgroups+bounces-13599-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 13:43:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E6ECC70F
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 13:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA19302FAA1
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 12:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106ED366053;
	Mon,  2 Feb 2026 12:42:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958B2BEC4A;
	Mon,  2 Feb 2026 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770036138; cv=none; b=e7QRkXoRgB6lBwDZjwpK3A9xxxyCd/88EEzNL6zb7q+ebb2DvQynLgkNFbUmO9ljgxGqNX4q+GMjTa+2pOifw+KLyN0t1dG1nmgTDVG58Y5uRhiSRQR6M/Kfh2HPKjrNGzaxTwelGOzqDaWv9K7uPnNMplVmk0E0dHy50kF+wkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770036138; c=relaxed/simple;
	bh=CZneUFGCjV/AwtGXq/uupsPKB+F2Liry6whMcr+Ppg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KSMQjxHYLrm0KNJZlUVcgvWJml4+WwMhdlHC61NaWvHU2xx0e1RnbsFOBDwZMvDKqfmiG6pd5e/iemY4VMZturG9v4jUHGa5uhBrA09kYW5acWXLqEsv4vZAc7/YT0z75EeusA2Gc4eOdNJ4Hx17zGLDlt7Q/MM391o6XLy+r6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f4R7S63vkzYQv5x;
	Mon,  2 Feb 2026 20:41:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 882B84056F;
	Mon,  2 Feb 2026 20:42:10 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP1 (Coremail) with SMTP id cCh0CgDXj+WWm4Bpt7ipFw--.14648S5;
	Mon, 02 Feb 2026 20:42:10 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: dev@lankhorst.se,
	mripard@kernel.org,
	natalie.vock@gmx.de,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH -next v2 3/4] cgroup/dmem: avoid pool UAF
Date: Mon,  2 Feb 2026 12:27:18 +0000
Message-Id: <20260202122719.414466-4-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202122719.414466-1-chenridong@huaweicloud.com>
References: <20260202122719.414466-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXj+WWm4Bpt7ipFw--.14648S5
X-Coremail-Antispam: 1UD129KBjvJXoW3WrW5Cry3Jw1UJF47Gw15Arb_yoWxAF1UpF
	nIkFyYkr4rZr47Zrn2y3WDZF9aya1kXa1Dt3yxCw4Fvr4xXw1rtF1Dt345tFy5GFZ7G347
	XF4YkrZrCFWYy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUHWlkUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13599-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_TO(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 87E6ECC70F
X-Rspamd-Action: no action

From: Chen Ridong <chenridong@huawei.com>

An UAF issue was observed:

BUG: KASAN: slab-use-after-free in page_counter_uncharge+0x65/0x150
Write of size 8 at addr ffff888106715440 by task insmod/527

CPU: 4 UID: 0 PID: 527 Comm: insmod    6.19.0-rc7-next-20260129+ #11
Tainted: [O]=OOT_MODULE
Call Trace:
<TASK>
dump_stack_lvl+0x82/0xd0
kasan_report+0xca/0x100
kasan_check_range+0x39/0x1c0
page_counter_uncharge+0x65/0x150
dmem_cgroup_uncharge+0x1f/0x260

Allocated by task 527:

Freed by task 0:

The buggy address belongs to the object at ffff888106715400
which belongs to the cache kmalloc-512 of size 512
The buggy address is located 64 bytes inside of
freed 512-byte region [ffff888106715400, ffff888106715600)

The buggy address belongs to the physical page:

Memory state around the buggy address:
ffff888106715300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff888106715380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888106715400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
				     ^
ffff888106715480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff888106715500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

The issue occurs because a pool can still be held by a caller after its
associated memory region is unregistered. The current implementation frees
the pool even if users still hold references to it (e.g., before uncharge
operations complete).

This patch adds a reference counter to each pool, ensuring that a pool is
only freed when its reference count drops to zero.

Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgroup")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/dmem.c | 60 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 787b334e0f5d..1ea6afffa985 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -14,6 +14,7 @@
 #include <linux/mutex.h>
 #include <linux/page_counter.h>
 #include <linux/parser.h>
+#include <linux/refcount.h>
 #include <linux/rculist.h>
 #include <linux/slab.h>
 
@@ -71,7 +72,9 @@ struct dmem_cgroup_pool_state {
 	struct rcu_head rcu;
 
 	struct page_counter cnt;
+	struct dmem_cgroup_pool_state *parent;
 
+	refcount_t ref;
 	bool inited;
 };
 
@@ -88,6 +91,9 @@ struct dmem_cgroup_pool_state {
 static DEFINE_SPINLOCK(dmemcg_lock);
 static LIST_HEAD(dmem_cgroup_regions);
 
+static void dmemcg_free_region(struct kref *ref);
+static void dmemcg_pool_free_rcu(struct rcu_head *rcu);
+
 static inline struct dmemcg_state *
 css_to_dmemcs(struct cgroup_subsys_state *css)
 {
@@ -104,10 +110,38 @@ static struct dmemcg_state *parent_dmemcs(struct dmemcg_state *cg)
 	return cg->css.parent ? css_to_dmemcs(cg->css.parent) : NULL;
 }
 
+static void dmemcg_pool_get(struct dmem_cgroup_pool_state *pool)
+{
+	refcount_inc(&pool->ref);
+}
+
+static bool dmemcg_pool_tryget(struct dmem_cgroup_pool_state *pool)
+{
+	return refcount_inc_not_zero(&pool->ref);
+}
+
+static void dmemcg_pool_put(struct dmem_cgroup_pool_state *pool)
+{
+	if (!refcount_dec_and_test(&pool->ref))
+		return;
+
+	call_rcu(&pool->rcu, dmemcg_pool_free_rcu);
+}
+
+static void dmemcg_pool_free_rcu(struct rcu_head *rcu)
+{
+	struct dmem_cgroup_pool_state *pool = container_of(rcu, typeof(*pool), rcu);
+
+	if (pool->parent)
+		dmemcg_pool_put(pool->parent);
+	kref_put(&pool->region->ref, dmemcg_free_region);
+	kfree(pool);
+}
+
 static void free_cg_pool(struct dmem_cgroup_pool_state *pool)
 {
 	list_del(&pool->region_node);
-	kfree(pool);
+	dmemcg_pool_put(pool);
 }
 
 static void
@@ -342,6 +376,12 @@ alloc_pool_single(struct dmemcg_state *dmemcs, struct dmem_cgroup_region *region
 	page_counter_init(&pool->cnt,
 			  ppool ? &ppool->cnt : NULL, true);
 	reset_all_resource_limits(pool);
+	refcount_set(&pool->ref, 1);
+	kref_get(&region->ref);
+	if (ppool && !pool->parent) {
+		pool->parent = ppool;
+		dmemcg_pool_get(ppool);
+	}
 
 	list_add_tail_rcu(&pool->css_node, &dmemcs->pools);
 	list_add_tail(&pool->region_node, &region->pools);
@@ -389,6 +429,10 @@ get_cg_pool_locked(struct dmemcg_state *dmemcs, struct dmem_cgroup_region *regio
 
 		/* Fix up parent links, mark as inited. */
 		pool->cnt.parent = &ppool->cnt;
+		if (ppool && !pool->parent) {
+			pool->parent = ppool;
+			dmemcg_pool_get(ppool);
+		}
 		pool->inited = true;
 
 		pool = ppool;
@@ -435,6 +479,8 @@ void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region)
 
 	list_for_each_entry_safe(pool, next, &region->pools, region_node) {
 		list_del_rcu(&pool->css_node);
+		list_del(&pool->region_node);
+		dmemcg_pool_put(pool);
 	}
 
 	/*
@@ -515,8 +561,10 @@ static struct dmem_cgroup_region *dmemcg_get_region_by_name(const char *name)
  */
 void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
 {
-	if (pool)
+	if (pool) {
 		css_put(&pool->cs->css);
+		dmemcg_pool_put(pool);
+	}
 }
 EXPORT_SYMBOL_GPL(dmem_cgroup_pool_state_put);
 
@@ -530,6 +578,8 @@ get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
 	pool = find_cg_pool_locked(cg, region);
 	if (pool && !READ_ONCE(pool->inited))
 		pool = NULL;
+	if (pool && !dmemcg_pool_tryget(pool))
+		pool = NULL;
 	rcu_read_unlock();
 
 	while (!pool) {
@@ -538,6 +588,8 @@ get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
 			pool = get_cg_pool_locked(cg, region, &allocpool);
 		else
 			pool = ERR_PTR(-ENODEV);
+		if (!IS_ERR(pool))
+			dmemcg_pool_get(pool);
 		spin_unlock(&dmemcg_lock);
 
 		if (pool == ERR_PTR(-ENOMEM)) {
@@ -573,6 +625,7 @@ void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size)
 
 	page_counter_uncharge(&pool->cnt, size);
 	css_put(&pool->cs->css);
+	dmemcg_pool_put(pool);
 }
 EXPORT_SYMBOL_GPL(dmem_cgroup_uncharge);
 
@@ -624,7 +677,9 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 		if (ret_limit_pool) {
 			*ret_limit_pool = container_of(fail, struct dmem_cgroup_pool_state, cnt);
 			css_get(&(*ret_limit_pool)->cs->css);
+			dmemcg_pool_get(*ret_limit_pool);
 		}
+		dmemcg_pool_put(pool);
 		ret = -EAGAIN;
 		goto err;
 	}
@@ -719,6 +774,7 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
 
 		/* And commit */
 		apply(pool, new_limit);
+		dmemcg_pool_put(pool);
 
 out_put:
 		kref_put(&region->ref, dmemcg_free_region);
-- 
2.34.1


