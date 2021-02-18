Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338B031E633
	for <lists+cgroups@lfdr.de>; Thu, 18 Feb 2021 07:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhBRGMR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Feb 2021 01:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhBRF4o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Feb 2021 00:56:44 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735FFC06178C
        for <cgroups@vger.kernel.org>; Wed, 17 Feb 2021 21:56:04 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id t18so439143qvn.8
        for <cgroups@vger.kernel.org>; Wed, 17 Feb 2021 21:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=97xepu+H893Qn2oD7QzEQlF0nqYf2pV6us14XKtvHxU=;
        b=mgbz52W0JN7xwQftwEtM6NGsY/g84xRLA4xkhTjEINN5my44bcXRu6XD/L38sC1qfB
         fFk0r+RCj1e1clOhXV7+g4RwblTqhm4rMAYlgBga522+NSBTxYmvRQBy1Wby31qUxspS
         2o1DQPJXVPiyJh6aiJRdpzWtHvBAg8XR4lxxIg1tkZhIUN+CxS34HLATPmSjYMbryzYh
         L3gZ0Bmtz2aLr/fB2xjsFlEgfigT7X0md89CHZzGaIwcsqT+wP+5w7Yh09lA+jl/U8NS
         5ZI43x8+XjOGS5AddwtIoX1G0f0hze4USrUbCr7PTJ7ElbZRW957RBC1kocJFd96cIPp
         w/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=97xepu+H893Qn2oD7QzEQlF0nqYf2pV6us14XKtvHxU=;
        b=umJFBZCpCN3zKbvHFvH/ViF0YINu8WZPYiN9CYVhoRKcmBO/y/R10dSDrZbecGohGC
         jXEaoVMtd4W5MYnZFd69M1313+Aa9WvLIALjlfdStb1lK+Amq9eK0KYuVpUjaij8hhH4
         GwfuRfXLpPxacMIy9mm7JzK9ET1pCKU6BN2hHlMlaQh24bY44eZONyhUSzOLAU2TAMF0
         p4pQcNQXgLstpUsr3RDPL58T2UZ0sz64R+spPPw9k7R582Hsw4Pla9iIM0DvVypSmCWi
         hqddQ9bESVokB3Wuo7ACvBSx/MLjZ/e93Q+kcFNXkBWBYknURKP1+bqgCg0R3TnsqnXk
         ZLTw==
X-Gm-Message-State: AOAM530FsCHkKFPwQ7oCT2LAaHOcluXbH++L/LZypuWPgbcQNLMEe6zM
        2d91bVYi7qasHFY6bV465d2njQ==
X-Google-Smtp-Source: ABdhPJwsk5IUVrVDg92pl5EyX/4pmGD+gOB1OV30TBrbHpR+IPLGYf7+2OWQg1V2jKga9UiKmLOINw==
X-Received: by 2002:a05:6214:242f:: with SMTP id gy15mr2624583qvb.17.1613627763640;
        Wed, 17 Feb 2021 21:56:03 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id p6sm3245805qkg.36.2021.02.17.21.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 21:56:03 -0800 (PST)
Date:   Thu, 18 Feb 2021 00:56:02 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mm: Fix missing mem cgroup soft limit tree updates
Message-ID: <YC4BcsNFEmW7XeqB@cmpxchg.org>
References: <cover.1613584277.git.tim.c.chen@linux.intel.com>
 <e269f5df3af1157232b01a9b0dae3edf4880d786.1613584277.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e269f5df3af1157232b01a9b0dae3edf4880d786.1613584277.git.tim.c.chen@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 17, 2021 at 12:41:36PM -0800, Tim Chen wrote:
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
> a page belonging to a different node.  Note that this batching for
> the same node logic is only relevant for v1 cgroup that has a memory
> soft limit.
> 
> Reviewed-by: Ying Huang <ying.huang@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  mm/memcontrol.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d72449eeb85a..8bddee75f5cb 100644
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
> @@ -6849,7 +6850,13 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  	 * exclusive access to the page.
>  	 */
>  
> -	if (ug->memcg != page_memcg(page)) {
> +	if (ug->memcg != page_memcg(page) ||
> +	    /*
> +	     * Update soft limit tree used in v1 cgroup in page batch for
> +	     * the same node. Relevant only to v1 cgroup with a soft limit.
> +	     */
> +	    (ug->dummy_page && ug->nid != page_to_nid(page) &&
> +	     ug->memcg->soft_limit != PAGE_COUNTER_MAX)) {

Sorry, I used weird phrasing in my last email.

Can you please preface the checks you're adding with a
!cgroup_subsys_on_dfl(memory_cgrp_subsys) to static branch for
cgroup1? The uncharge path is pretty hot, and this would avoid the
runtime overhead on cgroup2 at least, which doesn't have the SL.

Also, do we need the ug->dummy_page check? It's only NULL on the first
loop - where ug->memcg is NULL as well and the branch is taken anyway.

The soft limit check is also slightly cheaper than the nid check, as
page_to_nid() might be out-of-line, so we should do it first. This?

	/*
	 * Batch-uncharge all pages of the same memcg.
	 *
	 * Unless we're looking at a cgroup1 with a softlimit
	 * set: the soft limit trees are maintained per-node
	 * and updated on uncharge (via dummy_page), so keep
	 * batches confined to a single node as well.
	 */
	if (ug->memcg != page_memcg(page) ||
	    (!cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
	     ug->memcg->soft_limit != PAGE_COUNTER_MAX &&
	     ug->nid != page_to_nid(page)))
