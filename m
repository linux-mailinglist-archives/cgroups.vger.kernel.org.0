Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15564186DF8
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2020 15:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbgCPO63 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Mar 2020 10:58:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35490 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731630AbgCPO62 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Mar 2020 10:58:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so1008850wru.2;
        Mon, 16 Mar 2020 07:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aoR8qIRYYjNc/yM1/A0XpgWDiePb9Xg/ztquG02cRtE=;
        b=IqzE8TNLGcg+JDkk4y+JjiXBmg4Nq6DKIb8TM4I1lMDcUsUL9h5SHGRqmGKkIH+nSN
         aSh0AUwciwQQ6R61fVd6nt5tpb/qUQJt2m9NpuTHcdgmZKL3z1V7PADRAUIQp9qI/aT2
         pfF57ZwbugHsWY0RkgFseCScujPYUZWLaOreq7U9cIn8fgetUgMykL7bHB/sAPGgdibE
         kHa7o/ZwVg8qpFdJEBKKv/fBGBYCVMXCIVrFhJEHc5NvYd51FWcitDN52IGERwlMaTjT
         Kc/QO/1wZAeVIfxyssIkAvsLQ0qwFmQ774HH3ZwBuByyIputga2KJscvXn6UJEuTp9I0
         lLRw==
X-Gm-Message-State: ANhLgQ2RRHChjhevuLWQtyQQ9KgKiCY3OdlV3sBJrpr/NYtzJIxgwP5A
        qAXHQiGEAacRc8YnmA0OePg=
X-Google-Smtp-Source: ADFU+vsPKyYiawBkTj9oGFRYMq6Z5hOmF8SOoxdkq/Ce4cCbYx6zmtCzkHhfr6njw0405WWhAAAk7A==
X-Received: by 2002:adf:bbcd:: with SMTP id z13mr31549004wrg.389.1584370707117;
        Mon, 16 Mar 2020 07:58:27 -0700 (PDT)
Received: from localhost ([37.188.132.163])
        by smtp.gmail.com with ESMTPSA id f15sm331657wrt.9.2020.03.16.07.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:58:26 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:58:25 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/6] mm, memcg: Prevent memory.min load/store tearing
Message-ID: <20200316145825.GP11482@dhcp22.suse.cz>
References: <cover.1584034301.git.chris@chrisdown.name>
 <e809b4e6b0c1626dac6945970de06409a180ee65.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e809b4e6b0c1626dac6945970de06409a180ee65.1584034301.git.chris@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 12-03-20 17:33:07, Chris Down wrote:
> This can be set concurrently with reads, which may cause the wrong value
> to be propagated.
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
>  mm/memcontrol.c   |  4 ++--
>  mm/page_counter.c | 10 ++++++----
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c85a304fa4a1..e0ed790a2a8c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6261,7 +6261,7 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>  	if (!usage)
>  		return MEMCG_PROT_NONE;
>  
> -	emin = memcg->memory.min;
> +	emin = READ_ONCE(memcg->memory.min);
>  	elow = READ_ONCE(memcg->memory.low);
>  
>  	parent = parent_mem_cgroup(memcg);
> @@ -6277,7 +6277,7 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>  	if (emin && parent_emin) {
>  		unsigned long min_usage, siblings_min_usage;
>  
> -		min_usage = min(usage, memcg->memory.min);
> +		min_usage = min(usage, READ_ONCE(memcg->memory.min));
>  		siblings_min_usage = atomic_long_read(
>  			&parent->memory.children_min_usage);
>  
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index 18b7f779f2e2..ae471c7d255f 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -17,14 +17,16 @@ static void propagate_protected_usage(struct page_counter *c,
>  				      unsigned long usage)
>  {
>  	unsigned long protected, old_protected;
> -	unsigned long low;
> +	unsigned long low, min;
>  	long delta;
>  
>  	if (!c->parent)
>  		return;
>  
> -	if (c->min || atomic_long_read(&c->min_usage)) {
> -		if (usage <= c->min)
> +	min = READ_ONCE(c->min);
> +
> +	if (min || atomic_long_read(&c->min_usage)) {
> +		if (usage <= min)
>  			protected = usage;
>  		else
>  			protected = 0;
> @@ -217,7 +219,7 @@ void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages)
>  {
>  	struct page_counter *c;
>  
> -	counter->min = nr_pages;
> +	WRITE_ONCE(counter->min, nr_pages);
>  
>  	for (c = counter; c; c = c->parent)
>  		propagate_protected_usage(c, atomic_long_read(&c->usage));
> -- 
> 2.25.1
> 

-- 
Michal Hocko
SUSE Labs
