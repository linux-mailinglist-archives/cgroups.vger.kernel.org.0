Return-Path: <cgroups+bounces-9678-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EF9B42756
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 18:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05DFA7A7F64
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 16:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006030EF77;
	Wed,  3 Sep 2025 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="IsTK7dFz"
X-Original-To: cgroups@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6162BF3E2;
	Wed,  3 Sep 2025 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918524; cv=pass; b=hNXYsTkNBm6uu03o3ujR9rJvmpiInjgpAcK4Gt9cUbStbMCyztXA/abHsb5hPtorIluAseh9t4ovuxn5MrIgoHoYQeFiaSd5gihKp5UxYYc/XJgGrJXbhh90F+2YQoDpzOssw3JR9oloG3qxBigN3a/zTuuPwcSpofA+o9xhW+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918524; c=relaxed/simple;
	bh=XML3TLtqNLit6Cuk/fd0UijgFeKExTOFCjoiSKp+kCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmXpSKcgaOl+T/b81rqnUtnCN5O4ucRWHNdkoAbwcRJZypMp998VYgrML1ylqiNq30V3Gt9aOwDojC4JZ9QyCFfj+Tn/JzyFdWInNQ6KhfiNjhhHAMC5Yuq3uO/VYdUcBcj4s34/qoDCuMS0jRyA0VY6M5GyoF8e7VlAKJIAYak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=IsTK7dFz; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
ARC-Seal: i=1; a=rsa-sha256; t=1756918475; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LxA6xthJl3yR5kw+yNsCzgnMqt/DMw7Aj/qxGR2Zgzq7BTZHE1yJKgF+CmsrZei7cZfT/IEBwzehJofGst/z7g3RBBjXJSoqO+p+LoIHh6fVdu4FlbhyyFrlChSeBYxXnPWuT8piSSNtHf/8jw2qJgMTlVQOQYJIdYqPg8Dw2NM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756918475; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7WdYZEXC6O5mRGfLpDBkGN8H25EvnFvIzc7KmEQNUo8=; 
	b=npEau/1a9jaELQMDb9H01ZEtu1nDoGWwNN8hw9ySKQxh3fhx3WCharWZfl8NLOt6DDfbXtjPc9VxDfgiAVIPI2O1lGiixYqLUQOJKKtXFceLR51R5BEjjOHa4mQOzGxsZW9iAck0ioFuNYwetAoPPpnJnEFeAk2J6H4yzQjUgjk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756918475;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7WdYZEXC6O5mRGfLpDBkGN8H25EvnFvIzc7KmEQNUo8=;
	b=IsTK7dFzFhrJMg20s4XZnfRvA7LatZIg12EmMPmYg54oaH8ad3o66ID/CAh7hN4V
	qe4uvBxHTtY2j32S4INqMgW7F93Cf27LcEX/vH6acM2NYwcm9WEQxtazbkuZKLHqruY
	YF87Gs8q6fLEg3o4SzeCDrkqMvaPUyoOneCaekU8=
Received: by mx.zohomail.com with SMTPS id 1756918472587914.1197745405617;
	Wed, 3 Sep 2025 09:54:32 -0700 (PDT)
Message-ID: <5378349f-4d00-4d3e-9834-f3ddf2e514cc@yukuai.org.cn>
Date: Thu, 4 Sep 2025 00:54:21 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 02/15] block: add QUEUE_FLAG_BIO_ISSUE
To: Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: colyli@kernel.org, hare@suse.de, dlemoal@kernel.org, tieren@fnnas.com,
 axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 kmo@daterainc.com, satyat@google.com, ebiggers@google.com, neil@brown.name,
 akpm@linux-foundation.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-raid@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-3-yukuai1@huaweicloud.com>
 <aLhBqTrbUWVK4OKy@infradead.org>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <aLhBqTrbUWVK4OKy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/9/3 21:24, Christoph Hellwig 写道:
> On Mon, Sep 01, 2025 at 11:32:07AM +0800, Yu Kuai wrote:
>>   static inline void blkcg_bio_issue_init(struct bio *bio)
>>   {
>> -	bio->issue_time_ns = blk_time_get_ns();
>> +	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>> +
>> +	if (test_bit(QUEUE_FLAG_BIO_ISSUE, &q->queue_flags))
>> +		bio->issue_time_ns = blk_time_get_ns();
>>   }
> Given that this is called on a bio and called from generic code
> and not blk-mq, the flag should in the gendisk and not the queue.
>
ok, will change to disk, and also change set/clear the flag to
enable/disable iolatency.

Thanks,
Kuai


