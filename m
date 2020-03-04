Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C408178CD8
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 09:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbgCDIv6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 03:51:58 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:55439 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387688AbgCDIvz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 03:51:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TrctV1W_1583311905;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrctV1W_1583311905)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Mar 2020 16:51:45 +0800
Subject: Re: [PATCH v9 06/20] mm/thp: narrow lru locking
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
 <1583146830-169516-7-git-send-email-alex.shi@linux.alibaba.com>
 <20200304080248.wuj3vqlz46ehhptg@box>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <23cc4433-fe81-ec31-9281-3c9e8df5643b@linux.alibaba.com>
Date:   Wed, 4 Mar 2020 16:51:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304080248.wuj3vqlz46ehhptg@box>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/3/4 ÏÂÎç4:02, Kirill A. Shutemov Ð´µÀ:
> On Mon, Mar 02, 2020 at 07:00:16PM +0800, Alex Shi wrote:
>> @@ -2564,6 +2565,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>  		xa_lock(&swap_cache->i_pages);
>>  	}
>>  
>> +	/* Lru list would be changed, don't care head's LRU bit. */
>> +	spin_lock_irqsave(&pgdat->lru_lock, flags);
>> +
>>  	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
>>  		__split_huge_page_tail(head, i, lruvec, list);
>>  		/* Some pages can be beyond i_size: drop them from page cache */
> 
> You change locking order WRT i_pages lock. Is it safe?
> 

Thanks Kirill,

I think so. and lock_dep/proving has no complain.

Any problem addressed?

Alex
