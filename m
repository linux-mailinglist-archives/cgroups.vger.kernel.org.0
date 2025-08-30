Return-Path: <cgroups+bounces-9497-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E783B3C6C4
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 02:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDB7171A4D
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 00:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8811D54FE;
	Sat, 30 Aug 2025 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoWJAd7q"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF91F936;
	Sat, 30 Aug 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756515006; cv=none; b=A6K7k8uZQ3isMxzuuuyrkas8zd1Xn0S29tCL2GU6Yv/n6dpj9/2a9MtP5dI8BkRoutpdw1xzUdXBQD6H8xjFztEbtUHPJJGBFarMbWvsOv2stZhb0Vo6ckIH3AvQ6lMSdsjqdePX+S6YG68JEKvR73wfWC0G/e+umPXcy2YCrrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756515006; c=relaxed/simple;
	bh=4U/3AuCLeQW794nmqxMqi8puaH3JW6OOV6l5phr8A+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkWXOGbTTBWvAb68hYL9xpP4fkKOG3Q8oT7ReZlX3R+qW6eEg7QtGhZIXFvTZ5MDvJpiJe07jTUhnkYl+rgGAhAMbMs8HFV9odajp/3bY9jLVMEtqJmdtCwYzB2cSmwtX6k0WffmW1dv24uiMIN5ciBrs9qsNQWuh54mrRQHKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoWJAd7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7965C4CEF0;
	Sat, 30 Aug 2025 00:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756515005;
	bh=4U/3AuCLeQW794nmqxMqi8puaH3JW6OOV6l5phr8A+Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RoWJAd7qW57etfmY1iGF+NA+X50mZBVUmmprUIvjPW1zlqVT4Tnnh/5FQhUPzx0TU
	 dZl1BUDKR1XFoktAEI1Dd1YikKvdv9riY1fRKIooptvnfk586+6DzUzyZbFrsJui1o
	 YAX8KBSKzyI1uN3VXmucHbY40TZ0CmN0wTR3COJRSw6cOox1BF2ouBiqufT2hee3SQ
	 3b707Ojv1mYA2euPOQDnlyieIuVyHiivLn6VQcxzJTlhjtZpN3vzdUpBLjlqAsBrmC
	 zf9HXU/EBVElGFBiFEhLLX2iiEKvCIVvjiorJNhlmlhNdNMaNmAKPld/ngbN7fbmqO
	 IPRcDuPWiymOw==
Message-ID: <7920c82d-e307-4b8b-a3da-73cc2bc75784@kernel.org>
Date: Sat, 30 Aug 2025 09:50:01 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 05/10] md/raid5: convert to use
 bio_submit_split_bioset()
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, song@kernel.org, neil@brown.name,
 akpm@linux-foundation.org, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, tieren@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
 <20250828065733.556341-6-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250828065733.556341-6-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 15:57, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> On the one hand unify bio split code, prepare to fix disordered split
> IO; On the other hand fix missing blkcg_bio_issue_init() and
> trace_block_split() for split IO.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Same comment about the missing blkcg_bio_issue_init() call... Separate fix patch
first ?

Other than that, this looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

