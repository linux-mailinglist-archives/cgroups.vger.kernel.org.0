Return-Path: <cgroups+bounces-16515-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAq8DIVoHWrqaAkAu9opvQ
	(envelope-from <cgroups+bounces-16515-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 13:09:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1CC61E1BC
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 13:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10E7630078B1
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDF1395AD4;
	Mon,  1 Jun 2026 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fwuYrdm1"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09EC373BE8
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312194; cv=none; b=MYp530hB8223Hw98ceNtZxEU1NtAVgNGH9gah4qYQJFYyUCVcE3gWKSlpfSwLzaptduDAUqyW7lgEufjIe845nZTzrGVV0iGQim5U/6iBSy2BuYxcXTDfDEMxwwuu4VpzhlPBCACVjHaigHcS2IkoMoJc4n9xdg9YCfQ4nH0fSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312194; c=relaxed/simple;
	bh=fHxsazB7z+nu0WXVW1TygTZl47qa2PMlJrC6QSq/Hvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjFckxWFI/sS+SFcJyGtkFS79CSzmu2vbN/SDRU2LeahMgEjq0jNr7BkWSWlzuFsmvHFvnspPFDyOgl39Y/Jbt0NCYgvPE4NWvketlpITvQcizWcEGqOBjWMD6XwOVJzXrLgjuiWaWtYNqeVa1O53e3OWsPlgjUEVmSej9UeUJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fwuYrdm1; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c9cf7afb-1c92-4915-b311-305c7ac48739@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780312189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TTr4tQwBByNMsxp8D3ocf5yh1cG3xPQPohe/Uv/Q2R4=;
	b=fwuYrdm12vhes1RUcQfe5De52w6tNFQ4WjqITT2oAJkvclwo0eQiv9oCvrJTOzfOdF8EjN
	pUt+rMTOaFp6fdp8WsZ2kzw7Yw6so77nPChFnq5PyPwRn8wgss95ANbm+qnIdMMjsuLu27
	ToMkL/pgiC9lFr1RSqNcPITzxAXrMA8=
Date: Mon, 1 Jun 2026 19:09:34 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 9/9] mm: switch deferred split shrinker to list_lru
Content-Language: en-US
To: hannes@cmpxchg.org
Cc: akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
 shakeel.butt@linux.dev, mhocko@kernel.org, david@fromorbit.com,
 roman.gushchin@linux.dev, muchun.song@linux.dev, qi.zheng@linux.dev,
 yosry.ahmed@linux.dev, ziy@nvidia.com, liam@infradead.org,
 usama.arif@linux.dev, kas@kernel.org, vbabka@kernel.org, ryncsn@gmail.com,
 zaslonko@linux.ibm.com, gor@linux.ibm.com, baolin.wang@linux.alibaba.com,
 baohua@kernel.org, dev.jain@arm.com, npache@redhat.com,
 ryan.roberts@arm.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20260527204757.2544958-10-hannes@cmpxchg.org>
 <20260601103947.63923-1-lance.yang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260601103947.63923-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-16515-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BD1CC61E1BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/6/1 18:39, Lance Yang wrote:
> 
> On Wed, May 27, 2026 at 04:45:16PM -0400, Johannes Weiner wrote:
> [...]
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 135f5c0f57bd..f22e61d8c8de 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5222,6 +5222,10 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>> 			folio_put(folio);
>> 			goto next;
>> 		}
>> +		if (order > 1 && folio_memcg_alloc_deferred(folio)) {
>> +			folio_put(folio);
> 
> Missing a MTHP_STAT_ANON_FAULT_FALLBACK bump here?
> 
> Since we jump straight to fallback and end up at order-0 :)

Sorry for the noise, I missed the earlier discussion. Never mind this 
one, please.

> 
>> +			goto fallback;
>> +		}
>> 		folio_throttle_swaprate(folio, gfp);
>> 		/*
>> 		 * When a folio is not zeroed during allocation
> [...]
> 
> Cheers, Lance


