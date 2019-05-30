Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E682F765
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2019 08:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfE3GM1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 May 2019 02:12:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:44078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbfE3GM0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 30 May 2019 02:12:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF839B01C;
        Thu, 30 May 2019 06:12:24 +0000 (UTC)
Date:   Thu, 30 May 2019 08:12:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH REBASED] mm, memcg: Make scan aggression always exclude
 protection
Message-ID: <20190530061221.GA6703@dhcp22.suse.cz>
References: <20190228213050.GA28211@chrisdown.name>
 <20190322160307.GA3316@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322160307.GA3316@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[Sorry for a late reply]

On Fri 22-03-19 16:03:07, Chris Down wrote:
[...]
> With this patch, memory.low and memory.min affect reclaim pressure in a
> more understandable and composable way. For example, from a user
> standpoint, "protected" memory now remains untouchable from a reclaim
> aggression standpoint, and users can also have more confidence that
> bursty workloads will still receive some amount of guaranteed
> protection.

Maybe I am missing something so correct me if I am wrong but the new
calculation actually means that we always allow to scan even min
protected memcgs right?

Because ...

[...]

> +static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
> +						  bool in_low_reclaim)
>  {
> -	if (mem_cgroup_disabled()) {
> -		*min = 0;
> -		*low = 0;
> -		return;
> -	}
> +	if (mem_cgroup_disabled())
> +		return 0;
> +
> +	if (in_low_reclaim)
> +		return READ_ONCE(memcg->memory.emin);
>  
> -	*min = READ_ONCE(memcg->memory.emin);
> -	*low = READ_ONCE(memcg->memory.elow);
> +	return max(READ_ONCE(memcg->memory.emin),
> +		   READ_ONCE(memcg->memory.elow));
>  }
[...]
> +			unsigned long cgroup_size = mem_cgroup_size(memcg);
> +
> +			/* Avoid TOCTOU with earlier protection check */
> +			cgroup_size = max(cgroup_size, protection);
> +
> +			scan = lruvec_size - lruvec_size * protection /
> +				cgroup_size;
>  
[...]
> -			scan = clamp(scan, SWAP_CLUSTER_MAX, lruvec_size);
> +			scan = max(scan, SWAP_CLUSTER_MAX);

here the zero or sub SWAP_CLUSTER_MAX scan target gets extended to
SWAP_CLUSTER_MAX. Unless I am missing something this is not correct
because min protection should be a guarantee even in in_low_reclaim
mode.

>  		} else {
>  			scan = lruvec_size;
>  		}
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
