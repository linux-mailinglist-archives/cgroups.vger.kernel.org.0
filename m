Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C9664D29C
	for <lists+cgroups@lfdr.de>; Wed, 14 Dec 2022 23:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLNWwD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Dec 2022 17:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLNWvw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Dec 2022 17:51:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E796A37FAF
        for <cgroups@vger.kernel.org>; Wed, 14 Dec 2022 14:51:51 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r7-20020a25c107000000b006ff55ac0ee7so1479902ybf.15
        for <cgroups@vger.kernel.org>; Wed, 14 Dec 2022 14:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pP1HscS3NBizlWxdjalcxiOCxdTFFXWst9Um78lFYew=;
        b=T1vg6NpxLo6/eIwoy3Qed3mwYZrRcOaXUysYifLHaPi+vYhazUnDs6UDkTZlfRIw7V
         Y5hy6nvWH1kyT8kmze9eEa6nJSZiNVpW3N3UXMgfEqMuN0e25TVhuhO9D7VqOL/r6JiD
         44j5nrRtBPJjeCrY/eBcV76Ko9qHQL7Uf12YDUe97/+MP0nkOYsl4soDy9ktZnmEK6x+
         JG4eyDx3Gz2L0H7brEud6mnsIZbHYNBVEQ+rFXpJSg7KtZwCH9Hw29QGY6vvNpzSWtha
         wOUPLTllmlPcjgFW+I/5/U+W1WIJ6SDoiC88ehNVmoHhh1WhKqr8mBzhsap235RbUrOI
         kVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pP1HscS3NBizlWxdjalcxiOCxdTFFXWst9Um78lFYew=;
        b=wo3fsBnrP0/WT09q/YkH5zA1Dw2oRs8bB2VDZ2jfflSHUPwxiN+Saec7OeggCMZjQ1
         pNolLqNLcjjSHC5dgmVYOvjXUAVq1IV+U5GLv4VRf0GtoBNmVeqXIUHZualNmUFd+UCk
         Kwdtitc5GqtcZGL85l22p2ShRXrOPzhIJV+eBVc/HiSr01/o8HPe4jASNboEEjvoUggn
         6aYnr41znHTsPdvD51w8fMW81xJBGoKsxTpF77dtpeDc+awIUL2WKuxHShq4kDpDx3He
         +XoxLamHZcvR8pM3B5XBlfTWs+4+wLzgcb0vfes9v1YbKwD88/fJKNFIFKFCLp6NrcZZ
         PDOA==
X-Gm-Message-State: ANoB5plLrdLHSyIGLai+yBIDcHkjcJyKd6yNDTMmR0wXGu1kthZsZuhU
        XYJ20rG8o2rOq+zXx+hEUYLTT/DAdlPJ
X-Google-Smtp-Source: AA0mqf7P1hKr2kxnLCk/QZ1080xuaZc9TM+496Hb5ZsvxrM7pi3Lu6mK+r3cvFJ2NP34V6PpPdiHlgQapjM1
X-Received: from yuanchu.svl.corp.google.com ([2620:15c:2d4:203:1311:60bc:9e2a:ab1])
 (user=yuanchu job=sendgmr) by 2002:a25:dfc3:0:b0:6f3:2748:7469 with SMTP id
 w186-20020a25dfc3000000b006f327487469mr55315847ybg.564.1671058311228; Wed, 14
 Dec 2022 14:51:51 -0800 (PST)
Date:   Wed, 14 Dec 2022 14:51:23 -0800
In-Reply-To: <20221214225123.2770216-1-yuanchu@google.com>
Mime-Version: 1.0
References: <20221214225123.2770216-1-yuanchu@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221214225123.2770216-3-yuanchu@google.com>
Subject: [RFC PATCH 2/2] mm: multi-gen LRU: cgroup working set stats
From:   Yuanchu Xie <yuanchu@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Expose MGLRU generations as working set stats in cgroupfs as
memory.page_idle_age, where we group pages into idle age ranges, and
present the number of pages per node per pagetype in each range. This
aggregates the time information from MGLRU generations hierarchically.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 mm/memcontrol.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7d2fb3fc4580..86554e17be58 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1655,6 +1655,130 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 	pr_info("%s", buf);
 }
 
