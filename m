Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B61342924
	for <lists+cgroups@lfdr.de>; Sat, 20 Mar 2021 00:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbhCSXdl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Mar 2021 19:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCSXd2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Mar 2021 19:33:28 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F87CC061760
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 16:33:28 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o5so4710118qkb.0
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 16:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=H5VdK/uIKMT1pp4iCjsWX5lLDmAK1g5zh8chc7mIlAc=;
        b=AY3pRnV72+SVoCn6bFK2m3d33V0kl3Xdda5vLh6PNQNNefCcAdDxuiD5hlz3URSd+i
         IVpfjCNBFk7l3OILp3flc1HpKr+lYJewEk2+hdkYf4Anssy+2hawzWNpfP0J4MipfB0G
         K8Zzp7g7MQNL6nWIRfRrOyvtsD0HLMAt8lC/cAY0WhmdMVriYj6dbDBOUzWsxbSW/Eer
         uUdcZ08zjwC4OLH1mQoBs6fBjJstKgjzJb9MLdJpa4cP/B0ZjhqjvY02td2/Xk+LcRDd
         nZckom5APFW679p2UegQaJ14GM8XCvZ2zQS9rWIqW79JELxZOtYzsV2e44iG9zbnfpgC
         uj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=H5VdK/uIKMT1pp4iCjsWX5lLDmAK1g5zh8chc7mIlAc=;
        b=cnSHgZxZvpx+wb8fT588dmR17DR3qaphaXmvlfLcBPZ32w+T0Vj7DLatD0kkgFmKNa
         jtq4jW6gHIaTBNwwJY5wLDQFt/HDsSCnL0qb8+1lgZtbpev+zRQT7R8/asgw7CqVmuHx
         /ENdBnYsr3vHclUlOfiMo6Iqit+0RdYCdgLNqeqPZgIrRU+nJMVI9Sr1Kka5SzEekqq5
         KcSQlLXlfL/wEYPgeO8CpxJDREzgLzt19cJcm+zTEe4zQO9URaKWjRucFJXxwfY9NbFO
         +dWzF9UDwTn8Fbnk24YNtbQbg/DqBcgHvDIRK/9ysbeJkp6iHij0iz7Tx93c1/6GiBIv
         Tkvw==
X-Gm-Message-State: AOAM533wdbi6V/Rh19DNqAY9dBe7mxTiFNDIvCx872rpsMYWjIYgN79j
        2gpHP53EZCVI4odwgQucLiZehQ==
X-Google-Smtp-Source: ABdhPJzSOdA+BZ4Cwwe9fFa3TylOFETyoXHTWal2DU9jC14FF6dLvr0K3mrLd/HkzIlioGc3Yeg0QQ==
X-Received: by 2002:a37:a408:: with SMTP id n8mr1050785qke.6.1616196807028;
        Fri, 19 Mar 2021 16:33:27 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e14sm5545018qka.56.2021.03.19.16.33.25
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 19 Mar 2021 16:33:26 -0700 (PDT)
Date:   Fri, 19 Mar 2021 16:33:14 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2] mm: memcontrol: don't allocate cgroup swap arrays
 when memcg is disabled
In-Reply-To: <20210319054944.50048-1-hannes@cmpxchg.org>
Message-ID: <alpine.LSU.2.11.2103191630090.1043@eggly.anvils>
References: <20210319054944.50048-1-hannes@cmpxchg.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 19 Mar 2021, Johannes Weiner wrote:

> Since commit 2d1c498072de ("mm: memcontrol: make swap tracking an
> integral part of memory control"), the cgroup swap arrays are used to
> track memory ownership at the time of swap readahead and swapoff, even
> if swap space *accounting* has been turned off by the user via
> swapaccount=0 (which sets cgroup_memory_noswap).
> 
> However, the patch was overzealous: by simply dropping the
> cgroup_memory_noswap conditionals in the swapon, swapoff and uncharge
> path, it caused the cgroup arrays being allocated even when the memory
> controller as a whole is disabled. This is a waste of that memory.
> 
> Restore mem_cgroup_disabled() checks, implied previously by
> cgroup_memory_noswap, in the swapon, swapoff, and swap_entry_free
> callbacks.
> 
> Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Hugh Dickins <hughd@google.com>

Thanks for the memory!

> ---
>  mm/memcontrol.c  | 3 +++
>  mm/swap_cgroup.c | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 668d1d7c2645..49bdcf603af1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7101,6 +7101,9 @@ void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
>  	struct mem_cgroup *memcg;
>  	unsigned short id;
>  
> +	if (mem_cgroup_disabled())
> +		return;
> +
>  	id = swap_cgroup_record(entry, 0, nr_pages);
>  	rcu_read_lock();
>  	memcg = mem_cgroup_from_id(id);
> diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> index 7f34343c075a..08c3246f9269 100644
> --- a/mm/swap_cgroup.c
> +++ b/mm/swap_cgroup.c
> @@ -171,6 +171,9 @@ int swap_cgroup_swapon(int type, unsigned long max_pages)
>  	unsigned long length;
>  	struct swap_cgroup_ctrl *ctrl;
>  
> +	if (mem_cgroup_disabled())
> +		return 0;
> +
>  	length = DIV_ROUND_UP(max_pages, SC_PER_PAGE);
>  	array_size = length * sizeof(void *);
>  
> @@ -206,6 +209,9 @@ void swap_cgroup_swapoff(int type)
>  	unsigned long i, length;
>  	struct swap_cgroup_ctrl *ctrl;
>  
> +	if (mem_cgroup_disabled())
> +		return;
> +
>  	mutex_lock(&swap_cgroup_mutex);
>  	ctrl = &swap_cgroup_ctrl[type];
>  	map = ctrl->map;
> -- 
> 2.30.1
