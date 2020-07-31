Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A13E2349E1
	for <lists+cgroups@lfdr.de>; Fri, 31 Jul 2020 19:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732474AbgGaRGu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 Jul 2020 13:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729944AbgGaRGu (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 31 Jul 2020 13:06:50 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3255C2074B;
        Fri, 31 Jul 2020 17:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596215210;
        bh=+VUSWtEU2obYc+ePK90t3RP8I0yTyfzAx4iIOrUuZ74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAtSmDC2w2Ln8WEh56WQL62yee5akpVM/VnuiX7LQro9A/Sugff2KEgX4ZZhQfEjt
         AXtxfpZPx3m5Ximt3xarWPZ9mJHS/3AZd/8YL4lrbbEMgE983KIrz+1CvhlmfuC4/W
         lBnYRB/UOVWASkawWXD+zIapf/NNgOuCqNtAFETk=
Date:   Fri, 31 Jul 2020 12:12:53 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 1/2][next] mm: memcontrol: Use flex_array_size() helper in
 memcpy()
Message-ID: <ddd60dae2d9aea1ccdd2be66634815c93696125e.1596214831.git.gustavoars@kernel.org>
References: <cover.1596214831.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1596214831.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Make use of the flex_array_size() helper to calculate the size of a
flexible array member within an enclosing structure.

This helper offers defense-in-depth against potential integer
overflows, while at the same time makes it explicitly clear that
we are dealing with a flexible array member.

Also, remove unnecessary braces.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 mm/memcontrol.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e84c2b5596f2..bd7f972ceea4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4246,10 +4246,9 @@ static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
 	new->size = size;
 
 	/* Copy thresholds (if any) to new array */
-	if (thresholds->primary) {
-		memcpy(new->entries, thresholds->primary->entries, (size - 1) *
-				sizeof(struct mem_cgroup_threshold));
-	}
+	if (thresholds->primary)
+		memcpy(new->entries, thresholds->primary->entries,
+		       flex_array_size(new, entries, size - 1));
 
 	/* Add new threshold */
 	new->entries[size - 1].eventfd = eventfd;
-- 
2.27.0

