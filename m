Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A095409846
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345326AbhIMQEs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 12:04:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41590 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346838AbhIMQEm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 12:04:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 569D221FBB;
        Mon, 13 Sep 2021 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631549005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JBqyG3a4suDnnnaA3ac7IWCsPb+90G8GQiU5+rkKCIk=;
        b=Ar3weKnx1+I8P1sh4HMmXS1uBLW+4wBr79SZPuSNdxNbWyG6TrhJTYLZEnSJgq0NqujFjS
        UpTXLMx5gTJoyaZ6AmGW3tIHIVRtAHPWclKKhf/RrIpw2jV/W6gPULbm3loP8H8BG8r5ub
        sLeI775kCQa2bjboI/pOrxkYgvd/jqs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BE9EFA3B8E;
        Mon, 13 Sep 2021 16:03:24 +0000 (UTC)
Date:   Mon, 13 Sep 2021 18:03:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     yongw.pur@gmail.com
Cc:     tj@kernel.org, peterz@infradead.org, wang.yong12@zte.com.cn,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, yang.yang29@zte.com.cn
Subject: Re: [PATCH v1] vmpressure: wake up work only when there is
 registration event
Message-ID: <YT92TBIMAakm9s33@dhcp22.suse.cz>
References: <1631548441-2784-1-git-send-email-wang.yong12@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631548441-2784-1-git-send-email-wang.yong12@zte.com.cn>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 13-09-21 08:54:01, yongw.pur@gmail.com wrote:
> From: wangyong <wang.yong12@zte.com.cn>
> 
> Use the global variable num_events to record the number of vmpressure
> events registered by the system, and wake up work only when there is
> registration event.
> Usually, the vmpressure event is not registered in the system, this patch
> can avoid waking up work and doing nothing.

How much of an improvement does this bring?

> Refer to Michal Hocko's suggestion:
> https://lore.kernel.org/linux-mm/YR%2FNRJEhPKRQ1r22@dhcp22.suse.cz/

let me also point out that we do have means to implement conditional
branches with a zero overhead. Have a look at static branches.

> Tested-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: wangyong <wang.yong12@zte.com.cn>
> ---
>  mm/vmpressure.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmpressure.c b/mm/vmpressure.c
> index 76518e4..dfac76b 100644
> --- a/mm/vmpressure.c
> +++ b/mm/vmpressure.c
> @@ -67,6 +67,11 @@ static const unsigned int vmpressure_level_critical = 95;
>   */
>  static const unsigned int vmpressure_level_critical_prio = ilog2(100 / 10);
>  
> +/*
> + * Count the number of vmpressure events registered in the system.
> + */
> +static atomic_t num_events = ATOMIC_INIT(0);
> +
>  static struct vmpressure *work_to_vmpressure(struct work_struct *work)
>  {
>  	return container_of(work, struct vmpressure, work);
> @@ -277,7 +282,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>  		vmpr->tree_reclaimed += reclaimed;
>  		spin_unlock(&vmpr->sr_lock);
>  
> -		if (scanned < vmpressure_win)
> +		if (scanned < vmpressure_win || atomic_read(&num_events) == 0)
>  			return;
>  		schedule_work(&vmpr->work);
>  	} else {

This is a very odd place to put the check on. It is past locks being
held and schedule_work on it's own is unlikely to provide a big
overhead. I would have expected to implement the check at the very
beginning of vmpressure()

-- 
Michal Hocko
SUSE Labs
