Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B99D71B0
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2019 11:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfJOJCI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Oct 2019 05:02:08 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:53252 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727726AbfJOJCH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Oct 2019 05:02:07 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 0939E2E14A8;
        Tue, 15 Oct 2019 12:02:04 +0300 (MSK)
Received: from iva8-b53eb3f76dc7.qloud-c.yandex.net (iva8-b53eb3f76dc7.qloud-c.yandex.net [2a02:6b8:c0c:2ca1:0:640:b53e:b3f7])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id DbUH92CeEB-23OKsYoB;
        Tue, 15 Oct 2019 12:02:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1571130123; bh=zI18dNBNXOgchJaUsCZ4rEWuTdAP8TPR+E7kuGvEeoQ=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=qGyVlPLPV+q8cAABUjS3GnFLZR2f6jt7QuJBrWXXPHEU12fCcC86Rwo6TUcfAJFAV
         HsWFWf6yzNwbdWnb7nDh5GQojTM3r7IOEnIJUSKkzfPChKda36TPQlEBwDu/dMcxo8
         D7vB1gb7YXwTKipuIad+adI+bkn8VDRhgBp6N0Tk=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by iva8-b53eb3f76dc7.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id oJKLqvSmfN-23I0FQbx;
        Tue, 15 Oct 2019 12:02:03 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 1/2] mm/vmstat: add helpers to get vmstat item names for
 each enum type
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Tue, 15 Oct 2019 12:02:03 +0300
Message-ID: <157113012325.453.562783073839432766.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Statistics in vmstat is combined from counters with different structure,
but names for them are merged into one array.

This patch adds trivial helpers to get name for each item:

const char *zone_stat_name(enum zone_stat_item item);
const char *numa_stat_name(enum numa_stat_item item);
const char *node_stat_name(enum node_stat_item item);
const char *writeback_stat_name(enum writeback_stat_item item);
const char *vm_event_name(enum vm_event_item item);


Names for enum writeback_stat_item are folded in the middle of
vmstat_text so this patch moves declaration into header to calculate
offset of following items.


Also this patch reuses piece of node stat names for lru list names:

const char *lru_list_name(enum lru_list lru);

