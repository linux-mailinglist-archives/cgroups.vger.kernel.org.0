Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C74B1DB965
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2020 18:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgETQbr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 May 2020 12:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgETQbq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 May 2020 12:31:46 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBB2C061A0F
        for <cgroups@vger.kernel.org>; Wed, 20 May 2020 09:31:45 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l25so3753299edj.4
        for <cgroups@vger.kernel.org>; Wed, 20 May 2020 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=17jQ1Ah04oBToqJwXezLZCoVZLFH+XvWoWdyyqn9mN4=;
        b=ToruOqWtIPegGVdd3B6jTVoD/jM+3Af1McEs8wIdfzwADuzejeup3xOJQYdm11S4EZ
         65f5gLqFmKnxcngv/RXN+x6KKrFXbF2QNkJJEO/INc/RjX4WvlQPN+Bi7MjzN0mt+0WH
         8YSuiL7L4Tj+3phhD1zTvajIoimjSyRefUirY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=17jQ1Ah04oBToqJwXezLZCoVZLFH+XvWoWdyyqn9mN4=;
        b=sBsgSqdcMB4qDUoa0LuJ3wyo9eJz04BP/MpPNa/UxQCGTFZc1Ij7WOP8UNQMaAjlq8
         RQRNxAZpilV3k1kEwg/Ya/NoaqRFLssKCzlEHQTrmsK8T+sFr06AbU51GKcjpYLOJzfB
         Hm+5DHKzsnvoqyPeeV5N8UnrHdJv4tH4hq3i6qbluiH3xcU11NNdLQGvDfRDgkxWgEI9
         YXol/47W1/ugxu8Cd0AyOV9+F4+byF5UOYxofY2sm9PEzUakI3NQNI7RXSNorHPJrF6M
         pcumyQxJ7xwzI+HI/qeSCQezmBuqfVxeAJNERwlpPNo+4b/eVy+VZSk5HDgIdJgQj0jA
         yDbA==
X-Gm-Message-State: AOAM531wr3XAeraPcZNDzQ57sl0gHcEVYqBxxc596fOlq1toARZ6PSgo
        cWx3CGLKPgg9Jd63Tlw+j7SxIg==
X-Google-Smtp-Source: ABdhPJy4Y8SAoa9B33qnxj6nB4l/32rU1XrBuIH6bGgBO5u/ZSRq37k2+8ilcS54Hv60sCMxDciDKg==
X-Received: by 2002:a50:9b19:: with SMTP id o25mr4312664edi.141.1589992303655;
        Wed, 20 May 2020 09:31:43 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:758d])
        by smtp.gmail.com with ESMTPSA id gx25sm2279074ejb.63.2020.05.20.09.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:31:43 -0700 (PDT)
Date:   Wed, 20 May 2020 17:31:42 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm, memcg: unify reclaim retry limits with page allocator
Message-ID: <20200520163142.GA808793@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Reclaim retries have been set to 5 since the beginning of time in
66e1707bc346 ("Memory controller: add per cgroup LRU and reclaim").
However, we now have a generally agreed-upon standard for page reclaim:
MAX_RECLAIM_RETRIES (currently 16), added many years later in
0a0337e0d1d1 ("mm, oom: rework oom detection").

In the absence of a compelling reason to declare an OOM earlier in memcg
context than page allocator context, it seems reasonable to supplant
MEM_CGROUP_RECLAIM_RETRIES with MAX_RECLAIM_RETRIES, making the page
allocator and memcg internals more similar in semantics when reclaim
fails to produce results, avoiding premature OOMs or throttling.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
---
 mm/memcontrol.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b040951ccd6b..d3b23c57bed4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -73,9 +73,6 @@ EXPORT_SYMBOL(memory_cgrp_subsys);
 
 struct mem_cgroup *root_mem_cgroup __read_mostly;
 
-/* The number of times we should retry reclaim failures before giving up. */
-#define MEM_CGROUP_RECLAIM_RETRIES	5
-
 /* Socket memory accounting disabled? */
 static bool cgroup_memory_nosocket;
 
@@ -2386,7 +2383,7 @@ void mem_cgroup_handle_over_high(void)
 	unsigned long pflags;
 	unsigned long nr_reclaimed;
 	unsigned int nr_pages = current->memcg_nr_pages_over_high;
-	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
+	int nr_retries = MAX_RECLAIM_RETRIES;
 	struct mem_cgroup *memcg;
 
 	if (likely(!nr_pages))
@@ -2438,7 +2435,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		      unsigned int nr_pages)
 {
 	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
-	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
+	int nr_retries = MAX_RECLAIM_RETRIES;
 	struct mem_cgroup *mem_over_limit;
 	struct page_counter *counter;
 	unsigned long nr_reclaimed;
@@ -2557,7 +2554,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		       get_order(nr_pages * PAGE_SIZE));
 	switch (oom_status) {
 	case OOM_SUCCESS:
-		nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
+		nr_retries = MAX_RECLAIM_RETRIES;
 		goto retry;
 	case OOM_FAILED:
 		goto force;
@@ -3168,7 +3165,7 @@ static inline bool memcg_has_children(struct mem_cgroup *memcg)
  */
 static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 {
-	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
+	int nr_retries = MAX_RECLAIM_RETRIES;
 
 	/* we call try-to-free pages for make this cgroup empty */
 	lru_add_drain_all();
@@ -6001,7 +5998,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 				 char *buf, size_t nbytes, loff_t off)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
-	unsigned int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
+	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
 	bool drained = false;
 	unsigned long high;
 	int err;
@@ -6049,7 +6046,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
-	unsigned int nr_reclaims = MEM_CGROUP_RECLAIM_RETRIES;
+	unsigned int nr_reclaims = MAX_RECLAIM_RETRIES;
 	bool drained = false;
 	unsigned long max;
 	int err;
-- 
2.26.2

