Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0792A3A87
	for <lists+cgroups@lfdr.de>; Tue,  3 Nov 2020 03:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgKCCpq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Nov 2020 21:45:46 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:42240 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725968AbgKCCpp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Nov 2020 21:45:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0UE2a0gk_1604371541;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UE2a0gk_1604371541)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Nov 2020 10:45:41 +0800
Subject: Re: [PATCH v20 04/20] mm/thp: use head for head page in
 lru_add_page_tail
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-5-git-send-email-alex.shi@linux.alibaba.com>
 <20201029135047.GE599825@cmpxchg.org>
 <06a5b7d8-bbf2-51b7-1352-2b630186e15f@linux.alibaba.com>
 <20201102160357.GP27442@casper.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <374a5d13-e5d2-9f5e-0185-5b0f2a613fa6@linux.alibaba.com>
Date:   Tue, 3 Nov 2020 10:43:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201102160357.GP27442@casper.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/11/3 ÉÏÎç12:03, Matthew Wilcox Ð´µÀ:
> On Fri, Oct 30, 2020 at 10:46:54AM +0800, Alex Shi wrote:
>> -static void lru_add_page_tail(struct page *page, struct page *page_tail,
>> +static void lru_add_page_tail(struct page *head, struct page *tail,
>>  		struct lruvec *lruvec, struct list_head *list)
>>  {
>> -	VM_BUG_ON_PAGE(!PageHead(page), page);
>> -	VM_BUG_ON_PAGE(PageCompound(page_tail), page);
>> -	VM_BUG_ON_PAGE(PageLRU(page_tail), page);
>> +	VM_BUG_ON_PAGE(!PageHead(head), head);
>> +	VM_BUG_ON_PAGE(PageCompound(tail), head);
>> +	VM_BUG_ON_PAGE(PageLRU(tail), head);
> 
> These last two should surely have been
> 	VM_BUG_ON_PAGE(PageCompound(tail), tail);
> 	VM_BUG_ON_PAGE(PageLRU(tail), tail);
> 
> Also, what do people think about converting these to VM_BUG_ON_PGFLAGS?

Hi Matthew,

Thanks for reminder! Looks these changes worth for another patch.

> 
> Either way:
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 


I will take this option this time. :)

Thanks!
Alex
