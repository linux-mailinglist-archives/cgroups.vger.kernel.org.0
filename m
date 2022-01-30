Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3E94A34B2
	for <lists+cgroups@lfdr.de>; Sun, 30 Jan 2022 07:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiA3GdY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Jan 2022 01:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiA3GdY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Jan 2022 01:33:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180EBC061714;
        Sat, 29 Jan 2022 22:33:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83668B8284C;
        Sun, 30 Jan 2022 06:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0977CC340E4;
        Sun, 30 Jan 2022 06:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643524400;
        bh=/cIdn3XGZbN01cqnIxUhf4QjDFd+RjN9h/GNFpqHBx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+JJuEWZcnyvKQ4HBFshhORdDO3wl1baZ/MEmOSMA2ycX0QORFHD9sG+pkfY6t74b
         qzHqRUOJ1ukf4x4FPzevBh4425WXcs28BiSkQ+1Gtn4D3Nv8iwWjDVgzuYW/pOHjji
         axNJGCW5sLHHwFEzGvJ2di99X8+7oUT3WqDpEmC8J7P7Spf2cYHhlIbUt27rV5D1vK
         O//w3AAxUvjQAoVZaSyOe+GwnJrXjaleSvBNwOWXJ43F/WV9Ei1rCimn5Q1RQlptI4
         m7vro243wjTnidHvtFmc1cK8C2biVDrVd7T5X1j4jt/jUZxZzN8/zRvlmeZCsAH4d+
         l84dEpLXmuhEA==
Date:   Sun, 30 Jan 2022 08:33:09 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 3/3] mm/page_owner: Dump memcg information
Message-ID: <YfYxJR7ugv83ywAb@kernel.org>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129205315.478628-4-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jan 29, 2022 at 03:53:15PM -0500, Waiman Long wrote:
> It was found that a number of offlined memcgs were not freed because
> they were pinned by some charged pages that were present. Even "echo
> 1 > /proc/sys/vm/drop_caches" wasn't able to free those pages. These
> offlined but not freed memcgs tend to increase in number over time with
> the side effect that percpu memory consumption as shown in /proc/meminfo
> also increases over time.
> 
> In order to find out more information about those pages that pin
> offlined memcgs, the page_owner feature is extended to dump memory
> cgroup information especially whether the cgroup is offlined or not.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/page_owner.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 28dac73e0542..8dc5cd0fa227 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -10,6 +10,7 @@
>  #include <linux/migrate.h>
>  #include <linux/stackdepot.h>
>  #include <linux/seq_file.h>
> +#include <linux/memcontrol.h>
>  #include <linux/sched/clock.h>
>  
>  #include "internal.h"
> @@ -331,6 +332,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  		depot_stack_handle_t handle)
>  {
>  	int ret, pageblock_mt, page_mt;
> +	unsigned long __maybe_unused memcg_data;
>  	char *kbuf;
>  
>  	count = min_t(size_t, count, PAGE_SIZE);
> @@ -365,6 +367,35 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  			migrate_reason_names[page_owner->last_migrate_reason]);
>  	}
>  
> +#ifdef CONFIG_MEMCG

Can we put all this along with the declaration of memcg_data in a helper
function please?

> +	/*
> +	 * Look for memcg information and print it out
> +	 */
> +	memcg_data = READ_ONCE(page->memcg_data);
> +	if (memcg_data) {
> +		struct mem_cgroup *memcg = page_memcg_check(page);
> +		bool onlined;
> +		char name[80];
> +
> +		if (memcg_data & MEMCG_DATA_OBJCGS)
> +			ret += scnprintf(kbuf + ret, count - ret,
> +					"Slab cache page\n");
> +
> +		if (!memcg)
> +			goto copy_out;
> +
> +		onlined = (memcg->css.flags & CSS_ONLINE);
> +		cgroup_name(memcg->css.cgroup, name, sizeof(name));
> +		ret += scnprintf(kbuf + ret, count - ret,
> +				"Charged %sto %smemcg %s\n",
> +				PageMemcgKmem(page) ? "(via objcg) " : "",
> +				onlined ? "" : "offlined ",
> +				name);
> +	}
> +
> +copy_out:
> +#endif
> +
>  	ret += snprintf(kbuf + ret, count - ret, "\n");
>  	if (ret >= count)
>  		goto err;
> -- 
> 2.27.0
> 
> 

-- 
Sincerely yours,
Mike.
