Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C81186DEC
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2020 15:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbgCPO5o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Mar 2020 10:57:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51418 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731539AbgCPO5o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Mar 2020 10:57:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id a132so18014644wme.1;
        Mon, 16 Mar 2020 07:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CuvWFuqCG4KEAkRK7EOPy0KNKDy73YIks+wli/bNrIk=;
        b=WdHLOwgg/ZXiqJ9Gkl9eo0PWRHSoR9L6cKaHIhRXTufRUfLp6OYrbErMl3b9ZmTUlg
         PRrslsyB4ZcR32WrjYeCOHopICrEJURB9wommE3I6dGvrlgyM9T5Ul/O2zpsmeWsiExb
         UdS4aTdxvfsobtqMTV7EnEO/c7iAIHPqATtyJTb5ystPkVMqYWz3z5ie4wxshFKQB9v4
         cm+HkZ0qL227TpXrM2XrZyXasVdPkMGjq/45JXn6IO5VWxCHJ3g+VzICXitAre+91ZUy
         DQVdpZGI9oRXW0dvD7H3+ADgdeqP2IMSHkADKiYLSzY8XXp4So15tSTfLzWZOKOTR/3K
         NFog==
X-Gm-Message-State: ANhLgQ25Gd2zEtaJCw8zkQmphKyftheOkmKns9FJgP2UogeDSJj88IDt
        TfFHSpPfujNRb0YSjpdJ7Ck=
X-Google-Smtp-Source: ADFU+vuxr1MlnxaVPTHNEpdcW0tduhRumcOW54unK5HZo2oIB47fMNMEC3sUX2fki2zFgUKVoAWGwA==
X-Received: by 2002:a05:600c:c8:: with SMTP id u8mr28452399wmm.178.1584370662433;
        Mon, 16 Mar 2020 07:57:42 -0700 (PDT)
Received: from localhost ([37.188.132.163])
        by smtp.gmail.com with ESMTPSA id 31sm296460wrr.5.2020.03.16.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:57:41 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:57:40 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/6] mm, memcg: Prevent memory.low load/store tearing
Message-ID: <20200316145740.GO11482@dhcp22.suse.cz>
References: <cover.1584034301.git.chris@chrisdown.name>
 <448206f44b0fa7be9dad2ca2601d2bcb2c0b7844.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448206f44b0fa7be9dad2ca2601d2bcb2c0b7844.1584034301.git.chris@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 12-03-20 17:33:01, Chris Down wrote:
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
>  mm/memcontrol.c   | 4 ++--
>  mm/page_counter.c | 9 ++++++---
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index aca2964ea494..c85a304fa4a1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6262,7 +6262,7 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>  		return MEMCG_PROT_NONE;
>  
>  	emin = memcg->memory.min;
> -	elow = memcg->memory.low;
> +	elow = READ_ONCE(memcg->memory.low);
>  
>  	parent = parent_mem_cgroup(memcg);
>  	/* No parent means a non-hierarchical mode on v1 memcg */
> @@ -6291,7 +6291,7 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>  	if (elow && parent_elow) {
>  		unsigned long low_usage, siblings_low_usage;
>  
> -		low_usage = min(usage, memcg->memory.low);
> +		low_usage = min(usage, READ_ONCE(memcg->memory.low));
>  		siblings_low_usage = atomic_long_read(
>  			&parent->memory.children_low_usage);
>  
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index 50184929b61f..18b7f779f2e2 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -17,6 +17,7 @@ static void propagate_protected_usage(struct page_counter *c,
>  				      unsigned long usage)
>  {
>  	unsigned long protected, old_protected;
> +	unsigned long low;
>  	long delta;
>  
>  	if (!c->parent)
> @@ -34,8 +35,10 @@ static void propagate_protected_usage(struct page_counter *c,
>  			atomic_long_add(delta, &c->parent->children_min_usage);
>  	}
>  
> -	if (c->low || atomic_long_read(&c->low_usage)) {
> -		if (usage <= c->low)
> +	low = READ_ONCE(c->low);
> +
> +	if (low || atomic_long_read(&c->low_usage)) {
> +		if (usage <= low)
>  			protected = usage;
>  		else
>  			protected = 0;
> @@ -231,7 +234,7 @@ void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages)
>  {
>  	struct page_counter *c;
>  
> -	counter->low = nr_pages;
> +	WRITE_ONCE(counter->low, nr_pages);
>  
>  	for (c = counter; c; c = c->parent)
>  		propagate_protected_usage(c, atomic_long_read(&c->usage));
> -- 
> 2.25.1
> 

-- 
Michal Hocko
SUSE Labs
