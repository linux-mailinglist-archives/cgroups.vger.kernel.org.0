Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64144A5089
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 21:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379149AbiAaUvn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 15:51:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44608 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355850AbiAaUvi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 15:51:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5788614EA;
        Mon, 31 Jan 2022 20:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B64C340E8;
        Mon, 31 Jan 2022 20:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643662297;
        bh=tX6vpO5C4zkX8VHS8hum/62LQzSNztcbGvWYKWQl7YE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ATkv6m2+GD3ZcijSZcw0eXCmRFRyUcncCfGLiwwxFRMBGVP/hL2/OESM2+Bm3BHSI
         jlJH35lFKnZYbczbzb/FHB3rFk1nPEj2ShQz7aM96eLsi1UbGVbFwn1Ms4sP35M9kc
         M8An6au1QzZfQdF3xzKgDywd0cp1yPLla9MoGki7NOLZipmkcWXTpbRuHa61iuI3oQ
         K9uBC9RYQ/nKdzj9xBLog3e02+1k7q0Ifg3TzvbMAIdZwk2Gr05ydV6fkPzsie9pdF
         TycV2WnZsNinTpOhpHvELyAGCTfj5jR1CA6bwyZCxWBzwLdeK4/55DZ0N+WwR9Kff8
         smsdfdS1XajQQ==
Date:   Mon, 31 Jan 2022 22:51:24 +0200
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
Subject: Re: [PATCH v3 3/4] mm/page_owner: Print memcg information
Message-ID: <YfhLzI+RLRGgexmr@kernel.org>
References: <20220131192308.608837-1-longman@redhat.com>
 <20220131192308.608837-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131192308.608837-4-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 31, 2022 at 02:23:07PM -0500, Waiman Long wrote:
> It was found that a number of offlined memcgs were not freed because
> they were pinned by some charged pages that were present. Even "echo
> 1 > /proc/sys/vm/drop_caches" wasn't able to free those pages. These
> offlined but not freed memcgs tend to increase in number over time with
> the side effect that percpu memory consumption as shown in /proc/meminfo
> also increases over time.
> 
> In order to find out more information about those pages that pin
> offlined memcgs, the page_owner feature is extended to print memory
> cgroup information especially whether the cgroup is offlined or not.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: David Rientjes <rientjes@google.com>
> ---
>  mm/page_owner.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 28dac73e0542..a471c74c7fe0 100644
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
> @@ -325,6 +326,42 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>  	seq_putc(m, '\n');
>  }
>  
> +#ifdef CONFIG_MEMCG
> +/*
> + * Looking for memcg information and print it out
> + */
> +static inline void print_page_owner_memcg(char *kbuf, size_t count, int *pret,
> +					  struct page *page)
> +{
> +	unsigned long memcg_data = READ_ONCE(page->memcg_data);
> +	struct mem_cgroup *memcg;
> +	bool onlined;
> +	char name[80];
> +
> +	if (!memcg_data)
> +		return;
> +
> +	if (memcg_data & MEMCG_DATA_OBJCGS)
> +		*pret += scnprintf(kbuf + *pret, count - *pret,
> +				"Slab cache page\n");

Don't we need to check for overflow here?

> +
> +	memcg = page_memcg_check(page);
> +	if (!memcg)
> +		return;
> +
> +	onlined = (memcg->css.flags & CSS_ONLINE);
> +	cgroup_name(memcg->css.cgroup, name, sizeof(name));
> +	*pret += scnprintf(kbuf + *pret, count - *pret,
> +			"Charged %sto %smemcg %s\n",
> +			PageMemcgKmem(page) ? "(via objcg) " : "",
> +			onlined ? "" : "offlined ",
> +			name);

Ditto

> +}
> +#else /* CONFIG_MEMCG */
> +static inline void print_page_owner_memcg(char *kbuf, size_t count, int *pret,
> +					  struct page *page) { }

I think #ifdef inside the print_page_owner_memcg() functions will be
simpler and clearer.

> +#endif /* CONFIG_MEMCG */
> +
>  static ssize_t
>  print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  		struct page *page, struct page_owner *page_owner,
> @@ -365,6 +402,8 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  			migrate_reason_names[page_owner->last_migrate_reason]);
>  	}
>  
> +	print_page_owner_memcg(kbuf, count, &ret, page);
> +

ret can go over count here.
Why not make print_page_owner_memcg() an int so that the call will be
consistent with other calls in print_page_owner():

	ret += print_page_owner_memcg(kbuf, count, page);
	if (ret >= count)
		goto err;

>  	ret += snprintf(kbuf + ret, count - ret, "\n");
>  	if (ret >= count)
>  		goto err;
> -- 
> 2.27.0
> 

-- 
Sincerely yours,
Mike.
