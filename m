Return-Path: <cgroups+bounces-9498-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EBAB3C6CB
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 02:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3C5A07A7B
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 00:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FD01E98E6;
	Sat, 30 Aug 2025 00:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFazxpOz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6021A76DE;
	Sat, 30 Aug 2025 00:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756515080; cv=none; b=uKuYQbo7HBxExdqCugl1aGzXi+aJmw3i6MB6RLGgC+y92jMztHFUSK34RK0TSWgT9R2MFTORA2CUS69Y5gpvaxykpUSGnxG4TxV6EzO/96AB0I2QOmVpgciYf+aBCwq1BZ+3wL1rzUfZGbVYJIs6xHuAmC9ouQckmPKMa/H8iyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756515080; c=relaxed/simple;
	bh=4zGTkUfv8HDyg3aR2u8NEH0gwiVNSV5E5E6u6XHuMQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j481nufePak/n6kScHCxdxlCtRfNEnHooGAQdLMZRYHRTPt8bljdjHFeFOKO27Kwz663AwMBudZy3iXnXZPo4e6+uqga+Ib4AhBExzzTO7BfgeNiKdobD0SFOsmeOVETAHr+nS1nVP8tH5rU21pwJhidE1McMBFGrMQ4USx37Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFazxpOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8998C4CEF7;
	Sat, 30 Aug 2025 00:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756515080;
	bh=4zGTkUfv8HDyg3aR2u8NEH0gwiVNSV5E5E6u6XHuMQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YFazxpOze9STMhS3/EWqLP71o3hbphUnbSUtv8tKWt8rCrwS1cQi/Gz2a7kn1xF46
	 hQVEBK7HKVSNBS/J8zGzsxNsvIHVatTYmAAXTtYuAIGHrJMvoqELVJdCAXDGnyRic+
	 f7ex1v90poyRUFZNPYbekErYfnK0NfrjDCpxST/mndrskOG7wDIBB41l3eqa5Yo6QC
	 s1ws9+IA0NLBvTchIVzip07F2jTXf2qjOZGRt8g2axbdj40nzl0dXrzcTmGyd60WNG
	 qxw6+Y8YFXzLLT+GMdTJokwS9cDJWcQuxLcjfp5KWkqG+5j9VVA8I8l19NziTpQPSQ
	 9+nmAZXwRtmnw==
Message-ID: <fbfb5410-0418-4ca7-ac31-fb9bc9990aa5@kernel.org>
Date: Sat, 30 Aug 2025 09:51:16 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 06/10] md/md-linear: convert to use
 bio_submit_split_bioset()
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, song@kernel.org, neil@brown.name,
 akpm@linux-foundation.org, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, tieren@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
 <20250828065733.556341-7-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250828065733.556341-7-yukuai1@huaweicloud.com>
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

Same comment about the missing blkcg_bio_issue_init() call.
Other than that, this looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

