Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAF64D7F06
	for <lists+cgroups@lfdr.de>; Mon, 14 Mar 2022 10:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiCNJxC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Mar 2022 05:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiCNJxC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Mar 2022 05:53:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2069E3819D
        for <cgroups@vger.kernel.org>; Mon, 14 Mar 2022 02:51:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C657D1F37E;
        Mon, 14 Mar 2022 09:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647251511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5NF6lNWwnFNh+7tS3faEIi4Qi8RnFVdFjDG/PzNtPM8=;
        b=bhZzDU7v8Wwu25jZoPgqNLGtwJacNFQr0K/jLRcYshdulVjtwHjNRf1zztlxnOmzoc07mJ
        W7vzaoVfXusWzd9iIBZ0J/Jl+L4G/3VfGPgdIGp+fT6zLiZ+Aj7HzzdBBUU9+rXzDfh536
        bWd6IahUctKWu9y+eoqGtn8hVAAhLJU=
Received: from suse.cz (unknown [10.163.30.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B06FAA3B8A;
        Mon, 14 Mar 2022 09:51:51 +0000 (UTC)
Date:   Mon, 14 Mar 2022 10:51:51 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [Patch v2 1/3] mm/memcg: mz already removed from rb_tree in
 mem_cgroup_largest_soft_limit_node()
Message-ID: <Yi8QN+5oeUWWJQNv@dhcp22.suse.cz>
References: <20220312071623.19050-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312071623.19050-1-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 12-03-22 07:16:21, Wei Yang wrote:
> When mz is not NULL, mem_cgroup_largest_soft_limit_node() has removed
> it from rb_tree.
> 
> Not necessary to call __mem_cgroup_remove_exceeded() again.

Yes, the call seems to be unnecessary with the current code. mz can
either come from mem_cgroup_largest_soft_limit_node or
__mem_cgroup_largest_soft_limit_node both rely on the latter so the mz
is always off the tree indeed.
 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

After the changelog is completed you can add
Acked-by: Michal Hocko <mhocko@suse.com>

In general, though, I am not a super fan of changes like these. The code
works as expected, the call for __mem_cgroup_remove_exceeded will not
really add much of an overhead and at least we can see that mz is always
removed before it is re-added back. In a hot path I would care much more
of course but this is effectivelly a dead code as the soft limit itself
is mostly a relict of past.

Please keep this in mind when you want to make further changes to this
area. The review is not free of cost and I am not sure spending time on
this area is worthwhile unless there is a real usecase in mind.

Thanks!

> ---
>  mm/memcontrol.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f898320b678a..d70bf5cf04eb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3458,7 +3458,6 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  		nr_reclaimed += reclaimed;
>  		*total_scanned += nr_scanned;
>  		spin_lock_irq(&mctz->lock);
> -		__mem_cgroup_remove_exceeded(mz, mctz);
>  
>  		/*
>  		 * If we failed to reclaim anything from this memory cgroup
> -- 
> 2.33.1

-- 
Michal Hocko
SUSE Labs
