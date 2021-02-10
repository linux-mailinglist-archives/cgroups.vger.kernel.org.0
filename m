Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF71D316363
	for <lists+cgroups@lfdr.de>; Wed, 10 Feb 2021 11:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhBJKME (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Feb 2021 05:12:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:48952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230497AbhBJKJU (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 10 Feb 2021 05:09:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612951696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ig9aYUdY0A4bRb/viKrqlRI25TdZpdS3B9s1FAQ8d5M=;
        b=RmTN3T8/hICAOC6l1XMuobPQa8aGQBEt6sUVbhhqfPzbXPp+lhGVtVyXxTbsWfvsph963Y
        Y1kkh53nLblH/DL0vjjcxYLKFTWG2ENavtqu0YDAbpmAWSF91HpdIw5A9ksXepM6G9BQTb
        2HvhpCJwB3kbezOlEomfoSNoAl56rhQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5AA3DAE14;
        Wed, 10 Feb 2021 10:08:16 +0000 (UTC)
Date:   Wed, 10 Feb 2021 11:08:15 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: Fix missing mem cgroup soft limit tree updates
Message-ID: <YCOwjz/F15wci5qG@dhcp22.suse.cz>
References: <cover.1612902157.git.tim.c.chen@linux.intel.com>
 <3b6e4e9aa8b3ee1466269baf23ed82d90a8f791c.1612902157.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b6e4e9aa8b3ee1466269baf23ed82d90a8f791c.1612902157.git.tim.c.chen@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 09-02-21 12:29:47, Tim Chen wrote:
> On a per node basis, the mem cgroup soft limit tree on each node tracks
> how much a cgroup has exceeded its soft limit memory limit and sorts
> the cgroup by its excess usage.  On page release, the trees are not
> updated right away, until we have gathered a batch of pages belonging to
> the same cgroup. This reduces the frequency of updating the soft limit tree
> and locking of the tree and associated cgroup.
> 
> However, the batch of pages could contain pages from multiple nodes but
> only the soft limit tree from one node would get updated.  Change the
> logic so that we update the tree in batch of pages, with each batch of
> pages all in the same mem cgroup and memory node.  An update is issued for
> the batch of pages of a node collected till now whenever we encounter
> a page belonging to a different node.

I do agree with Johannes here. This shouldn't be done unconditionally
for all memcgs. Wouldn't it be much better to do the fix up in the
mem_cgroup_soft_reclaim path instead. Simply check the excess before
doing any reclaim?

Btw. have you seen this triggering a noticeable misbehaving? I would
expect this to have a rather small effect considering how many sources
of memcg_check_events we have.

Unless I have missed something this has been introduced by 747db954cab6
("mm: memcontrol: use page lists for uncharge batching"). Please add
Fixes tag as well if this is really worth fixing.

> Reviewed-by: Ying Huang <ying.huang@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  mm/memcontrol.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d72449eeb85a..f5a4a0e4e2ec 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6804,6 +6804,7 @@ struct uncharge_gather {
>  	unsigned long pgpgout;
>  	unsigned long nr_kmem;
>  	struct page *dummy_page;
> +	int nid;
>  };
>  
>  static inline void uncharge_gather_clear(struct uncharge_gather *ug)
> @@ -6849,7 +6850,9 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  	 * exclusive access to the page.
>  	 */
>  
> -	if (ug->memcg != page_memcg(page)) {
> +	if (ug->memcg != page_memcg(page) ||
> +	    /* uncharge batch update soft limit tree on a node basis */
> +	    (ug->dummy_page && ug->nid != page_to_nid(page))) {
>  		if (ug->memcg) {
>  			uncharge_batch(ug);
>  			uncharge_gather_clear(ug);
> @@ -6869,6 +6872,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  		ug->pgpgout++;
>  
>  	ug->dummy_page = page;
> +	ug->nid = page_to_nid(page);
>  	page->memcg_data = 0;
>  	css_put(&ug->memcg->css);
>  }
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
