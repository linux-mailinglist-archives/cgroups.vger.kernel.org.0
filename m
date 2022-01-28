Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851D14A029F
	for <lists+cgroups@lfdr.de>; Fri, 28 Jan 2022 22:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbiA1VWv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jan 2022 16:22:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:59772 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348812AbiA1VWu (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 28 Jan 2022 16:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643404970; x=1674940970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dpOFTowJuy7FP6yz3n7YQmC/tWQqCIDscNtq/3bOefk=;
  b=Bfl2KbVKfvpmF9Nah26C4jmsOcZR51bTiKc3YvPlXDKoR1zosqIPnbic
   PPWIOD86kTB+rOxClvbXwvD28PHaBgyyStHvGBce+8mifSLL9j7QprELE
   H4TzKSzr1u2c9MOpc6ZQx4Mo4ujmSdZPgJwqZpIPKMyq/yCmvt50oS+6V
   xNipuukDipiaku/kFxjk7MFNk71f17/lim+JeiMy9vo1KA+N+QcRnyLKU
   F2S38eZc0XKervmP/6uNBOYOCFO8sQZrkFnvJ3qSOVzBFKtw+bmIi9K81
   J5P2o2JHpggcjyA8Ri0HSTjiZlbgpi/HOmUvVMiWPsODOBO4Zu2J4FibN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="247421020"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="247421020"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 13:22:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="521857653"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 13:22:49 -0800
Date:   Fri, 28 Jan 2022 13:22:49 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH 2/2] mm/page_owner: Dump memcg information
Message-ID: <20220128212249.GI785175@iweiny-DESK2.sc.intel.com>
References: <20220128195642.416743-1-longman@redhat.com>
 <20220128195642.416743-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128195642.416743-3-longman@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 28, 2022 at 02:56:42PM -0500, Waiman Long wrote:
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
>  mm/page_owner.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index c52ce9d6bc3b..e5d8c642296b 100644
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
> @@ -339,6 +340,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  		depot_stack_handle_t handle)
>  {
>  	int ret = 0, pageblock_mt, page_mt;
> +	unsigned long __maybe_unused memcg_data;
>  	char *kbuf;
>  
>  	count = min_t(size_t, count, PAGE_SIZE);
> @@ -371,6 +373,32 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  			"Page has been migrated, last migrate reason: %s\n",
>  			migrate_reason_names[page_owner->last_migrate_reason]);
>  
> +#ifdef CONFIG_MEMCG
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
> +			SNPRINTF(kbuf, count, ret, err, "Slab cache page\n");
> +
> +		if (!memcg)
> +			goto copy_out;
> +
> +		onlined = (memcg->css.flags & CSS_ONLINE);
> +		cgroup_name(memcg->css.cgroup, name, sizeof(name) - 1);
> +		SNPRINTF(kbuf, count, ret, err, "Charged %sto %smemcg %s\n",
                                                        ^^^
						Extra specifier?

Did this compile without warnings?

Ira

> +			PageMemcgKmem(page) ? "(via objcg) " : "",
> +			onlined ? "" : "offlined ", name);
> +	}
> +
> +copy_out:
> +#endif
> +
>  	SNPRINTF(kbuf, count, ret, err, "\n");
>  
>  	if (copy_to_user(buf, kbuf, ret))
> -- 
> 2.27.0
> 
> 
