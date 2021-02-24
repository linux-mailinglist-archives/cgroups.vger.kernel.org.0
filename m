Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001B5323980
	for <lists+cgroups@lfdr.de>; Wed, 24 Feb 2021 10:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbhBXJcE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Feb 2021 04:32:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:55904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232563AbhBXJbo (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 24 Feb 2021 04:31:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614159058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RHDb1EdzW6ls0b9fIDV8fGOOuVEVrb7XhiXVWuec/l4=;
        b=sdh8e/w5oTQCb745WEPHxOHWYf5r0wxjB/z4beRQ4u39gmoCbGLGEmfsRGI/HaRqjS4Kmh
        YIK7mWaAXmjWIOSgk8wZ8aFvrivXgmVghdLlilVsChCKuTF/XPP7ZwytmBizpe8HCFizS8
        ZBToJTW5QZiLS+U7WWzpcvk663uYC9s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60CA8AE05;
        Wed, 24 Feb 2021 09:30:58 +0000 (UTC)
Date:   Wed, 24 Feb 2021 10:30:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: cleanup root memcg checks
Message-ID: <YDYc0WHOcCbwOS8h@dhcp22.suse.cz>
References: <20210223205625.2792891-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223205625.2792891-1-shakeelb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 23-02-21 12:56:25, Shakeel Butt wrote:
> Replace the implicit checking of root memcg with explicit root memcg
> checking i.e. !css->parent with mem_cgroup_is_root().
>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index dcb5665aeb69..79046ad3eec0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4141,7 +4141,7 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
>  	if (val > 100)
>  		return -EINVAL;
>  
> -	if (css->parent)
> +	if (!mem_cgroup_is_root(memcg))
>  		memcg->swappiness = val;
>  	else
>  		vm_swappiness = val;
> @@ -4491,7 +4491,7 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>  
>  	/* cannot set to root cgroup and only 0 and 1 are allowed */
> -	if (!css->parent || !((val == 0) || (val == 1)))
> +	if (mem_cgroup_is_root(memcg) || !((val == 0) || (val == 1)))
>  		return -EINVAL;
>  
>  	memcg->oom_kill_disable = val;
> -- 
> 2.30.0.617.g56c4b15f3c-goog

-- 
Michal Hocko
SUSE Labs
