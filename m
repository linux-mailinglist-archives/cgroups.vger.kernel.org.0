Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C731D9DB8
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2020 19:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgESRTq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 May 2020 13:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbgESRTq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 19 May 2020 13:19:46 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AEBC20842;
        Tue, 19 May 2020 17:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589908786;
        bh=zU6BYtpx72jVihkxFVAWHDj5teHYoyigohzs9US3qOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JfArE+DcUqMaPPcH22CmjeNr+UUcveoCTLxPwwCXAl4yzL4t/o8xCIn/rC0bu6w1t
         FIQx4izTk1vUtqunaed9xnCxYL46+rhD6slzqJZ2qfV9L2HVIt7eyI66Jc+Ben4V0B
         mTW6IdrolslgP0tN6vnR5aW5YQGaeoD3obXlzh7s=
From:   Jakub Kicinski <kuba@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, kernel-team@fb.com, tj@kernel.org,
        hannes@cmpxchg.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        shakeelb@google.com, mhocko@kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH mm v4 2/4] mm: move penalty delay clamping out of calculate_high_delay()
Date:   Tue, 19 May 2020 10:19:36 -0700
Message-Id: <20200519171938.3569605-3-kuba@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200519171938.3569605-1-kuba@kernel.org>
References: <20200519171938.3569605-1-kuba@kernel.org>
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
index 0d05e6a593f5..dd8605a9137a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2367,14 +2367,7 @@ static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
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
@@ -2402,6 +2395,13 @@ void mem_cgroup_handle_over_high(void)
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

