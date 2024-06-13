Return-Path: <cgroups+bounces-3180-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C76B6907807
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 18:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F25C282EFF
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2024 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6471F1474B5;
	Thu, 13 Jun 2024 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="HrcpeDFR"
X-Original-To: cgroups@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C3A14198E;
	Thu, 13 Jun 2024 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295322; cv=none; b=MdDR1pSYAN9o/XOFnMbqFvqWTDmigL9Sx0ZakH9OwaQa4Gq49SKvms74ng9USBcO7P2ltk9QOrZTDzJ3jrNAM6hmZ8n1N+ULug4uwkTEd19GF2FIwg/8GT3/VXYj2IIrg+0nf/X1xGVEGbpEYZsPz0vUJvR+qdLdQPYI79VhYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295322; c=relaxed/simple;
	bh=whMfq11Dvw2ni6ZHzlG2G6+Nq2AQLkx4vq48AZNPPKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CR67LLtwTMD4o30sXxSNVbM0dt1WeXWzlXjqHYcwOwai4i5Rh0tN+alkMx5kG/VC0SCPgQtH7uIlfMju1n8n0RNulVpMfT2ZvfuYngnqCBRVvbeG2ABl6CtGO/5wFXGfuHZ6DfGSDtfpnWAIFpXHkiXI/0uECfXE4BykY9YpB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=HrcpeDFR; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4W0SDl5Rwcz6Cnk94;
	Thu, 13 Jun 2024 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718295315; x=1720887316; bh=VkPfQbRg/V3TI9O9qndO+2G1
	4jtGtT1qgCPkkoNwBOM=; b=HrcpeDFREjPrz+2v1PgNd01GJOe/dxhdUPjTA+LD
	pZHQgMHKcgmHMsTnqxvkBqa0/P4ZEFihu5ONnYpHZe+BSMFky0muLiknd/afYuDV
	BcxA0aSpy3tT8XMmzx2sIm8bLIKNQjkjl3VewPrxaHmYHtRr2MmroDea7T7ka0B5
	wfGwUwQalf/nMiwXZiNfdhukh96/Cuus1SkqrbvaimWrx5zVLAEmdnWCQuJmRtV0
	Kvvqf44yFMOywckrNLjaOaERTlaVKXHRF5G8F3A3WDNXXLJdHi1m9uAI3H95g41Z
	3zQpI91h0FDjUCKPOhJmxB+LX+SoM1R5F09XCJZdeW9Yuw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0z4NuhIURIQq; Thu, 13 Jun 2024 16:15:15 +0000 (UTC)
Received: from [IPV6:2620:0:1000:5e10:c543:208b:8ce4:f55a] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4W0SDd3gd8z6Cnk9B;
	Thu, 13 Jun 2024 16:15:13 +0000 (UTC)
Message-ID: <97a2b888-4dac-451c-bb9c-40d8dc52cd60@acm.org>
Date: Thu, 13 Jun 2024 09:15:11 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC -next 0/7] blk-iocost: support to build iocost as
 kernel module
To: Greg KH <gregkh@linuxfoundation.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com
References: <20240613014937.1326020-1-yukuai1@huaweicloud.com>
 <2024061342-walk-cavalier-7e48@gregkh>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2024061342-walk-cavalier-7e48@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 10:54 PM, Greg KH wrote:
> On Thu, Jun 13, 2024 at 09:49:30AM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Yu Kuai (7):
>>    kernfs: export pr_cont_kernfs_path()
>>    cgroup: export cgroup_parse_float
>>    block: export some API
>>    blk-iocost: factor out helpers to handle params from ioc_qos_write()
>>    blk-iocost: parse params before initializing iocost
>>    blk-iocost: support to free iocost
>>    blk-iocost: support to build iocost as kernel module
> 
> No where do you say _why_ building this as a module is a good idea.
> 
> Why do this at all?

With CONFIG_BLK_CGROUP_IOCOST=y (as in the Android kernel), the
blk-iocost kernel module causes a (small) runtime overhead, even if it
is not being used.

Thanks,

Bart.


