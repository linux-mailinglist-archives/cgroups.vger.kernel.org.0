Return-Path: <cgroups+bounces-9543-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C454DB3D9FB
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 08:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A26D16B729
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 06:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D9225784E;
	Mon,  1 Sep 2025 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNbunhtm"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D15B1BC58;
	Mon,  1 Sep 2025 06:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756708400; cv=none; b=b3dkyNITlfNeMDI4ykds1l0iAg1QHekMLYFh7mhMRAydL4ZvO2HlESI0wqDev/EvNy4z5TC6hrAPnzo7cC4sNFcWw3O/G3nyZLo2ZvD8PjYTY+NqLiTHOBH5Z5F9XjyQGF8CGhSjVp+tKRLgB9/w06KWbZ0ZyG9zPL5wcc/8mms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756708400; c=relaxed/simple;
	bh=E02cI/V/1+uVz7ukXOcf2OhESz1lzdkC/RxD8ik6jeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzcJLCe1FannZrLjrcBm37FapmbhohprtP3r79RoCLJsTLB5PuSvxCMoaOHG4wY2z2blDXmHtigYarAn5fOLIrlP9dTRCDpIj+ziwTTkvuoP+OArHV2VrlzayRFsWaVgJsngiw3np0OoCeQoCNjO8dr3TTj7Z1fle1b+R3736Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNbunhtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E8AC4CEF0;
	Mon,  1 Sep 2025 06:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756708399;
	bh=E02cI/V/1+uVz7ukXOcf2OhESz1lzdkC/RxD8ik6jeA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BNbunhtmp6ZoYHwA0dputtIcQxvtuo6lO/SfbzMVSWlCP18VDz6IZu0iqd2wzKQ+P
	 eOf8SK77+MDexFBxmVc7b8MnGjs4UMQzv4QLluIfdqd2hfZyVEbo68D2SriO0dFDPd
	 qh6FnUtf2t3xeSmfvKPPPKbXwrrEM+Zhwu/viPSuFZoq8qtgkBaDOYMjcAW0LyiLN2
	 ouHmt5bovlVRTDEWiABG3k4bL8fT7wQkNfz59WsTXlK78rpEyTG6UbS6FNAchK6xRL
	 CrhdV7PPGD7OnX8lDHS9N5bBNPPw86ci/ok0pjlWrfylQlYnfFm4XC0u6lxxHGgVfc
	 xY0Zkjpk8LwFw==
Message-ID: <c7182d12-4b57-4133-9412-7587a98b86bd@kernel.org>
Date: Mon, 1 Sep 2025 15:30:22 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 03/15] md: fix mssing blktrace bio split events
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, song@kernel.org, kmo@daterainc.com, satyat@google.com,
 ebiggers@google.com, neil@brown.name, akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-4-yukuai1@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250901033220.42982-4-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 12:32 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> If bio is split by internal chunksize of badblocks, the corresponding

badblocks ? Unclear.

> trace_block_split() is missing, causing blktrace can't catch the split
> events and make it hader to analyze IO behavior.

maybe:

trace_block_split() is missing, resulting in blktrace inability to catch BIO
split events and making it harder to analyze the BIO sequence.

would be better.

> 
> Fixes: 4b1faf931650 ("block: Kill bio_pair_split()")

Missing Cc: stable@vger.kernel.org

> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

With that,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

(maybe drop the RFC on this patch series ? Sending a review tag for RFC patches
is odd...)

-- 
Damien Le Moal
Western Digital Research

