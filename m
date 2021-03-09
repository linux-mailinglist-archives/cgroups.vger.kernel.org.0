Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689F1332960
	for <lists+cgroups@lfdr.de>; Tue,  9 Mar 2021 15:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhCIO57 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Mar 2021 09:57:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:56994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231652AbhCIO5x (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 9 Mar 2021 09:57:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615301872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ub+z7UW6G+p7byFeLSBCS3Oq9eOmRCBt+nX5wp22Mg=;
        b=AivRumHZpuQ4WOtIffTFP2IZCPHT1w3Z1VSEUQCS85Si/yS/0LEY0F3M9HsP7VdBx5rf5R
        kprrR1HPRo1G9mKSWEgrfenZA9x6IXOBttbWnCdzMIQIXXIRKI8k9tMN9NhfGEY86DlWWi
        B0xXDtrH4r5dIHEslCslFYtKv69a8us=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6B2FAC8C;
        Tue,  9 Mar 2021 14:57:52 +0000 (UTC)
Date:   Tue, 9 Mar 2021 15:57:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH 1/9] memcg: accounting for allocations called with
 disabled BH
Message-ID: <YEeM8AZczZt/irhR@dhcp22.suse.cz>
References: <18a0ae77-89ff-2679-ab19-378e38ce2be2@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18a0ae77-89ff-2679-ab19-378e38ce2be2@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 09-03-21 11:03:48, Vasily Averin wrote:
> in_interrupt() check in memcg_kmem_bypass() is incorrect because
> it does not allow to account memory allocation called from task context
> with disabled BH, i.e. inside spin_lock_bh()/spin_unlock_bh() sections

Is there any existing user in the tree? Or is this more of a preparatory
patch for a later one which will need it? In other words, is this a bug
fix or a preparatory work.

> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 845eec0..568f2cb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1076,7 +1076,7 @@ static __always_inline bool memcg_kmem_bypass(void)
>  		return false;
>  
>  	/* Memcg to charge can't be determined. */
> -	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
> +	if (!in_task() || !current->mm || (current->flags & PF_KTHREAD))
>  		return true;
>  
>  	return false;
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
