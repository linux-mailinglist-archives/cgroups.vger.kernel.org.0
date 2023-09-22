Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047987AB8BF
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 20:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjIVSAN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 14:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjIVR7f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 13:59:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356274213
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 10:57:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7ec535fe42so3090071276.1
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695405465; x=1696010265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIUVdWYJzS23SUkOVUGYlHJuolUCd+SBS6YJzjY/W/M=;
        b=j6jMO0KPP+GHBicZNd3LVMZSQuXiS/dwN9sDBeANBHBoOrl6GWQqcBMeYr+OhfGW41
         j9DARkjCnZgGSkLQcbz2WN6qW1frdj3oCH4ytTmmXC3yQ8QLuYd6ANgEmbPFi+ZMhO/2
         QojDnZ+NojRvcRFAVk5DLP+aIbCt2o5iCNj+r2udzeGho/0Wr1Bf7yD1ZIAh9zeJ/5+Y
         bnXcN+PNpLvDvIiP7kQBWTmMys97Lr5W7o9XlZIm4rjFchkQTs6S3Qeg9Cx8z0DR7W+c
         rx1b+qrC/O01Wcwk4hBmmEuUoSD+GtApnNOU1FGwwpi99VqjIcj+/LOmi44D5yZJultX
         NfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405465; x=1696010265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIUVdWYJzS23SUkOVUGYlHJuolUCd+SBS6YJzjY/W/M=;
        b=UJwgVsIO+yd1NaJFewcg5/Ee7b9SFKnlt28ud9OKPZ4hgB65tv8L78Lf+Ie4/ltckz
         HYbDT+caPBM/yPxo7RRlatZsnKgDO7uVsVIWFu+VLV/DGYLONoz0G4Dl/LOzwSsh4NDj
         quE6f76Pqg/tdUqfdOiCpDhzA61wvI1MlSsmtBINbyUbpbFhEeGYrjr1FpJubMo51CXM
         6nk/7aetbwsKj7lbPBcm58IDnHyvfLt9key5iU2NgdJtgH4m9SM8/WPwafyQxi5bymrK
         10B3WSHrnjVpmYAFcb56/d0MgGBgHanzlWCGqQzpriZ8WGeDr1pHCeqi1IoICULfNowH
         4nRg==
X-Gm-Message-State: AOJu0Yy09F55yYfjfRE8AtHIo+4g+hbCK6VNeZlIJCbE2HXLpKMM8wEf
        M+WpMLSvgsmHBR45c5vOP3foJ2xFAdzKD3QP
X-Google-Smtp-Source: AGHT+IGRY7CHNarSt8hxzLUxdPvhzPSOwb+6g2+4WOANIpjP9cYGG1L1f1r5GlTbEtZccPZQJPzwzGGJFWlsxbc8
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:6942:0:b0:d80:cf4:7e80 with SMTP id
 e63-20020a256942000000b00d800cf47e80mr453ybc.7.1695405465321; Fri, 22 Sep
 2023 10:57:45 -0700 (PDT)
Date:   Fri, 22 Sep 2023 17:57:39 +0000
In-Reply-To: <20230922175741.635002-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230922175741.635002-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922175741.635002-2-yosryahmed@google.com>
Subject: [PATCH v2 1/2] mm: memcg: refactor page state unit helpers
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
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

memcg_page_state_unit() is currently used to identify the unit of a
memcg state item so that all stats in memory.stat are in bytes. However,
it lies about the units of WORKINGSET_* stats. These stats actually
represent pages, but we present them to userspace as a scalar number of
events. In retrospect, maybe those stats should have been memcg "events"
rather than memcg "state".

In preparation for using memcg_page_state_unit() for other purposes that
need to know the truthful units of different stat items, break it down
into two helpers:
- memcg_page_state_unit() retuns the actual unit of the item.
- memcg_page_state_output_unit() returns the unit used for output.

Use the latter instead of the former in memcg_page_state_output() and
lruvec_page_state_output(). While we are at it, let's show cgroup v1
some love and add memcg_page_state_local_output() for consistency.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 927c64d3cbcb..308cc7353ef0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1535,7 +1535,7 @@ static const struct memory_stat memory_stats[] = {
 	{ "workingset_nodereclaim",	WORKINGSET_NODERECLAIM		},
 };
 
-/* Translate stat items to the correct unit for memory.stat output */
+/* The actual unit of the state item, not the same as the output unit */
 static int memcg_page_state_unit(int item)
 {
 	switch (item) {
@@ -1543,6 +1543,22 @@ static int memcg_page_state_unit(int item)
 	case MEMCG_ZSWAP_B:
 	case NR_SLAB_RECLAIMABLE_B:
 	case NR_SLAB_UNRECLAIMABLE_B:
+		return 1;
+	case NR_KERNEL_STACK_KB:
+		return SZ_1K;
+	default:
+		return PAGE_SIZE;
+	}
+}
+
+/* Translate stat items to the correct unit for memory.stat output */
+static int memcg_page_state_output_unit(int item)
+{
+	/*
+	 * Workingset state is actually in pages, but we export it to userspace
+	 * as a scalar count of events, so special case it here.
+	 */
+	switch (item) {
 	case WORKINGSET_REFAULT_ANON:
 	case WORKINGSET_REFAULT_FILE:
 	case WORKINGSET_ACTIVATE_ANON:
@@ -1551,17 +1567,23 @@ static int memcg_page_state_unit(int item)
 	case WORKINGSET_RESTORE_FILE:
 	case WORKINGSET_NODERECLAIM:
 		return 1;
-	case NR_KERNEL_STACK_KB:
-		return SZ_1K;
 	default:
-		return PAGE_SIZE;
+		return memcg_page_state_unit(item);
 	}
 }
 
 static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
 						    int item)
 {
-	return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
+	return memcg_page_state(memcg, item) *
+		memcg_page_state_output_unit(item);
+}
+
+static inline unsigned long memcg_page_state_local_output(
+		struct mem_cgroup *memcg, int item)
+{
+	return memcg_page_state_local(memcg, item) *
+		memcg_page_state_output_unit(item);
 }
 
 static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
@@ -4106,9 +4128,8 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
 
-		nr = memcg_page_state_local(memcg, memcg1_stats[i]);
-		seq_buf_printf(s, "%s %lu\n", memcg1_stat_names[i],
-			   nr * memcg_page_state_unit(memcg1_stats[i]));
+		nr = memcg_page_state_local_output(memcg, memcg1_stats[i]);
+		seq_buf_printf(s, "%s %lu\n", memcg1_stat_names[i], nr);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
@@ -4134,9 +4155,9 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
 
-		nr = memcg_page_state(memcg, memcg1_stats[i]);
+		nr = memcg_page_state_output(memcg, memcg1_stats[i]);
 		seq_buf_printf(s, "total_%s %llu\n", memcg1_stat_names[i],
-			   (u64)nr * memcg_page_state_unit(memcg1_stats[i]));
+			       (u64)nr);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
@@ -6614,7 +6635,8 @@ static int memory_stat_show(struct seq_file *m, void *v)
 static inline unsigned long lruvec_page_state_output(struct lruvec *lruvec,
 						     int item)
 {
-	return lruvec_page_state(lruvec, item) * memcg_page_state_unit(item);
+	return lruvec_page_state(lruvec, item) *
+		memcg_page_state_output_unit(item);
 }
 
 static int memory_numa_stat_show(struct seq_file *m, void *v)
-- 
2.42.0.515.g380fc7ccd1-goog

