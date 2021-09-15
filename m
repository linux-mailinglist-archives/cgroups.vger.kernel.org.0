Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCF340C466
	for <lists+cgroups@lfdr.de>; Wed, 15 Sep 2021 13:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhIOLbv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Sep 2021 07:31:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41842 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbhIOLbu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Sep 2021 07:31:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 005722207D;
        Wed, 15 Sep 2021 11:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631705431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UOkCjvFoaNxGNbGFWeeVQVHJtZCjHhgLPxx+uerfl10=;
        b=HNke4/c6CnQ8nnlErjOvekgpXVSQXjWl4Ol2+/tLgrRlknDlrVnGAlJb48fXnI99PKyxch
        OYd1ItE4KjwfkP1Zku3mE76kBPFNJ8txDsFMjiMkJFJOsTZYn4j5Fetseg8i3S8mO1/f1k
        /jZcCmJ85qh1RlBqZrqrlIGfiLDUXFU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7DE1EA3BA3;
        Wed, 15 Sep 2021 11:30:30 +0000 (UTC)
Date:   Wed, 15 Sep 2021 13:30:27 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_alloc: detect allocation forbidden by cpuset
 and bail out early
Message-ID: <YUHZU4OHaJy3WtRk@dhcp22.suse.cz>
References: <1631590828-25565-1-git-send-email-feng.tang@intel.com>
 <3bd87d8a-d09e-ac7-1d1d-25ad1b9d5ed9@google.com>
 <20210915053247.GG56674@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915053247.GG56674@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 15-09-21 13:32:47, Feng Tang wrote:
> On Tue, Sep 14, 2021 at 05:30:03PM -0700, David Rientjes wrote:
[...]
> > I'm wondering about a single node nodemask, for example, where all 
> > ZONE_NORMAL memory is hot-removed.

While this is theoretically possible it is highly unlikely to happen.
Non movable memory just takes one kernel allocation to prevent any
hotremove operation to finish. I have to say I was not aware of the
hotplug callback. It all seems rather suspicious. I will have a look.

Anyway something worth having covered "just in case". Thanks for
pointing it out.
 
> Thanks for the reminding! Yes, memory hot remove can change the
> cpuset's effective nodemask, we may need to add similar check inside
> cpuset_hotplug_update_tasks() which is called by cpuset_hotplug_workfn(), 
> something like below?
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 7fa633e..d5f6776 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3186,6 +3186,14 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>  	cpus_updated = !cpumask_equal(&new_cpus, cs->effective_cpus);
>  	mems_updated = !nodes_equal(new_mems, cs->effective_mems);
>  
> +	if (mems_updated && !cpusets_insane_config() &&
> +		movable_only_nodes(new_mems)) {
> +		static_branch_enable(&cpusets_insane_config_key);
> +		pr_info("Unsupported (movable nodes only) cpuset configuration detected (nmask=%*pbl) after memory hotplug."
> +			"Cpuset allocations might fail even with a lot of memory available.\n",
> +			nodemask_pr_args(new_mems);
> +	}

Please create a helper rather than two copies of the same. Thanks!
> +
>  	if (is_in_v2_mode())
>  		hotplug_update_tasks(cs, &new_cpus, &new_mems,
>  				     cpus_updated, mems_updated);
> 
> Thanks,
> Feng

-- 
Michal Hocko
SUSE Labs
