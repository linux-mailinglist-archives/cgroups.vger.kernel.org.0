Return-Path: <cgroups+bounces-8530-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61647ADA66E
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 04:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9440E188EB81
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 02:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723D61922FB;
	Mon, 16 Jun 2025 02:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBZifnpa"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C0123AD;
	Mon, 16 Jun 2025 02:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750041996; cv=none; b=or7GGf0LYD30Vq71DpmvtHUQLBdJyCMPXIXnqnsQRg0uko8V0GUqdreBTnuhc6toy/1bPPIDJRHUrXdSwzCtwiZ+G2LLqxwJiTYxho2Vck06JqG7JIJldsYPvmVS0/MJxkOMRR3Aw9DTEv6lYZW+hgsKONJggTBDvjyv2T0CvxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750041996; c=relaxed/simple;
	bh=wJvmwvSD+YkCIiDpdRJYVYq/38i1xbnya3KSea6L8Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqTt5JbSzQM/ZhCdhMSTVY+qITYexOr4hr0j5EViz9uB3RPrNwTzv4NTIllk3EM+NnWO83V5mtimfdZg94o4gJYhRVfKgpBqXMHNaDEn6FNf7Vr6zU531JNX+SL67k8HLJ1Bf7LkEj8uOEb34U9znahPfmCJx64sxWJA+/AS1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBZifnpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1616BC4CEE3;
	Mon, 16 Jun 2025 02:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750041995;
	bh=wJvmwvSD+YkCIiDpdRJYVYq/38i1xbnya3KSea6L8Ks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jBZifnpahyggAD0yBiXHQWIESzcdElxHRG7Pd8CHuaSXT/WlWO1jgSkpBI219nYOW
	 XrDyjZ+D+M9La7IGAIgPi4zBizOMtCwv3RymcTK6yOiv4Vj0Ber9Onw+I1a7diaUa6
	 ThB5l15dj7azaxtSLdoXEbIdbgPVcxcMUKh0G4Kwjpk5RMMxMpvcUlXCM+db0SxvUE
	 Om/fefRbo8JTfLc5fTI19w7BCDDdxa/hW8D0Wr3LZqkndv9R9IIDNwmVi31wnBVzFm
	 G+R8bs5ha1k4jvukR33NzTrtewUs8qPRnLc75ZrJpTdcwRPLCaqYKDxCJtv1p0B2sV
	 /wgB5L/U0GtzQ==
Message-ID: <8c17ba4e-98b1-4ac5-8c0d-fb5e1c13f7f2@kernel.org>
Date: Mon, 16 Jun 2025 11:46:33 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/5] block, bfq: switch to use elevator lock
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com,
 yukuai3@huawei.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250614092528.2352680-1-yukuai1@huaweicloud.com>
 <20250614092528.2352680-4-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250614092528.2352680-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/14/25 18:25, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Convert 'bfqd->lock' to high level 'q->elevator->lock', prepare to support
> batch requests dispatching.

Same comment as for the previous patch.

-- 
Damien Le Moal
Western Digital Research