This returns common lru list names: "inactive_anon", "active_anon",
"inactive_file", "active_file", "unevictable".

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/base/node.c    |    9 +++------
 include/linux/vmstat.h |   50 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/vmstat.c            |   27 +++++++++-----------------
 3 files changed, 62 insertions(+), 24 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 296546ffed6c..98a31bafc8a2 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -496,20 +496,17 @@ static ssize_t node_read_vmstat(struct device *dev,
 	int n = 0;
 
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
-		n += sprintf(buf+n, "%s %lu\n", vmstat_text[i],
+		n += sprintf(buf+n, "%s %lu\n", zone_stat_name(i),
 			     sum_zone_node_page_state(nid, i));
 
 #ifdef CONFIG_NUMA
 	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
-		n += sprintf(buf+n, "%s %lu\n",
-			     vmstat_text[i + NR_VM_ZONE_STAT_ITEMS],
+		n += sprintf(buf+n, "%s %lu\n", numa_stat_name(i),
 			     sum_zone_numa_state(nid, i));
 #endif
 
 	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-		n += sprintf(buf+n, "%s %lu\n",
-			     vmstat_text[i + NR_VM_ZONE_STAT_ITEMS +
-			     NR_VM_NUMA_STAT_ITEMS],
+		n += sprintf(buf+n, "%s %lu\n", node_stat_name(i),
 			     node_page_state(pgdat, i));
 
 	return n;
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index bdeda4b079fe..b995d8b680c2 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -31,6 +31,12 @@ struct reclaim_stat {
 	unsigned nr_unmap_fail;
 };
 
+enum writeback_stat_item {
+	NR_DIRTY_THRESHOLD,
+	NR_DIRTY_BG_THRESHOLD,
+	NR_VM_WRITEBACK_STAT_ITEMS,
+};
+
 #ifdef CONFIG_VM_EVENT_COUNTERS
 /*
  * Light weight per cpu counter implementation.
@@ -381,4 +387,48 @@ static inline void __mod_zone_freepage_state(struct zone *zone, int nr_pages,
 
 extern const char * const vmstat_text[];
 
+static inline const char *zone_stat_name(enum zone_stat_item item)
+{
+	return vmstat_text[item];
+}
+
+#ifdef CONFIG_NUMA
+static inline const char *numa_stat_name(enum numa_stat_item item)
+{
+	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
+			   item];
+}
+#endif /* CONFIG_NUMA */
+
+static inline const char *node_stat_name(enum node_stat_item item)
+{
+	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
+			   NR_VM_NUMA_STAT_ITEMS +
+			   item];
+}
+
+static inline const char *lru_list_name(enum lru_list lru)
+{
+	return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
+}
+
+static inline const char *writeback_stat_name(enum writeback_stat_item item)
+{
+	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
+			   NR_VM_NUMA_STAT_ITEMS +
+			   NR_VM_NODE_STAT_ITEMS +
+			   item];
+}
+
+#ifdef CONFIG_VM_EVENT_COUNTERS
+static inline const char *vm_event_name(enum vm_event_item item)
+{
+	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
+			   NR_VM_NUMA_STAT_ITEMS +
+			   NR_VM_NODE_STAT_ITEMS +
+			   NR_VM_WRITEBACK_STAT_ITEMS +
+			   item];
+}
+#endif /* CONFIG_VM_EVENT_COUNTERS */
+
 #endif /* _LINUX_VMSTAT_H */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 6afc892a148a..590aeca27cab 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1134,7 +1134,7 @@ const char * const vmstat_text[] = {
 	"numa_other",
 #endif
 
-	/* Node-based counters */
+	/* enum node_stat_item counters */
 	"nr_inactive_anon",
 	"nr_active_anon",
 	"nr_inactive_file",
@@ -1547,10 +1547,8 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 	if (is_zone_first_populated(pgdat, zone)) {
 		seq_printf(m, "\n  per-node stats");
 		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
-			seq_printf(m, "\n      %-12s %lu",
-				vmstat_text[i + NR_VM_ZONE_STAT_ITEMS +
-				NR_VM_NUMA_STAT_ITEMS],
-				node_page_state(pgdat, i));
+			seq_printf(m, "\n      %-12s %lu", node_stat_name(i),
+				   node_page_state(pgdat, i));
 		}
 	}
 	seq_printf(m,
@@ -1583,14 +1581,13 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 	}
 
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
-		seq_printf(m, "\n      %-12s %lu", vmstat_text[i],
-				zone_page_state(zone, i));
+		seq_printf(m, "\n      %-12s %lu", zone_stat_name(i),
+			   zone_page_state(zone, i));
 
 #ifdef CONFIG_NUMA
 	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
-		seq_printf(m, "\n      %-12s %lu",
-				vmstat_text[i + NR_VM_ZONE_STAT_ITEMS],
-				zone_numa_state_snapshot(zone, i));
+		seq_printf(m, "\n      %-12s %lu", numa_stat_name(i),
+			   zone_numa_state_snapshot(zone, i));
 #endif
 
 	seq_printf(m, "\n  pagesets");
@@ -1641,12 +1638,6 @@ static const struct seq_operations zoneinfo_op = {
 	.show	= zoneinfo_show,
 };
 
-enum writeback_stat_item {
-	NR_DIRTY_THRESHOLD,
-	NR_DIRTY_BG_THRESHOLD,
-	NR_VM_WRITEBACK_STAT_ITEMS,
-};
-
 static void *vmstat_start(struct seq_file *m, loff_t *pos)
 {
 	unsigned long *v;
@@ -1764,7 +1755,7 @@ int vmstat_refresh(struct ctl_table *table, int write,
 		val = atomic_long_read(&vm_zone_stat[i]);
 		if (val < 0) {
 			pr_warn("%s: %s %ld\n",
-				__func__, vmstat_text[i], val);
+				__func__, zone_stat_name(i), val);
 			err = -EINVAL;
 		}
 	}
@@ -1773,7 +1764,7 @@ int vmstat_refresh(struct ctl_table *table, int write,
 		val = atomic_long_read(&vm_numa_stat[i]);
 		if (val < 0) {
 			pr_warn("%s: %s %ld\n",
-				__func__, vmstat_text[i + NR_VM_ZONE_STAT_ITEMS], val);
+				__func__, numa_stat_name(i), val);
 			err = -EINVAL;
 		}
 	}

