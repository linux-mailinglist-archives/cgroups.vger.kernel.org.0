Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28DB411EB14
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2019 20:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfLMTWJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Dec 2019 14:22:09 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42680 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbfLMTWJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Dec 2019 14:22:09 -0500
Received: by mail-qk1-f193.google.com with SMTP id z14so108929qkg.9
        for <cgroups@vger.kernel.org>; Fri, 13 Dec 2019 11:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIHxBHZ5brpnLBIeYRR4Zy+JYAJhZx+hc+o8DfZr+/0=;
        b=cUlOaDnZdkeZLanKU3aLP1Zk7P6+nUwqXpUXG5Wy4VV4OTMlkGpuWWEqfSVH12ocLM
         XW/RSAmDIh0aicHiA8TCP7oJWIdm3BjV+PjXtnjLEv4Vx+gYKi6UT6j4Y+TFZ6kttAjQ
         rOcwCQitZxXydHocsR8D8uK1qftqZfS7jmgt7MiTq8B6zQX4FN1IhGpfxiU1u3TzvqNQ
         N43RE+El1Y3SQlyrZ1fToTNWVetgMWKvIwiYNQa9mtwM//ebyVkeUgfcEIY3Ce4Gn07A
         58t78H8dkSNt6+9GZ1L6E7IJTa06q+H2BxoPjPzdh+VqBMfV1yqxOnDyUZKjtJop8ZG3
         51Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIHxBHZ5brpnLBIeYRR4Zy+JYAJhZx+hc+o8DfZr+/0=;
        b=nib8egPp6QnTEeSVc1HNMCpDLnzAJQYseLhehT94NaFE1APGgl/WYUkLZKdjlKlKp0
         mFbqK4FgygEWDz/X7U2zjs49QgAtECtHHus54nQ6FWsjmtrMAys1t8SpBzJBr8U0xDOX
         WOZrcnEbmNkW3YHqr1p6zmZy/yvySQhP4G0UpVBWtpOtKEMFo0FuyVuySXRbR51g9a32
         kc9bNo/ChdQXgAMADtdmaAHqx0GVlrnT05KEsxi+hJrDkLNG/u8jnomnt5LoyLrs/q2u
         Mhomaf/a/G2aQ8ZoHh6IJzES8LmX3BEpEi614a8KZRE7lEhULyu3ekgI31+8yqy8j01p
         IvZg==
X-Gm-Message-State: APjAAAVLMgc9u+B5Lql6sub8RrIq6p/6sTtpocwm1eoYLLzY+uYyIWiT
        P179Q4dkE5TrA3tJKnlk5VkgUA==
X-Google-Smtp-Source: APXvYqzIQGv+yc5JGtSvpf6UidQoCll4ofJa937AnUTHgdo7FLBJIiUjkYn94LuuO96ZkGf3sxfGAA==
X-Received: by 2002:a05:620a:3cf:: with SMTP id r15mr15267665qkm.12.1576264928301;
        Fri, 13 Dec 2019 11:22:08 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id q126sm3074257qkd.21.2019.12.13.11.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 11:22:07 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/3] mm: memcontrol: fix memory.low proportional distribution
Date:   Fri, 13 Dec 2019 14:21:56 -0500
Message-Id: <20191213192158.188939-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213192158.188939-1-hannes@cmpxchg.org>
References: <20191213192158.188939-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When memory.low is overcommitted - i.e. the children claim more
protection than their shared ancestor grants them - the allowance is
distributed in proportion to each siblings's utilized protection:

	low_usage = min(low, usage)
	elow = parent_elow * (low_usage / siblings_low_usage)

However, siblings_low_usage is not the sum of all low_usages. It sums
up the usages of *only those cgroups that are within their memory.low*
That means that low_usage can be *bigger* than siblings_low_usage, and
consequently the total protection afforded to the children can be
bigger than what the ancestor grants the subtree.

Consider three groups where two are in excess of their protection:

  A/memory.low = 10G
  A/A1/memory.low = 10G, A/memory.current = 20G
  A/A2/memory.low = 10G, B/memory.current = 20G
  A/A3/memory.low = 10G, C/memory.current =  8G

  siblings_low_usage = 8G (only A3 contributes)
  A1/elow = parent_elow(10G) * low_usage(20G) / siblings_low_usage(8G) = 25G

The 25G are then capped to A1's own memory.low setting, i.e. 10G. The
same is true for A2. And A3 would also receive 10G. The combined
protection of A1, A2 and A3 is 30G, when A limits the tree to 10G.

What does this mean in practice? A1 and A2 would still be in excess of
their 10G allowance and would be reclaimed, whereas A3 would not. As
they eventually drop below their protection setting, they would be
counted in siblings_low_usage again and the error would right itself.

When reclaim is applied in a binary fashion - cgroup is reclaimed when
it's above its protection, otherwise it's skipped - this could work
actually work out just fine - although it's not quite clear to me why
we'd introduce this error in the first place. However, since
1bc63fb1272b ("mm, memcg: make scan aggression always exclude
protection"), reclaim pressure is scaled to how much a cgroup is above
its protection. As a result this calculation error unduly skews
pressure away from A1 and A2 toward the rest of the system.

Fix this by by making siblings_low_usage the sum of all protected
memory among siblings, including those that are in excess of their
protection.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c   |  4 +---
 mm/page_counter.c | 12 ++----------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c5b5f74cfd4d..874a0b00f89b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6236,9 +6236,7 @@ struct cgroup_subsys memory_cgrp_subsys = {
  * elow = min( memory.low, parent->elow * ------------------ ),
  *                                        siblings_low_usage
  *
- *             | memory.current, if memory.current < memory.low
- * low_usage = |
- *	       | 0, otherwise.
+ * low_usage = min(memory.low, memory.current)
  *
  *
  * Such definition of the effective memory.low provides the expected
diff --git a/mm/page_counter.c b/mm/page_counter.c
index de31470655f6..75d53f15f040 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -23,11 +23,7 @@ static void propagate_protected_usage(struct page_counter *c,
 		return;
 
 	if (c->min || atomic_long_read(&c->min_usage)) {
-		if (usage <= c->min)
-			protected = usage;
-		else
-			protected = 0;
-
+		protected = min(usage, c->min);
 		old_protected = atomic_long_xchg(&c->min_usage, protected);
 		delta = protected - old_protected;
 		if (delta)
@@ -35,11 +31,7 @@ static void propagate_protected_usage(struct page_counter *c,
 	}
 
 	if (c->low || atomic_long_read(&c->low_usage)) {
-		if (usage <= c->low)
-			protected = usage;
-		else
-			protected = 0;
-
+		protected = min(usage, c->low);
 		old_protected = atomic_long_xchg(&c->low_usage, protected);
 		delta = protected - old_protected;
 		if (delta)
-- 
2.24.0

