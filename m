Return-Path: <cgroups+bounces-11688-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4EDC43E16
	for <lists+cgroups@lfdr.de>; Sun, 09 Nov 2025 13:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C85E94E650C
	for <lists+cgroups@lfdr.de>; Sun,  9 Nov 2025 12:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FB02F0C70;
	Sun,  9 Nov 2025 12:50:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AC12EDD53
	for <cgroups@vger.kernel.org>; Sun,  9 Nov 2025 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692604; cv=none; b=lSYSZvRRT3tRqvI/7/NPeMmwlWia821+wI5SqlXZSOWcxatp8jgT4bFHLEnsA2lsTe/ypIatRRMTLggmD4jm+eccJVZj5zwKVRe19yZ2MwwDeResqmOJNas++SvYmZ8CEWCtCOMgrOB6PdFl4h5ZXMioFx589syuDETICDT+Ap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692604; c=relaxed/simple;
	bh=kEu6HkKA1nWBlQwm/t0WIr9dtjCOGxLNgdKPTSoF8KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FssVDZxNIABYSvQ7WPRhRPdMiPXTWwn2D69wRbcsEs4VMm3hFbwsdzYuYsOy4B3+qbX/QDT9jFxgS2/3K4/bGtZBdaqmnDW44EZOPz17XUf+XUoVyDez9PU7CQmYJV3nKTtaWXkmn1ap19T8YHcZzBaAbz591MCezb1uBy2ugsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 9 Nov 2025 21:49:53 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	youngjun.park@lge.com,
	gunho.lee@lge.com,
	taejoon.song@lge.com
Subject: [PATCH 3/3] mm/swap: integrate swap tier infrastructure into swap subsystem
Date: Sun,  9 Nov 2025 21:49:47 +0900
Message-Id: <20251109124947.1101520-4-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251109124947.1101520-1-youngjun.park@lge.com>
References: <20251109124947.1101520-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Integrate the swap tier infrastructure into the existing swap subsystem
to enable selective swap device usage based on tier configuration.

Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 mm/memcontrol.c | 69 ++++++++++++++++++++++++++++++++++++
 mm/page_io.c    | 21 ++++++++++-
 mm/swap_state.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++
 mm/swapfile.c   | 15 ++++++--
 4 files changed, 194 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bfc986da3289..33c7cc069754 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -68,6 +68,7 @@
 #include <net/ip.h>
 #include "slab.h"
 #include "memcontrol-v1.h"
+#include "swap_tier.h"
 
 #include <linux/uaccess.h>
 
@@ -3730,6 +3731,7 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
 	lru_gen_exit_memcg(memcg);
 	memcg_wb_domain_exit(memcg);
+	swap_tiers_put_mask(memcg);
 	__mem_cgroup_free(memcg);
 }
 
@@ -3842,6 +3844,11 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		page_counter_init(&memcg->kmem, &parent->kmem, false);
 		page_counter_init(&memcg->tcpmem, &parent->tcpmem, false);
 #endif
