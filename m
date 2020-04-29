Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A7C1BD941
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2020 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgD2KPO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Apr 2020 06:15:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35004 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgD2KPO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Apr 2020 06:15:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id x18so1824187wrq.2;
        Wed, 29 Apr 2020 03:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Njrl+LtsYOcLWuGaTy+eEj39sQfLR9JQYx3iweX+KpU=;
        b=IFf/tsOR3P29D3EvmDuNC8LdwdKyF5bVNOpYZXdS2rrE7DVB5shqIQr0lC/NpcnkNQ
         6OKJmatoK3M6ztkrsZppiyV8kYCMWhD1IhlkKPf+YJ7igTnD2uAfUSFSDBgmKKt7i4jm
         XoDzsZD9SRaMsKyiMNdxleMEctQNpYIYw0v0rWWXFZ5CezyXsKR1gvpi4LFHVKIbHtLa
         Kt4Zbri1oL6QR43+G30/18HeK+g7OUTcvr213Vd9rZ8ogFSIcY7c6+cqDZ9mLQoi4Aew
         7SOyCeD21Xi0R6/Ha/ShSXhnp9RcS6xOQXkm9/t7kOb1B5B1smtloENaLYK1jOQAZQCM
         rFZg==
X-Gm-Message-State: AGi0PuaHXXH2U0MARtc4pUQ6t/I3i/yILe+hTbrAWqXV/AopAn12/9Dc
        fgAPGB9SY+rwHCqrrOHF9oI=
X-Google-Smtp-Source: APiQypJGgFvLLqTU1s5YisUTtz/tbz+dtqB8uoU/wVmtyeOtMDieqK+p6vICrzf6demSsbqO+3KtGw==
X-Received: by 2002:a5d:428a:: with SMTP id k10mr38619699wrq.59.1588155312300;
        Wed, 29 Apr 2020 03:15:12 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id n6sm6870097wmc.28.2020.04.29.03.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:15:11 -0700 (PDT)
Date:   Wed, 29 Apr 2020 12:15:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
Message-ID: <20200429101510.GA28637@dhcp22.suse.cz>
References: <cover.1588092152.git.chris@chrisdown.name>
 <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 28-04-20 19:26:47, Chris Down wrote:
> From: Yafang Shao <laoar.shao@gmail.com>
> 
> A cgroup can have both memory protection and a memory limit to isolate
> it from its siblings in both directions - for example, to prevent it
> from being shrunk below 2G under high pressure from outside, but also
> from growing beyond 4G under low pressure.
> 
> Commit 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
> implemented proportional scan pressure so that multiple siblings in
> excess of their protection settings don't get reclaimed equally but
> instead in accordance to their unprotected portion.
> 
> During limit reclaim, this proportionality shouldn't apply of course:
> there is no competition, all pressure is from within the cgroup and
> should be applied as such. Reclaim should operate at full efficiency.
> 
> However, mem_cgroup_protected() never expected anybody to look at the
> effective protection values when it indicated that the cgroup is above
> its protection. As a result, a query during limit reclaim may return
> stale protection values that were calculated by a previous reclaim cycle
> in which the cgroup did have siblings.
> 
> When this happens, reclaim is unnecessarily hesitant and potentially
> slow to meet the desired limit. In theory this could lead to premature
> OOM kills, although it's not obvious this has occurred in practice.

Thanks this describes the underlying problem. I would be also explicit
that the issue should be visible only on tail memcgs which have both
max/high and protection configured and the effect depends on the
difference between the two (the smaller it is the largrger the effect).

There is no mention about the fix. The patch resets effective values for
the reclaim root and I've had some concerns about that
http://lkml.kernel.org/r/20200424162103.GK11591@dhcp22.suse.cz.
Johannes has argued that other races are possible and I didn't get to
think about it thoroughly. But this patch is introducing a new
possibility of breaking protection. If we want to have a quick and
simple fix that would be easier to backport to older kernels then I
would feel much better if we simply workedaround the problem as
suggested earlier http://lkml.kernel.org/r/20200423061629.24185-1-laoar.shao@gmail.com
We can rework the effective values calculation to be more robust against
races on top of that because this is likely a more tricky thing to do.

> Fixes: 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> 
> [hannes@cmpxchg.org: rework code comment]
> [hannes@cmpxchg.org: changelog]
> [chris@chrisdown.name: fix store tear]
> [chris@chrisdown.name: retitle]
> ---
>  mm/memcontrol.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0be00826b832..b0374be44e9e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6392,8 +6392,19 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>  
>  	if (!root)
>  		root = root_mem_cgroup;
> -	if (memcg == root)
> +	if (memcg == root) {
> +		/*
> +		 * The cgroup is the reclaim root in this reclaim
> +		 * cycle, and therefore not protected. But it may have
> +		 * stale effective protection values from previous
> +		 * cycles in which it was not the reclaim root - for
> +		 * example, global reclaim followed by limit reclaim.
> +		 * Reset these values for mem_cgroup_protection().
> +		 */
> +		WRITE_ONCE(memcg->memory.emin, 0);
> +		WRITE_ONCE(memcg->memory.elow, 0);
>  		return MEMCG_PROT_NONE;
> +	}
>  
>  	usage = page_counter_read(&memcg->memory);
>  	if (!usage)
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
