Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F6F96267
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2019 16:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfHTO11 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Aug 2019 10:27:27 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:44765 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728770AbfHTO11 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Aug 2019 10:27:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0Ta-z0CR_1566310900;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Ta-z0CR_1566310900)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Aug 2019 22:21:42 +0800
Subject: Re: [PATCH 14/14] mm/lru: fix the comments of lru_lock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Arun KS <arunks@codeaurora.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
 <1566294517-86418-15-git-send-email-alex.shi@linux.alibaba.com>
 <20190820140019.GB24642@bombadil.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <bf8be185-e757-cf05-999d-56bfb83f1bc9@linux.alibaba.com>
Date:   Tue, 20 Aug 2019 22:21:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820140019.GB24642@bombadil.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2019/8/20 ÏÂÎç10:00, Matthew Wilcox Ð´µÀ:
> On Tue, Aug 20, 2019 at 05:48:37PM +0800, Alex Shi wrote:
>> @@ -159,7 +159,7 @@ static inline bool free_area_empty(struct free_area *area, int migratetype)
>>  struct pglist_data;
>>  
>>  /*
>> - * zone->lock and the zone lru_lock are two of the hottest locks in the kernel.
>> + * zone->lock and the lru_lock are two of the hottest locks in the kernel.
>>   * So add a wild amount of padding here to ensure that they fall into separate
>>   * cachelines.  There are very few zone structures in the machine, so space
>>   * consumption is not a concern here.
> 
> But after this patch series, the lru lock is no longer stored in the zone.
> So this comment makes no sense.

Yes, It's need reconsider here. thanks for opoint out.

> 
>> @@ -295,7 +295,7 @@ struct zone_reclaim_stat {
>>  
>>  struct lruvec {
>>  	struct list_head		lists[NR_LRU_LISTS];
>> -	/* move lru_lock to per lruvec for memcg */
>> +	/* perf lruvec lru_lock for memcg */
> 
> What does the word 'perf' mean here?

sorry for typo, could be s/perf/per/ here.

Thanks
Alex

 
