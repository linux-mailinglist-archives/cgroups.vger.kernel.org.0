Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D994213848E
	for <lists+cgroups@lfdr.de>; Sun, 12 Jan 2020 03:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbgALC3H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 11 Jan 2020 21:29:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:37031 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731982AbgALC3G (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 11 Jan 2020 21:29:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2020 18:29:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,423,1571727600"; 
   d="scan'208";a="218389651"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jan 2020 18:29:03 -0800
Date:   Sun, 12 Jan 2020 10:28:58 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        alexander.duyck@gmail.com, rientjes@google.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200112022858.GA17733@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com>
 <20200111000352.efy6krudecpshezh@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200111000352.efy6krudecpshezh@box>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jan 11, 2020 at 03:03:52AM +0300, Kirill A. Shutemov wrote:
>On Thu, Jan 09, 2020 at 10:30:54PM +0800, Wei Yang wrote:
>> As all the other places, we grab the lock before manipulate the defer list.
>> Current implementation may face a race condition.
>> 
>> For example, the potential race would be:
>> 
>>     CPU1                      CPU2
>>     mem_cgroup_move_account   split_huge_page_to_list
>>       !list_empty
>>                                 lock
>>                                 !list_empty
>>                                 list_del
>>                                 unlock
>>       lock
>>       # !list_empty might not hold anymore
>>       list_del_init
>>       unlock
>
>I don't think this particular race is possible. Both parties take page
>lock before messing with deferred queue, but anytway:

I am afraid not. Page lock is per page, while defer queue is per pgdate or
memcg.

It is possible two page in the same pgdate or memcg grab page lock
respectively and then access the same defer queue concurrently.

>
>Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>
>> 
>> When this sequence happens, the list_del_init() in
>> mem_cgroup_move_account() would crash if CONFIG_DEBUG_LIST since the
>> page is already been removed by list_del in split_huge_page_to_list().
>> 
>> Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Acked-by: David Rientjes <rientjes@google.com>
>> 
>> ---
>> v2:
>>   * move check on compound outside suggested by Alexander
>>   * an example of the race condition, suggested by Michal
>> ---
>>  mm/memcontrol.c | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>> 
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index bc01423277c5..1492eefe4f3c 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -5368,10 +5368,12 @@ static int mem_cgroup_move_account(struct page *page,
>>  	}
>>  
>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -	if (compound && !list_empty(page_deferred_list(page))) {
>> +	if (compound) {
>>  		spin_lock(&from->deferred_split_queue.split_queue_lock);
>> -		list_del_init(page_deferred_list(page));
>> -		from->deferred_split_queue.split_queue_len--;
>> +		if (!list_empty(page_deferred_list(page))) {
>> +			list_del_init(page_deferred_list(page));
>> +			from->deferred_split_queue.split_queue_len--;
>> +		}
>>  		spin_unlock(&from->deferred_split_queue.split_queue_lock);
>>  	}
>>  #endif
>> @@ -5385,11 +5387,13 @@ static int mem_cgroup_move_account(struct page *page,
>>  	page->mem_cgroup = to;
>>  
>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> -	if (compound && list_empty(page_deferred_list(page))) {
>> +	if (compound) {
>>  		spin_lock(&to->deferred_split_queue.split_queue_lock);
>> -		list_add_tail(page_deferred_list(page),
>> -			      &to->deferred_split_queue.split_queue);
>> -		to->deferred_split_queue.split_queue_len++;
>> +		if (list_empty(page_deferred_list(page))) {
>> +			list_add_tail(page_deferred_list(page),
>> +				      &to->deferred_split_queue.split_queue);
>> +			to->deferred_split_queue.split_queue_len++;
>> +		}
>>  		spin_unlock(&to->deferred_split_queue.split_queue_lock);
>>  	}
>>  #endif
>> -- 
>> 2.17.1
>> 
>> 
>
>-- 
> Kirill A. Shutemov

-- 
Wei Yang
Help you, Help me
