Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B224D7F31
	for <lists+cgroups@lfdr.de>; Mon, 14 Mar 2022 10:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbiCNJ4a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Mar 2022 05:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238260AbiCNJ4V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Mar 2022 05:56:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B776A3CFD9
        for <cgroups@vger.kernel.org>; Mon, 14 Mar 2022 02:54:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 72ED2210FE;
        Mon, 14 Mar 2022 09:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647251643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6VPBVQrxRZ4Cx7+iuRgH+2wDidcAf0gmeaDeqXu8ow8=;
        b=uoiY0spO/Ap8AdtaUTbRUJl58srkazDganaxbtxD0SvT4OF+KtD/ux6hk3ueqxX3EGYSu8
        3c7E3zpadTc2qGeE9wDEVL6l9ZxN/hlQAFwh+2UJy2pFUjgaa0NOxcMOR6iuKz6UyqfBHr
        k6RF+rr6F+tvDC5mnQrI0i5fti0aj78=
Received: from suse.cz (unknown [10.163.30.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5BF37A3B81;
        Mon, 14 Mar 2022 09:54:03 +0000 (UTC)
Date:   Mon, 14 Mar 2022 10:54:03 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [Patch v2 2/3] mm/memcg: __mem_cgroup_remove_exceeded could
 handle a !on-tree mz properly
Message-ID: <Yi8Qu/1V4H1M9qZV@dhcp22.suse.cz>
References: <20220312071623.19050-1-richard.weiyang@gmail.com>
 <20220312071623.19050-2-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220312071623.19050-2-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 12-03-22 07:16:22, Wei Yang wrote:
> There is no tree operation if mz is not on-tree.

This doesn't explain problem you are trying to solve nor does it make
much sense to me TBH.

> Let's remove the extra check.

What would happen if the mz was already in the excess tree and the
excess has grown?

> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  mm/memcontrol.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d70bf5cf04eb..344a7e891bc5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -545,9 +545,11 @@ static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
>  			unsigned long flags;
>  
>  			spin_lock_irqsave(&mctz->lock, flags);
> -			/* if on-tree, remove it */
> -			if (mz->on_tree)
> -				__mem_cgroup_remove_exceeded(mz, mctz);
> +			/*
> +			 * remove it first
> +			 * If not on-tree, no tree ops.
> +			 */
> +			__mem_cgroup_remove_exceeded(mz, mctz);
>  			/*
>  			 * Insert again. mz->usage_in_excess will be updated.
>  			 * If excess is 0, no tree ops.
> -- 
> 2.33.1

-- 
Michal Hocko
SUSE Labs
