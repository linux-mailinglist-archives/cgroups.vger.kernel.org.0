Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D26901837A8
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2020 18:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCLRdE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Mar 2020 13:33:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46392 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgCLRdE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Mar 2020 13:33:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so8534634wrw.13
        for <cgroups@vger.kernel.org>; Thu, 12 Mar 2020 10:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wi04zoB+1lwUS/JkrIWiJtz6qrlQUGWxV2d3AofBbt4=;
        b=qdHoaPhxQicwt6H3R0TCGLXYf5k3L9ooFg374fONxjv8C3rvNxgZwp+11xl3vl5riH
         0+LwXAumxpp4RyUzxzdWqtEjG5BG9CDRPl4N6+xAtMsl5UUdZ8hz2enRswBOwYzfdka9
         XGBadlITdSJeRvdGcod95gw7PRehSEFfoQdJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wi04zoB+1lwUS/JkrIWiJtz6qrlQUGWxV2d3AofBbt4=;
        b=MWJfpHxEWT0u1UXgY7AzJzAFOgM3S3hXwFGTbTy6u+auYawhsTzTVm7zv/Wo+1GURC
         GupPJGuzvCsJX5i0FkyoSmvVx59CF8tcbHndbNtSKkNIyiJgwdEmOpd61bi/0fUCnJlO
         fp/IYn4I6e0YiJ5dy4a1svRqbOLMfmBo08hpm3zTWpzWHj1Lqe4ovWNDfQki+R0uxdgX
         BK7jwmHvM/EOWUnCcNwUgffI0nGI/3/0P0Q61WL1Q8wIbg+Uwi7b55Mym4hE78KP+gwD
         CE7HtVFN4w4mKqbfOGjR/unebppV5L04pw1ug+6u5Vtc7NAm2uGbLoW6KLNtnpY3mgre
         8ggA==
X-Gm-Message-State: ANhLgQ26YsaUIM0KFcaTXYDMHiRu+FXIRHHMNUnj1TsObhdUASTT6zyD
        lO5DFOJiQpkbiB/4A7ahPW9Hqg==
X-Google-Smtp-Source: ADFU+vs6lh4JtrMC8cO3JiGvHgD7AQUqQmn80t3o/bMOWdGzTkGWTWbLaTayMV0C4e7AmUIfCKkQxw==
X-Received: by 2002:adf:e4ca:: with SMTP id v10mr11831736wrm.305.1584034382407;
        Thu, 12 Mar 2020 10:33:02 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id s7sm9500905wro.10.2020.03.12.10.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:33:01 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:33:01 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 3/6] mm, memcg: Prevent memory.low load/store tearing
Message-ID: <448206f44b0fa7be9dad2ca2601d2bcb2c0b7844.1584034301.git.chris@chrisdown.name>
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
 mm/memcontrol.c   | 4 ++--
 mm/page_counter.c | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index aca2964ea494..c85a304fa4a1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6262,7 +6262,7 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 		return MEMCG_PROT_NONE;
 
 	emin = memcg->memory.min;
-	elow = memcg->memory.low;
+	elow = READ_ONCE(memcg->memory.low);
 
 	parent = parent_mem_cgroup(memcg);
 	/* No parent means a non-hierarchical mode on v1 memcg */
@@ -6291,7 +6291,7 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 	if (elow && parent_elow) {
 		unsigned long low_usage, siblings_low_usage;
 
-		low_usage = min(usage, memcg->memory.low);
+		low_usage = min(usage, READ_ONCE(memcg->memory.low));
 		siblings_low_usage = atomic_long_read(
 			&parent->memory.children_low_usage);
 
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 50184929b61f..18b7f779f2e2 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -17,6 +17,7 @@ static void propagate_protected_usage(struct page_counter *c,
 				      unsigned long usage)
 {
 	unsigned long protected, old_protected;
+	unsigned long low;
 	long delta;
 
 	if (!c->parent)
@@ -34,8 +35,10 @@ static void propagate_protected_usage(struct page_counter *c,
 			atomic_long_add(delta, &c->parent->children_min_usage);
 	}
 
-	if (c->low || atomic_long_read(&c->low_usage)) {
-		if (usage <= c->low)
+	low = READ_ONCE(c->low);
+
+	if (low || atomic_long_read(&c->low_usage)) {
+		if (usage <= low)
 			protected = usage;
 		else
 			protected = 0;
@@ -231,7 +234,7 @@ void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages)
 {
 	struct page_counter *c;
 
-	counter->low = nr_pages;
+	WRITE_ONCE(counter->low, nr_pages);
 
 	for (c = counter; c; c = c->parent)
 		propagate_protected_usage(c, atomic_long_read(&c->usage));
-- 
2.25.1

