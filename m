Return-Path: <cgroups+bounces-13545-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NRdAxK0fGm7OQIAu9opvQ
	(envelope-from <cgroups+bounces-13545-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 14:37:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1D0BB202
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 14:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0929230547C8
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 13:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746952E6CDE;
	Fri, 30 Jan 2026 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KT/rqX0Q"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC673306B37;
	Fri, 30 Jan 2026 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769780092; cv=none; b=MOiQpKYLJ3Xo8NcsbG6N1vLU+32+3VjLockMIcRHIn3clTR/WT/bf0puclm/1ONzK2GNf+xpb+Y3wAjx/pPA3JEbKypZ4DThgaHIH6In7YnzUfLboF5VPFPeENu7ApLcFiQQuuxEQBd0oZGiERBTUpyjdASCBoHnVADZIc9HvR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769780092; c=relaxed/simple;
	bh=h7OZTQW8HL4CAVftwpzjxLZ/SxIGP8730RoVB6HG7Aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7Qt940Wq5VN7vJvmlX+YDW3F2wKVf8KoLOykEF3Xcd7bkDE/DjKqr/2S3+uuUdoETzWsHCeskWm64xMrtvzzBUwSEkFISOFzVDZvyJaghcv+0czXAz+9FY4/kOFH9E1oSppwH0+N2tWKQvgy3Ace14Fo/j0Zu2J6za0a9Y+O1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KT/rqX0Q; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b62d0a63-624f-4822-b0b3-07e75d97721c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769780086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IBlsa1vr6ZeB2QvpQ71ZYV6glQGH5Ds/8UMAFBywU/c=;
	b=KT/rqX0Q1rH5fQrJsOvYoaGjogI6RddJi+9rCtaewr/0tgz/SMGbybWw/IYOyxs1XiP4TN
	Xu3bblr5El/xMJUdM4Px7qCtcaKe0SmuDphEJJP0PjpBkye4qZUKb73WYI7wGHMClnpEvb
	W4AALt8EBn6nd7JEsA1WycJFXDZi0fk=
Date: Fri, 30 Jan 2026 21:34:21 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm: khugepaged: fix NR_FILE_PAGES and NR_SHMEM in
 collapse_file()
Content-Language: en-US
To: Dev Jain <dev.jain@arm.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>,
 Song Liu <songliubraving@fb.com>, Kiryl Shutsemau <kas@kernel.org>,
 Usama Arif <usamaarif642@gmail.com>, David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <baohua@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260130042925.2797946-1-shakeel.butt@linux.dev>
 <1a33fe3e-b0dd-4553-95b4-89619b9229d2@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <1a33fe3e-b0dd-4553-95b4-89619b9229d2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13545-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,surriel.com,fb.com,kernel.org,gmail.com,linux-foundation.org,oracle.com,nvidia.com,linux.dev,linux.alibaba.com,redhat.com,arm.com,infradead.org,meta.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 5E1D0BB202
X-Rspamd-Action: no action



On 2026/1/30 16:10, Dev Jain wrote:
> 
> On 30/01/26 9:59 am, Shakeel Butt wrote:
>> In META's fleet, we observed high-level cgroups showing zero file memcg
>> stats while their descendants had non-zero values. Investigation using
>> drgn revealed that these parent cgroups actually had negative file stats,
>> aggregated from their children.
>>
>> This issue became more frequent after deploying thp-always more widely,
>> pointing to a correlation with THP file collapsing. The root cause is
>> that collapse_file() assumes old folios and the new THP belong to the
>> same node and memcg. When this assumption breaks, stats become skewed.
>> The bug affects not just memcg stats but also per-numa stats, and not
>> just NR_FILE_PAGES but also NR_SHMEM.
>>
>> The assumption breaks in scenarios such as:
>>
>> 1. Small folios allocated on one node while the THP gets allocated on a
>>     different node.
>>
>> 2. A package downloader running in one cgroup populates the page cache,
>>     while a job in a different cgroup executes the downloaded binary.
>>
>> 3. A file shared between processes in different cgroups, where one
>>     process faults in the pages and khugepaged (or madvise(COLLAPSE))
>>     collapses them on behalf of the other.
>>
>> Fix the accounting by explicitly incrementing stats for the new THP and
>> decrementing stats for the old folios being replaced.
>>
>> Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
>> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>> ---
> 
> Thanks.
> 
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> 
>>   mm/khugepaged.c | 16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 1d994b6c58c6..fa1e57fd2c46 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -2195,16 +2195,13 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>>   		xas_lock_irq(&xas);
>>   	}
>>   
>> -	if (is_shmem)
>> +	if (is_shmem) {
>> +		lruvec_stat_mod_folio(new_folio, NR_SHMEM, HPAGE_PMD_NR);
>>   		lruvec_stat_mod_folio(new_folio, NR_SHMEM_THPS, HPAGE_PMD_NR);
>> -	else
>> +	} else {
>>   		lruvec_stat_mod_folio(new_folio, NR_FILE_THPS, HPAGE_PMD_NR);
>> -
>> -	if (nr_none) {
>> -		lruvec_stat_mod_folio(new_folio, NR_FILE_PAGES, nr_none);
>> -		/* nr_none is always 0 for non-shmem. */
>> -		lruvec_stat_mod_folio(new_folio, NR_SHMEM, nr_none);
>>   	}
>> +	lruvec_stat_mod_folio(new_folio, NR_FILE_PAGES, HPAGE_PMD_NR);
>>   
>>   	/*
>>   	 * Mark new_folio as uptodate before inserting it into the
>> @@ -2238,6 +2235,11 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>>   	 */
>>   	list_for_each_entry_safe(folio, tmp, &pagelist, lru) {
>>   		list_del(&folio->lru);
>> +		lruvec_stat_mod_folio(folio, NR_FILE_PAGES,
>> +				      -folio_nr_pages(folio));
>> +		if (is_shmem)
>> +			lruvec_stat_mod_folio(folio, NR_SHMEM,
>> +					      -folio_nr_pages(folio));
> 
> I notice here that we don't need to do accounting for NR_SHMEM_THPS or NR_FILE_THPS -
> but the following bit:
> 
> if (folio_order(folio) == HPAGE_PMD_ORDER && folio->index == start)
> 
> in the khugepaged code, seems to suggest that we can reach this stat accounting path
> with a PMD order old folio, if folio->index != start. But this condition should not be possible;
> a folio is always order-aligned within the file, which means the folio->index here
> is PMD-aligned. The entry of collapse_file() asserts that start is also PMD-aligned (guaranteed


Yep, good catch! There are checks in __filemap_add_folio():

	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);

and at the top of collapse_file():

	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));

guarantee that any PMD folio in the scan range [start, start + HPAGE_PMD_NR)
must have index == start.

Converting this to a VM_WARN_ON looks good to me :)


Cheers,
Lance

> by thp_vma_allowable_order in khugepaged_scan_mm_slot). Therefore start must equal folio->index.
> 
> If I am not missing something here, I'll send a patch to convert this to a VM_WARN_ON.
>   
> 
>>   		folio->mapping = NULL;
>>   		folio_clear_active(folio);
>>   		folio_clear_unevictable(folio);


