Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFA02E059C
	for <lists+cgroups@lfdr.de>; Tue, 22 Dec 2020 06:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgLVFXw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Dec 2020 00:23:52 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:57898 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725818AbgLVFXw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Dec 2020 00:23:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UJPXZ7P_1608614586;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UJPXZ7P_1608614586)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Dec 2020 13:23:06 +0800
Subject: Re: [PATCH 1/3] mm/memcg: revise the using condition of
 lock_page_lruvec function series
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1608186532-81218-1-git-send-email-alex.shi@linux.alibaba.com>
 <alpine.LSU.2.11.2012211827560.1045@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <be915778-2f0e-17a3-c44e-889bda0bc12d@linux.alibaba.com>
Date:   Tue, 22 Dec 2020 13:23:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2012211827560.1045@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/12/22 ÉÏÎç11:01, Hugh Dickins Ð´µÀ:
> On Thu, 17 Dec 2020, Alex Shi wrote:
> 
>> The series function could be used under lock_page_memcg(), add this and
>> a bit style changes following commit_charge().
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Cc: Hugh Dickins <hughd@google.com>
> 
> This patch, or its intention,
> Acked-by: Hugh Dickins <hughd@google.com>
> but rewording suggested below, and requested above -
> which left me very puzzled before eventually I understood it.
> I don't think we need to talk about "a bit style changes",
> but the cross-reference to commit_charge() is helpful.
> 
> "
> lock_page_lruvec() and its variants are safe to use under the same
> conditions as commit_charge(): add lock_page_memcg() to the comment.
> "

Thanks a lot, Hugh. Yes, your commit log are far more better than mine. :)

I will resent with your changes and Ack.

Thanks!
Alex

> 
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: cgroups@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  mm/memcontrol.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index b80328f52fb4..e6b50d068b2f 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1345,10 +1345,11 @@ void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
>>   * lock_page_lruvec - lock and return lruvec for a given page.
>>   * @page: the page
>>   *
>> - * This series functions should be used in either conditions:
>> - * PageLRU is cleared or unset
>> - * or page->_refcount is zero
>> - * or page is locked.
>> + * This series functions should be used in any one of following conditions:
> 
> These functions are safe to use under any of the following conditions:
> 
>> + * - PageLRU is cleared or unset
>> + * - page->_refcount is zero
>> + * - page is locked.
> 
> Remove that full stop...
> 
>> + * - lock_page_memcg()
> 
> ... and, if you wish (I don't care), add full stop at the end of that line.
> 
> Maybe reorder those to the same order as listed in commit_charge().
> Copy its text exactly? I don't think so, actually, I find your wording
> (e.g. _refcount is zero) more explicit: good to have both descriptions.
> 
>>   */
>>  struct lruvec *lock_page_lruvec(struct page *page)
>>  {
>> -- 
>> 2.29.GIT
