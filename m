Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5BD13609C
	for <lists+cgroups@lfdr.de>; Thu,  9 Jan 2020 19:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgAIS6t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Jan 2020 13:58:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39576 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbgAIS6t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Jan 2020 13:58:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so4018496wmj.4;
        Thu, 09 Jan 2020 10:58:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MLlNWsBXrOryBNtAajsP6p+tnqNK4xK0vs1yNExUT74=;
        b=dXpGQDDRjIlA+gLoIO93LYwxU1Y3f0diNv9ORZMRHK7jKbQTMTjT5D1ewnvkK6Nhu2
         Kb3xIZ3ErRMeqoKcXC7X20g/E6GtJnb/yzGcNVgNLIVnzSHiR9fUCfNk9cezky0hmtrK
         fhMH1A7xwmRNHLYewxSACECZVg0jx0QwpOVyN8Wg916K449RG4nstfu2o9GtJQL2Qol5
         LehQ319GGwSoRsobCfNAPYfZvWy07RCock6CgXNnORwve13m+1zagA5oLZmjVIZ9rFU0
         ZOaB8wGfVEN5kZvlWEFYBWRZwGZwL9q6X6nPIQ2nUA/kPIBAE6zZ8VVCj89DrUjyVb3J
         L17w==
X-Gm-Message-State: APjAAAVH89ZqYZKg2fsw8gWARow2VdL/H8/IuqDvJ+NWtnepSLCAFTOM
        d9kBbTYxQoKgCCu56VvO/AU=
X-Google-Smtp-Source: APXvYqxJvw5/CUhjdAN8kmCIJe1AG6KRvRw2pvb/+xrKwKH1l+cWQxudUwXlSn+EWHzV35YjdU4xBA==
X-Received: by 2002:a7b:cd0a:: with SMTP id f10mr6730175wmj.56.1578596327589;
        Thu, 09 Jan 2020 10:58:47 -0800 (PST)
Received: from localhost (ip-37-188-146-105.eurotel.cz. [37.188.146.105])
        by smtp.gmail.com with ESMTPSA id q19sm3631897wmc.12.2020.01.09.10.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 10:58:46 -0800 (PST)
Date:   Thu, 9 Jan 2020 19:58:44 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        alexander.duyck@gmail.com, rientjes@google.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200109185844.GW4951@dhcp22.suse.cz>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109143054.13203-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 09-01-20 22:30:54, Wei Yang wrote:
> As all the other places, we grab the lock before manipulate the defer list.
> Current implementation may face a race condition.
> 
> For example, the potential race would be:
> 
>     CPU1                      CPU2
>     mem_cgroup_move_account   split_huge_page_to_list
>       !list_empty
>                                 lock
>                                 !list_empty
>                                 list_del
>                                 unlock
>       lock
>       # !list_empty might not hold anymore
>       list_del_init
>       unlock
> 
> When this sequence happens, the list_del_init() in
> mem_cgroup_move_account() would crash if CONFIG_DEBUG_LIST since the
> page is already been removed by list_del in split_huge_page_to_list().
> 
> Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Acked-by: David Rientjes <rientjes@google.com>

Thanks a lot for the changelog approvements!
Acked-by: Michal Hocko <mhocko@suse.com>

> 
> ---
> v2:
>   * move check on compound outside suggested by Alexander
>   * an example of the race condition, suggested by Michal
> ---
>  mm/memcontrol.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index bc01423277c5..1492eefe4f3c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5368,10 +5368,12 @@ static int mem_cgroup_move_account(struct page *page,
>  	}
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (compound && !list_empty(page_deferred_list(page))) {
> +	if (compound) {
>  		spin_lock(&from->deferred_split_queue.split_queue_lock);
> -		list_del_init(page_deferred_list(page));
> -		from->deferred_split_queue.split_queue_len--;
> +		if (!list_empty(page_deferred_list(page))) {
> +			list_del_init(page_deferred_list(page));
> +			from->deferred_split_queue.split_queue_len--;
> +		}
>  		spin_unlock(&from->deferred_split_queue.split_queue_lock);
>  	}
>  #endif
> @@ -5385,11 +5387,13 @@ static int mem_cgroup_move_account(struct page *page,
>  	page->mem_cgroup = to;
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (compound && list_empty(page_deferred_list(page))) {
> +	if (compound) {
>  		spin_lock(&to->deferred_split_queue.split_queue_lock);
> -		list_add_tail(page_deferred_list(page),
> -			      &to->deferred_split_queue.split_queue);
> -		to->deferred_split_queue.split_queue_len++;
> +		if (list_empty(page_deferred_list(page))) {
> +			list_add_tail(page_deferred_list(page),
> +				      &to->deferred_split_queue.split_queue);
> +			to->deferred_split_queue.split_queue_len++;
> +		}
>  		spin_unlock(&to->deferred_split_queue.split_queue_lock);
>  	}
>  #endif
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
