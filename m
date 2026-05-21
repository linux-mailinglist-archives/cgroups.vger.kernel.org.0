Return-Path: <cgroups+bounces-16138-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBcpHK1jDmpG+QUAu9opvQ
	(envelope-from <cgroups+bounces-16138-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 03:45:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C15BA59DC8F
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 03:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2631430534F8
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 01:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89430191F91;
	Thu, 21 May 2026 01:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUoRj7Xx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68CC3126B1;
	Thu, 21 May 2026 01:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779327805; cv=none; b=ZbSRnZx90MtHAcr1357kPOYejGvFp+vNxk3YXtWG1GHRBzp8GkIHEGdjTzqzNwZIiXq0bEAm3pT4hXBKoX+RjapZfW9e0kglA4hHNHWsu0JxWJeKt+edd5lBY2/Ftio1OoABVvWggdj/bVwr/+889pYpqHOzuXIEtwEyvarbZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779327805; c=relaxed/simple;
	bh=EmnHGDbTdw48NKTSfC+WeBfPXbDBkBkKYYyKn8M44T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5o5j+efa0yZU/cAuybtUh/TAx/I7KxZs1La9ypyqcbkwrDkYVRljt471Ct4DFWZvJ7+4UG6AT7yWm0uchvayz1OdOcrt3MggF2qHmSmCRWCSUx5QptZcyQzPFrpwTFZlNxGsIM0te5Qu9w9EtP2ozuJ5FnX2fr1+pYiQ1V0les=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUoRj7Xx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B589E1F000E9;
	Thu, 21 May 2026 01:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779327795;
	bh=TjSMEOl6HoJhfnGhlg9lwlgKo2mAJunoCTjT72+1vmE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hUoRj7Xx7zxiV+y2G/ilfDYIoH03YyCV33rF5ZScmU4APkemG0NbVIlfShmstGYt6
	 f0GlCYPAR8fEcrG6sdt7CoPyyEM/eE9tW58ruj7OMa6SzbSXowgHgF4RFAnenu+VOq
	 8w/ByKROGz2z2bg2xsS5O/8UorPYoh3ahCu29UKzbQ6hcRKyJXgZdGSsO2QaiJa1NL
	 REFS4+E4XIIWs20Am3SV+m/fPATBFrERJqYmxwwRHASUGUVaIrzzIurw0iCj1cer2x
	 05aBKdCSdnrUwVRT12R9PSEal3c//gBn8AiJ9oJzRosvwhVIpbK3bctDGWLJIrBRoG
	 x8HDoFG0Rbmdw==
Message-ID: <5b09f618-3b84-4163-84f9-f3adc0f1cc97@kernel.org>
Date: Thu, 21 May 2026 10:43:11 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] memcg: multi objcg charge support
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
 Alexandre Ghiti <alex@ghiti.fr>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
References: <20260520053123.2709959-1-shakeel.butt@linux.dev>
 <20260520053123.2709959-5-shakeel.butt@linux.dev>
 <4e20f643-6983-4b6e-b12d-c6c4eb20ae0c@kernel.org>
 <ag5Z9uIMoXpr3rLP@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <ag5Z9uIMoXpr3rLP@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16138-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C15BA59DC8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/21/26 10:05 AM, Shakeel Butt wrote:
> On Wed, May 20, 2026 at 06:35:30PM +0900, Harry Yoo wrote:
>>> @@ -3350,19 +3405,45 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
>>>    		goto out;
>>>    	}
>>> -	stock_nr_bytes = stock->nr_bytes;
>>> -	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
>>> -		drain_obj_stock(stock);
>>> +	for (i = 0; i < NR_OBJ_STOCK; ++i) {
>>> +		struct obj_cgroup *cached = READ_ONCE(stock->cached[i]);
>>> +
>>> +		if (!cached) {
>>> +			if (empty_slot == -1)
>>> +				empty_slot = i;
>>> +			continue;
>>> +		}
>>> +		if (cached == objcg) {
>>> +			slot = i;
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	if (slot == -1) {
>>> +		slot = empty_slot;
>>> +		if (slot == -1) {
>>> +			slot = get_random_u32_below(NR_OBJ_STOCK);
>>
>> It would break kmalloc_nolock() because _get_random_bytes() uses a spinlock.
>> perhaps prandom_u32_state() should be sufficient in this case.

s/spinlock/local_lock/

>> Is there a reason why it uses random eviction, unlike multi-memcg percpu
>> charge cache?
> 
> Oh I didn't know and actually we are already using get_random_u32_below() in
> refill_stock(). So, it need fixing as well. That would be a separate patch.

Ouch, I see.
> I will explore prandom_u32_state().

Thanks!

FYI, SLUB had a similar issue that was recently fixed:
commit a1e244a9f1778 ("mm/slab: use prandom if !allow_spin").

It uses prandom if spinning is not allowed when shuffling slab freelist.

-- 
Cheers,
Harry / Hyeonggon


