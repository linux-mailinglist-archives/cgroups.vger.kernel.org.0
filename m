Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB054A6013
	for <lists+cgroups@lfdr.de>; Tue,  1 Feb 2022 16:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbiBAP2Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Feb 2022 10:28:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59316 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiBAP2P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Feb 2022 10:28:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F077121122;
        Tue,  1 Feb 2022 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643729294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RQRLOb3bXZrYGcNHUZwT7I3GzHLLZBfOqR/e/Ky19U0=;
        b=tDzwQ3OjYZK3aArHn/DGQi+rmnL8fLeYFwWwbSDdHLFkDbcOwnJFUTVS+NZ85Rjjyif4OL
        4cG7+qsLAUyiem/flUf/ml1EdAtz9FkrFl0P6eTUIHlJb2YyJPcY9gp7M2WpRHeZgJDSrH
        gXiAvAE+gYsHBZSWmYOWm7RRKNspuHM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9D789A3B95;
        Tue,  1 Feb 2022 15:28:13 +0000 (UTC)
Date:   Tue, 1 Feb 2022 16:28:13 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>,
        Rafael Aquini <aquini@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 4/4] mm/page_owner: Record task command name
Message-ID: <YflRjeoC0jbzArDG@dhcp22.suse.cz>
References: <20220131192308.608837-5-longman@redhat.com>
 <20220131220328.622162-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131220328.622162-1-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Cc Vlastimil

On Mon 31-01-22 17:03:28, Waiman Long wrote:
> The page_owner information currently includes the pid of the calling
> task. That is useful as long as the task is still running. Otherwise,
> the number is meaningless. To have more information about the allocating
> tasks that had exited by the time the page_owner information is
> retrieved, we need to store the command name of the task.
> 
> Add a new comm field into page_owner structure to store the command name
> and display it when the page_owner information is retrieved.

I completely agree that pid is effectivelly useless (if not misleading)
but is comm really telling all that much to compensate for the
additional storage required for _each_ page in the system?

> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/page_owner.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index a471c74c7fe0..485542155483 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -29,6 +29,7 @@ struct page_owner {
>  	depot_stack_handle_t free_handle;
>  	u64 ts_nsec;
>  	u64 free_ts_nsec;
> +	char comm[TASK_COMM_LEN];
>  	pid_t pid;
>  };
>  
> @@ -146,6 +147,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
>  		page_owner = get_page_owner(page_ext);
>  		page_owner->free_handle = handle;
>  		page_owner->free_ts_nsec = free_ts_nsec;
> +		page_owner->comm[0] = '\0';
>  		page_ext = page_ext_next(page_ext);
>  	}
>  }
> @@ -165,6 +167,8 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
>  		page_owner->last_migrate_reason = -1;
>  		page_owner->pid = current->pid;
>  		page_owner->ts_nsec = local_clock();
> +		strlcpy(page_owner->comm, current->comm,
> +			sizeof(page_owner->comm));
>  		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
>  		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
>  
> @@ -232,6 +236,7 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
>  	new_page_owner->pid = old_page_owner->pid;
>  	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
>  	new_page_owner->free_ts_nsec = old_page_owner->ts_nsec;
> +	strcpy(new_page_owner->comm, old_page_owner->comm);
>  
>  	/*
>  	 * We don't clear the bit on the old folio as it's going to be freed
> @@ -376,10 +381,11 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  		return -ENOMEM;
>  
>  	ret = scnprintf(kbuf, count,
> -			"Page allocated via order %u, mask %#x(%pGg), pid %d, ts %llu ns, free_ts %llu ns\n",
> +			"Page allocated via order %u, mask %#x(%pGg), pid %d (%s), ts %llu ns, free_ts %llu ns\n",
>  			page_owner->order, page_owner->gfp_mask,
>  			&page_owner->gfp_mask, page_owner->pid,
> -			page_owner->ts_nsec, page_owner->free_ts_nsec);
> +			page_owner->comm, page_owner->ts_nsec,
> +			page_owner->free_ts_nsec);
>  
>  	/* Print information relevant to grouping pages by mobility */
>  	pageblock_mt = get_pageblock_migratetype(page);
> @@ -446,9 +452,10 @@ void __dump_page_owner(const struct page *page)
>  	else
>  		pr_alert("page_owner tracks the page as freed\n");
>  
> -	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg), pid %d, ts %llu, free_ts %llu\n",
> +	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg), pid %d (%s), ts %llu, free_ts %llu\n",
>  		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask,
> -		 page_owner->pid, page_owner->ts_nsec, page_owner->free_ts_nsec);
> +		 page_owner->pid, page_owner->comm, page_owner->ts_nsec,
> +		 page_owner->free_ts_nsec);
>  
>  	handle = READ_ONCE(page_owner->handle);
>  	if (!handle)
> -- 
> 2.27.0

-- 
Michal Hocko
SUSE Labs
