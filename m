Return-Path: <cgroups+bounces-17250-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2xU1KeIKPGp6jAgAu9opvQ
	(envelope-from <cgroups+bounces-17250-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 18:50:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ADB6C0191
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 18:50:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=c4KpaYcG;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17250-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17250-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DED930FA71C
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 16:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CFC333429;
	Wed, 24 Jun 2026 16:44:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D52E334C39
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 16:44:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319466; cv=none; b=QB3PzRdUOCvBKdRYqV8RWg1VMw/ehMPqcGzdj8Ym/HPvX20eVGXWDGgSRQZcVdHOmNc5+pF8AYmF3quaBYncXls0wnY8F4flttY0Alfmoc1rVA6BZorRG4vpSyIbYA3lU4tL+QEK9MgppJclwdko07mJ5HgmVpoki6IzzYoSiLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319466; c=relaxed/simple;
	bh=OEYGblbT9PjP9KwnT8iS6u6ZU659hdzc5BhhFdZylRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTqMdt4iCHMRBOZIMO2kCowbpBfZUWstxTGSazn/IOYJ0PqnvFU7U6Y+Ka0a56DiPTIiqH0a/OJZ6x9GV9UgPonTvMifCDqD/LCIK0Xl4uckSNQOjF65zdvDYyl3xktXAf03IVa3IUBRanCS35Evn+/yFE8jbRkaVsl3RH2UkgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c4KpaYcG; arc=none smtp.client-ip=95.215.58.173
Message-ID: <120367a5-0a3c-40ba-a821-f46f8494ef85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782319462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nf45tH+DZxDmO3Xa8ocD4s3OrE54bf3xPt2q+j677fQ=;
	b=c4KpaYcGLpCl50YxEoCnwFd4Lo6D9bMArzTKSQ6bqq7KH+Es0YpHgnF8/5t9/egp5Qikeq
	UP7tnUOU72oz76r6+m98C/WFMvQd7o0fM4iDOyBu+UOp4P5jHBbzTYhEZcqCeFT3ZBFQsE
	z2SzxS1mc4zxpdgiDD8ceOUNzqKqKVA=
Date: Wed, 24 Jun 2026 17:43:56 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/5] mm/memcontrol: convert memcg to use
 page_counter_stock
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam.howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260624152331.2228828-1-joshua.hahnjy@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260624152331.2228828-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:joshua.hahnjy@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam.howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17250-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08ADB6C0191



On 24/06/2026 16:23, Joshua Hahn wrote:
> On Wed, 24 Jun 2026 07:43:47 -0700 Usama Arif <usama.arif@linux.dev> wrote:
> 
>> On Tue, 23 Jun 2026 11:01:22 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> Hello Usama!!
> 
> Thank you for reviewing the patch : -)
> 
> [...snip...]
> 
>>> @@ -2595,7 +2596,6 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
>>>  static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>>>  			    unsigned int nr_pages)
>>>  {
>>> -	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
>>>  	int nr_retries = MAX_RECLAIM_RETRIES;
>>>  	struct mem_cgroup *mem_over_limit;
>>>  	struct page_counter *counter;
>>> @@ -2606,36 +2606,30 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>>>  	bool raised_max_event = false;
>>>  	unsigned long pflags;
>>>  	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
>>> +	unsigned long nr_charged = 0;
>>>  
>>>  retry:
>>> -	if (consume_stock(memcg, nr_pages))
>>> -		return 0;
>>> -
>>> -	if (!allow_spinning)
>>> -		/* Avoid the refill and flush of the older stock */
>>> -		batch = nr_pages;
>>> -
>>>  	reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
>>>  	if (do_memsw_account() &&
>>> -	    !page_counter_try_charge(&memcg->memsw, batch, &counter)) {
>>> +	    !page_counter_try_charge_stock(&memcg->memsw, nr_pages,
>>> +					   &counter, NULL)) {
>>>  		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
>>>  		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
>>>  		goto reclaim;
>>>  	}
>>>  
>>> -	if (page_counter_try_charge(&memcg->memory, batch, &counter))
>>> -		goto done_restock;
>>> +	if (page_counter_try_charge_stock(&memcg->memory, nr_pages,
>>> +					  &counter, &nr_charged)) {
>>> +		if (!nr_charged)
>>> +			return 0;
>>> +		goto handle_high;
>>> +	}
>>>  
>>>  	if (do_memsw_account())
>>> -		page_counter_uncharge(&memcg->memsw, batch);
>>> +		page_counter_uncharge(&memcg->memsw, nr_pages);
>>
>> This needs a transactional rollback. page_counter_try_charge_stock() can
>> succeed by consuming memsw stock and charging 0 new pages, but the
>> memory-failure path unconditionally uncharges nr_pages from memsw.
>> That turns a failed allocation into a real memsw usage decrement.
> 
> Hmmmmmmmmmm....... I'm not sure.
> 
> At this point in the code, we are either (1) using cgroup v1 with memsw
> and charged successfully, or (2) not using cgroup v1 with memsw. So I'm
> not sure if this really is unconditional, we're just distinguishing
> between cases (1) and (2) by checking if we're using cgroupv1.
> 
> Or is your concern with taking a charge via stock, but uncharging with
> a hierarchical page_counter walk?

This was my concern. But I re-read the page_counter stock invariant,
and the stock-hit case is not an undercount? Consuming stock transfers
already-charged credit to the pending allocation; if the later memory charge
fails, page_counter_uncharge() discards that consumed credit from the
hierarchy. That should keeps usage equal to real charges plus remaining stock?

> If so, I think there's a case to be
> made here with just simply returning the stock. I just wanted to keep
> it consistent with the original memcontrol code, which only used
> stock to fulfill charges, not uncharges, since this could make the
> stock grow without bound.
> 
> What do you think? Thanks again for reviewing Usama, I hope you have a
> great day!!!
> Joshua


