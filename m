Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E362316EF
	for <lists+cgroups@lfdr.de>; Wed, 29 Jul 2020 02:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbgG2AsU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jul 2020 20:48:20 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:36814 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730837AbgG2AsT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jul 2020 20:48:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U45v0Du_1595983694;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U45v0Du_1595983694)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Jul 2020 08:48:14 +0800
Subject: Re: [PATCH v17 17/21] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-18-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UdaW4Rf43yULhQBuP07vQgmoPbaWHGKv1Z7fEPP6jH83w@mail.gmail.com>
 <1fd45e69-3a50-aae8-bcc4-47d891a5e263@linux.alibaba.com>
 <CAKgT0UfWckn0npij5UhEEmMKuG0bRytN3kPDtvvE3AdJuEZjJg@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <cb49a573-8d24-d289-199d-8058cd79b89b@linux.alibaba.com>
Date:   Wed, 29 Jul 2020 08:48:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfWckn0npij5UhEEmMKuG0bRytN3kPDtvvE3AdJuEZjJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/28 下午11:55, Alexander Duyck 写道:
>>  /*
>> @@ -511,11 +511,11 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
>>   *             scheduled)
>>   */
>>  static bool compact_unlock_should_abort(spinlock_t *lock,
>> -               unsigned long flags, bool *locked, struct compact_control *cc)
>> +               unsigned long flags, void **locked, struct compact_control *cc)
> Instead of passing both a void pointer and the lock why not just pass
> the pointer to the lock pointer? You could combine lock and locked
> into a single argument and save yourself some extra effort.
> 

the passed locked pointer could be rewrite in the func, that is unacceptable if it is a lock which could
be used other place.

And it is alreay dangerous to NULL a local pointer. In fact, I perfer the orignal verion, not so smart
but rebust enough for future changes, right?

Thanks
Alex


>>  {
>>         if (*locked) {
>>                 spin_unlock_irqrestore(lock, flags);
>> -               *locked = false;
>> +               *locked = NULL;
>>         }
>>
>>         if (fatal_signal_pending(current)) {
