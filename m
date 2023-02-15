Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D330697314
	for <lists+cgroups@lfdr.de>; Wed, 15 Feb 2023 02:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBOBGx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Feb 2023 20:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjBOBGw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Feb 2023 20:06:52 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F182D25BA3;
        Tue, 14 Feb 2023 17:06:49 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0Vbhgqjj_1676423204;
Received: from 30.97.48.50(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vbhgqjj_1676423204)
          by smtp.aliyun-inc.com;
          Wed, 15 Feb 2023 09:06:45 +0800
Message-ID: <76f1e8d2-1ef0-4317-061b-c7de33f20626@linux.alibaba.com>
Date:   Wed, 15 Feb 2023 09:06:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 3/4] mm: hugetlb: change to return bool for
 isolate_hugetlb()
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev,
        naoya.horiguchi@nec.com, linmiaohe@huawei.com, david@redhat.com,
        osalvador@suse.de, willy@infradead.org, damon@lists.linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230214180324.71585-1-sj@kernel.org>
 <20230214180708.71645-1-sj@kernel.org> <Y+vRK7kYP0xVZ9Ya@monkey>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Y+vRK7kYP0xVZ9Ya@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/15/2023 2:21 AM, Mike Kravetz wrote:
> On 02/14/23 18:07, SeongJae Park wrote:
>> On Tue, 14 Feb 2023 18:03:24 +0000 SeongJae Park <sj@kernel.org> wrote:
>>
>>> On Tue, 14 Feb 2023 21:59:31 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>> Now the isolate_hugetlb() only returns 0 or -EBUSY, and most users did not
>>>> care about the negative value, thus we can convert the isolate_hugetlb()
>>>> to return a boolean value to make code more clear when checking the
>>>> hugetlb isolation state. Moreover converts 2 users which will consider
>>>> the negative value returned by isolate_hugetlb().
>>>>
>>>> No functional changes intended.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>>   include/linux/hugetlb.h |  6 +++---
>>>>   mm/hugetlb.c            | 12 ++++++++----
>>>>   mm/memory-failure.c     |  2 +-
>>>>   mm/mempolicy.c          |  2 +-
>>>>   mm/migrate.c            |  2 +-
>>>>   5 files changed, 14 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>>> index df6dd624ccfe..5f5e4177b2e0 100644
>> [...]
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index 53010a142e7f..c5136fa48638 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -2128,7 +2128,7 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>>>>   		if (PageHead(page)) {
>>>>   			err = isolate_hugetlb(page_folio(page), pagelist);
>>>>   			if (!err)
>>>> -				err = 1;
>>>> +				err = -EBUSY;
>>>
>>> Again, I think this is confusing.  'err' is 'bool', not 'int'.
>>
>> I mean, 'err' is not 'bool' but 'int', sorry.  See? This confuses me ;)
>>
> 
> Yes,
> in the case here (and elsewhere) I like David's suggestion of using a separate
> bool such as 'isolated' to capture the return value of the isolate function.
> Then, the statement:
> 
> 	err = isolated ? 0 : -EBUSY;
> 
> would be pretty clear.

Yes, much better, will do. Thanks.
