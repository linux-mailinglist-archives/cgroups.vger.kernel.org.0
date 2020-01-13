Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDCB2138E4A
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2020 10:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgAMJ4F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jan 2020 04:56:05 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:38272 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgAMJ4E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jan 2020 04:56:04 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 76AB82E0B1E;
        Mon, 13 Jan 2020 12:56:01 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 2kBEcgvne1-u0Luud4o;
        Mon, 13 Jan 2020 12:56:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1578909361; bh=tfWEf85Tg93V8jfj/kRU8NVn5c39kp85P+atbWGt+tM=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=XmwXyts9sUV12nUE4N1YSxf4tvNZDuR2Ax8TvGvRhsh26jDwzbTHtJ99/Mlp6VqtB
         /AYBkrEzUXcCxSzePb6NELBf292iLyFGmNdmZlMZGMCS1/0JVKkw2VGFtnDeFj+HEA
         Vxi2Izzl7c6DKKT3UT00eui5YKjhKoMkMkTm2wwY=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 6iOpZA3Dpj-txX0Y9uN;
        Mon, 13 Jan 2020 12:56:00 +0300
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
 <36d7e390-a3d1-908c-d181-4a9e9c8d3d98@yandex-team.ru>
 <952d02c2-8aa5-40bb-88bb-c43dee65c8bc@linux.alibaba.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <2ba8a04e-d8e0-1d50-addc-dbe1b4d8e0f1@yandex-team.ru>
Date:   Mon, 13 Jan 2020 12:55:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <952d02c2-8aa5-40bb-88bb-c43dee65c8bc@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 13/01/2020 12.45, Alex Shi wrote:
> 
> 
> 在 2020/1/10 下午4:49, Konstantin Khlebnikov 写道:
>> On 25/12/2019 12.04, Alex Shi wrote:
>>>   From the commit_charge's explanations and mem_cgroup_commit_charge
>>> comments, as well as call path when lrucare is ture, The lru_lock is
>>> just to guard the task migration(which would be lead to move_account)
>>> So it isn't needed when !PageLRU, and better be fold into PageLRU to
>>> reduce lock contentions.
>>>
>>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: Michal Hocko <mhocko@kernel.org>
>>> Cc: Matthew Wilcox <willy@infradead.org>
>>> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: cgroups@vger.kernel.org
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>    mm/memcontrol.c | 9 ++++-----
>>>    1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index c5b5f74cfd4d..0ad10caabc3d 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -2572,12 +2572,11 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>>>      static void lock_page_lru(struct page *page, int *isolated)
>>>    {
>>> -    pg_data_t *pgdat = page_pgdat(page);
>>> -
>>> -    spin_lock_irq(&pgdat->lru_lock);
>>>        if (PageLRU(page)) {
>>> +        pg_data_t *pgdat = page_pgdat(page);
>>>            struct lruvec *lruvec;
>>>    +        spin_lock_irq(&pgdat->lru_lock);
>>
>> That's wrong. Here PageLRU must be checked again under lru_lock.
> Hi, Konstantin,
> 
> For logical remain, we can get the lock and then release for !PageLRU.
> but I still can figure out the problem scenario. Would like to give more hints?

That's trivial race: page could be isolated from lru between

if (PageLRU(page))
and
spin_lock_irq(&pgdat->lru_lock);

> 
> 
>>
>>
>> Also I don't like these functions:
>> - called lock/unlock but actually also isolates
>> - used just once
>> - pgdat evaluated twice
> 
> That's right. I will fold these functions into commit_charge.
> 
> Thanks
> Alex
> 
