Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5060E138E20
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2020 10:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgAMJrY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jan 2020 04:47:24 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:35470 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgAMJrX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jan 2020 04:47:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TncLfyC_1578908838;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TncLfyC_1578908838)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 Jan 2020 17:47:19 +0800
Subject: Re: [PATCH v7 02/10] mm/memcg: fold lru_lock in lock_page_lru
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, shakeelb@google.com, hannes@cmpxchg.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
 <1577264666-246071-3-git-send-email-alex.shi@linux.alibaba.com>
 <36d7e390-a3d1-908c-d181-4a9e9c8d3d98@yandex-team.ru>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <952d02c2-8aa5-40bb-88bb-c43dee65c8bc@linux.alibaba.com>
Date:   Mon, 13 Jan 2020 17:45:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <36d7e390-a3d1-908c-d181-4a9e9c8d3d98@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/1/10 下午4:49, Konstantin Khlebnikov 写道:
> On 25/12/2019 12.04, Alex Shi wrote:
>>  From the commit_charge's explanations and mem_cgroup_commit_charge
>> comments, as well as call path when lrucare is ture, The lru_lock is
>> just to guard the task migration(which would be lead to move_account)
>> So it isn't needed when !PageLRU, and better be fold into PageLRU to
>> reduce lock contentions.
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: cgroups@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   mm/memcontrol.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index c5b5f74cfd4d..0ad10caabc3d 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2572,12 +2572,11 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>>     static void lock_page_lru(struct page *page, int *isolated)
>>   {
>> -    pg_data_t *pgdat = page_pgdat(page);
>> -
>> -    spin_lock_irq(&pgdat->lru_lock);
>>       if (PageLRU(page)) {
>> +        pg_data_t *pgdat = page_pgdat(page);
>>           struct lruvec *lruvec;
>>   +        spin_lock_irq(&pgdat->lru_lock);
> 
> That's wrong. Here PageLRU must be checked again under lru_lock.
Hi, Konstantin,

For logical remain, we can get the lock and then release for !PageLRU. 
but I still can figure out the problem scenario. Would like to give more hints?


> 
> 
> Also I don't like these functions:
> - called lock/unlock but actually also isolates
> - used just once
> - pgdat evaluated twice

That's right. I will fold these functions into commit_charge.

Thanks
Alex
