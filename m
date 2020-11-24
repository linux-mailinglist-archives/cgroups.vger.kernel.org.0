Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016A82C2416
	for <lists+cgroups@lfdr.de>; Tue, 24 Nov 2020 12:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbgKXL0P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Nov 2020 06:26:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:33214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732658AbgKXL0O (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 24 Nov 2020 06:26:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606217173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jXr6QneDp2gyWm4z+0ntuKNCFM6noV3BZjgwhMClHvw=;
        b=NdgHMtdY+WJQriDVpq2qkEw/p6UkfzkpoFswP4Q062cvu8TyFR660jrLhYqSA9GXE2xENf
        eTiTyuE69WbuGPEe6/F60X1SIO4/DVdj0tmK1gZxZlfmi/DV8artIw2P82QJZl9TS6+VL4
        9zobRzvA0rtgeB/1ZvaHyVttmRkgnf0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14A43AD21;
        Tue, 24 Nov 2020 11:26:13 +0000 (UTC)
Date:   Tue, 24 Nov 2020 12:26:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] memcg: add support to generate the total count of
 children from root
Message-ID: <20201124112612.GV27488@dhcp22.suse.cz>
References: <20201124105836.713371-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124105836.713371-1-atomlin@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 24-11-20 10:58:36, Aaron Tomlin wrote:
> Each memory-controlled cgroup is assigned a unique ID and the total
> number of memory cgroups is limited to MEM_CGROUP_ID_MAX.
> 
> This patch provides the ability to determine the number of
> memory cgroups from the root memory cgroup, only.
> A value of 1 (i.e. self count) is returned if there are no children.
> For example, the number of memory cgroups can be established by
> reading the /sys/fs/cgroup/memory/memory.total_cnt file.

Could you add some explanation why is this information useful for
userspace? Who is going to use it and why a simple scripting on top of
cgroupfs is insufficient.

> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  mm/memcontrol.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 29459a6ce1c7..a4f7cb40e233 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4535,6 +4535,19 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
>  	return 0;
>  }
>  
> +static int mem_cgroup_total_count_read(struct cgroup_subsys_state *css,
> +				      struct cftype *cft)
> +{
> +	struct mem_cgroup *iter, *memcg = mem_cgroup_from_css(css);
> +	int num = 0;
> +
> +	for_each_mem_cgroup_tree(iter, memcg)
> +		num++;
> +
> +	/* Returns 1 (i.e. self count) if no children. */
> +	return num;
> +}
> +
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  
>  #include <trace/events/writeback.h>
> @@ -5050,6 +5063,11 @@ static struct cftype mem_cgroup_legacy_files[] = {
>  		.write_u64 = mem_cgroup_oom_control_write,
>  		.private = MEMFILE_PRIVATE(_OOM_TYPE, OOM_CONTROL),
>  	},
> +	{
> +		.name = "total_cnt",
> +		.flags = CFTYPE_ONLY_ON_ROOT,
> +		.read_u64 = mem_cgroup_total_count_read,
> +	},
>  	{
>  		.name = "pressure_level",
>  	},
> -- 
> 2.26.2
> 

-- 
Michal Hocko
SUSE Labs
