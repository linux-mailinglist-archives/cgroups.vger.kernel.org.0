Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC172A3AD1
	for <lists+cgroups@lfdr.de>; Tue,  3 Nov 2020 04:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgKCDEz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Nov 2020 22:04:55 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:54223 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbgKCDEz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Nov 2020 22:04:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0UE2aS-g_1604372689;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UE2aS-g_1604372689)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Nov 2020 11:04:49 +0800
Subject: Re: [PATCH v20 15/20] mm/lru: introduce TestClearPageLRU
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, Michal Hocko <mhocko@kernel.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-16-git-send-email-alex.shi@linux.alibaba.com>
 <20201102151008.GH724984@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <ae59cae4-48f4-a7e9-044a-86790e16e641@linux.alibaba.com>
Date:   Tue, 3 Nov 2020 11:02:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201102151008.GH724984@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/11/2 ÏÂÎç11:10, Johannes Weiner Ð´µÀ:
> On Thu, Oct 29, 2020 at 06:45:00PM +0800, Alex Shi wrote:
>> Currently lru_lock still guards both lru list and page's lru bit, that's
>> ok. but if we want to use specific lruvec lock on the page, we need to
>> pin down the page's lruvec/memcg during locking. Just taking lruvec
>> lock first may be undermined by the page's memcg charge/migration. To
>> fix this problem, we could clear the lru bit out of locking and use
>> it as pin down action to block the page isolation in memcg changing.
> 
> Small nit, but the use of "could" in this sentence sounds like you're
> describing one possible solution that isn't being taken, when in fact
> you are describing the chosen locking mechanism.
> 
> Replacing "could" with "will" would make things a bit clearer IMO.
> 

Yes, 'will' is better here. Thanks!

>> So now a standard steps of page isolation is following:
>> 	1, get_page(); 	       #pin the page avoid to be free
>> 	2, TestClearPageLRU(); #block other isolation like memcg change
>> 	3, spin_lock on lru_lock; #serialize lru list access
>> 	4, delete page from lru list;
>> The step 2 could be optimzed/replaced in scenarios which page is
>> unlikely be accessed or be moved between memcgs.
> 
> This is a bit ominous. I'd either elaborate / provide an example /
> clarify why some sites can deal with races - or just remove that
> sentence altogether from this part of the changelog.
> 

A few scenarios here, so examples looks verbose or cann't describe whole.
Maybe removing above 2 lines "The step 2 could be optimzed/replaced in 
scenarios which page is unlikely be accessed or be moved between memcgs."
is better. 

Thanks!

>> This patch start with the first part: TestClearPageLRU, which combines
>> PageLRU check and ClearPageLRU into a macro func TestClearPageLRU. This
>> function will be used as page isolation precondition to prevent other
>> isolations some where else. Then there are may !PageLRU page on lru
>> list, need to remove BUG() checking accordingly.
>>
>> There 2 rules for lru bit now:
>> 1, the lru bit still indicate if a page on lru list, just in some
>>    temporary moment(isolating), the page may have no lru bit when
>>    it's on lru list.  but the page still must be on lru list when the
>>    lru bit set.
>> 2, have to remove lru bit before delete it from lru list.
>>
>> As Andrew Morton mentioned this change would dirty cacheline for page
>> isn't on LRU. But the lost would be acceptable in Rong Chen
>> <rong.a.chen@intel.com> report:
>> https://lore.kernel.org/lkml/20200304090301.GB5972@shao2-debian/
>>
>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Acked-by: Hugh Dickins <hughd@google.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: cgroups@vger.kernel.org
>> Cc: linux-mm@kvack.org
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 

Thanks!
Alex
