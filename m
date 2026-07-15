Return-Path: <cgroups+bounces-17860-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xX9EEn+VV2rkXQAAu9opvQ
	(envelope-from <cgroups+bounces-17860-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 16:13:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E0275F366
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 16:13:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Cw4boTms;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17860-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17860-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D6533049FFD
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CCD26D4E5;
	Wed, 15 Jul 2026 13:56:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB10930566D;
	Wed, 15 Jul 2026 13:56:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123808; cv=none; b=LnTROCmihvz49C6cz044r8xXUAYPiIxCfGfMgEOUkApjGkNFPNZdJEeFKsTuUXFFyZdqUzGFfCQQlVCL80NPSq7edAbf5jDTFqeX8Z/3WqhDzIHT9JXeIQz974C2Y1RvOIYVbnv0OzORAvr41+ElVTKygiWapzJENjZ2ZdUdci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123808; c=relaxed/simple;
	bh=7FFJjfT3arlHAlINN+VL8nGb7zb+3IxIst7wVsHJmv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5Qma7iSwmMfAQ5GMh06YUHeP/lN2jOXF+BTsEyiFkCQifw3GZZtRMktjtFE6zuof5BxkWF+YU+B0LqhiDVzDI80s/Mm95W3UcR6Ak3+A2yoCo2zr3+w4eufRs9TQzBM+SvR+BPagtmur037rrQuiG+mYFI4NorvEbKoupWTNSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw4boTms; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BE71F000E9;
	Wed, 15 Jul 2026 13:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784123806;
	bh=cbKgz7rXvprr13EIVZgf2t4q5XUn8QXsE1MwfnSlNlg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Cw4boTmsvRJ5HsdR3DL8TP4eNURF9azj/01YdTbCQ00SSClYjC0ktaTG32yicWS8i
	 rEu9JU2Sv1NQg32x3uG+1oDLYIkJDcLZK0LN8ChV02saljmpG4kvvVTdWZuE2MLTc5
	 NJzMCUYg2OSTzA/Fvxe9UGIFdrcJeS4majmQ5zu5rw5MW679fIGZXWL5lcUSXKwRa/
	 oM9wOaGYdKYK0+p6CJfaqB1AHcjU4DRyK8wwqd61pfOeYaZJ9vrhjU2F2+wGWhsT26
	 Os7yzQ1+ihsCKMlNuxOVXEtdLFs+U4bf9EVaa4MWk7+7j8Bawt2CJYQwxDrCJnSV3f
	 3DPRqIRjtR0KA==
Message-ID: <fa67d62e-41bb-4d78-83d1-18461542aff1@kernel.org>
Date: Wed, 15 Jul 2026 15:56:40 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm/page_alloc: remove a couple of VM_BUG_ON()st
Content-Language: en-US
To: Brendan Jackman <brendan.jackman@linux.dev>,
 Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Waiman Long <longman@redhat.com>, Ridong Chen <ridong.chen@linux.dev>,
 Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
 <20260715-spin-trylock-followup-v3-4-fc4d246f705d@google.com>
 <ed4572f4-0074-45c5-993d-7b6533eddc31@kernel.org>
 <DJZ6XH7C3377.1D6EIFUEK2656@linux.dev>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <DJZ6XH7C3377.1D6EIFUEK2656@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:brendan.jackman@linux.dev,m:jackmanb@google.com,m:akpm@linux-foundation.org,m:surenb@google.com,m:mhocko@suse.com,m:hannes@cmpxchg.org,m:ziy@nvidia.com,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:rppt@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-17860-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98E0275F366
X-Rspamd-Action: no action

On 7/15/26 15:48, Brendan Jackman wrote:
> On Wed Jul 15, 2026 at 1:25 PM UTC, Vlastimil Babka (SUSE) wrote:
>> Subject has stray 't' at the end?
> 
> Thanks - will fix if we do a v3 (otherwise Andrew, please can you amend
> when you apply it?)
> 
>> On 7/15/26 13:03, Brendan Jackman wrote:
>>> VM_BUG_ON() is out of favour and on the way to removal, since I recently
>>> touched alloc_pages_node_noprof() I am removing that invocation, and
>>> also removing the __folio_alloc_node_noprof() one for consistency. If
>>> this precondition is violated, the system will soon crash anyway.
>>> 
>>> Suggested-by: Zi Yan <ziy@nvidia.com>
>>> Link: https://lore.kernel.org/all/7F866265-3F2E-4765-B9D4-9AB898A9C4AC@nvidia.com/
>>> Acked-by: Zi Yan <ziy@nvidia.com>
>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>
>> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>>
>>> ---
>>>  include/linux/gfp.h | 1 -
>>>  mm/page_alloc.c     | 1 -
>>>  2 files changed, 2 deletions(-)
>>> 
>>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>>> index 4d57e9c0bf204..872bc53f32ec8 100644
>>> --- a/include/linux/gfp.h
>>> +++ b/include/linux/gfp.h
>>> @@ -255,7 +255,6 @@ static inline void warn_if_node_offline(int this_node, gfp_t gfp_mask)
>>>  static inline
>>>  struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid)
>>>  {
>>> -	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
>>>  	warn_if_node_offline(nid, gfp);
>>>  
>>>  	return __folio_alloc_noprof(gfp, order, nid, NULL);
>>
>> Well if you want more cleanups, I can see in iommu_alloc_pages_node_sz():
>>
>>
>>         /*
>>          * __folio_alloc_node() does not handle NUMA_NO_NODE like
>>          * alloc_pages_node() did.
>>          */
>>         if (nid == NUMA_NO_NODE)
>>                 nid = numa_mem_id();
>>
>>         folio = __folio_alloc_node(gfp | __GFP_ZERO, order, nid);
>>
>> Should we introduce folio_alloc_node() and make __folio_alloc_node()
>> mm-internal, for consistency?
> 
> Ha, I literally just wrote that patch. I'm planning to do it as yet
> another series as there's a little dance needed to get it all into

Cool!

> shape. But, also happy to just expand this one if you prefer.

Not necessary, another series is fine.

> Then I'm gonna add alloc_flags to the __ variant so filemap.c can set
> ALLOC_UNMAPPED for AS_NO_DIRECT_MAP.

Great!

