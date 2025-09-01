Return-Path: <cgroups+bounces-9540-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7313B3D7E6
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 05:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34743BDB7B
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 03:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6355221F39;
	Mon,  1 Sep 2025 03:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkb4mG5m"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5632E1D432D;
	Mon,  1 Sep 2025 03:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698400; cv=none; b=Xee5eg6RFl5k9HGGM0BFKrJQcdcQVJLJrmWL62lB863uxs4QuIylNNx6LL8EVNR/P6QyY+JpGKbnnY8ag7se8i83W9yjNLY2EOrJeuDQcC2H8Rwmux+C+XawHBkYGqyJp1le1GFBuEo6Dix5esEEhAAi84LEWgfPEZvFAGHHIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698400; c=relaxed/simple;
	bh=60r1YdoWzFDEVrwyX1ee7zPgrE8MvRU3cRlKkVfbB8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FT1DkdNc2RR7mqltR+4LlIayrPZN6GEJANzgm/ZFkOs2QNwLNXD27abmXkHXk7r8I7iInTOJbWJZUVrXHlhJgkOivVnV5n5Y8onwYbXWBMWuE6qvurhlRtfETXx1CqPHZJAH84q7V1Xlx54Sc24I3V0o71VptXF2TNq6vKaa1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkb4mG5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867E4C4CEF0;
	Mon,  1 Sep 2025 03:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756698400;
	bh=60r1YdoWzFDEVrwyX1ee7zPgrE8MvRU3cRlKkVfbB8Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gkb4mG5myaEfn49iiCAq8xCKnhhO+O19pDcmzEy7gFWA4uWoZ6nH9BtiqeLbNXwbE
	 6XLm/G42T/+hRPV/SClJhTM1T12Kh1XBgugsnYzLoLVCzla+BHJaoz5BASRkBviH6S
	 hUvguqJxjQVhB+Qfc52Y+eTScDq+m1V1oIDtEPOyfQDS8fTIVYq2uEH1JCL3wBo0To
	 R1452+k/1B+utrpzBr7+Dg4U8umZUPcl75dScMD7UfQXJDgWLJwyBa7XIFIwx9aYlE
	 4ub9acEaUA0L08t/nszp17NAdohzXB7ewL1xVcfHiOi6C+2D6r8reyo8t29+/u90Wl
	 5lsJC1ckWbUCA==
Message-ID: <7ef5c6dc-5eae-41a7-9403-0d8616668c4b@kernel.org>
Date: Mon, 1 Sep 2025 12:43:43 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 01/15] block: cleanup bio_issue
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, song@kernel.org, kmo@daterainc.com, satyat@google.com,
 ebiggers@google.com, neil@brown.name, akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250901033220.42982-1-yukuai1@huaweicloud.com>
 <20250901033220.42982-2-yukuai1@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250901033220.42982-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 12:32 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Now that bio->bi_issue is only used by io-latency to get bio issue time,
> replace bio_issue with u64 time directly and remove bio_issue to make
> code cleaner.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

It seems that this patch is completely independent of the series.
Maybe post it separately not as an RFC ?

-- 
Damien Le Moal
Western Digital Research

