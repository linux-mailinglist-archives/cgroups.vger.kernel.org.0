Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCD84A7F7F
	for <lists+cgroups@lfdr.de>; Thu,  3 Feb 2022 07:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244639AbiBCGxX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Feb 2022 01:53:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48494 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241737AbiBCGxW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Feb 2022 01:53:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3050461799;
        Thu,  3 Feb 2022 06:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAEEAC340E4;
        Thu,  3 Feb 2022 06:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643871201;
        bh=9nbtztfsgUhdr6aIZKYDMaKCReVO1EVdAswxzSjNC7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L6HEisU3wiHHxL8R9caiTeqrkK56FJXhwb2DFel+9K7/RdNm4Abym6AZjPQJ+NRIG
         RUmDLCvDW+mWgyKh8KuFV1evSRBK58szRcB/zqQzJv+AxciTxWg8rz133mfo6wSxUi
         9c2ELDV7ixzAhlyQEz7+VvbHhyH1QoadIgBpJBu5nUpDAha3FFEuOXoqJlgQp2p6Hv
         gPkrqy9u/H3pGZmDePLjGeGyXE5NXCe7adhLerCiQsWgbnb4LELuRs/bSzlztvlAds
         Q7suEazu8PcoROGWUdjBttRsFysrf0TPvRT9JysqR1aAii9GBOGpVSCrzoq3fW9HVA
         YbQYF9iNsK73g==
Date:   Thu, 3 Feb 2022 08:53:10 +0200
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
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>, Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v4 3/4] mm/page_owner: Print memcg information
Message-ID: <Yft71q+OO7lg90sl@kernel.org>
References: <20220131192308.608837-5-longman@redhat.com>
 <20220202203036.744010-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202203036.744010-4-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 02, 2022 at 03:30:35PM -0500, Waiman Long wrote:
> It was found that a number of offline memcgs were not freed because
> they were pinned by some charged pages that were present. Even "echo 1 >
> /proc/sys/vm/drop_caches" wasn't able to free those pages. These offline
> but not freed memcgs tend to increase in number over time with the side
> effect that percpu memory consumption as shown in /proc/meminfo also
> increases over time.
> 
> In order to find out more information about those pages that pin
> offline memcgs, the page_owner feature is extended to print memory
> cgroup information especially whether the cgroup is offline or not.
> RCU read lock is taken when memcg is being accessed to make sure
> that it won't be freed.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

And my akcs for the first two patches are missing somehow in v4...

> ---
>  mm/page_owner.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 28dac73e0542..f7820357e4d4 100644
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
> @@ -325,6 +326,45 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>  	seq_putc(m, '\n');
>  }
>  
> +/*
> + * Looking for memcg information and print it out
> + */
> +static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
> +					 struct page *page)
> +{
> +#ifdef CONFIG_MEMCG
> +	unsigned long memcg_data;
> +	struct mem_cgroup *memcg;
> +	bool online;
> +	char name[80];
> +
> +	rcu_read_lock();
> +	memcg_data = READ_ONCE(page->memcg_data);
> +	if (!memcg_data)
> +		goto out_unlock;
> +
> +	if (memcg_data & MEMCG_DATA_OBJCGS)
> +		ret += scnprintf(kbuf + ret, count - ret,
> +				"Slab cache page\n");
> +
> +	memcg = page_memcg_check(page);
> +	if (!memcg)
> +		goto out_unlock;
> +
> +	online = (memcg->css.flags & CSS_ONLINE);
> +	cgroup_name(memcg->css.cgroup, name, sizeof(name));
> +	ret += scnprintf(kbuf + ret, count - ret,
> +			"Charged %sto %smemcg %s\n",
> +			PageMemcgKmem(page) ? "(via objcg) " : "",
> +			online ? "" : "offline ",
> +			name);
> +out_unlock:
> +	rcu_read_unlock();
> +#endif /* CONFIG_MEMCG */
> +
> +	return ret;
> +}
> +
>  static ssize_t
>  print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  		struct page *page, struct page_owner *page_owner,
> @@ -365,6 +405,8 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  			migrate_reason_names[page_owner->last_migrate_reason]);
>  	}
>  
> +	ret = print_page_owner_memcg(kbuf, count, ret, page);
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
