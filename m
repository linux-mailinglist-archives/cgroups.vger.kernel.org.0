Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C56199A8A
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 17:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgCaP56 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 11:57:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46197 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730562AbgCaP56 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Mar 2020 11:57:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id j17so26576807wru.13;
        Tue, 31 Mar 2020 08:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ajlETTQNKzy9g6KlAay+lUFrUJ8HMEJhr2C6BEcUd6w=;
        b=N8M/L1t4DD2lLIxJ65T4Rrb17nUR1FQ6vPV761S7JUSsC8LUWG+eFXscbebim83tyM
         /q7SbQOFOOg+0IGUBrvIMDgBcoIIGHyL9UfHBp1SilwrEnxf65uLdM2kGh449uv+h1sO
         u42nA/b3g7uG9YvcyCHumnFdpme2P+kaKBFR/sj9ebZgyeJ0dl987pVp5no+ygRBpIeA
         rDFgmQGmSzWenLvvEJ80MYYACHuXBibUChnaBBgQKbwfGt/4iKWoJpWq3EI4SfITVkP7
         0tfJnqK8JK3a6BI7FYqCcrdABlMm7wXGumSrKeJ8Nw4+oP075gUjx5vTpXC7GzKAzrRs
         WvYw==
X-Gm-Message-State: ANhLgQ1u64KEpTQ0k/mWwTatt68c+kYAoj7g0uSVHZZn1ZIuQ11MNa4f
        oRrPZ8VylBXduO1X/VuPIK0=
X-Google-Smtp-Source: ADFU+vusVC+kAxIUO0/1NOkFjptxiMjtwlkiI5H3n9XFo9Un/LqGu0X+aapUXnBl+Pj62yb15HdDLw==
X-Received: by 2002:adf:e848:: with SMTP id d8mr20629742wrn.209.1585670275039;
        Tue, 31 Mar 2020 08:57:55 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id u13sm4272535wmm.32.2020.03.31.08.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 08:57:54 -0700 (PDT)
Date:   Tue, 31 Mar 2020 17:57:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: Do not high throttle allocators based on
 wraparound
Message-ID: <20200331155752.GN30449@dhcp22.suse.cz>
References: <20200331152424.GA1019937@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331152424.GA1019937@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 31-03-20 16:24:24, Chris Down wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> If a cgroup violates its memory.high constraints, we may end
> up unduly penalising it. For example, for the following hierarchy:
> 
> A:   max high, 20 usage
> A/B: 9 high, 10 usage
> A/C: max high, 10 usage
> 
> We would end up doing the following calculation below when calculating
> high delay for A/B:
> 
> A/B: 10 - 9 = 1...
> A:   20 - PAGE_COUNTER_MAX = 21, so set max_overage to 21.
> 
> This gets worse with higher disparities in usage in the parent.
> 
> I have no idea how this disappeared from the final version of the patch,
> but it is certainly Not Good(tm). This wasn't obvious in testing
> because, for a simple cgroup hierarchy with only one child, the result
> is usually roughly the same. It's only in more complex hierarchies that
> things go really awry (although still, the effects are limited to a
> maximum of 2 seconds in schedule_timeout_killable at a maximum).

I find this paragraph rather confusing. This is essentially an unsigned
underflow when any of the memcg up the hierarchy is below the high
limit, right?  There doesn't really seem anything complex in such a
hierarchy.

> [chris@chrisdown.name: changelog]
> 
> Fixes: e26733e0d0ec ("mm, memcg: throttle allocators based on ancestral memory.high")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: stable@vger.kernel.org # 5.4.x

To the patch
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index eecf003b0c56..75a978307863 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2336,6 +2336,9 @@ static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
>  		usage = page_counter_read(&memcg->memory);
>  		high = READ_ONCE(memcg->high);
>  
> +		if (usage <= high)
> +			continue;
> +
>  		/*
>  		 * Prevent division by 0 in overage calculation by acting as if
>  		 * it was a threshold of 1 page
> -- 
> 2.26.0
> 

-- 
Michal Hocko
SUSE Labs
