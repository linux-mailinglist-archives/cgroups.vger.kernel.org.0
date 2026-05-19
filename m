Return-Path: <cgroups+bounces-16101-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM/hAcT0DGqPqQUAu9opvQ
	(envelope-from <cgroups+bounces-16101-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 01:39:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9911A58615A
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 01:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E5D7304CF5F
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 23:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1321F370AF8;
	Tue, 19 May 2026 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9tundKL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3BE233924;
	Tue, 19 May 2026 23:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779233982; cv=none; b=h5H+ADDQFunE5i6QPG4C2mZJs9OlVFfb+inZ6tVg809XkUqzDY68Wqfior3bYZc6HMj/pgxAa+3qzUqBUqwz0rZAm7zewwkjIJ85032usz0yJAZvY54AFGSZC3M/C00NkSQJhlACSpYCVmEeTHl6H+ft4XHBLhXrSaq4y4NBfoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779233982; c=relaxed/simple;
	bh=B5o1RxDkQuY/dH4SRTLvEIqXq5ycT0Yn1h7a+4dQEy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1hACZrpYM8Xtyd4EP9VU0LoQ3bjylIkbw4SotMPRtQnrVebRX4Ft8yfUTAwEOXnGHv67QlFw9Hj+Er3CPcD5EAqzANcelX2a/AjuZHdPZfzOflwWC6RY+kS6C+SWuuFnpX6T6/hxbNbc85IWCdgjD5IBUYPX6pjvYlW57B1h8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9tundKL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF82E1F000E9;
	Tue, 19 May 2026 23:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779233981;
	bh=r+hzOVex1jUoqLwARlZfBASNO++sjiPZWujjsCNbAmU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y9tundKLUw86gpRjIBHp1wp1J2W9uDzKuOrkdcHVp2AznvGUbD7MDggJA1MoxmdYz
	 Rhx7MYZnokxMeigJ8L6oAbCqr0j1NwqRDAjpxz0pm9u1zFJL92jdQGu23TB7WuhhP+
	 JpeP5ntASjuJUSpQ8C6Dd2GW+ndAfWC1qHwUtPhG4hUfcF7LQEsUYzLCXs4W7AQO+1
	 VUJOxYgnyYUmgxPtDVcUJ785BW9w+0MMNdfPRcTFEgES2EjGW6dU1QtbdKKaZafU2B
	 zODBSgY60ipNCcgugEtb04WZtWZq6HBBc10ce22GX0R0JJWo5g+XEFDxoo4kQ6aPde
	 MZaBwMyy/FgCg==
Message-ID: <1ca41e22-aff1-4068-b080-067885b44f69@kernel.org>
Date: Wed, 20 May 2026 08:39:37 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memcg: cache obj_stock by memcg, not by objcg pointer
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
 Alexandre Ghiti <alex@ghiti.fr>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
References: <20260518222827.110696-1-shakeel.butt@linux.dev>
 <aguiSnY3ie1y4nEl@linux.dev>
 <4e296262-fbbf-4ac7-aecc-3ef831583704@kernel.org>
 <agxszIIN6FtK0fEb@linux.dev>
 <ca8e655d-5fe7-4957-8a36-6667616be8b6@kernel.org>
 <agynzVVBb4CYJTYG@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <agynzVVBb4CYJTYG@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16101-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9911A58615A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/20/26 5:11 AM, Shakeel Butt wrote:
> On Wed, May 20, 2026 at 12:00:16AM +0900, Harry Yoo wrote:
>>
>>
> [...]
>>>
>>> The full clean solution might take one more cycle and I think we can not just
>>> ignore 67% regression on 7.1.
>>
>> That is valid point, unfortunately.
>>
>> One more thing I have to ask... for v7.1, wouldn't it be a safer option to
>> revert the per-node object change and re-introduce it once we have a cleaner
>> solution?
> 
> The issue with that revert is that we reintroduce all node lru locking in the
> objcg reparenting path.

I'm not sure the problems with all-node locking are serious enough to 
rule it out as an option for 7.1.

It is not ideal, but given that the critical section for reparenting is 
independent of folio count, would this actually be a significant problem 
in practice? (even large servers rarely go beyond 8 NUMA nodes...)

>> This change was introduced in v5, but the implementation before v4 had been
>> exposed in -next for a while, and I think we don't have enough justification
>> to keep the per-node objcgs change, at least for v7.1, given that we have an
>> unexpected last-minute regression and
>> correctness concerns (albeit slight).
> 
> I am waiting for Oliver to test the multi-objcg patch I sent. If that also
> resolves the regression then we have one more option i.e. backport that to 7.1
> to fix the regression.

Yeah, If per-node objcg is required in future kernels anyway, this 
option would be more ideal (if available).

> So to summarize, for future kernels we will be having multi-objcg in some form.
> For 7.1, we have to decide between (1) do nothing (2) this patch or (3) backport
> the multi-objcg path to 7.1.

Ack.

Thanks!

-- 
Cheers,
Harry / Hyeonggon


