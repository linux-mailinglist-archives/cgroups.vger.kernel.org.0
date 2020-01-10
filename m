Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E91C136927
	for <lists+cgroups@lfdr.de>; Fri, 10 Jan 2020 09:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgAJItN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jan 2020 03:49:13 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:60930 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727152AbgAJItN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jan 2020 03:49:13 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 22BFB2E037C;
        Fri, 10 Jan 2020 11:49:10 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id mOJVkqvLMH-n8dmwGcB;
        Fri, 10 Jan 2020 11:49:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1578646150; bh=qNR3NRByyHlpXQ4p8X/hlo3hrAKhN7Qz3lDeB34a2SE=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=Fyx7qH8P/x1bFQnJzbtV/n/oKwipgrSOqyHGMcwJ8hs8laBFTQJQCrEKnzAvegvLj
         7DmxhCtvD5dSvHww2xkvK8WCrFCn8nLyOIVAc8fp2ddXKmixviBV9JqSrBpVvJZ0O9
         vop6n5umIXK5jlres1B9ZHfNtHWTnSNRpRfoE+fw=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id yoMDYH1TTx-n8V0jXth;
        Fri, 10 Jan 2020 11:49:08 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH v7 02/10] mm/memcg: fold lru_lock in lock_page_lru
To:     Alex Shi <alex.shi@linux.alibaba.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
 <1577264666-246071-3-git-send-email-alex.shi@linux.alibaba.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <36d7e390-a3d1-908c-d181-4a9e9c8d3d98@yandex-team.ru>
Date:   Fri, 10 Jan 2020 11:49:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577264666-246071-3-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 25/12/2019 12.04, Alex Shi wrote:
>  From the commit_charge's explanations and mem_cgroup_commit_charge
> comments, as well as call path when lrucare is ture, The lru_lock is
> just to guard the task migration(which would be lead to move_account)
> So it isn't needed when !PageLRU, and better be fold into PageLRU to
> reduce lock contentions.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   mm/memcontrol.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c5b5f74cfd4d..0ad10caabc3d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2572,12 +2572,11 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>   
>   static void lock_page_lru(struct page *page, int *isolated)
>   {
> -	pg_data_t *pgdat = page_pgdat(page);
> -
> -	spin_lock_irq(&pgdat->lru_lock);
>   	if (PageLRU(page)) {
> +		pg_data_t *pgdat = page_pgdat(page);
>   		struct lruvec *lruvec;
>   
> +		spin_lock_irq(&pgdat->lru_lock);

That's wrong. Here PageLRU must be checked again under lru_lock.


Also I don't like these functions:
- called lock/unlock but actually also isolates
- used just once
- pgdat evaluated twice

>   		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>   		ClearPageLRU(page);
>   		del_page_from_lru_list(page, lruvec, page_lru(page));
> @@ -2588,17 +2587,17 @@ static void lock_page_lru(struct page *page, int *isolated)
>   
>   static void unlock_page_lru(struct page *page, int isolated)
>   {
> -	pg_data_t *pgdat = page_pgdat(page);
>   
>   	if (isolated) {
> +		pg_data_t *pgdat = page_pgdat(page);
>   		struct lruvec *lruvec;
>   
>   		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>   		VM_BUG_ON_PAGE(PageLRU(page), page);
>   		SetPageLRU(page);
>   		add_page_to_lru_list(page, lruvec, page_lru(page));
> +		spin_unlock_irq(&pgdat->lru_lock);
>   	}
> -	spin_unlock_irq(&pgdat->lru_lock);
>   }
>   
>   static void commit_charge(struct page *page, struct mem_cgroup *memcg,
> 
