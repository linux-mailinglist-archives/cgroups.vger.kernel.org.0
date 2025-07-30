Return-Path: <cgroups+bounces-8940-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E87B165F2
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 20:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2845A7A7686
	for <lists+cgroups@lfdr.de>; Wed, 30 Jul 2025 18:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9777F2E267C;
	Wed, 30 Jul 2025 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzQ1tc4J"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507C81EBFE0;
	Wed, 30 Jul 2025 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898480; cv=none; b=cG76C2PTZXmIUioH14/Z0kccsfO4ZEzL78uvLyu/ZzoMu/+x8eHPrg7VI2yHwyLYOx3ExZ7qQXQ3Y5fnaU1OmRR1ZMLlWSw0pgsxe8LKsGrZ/DdhPpxx9RQmPJh2YK7kPH/ST8tMFHej1gDhEJEmqqp6U7e89QTeN4FvyRIiOW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898480; c=relaxed/simple;
	bh=WGSTFMyslNF+k98XtSZHWvxmFBmEaR6euDi8RYUmSk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZov2qcGfEhtVQg4wkG0915MCrdCFXuFGu6X+Oj96GbVYm7a5Iyn51m2aSnPoynekkO1Ng86//0kaJFWgCiHD1wQFRcJ5owtpYZEFZ5oujHhgijK6BoQf1hzIPP9OFMS3dTzSm7omjHDizsEMUCnGlbMjo4uBQrYIg0W5K68cQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzQ1tc4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EEFC4CEE7;
	Wed, 30 Jul 2025 18:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753898480;
	bh=WGSTFMyslNF+k98XtSZHWvxmFBmEaR6euDi8RYUmSk8=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YzQ1tc4JzUQiVDnFJE9n4vhXAT+8jGnjQRziLqlqXwCm22gPvxqEbQyibCYaSsj8K
	 JXkRHynXnqtcrECfdWXRtG9NVIK4+eOIXQEvqdNkmxp1II5ZO8myZ1KQQA+glfSKxI
	 G3yt8i+SamwcCkXnqvVx4YW9Dsqw73Rbp4pRO8oYMwXh/4pjPODsX0rp1V22brSyJL
	 ZNWP3vWdxFcoLLYAScPVeSvcYcQkWVe9MxsF/PcRdXMunVijbFIQQLQMdpEfi4+Ebp
	 c+mcWupQo5ecBXtjjZAja0pNEwbyU1xIyd5fYi46MH3k6MmXBoy4ZGKN5an1NZ7tHz
	 neqUqBHdlQkwQ==
Message-ID: <d80b9fc4-515e-4ce8-9f3c-28bdf2676336@kernel.org>
Date: Thu, 31 Jul 2025 02:01:13 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@kernel.org
Subject: Re: [PATCH v2 2/5] mq-deadline: switch to use elevator lock
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 dlemoal@kernel.org, hare@suse.de, jack@suse.cz, tj@kernel.org,
 josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <20250730082207.4031744-3-yukuai1@huaweicloud.com>
 <ca605746-da46-46a4-a0f3-460ed2d35b0b@acm.org>
Content-Language: en-US
From: Yu Kuai <yukuai@kernel.org>
In-Reply-To: <ca605746-da46-46a4-a0f3-460ed2d35b0b@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2025/7/31 1:21, Bart Van Assche 写道:
> On 7/30/25 1:22 AM, Yu Kuai wrote:
>> @@ -466,10 +466,9 @@ static struct request 
>> *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>>       struct request *rq;
>>       enum dd_prio prio;
>>   -    spin_lock(&dd->lock);
>>       rq = dd_dispatch_prio_aged_requests(dd, now);
>
> The description says "no functional changes" but I think I see a 
> functional change above. Please restrict this patch to changing
> &dd->lock into dd->lock only.
Ok, you mean that the lock is moved to the caller is functional change, 
right?

Thanks,
Kuai
>
> Thanks,
>
> Bart.
>


