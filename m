Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26698186DE7
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2020 15:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbgCPO4g (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Mar 2020 10:56:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55720 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731539AbgCPO4g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Mar 2020 10:56:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id 6so18010891wmi.5;
        Mon, 16 Mar 2020 07:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VrtE/xlfUCPSQK0yP3Q30OMAAICBZ67o1F4lAQpydlc=;
        b=eLPvMiRXCRNnK1WYt2DxTDt73T3O1Qp4jIGlaMzCWQ12B20QhdXUJIkJvMD43KBkNV
         P0CGpi5/YbdfzmnPmLN/g8s2NVd2Hj08ua7RE0ovHu9aR/ozAk/mOnwHxWppeQR77NQ3
         iVv29CyH7+3NzpEymrb8xkHRngrgohsWnXOJg39CYFp0MIFdj9lkgmGTDHm5LdTwCQGi
         KAs6O86h3MlNk5XvqqLZVvR9Ggs/kyZo/27aOqvdK+tTdAyhTOfkbPAov+PibwyeUjRR
         fLL4rnJBm1SILbG1oEPau+ZAJt86ihwzytrTJBxb/w0OVjGoORmeBDYdFL2uBhkWog3F
         oBIg==
X-Gm-Message-State: ANhLgQ1PS+2DRM5bXG/qegFqWRQ5Jwbl3fKteNSH8vtCPXU+OazcR3Ro
        jlyi2gPZmXWBj4JDOBiTCCU=
X-Google-Smtp-Source: ADFU+vtr5jjf77Iajr1j4frzBct5FB3RoAb5tS2YuayVeZDjargzQYU0nueHCGk3jW3u2FntvbOAvA==
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr29205085wmf.50.1584370594403;
        Mon, 16 Mar 2020 07:56:34 -0700 (PDT)
Received: from localhost ([37.188.132.163])
        by smtp.gmail.com with ESMTPSA id b202sm5587869wmd.15.2020.03.16.07.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:56:33 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:56:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/6] mm, memcg: Prevent memory.max load tearing
Message-ID: <20200316145630.GN11482@dhcp22.suse.cz>
References: <cover.1584034301.git.chris@chrisdown.name>
 <50a31e5f39f8ae6c8fb73966ba1455f0924e8f44.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50a31e5f39f8ae6c8fb73966ba1455f0924e8f44.1584034301.git.chris@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 12-03-20 17:32:56, Chris Down wrote:
> This one is a bit more nuanced because we have memcg_max_mutex, which is
> mostly just used for enforcing invariants, but we still need to
> READ_ONCE since (despite its name) it doesn't really protect memory.max
> access.
> 
> On write (page_counter_set_max() and memory_max_write()) we use xchg(),
> which uses smp_mb(), so that's already fine.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@fb.com

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d32d3c0a16d4..aca2964ea494 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1507,7 +1507,7 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>  
>  	pr_info("memory: usage %llukB, limit %llukB, failcnt %lu\n",
>  		K((u64)page_counter_read(&memcg->memory)),
> -		K((u64)memcg->memory.max), memcg->memory.failcnt);
> +		K((u64)READ_ONCE(memcg->memory.max)), memcg->memory.failcnt);
>  	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		pr_info("swap: usage %llukB, limit %llukB, failcnt %lu\n",
>  			K((u64)page_counter_read(&memcg->swap)),
> @@ -1538,7 +1538,7 @@ unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
>  {
>  	unsigned long max;
>  
> -	max = memcg->memory.max;
> +	max = READ_ONCE(memcg->memory.max);
>  	if (mem_cgroup_swappiness(memcg)) {
>  		unsigned long memsw_max;
>  		unsigned long swap_max;
> @@ -3006,7 +3006,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
>  		 * Make sure that the new limit (memsw or memory limit) doesn't
>  		 * break our basic invariant rule memory.max <= memsw.max.
>  		 */
> -		limits_invariant = memsw ? max >= memcg->memory.max :
> +		limits_invariant = memsw ? max >= READ_ONCE(memcg->memory.max) :
>  					   max <= memcg->memsw.max;
>  		if (!limits_invariant) {
>  			mutex_unlock(&memcg_max_mutex);
> @@ -3753,8 +3753,8 @@ static int memcg_stat_show(struct seq_file *m, void *v)
>  	/* Hierarchical information */
>  	memory = memsw = PAGE_COUNTER_MAX;
>  	for (mi = memcg; mi; mi = parent_mem_cgroup(mi)) {
> -		memory = min(memory, mi->memory.max);
> -		memsw = min(memsw, mi->memsw.max);
> +		memory = min(memory, READ_ONCE(mi->memory.max));
> +		memsw = min(memsw, READ_ONCE(mi->memsw.max));
>  	}
>  	seq_printf(m, "hierarchical_memory_limit %llu\n",
>  		   (u64)memory * PAGE_SIZE);
> @@ -4257,7 +4257,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
>  	*pheadroom = PAGE_COUNTER_MAX;
>  
>  	while ((parent = parent_mem_cgroup(memcg))) {
> -		unsigned long ceiling = min(memcg->memory.max,
> +		unsigned long ceiling = min(READ_ONCE(memcg->memory.max),
>  					    READ_ONCE(memcg->high));
>  		unsigned long used = page_counter_read(&memcg->memory);
>  
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
