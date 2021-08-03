Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897D13DE708
	for <lists+cgroups@lfdr.de>; Tue,  3 Aug 2021 09:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhHCHLm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Aug 2021 03:11:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34348 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbhHCHLj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Aug 2021 03:11:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7723B2205F;
        Tue,  3 Aug 2021 07:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627974687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yTB1aRzTEEw2dTSaIA3iMc8Rd5LQIIGML6amfYHIZt4=;
        b=bwvEpu8IwlMFzHs+yKzQ5BkflANLVPluliOGC2khS0BvVK9MnKiTUjZtExbHtFh63auwUB
        A2SyUrkYvGA5kzCzUMoQ2b6UCYU84Nn/R6P49iaFug5gcjrDZ5SLblSEEmEXSS6LWs/dko
        mnKrOFfiafycrcdUJ2jxarlFUwEfmJk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 114E2A3BCB;
        Tue,  3 Aug 2021 07:11:26 +0000 (UTC)
Date:   Tue, 3 Aug 2021 09:11:25 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Roman Gushchin <guro@fb.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        shakeelb@google.com, willy@infradead.org, alexs@kernel.org,
        richard.weiyang@gmail.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
Message-ID: <YQjsHTW+46bG9XsV@dhcp22.suse.cz>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-3-linmiaohe@huawei.com>
 <YQNsxVPsRSBZcfGG@carbon.lan>
 <YQOhGs3k9rHx3mmT@dhcp22.suse.cz>
 <4a3c23c4-054c-2896-29c5-8cf9a4deee98@huawei.com>
 <YQi6lOT6j2DtOGlT@carbon.dhcp.thefacebook.com>
 <95629d91-6ae8-b445-e7fc-b51c888cad59@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95629d91-6ae8-b445-e7fc-b51c888cad59@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 03-08-21 14:29:13, Miaohe Lin wrote:
[...]
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 616d1a72ece3..6210b1124929 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2208,11 +2208,11 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>   */
>  static void drain_all_stock(struct mem_cgroup *root_memcg)
>  {
> -       static DEFINE_MUTEX(percpu_charge_mutex);
>         int cpu, curcpu;
> +       static atomic_t drainer = ATOMIC_INIT(0);
> 
>         /* If someone's already draining, avoid adding running more workers. */
> -       if (!mutex_trylock(&percpu_charge_mutex))
> +       if (atomic_cmpxchg(&drainer, 0, 1) != 0)
>                 return;
>         /*
>          * Notify other cpus that system-wide "drain" is running
> @@ -2244,7 +2244,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>                 }
>         }
>         put_cpu();
> -       mutex_unlock(&percpu_charge_mutex);
> +       atomic_set(&drainer, 0);

atomic_set doesn't imply memory barrier IIRC. Is this safe?

-- 
Michal Hocko
SUSE Labs
