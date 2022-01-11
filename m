Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B8B48A9B2
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 09:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbiAKIkX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 03:40:23 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38060 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbiAKIkW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 03:40:22 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D04351F3B8;
        Tue, 11 Jan 2022 08:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641890421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VIUY6eShIdRTWSX2SPQ97aOdwxxv1/dSNJBcmaqEh1k=;
        b=F6OQn/8ghbFt5kDOe4MDHdFUUUJKANC6GwmV1NZ9rs/hfuit0S6arCMN+IIbKkNilDqykQ
        VkFrl8zKQmi6G2ugEIf9Sggw6KPJC4bGGTrmbqFIEkWlWZYdXeQjIsHCKgy7+6daHk8aJx
        bxjWj2srPDWFaegvbV1yxKE1P9cKT9E=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 52F29A3B88;
        Tue, 11 Jan 2022 08:40:21 +0000 (UTC)
Date:   Tue, 11 Jan 2022 09:40:20 +0100
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
Message-ID: <Yd1CdJA5NelzoK1D@dhcp22.suse.cz>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111010302.8864-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 11-01-22 01:02:59, Wei Yang wrote:
> Instead of use "-1", let's use NUMA_NO_NODE for consistency.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

I am not really sure this is worth it. After the merge window I plan to
post http://lkml.kernel.org/r/20211214100732.26335-1-mhocko@kernel.org.
With that in place we can drop the check and a node rewrite so the net
result will be a less and more straightforward code. If you agree I can
add this with your s-o-b into my series:

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
Michal Hocko
SUSE Labs
