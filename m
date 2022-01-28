Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683B64A02A2
	for <lists+cgroups@lfdr.de>; Fri, 28 Jan 2022 22:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243744AbiA1VXG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jan 2022 16:23:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350649AbiA1VXF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jan 2022 16:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643404984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hvrb/vy89ZNYuwBLWpFtg9jTrt+DtAEe9H5nZb7p2Ts=;
        b=VzQ3b7NRl6OI4Cpdd3X0R4fqzEZ0lNe0gwolQQghmPE1J/tibKEDk2gF1MOyUHmcDsxGLT
        YO+zs6H4coWrp2iVi7U1k1We2kRHPQqGhqZ4BXKuY0//maYCBUnCi190dVIj6fEoewpCQB
        HcyhSvyvnpx6PJnDz6qRPMeXVnvTm8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-8F_YfrERNuiFEiWvU914Kg-1; Fri, 28 Jan 2022 16:22:59 -0500
X-MC-Unique: 8F_YfrERNuiFEiWvU914Kg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32C901006AA8;
        Fri, 28 Jan 2022 21:22:57 +0000 (UTC)
Received: from [10.22.33.1] (unknown [10.22.33.1])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F01564E2A1;
        Fri, 28 Jan 2022 21:22:55 +0000 (UTC)
Message-ID: <2b68eb66-db17-a8a2-2a07-48b8584da841@redhat.com>
Date:   Fri, 28 Jan 2022 16:22:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] mm/page_owner: Introduce SNPRINTF() macro that
 includes length error check
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Rafael Aquini <aquini@redhat.com>
References: <20220128195642.416743-1-longman@redhat.com>
 <20220128195642.416743-2-longman@redhat.com>
 <20220128211848.GH785175@iweiny-DESK2.sc.intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220128211848.GH785175@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 1/28/22 16:18, Ira Weiny wrote:
> On Fri, Jan 28, 2022 at 02:56:41PM -0500, Waiman Long wrote:
>> In print_page_owner(), there is a repetitive check after each snprintf()
>> to make sure that the final length is less than the buffer size. Simplify
>> the code and make it easier to read by embedding the buffer length
>> check and increment inside the macro.
> This does not follow the kernel coding style of not putting control flow
> statements in macros.[1]

OK, fair enough. I can remove the macro and repost the patch.

Cheers,
Longman

>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/page_owner.c | 50 +++++++++++++++++++++++--------------------------
>>   1 file changed, 23 insertions(+), 27 deletions(-)
> And in the end you only saved 4 lines of code to read...  Not worth it IMO.
>
> Ira
>
> [1] https://www.kernel.org/doc/html/v4.17/process/coding-style.html
>
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index 99e360df9465..c52ce9d6bc3b 100644
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
>> @@ -325,12 +325,20 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>>   	seq_putc(m, '\n');
>>   }
>>   
>> +#define SNPRINTF(_buf, _size, _len, _err, _fmt, ...)			\
>> +	do {								\
>> +		_len += snprintf(_buf + _len, _size - _len, _fmt,	\
>> +				 ##__VA_ARGS__);			\
>> +		if (_len >= _size)					\
>> +			goto _err;					\
>> +	} while (0)
>> +
>>   static ssize_t
>>   print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>>   		struct page *page, struct page_owner *page_owner,
>>   		depot_stack_handle_t handle)
>>   {
>> -	int ret, pageblock_mt, page_mt;
>> +	int ret = 0, pageblock_mt, page_mt;
>>   	char *kbuf;
>>   
>>   	count = min_t(size_t, count, PAGE_SIZE);
>> @@ -338,44 +346,32 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>>   	if (!kbuf)
>>   		return -ENOMEM;
>>   
>> -	ret = snprintf(kbuf, count,
>> -			"Page allocated via order %u, mask %#x(%pGg), pid %d, ts %llu ns, free_ts %llu ns\n",
>> -			page_owner->order, page_owner->gfp_mask,
>> -			&page_owner->gfp_mask, page_owner->pid,
>> -			page_owner->ts_nsec, page_owner->free_ts_nsec);
>> -
>> -	if (ret >= count)
>> -		goto err;
>> +	SNPRINTF(kbuf, count, ret, err,
>> +		"Page allocated via order %u, mask %#x(%pGg), pid %d, ts %llu ns, free_ts %llu ns\n",
>> +		page_owner->order, page_owner->gfp_mask,
>> +		&page_owner->gfp_mask, page_owner->pid,
>> +		page_owner->ts_nsec, page_owner->free_ts_nsec);
>>   
>>   	/* Print information relevant to grouping pages by mobility */
>>   	pageblock_mt = get_pageblock_migratetype(page);
>>   	page_mt  = gfp_migratetype(page_owner->gfp_mask);
>> -	ret += snprintf(kbuf + ret, count - ret,
>> -			"PFN %lu type %s Block %lu type %s Flags %pGp\n",
>> -			pfn,
>> -			migratetype_names[page_mt],
>> -			pfn >> pageblock_order,
>> -			migratetype_names[pageblock_mt],
>> -			&page->flags);
>> -
>> -	if (ret >= count)
>> -		goto err;
>> +	SNPRINTF(kbuf, count, ret, err,
>> +		"PFN %lu type %s Block %lu type %s Flags %pGp\n",
>> +		pfn, migratetype_names[page_mt],
>> +		pfn >> pageblock_order,
>> +		migratetype_names[pageblock_mt],
>> +		&page->flags);
>>   
>>   	ret += stack_depot_snprint(handle, kbuf + ret, count - ret, 0);
>>   	if (ret >= count)
>>   		goto err;
>>   
>> -	if (page_owner->last_migrate_reason != -1) {
>> -		ret += snprintf(kbuf + ret, count - ret,
>> +	if (page_owner->last_migrate_reason != -1)
>> +		SNPRINTF(kbuf, count, ret, err,
>>   			"Page has been migrated, last migrate reason: %s\n",
>>   			migrate_reason_names[page_owner->last_migrate_reason]);
>> -		if (ret >= count)
>> -			goto err;
>> -	}
>>   
>> -	ret += snprintf(kbuf + ret, count - ret, "\n");
>> -	if (ret >= count)
>> -		goto err;
>> +	SNPRINTF(kbuf, count, ret, err, "\n");
>>   
>>   	if (copy_to_user(buf, kbuf, ret))
>>   		ret = -EFAULT;
>> -- 
>> 2.27.0
>>
>>

