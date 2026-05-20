Return-Path: <cgroups+bounces-16115-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIIsBchYDWpuwQUAu9opvQ
	(envelope-from <cgroups+bounces-16115-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 08:46:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1E3588532
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 08:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87BE8301589D
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 06:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7811E33D4F8;
	Wed, 20 May 2026 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4/u22s+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A98233A6F1;
	Wed, 20 May 2026 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259267; cv=none; b=eMsmaVHawbGcYHhzI3EvW9lQlQaueEUaInRaaeAOWtfZ8FLEyQgyvuT5oRWM0Uo/IXDQO3hzWchgOFgndeZilzvKrNK4ABX+njpHkY57XPTpA1llBE+HeJ31vbxm2w3aZcWZW+LWeeLqPekfMX+gEt9NlEAcrx6K3sQDciof4CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259267; c=relaxed/simple;
	bh=oRrxPI8YAXHdl+Os7sSeFj1xpkSqAKNVD65qbgB/f1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BW+0+tVggOHKsM6jbmyE1h5bG29Pmf3iTu317pVfwyaatyDh3mY2u1u8TYV9BhjXcWxi+2mggES6BDI5R+mb4oK4vSyGsHMtSWorD1Bvk8q0n/SzcQb+OsPmslxfgSw+67xYKrdped6ItdfiXwoS3yNOpJngJ+VkXDBvqtCH/ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4/u22s+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F7B1F000E9;
	Wed, 20 May 2026 06:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779259265;
	bh=t5aueIOO+B8O30BYhpyvaYfeaMnbRo9gO1SHqe+cDh4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C4/u22s+iJFOhW8pgObb0RVr2N7kMXeXpEl4lUPTaIi091OJPb//FrxSwEW27oqJa
	 kHiNRf/Fno0ECc+vLbk9XIKE7v1l2xgxVIW6MYYN9c3yd7o0RNEKKuRfuWyUKy2Rzg
	 ESBM8FWYeBZfp6Q38Q5WDpZQT2oLGFKfHNbplVVcUVDadUdZUnOA6HwKpFTVcCbvrJ
	 1CjqJoM0qw6+qu81E3bEMdSsAs1Mh4XVWuULqgZKfURJ8u2WSq0XuJ9z5KTCAYKWDQ
	 U8GqsjzlJvCXZnnU2EN4MCjgJXecH/V4L/Df2WBqNISK/mPa4l1BOkTJk63H6ZJPpQ
	 3miapLDvgPAbg==
Message-ID: <98578d1a-a1fa-4d4b-91ee-921cf07dd09d@kernel.org>
Date: Wed, 20 May 2026 15:41:02 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] memcg: uint16_t for nr_bytes in obj_stock_pcp
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
 Alexandre Ghiti <alex@ghiti.fr>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
References: <20260520053123.2709959-1-shakeel.butt@linux.dev>
 <20260520053123.2709959-3-shakeel.butt@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260520053123.2709959-3-shakeel.butt@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-16115-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,linux.dev:email]
X-Rspamd-Queue-Id: 6A1E3588532
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/20/26 2:31 PM, Shakeel Butt wrote:
> Currently struct obj_stock_pcp stores nr_bytes in an 'unsigned int'
> which is 4 bytes on 64-bit machines. Switch the field to uint16_t to
> shrink the per-CPU cache.
> 
> The kernel supports PAGE_SIZE_4KB, _8KB, _16KB, _32KB, _64KB and
> _256KB (see HAVE_PAGE_SIZE_* in arch/Kconfig). After the
> PAGE_SIZE-aligned flush in __refill_obj_stock(), the sub-page
> remainder fits in uint16_t up through 64KiB pages where PAGE_SIZE - 1
> == U16_MAX, but on 256KiB pages PAGE_SIZE - 1 == 0x3FFFF exceeds
> U16_MAX. The accumulator also needs to stay within uint16_t between
> page-aligned flushes on 64KiB pages where PAGE_SIZE itself is
> U16_MAX + 1.
> 
> Accumulate the new total in an 'unsigned int' local, then:
> 
>    1. Flush whenever the accumulator would hit U16_MAX. Together with
>       the existing allow_uncharge flush at PAGE_SIZE, this keeps the
>       uint16_t safe on PAGE_SIZE <= 64KiB.
> 
>    2. On configs with PAGE_SHIFT > 16 (PAGE_SIZE_256KB on hexagon and
>       powerpc 44x), push any sub-page remainder above U16_MAX into
>       objcg->nr_charged_bytes via atomic_add before storing back, so
>       the store cannot silently truncate. The PAGE_SHIFT > 16 guard
>       folds the branch out at compile time on smaller page sizes.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> ---

Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

-- 
Cheers,
Harry / Hyeonggon


