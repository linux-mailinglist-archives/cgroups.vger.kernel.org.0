Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8439B1038FB
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2019 12:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfKTLmu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Nov 2019 06:42:50 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:56241 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728343AbfKTLmu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Nov 2019 06:42:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Tie.HNt_1574250166;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tie.HNt_1574250166)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Nov 2019 19:42:47 +0800
Subject: Re: [PATCH v4 1/9] mm/swap: fix uninitialized compiler warning
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
 <1574166203-151975-2-git-send-email-alex.shi@linux.alibaba.com>
 <20191119154138.GB382712@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <919a5a57-1b7a-b109-491f-2b8b099390fe@linux.alibaba.com>
Date:   Wed, 20 Nov 2019 19:42:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191119154138.GB382712@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2019/11/19 下午11:41, Johannes Weiner 写道:
> On Tue, Nov 19, 2019 at 08:23:15PM +0800, Alex Shi wrote:
>>   ../mm/swap.c: In function ‘__page_cache_release’:
>>   ../mm/swap.c:67:10: warning: ‘flags’ may be used uninitialized in this
>>   function [-Wmaybe-uninitialized]
>>        lruvec = lock_page_lruvec_irqsave(page, pgdat, flags);
>>        ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> At this point in the series, there is no lock_page_lruvec_irqsave()
> yet, so this patch is out of order. Please don't do that. It's very
> hard to review patches that depend on later changes to make sense.
> 

Sorry, I will be more careful on this.

>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  mm/swap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/swap.c b/mm/swap.c
>> index 5341ae93861f..c36a10244d07 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -62,7 +62,7 @@ static void __page_cache_release(struct page *page)
>>  	if (PageLRU(page)) {
>>  		pg_data_t *pgdat = page_pgdat(page);
>>  		struct lruvec *lruvec;
>> -		unsigned long flags;
>> +		unsigned long flags = 0;
> Use unintialized_var() for these cases to make the intent clear.

Thanks for suggestion!
