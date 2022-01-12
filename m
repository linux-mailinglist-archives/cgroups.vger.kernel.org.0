Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EF048C077
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 09:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351801AbiALI4T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jan 2022 03:56:19 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54540 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351771AbiALI4T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jan 2022 03:56:19 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E746B1F3C0;
        Wed, 12 Jan 2022 08:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641977777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uBzH2mVPP3ctB/WRYSae7RVF7fvvNk6lw/YieWT7XoY=;
        b=emOHqq2ajf3XQKAtY6MDJLTTxLdgpdZuzRzgsgUybOUXZau2wtcPEN+0xr/6g9XFLCUxaN
        gbR5sH+syOJ7AMleiVDT3t5vtqUQQUBLBKTGlufLw6GethRo+KdXM0yImTJbsHGn4+F+En
        ITLplvGE0N3IntYNvADruyzhJCyB1uc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9722AA3B85;
        Wed, 12 Jan 2022 08:56:16 +0000 (UTC)
Date:   Wed, 12 Jan 2022 09:56:15 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        vbabka@suse.cz, willy@infradead.org, songmuchun@bytedance.com,
        shy828301@gmail.com, surenb@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm/memcg: use NUMA_NO_NODE to indicate allocation
 from unspecified node
Message-ID: <Yd6Xr7K9bKGVgGtI@dhcp22.suse.cz>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
 <Yd1CdJA5NelzoK1D@dhcp22.suse.cz>
 <20220112004634.dc5suwei4ymyxaxg@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112004634.dc5suwei4ymyxaxg@master>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 12-01-22 00:46:34, Wei Yang wrote:
> On Tue, Jan 11, 2022 at 09:40:20AM +0100, Michal Hocko wrote:
> >On Tue 11-01-22 01:02:59, Wei Yang wrote:
> >> Instead of use "-1", let's use NUMA_NO_NODE for consistency.
> >> 
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >
> >I am not really sure this is worth it. After the merge window I plan to
> >post http://lkml.kernel.org/r/20211214100732.26335-1-mhocko@kernel.org.
> 
> Give me some time to understand it :-)

Just for the record, here is what I have put on top of that series:
--- 
From b7195eba02fe6308a6927450f4630057c05e808e Mon Sep 17 00:00:00 2001
From: Wei Yang <richard.weiyang@gmail.com>
Date: Tue, 11 Jan 2022 09:45:25 +0100
Subject: [PATCH] memcg: do not tweak node in alloc_mem_cgroup_per_node_info

alloc_mem_cgroup_per_node_info is allocated for each possible node and
this used to be a problem because not !node_online nodes didn't have
appropriate data structure allocated. This has changed by "mm: handle
uninitialized numa nodes gracefully" so we can drop the special casing
here.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 781605e92015..ed19a21ee14e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5044,18 +5044,8 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
 static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn;
-	int tmp = node;
-	/*
-	 * This routine is called against possible nodes.
-	 * But it's BUG to call kmalloc() against offline node.
-	 *
-	 * TODO: this routine can waste much memory for nodes which will
-	 *       never be onlined. It's better to use memory hotplug callback
-	 *       function.
-	 */
-	if (!node_state(node, N_NORMAL_MEMORY))
-		tmp = -1;
-	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, tmp);
+
+	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, node);
 	if (!pn)
 		return 1;
 
-- 
2.30.2


-- 
Michal Hocko
SUSE Labs
