Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D2C1D0B72
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2020 11:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbgEMJFH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 May 2020 05:05:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34937 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730617AbgEMJFG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 May 2020 05:05:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5so19908555wrq.2
        for <cgroups@vger.kernel.org>; Wed, 13 May 2020 02:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=25RxHAwMSBIhetL8+/dr6OgZkr6zowEfU1+0SqNEFMo=;
        b=K/gzyDIDC5+9XghFqPJ4xLmSESFmBorOWA4711k94igjz6i4Y23+haUmwR6EYLPjkZ
         HNd7v7+nlNKq6zenz63fd29MyR5iPFwc6jm1Pm1dcJVjS+3nCk+8QyNVxakC0SjpnNyZ
         BelOtT7/9vkU9sEfXRnLfI2NWRWtxzFDID/5D+2Nvsinmzbobx/r7ruUdAFUVMNLlJ98
         QvaWFRbfi9mTWiEQ4ZqT7Nf8I+AdOzXbubZOy+zDFidbMvMyS9Z8NdPHK2FoUv0fPKSU
         NchTQ1wtQMLiyr9LKeMu3EAOlf0balHskc8z7z1dZkylSjK+M/e1N/Z1NlnyNLei1TRr
         QlJg==
X-Gm-Message-State: AGi0PuZMM1xCJooPxhJa/AqpdnsdXh1rvewPVJifR1tOhtepmuUli+8y
        3piuMpWxstKL5NxlPb4lQnKv5gJR
X-Google-Smtp-Source: APiQypJWdE8DjrCrM/t86K82ap6eXFwHYOthGCW0D9foSRXTjZWil1VrsD6Grw0l79eYIaZbRgqC8Q==
X-Received: by 2002:adf:e905:: with SMTP id f5mr30391896wrm.409.1589360704960;
        Wed, 13 May 2020 02:05:04 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id 128sm29510735wme.39.2020.05.13.02.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 02:05:03 -0700 (PDT)
Date:   Wed, 13 May 2020 11:05:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Zefan Li <lizefan@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] memcg: Fix memcg_kmem_bypass() for remote memcg charging
Message-ID: <20200513090502.GV29153@dhcp22.suse.cz>
References: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 13-05-20 15:28:28, Li Zefan wrote:
> While trying to use remote memcg charging in an out-of-tree kernel module
> I found it's not working, because the current thread is a workqueue thread.
> 
> Signed-off-by: Zefan Li <lizefan@huawei.com>
> ---
> 
> No need to queue this for v5.7 as currently no upstream users of this memcg
> feature suffer from this bug.
> 
> ---
>  mm/memcontrol.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a3b97f1..db836fc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2802,6 +2802,8 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
>  
>  static inline bool memcg_kmem_bypass(void)
>  {
> +	if (unlikely(current->active_memcg))
> +		return false;

I am confused. Why the check below is insufficient? It checks for both mm
and PF_KTHREAD?

>  	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
>  		return true;
>  	return false;
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
