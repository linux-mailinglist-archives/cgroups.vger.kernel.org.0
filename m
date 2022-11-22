Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582BC634862
	for <lists+cgroups@lfdr.de>; Tue, 22 Nov 2022 21:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiKVUjI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Nov 2022 15:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiKVUjF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Nov 2022 15:39:05 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D7F68C75
        for <cgroups@vger.kernel.org>; Tue, 22 Nov 2022 12:39:04 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id v4-20020a1709029a0400b00188f5824b50so11476632plp.11
        for <cgroups@vger.kernel.org>; Tue, 22 Nov 2022 12:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mH2xKyLbtphuPdUJ732OjxOQc7w7f5rhMLqPKs8ZczA=;
        b=qdsmec8olNuJkHjim4tCNOzdWa/frQp8m5lufYNaqejkZMLoMUUyW+CWmAkGziybpf
         XVtKd/0LwOGTSKPzuW0laRVzBchDj/eYAtuTCSNB8IMPYcpApfCWC2zjH37lPwrTquSo
         e6VwPwg/ku5WTWy2ImXR0wgUFLZ1Bya8Re9NroqrrjtTrQdgeKHCixYvONLr+VBOSK7D
         y/z7y3/mili8PPvIi+kePEDEmzvJZh09v92ohyzbQ5RuROFwKw5KgQsz7VHG+PzHsW5E
         1yg6L/6VSUWRD0wFpHrfizjK3o+Nif6zqdPMbBMhrgAWMlNgfhUP/5lOq0C7Wj8y1WM3
         OO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mH2xKyLbtphuPdUJ732OjxOQc7w7f5rhMLqPKs8ZczA=;
        b=bQbeTvxOtxrG9V6Y/EbTWm6zmM0vWTzsyZAA+j8xu+1UzQJbw9mlGzOKo4YLsmTtmW
         z8yh6e65I7v0B2iXGY75VeSnXlVn/lqtyxiENm0ebJeA/Fc+6zaE/SFxsWUPWZPYvHW5
         Gc3HnlxPwDWQm706zDkrB+t/cVCUKayWC2kh8EAsS5MYzb7epfHOSNkByyP3zlPHX5mo
         HXDqqvgrVcDLnpDX9N9D4wWXQlkr3A4XrHyDoEhi1ScVzFD9Sw0vBpa4j7VYa9eRaZXx
         6JWl+dXoviEL00WEneHfPcKdlTGHzR2Lfj9EeXjq7ZIw0HYzyUIWFRFNx1HRztF4xdKt
         d3Og==
X-Gm-Message-State: ANoB5pmFoYnJQLOSLGBcFiFYnfJvkEWIXMWiCFopHilHqbq64OL7uPtx
        s0osDQXRKVz6pNVuF3fdhYBHA87aXLSxUolJBw==
X-Google-Smtp-Source: AA0mqf4nRSDZsJA5udKOk+WPQ7He8G7ypX1TuK+m1EL8dLhG9pG68x3W9SVyDcAVprESbrBcmMcBBy7AvLCfO1+7Ag==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2d4:203:b7d0:497d:abe4:3e6f])
 (user=almasrymina job=sendgmr) by 2002:a63:7143:0:b0:46f:918e:7338 with SMTP
 id b3-20020a637143000000b0046f918e7338mr6371506pgn.8.1669149544152; Tue, 22
 Nov 2022 12:39:04 -0800 (PST)
Date:   Tue, 22 Nov 2022 12:38:46 -0800
In-Reply-To: <20221122203850.2765015-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20221122203850.2765015-1-almasrymina@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122203850.2765015-2-almasrymina@google.com>
Subject: [RFC PATCH v1] mm: Add memory.demote for proactive demotion only
From:   Mina Almasry <almasrymina@google.com>
To:     Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
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

Add the proactive demotion interface memory.demote. This interface can
be used as follows:

echo "1m" > memory.demote

At this command the kernel will attempt to demote 1m of memory from this
cgroup. The kernel may not be able to demote the full amount requested
by the userspace and in that case EAGAIN would be returned to the user
(similar to memory.reclaim).

The kernel will only attempt to demote pages with this interface. It
will not attempt any other kind of reclaim (swap, writeback or
reclaiming clean file pages).

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 mm/memcontrol.c | 38 ++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c     | 18 ++++++++++++++----
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fd4ff1c865a2..427c79e467eb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6623,6 +6623,39 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }

+static ssize_t memory_demote(struct kernfs_open_file *of, char *buf,
+			     size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
+	unsigned long nr_to_demote, nr_demoted = 0;
+	unsigned int reclaim_options = MEMCG_RECLAIM_ONLY_DEMOTE;
+	int err;
+
+	buf = strstrip(buf);
+	err = page_counter_memparse(buf, "", &nr_to_demote);
+	if (err)
+		return err;
+
+	while (nr_demoted < nr_to_demote) {
+		unsigned long demoted;
+
+		if (signal_pending(current))
+			return -EINTR;
+
+		demoted = try_to_free_mem_cgroup_pages(
+			memcg, nr_to_demote - nr_demoted, GFP_KERNEL,
+			reclaim_options);
+
+		if (!demoted && !nr_retries--)
+			return -EAGAIN;
+
+		nr_demoted += demoted;
+	}
+
+	return nbytes;
+}
+
 static struct cftype memory_files[] = {
 	{
 		.name = "current",
@@ -6691,6 +6724,11 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NS_DELEGATABLE,
 		.write = memory_reclaim,
 	},
+	{
+		.name = "demote",
+		.flags = CFTYPE_NS_DELEGATABLE,
+		.write = memory_demote,
+	},
 	{ }	/* terminate */
 };

diff --git a/mm/vmscan.c b/mm/vmscan.c
index dea05ad8ece5..8c1f5416d789 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1657,12 +1657,13 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	LIST_HEAD(demote_folios);
 	unsigned int nr_reclaimed = 0;
 	unsigned int pgactivate = 0;
-	bool do_demote_pass;
+	bool do_demote_pass, only_demote_pass;
 	struct swap_iocb *plug = NULL;

 	memset(stat, 0, sizeof(*stat));
 	cond_resched();
 	do_demote_pass = can_demote(pgdat->node_id, sc);
+	only_demote_pass = sc->demotion == 2;

 retry:
 	while (!list_empty(folio_list)) {
@@ -2091,10 +2092,19 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
 	/* Folios that could not be demoted are still in @demote_folios */
 	if (!list_empty(&demote_folios)) {
-		/* Folios which weren't demoted go back on @folio_list for retry: */
+		/*
+		 * Folios which weren't demoted go back on @folio_list.
+		 */
 		list_splice_init(&demote_folios, folio_list);
-		do_demote_pass = false;
-		goto retry;
+
+		/*
+		 * goto retry to reclaim the undemoted folios in folio_list if
+		 * desired.
+		 */
+		if (!only_demote_pass) {
+			do_demote_pass = false;
+			goto retry;
+		}
 	}

 	pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
--
2.38.1.584.g0f3c55d4c2-goog
