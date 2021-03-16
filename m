Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE0533D0D9
	for <lists+cgroups@lfdr.de>; Tue, 16 Mar 2021 10:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhCPJa6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Mar 2021 05:30:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:34922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233767AbhCPJa5 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 16 Mar 2021 05:30:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615887056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lBGk+Iyq4CVjb4mLe0kBH+gokhgg7ZND2EOk7K2C61E=;
        b=JlKA6J2mMwOl6dNyPKwczKNqW5ujsCX/JNcnjD9w/a3KbTDxWdeRveY6v+nSQvzPy7cTga
        3jKZunIC3Fc8DEWQ6ZbMVPbPVTw1NjyL651SN0ROIRokZhD4hOlgVvuTLtujB+qwZOCFh+
        dXNnU/vEJ9SzwTymxFR0IdP57NeyXro=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 174C7AC5C;
        Tue, 16 Mar 2021 09:30:56 +0000 (UTC)
Date:   Tue, 16 Mar 2021 10:30:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: switch to rstat fix
Message-ID: <YFB6zkqXx+Z+pO+q@dhcp22.suse.cz>
References: <20210315234100.64307-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315234100.64307-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 15-03-21 19:41:00, Johannes Weiner wrote:
> Fix a sleep in atomic section problem: wb_writeback() takes a spinlock
> and calls wb_over_bg_thresh() -> mem_cgroup_wb_stats, but the regular
> rstat flushing function called from in there does lockbreaking and may
> sleep. Switch to the atomic variant, cgroup_rstat_irqsafe().
> 
> To be consistent with other memcg flush calls, but without adding
> another memcg wrapper, inline and drop memcg_flush_vmstats() instead.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f7fb12d3c2fc..9091913ec877 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -757,11 +757,6 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>  	return mz;
>  }
>  
> -static void memcg_flush_vmstats(struct mem_cgroup *memcg)
> -{
> -	cgroup_rstat_flush(memcg->css.cgroup);
> -}
> -
>  /**
>   * __mod_memcg_state - update cgroup memory statistics
>   * @memcg: the memory cgroup
> @@ -1572,7 +1567,7 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  	 *
>  	 * Current memory state:
>  	 */
> -	memcg_flush_vmstats(memcg);
> +	cgroup_rstat_flush(memcg->css.cgroup);
>  
>  	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
>  		u64 size;
> @@ -3523,7 +3518,7 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
>  	unsigned long val;
>  
>  	if (mem_cgroup_is_root(memcg)) {
> -		memcg_flush_vmstats(memcg);
> +		cgroup_rstat_flush(memcg->css.cgroup);
>  		val = memcg_page_state(memcg, NR_FILE_PAGES) +
>  			memcg_page_state(memcg, NR_ANON_MAPPED);
>  		if (swap)
> @@ -3925,7 +3920,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
>  	int nid;
>  	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
>  
> -	memcg_flush_vmstats(memcg);
> +	cgroup_rstat_flush(memcg->css.cgroup);
>  
>  	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
>  		seq_printf(m, "%s=%lu", stat->name,
> @@ -3997,7 +3992,7 @@ static int memcg_stat_show(struct seq_file *m, void *v)
>  
>  	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
>  
> -	memcg_flush_vmstats(memcg);
> +	cgroup_rstat_flush(memcg->css.cgroup);
>  
>  	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
>  		unsigned long nr;
> @@ -4500,7 +4495,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
>  	struct mem_cgroup *parent;
>  
> -	memcg_flush_vmstats(memcg);
> +	cgroup_rstat_flush_irqsafe(memcg->css.cgroup);
>  
>  	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
>  	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
> -- 
> 2.30.1

-- 
Michal Hocko
SUSE Labs
