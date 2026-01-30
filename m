Return-Path: <cgroups+bounces-13543-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLFLIp9nfGk/MQIAu9opvQ
	(envelope-from <cgroups+bounces-13543-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 09:11:11 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D24EB831F
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 09:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 674013004DED
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 08:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59E132694A;
	Fri, 30 Jan 2026 08:11:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFEE30594F;
	Fri, 30 Jan 2026 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769760666; cv=none; b=if57Tx9D8awCkqmuh0C7oL9P1OtK30S6OOvNRIjFbL2xpcEhY+CvOjdZfCUd4IkC3pLWGgjXLgYYFOFBWyKf1LGzTIhJ2Ve+rb+hKJetYtWG1TdXNoL7edCr5oXKALLg0ptVMC4ZK9ncJq0/j25xnYBf9kOCA6JgtrnmtZ1hUJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769760666; c=relaxed/simple;
	bh=/s65cuwG2s7quRiocr+iGjbTPoSdj2e6uUzazyRUKBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nffS46tY2rYB3lpWd3toY7uN+tcN3tCjV3TuOJCklErnKMCRyYbs/bWAIamovRtN6NUyr9T6XYkCcL0rMn1o/7B172hxutU4xU/2BvyZ4ek5JC7gdLUxkDgYTbbHH5sGw/FlWc5IV7fvXHA+/A/cRAo2byhbKt6+Aa7mY+1wh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 343F1153B;
	Fri, 30 Jan 2026 00:10:56 -0800 (PST)
Received: from [10.164.18.94] (unknown [10.164.18.94])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20D8D3F632;
	Fri, 30 Jan 2026 00:10:56 -0800 (PST)
Message-ID: <1a33fe3e-b0dd-4553-95b4-89619b9229d2@arm.com>
Date: Fri, 30 Jan 2026 13:40:54 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: khugepaged: fix NR_FILE_PAGES and NR_SHMEM in
 collapse_file()
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>,
 Song Liu <songliubraving@fb.com>, Kiryl Shutsemau <kas@kernel.org>,
 Usama Arif <usamaarif642@gmail.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Matthew Wilcox <willy@infradead.org>, Meta kernel team
 <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260130042925.2797946-1-shakeel.butt@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20260130042925.2797946-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,surriel.com,fb.com,kernel.org,gmail.com,oracle.com,nvidia.com,linux.alibaba.com,redhat.com,arm.com,linux.dev,infradead.org,meta.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13543-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev.jain@arm.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,arm.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 2D24EB831F
X-Rspamd-Action: no action


On 30/01/26 9:59 am, Shakeel Butt wrote:
> In META's fleet, we observed high-level cgroups showing zero file memcg
> stats while their descendants had non-zero values. Investigation using
> drgn revealed that these parent cgroups actually had negative file stats,
> aggregated from their children.
>
> This issue became more frequent after deploying thp-always more widely,
> pointing to a correlation with THP file collapsing. The root cause is
> that collapse_file() assumes old folios and the new THP belong to the
> same node and memcg. When this assumption breaks, stats become skewed.
> The bug affects not just memcg stats but also per-numa stats, and not
> just NR_FILE_PAGES but also NR_SHMEM.
>
> The assumption breaks in scenarios such as:
>
> 1. Small folios allocated on one node while the THP gets allocated on a
>    different node.
>
> 2. A package downloader running in one cgroup populates the page cache,
>    while a job in a different cgroup executes the downloaded binary.
>
> 3. A file shared between processes in different cgroups, where one
>    process faults in the pages and khugepaged (or madvise(COLLAPSE))
>    collapses them on behalf of the other.
>
> Fix the accounting by explicitly incrementing stats for the new THP and
> decrementing stats for the old folios being replaced.
>
> Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---

Thanks.

Reviewed-by: Dev Jain <dev.jain@arm.com>

>  mm/khugepaged.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 1d994b6c58c6..fa1e57fd2c46 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2195,16 +2195,13 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  		xas_lock_irq(&xas);
>  	}
>  
> -	if (is_shmem)
> +	if (is_shmem) {
> +		lruvec_stat_mod_folio(new_folio, NR_SHMEM, HPAGE_PMD_NR);
>  		lruvec_stat_mod_folio(new_folio, NR_SHMEM_THPS, HPAGE_PMD_NR);
> -	else
> +	} else {
>  		lruvec_stat_mod_folio(new_folio, NR_FILE_THPS, HPAGE_PMD_NR);
> -
> -	if (nr_none) {
> -		lruvec_stat_mod_folio(new_folio, NR_FILE_PAGES, nr_none);
> -		/* nr_none is always 0 for non-shmem. */
> -		lruvec_stat_mod_folio(new_folio, NR_SHMEM, nr_none);
>  	}
> +	lruvec_stat_mod_folio(new_folio, NR_FILE_PAGES, HPAGE_PMD_NR);
>  
>  	/*
>  	 * Mark new_folio as uptodate before inserting it into the
> @@ -2238,6 +2235,11 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>  	 */
>  	list_for_each_entry_safe(folio, tmp, &pagelist, lru) {
>  		list_del(&folio->lru);
> +		lruvec_stat_mod_folio(folio, NR_FILE_PAGES,
> +				      -folio_nr_pages(folio));
> +		if (is_shmem)
> +			lruvec_stat_mod_folio(folio, NR_SHMEM,
> +					      -folio_nr_pages(folio));

I notice here that we don't need to do accounting for NR_SHMEM_THPS or NR_FILE_THPS -
but the following bit:

if (folio_order(folio) == HPAGE_PMD_ORDER && folio->index == start)

in the khugepaged code, seems to suggest that we can reach this stat accounting path
with a PMD order old folio, if folio->index != start. But this condition should not be possible;
a folio is always order-aligned within the file, which means the folio->index here
is PMD-aligned. The entry of collapse_file() asserts that start is also PMD-aligned (guaranteed
by thp_vma_allowable_order in khugepaged_scan_mm_slot). Therefore start must equal folio->index.

If I am not missing something here, I'll send a patch to convert this to a VM_WARN_ON.
 

>  		folio->mapping = NULL;
>  		folio_clear_active(folio);
>  		folio_clear_unevictable(folio);