+#ifdef CONFIG_SWAP_TIER
+		memcg->tiers_mask = 0;
+		memcg->tiers_onoff = 0;
+#endif
+
 	} else {
 		init_memcg_stats();
 		init_memcg_events();
@@ -3850,6 +3857,10 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 #ifdef CONFIG_MEMCG_V1
 		page_counter_init(&memcg->kmem, NULL, false);
 		page_counter_init(&memcg->tcpmem, NULL, false);
+#endif
+#ifdef CONFIG_SWAP_TIER
+		memcg->tiers_mask = DEFAULT_FULL_MASK;
+		memcg->tiers_onoff = DEFAULT_ON_MASK;
 #endif
 		root_mem_cgroup = memcg;
 		return &memcg->css;
@@ -5390,6 +5401,56 @@ static int swap_events_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+#ifdef CONFIG_SWAP_TIER
+static int swap_tier_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	swap_tiers_show_memcg(m, memcg);
+	return 0;
+}
+
+static ssize_t swap_tier_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	struct tiers_desc desc[MAX_SWAPTIER] = {};
+	char *pos = buf, *token;
+	int nr = 0;
+	int ret;
+
+	while ((token = strsep(&pos, " \t\n")) != NULL) {
+		if (!*token)
+			continue;
+
+		if (nr >= MAX_SWAPTIER)
+			return -E2BIG;
+
+		if (token[0] != '+' && token[0] != '-')
+			return -EINVAL;
+
+		desc[nr].ops = (token[0] == '+') ? TIER_ON_MASK : TIER_OFF_MASK;
+
+		if (strlen(token) <= 1) {
+			strscpy(desc[nr].name, DEFAULT_TIER_NAME);
+			nr++;
+			continue;
+		}
+
+		if (strscpy(desc[nr].name, token + 1, MAX_TIERNAME) < 0)
+			return -EINVAL;
+
+		nr++;
+	}
+
+	ret = swap_tiers_get_mask(desc, nr, memcg);
+	if (ret)
+		return ret;
+
+	return nbytes;
+}
+#endif
+
 static struct cftype swap_files[] = {
 	{
 		.name = "swap.current",
@@ -5422,6 +5483,14 @@ static struct cftype swap_files[] = {
 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
 		.seq_show = swap_events_show,
 	},
+#ifdef CONFIG_SWAP_TIER
+	{
+		.name = "swap.tiers",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_tier_show,
+		.write = swap_tier_write,
+	},
+#endif
 	{ }	/* terminate */
 };
 
diff --git a/mm/page_io.c b/mm/page_io.c
index 3c342db77ce3..2b3b1154a169 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -26,6 +26,7 @@
 #include <linux/delayacct.h>
 #include <linux/zswap.h>
 #include "swap.h"
+#include "swap_tier.h"
 
 static void __end_swap_bio_write(struct bio *bio)
 {
@@ -233,6 +234,24 @@ static void swap_zeromap_folio_clear(struct folio *folio)
 	}
 }
 
+#if defined(CONFIG_SWAP_TIER) && defined(CONFIG_ZSWAP)
+static bool folio_swap_tier_zswap_test_off(struct folio *folio)
+{
+	struct mem_cgroup *memcg;
+
+	memcg = folio_memcg(folio);
+	if (memcg)
+		return swap_tier_test_off(memcg->tiers_mask,
+			TIER_MASK(SWAP_TIER_ZSWAP, TIER_ON_MASK));
+
+	return false;
+}
+#else
+static bool folio_swap_tier_zswap_test_off(struct folio *folio)
+{
+	return false;
+}
+#endif
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -272,7 +291,7 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
 	 */
 	swap_zeromap_folio_clear(folio);
 
