Return-Path: <cgroups+bounces-11843-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC2BC504FB
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 03:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D2E94E824E
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 02:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCAA292B54;
	Wed, 12 Nov 2025 02:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A7XRRi4j"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A147261B
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762913489; cv=none; b=E7vqMgaXqCAx88WAyJpvI5EE4c91Ka+Zc4dxY9MU1IbL6Iyv/wf8MKXCd4gM9bHrZ4bVWzF2cXOKlR4/TzN2nrgcYgWpWonm0CRBU0plOMsBGH4IeYrcxbBnGJ0dAhfc48Vc0ac3ZgNtT9kx0u1+tFZ2kttXwIJHujgRZ4w35yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762913489; c=relaxed/simple;
	bh=5Vpj1bb3HpZ52iH36YEe53g0hvKmziXmTRxd5n1R3JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVocsaPih6r5nGyoWLptAknxD508ZHXB0nP0w5UEcxt582QCpzIhI57lhYLvJQuBNVMwjSckTdAinTNmcZOTy3hOklhhuf6cnEGAcCXOTQKisvqs6ujox4TJ6l0/C8k3DbJY/8fALAVKR5YDxGSVvEiIogWJ+nBS8NlW+LtaNHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A7XRRi4j; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3ba7892-ed5e-45bb-9b1c-e901b622306d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762913480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uriJ/UZtbFIWJHYtkqAM7/7gRRqxwaWIv7KjAJwxh2s=;
	b=A7XRRi4jm9+2dng+brC/ULaeX9wZNMw/VzLlf/tyUGMqCUfZ2beqnlyFDHJ5onqOe9qT/x
	+xVpymK38zhN1SdT+9T6nvNkJhJWwRUumKKTdfvjlk+gOa4GWGWTPF5Gmf3ZhCEuJaIj/S
	4caHjsnL4DfoYVhD3xw/wxg9bXoNT3k=
Date: Wed, 12 Nov 2025 10:11:11 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <0618ea79-fed3-4d4d-9573-2be49de728cf@linux.dev>
 <xjwmyqdjynpeuqtgxiz3igynjl4ywopdc33lteidgmp5yez2ed@pbdfsekytezn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <xjwmyqdjynpeuqtgxiz3igynjl4ywopdc33lteidgmp5yez2ed@pbdfsekytezn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/12/25 12:45 AM, Shakeel Butt wrote:
> On Tue, Nov 11, 2025 at 04:36:14PM +0800, Qi Zheng wrote:
>> Hi Shakeel,
>>
>> On 11/11/25 7:20 AM, Shakeel Butt wrote:
>>> The memcg stats are safe against irq (and nmi) context and thus does not
>>> require disabling irqs. However for some stats which are also maintained
>>> at node level, it is using irq unsafe interface and thus requiring the
>>> users to still disables irqs or use interfaces which explicitly disables
>>> irqs. Let's move memcg code to use irq safe node level stats function
>>> which is already optimized for architectures with HAVE_CMPXCHG_LOCAL
>>> (all major ones), so there will not be any performance penalty for its
>>> usage.
>>
>> Generally, places that call __mod_lruvec_state() also call
>> __mod_zone_page_state(), and it also has the corresponding optimized
>> version (mod_zone_page_state()). It seems necessary to clean that up
>> as well, so that those disabling-IRQs that are only used for updating
>> vmstat can be removed.
> 
> I agree, please take a stab at that.

OK, will do.