+#ifdef CONFIG_LRU_GEN
+static const unsigned long page_idle_age_ranges[] = {
+	1,   2,	  5,   10,  20,	 30,   45,   60,   90,	 120, 180,
+	240, 360, 480, 720, 960, 1440, 1920, 2880, 3840, -1
+};
+
+#define PAGE_IDLE_AGE_NR_RANGES ARRAY_SIZE(page_idle_age_ranges)
+
+static unsigned int lru_gen_time_to_page_idle_age_range(unsigned long timestamp)
+{
+	unsigned int i;
+	unsigned long gen_age = jiffies_to_msecs(jiffies - timestamp) / MSEC_PER_SEC;
+
+	for (i = 0; i < PAGE_IDLE_AGE_NR_RANGES - 1; ++i)
+		if (gen_age <= page_idle_age_ranges[i])
+			return i;
+
+	return PAGE_IDLE_AGE_NR_RANGES - 1;
+}
+
+static void lru_gen_fill_page_idle_age_table(unsigned long *table,
+					     struct lru_gen_struct *lrugen,
+					     int nid)
+{
+	unsigned long max_seq = READ_ONCE(lrugen->max_seq);
+	unsigned long min_seq[ANON_AND_FILE] = {
+		READ_ONCE(lrugen->min_seq[LRU_GEN_ANON]),
+		READ_ONCE(lrugen->min_seq[LRU_GEN_FILE]),
+	};
+	unsigned long seq;
+	unsigned int pagetype;
+
+	/*
+	 * what do we want to do here?
+	 * iterate over all the generations, for each anon and file
+	 */
+
+	for (pagetype = LRU_GEN_ANON; pagetype < ANON_AND_FILE; ++pagetype) {
+		for (seq = min_seq[pagetype]; seq <= max_seq; ++seq) {
+			unsigned int zone;
+			unsigned int gen = lru_gen_from_seq(seq);
+			unsigned int idle_age = lru_gen_time_to_page_idle_age_range(
+				READ_ONCE(lrugen->timestamps[gen]));
+			unsigned long page_count = 0;
+
+			for (zone = 0; zone < MAX_NR_ZONES; ++zone) {
+				page_count += READ_ONCE(
+					lrugen->nr_pages[gen][pagetype][zone]);
+			}
+			table[pagetype * PAGE_IDLE_AGE_NR_RANGES *
+				      nr_node_ids +
+			      PAGE_IDLE_AGE_NR_RANGES * nid + idle_age] +=
+				page_count;
+		}
+	}
+}
+
+static void memory_page_idle_age_print(struct seq_file *m, unsigned long *table)
+{
+	static const char *type_str[ANON_AND_FILE] = { "anon", "file" };
+	unsigned int i, nid, pagetype;
+	unsigned int lower = 0;
+
+	for (i = 0; i < PAGE_IDLE_AGE_NR_RANGES; ++i) {
+		unsigned int upper = page_idle_age_ranges[i];
+
+		for (pagetype = LRU_GEN_ANON; pagetype < ANON_AND_FILE;
+		     ++pagetype) {
+			if (upper == -1)
+				seq_printf(m, "%u-inf %s", lower,
+					  type_str[pagetype]);
+			else
+				seq_printf(m, "%u-%u %s", lower, upper,
+					   type_str[pagetype]);
+			for_each_node_state(nid, N_MEMORY) {
+				unsigned long page_count = table
+					[pagetype *
+						 PAGE_IDLE_AGE_NR_RANGES *
+						 nr_node_ids +
+					 PAGE_IDLE_AGE_NR_RANGES * nid +
+					 i];
+				seq_printf(m, " N%u=%lu", nid, page_count);
+			}
+			seq_puts(m, "\n");
+		}
+
+		lower = upper;
+	}
+}
+
+static int memory_page_idle_age_format(struct mem_cgroup *root,
+				       struct seq_file *m)
+{
+	struct mem_cgroup *memcg;
+	unsigned long *table;
+
+	/*
+	 * table contains PAGE_IDLE_AGE_NR_RANGES entries
+	 * per node per pagetype
+	 */
+	table = kmalloc_array(PAGE_IDLE_AGE_NR_RANGES * nr_node_ids *
+				      ANON_AND_FILE,
+			      sizeof(*table), __GFP_ZERO | GFP_KERNEL);
+
+	if (!table)
+		return -ENOMEM;
+
+	memcg = mem_cgroup_iter(root, NULL, NULL);
+	do {
+		int nid;
+
+		for_each_node_state(nid, N_MEMORY) {
+			struct lru_gen_struct *lrugen =
+				&memcg->nodeinfo[nid]->lruvec.lrugen;
+
+			lru_gen_fill_page_idle_age_table(table, lrugen, nid);
+		}
+	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
+
+	memory_page_idle_age_print(m, table);
+	return 0;
+}
+#endif /* CONFIG_LRU_GEN */
+
 /*
  * Return the memory (and swap, if configured) limit for a memcg.
  */
@@ -6571,6 +6695,13 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 }
 
 #ifdef CONFIG_LRU_GEN
+static int memory_page_idle_age_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	return memory_page_idle_age_format(memcg, m);
+}
+
 static int memory_periodic_aging_show(struct seq_file *m, void *v)
 {
 	unsigned int interval = kold_get_interval();
@@ -6724,6 +6855,11 @@ static struct cftype memory_files[] = {
 		.write = memory_reclaim,
 	},
 #ifdef CONFIG_LRU_GEN
+	{
+		.name = "page_idle_age",
+		.flags = CFTYPE_NS_DELEGATABLE,
+		.seq_show = memory_page_idle_age_show,
+	},
 	{
 		.name = "periodic_aging",
 		.flags = CFTYPE_ONLY_ON_ROOT,
-- 
2.39.0.314.g84b9a713c41-goog

