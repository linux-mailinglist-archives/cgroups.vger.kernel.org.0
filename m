Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D814B15914E
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2020 15:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgBKOBx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Feb 2020 09:01:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38006 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbgBKOBw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Feb 2020 09:01:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so3700503wmj.3
        for <cgroups@vger.kernel.org>; Tue, 11 Feb 2020 06:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BXiGmThdAH0Y+7szdJZvX90AmeQq3coTYvS9lSVqoHQ=;
        b=Yelhdn3Ss+7RZcMG4WyGiKjSjI9HDf5QDm+XM7q4JgYPhVY45B8QRks/WOr8gl/YII
         nuVhDfJg9Q/ftMTLtQpUApb9SYMRZK3J3IDooslIAwBcPhViPWyHt5zuh0S5Z5w/bMQU
         8l712V6qxqEKMrayFGheiQvItfgdaegGfHRNzMLb1h0VNviE4EkBovtDljtwVtdXK5NJ
         r91Do4bbiCJWXc7c37NPdcVuhoB7Q8VvkzIBjG2jImFSuPmttP7o818Q78aYSwP3ttcm
         AV4HwWU8o40XXRXJpM0AN+ePDSafBkOOVx60copR2eS4kfds9hpAPKL3EwL6Y+xH69eN
         Q5AA==
X-Gm-Message-State: APjAAAXfTTAEjHsGQT6Bk2I4oePpUSAQkdh/9wNhVgwBNw5hk8vTrX9R
        3z0t3MPMZKN9wrlhy3MLK9I=
X-Google-Smtp-Source: APXvYqwMXtPDnxivXRo6fXhlbud5qAkmSVTJWSyOp2Z7gAqFF6wrFc0pyj1lKg+sO6AEpX6w7LtObQ==
X-Received: by 2002:a1c:bb82:: with SMTP id l124mr5752300wmf.176.1581429709436;
        Tue, 11 Feb 2020 06:01:49 -0800 (PST)
Received: from localhost (ip-37-188-227-72.eurotel.cz. [37.188.227.72])
        by smtp.gmail.com with ESMTPSA id f8sm5383908wru.12.2020.02.11.06.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 06:01:48 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:01:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] memcg: lost css_put in memcg_expand_shrinker_maps()
Message-ID: <20200211135322.GO10636@dhcp22.suse.cz>
References: <c98414fb-7e1f-da0f-867a-9340ec4bd30b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c98414fb-7e1f-da0f-867a-9340ec4bd30b@virtuozzo.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 11-02-20 14:20:10, Vasily Averin wrote:
> for_each_mem_cgroup() increases css reference counter for memory cgroup
> and requires to use mem_cgroup_iter_break() if the walk is cancelled.
> 
> Cc: stable@vger.kernel.org
> Fixes commit 0a4465d34028("mm, memcg: assign memcg-aware shrinkers bitmap to memcg")

Fixes: 0a4465d34028("mm, memcg: assign memcg-aware shrinkers bitmap to memcg")

Is the usual format.
 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6c83cf4..e2da615 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -409,8 +409,10 @@ int memcg_expand_shrinker_maps(int new_id)
>  		if (mem_cgroup_is_root(memcg))
>  			continue;
>  		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
> -		if (ret)
> +		if (ret) {
> +			mem_cgroup_iter_break(NULL, memcg);
>  			goto unlock;
> +		}
>  	}
>  unlock:
>  	if (!ret)
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
