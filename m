Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89415408724
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 10:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbhIMIis (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 04:38:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47108 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbhIMIiY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 04:38:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BD6661FFAA;
        Mon, 13 Sep 2021 08:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631522227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKSu3yTv+TX0tXlcSUO37sd0/aOo8J1xv19A7FZ7+Ig=;
        b=ZMT+0AgcgH+hRJCL2ffTYbCzZn/BEVzdgyChbAJf+WYp+HMrwdkFDOqIR/wbhIEDQaJ3dS
        VDxQV9ERlW08pJz64yBgAYXVsCo2ljnNryj8wTbreIMQM32Ehb0ZAbbPkmtK1oYCdaCbCq
        22d+IBxpaQQO5LXBt5yF+0v5WHrDATY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8874EA3B81;
        Mon, 13 Sep 2021 08:37:07 +0000 (UTC)
Date:   Mon, 13 Sep 2021 10:37:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        kernel@openvz.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] ipc: remove memcg accounting for sops objects in
 do_semtimedop()
Message-ID: <YT8NrsaztWNDpKXk@dhcp22.suse.cz>
References: <90e254df-0dfe-f080-011e-b7c53ee7fd20@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90e254df-0dfe-f080-011e-b7c53ee7fd20@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 11-09-21 10:40:08, Vasily Averin wrote:
> Linus proposes to revert an accounting for sops objects in
> do_semtimedop() because it's really just a temporary buffer
> for a single semtimedop() system call.
> 
> This object can consume up to 2 pages, syscall is sleeping one,
> size and duration can be controlled by user, and this allocation
> can be repeated by many thread at the same time.

Is there any upper bound or is it just bounded by the number of
tasks/threads (that can be controlled by pid controller at least)?

> However Shakeel Butt pointed that there are much more popular objects
> with the same life time and similar memory consumption, the accounting
> of which was decided to be rejected for performance reasons.

Is there any measurable performance impact in this particular case?
 
> In addition, any usual task consumes much more accounted memory,
> so 2 pages of this temporal buffer can be safely ignored.
> 
> Link: https://patchwork.kernel.org/project/linux-fsdevel/patch/20171005222144.123797-1-shakeelb@google.com/
> 
> Fixes: 18319498fdd4 ("memcg: enable accounting of ipc resources")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  ipc/sem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ipc/sem.c b/ipc/sem.c
> index f833238df1ce..6693daf4fe11 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -2238,7 +2238,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
>  		return -EINVAL;
>  
>  	if (nsops > SEMOPM_FAST) {
> -		sops = kvmalloc_array(nsops, sizeof(*sops), GFP_KERNEL_ACCOUNT);
> +		sops = kvmalloc_array(nsops, sizeof(*sops), GFP_KERNEL);
>  		if (sops == NULL)
>  			return -ENOMEM;
>  	}
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
