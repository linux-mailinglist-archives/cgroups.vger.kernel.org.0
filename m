Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E344F11F9
	for <lists+cgroups@lfdr.de>; Mon,  4 Apr 2022 11:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbiDDJ3y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Apr 2022 05:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiDDJ3y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Apr 2022 05:29:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E553BBC6
        for <cgroups@vger.kernel.org>; Mon,  4 Apr 2022 02:27:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 310E3210DE;
        Mon,  4 Apr 2022 09:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649064477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OwAumWcezlls50PruntJTwS4J8Nr3qUaKu9aGBgBgEs=;
        b=mpv1G9m8vdAxMGUmqMs2ZgJLiHrJG8NmRRJRgSjJkp8vlwqkbtqDCNu0V7MLx7sAqB84UW
        hct3dBWDtjrzRplcnV9lYZyLRrmKWf/vDGRfJS8RdGbYe4vdXtUY7JgHsXaZfBr0YzoL6N
        1TME0jb8pe4fGTsKW1pMDUxzsK3AKf0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EF484A3B83;
        Mon,  4 Apr 2022 09:27:56 +0000 (UTC)
Date:   Mon, 4 Apr 2022 11:27:53 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/memcg: non-hierarchical mode is deprecated
Message-ID: <Ykq6Gbt5MX9GCiKM@dhcp22.suse.cz>
References: <20220403020833.26164-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403020833.26164-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun 03-04-22 02:08:33, Wei Yang wrote:
> After commit bef8620cd8e0 ("mm: memcg: deprecate the non-hierarchical
> mode"), we won't have a NULL parent except root_mem_cgroup. And this
> case is handled when (memcg == root).
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Roman Gushchin <roman.gushchin@linux.dev>
> CC: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/memcontrol.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2cd8bfdec379..3ceb9b8592b1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6587,9 +6587,6 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
>  		return;
>  
>  	parent = parent_mem_cgroup(memcg);
> -	/* No parent means a non-hierarchical mode on v1 memcg */
> -	if (!parent)
> -		return;
>  
>  	if (parent == root) {
>  		memcg->memory.emin = READ_ONCE(memcg->memory.min);
> -- 
> 2.33.1

-- 
Michal Hocko
SUSE Labs
