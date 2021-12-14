Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96477473FA7
	for <lists+cgroups@lfdr.de>; Tue, 14 Dec 2021 10:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhLNJiu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Dec 2021 04:38:50 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47432 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhLNJiu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Dec 2021 04:38:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0BCE92113A;
        Tue, 14 Dec 2021 09:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639474729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DZOd/YlnoT6tjCOMidF4fHVU5QDgu/mXU178ktIvi5s=;
        b=kuEtYIU7reYiVep3MAXrOtg9r/HPOo3becXk8V6gOocQyNceBmW9ZvQ7CnlAkD7kC4cmOK
        GJTjoFlDbqJGuc3/oBRu3gf1HFGFEpzUgDQMDv858fev78o1v1fGcun5kHpqo+4T2K2fs0
        xeRmqbHfcE8mmD7Xx4OCuWMl+JXehhA=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6D2ADA3B8F;
        Tue, 14 Dec 2021 09:38:48 +0000 (UTC)
Date:   Tue, 14 Dec 2021 10:38:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: add group_oom_kill memory.event fix
Message-ID: <YbhmJ63KXGLDpQo7@dhcp22.suse.cz>
References: <20211213162511.2492267-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213162511.2492267-1-schatzberg.dan@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 13-12-21 08:25:10, Dan Schatzberg wrote:
> Andrew, could you please amend the prior patch "mm: add group_oom_kill
> memory.event" with these changes from Johannes and Chris?
> 
> Also - small nit: it makes better sense to
> s/group_oom_kill/oom_group_kill/g in the patch title.

Agreed. This is more in line with the oom.group knob we export.
> 
> Reviewed-by: Roman Gushchin <guro@fb.com>
> Acked-by: Chris Down <chris@chrisdown.name>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>

With these changes feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 3 +--
>  mm/memcontrol.c                         | 3 ---
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index eec830ce2068..8269bfa240f4 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1269,8 +1269,7 @@ PAGE_SIZE multiple when read back.
>  		killed by any kind of OOM killer.
>  
>            oom_group_kill
> -                The number of times all tasks in the cgroup were killed
> -                due to memory.oom.group.
> +                The number of times a group OOM has occurred.
>  
>    memory.events.local
>  	Similar to memory.events but the fields in the file are local
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5ab3b9ce90de..b5454d8fc344 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4390,9 +4390,6 @@ static int mem_cgroup_oom_control_read(struct seq_file *sf, void *v)
>  	seq_printf(sf, "under_oom %d\n", (bool)memcg->under_oom);
>  	seq_printf(sf, "oom_kill %lu\n",
>  		   atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]));
> -	seq_printf(sf, "oom_group_kill %lu\n",
> -		   atomic_long_read(
> -			&memcg->memory_events[MEMCG_OOM_GROUP_KILL]));
>  	return 0;
>  }
>  
> -- 
> 2.30.2

-- 
Michal Hocko
SUSE Labs
