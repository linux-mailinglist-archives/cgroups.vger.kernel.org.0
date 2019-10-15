Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9FFD7155
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2019 10:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfJOIo1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Oct 2019 04:44:27 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:60640 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726430AbfJOIo1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Oct 2019 04:44:27 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id B5BBB2E149C;
        Tue, 15 Oct 2019 11:44:23 +0300 (MSK)
Received: from iva4-c987840161f8.qloud-c.yandex.net (iva4-c987840161f8.qloud-c.yandex.net [2a02:6b8:c0c:3da5:0:640:c987:8401])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id OxwQY6knWm-iNfC0WqM;
        Tue, 15 Oct 2019 11:44:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1571129063; bh=lnvoJc4lckZwUKOSXQNoEHjcOj06ik4igfQkAd2qz8g=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=DM3eoiiMqJcpuZ+y4jQPKbbWGJ9bGSQ5DKMEDttIg8NHnKpADIHKjCcaNVo3tc4vl
         fMZMkPmweNVaA9QfJewcGe59pbXRA0Y4jNOn5H62Vy09VOozpZJ+PqjZ8hH8IgZwKB
         ftB3I3bMA1k1ijGsKBlDfouKloTp0/8ShoJxOKr4=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by iva4-c987840161f8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id xZbxjK3pt4-iNNeGGMI;
        Tue, 15 Oct 2019 11:44:23 +0300
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
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <3b73e301-ea4a-5edb-9360-2ae9b4ad9f69@yandex-team.ru>
Date:   Tue, 15 Oct 2019 11:44:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015082048.GU317@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 15/10/2019 11.20, Michal Hocko wrote:
> On Tue 15-10-19 11:09:59, Konstantin Khlebnikov wrote:
>> Mapped, dirty and writeback pages are also counted in per-lruvec stats.
>> These counters needs update when page is moved between cgroups.
> 
> Please describe the user visible effect.

Surprisingly I don't see any users at this moment.
So, there is no effect in mainline kernel.

>> Fixes: 00f3ca2c2d66 ("mm: memcontrol: per-lruvec stats infrastructure")
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> We want Cc: stable I suspect because broken stats might be really
> misleading.
> 
> The patch looks ok to me otherwise
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
>> ---
>>   mm/memcontrol.c |   18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index bdac56009a38..363106578876 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -5420,6 +5420,8 @@ static int mem_cgroup_move_account(struct page *page,
>>   				   struct mem_cgroup *from,
>>   				   struct mem_cgroup *to)
>>   {
>> +	struct lruvec *from_vec, *to_vec;
>> +	struct pglist_data *pgdat;
>>   	unsigned long flags;
>>   	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
>>   	int ret;
>> @@ -5443,11 +5445,15 @@ static int mem_cgroup_move_account(struct page *page,
>>   
>>   	anon = PageAnon(page);
>>   
>> +	pgdat = page_pgdat(page);
>> +	from_vec = mem_cgroup_lruvec(pgdat, from);
>> +	to_vec = mem_cgroup_lruvec(pgdat, to);
>> +
>>   	spin_lock_irqsave(&from->move_lock, flags);
>>   
>>   	if (!anon && page_mapped(page)) {
>> -		__mod_memcg_state(from, NR_FILE_MAPPED, -nr_pages);
>> -		__mod_memcg_state(to, NR_FILE_MAPPED, nr_pages);
>> +		__mod_lruvec_state(from_vec, NR_FILE_MAPPED, -nr_pages);
>> +		__mod_lruvec_state(to_vec, NR_FILE_MAPPED, nr_pages);
>>   	}
>>   
>>   	/*
>> @@ -5459,14 +5465,14 @@ static int mem_cgroup_move_account(struct page *page,
>>   		struct address_space *mapping = page_mapping(page);
>>   
>>   		if (mapping_cap_account_dirty(mapping)) {
>> -			__mod_memcg_state(from, NR_FILE_DIRTY, -nr_pages);
>> -			__mod_memcg_state(to, NR_FILE_DIRTY, nr_pages);
>> +			__mod_lruvec_state(from_vec, NR_FILE_DIRTY, -nr_pages);
>> +			__mod_lruvec_state(to_vec, NR_FILE_DIRTY, nr_pages);
>>   		}
>>   	}
>>   
>>   	if (PageWriteback(page)) {
>> -		__mod_memcg_state(from, NR_WRITEBACK, -nr_pages);
>> -		__mod_memcg_state(to, NR_WRITEBACK, nr_pages);
>> +		__mod_lruvec_state(from_vec, NR_WRITEBACK, -nr_pages);
>> +		__mod_lruvec_state(to_vec, NR_WRITEBACK, nr_pages);
>>   	}
>>   
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> 
