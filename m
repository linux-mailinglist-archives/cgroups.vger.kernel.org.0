Return-Path: <cgroups+bounces-9766-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF9DB4679A
	for <lists+cgroups@lfdr.de>; Sat,  6 Sep 2025 02:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357815C634B
	for <lists+cgroups@lfdr.de>; Sat,  6 Sep 2025 00:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749A1146585;
	Sat,  6 Sep 2025 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecSwNTQV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2209B3FC2;
	Sat,  6 Sep 2025 00:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757119113; cv=none; b=tAEUMegIRiIBogRDhi9pg077LNTSQdKDnm3DJItLDQ+DVfBv/v9Hj3a1vTlAGKw1baYAjdd5AxVFN74ztGExNQtaNdXz2Tq9b3yxUTOg14c/guqT4baJJDqKJQ+t07sURfZQMcQKskJpucy9GxAJFtqwenVn9+El//6kcBDVdXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757119113; c=relaxed/simple;
	bh=r5hRDI52a9QummrrvIrNZWkW4GnXqtrBUMH2FBxPOew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMGsp9ZzsyVZVtBmhgkX9y6/oDEG87IS8HQDgWnE6Gkh+n3OiTXb5jaqX/Zx4R02e34fbx7FfASRKRLKOLr4hIygAsPtK7fHb/TVk/Xz3MVSEl+t2tpBaXNqJYeFWvnuqlvr8BmnG3Xxpzlzj+yuCRItoYOqX7xm9dQ6xpu4/Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecSwNTQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53BCC4CEF1;
	Sat,  6 Sep 2025 00:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757119111;
	bh=r5hRDI52a9QummrrvIrNZWkW4GnXqtrBUMH2FBxPOew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ecSwNTQVLa9S89BQSpFsPy8CeKuG4ATjgWq8+c9bna+eGtbKNi8hix/422H/z7euJ
	 HLmqzlEPgxmtkNfDjnMFdMicpj+Ct8orPlMnFLzA7JY2bz5Sm7fgVUPJzr64a/Si0k
	 hmzM5dy0EHgI5AOI4X5K9IHXFm2jm420wkMAlol4arATfUm63b0AWkHB12rTxuKV7K
	 P0qCbqtoPzdTjV3I+qL2BptPLJgwrTGiQFIclH/69w7LvDTEUQNaMq8XN0LHIc7w2E
	 PHhiCPHTxQ6e6DsP/foFLdX2EsjoWNhKNynWEBaRQNL4/fWAQZ6NaSAQyp0NtatVhk
	 9H7/ZsvbUiYbA==
Message-ID: <e5d0cf8f-5ca3-46ba-9291-105d1812a73d@kernel.org>
Date: Sat, 6 Sep 2025 09:38:26 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 07/16] md/raid0: convert
 raid0_handle_discard() to use bio_submit_split_bioset()
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 hch@infradead.org, colyli@kernel.org, hare@suse.de, tieren@fnnas.com,
 axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, song@kernel.org,
 yukuai3@huawei.com, satyat@google.com, ebiggers@google.com,
 kmo@daterainc.com, akpm@linux-foundation.org, neil@brown.name
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <20250905070643.2533483-8-yukuai1@huaweicloud.com>
 <e4f749f6-3d89-4342-b896-8f32a55907ec@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <e4f749f6-3d89-4342-b896-8f32a55907ec@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/25 05:49, Bart Van Assche wrote:
> On 9/5/25 12:06 AM, Yu Kuai wrote:
>> Unify bio split code, and prepare to fix disordered split IO
> 
> fix disordered split IO -> fix reordering of split IO

-> fix ordering of split IO

the fix is to reorder IOs :)


-- 
Damien Le Moal
Western Digital Research

