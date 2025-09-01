Return-Path: <cgroups+bounces-9544-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6ECB3DA0E
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 08:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F9D1884071
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 06:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4862580E4;
	Mon,  1 Sep 2025 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOR9LGDT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3100522156A;
	Mon,  1 Sep 2025 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756708480; cv=none; b=JSL28PycXBpDBSAS5u8gwueMzS5OmE94eyPMW8DZbsS1HVEE2z1pX2+EjwAGHff8+rZWVb5sAldVCPwAKSxNMbXsGA+5cgwQenaxNzdanpcCuciEi2I47BUY0xWg3Cmh4NcGUPQ/IyDB0qEPHIYMVei/yTy33utnngt40EMsCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756708480; c=relaxed/simple;
	bh=I/S/wi8oF/tnDG2puHH+xKqITXjDX3LTp5nAHiKjltI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJZH9P7h2JaZnDZdEB+rLoucy/wy0PPWOB9lkz6lEFox+NwdxNbpWB3GBe9PM5/i5Wh3OgZAXtX4iquA7cqNWbWHdgY+VjWScJi49gBCA/mViCeiEyEZj0gNShCGkt6sV3cza2jGDZJGJh60Mc+NiaCkN+6tqPdQEDRIeN3Wbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOR9LGDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA85C4CEF7;
	Mon,  1 Sep 2025 06:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756708479;
	bh=I/S/wi8oF/tnDG2puHH+xKqITXjDX3LTp5nAHiKjltI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HOR9LGDTbGwoevH3JXtWQcKDOCBhjsmzU2qE1/S52sZqsyDP+dO0C1pGOwDKFsXfA
	 XW6xIWA2M9gnht7Jn0o6gOE8+eMQkDg9DUUV/n4iY202z/conBFvPOlZzGes8UJWuZ
	 Paxm+HN3kXanAD8sRtbnOQpoHMNEzz29/fzbUV4DrcEdqS/E0qe9iBZ6nTOdl66NMX
	 TLwCDNg4gNazMixBfllErsOZJAPeoA1kox68dGl+fshQ+EqNsFNPKvqHL+b43ykG5u
	 bkcoZ0mSh+msKTz+dZY10jEwcNtYt5GZalUF9XlfugX2UIhUk/6b63ExBamrFcw7XD
	 qqlEkCM3O6zIA==
Message-ID: <d0e213d7-0e9f-4fcf-89fa-d58ec326461c@kernel.org>
Date: Mon, 1 Sep 2025 15:31:43 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 04/15] blk-crypto: fix missing processing for split
 bio
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, song@kernel.org, kmo@daterainc.com, satyat@google.com,
 ebiggers@google.com, neil@brown.name, akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-5-yukuai1@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250901033220.42982-5-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 12:32 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> 1) trace_block_split() is missing and blktrace can't catch split events;
> 2) blkcg_bio_issue_init() is missing, and io-latency will not work
>    correctly for split bio.
> 
> Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Most comments I sent on patch 3 apply here too.

With that,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

