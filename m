Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAB4274ED1
	for <lists+cgroups@lfdr.de>; Wed, 23 Sep 2020 04:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgIWCBJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 22:01:09 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:48751 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727045AbgIWCBJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Sep 2020 22:01:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0U9oxvFx_1600826462;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U9oxvFx_1600826462)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Sep 2020 10:01:04 +0800
Subject: Re: [PATCH v18 25/32] mm/mlock: remove lru_lock on
 TestClearPageMlocked in munlock_vma_page
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598273705-69124-26-git-send-email-alex.shi@linux.alibaba.com>
 <alpine.LSU.2.11.2009212253320.6434@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <289ad388-d91a-92f5-b29c-030b666a74ee@linux.alibaba.com>
Date:   Wed, 23 Sep 2020 09:58:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2009212253320.6434@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/9/22 ÏÂÎç2:13, Hugh Dickins Ð´µÀ:
> On Mon, 24 Aug 2020, Alex Shi wrote:
> 
>> In the func munlock_vma_page, the page must be PageLocked as well as
>> pages in split_huge_page series funcs. Thus the PageLocked is enough
>> to serialize both funcs.
>>
>> So we could relief the TestClearPageMlocked/hpage_nr_pages which are not
>> necessary under lru lock.
>>
>> As to another munlock func __munlock_pagevec, which no PageLocked
>> protection and should remain lru protecting.
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> I made some comments on the mlock+munlock situation last week:
> I won't review this 24/32 and 25/32 now, but will take a look
> at your github tree tomorrow instead.  Perhaps I'll find you have
> already done the fixes, perhaps I'll find you have merged these back
> into earlier patches.  And I won't be reviewing beyond this point:
> this is enough for now, I think.
> 

Yes, these 2 patches was fixed as your suggested on 
https://github.com/alexshi/linux.git lruv19.5 

83f8582dcd5a mm/mlock: remove lru_lock on TestClearPageMlocked
20836d10f0ed mm/mlock: remove __munlock_isolate_lru_page

Thanks!
Alex
