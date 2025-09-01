Return-Path: <cgroups+bounces-9546-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 623F5B3DA17
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 08:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E585C1897157
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 06:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65855258EDE;
	Mon,  1 Sep 2025 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk6JOGWb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1645D21D3F5;
	Mon,  1 Sep 2025 06:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756708823; cv=none; b=YgCgwj/D0dOc8Qu2TdKqSGps1nX0SNiqp6NLBZVWC+iMy5gmfKKMgXVNZ1SShjndpP7+SmpkgghEsyezXnGhnEE0+7NSE5zAPWUGjZDWs/CPX9H7M8nLa6ef3DK7XEA7+t7aXzUtvUG3rb+k23yt4H9ZmXrEMcHgZeWdfxNF5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756708823; c=relaxed/simple;
	bh=RXDj7xK0ck/gx9buYEpnUyuWq5E4nYhKUE+rPIgPH3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDK5lMQK6BcR9p+tuEvpYgVPInufGTcluGdqjwrtnKEGlmMy3AmQ1rzF5Q4Z+vj6smcUwR1XXZJJxesVbk2JBskhdvYlUt88CLhnIb4OdgYxK0pruT21hZ02N3Buo8wbhRqJOMCB+gbKWXAr2Oucgr1B+MQRMwql0sevvkzbH4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jk6JOGWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9322BC4CEF0;
	Mon,  1 Sep 2025 06:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756708822;
	bh=RXDj7xK0ck/gx9buYEpnUyuWq5E4nYhKUE+rPIgPH3k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jk6JOGWbk7AXGPMMwGsumxHUONuqTrN7ZTmLB/5OhbnNES2j3RCGW5Xjv+7C+BvLf
	 hTRusQhAMr//AWBAEjeIziWkW+LTMEFZgsweJeD85R5owtaxVn7Ydl6InnNIau0HLw
	 Yn8lm4GS/p3wPBuBS3QwtxRCsR7jX2h3084v0zepZI4DaPmZu8eoQOvzQOcRGeWnf9
	 mW8bgwAOXQsutnPIRaYUSOhmcuI6M2zGhUhq+9EJXVq9C6ruCiB6jrb1h+0t1OA2qZ
	 tm3Hys2FzG6p3JOeiWZtzN8YWW4Q7+XGNOPisV4eoUGw9UuJESAfl1ZNMFFOG63mG6
	 dMKAll7I4KFPQ==
Message-ID: <aa6b1a62-787e-4365-aca5-d03c6b94545f@kernel.org>
Date: Mon, 1 Sep 2025 15:37:25 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 06/15] md/raid0: convert raid0_handle_discard() to
 use bio_submit_split_bioset()
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, song@kernel.org, kmo@daterainc.com, satyat@google.com,
 ebiggers@google.com, neil@brown.name, akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-7-yukuai1@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250901033220.42982-7-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 12:32 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Unify bio split code, and prepare to fix disordered split IO

Missing the period at the end of the above sentence.

> 
> Noted commit 319ff40a5427 ("md/raid0: Fix performance regression for large
> sequential writes") already fix disordered split IO by converting bio to
> underlying disks before submit_bio_noacct(), with the respect
> md_submit_bio() already split by sectors, and raid0_make_request() will
> split at most once for unaligned IO. This is a bit hacky and we'll convert
> this to solution in general later.

I do not see how this is relevant to this patch. The patch is a simple
straightforward conversion of hard-coded BIO split to using
bio_submit_split_bioset(). So I would just say that.

> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

With the above addressed, this looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

