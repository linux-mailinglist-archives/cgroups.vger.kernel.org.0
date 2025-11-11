Return-Path: <cgroups+bounces-11777-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D540FC4B3EE
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 03:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBB6188EF3D
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 02:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A1D348889;
	Tue, 11 Nov 2025 02:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sSNpu3UL"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C919347FC0
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762829316; cv=none; b=G1dsZxcpBP8edW+YddwehnL5msgBQFMk2RGoF03ROjD1m5hSB1n2g5ilc5RDx4PAbh9gVIV0RNcOR35N3VD0S2QxQT5L6OOOtBqMLs6bNuNZbyAqCwdlhFKCdi8WajieT2g2wnZTSQrp8ZreJpPh9I+SEEIbpbXhy/OmsAD8I8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762829316; c=relaxed/simple;
	bh=gi1wRAAF95yTa8IfTtHf+MpTbcQq5jDbCsoK1Xljp3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaBzGW8jLNmUbTb1zMX9XYSpRdUHXHw75Bp1LFxRh6lvHAJpst/+awbG+d4HNz0CFGIlEFe20NJcuoxdW97VjR52oG0BlthY5dAth5pYfmEYVU9UPF7hJyUGvDPZzdgGbc2QTX7baph/KZanZdKHxtb8L1elIAdpAi4ucBlySbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sSNpu3UL; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <99429fb8-dcec-43e7-a23b-bee54b8ed6e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762829311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpTvE8Rrz+iBUsvxU9XIT/WrbpcwDHgcPlPzJcVRRVg=;
	b=sSNpu3ULY/cNZ+A4d1Y0Du9gO2K+uzrWXWaVLZBN9O3nQ5viEcBh0vrqe9DZsCltNYRmqV
	RgokJpqGWgDlp/Zqq4NqdHIH9q0Ot8CaBEYqU5PzvmQwGyBwEsfXaHCCluEmksz7CSBvsd
	LSerrPmk/XUPXcmgWytmEMdbL7oWrFM=
Date: Tue, 11 Nov 2025 10:48:18 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Harry Yoo <harry.yoo@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <aRKKfdN3B68wxFvN@hyeyoo> <24969292-7543-456f-8b80-09c4521507e2@linux.dev>
 <gsew67sciieqxbcczp5mzx4lj6pvvclfrxn6or3pzjqmj7eeic@7bxuwqgnqaum>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <gsew67sciieqxbcczp5mzx4lj6pvvclfrxn6or3pzjqmj7eeic@7bxuwqgnqaum>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Shakeel,

On 11/11/25 10:39 AM, Shakeel Butt wrote:
> On Tue, Nov 11, 2025 at 10:23:15AM +0800, Qi Zheng wrote:
>> Hi,
>>
> [...]
>>>
>>> Are you or Qi planning a follow-up that converts spin_lock_irq() to
>>> spin_lock() in places where they disabled IRQs was just to update vmstat?
>>
>> Perhaps this change could be implemented together in [PATCH 1/4]?
>>
>> Of course, it's also reasonable to make it a separate patch. If we
>> choose this method, I’m fine with either me or Shakeel doing it.
>>
> 
> Let's do it separately as I wanted to keep the memcg related changes
> self-contained.

OK.

> 
> Qi, can you please take a stab at that?

Sure, I will do it.

> 
>>>
>>> Qi's zombie memcg series will depends on that work I guess..
>>
>> Yes, and there are other places that also need to be converted, such as
>> __folio_migrate_mapping().
> 
> I see __mod_zone_page_state() usage in __folio_migrate_mapping() and
> using the same reasoning we can convert it to use mod_zone_page_state().
> Where else do you need to do these conversions (other than
> __folio_migrate_mapping)?

I mean converting these places to use spin_lock() instead of
spin_lock_irq().

Thanks,
Qi


