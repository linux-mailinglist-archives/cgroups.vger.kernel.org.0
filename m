Return-Path: <cgroups+bounces-9680-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075AEB4277C
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 19:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FD6685B9B
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 17:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C917E31DD94;
	Wed,  3 Sep 2025 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="aR499Mva"
X-Original-To: cgroups@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB232D4B57;
	Wed,  3 Sep 2025 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918891; cv=pass; b=dGIpHZT91/s4zvFSOdFhRIUDjtvTXKIdpPx8YBCPBM7YGB3gc3gAxRIOt/dFHTC2l7xGguDvBVaRDLIj35CnjYsHyIXjNuECY7zITaYlozX4prk55K/ylVoQIN81Pxkap23hlIOK9dnckT1/3BHwcnYhmNEAA7DMpN/5iB9MpDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918891; c=relaxed/simple;
	bh=TS5rEA7aLL0ZL27pOdYMDynNpYbnEpYaB0V+iYC3wXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fK8zMrhv9f9naMHj9kPBSmVt+/z4przkIQmJ9kzTObYAoxhCw+8GTyl2I7Cu2os1LINAeRzLIXTUFpYqsxT3OAaLPjiv4BkSfpcq47EB8LtuU9sf0OnL/n5eoAmx/bivpqYkR5BTkWYfUT05oepDF8Io4elBCsK6sQ5Vnxkxp2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=aR499Mva; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
ARC-Seal: i=1; a=rsa-sha256; t=1756918852; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BrfW6ug+MFHNCAod74E9LHWyvqUbVTV7rWR4bMmILFrNYdQ/YxeWSMaja/RjNda/MkQ5kIKVMCq3nKUFLPGWjgYYrj5BDtBdmLy8WeoTw/ZVD4t7s8aPp5b4l4rVmo64moABd9vsMJ3Ck/aFlxEr/EUFwNuRKaH2ZnLMEyWEZx0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756918852; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TS5rEA7aLL0ZL27pOdYMDynNpYbnEpYaB0V+iYC3wXg=; 
	b=L9z+xaqywn8JnbBq8ZNoraMr+PTuRyBhIMjWyl8JMbZjYNBXsChl1U8ZlOh1K3YbG2iTkz8bqMebVxb0T4F0GRZWaXglkAkUbGuIYi2xMYlAFe58+T7/N4koyXU7TCMu/lK6veTLPCDF1b1kXxgrz73GYHKa4KoCtZsvrLOl70w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756918852;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TS5rEA7aLL0ZL27pOdYMDynNpYbnEpYaB0V+iYC3wXg=;
	b=aR499MvarNjjHf40vyvNzrbbWoDwBvwLr32Jni4kw1joK6BilXu7G8Pp8gx3Juh7
	GoXxTa2DFsDvxWWM4V+tdMUqw6c/Mf3/TH0w4z99bvzb4ZUvj2udVj6b9ihHphvG4jF
	y4I9lOm8sq4ag4H6NXNiLV9l3vQ75ShE5aCGE4Dc=
Received: by mx.zohomail.com with SMTPS id 1756918850410396.6881075452751;
	Wed, 3 Sep 2025 10:00:50 -0700 (PDT)
Message-ID: <4c6bc1c6-9050-469c-b0f3-872745257398@yukuai.org.cn>
Date: Thu, 4 Sep 2025 01:00:43 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 13/15] block: skip unnecessary checks for split bio
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: colyli@kernel.org, hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com,
 axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 kmo@daterainc.com, satyat@google.com, ebiggers@google.com, neil@brown.name,
 akpm@linux-foundation.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-raid@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-14-yukuai1@huaweicloud.com>
 <aLhDp10e2MpKVVyY@infradead.org>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <aLhDp10e2MpKVVyY@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/9/3 21:33, Christoph Hellwig 写道:
> On Mon, Sep 01, 2025 at 11:32:18AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Lots of checks are already done while submitting this bio the first
>> time, and there is no need to check them again when this bio is
>> resubmitted after split.
>>
>> Hence factor out a helper submit_split_bio_noacct() for resubmitting
>> bio after splitting, only should_fail_bio() and blk_throtl_bio() are
>> kept.
> As Damien said last run this helper is a bit odd.
>
> I'd just make should_fail_bio non-sttic and merge
> submit_split_bio_noacct into bio_submit_split_bioset if that works out.
>
Ok, I'll do this in the next version.

Thanks,
Kuai


