Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75DEAD73D1
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2019 12:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731444AbfJOKtV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Oct 2019 06:49:21 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:39022 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731434AbfJOKtT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Oct 2019 06:49:19 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 7E4802E0AD4;
        Tue, 15 Oct 2019 13:49:16 +0300 (MSK)
Received: from vla5-2bf13a090f43.qloud-c.yandex.net (vla5-2bf13a090f43.qloud-c.yandex.net [2a02:6b8:c18:3411:0:640:2bf1:3a09])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 7rrsh8uytn-nFq8PcE2;
        Tue, 15 Oct 2019 13:49:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1571136556; bh=kAMGDxkAbOPo3YYQfmMwLm3qVE+lcF5C9p9mjMh3EfA=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=rQw+KLl4HkAqtmwhezss/Z53Dxs7y2+bj/AoPhBWVauUKB4M0XyZWTOlyM1sV6kfO
         u2G0uWq5uOz9iVde1iKyTrtI3zgvE3QzuUkrwlYkIi0uL+/HQGVeuAZkBmr2A7BX9j
         GHxfA+S3RCAXieYfCJFzif4whnfoVGqMxtZBg86o=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by vla5-2bf13a090f43.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id tdH7LpAdpl-nFJCDZSi;
        Tue, 15 Oct 2019 13:49:15 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] mm/memcontrol: update lruvec counters in
 mem_cgroup_move_account
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <157112699975.7360.1062614888388489788.stgit@buzz>
 <20191015082048.GU317@dhcp22.suse.cz>
 <3b73e301-ea4a-5edb-9360-2ae9b4ad9f69@yandex-team.ru>
 <20191015103623.GX317@dhcp22.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <31cab57d-6e79-33cb-1a58-99065c6e7b82@yandex-team.ru>
Date:   Tue, 15 Oct 2019 13:49:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015103623.GX317@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 15/10/2019 13.36, Michal Hocko wrote:
> On Tue 15-10-19 11:44:22, Konstantin Khlebnikov wrote:
>> On 15/10/2019 11.20, Michal Hocko wrote:
>>> On Tue 15-10-19 11:09:59, Konstantin Khlebnikov wrote:
>>>> Mapped, dirty and writeback pages are also counted in per-lruvec stats.
>>>> These counters needs update when page is moved between cgroups.
>>>
>>> Please describe the user visible effect.
>>
>> Surprisingly I don't see any users at this moment.
>> So, there is no effect in mainline kernel.
> 
> Those counters are exported right? Or do we exclude them for v1?

It seems per-lruvec statistics is not exposed anywhere.
And per-lruvec NR_FILE_MAPPED, NR_FILE_DIRTY, NR_WRITEBACK never had users.

I've found this because I'm using mem_cgroup_move_account for recharging
pages at mlock and playing right now with debug for memory cgroup which
validates statistics and counters when cgroup dies.

> 
>>>> Fixes: 00f3ca2c2d66 ("mm: memcontrol: per-lruvec stats infrastructure")
>>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>>
>>> We want Cc: stable I suspect because broken stats might be really
>>> misleading.
>>>
>>> The patch looks ok to me otherwise
>>> Acked-by: Michal Hocko <mhocko@suse.com>
>>>
>>>> ---
>>>>    mm/memcontrol.c |   18 ++++++++++++------
>>>>    1 file changed, 12 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>> index bdac56009a38..363106578876 100644
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>>> @@ -5420,6 +5420,8 @@ static int mem_cgroup_move_account(struct page *page,
>>>>    				   struct mem_cgroup *from,
>>>>    				   struct mem_cgroup *to)
>>>>    {
>>>> +	struct lruvec *from_vec, *to_vec;
>>>> +	struct pglist_data *pgdat;
>>>>    	unsigned long flags;
>>>>    	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
>>>>    	int ret;
>>>> @@ -5443,11 +5445,15 @@ static int mem_cgroup_move_account(struct page *page,
>>>>    	anon = PageAnon(page);
>>>> +	pgdat = page_pgdat(page);
>>>> +	from_vec = mem_cgroup_lruvec(pgdat, from);
>>>> +	to_vec = mem_cgroup_lruvec(pgdat, to);
>>>> +
>>>>    	spin_lock_irqsave(&from->move_lock, flags);
>>>>    	if (!anon && page_mapped(page)) {
>>>> -		__mod_memcg_state(from, NR_FILE_MAPPED, -nr_pages);
>>>> -		__mod_memcg_state(to, NR_FILE_MAPPED, nr_pages);
>>>> +		__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
>>>> +		__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
>>>>    	}
>>>>    	/*
>>>> @@ -5459,14 +5465,14 @@ static int mem_cgroup_move_account(struct page *page,
>>>>    		struct address_space *mapping = page_mapping(page);
>>>>    		if (mapping_cap_account_dirty(mapping)) {
>>>> -			__mod_memcg_state(from, NR_FILE_DIRTY, -nr_pages);
>>>> -			__mod_memcg_state(to, NR_FILE_DIRTY, nr_pages);
>>>> +			__mod_lruvec_state(from_vec, NR_FILE_DIRTY, -nr_pages);
>>>> +			__mod_lruvec_state(to_vec, NR_FILE_DIRTY, nr_pages);
>>>>    		}
>>>>    	}
>>>>    	if (PageWriteback(page)) {
>>>> -		__mod_memcg_state(from, NR_WRITEBACK, -nr_pages);
>>>> -		__mod_memcg_state(to, NR_WRITEBACK, nr_pages);
>>>> +		__mod_lruvec_state(from_vec, NR_WRITEBACK, -nr_pages);
>>>> +		__mod_lruvec_state(to_vec, NR_WRITEBACK, nr_pages);
>>>>    	}
>>>>    #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>
> 
