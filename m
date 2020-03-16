Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A9E186DE1
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2020 15:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbgCPOyX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Mar 2020 10:54:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45507 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731566AbgCPOyX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Mar 2020 10:54:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id t2so11552487wrx.12;
        Mon, 16 Mar 2020 07:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/2V8TQXmTbu4k1la5PWpjE8lHIj1Vj9s/Np+8xl7UF4=;
        b=QJiqsEhFflhvczsU53Va+zwCkp27faC2Cf9KtIGZci3R5Yi/6zbcV11kxDAA8ULsT9
         UOXAG+cILu6DGAuLVK2JmFkIi4AEZJ+5TPjuegvPmwerR+ze7spBEU9UdsHbcJtny88/
         4yZU9UWm1j1+5bfYef4Sdaz+Pp8GKaZS9wnQoWcwZpIZuNcEDqiDEgL5/r+ytyZowR59
         QnRPcyNHJCtyA9YysKdmdrNXP7z0WCDGrhemV2f/b3Z+L4Zd02kF8uY7eZjJQJ2aJsWu
         KtTqi/rRNiTiHYWsVcdSd3Oo9J8E2nB/64KwL6G4H84f/QWprM3kQcE0ZmswLVSe0cZG
         5K7g==
X-Gm-Message-State: ANhLgQ22jQs49QheZNaoNoBz8hMuInyG00yxKVyD9DO34lGrrLmeccl0
        /jubtfmjOhu/fm2OoCui1Lk=
X-Google-Smtp-Source: ADFU+vtODJApMfC6Yi/mTwQNn0Ud1XnGoYxLez+QcBseednYGX1TM8nnlpyX9JwgtL3XxxRE+6RtmA==
X-Received: by 2002:adf:fcce:: with SMTP id f14mr24285905wrs.200.1584370459969;
        Mon, 16 Mar 2020 07:54:19 -0700 (PDT)
Received: from localhost ([37.188.132.163])
        by smtp.gmail.com with ESMTPSA id q11sm227926wrp.53.2020.03.16.07.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:54:19 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:54:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/6] mm, memcg: Prevent memory.high load/store tearing
Message-ID: <20200316145416.GM11482@dhcp22.suse.cz>
References: <cover.1584034301.git.chris@chrisdown.name>
 <2f66f7038ed1d4688e59de72b627ae0ea52efa83.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f66f7038ed1d4688e59de72b627ae0ea52efa83.1584034301.git.chris@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 12-03-20 17:32:51, Chris Down wrote:
> A mem_cgroup's high attribute can be concurrently set at the same time
> as we are trying to read it -- for example, if we are in
> memory_high_write at the same time as we are trying to do high reclaim.

I assume this is a replace all kinda patch because css_alloc shouldn't
really be a subject to races. I am not sure about css_reset but it
sounds like a safe as well.

That being said I do not object because this cannot be harmful but it
would be nice to mention that in the changelog just in case somebody
wonders about this in future.
 
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
>  mm/memcontrol.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 63bb6a2aab81..d32d3c0a16d4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2228,7 +2228,7 @@ static void reclaim_high(struct mem_cgroup *memcg,
>  			 gfp_t gfp_mask)
>  {
>  	do {
> -		if (page_counter_read(&memcg->memory) <= memcg->high)
> +		if (page_counter_read(&memcg->memory) <= READ_ONCE(memcg->high))
>  			continue;
>  		memcg_memory_event(memcg, MEMCG_HIGH);
>  		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
> @@ -2545,7 +2545,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 * reclaim, the cost of mismatch is negligible.
>  	 */
>  	do {
> -		if (page_counter_read(&memcg->memory) > memcg->high) {
> +		if (page_counter_read(&memcg->memory) > READ_ONCE(memcg->high)) {
>  			/* Don't bother a random interrupted task */
>  			if (in_interrupt()) {
>  				schedule_work(&memcg->high_work);
> @@ -4257,7 +4257,8 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
>  	*pheadroom = PAGE_COUNTER_MAX;
>  
>  	while ((parent = parent_mem_cgroup(memcg))) {
> -		unsigned long ceiling = min(memcg->memory.max, memcg->high);
> +		unsigned long ceiling = min(memcg->memory.max,
> +					    READ_ONCE(memcg->high));
>  		unsigned long used = page_counter_read(&memcg->memory);
>  
>  		*pheadroom = min(*pheadroom, ceiling - min(ceiling, used));
> @@ -4978,7 +4979,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  	if (!memcg)
>  		return ERR_PTR(error);
>  
> -	memcg->high = PAGE_COUNTER_MAX;
> +	WRITE_ONCE(memcg->high, PAGE_COUNTER_MAX);
>  	memcg->soft_limit = PAGE_COUNTER_MAX;
>  	if (parent) {
>  		memcg->swappiness = mem_cgroup_swappiness(parent);
> @@ -5131,7 +5132,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
>  	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
>  	page_counter_set_min(&memcg->memory, 0);
>  	page_counter_set_low(&memcg->memory, 0);
> -	memcg->high = PAGE_COUNTER_MAX;
> +	WRITE_ONCE(memcg->high, PAGE_COUNTER_MAX);
>  	memcg->soft_limit = PAGE_COUNTER_MAX;
>  	memcg_wb_domain_size_changed(memcg);
>  }
> @@ -5947,7 +5948,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  	if (err)
>  		return err;
>  
> -	memcg->high = high;
> +	WRITE_ONCE(memcg->high, high);
>  
>  	for (;;) {
>  		unsigned long nr_pages = page_counter_read(&memcg->memory);
> -- 
> 2.25.1
> 

-- 
Michal Hocko
SUSE Labs
