Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB41A4ED0E0
	for <lists+cgroups@lfdr.de>; Thu, 31 Mar 2022 02:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352102AbiCaAaP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Mar 2022 20:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352100AbiCaAaO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Mar 2022 20:30:14 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2365F61
        for <cgroups@vger.kernel.org>; Wed, 30 Mar 2022 17:28:28 -0700 (PDT)
Date:   Wed, 30 Mar 2022 17:28:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648686506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jJCkR8Jqm62pdxZogzgoWn7utwih/y2wfzxyFGpIn/U=;
        b=NMWkMdAryffAdC9bHXtUzUBevhGQztvRKoIsGq2gk+6d+h+xM7BmQuTWclsyWZtiPFwe01
        raOCfjg/oGNfvLb7bdUkawI09np2FJTF2lpY+sx3fuqtGGal9SzQoGcxT3OMVJIFwGrCOV
        NrqWFGA4MvW8GVoYf/NZS/p+8ioElpc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [Patch v2 3/3] mm/memcg: move generation assignment and
 comparison together
Message-ID: <YkT1paG1n0ZLe3YN@carbon.dhcp.thefacebook.com>
References: <20220330234719.18340-1-richard.weiyang@gmail.com>
 <20220330234719.18340-4-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330234719.18340-4-richard.weiyang@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 30, 2022 at 11:47:19PM +0000, Wei Yang wrote:
> For each round-trip, we assign generation on first invocation and
> compare it on subsequent invocations.
> 
> Let's move them together to make it more self-explaining. Also this
> reduce a check on prev.
> 
> [hannes@cmpxchg.org: better comment to explain reclaim model]
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

> 
> ---
> v2: a better comment from Johannes
> ---
>  mm/memcontrol.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5d433b79ba47..2cd8bfdec379 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1013,7 +1013,13 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>  		mz = root->nodeinfo[reclaim->pgdat->node_id];
>  		iter = &mz->iter;
>  
> -		if (prev && reclaim->generation != iter->generation)
> +		/*
> +		 * On start, join the current reclaim iteration cycle.
> +		 * Exit when a concurrent walker completes it.
> +		 */
> +		if (!prev)
> +			reclaim->generation = iter->generation;
> +		else if (reclaim->generation != iter->generation)
>  			goto out_unlock;
>  
>  		while (1) {
> @@ -1075,8 +1081,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>  
>  		if (!memcg)
>  			iter->generation++;
> -		else if (!prev)
> -			reclaim->generation = iter->generation;
>  	}
>  
>  out_unlock:
> -- 
> 2.33.1
> 
> 
