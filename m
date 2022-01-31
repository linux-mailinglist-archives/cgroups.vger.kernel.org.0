Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAF24A3F60
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 10:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbiAaJiy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 04:38:54 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36172 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbiAaJix (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 04:38:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 82D841F381;
        Mon, 31 Jan 2022 09:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643621932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gFfYneuXxxyIxBAM26QGb5mPJgkTqy82COvXmXoG2U4=;
        b=GMBKwIRjiio5uHYtjsHX5SKOBDrnxWSy8DukbeDOPJQleviNEbItB3o3m1N/LZjjEGZVAr
        rZJm32G3ziPltbFmd7NNMW1esOGj+61VxPiAimMbWMU0g9EkStqQpAYsPEgLmzCHMaECD1
        h7SFZ8qG3T157yf1RvTbA0Qh25FCw8M=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 802F1A3B84;
        Mon, 31 Jan 2022 09:38:51 +0000 (UTC)
Date:   Mon, 31 Jan 2022 10:38:51 +0100
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
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 3/3] mm/page_owner: Dump memcg information
Message-ID: <YfeuK5j7cbgM+Oo+@dhcp22.suse.cz>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129205315.478628-4-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 29-01-22 15:53:15, Waiman Long wrote:
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

It is not really clear to me how this is supposed to be used. Are you
really dumping all the pages in the system to find out offline memcgs?
That looks rather clumsy to me. I am not against adding memcg
information to the page owner output. That can be useful in other
contexts.

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

This really begs to be in a dedicated function. page_owner_print_memcg
or something like that.

> +	/*
> +	 * Look for memcg information and print it out
> +	 */
> +	memcg_data = READ_ONCE(page->memcg_data);
> +	if (memcg_data) {
> +		struct mem_cgroup *memcg = page_memcg_check(page);
> +		bool onlined;
> +		char name[80];

What does prevent memcg to go away and being reused for a different
purpose?

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
-- 
Michal Hocko
SUSE Labs
