Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454A348A9C0
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 09:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbiAKInK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 03:43:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40024 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbiAKInJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 03:43:09 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9E803212C3;
        Tue, 11 Jan 2022 08:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641890588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dvrQ8GpbOEr2tVquDL+ClTqdyZ22DJTvcyRoTEm2Few=;
        b=ZftksyPgJPdT1KN4Z0rpqdtOyK4aKsDM/AVcFvWWvEN/iE+DBT7/aePu9rel4KYi+UcjUF
        SOkLBQYNQZttG7U2AZdMQAV7CVBm/qAPiniQ2xtZwscP7phAtfbUK6rRGk7L6wCU52ttlG
        lVsVdKoJdFyAVDsVPS7feqxfuMGLcnI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 67659A3B88;
        Tue, 11 Jan 2022 08:43:08 +0000 (UTC)
Date:   Tue, 11 Jan 2022 09:43:07 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        vbabka@suse.cz, willy@infradead.org, songmuchun@bytedance.com,
        shy828301@gmail.com, surenb@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/4] mm/memcg: retrieve parent memcg from css.parent
Message-ID: <Yd1DG99LPXDmDvvs@dhcp22.suse.cz>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
 <20220111010302.8864-3-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111010302.8864-3-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 11-01-22 01:03:01, Wei Yang wrote:
> The parent we get from page_counter is correct, while this is two
> different hierarchy.
> 
> Let's retrieve the parent memcg from css.parent just like parent_cs(),
> blkcg_parent(), etc.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0c5c403f4be6..12bf443f7b14 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -886,9 +886,7 @@ static inline struct mem_cgroup *lruvec_memcg(struct lruvec *lruvec)
>   */
>  static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
>  {
> -	if (!memcg->memory.parent)
> -		return NULL;
> -	return mem_cgroup_from_counter(memcg->memory.parent, memory);
> +	return mem_cgroup_from_css(memcg->css.parent);
>  }
>  
>  static inline bool mem_cgroup_is_descendant(struct mem_cgroup *memcg,
> -- 
> 2.33.1

-- 
Michal Hocko
SUSE Labs
