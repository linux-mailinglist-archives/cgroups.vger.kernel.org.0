Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7483A38FCF8
	for <lists+cgroups@lfdr.de>; Tue, 25 May 2021 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhEYIh2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 May 2021 04:37:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:48880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231690AbhEYIgO (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 25 May 2021 04:36:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621931684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bjnsL2peeOiwWaK94JCXPWqqFm70yQEu/wWcJgX6mj8=;
        b=Y7rk0GEZ2G5BRETie8/EcGewGFpOb/F+H5mMaKQIz01KT1HN37phtRqsK5uKgMqra2IBtc
        c7RUPp8fYAzoG/lcS4F+KVbnNYp50GLWBtd6+1XHQ66//RWJ+IbkA7I8N2M78qdbMN14yg
        5onv36M08g1DIF7KwxmO4au0Xiqa2UE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3CF9DAE1F;
        Tue, 25 May 2021 08:34:44 +0000 (UTC)
Date:   Tue, 25 May 2021 10:34:43 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: fix kernel-doc
Message-ID: <YKy2o2WGRcD7vht8@dhcp22.suse.cz>
References: <1621851862-34443-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621851862-34443-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 24-05-21 18:24:22, Yang Li wrote:
> Fix function name in mm/memcontrol.c kernel-doc comment
> to remove a warning.
> 
> mm/memcontrol.c:6546: warning: expecting prototype for
> mem_cgroup_protected(). Prototype was for
> mem_cgroup_calculate_protection() instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 64ada9e..030c1dc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6456,7 +6456,7 @@ static unsigned long effective_protection(unsigned long usage,
>  }
>  
>  /**
> - * mem_cgroup_protected - check if memory consumption is in the normal range
> + * mem_cgroup_calculate_protection - check if memory consumption is in the normal range
>   * @root: the top ancestor of the sub-tree being checked
>   * @memcg: the memory cgroup to check
>   *
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