-	if (zswap_store(folio)) {
+	if (folio_swap_tier_zswap_test_off(folio) || zswap_store(folio)) {
 		count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
 		goto out_unlock;
 	}
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 3f85a1c4cfd9..2e5f65ff2479 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -25,6 +25,7 @@
 #include "internal.h"
 #include "swap_table.h"
 #include "swap.h"
+#include "swap_tier.h"
 
 /*
  * swapper_space is a fiction, retained to simplify the path through
@@ -836,8 +837,100 @@ static ssize_t vma_ra_enabled_store(struct kobject *kobj,
 }
 static struct kobj_attribute vma_ra_enabled_attr = __ATTR_RW(vma_ra_enabled);
 
+#ifdef CONFIG_SWAP_TIER
+static ssize_t tiers_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	return swap_tiers_show_sysfs(buf);
+}
+
+static ssize_t tiers_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct tiers_desc desc[MAX_SWAPTIER] = {};
+	int nr = 0;
+	char *data, *p, *token;
+	int ret = 0;
+	bool is_add = true;
+
+	if (!count)
+		return -EINVAL;
+
+	data = kmemdup_nul(buf, count, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	p = data;
+
+	if (*p == '+')
+		p++;
+	else if (*p == '-') {
+		is_add = false;
+		p++;
+	} else
+		return -EINVAL;
+
+	while ((token = strsep(&p, ", \t\n")) != NULL) {
+		if (!*token)
+			continue;
+
+		if (nr >= MAX_SWAPTIER) {
+			ret = -E2BIG;
+			goto out;
+		}
+
+		if (is_add) {
+			char *name, *prio_str;
+			int prio;
+
+			name = strsep(&token, ":");
+			prio_str = token;
+
+			if (!name || !prio_str || !*name || !*prio_str) {
+				ret = -EINVAL;
+				goto out;
+			}
+
+			if (strscpy(desc[nr].name, name, MAX_TIERNAME) < 0) {
+				ret = -EINVAL;
+				goto out;
+			}
+
+			if (kstrtoint(prio_str, 10, &prio)) {
+				ret = -EINVAL;
+				goto out;
+			}
+
+			desc[nr].prio_st = prio;
+		} else {
+			if (strscpy(desc[nr].name, token, MAX_TIERNAME) < 0) {
+				ret = -EINVAL;
+				goto out;
+			}
+			desc[nr].prio_st = 0;
+		}
+		nr++;
+	}
+
+	if (is_add)
+		ret = swap_tiers_add(desc, nr);
+	else
+		ret = swap_tiers_remove(desc, nr);
+
+out:
+	kfree(data);
+	return ret ? ret : count;
+}
+
+static struct kobj_attribute tier_attr = __ATTR_RW(tiers);
+#endif
+
 static struct attribute *swap_attrs[] = {
 	&vma_ra_enabled_attr.attr,
+#ifdef CONFIG_SWAP_TIER
+	&tier_attr.attr,
+#endif
 	NULL,
 };
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a5c90e419ff3..8715a2d94140 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -49,6 +49,7 @@
 #include "swap_table.h"
 #include "internal.h"
 #include "swap.h"
+#include "swap_tier.h"
 
 static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
 				 unsigned char);
@@ -1296,7 +1297,8 @@ static bool get_swap_device_info(struct swap_info_struct *si)
 
 /* Rotate the device and switch to a new cluster */
 static void swap_alloc_entry(swp_entry_t *entry,
-			    int order)
+			    int order,
+			    int mask)
 {
 	unsigned long offset;
 	struct swap_info_struct *si, *next;
@@ -1304,6 +1306,8 @@ static void swap_alloc_entry(swp_entry_t *entry,
 	spin_lock(&swap_avail_lock);
 start_over:
 	plist_for_each_entry_safe(si, next, &swap_avail_head, avail_list) {
+		if (swap_tiers_test_off(si->tier_idx, mask))
+			continue;
 		/* Rotate the device and switch to a new cluster */
 		plist_requeue(&si->avail_list, &swap_avail_head);
 		spin_unlock(&swap_avail_lock);
@@ -1376,6 +1380,7 @@ int folio_alloc_swap(struct folio *folio)
 {
 	unsigned int order = folio_order(folio);
 	unsigned int size = 1 << order;
+	int mask;
 	swp_entry_t entry = {};
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -1400,8 +1405,8 @@ int folio_alloc_swap(struct folio *folio)
 	}
 
 again:
-	swap_alloc_entry(&entry, order);
-
+	mask = swap_tiers_collect_compare_mask(folio_memcg(folio));
+	swap_alloc_entry(&entry, order, mask);
 	if (unlikely(!order && !entry.val)) {
 		if (swap_sync_discard())
 			goto again;
@@ -2673,6 +2678,8 @@ static void _enable_swap_info(struct swap_info_struct *si)
 
 	/* Add back to available list */
 	add_to_avail_list(si, true);
+
+	swap_tiers_assign(si);
 }
 
 static void enable_swap_info(struct swap_info_struct *si, int prio,
@@ -2840,6 +2847,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	spin_lock(&swap_lock);
 	spin_lock(&p->lock);
 	drain_mmlist();
+	swap_tiers_release(p);
 
 	swap_file = p->swap_file;
 	p->swap_file = NULL;
@@ -4004,6 +4012,7 @@ static int __init swapfile_init(void)
 		swap_migration_ad_supported = true;
 #endif	/* CONFIG_MIGRATION */
 
+	swap_tiers_init();
 	return 0;
 }
 subsys_initcall(swapfile_init);
-- 
2.34.1


