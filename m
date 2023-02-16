Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E42A698A55
	for <lists+cgroups@lfdr.de>; Thu, 16 Feb 2023 03:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjBPCHN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Feb 2023 21:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjBPCHL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Feb 2023 21:07:11 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466EC2A6FA;
        Wed, 15 Feb 2023 18:07:10 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VbmFOuB_1676513225;
Received: from 30.97.48.85(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VbmFOuB_1676513225)
          by smtp.aliyun-inc.com;
          Thu, 16 Feb 2023 10:07:06 +0800
Message-ID: <baf51a97-0d28-119a-691a-e3ecb799d806@linux.alibaba.com>
Date:   Thu, 16 Feb 2023 10:07:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 4/4] mm: change to return bool for
 isolate_movable_page()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        sj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
        mike.kravetz@oracle.com, damon@lists.linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
 <cb877f73f4fff8d309611082ec740a7065b1ade0.1676424378.git.baolin.wang@linux.alibaba.com>
 <Y+z91pcxAuygc92J@casper.infradead.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Y+z91pcxAuygc92J@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/15/2023 11:44 PM, Matthew Wilcox wrote:
> On Wed, Feb 15, 2023 at 06:39:37PM +0800, Baolin Wang wrote:
>> Now the isolate_movable_page() can only return 0 or -EBUSY, and no users
>> will care about the negative return value, thus we can convert the
>> isolate_movable_page() to return a boolean value to make the code more
>> clear when checking the movable page isolation state.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> A couple of nits below, not worth respinning the patch series for:
> 
>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>> index c88b96b48be7..6b252f519c86 100644
>> --- a/include/linux/migrate.h
>> +++ b/include/linux/migrate.h
>> @@ -71,7 +71,7 @@ extern int migrate_pages(struct list_head *l, new_page_t new, free_page_t free,
>>   		unsigned long private, enum migrate_mode mode, int reason,
>>   		unsigned int *ret_succeeded);
>>   extern struct page *alloc_migration_target(struct page *page, unsigned long private);
>> -extern int isolate_movable_page(struct page *page, isolate_mode_t mode);
>> +extern bool isolate_movable_page(struct page *page, isolate_mode_t mode);
> 
> You can drop the 'extern' here.
> 
>> +++ b/mm/memory_hotplug.c
>> @@ -1668,18 +1668,18 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>>   		 * We can skip free pages. And we can deal with pages on
>>   		 * LRU and non-lru movable pages.
>>   		 */
>> -		if (PageLRU(page)) {
>> +		if (PageLRU(page))
>>   			isolated = isolate_lru_page(page);
>> -			ret = isolated ? 0 : -EBUSY;
>> -		} else
>> -			ret = isolate_movable_page(page, ISOLATE_UNEVICTABLE);
>> -		if (!ret) { /* Success */
>> +		else
>> +			isolated = isolate_movable_page(page, ISOLATE_UNEVICTABLE);
>> +		if (isolated) { /* Success */
> 
> I would have dropped the "/* Success */" here.  Before, commenting
> "!ret" is quite sensible, but "isolated" seems obviously success to me.

Right. Hope Andrew can help to drop this unnecessary comment:)

Thanks for reviewing.
