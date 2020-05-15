Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECE61D5AA4
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 22:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgEOUUh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 16:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgEOUUg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 15 May 2020 16:20:36 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 279B2207D0;
        Fri, 15 May 2020 20:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589574036;
        bh=ZAMCAB5zes7ruduXHumaQzQVZLxAMKuG/SKsRaj1NlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SkFSq6ZAAiVv4raX5iKLhpQJFcUpdyCP3HRO0BnvNHpA1KIXtJ66vTw9tP+hrXvFM
         oCx3nKSJOBP94f02W5Ib95YlcxwiP2RtVmREMECQWBsxvJLKd8Zv5DzjTRANhA076R
         AG6UWkiTWPsXNw2UhZeUbOVwzHw+bTx0zE8uLMZk=
From:   Jakub Kicinski <kuba@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, kernel-team@fb.com, tj@kernel.org,
        hannes@cmpxchg.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        shakeelb@google.com, mhocko@kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH mm v3 2/3] mm: move penalty delay clamping out of calculate_high_delay()
Date:   Fri, 15 May 2020 13:20:26 -0700
Message-Id: <20200515202027.3217470-3-kuba@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200515202027.3217470-1-kuba@kernel.org>
References: <20200515202027.3217470-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We will want to call calculate_high_delay() twice - once for
memory and once for swap, and we should apply the clamp value
to sum of the penalties. Clamping has to be applied outside
of calculate_high_delay().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 mm/memcontrol.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 851f4d033e8f..b2022f98bf46 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2365,14 +2365,7 @@ static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
 	 * MEMCG_CHARGE_BATCH pages is nominal, so work out how much smaller or
 	 * larger the current charge patch is than that.
 	 */
-	penalty_jiffies = penalty_jiffies * nr_pages / MEMCG_CHARGE_BATCH;
-
-	/*
-	 * Clamp the max delay per usermode return so as to still keep the
-	 * application moving forwards and also permit diagnostics, albeit
-	 * extremely slowly.
-	 */
-	return min(penalty_jiffies, MEMCG_MAX_HIGH_DELAY_JIFFIES);
+	return penalty_jiffies * nr_pages / MEMCG_CHARGE_BATCH;
 }
 
 /*
@@ -2400,6 +2393,13 @@ void mem_cgroup_handle_over_high(void)
 	penalty_jiffies = calculate_high_delay(memcg, nr_pages,
 					       mem_find_max_overage(memcg));
 
+	/*
+	 * Clamp the max delay per usermode return so as to still keep the
+	 * application moving forwards and also permit diagnostics, albeit
+	 * extremely slowly.
+	 */
+	penalty_jiffies = min(penalty_jiffies, MEMCG_MAX_HIGH_DELAY_JIFFIES);
+
 	/*
 	 * Don't sleep if the amount of jiffies this memcg owes us is so low
 	 * that it's not even worth doing, in an attempt to be nice to those who
-- 
2.25.4

