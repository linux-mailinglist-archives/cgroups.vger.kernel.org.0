Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 672871837AB
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2020 18:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgCLRdL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Mar 2020 13:33:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35973 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgCLRdL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Mar 2020 13:33:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id g62so7309896wme.1
        for <cgroups@vger.kernel.org>; Thu, 12 Mar 2020 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XlHPYdHYVGL+ZH9Fy2ExhyAo23ZIkMLKS1ZUcqxxQY0=;
        b=up0/TKVQ7COgyqEd0H7isdZkegQuEbx6al4+9E95wP3QiMQsdxvH9836eQ+LluSIC5
         RrbHhXsGGbJAFQXjNgehCBmeLiF93Sg8ahlpsQiK3ct/C8obWCIZR0CUU9z9GnAc5QUt
         /KMm82i4Ln7WBp4XE3Bm+5wpBL7eIdIAKbhSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XlHPYdHYVGL+ZH9Fy2ExhyAo23ZIkMLKS1ZUcqxxQY0=;
        b=mBHX4IGmP3cJ0VMHj12E8XoBpS/nu/tzfUG9Ymr4s51icja5Oi4f9aKlPCGbVW/a+f
         hHVRWC144/zIHq6VwEoHZKm1aFxeWkbsvN8bLVeIqdHe2fDLWAkNpGoSwRbpkJy5lkwc
         gRwAs2u83p9KMoUYIN14JALmGaxwdMhpqI6vuBNsoTIWHLFStNifIEo0ezWIo+ktaTPp
         mVoAJHcoh4y5ME8ZEqyqsInXiHxvIfmwG+WB0+jmWjLoLtED9vZZUQUjvOeVnvBpcKTx
         o/Kvo/ebhkmnPDctABONTb6eh3fzhbyxQ64aRLG19SklivS+9mLbG1LMLAM5D2X4059f
         cZ4A==
X-Gm-Message-State: ANhLgQ0w1Jpx5WVjktOcmEmGpk32f1KPgNVNH2hHDtaWNFUNUBKNUuOy
        rI6SOU6Y55EPkn7Fe+Q/UQqSUg==
X-Google-Smtp-Source: ADFU+vvMEQBOPd6Zfe5WzhxMWesz4iewNlgOu1pm6OgWwYpcAaCXRS0o8aM/RRSitF4y+VwXVIB6pw==
X-Received: by 2002:a1c:7d88:: with SMTP id y130mr6104452wmc.5.1584034388539;
        Thu, 12 Mar 2020 10:33:08 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id l17sm14887319wmg.23.2020.03.12.10.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:33:08 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:33:07 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 4/6] mm, memcg: Prevent memory.min load/store tearing
Message-ID: <e809b4e6b0c1626dac6945970de06409a180ee65.1584034301.git.chris@chrisdown.name>
References: <cover.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584034301.git.chris@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This can be set concurrently with reads, which may cause the wrong value
to be propagated.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 mm/memcontrol.c   |  4 ++--
 mm/page_counter.c | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c85a304fa4a1..e0ed790a2a8c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6261,7 +6261,7 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	if (!usage)
 		return MEMCG_PROT_NONE;
 
-	emin = memcg->memory.min;
+	emin = READ_ONCE(memcg->memory.min);
 	elow = READ_ONCE(memcg->memory.low);
 
 	parent = parent_mem_cgroup(memcg);
@@ -6277,7 +6277,7 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	if (emin && parent_emin) {
 		unsigned long min_usage, siblings_min_usage;
 
-		min_usage = min(usage, memcg->memory.min);
+		min_usage = min(usage, READ_ONCE(memcg->memory.min));
 		siblings_min_usage = atomic_long_read(
 			&parent->memory.children_min_usage);
 
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 18b7f779f2e2..ae471c7d255f 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -17,14 +17,16 @@ static void propagate_protected_usage(struct page_counter *c,
 				      unsigned long usage)
 {
 	unsigned long protected, old_protected;
-	unsigned long low;
+	unsigned long low, min;
 	long delta;
 
 	if (!c->parent)
 		return;
 
-	if (c->min || atomic_long_read(&c->min_usage)) {
-		if (usage <= c->min)
+	min = READ_ONCE(c->min);
+
+	if (min || atomic_long_read(&c->min_usage)) {
+		if (usage <= min)
 			protected = usage;
 		else
 			protected = 0;
@@ -217,7 +219,7 @@ void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages)
 {
 	struct page_counter *c;
 
-	counter->min = nr_pages;
+	WRITE_ONCE(counter->min, nr_pages);
 
 	for (c = counter; c; c = c->parent)
 		propagate_protected_usage(c, atomic_long_read(&c->usage));
-- 
2.25.1

