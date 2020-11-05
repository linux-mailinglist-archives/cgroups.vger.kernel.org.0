Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC222A76CB
	for <lists+cgroups@lfdr.de>; Thu,  5 Nov 2020 06:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725275AbgKEFH7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Nov 2020 00:07:59 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:52787 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730740AbgKEFH7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Nov 2020 00:07:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0UEHX1wb_1604552873;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEHX1wb_1604552873)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Nov 2020 13:07:53 +0800
Subject: Re: [PATCH v20 00/20] per memcg lru lock
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <811216d4-4972-4721-d6b9-1028c02f4290@linux.alibaba.com>
 <20201104165935.GA744831@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <59f37649-0530-e2d8-c2e3-ecb70871ffb4@linux.alibaba.com>
Date:   Thu, 5 Nov 2020 13:07:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201104165935.GA744831@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/11/5 ÉÏÎç12:59, Johannes Weiner Ð´µÀ:
> On Wed, Nov 04, 2020 at 07:55:39PM +0800, Alex Shi wrote:
>> @@ -1380,6 +1383,14 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
>>         return lruvec;
>>  }
>>
>> +/**
>> + * lock_page_lruvec - return lruvec for the locked page.
> 
> I would say "lock and return the lruvec for a given page"
> 
>> + * @page: the page
>> + *
>> + * This series functions should be used in either conditions:
>> + * PageLRU is cleared or unset
>> + * or, page->_refcount is zero
> 
> or page is locked
> 
> The other changes look good to me, thanks!
> 

Thanks a lot for both comments!
I will pick them and sent out in v21.

Thanks!
Alex
