Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F2B241B1A
	for <lists+cgroups@lfdr.de>; Tue, 11 Aug 2020 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgHKMnF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Aug 2020 08:43:05 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:52603 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726829AbgHKMnE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Aug 2020 08:43:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U5TNqJ4_1597149777;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U5TNqJ4_1597149777)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 Aug 2020 20:42:58 +0800
Subject: Re: [Resend PATCH 2/6] mm/memcg: remove useless check on
 page->mem_cgroup
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com>
 <1597144232-11370-2-git-send-email-alex.shi@linux.alibaba.com>
 <20200811113008.GK4793@dhcp22.suse.cz>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <a1da796f-e42a-aaac-58e2-8b352fde4dc2@linux.alibaba.com>
Date:   Tue, 11 Aug 2020 20:42:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200811113008.GK4793@dhcp22.suse.cz>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/8/11 ÏÂÎç7:30, Michal Hocko Ð´µÀ:
> subject line looks like a left over. It doesn't match the path. Did you
> mean
> memcg: bail out early from swap accounting when memcg is disabled?

It's much better, Thanks for correction!

> 
> Btw. if this patch was first in the series then you wouldn't need to
> mention the warnings that would trigger based on your previous patch.
> I am fine with both ways but mentioning the warning is usefule.

Right. but the patch is very simple,  w/o warning message doesn't cuase trouble.
So, removing the 'and keep WARN_ON monitor' make sense too.

Do I need a resend for the commit log change?

Thanks a lot!
Alex

> 
> On Tue 11-08-20 19:10:28, Alex Shi wrote:
>> If we disabled memcg by cgroup_disable=memory, the swap charges are
>> still called. Let's return from the funcs earlier and keep WARN_ON
>> monitor.
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Reviewed-by: Roman Gushchin <guro@fb.com>
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: cgroups@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  mm/memcontrol.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 299382fc55a9..419cf565f40b 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -7098,6 +7098,9 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>>  	VM_BUG_ON_PAGE(page_count(page), page);
>>  
>> +	if (mem_cgroup_disabled())
>> +		return;
>> +
>>  	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>>  		return;
>>  
>> @@ -7163,6 +7166,9 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
>>  	struct mem_cgroup *memcg;
>>  	unsigned short oldid;
>>  
>> +	if (mem_cgroup_disabled())
>> +		return 0;
>> +
>>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>>  		return 0;
>>  
>> -- 
>> 1.8.3.1
> 
