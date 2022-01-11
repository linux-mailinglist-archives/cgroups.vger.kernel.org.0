Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D3448A4A6
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 02:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345865AbiAKBDK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 20:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346046AbiAKBDI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jan 2022 20:03:08 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CD8C06173F;
        Mon, 10 Jan 2022 17:03:08 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id k15so60618268edk.13;
        Mon, 10 Jan 2022 17:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GGc1cimFOcena0hJzqhAcjsWeuG9TQ4RXCir27mg2t0=;
        b=jiQ42Y7CHZZtZfr0P6hnQ1aVpXrkyGGjHJiEJOydtLNdPEG98j73wqZIJmQ9nliUJq
         J8LzTE0O/1GYG3WOJELkKIwETtKtExvdajuPIgvNc5VIDMug1EMI2Mbai/e/1+Y4Mqjr
         1GK0ffaC+9QPT+hva3tBcOlyu8XHTaixj6ubnRBdGjpvfqB8sO3SXR0VGS+MUSwuuhFo
         DyYkAWi3xQH/oUUXXZkM1gW8sAycY9KXnLpi0z9UujlQ6QG6xXbQ9i6/lpRiCrDVU+SS
         N6cSB1GWILoSdYPMstvbbLEMY73ykEfolAjOkGoiKBqqtXJGeuMNGd1oLCbJi6kWtEVH
         iQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GGc1cimFOcena0hJzqhAcjsWeuG9TQ4RXCir27mg2t0=;
        b=q5nmAgfRdj/8wd46mnSBEmc3Y2JwK3WAOYApQgq/nTlo15WpqOFysY1mWNXTkK29yn
         F1xbOUNH41B5WKaL9zfo1b8LPMk5M2ni38zwnZsWQpfHONVTtNXUdqjG3hdS6QTHifw6
         i2xTRFZKoDDsYEVhF+//78d1/FrJaQ4aKsNB7p/ib8AB/KPlazh4/Xe9NqhWHR2rX8BP
         5EeLmQede/vXOQkidzJUwrnaVUIWBHZ5InQycUTY+2UJHK56F7CCMBUqJKWManV7Wz0o
         7uJVas1ARkNSPDYdw7QcGNoxJbQnE3LiUjW+NBqMRH7WRRRCyziy6fixlVWT2SlFBVX3
         Watg==
X-Gm-Message-State: AOAM532+iaqzk5Cl7I5hd+wjLoXdO8skvxKhIjkUmC39ziSof/wIzkye
        XlCfzCrJhrnjjQ8lVyUg1G3w3OOLxiw=
X-Google-Smtp-Source: ABdhPJyVjpTad4Otqdhb+YMruYx/2fOQ1WRkMaE08kdCcgSDgGqBRpi+hjjxUUkr7ybiFwBBpz9enA==
X-Received: by 2002:a17:907:7da5:: with SMTP id oz37mr1746834ejc.465.1641862986847;
        Mon, 10 Jan 2022 17:03:06 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 9sm303304ejt.181.2022.01.10.17.03.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jan 2022 17:03:06 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        vbabka@suse.cz, willy@infradead.org, songmuchun@bytedance.com,
        shy828301@gmail.com, surenb@google.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 4/4] mm/memcg: refine mem_cgroup_threshold_ary->current_threshold calculation
Date:   Tue, 11 Jan 2022 01:03:02 +0000
Message-Id: <20220111010302.8864-4-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220111010302.8864-1-richard.weiyang@gmail.com>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

mem_cgroup_threshold_ary->current_threshold points to the last entry
who's threshold is less or equal to usage.

Instead of iterating entries to get the correct index, we can leverage
primary->current_threshold to get it. If the threshold added is less or
equal to usage, current_threshold should increase by one. Otherwise, it
doesn't change.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/memcontrol.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a504616f904a..ce7060907df2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4161,7 +4161,7 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 	struct mem_cgroup_threshold_ary *new;
 	unsigned long threshold;
 	unsigned long usage;
-	int i, size, ret;
+	int size, ret;
 
 	ret = page_counter_memparse(args, "-1", &threshold);
 	if (ret)
@@ -4193,9 +4193,13 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 	new->size = size;
 
 	/* Copy thresholds (if any) to new array */
-	if (thresholds->primary)
+	if (thresholds->primary) {
 		memcpy(new->entries, thresholds->primary->entries,
 		       flex_array_size(new, entries, size - 1));
+		new->current_threshold = thresholds->primary->current_threshold;
+	} else {
+		new->current_threshold = -1;
+	}
 
 	/* Add new threshold */
 	new->entries[size - 1].eventfd = eventfd;
@@ -4205,18 +4209,17 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 	sort(new->entries, size, sizeof(*new->entries),
 			compare_thresholds, NULL);
 
-	/* Find current threshold */
-	new->current_threshold = -1;
-	for (i = 0; i < size; i++) {
-		if (new->entries[i].threshold <= usage) {
-			/*
-			 * new->current_threshold will not be used until
-			 * rcu_assign_pointer(), so it's safe to increment
-			 * it here.
-			 */
-			++new->current_threshold;
-		} else
-			break;
+	/*
+	 * If the threshold added here is less or equal to usage, this means
+	 * current_threshold need to increase by one.
+	 */
+	if (threshold <= usage) {
+		/*
+		 * new->current_threshold will not be used until
+		 * rcu_assign_pointer(), so it's safe to increment
+		 * it here.
+		 */
+		new->current_threshold++;
 	}
 
 	/* Free old spare buffer and save old primary buffer as spare */
-- 
2.33.1

