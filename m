Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24B50178825
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 03:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387550AbgCDCVX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Mar 2020 21:21:23 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:43427 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387488AbgCDCVX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Mar 2020 21:21:23 -0500
Received: by mail-pl1-f201.google.com with SMTP id d9so159868plo.10
        for <cgroups@vger.kernel.org>; Tue, 03 Mar 2020 18:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+xah7E//6pVRKdaZXmFI1T6nfuFUo9iVXUkHyM4jmQo=;
        b=TZwFCinuj11xZdNvspmekDI0x79O/EQihOSSmxMSVxtrpfdyMQkBRLLvD95CEFCzpX
         LLJPxfEnWDkieQxh7QIxWxbToGfC+DMpLfbgM4udxeAy8K5yQHCP1k4fD6xZVxK51r2m
         uCNK6OZd3TSqEautzdRJCITCLeqff8iyKCZFyG01AxM0dPjwy0pwIyjdDBheYzwyIB3M
         b21oYiHUF7a9PAjanaiCpWH4aFMeYD4jjLh872JSJ0BGqqi1PHtAr+BikLaErcxfrWv+
         U1c2HZsQTLpu4Y39JF9rjKug9K9KM/Wd6WgOrSRcCsD9Dn0Qs8DAYqL4Shs4nsmMLQXh
         vgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+xah7E//6pVRKdaZXmFI1T6nfuFUo9iVXUkHyM4jmQo=;
        b=bEG1PdroJusFP0iehPqXMtWFzDtEYmflcV/2bHMYW1wP4KC8zUKk1Xt27ITVQGQEgF
         SblexzmK/ADwtQ9ytio1069GBaOYzVIOPCeQaLsFY9vN1pFRntZ+2MC2t6bvWF+ckDM+
         no8jYZhDbckwFmzMxbRFZc9vuaChkOYndtfJ2OUIsoCUiTkk/NUX+gewLngHaDLXOTaH
         iCyR9IHHcVIqRLlQpZdWwoZ319WUXsrd6hOtdGGr3OloBbEdAkHXZ9JboyMHgojd9kZ6
         wK729GVsKzeN9WdlMjWSGOlzRJOZiMScLupemg2Jimfw81pBfgj8SE5W6sL8yzB5JONx
         utww==
X-Gm-Message-State: ANhLgQ1bZCrsUaiAJ4dXVNrM06imFfdPAUhK/I13/NPtYd8a7kxi5dEg
        O89B+SCIEuEevfw5FxbOwC+fMJ71CEEn/w==
X-Google-Smtp-Source: ADFU+vu8OtgDgAEEtoJCrBqXEjW+PtdPObK6IdK9ihXt3F3QrY5fhSy5oyuvRqAnRLJJE4WOR6O7U3lAP9UJDA==
X-Received: by 2002:a63:731c:: with SMTP id o28mr418425pgc.139.1583288481764;
 Tue, 03 Mar 2020 18:21:21 -0800 (PST)
Date:   Tue,  3 Mar 2020 18:20:58 -0800
Message-Id: <20200304022058.248270-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] memcg: optimize memory.numa_stat like memory.stat
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently reading memory.numa_stat traverses the underlying memcg tree
multiple times to accumulate the stats to present the hierarchical view
of the memcg tree. However the kernel already maintains the hierarchical
view of the stats and use it in memory.stat. Just use the same mechanism
in memory.numa_stat as well.

I ran a simple benchmark which reads root_mem_cgroup's memory.numa_stat
file in the presense of 10000 memcgs. The results are:

Without the patch:
$ time cat /dev/cgroup/memory/memory.numa_stat > /dev/null

real    0m0.700s
user    0m0.001s
sys     0m0.697s

With the patch:
$ time cat /dev/cgroup/memory/memory.numa_stat > /dev/null

real    0m0.001s
user    0m0.001s
sys     0m0.000s

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 52 +++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 63bb6a2aab81..d5485fa8a345 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3614,32 +3614,40 @@ static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
 #define LRU_ALL	     ((1 << NR_LRU_LISTS) - 1)
 
 static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
-					   int nid, unsigned int lru_mask)
+				int nid, unsigned int lru_mask, bool tree)
 {
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 	unsigned long nr = 0;
 	enum lru_list lru;
+	unsigned long (*page_state)(struct lruvec *lruvec,
+				    enum node_stat_item idx);
 
 	VM_BUG_ON((unsigned)nid >= nr_node_ids);
 
+	page_state = tree ? lruvec_page_state : lruvec_page_state_local;
+
 	for_each_lru(lru) {
 		if (!(BIT(lru) & lru_mask))
 			continue;
-		nr += lruvec_page_state_local(lruvec, NR_LRU_BASE + lru);
+		nr += page_state(lruvec, NR_LRU_BASE + lru);
 	}
 	return nr;
 }
 
 static unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
-					     unsigned int lru_mask)
+					     unsigned int lru_mask,
+					     bool tree)
 {
 	unsigned long nr = 0;
 	enum lru_list lru;
+	unsigned long (*page_state)(struct mem_cgroup *memcg, int idx);
+
+	page_state = tree ? memcg_page_state : memcg_page_state_local;
 
 	for_each_lru(lru) {
 		if (!(BIT(lru) & lru_mask))
 			continue;
-		nr += memcg_page_state_local(memcg, NR_LRU_BASE + lru);
+		nr += page_state(memcg, NR_LRU_BASE + lru);
 	}
 	return nr;
 }
@@ -3659,34 +3667,28 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	};
 	const struct numa_stat *stat;
 	int nid;
-	unsigned long nr;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
-		nr = mem_cgroup_nr_lru_pages(memcg, stat->lru_mask);
-		seq_printf(m, "%s=%lu", stat->name, nr);
-		for_each_node_state(nid, N_MEMORY) {
-			nr = mem_cgroup_node_nr_lru_pages(memcg, nid,
-							  stat->lru_mask);
-			seq_printf(m, " N%d=%lu", nid, nr);
-		}
+		seq_printf(m, "%s=%lu", stat->name,
+			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
+						   false));
+		for_each_node_state(nid, N_MEMORY)
+			seq_printf(m, " N%d=%lu", nid,
+				   mem_cgroup_node_nr_lru_pages(memcg, nid,
+							stat->lru_mask, false));
 		seq_putc(m, '\n');
 	}
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
-		struct mem_cgroup *iter;
-
-		nr = 0;
-		for_each_mem_cgroup_tree(iter, memcg)
-			nr += mem_cgroup_nr_lru_pages(iter, stat->lru_mask);
-		seq_printf(m, "hierarchical_%s=%lu", stat->name, nr);
-		for_each_node_state(nid, N_MEMORY) {
-			nr = 0;
-			for_each_mem_cgroup_tree(iter, memcg)
-				nr += mem_cgroup_node_nr_lru_pages(
-					iter, nid, stat->lru_mask);
-			seq_printf(m, " N%d=%lu", nid, nr);
-		}
+
+		seq_printf(m, "hierarchical_%s=%lu", stat->name,
+			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
+						   true));
+		for_each_node_state(nid, N_MEMORY)
+			seq_printf(m, " N%d=%lu", nid,
+				   mem_cgroup_node_nr_lru_pages(memcg, nid,
+							stat->lru_mask, true));
 		seq_putc(m, '\n');
 	}
 
-- 
2.25.0.265.gbab2e86ba0-goog

