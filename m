Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF894085AF
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 09:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbhIMHw5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 03:52:57 -0400
Received: from relay.sw.ru ([185.231.240.75]:52358 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237739AbhIMHw4 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 13 Sep 2021 03:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=U4RAeSovTvpMRoz+/O0gqhyhiu8Ap3QYy/JuIDY+LGQ=; b=PHISA81fMzX7U1PJK
        4jMERB9nGCylx9xhsenaCZO9osLoDfy+1CfYpuXrEUwCyXj1LM98p3ShFPalaRAEU0KAbdr3EP/bC
        zkLEsPyfEAV5bU5ZBlbuf35U7inCJ5yeA+aSUbManIFFNuT2ACDZhO0e9iicSOvGZT8bz6W5/BN+k
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mPgkb-001nKw-PH; Mon, 13 Sep 2021 10:51:37 +0300
Subject: Re: [PATCH memcg] memcg: prohibit unconditional exceeding the limit
 of dying tasks
From:   Vasily Averin <vvs@virtuozzo.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
Message-ID: <8b98d44a-aeb2-5f5f-2545-ac2bd0c7049b@virtuozzo.com>
Date:   Mon, 13 Sep 2021 10:51:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/10/21 3:39 PM, Vasily Averin wrote:
> The kernel currently allows dying tasks to exceed the memcg limits.
> The allocation is expected to be the last one and the occupied memory
> will be freed soon.
> This is not always true because it can be part of the huge vmalloc
> allocation. Allowed once, they will repeat over and over again.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 389b5766e74f..67195fcfbddf 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2622,15 +2625,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	if (gfp_mask & __GFP_ATOMIC)
>  		goto force;
>  
> -	/*
> -	 * Unlike in global OOM situations, memcg is not in a physical
> -	 * memory shortage.  Allow dying and OOM-killed tasks to
> -	 * bypass the last charges so that they can exit quickly and
> -	 * free their memory.
> -	 */
> -	if (unlikely(should_force_charge()))
> -		goto force;
> -

Should we keep current behaviour for (current->flags & PF_EXITING) case perhaps?
It is set inside do_exit only and (I hope) cannot trigger huge vmalloc allocations.

Thank you,
	Vasily Averin
