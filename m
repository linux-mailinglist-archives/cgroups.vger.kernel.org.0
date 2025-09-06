Return-Path: <cgroups+bounces-9767-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09F8B4687C
	for <lists+cgroups@lfdr.de>; Sat,  6 Sep 2025 04:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922E5AA21D9
	for <lists+cgroups@lfdr.de>; Sat,  6 Sep 2025 02:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DA42116E7;
	Sat,  6 Sep 2025 02:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="QUpu/zmZ"
X-Original-To: cgroups@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1291A17BB21;
	Sat,  6 Sep 2025 02:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757126617; cv=pass; b=jeNK3b/r/sSpYRnCYOoKbgCOQXK9JpbQSz2qCsV+DnNmo2hem4z71RhkVsZJIGP18nRl/dnvwkB98vigejOpAdP2kF/0m8eRY+xxqHv5pOcRAKRyBo8eATiJNvRWkTyJ3+SxTWqwAmBTNSjGH/Qtqd1Of0eLEXZMSa3D7/cBUNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757126617; c=relaxed/simple;
	bh=EEZ9WRFEF2Fy/k4ANVFTn4rKSWziZVxbMak+++nZFEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USoTYkSQZ1Uy7IWJBTVWVUzBeBA4RJj9os2e5c1CJkBELXZX3/apbPr0EKVYR7v+A9UKXKmw1CwAfCYE9vJ8a7YmekwC+wq1QUQQiPnqiy23brDfkZKlPYIyiT1L61jb2np+humU4o8/YIVOdAGJt+cnYWO3f38z8xbfRaY2obU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=QUpu/zmZ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
ARC-Seal: i=1; a=rsa-sha256; t=1757126559; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y9nFSnyBJdTyLv9qRIQjuBmuk/Xl6T1mHKwEeJUEddd5q8Ar06xoJ8lnPHO8Swx6akpuRLXdCGsStynhSkZulnW6HwpDKCCXh7Tofk5S3gzNfRNnvrrNd0/2QnagAm4u+1wR/zEh2mW5VWTC5xdW9jXAgK7dXwqiH0/xq9Qp4O4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757126559; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EEZ9WRFEF2Fy/k4ANVFTn4rKSWziZVxbMak+++nZFEE=; 
	b=iZjkJ8gvFI5ifhf9rjtpuB5eU51ZmhlHayrh3rDTYj+VU8YyewkQJIOP4JZD0Q1a1ULuZlQ8m5OW2xAW37tA+JUmMYE3Mq7SeyEh9zlbjxpE9yLUgHDw3vCr90Cg+jCQ0PVoau3fiQfXU9uY9ls8CHp6M2WDrD6cU9JhJxQLhZc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757126559;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=EEZ9WRFEF2Fy/k4ANVFTn4rKSWziZVxbMak+++nZFEE=;
	b=QUpu/zmZA/f8gexuBybB8exOl63cxxurojR7l+YbYO3qxRMrZADzM7V/s7YwDCxi
	e0wbohzZoFlqkYUZjObTvsKl7SBfn6tebvwTetcmoU/DlnVFfNmao8PN9Iw/HrH/OQu
	ITllRHXxhNjx2hB3Ch+9TjCd49LNtPeAyzdQYbsY=
Received: by mx.zohomail.com with SMTPS id 1757126556654411.8255802906366;
	Fri, 5 Sep 2025 19:42:36 -0700 (PDT)
Message-ID: <9b6d8503-335d-435a-a38b-ec717966ac1c@yukuai.org.cn>
Date: Sat, 6 Sep 2025 10:42:25 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 13/16] blk-crypto: convert to use
 bio_submit_split_bioset()
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 hch@infradead.org, colyli@kernel.org, hare@suse.de, dlemoal@kernel.org,
 tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
 song@kernel.org, yukuai3@huawei.com, satyat@google.com, ebiggers@google.com,
 kmo@daterainc.com, akpm@linux-foundation.org, neil@brown.name
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-14-yukuai1@huaweicloud.com>
 <d9c6bf32-4131-476a-aebf-c31f549368f2@acm.org>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <d9c6bf32-4131-476a-aebf-c31f549368f2@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/9/6 4:50, Bart Van Assche 写道:
> On 9/5/25 12:06 AM, Yu Kuai wrote:
>> Unify bio split code, prepare to fix reordered split IO.
>
> reordered split IO -> reordering of split IO


I'll fix this in the next version, and the same as other patches.

>
> Anyway:
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>
>
Thanks for the Review!
Kuai


