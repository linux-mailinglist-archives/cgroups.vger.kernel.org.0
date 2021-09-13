Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EE7408796
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 10:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbhIMIyw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 04:54:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52178 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbhIMIyw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 04:54:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2BD0B1FFAB;
        Mon, 13 Sep 2021 08:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631523216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kchB+aw0FiEHbBgAGvT8V7qxriNJ47RlDUOFmHHFsR8=;
        b=kGFs+4yihN3fLKCge3xceliBWYVrbZxUw+0zsqAVcpn5mgLH/8I1UfL/abne0cLcIy5BfQ
        yKP5rIR4r7OfrZo/Xkn8Xzn3z6WA/qAVONP+h+kArUvhUxk8NrP4LW4K8CNZ0VD72+YMAX
        HXBEC49PkTTooA+LPItgSLJerNg1ol0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DBC99A3B93;
        Mon, 13 Sep 2021 08:53:35 +0000 (UTC)
Date:   Mon, 13 Sep 2021 10:53:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH memcg] memcg: prohibit unconditional exceeding the limit
 of dying tasks
Message-ID: <YT8RjxShvfEVe4YU@dhcp22.suse.cz>
References: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 10-09-21 15:39:28, Vasily Averin wrote:
> The kernel currently allows dying tasks to exceed the memcg limits.
> The allocation is expected to be the last one and the occupied memory
> will be freed soon.
> This is not always true because it can be part of the huge vmalloc
> allocation. Allowed once, they will repeat over and over again.
> Moreover lifetime of the allocated object can differ from
> In addition the lifetime of the dying task.
> Multiple such allocations running concurrently can not only overuse
> the memcg limit, but can lead to a global out of memory and,
> in the worst case, cause the host to panic.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  mm/memcontrol.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 389b5766e74f..67195fcfbddf 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1834,6 +1834,9 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
>  		return OOM_ASYNC;
>  	}
>  
> +	if (should_force_charge())
> +		return OOM_SKIPPED;

mem_cgroup_out_of_memory already check for the bypass, now you are
duplicating that check with a different answer to the caller. This is
really messy. One of the two has to go away.

-- 
Michal Hocko
SUSE Labs
