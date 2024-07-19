Return-Path: <cgroups+bounces-3812-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98D7937AE8
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 18:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0EE1C218BA
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 16:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B3D13EFEE;
	Fri, 19 Jul 2024 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="yB1ZxALX"
X-Original-To: cgroups@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF222071;
	Fri, 19 Jul 2024 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406325; cv=none; b=E2TiEWLtBPExPEzS9zqQyuICyQyre96W0gv0GwB0AkvD9DQnFEBIEowKpp8iLUgmtcSGMt4i0iRs/6RHOErYrQVozyl6PscHSHQRmMBcVHrqTQW1b9Elm4W3HDCsjKLnEsoBEcXV8aClmCdHyd0Bqs/3YUikRca9cs64Blt1LHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406325; c=relaxed/simple;
	bh=D2YECO4CUpLpZ/5gziEVa57+OmWK4MuvHene9TJkvaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4nLpOw+Dm6As3XX7NGSBsSbjxS8zBdrVhBoeUSLfSVgNJoRa3462/ePKA6EvWspnSQ/SOMPPhyhYYn8r6gefQmnHkS9FLNyKkdKBX7a+ScvttVjckoxgUgk+Pn9unzvsO3iwroi3ajG7wd638cIU/38TUyHGXMaaDYZc6dsSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=yB1ZxALX; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WQZld3ffqz6ClbJB;
	Fri, 19 Jul 2024 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1721406313; x=1723998314; bh=0VO8L+dQpbW1mO5fjqBZ5/J9
	PAn2ZjVWoVBKAWeouT8=; b=yB1ZxALXiD/5e20VPeUGRqsDhjZ9txPmRc0UkcqG
	2mMs17N0NNl3Jm+Ba1Cr3yD5C8YQdEMptf3huk18RbpK96gfGvaEENNYyZWBuNsp
	ojlxYn674ZMsVlUug/L0yEzuExQ91SiFsrFYrRGeJ/wxnyw3atYVv0UimB9dXiWb
	zCWuiMVU8Q2t4o2GVc1/RgeWY0SA165iNvgF9Iem7iBXGiiEHHatDDxAALmjr4xt
	0VjEZyD03Dv3qmOzVIZzWD2EsWBGJldp/rAbYfcpiay1zYcCzETFl8k+RSxKjWCu
	5qkUXkB8c6g8zYUxbF0Dc/n+IP12r+Cor5Qhf9V4Enr4fg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id VS1TUZfVv7WS; Fri, 19 Jul 2024 16:25:13 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WQZlV2vdLz6CmM6c;
	Fri, 19 Jul 2024 16:25:09 +0000 (UTC)
Message-ID: <ab8f117b-0e0a-4157-b261-471328f6b4e3@acm.org>
Date: Fri, 19 Jul 2024 09:25:07 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] blk-cgroup: check for pd_(alloc|free)_fn in
 blkcg_activate_policy()
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com
References: <20240719023431.3800647-1-yukuai1@huaweicloud.com>
 <20240719023431.3800647-2-yukuai1@huaweicloud.com>
 <Zpn5zvcC4TbDxeKU@infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Zpn5zvcC4TbDxeKU@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 10:29 PM, Christoph Hellwig wrote:
> On Fri, Jul 19, 2024 at 10:34:29AM +0800, Yu Kuai wrote:
>> +	/*
>> +	 * Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs, and policy
>> +	 * without pd_alloc_fn/pd_free_fn can't be activated.
>> +	 */
>>   	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
>>   		(!pol->pd_alloc_fn ^ !pol->pd_free_fn))
>>   		goto err_unlock;
>> -- 
> 
> I know this is existing code, but can you fix up the incorrect
> indentation while you touch this:
> 
>   	if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
>   	    (!pol->pd_alloc_fn ^ !pol->pd_free_fn))

Using xor (^) for booleans seems weird to me. Is there any preference in
Linux kernel code whether to use ^ or != to check whether to booleans
are different?

Thanks,

Bart.


