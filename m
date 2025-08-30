Return-Path: <cgroups+bounces-9499-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69725B3C6D1
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 02:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B03F1758AB
	for <lists+cgroups@lfdr.de>; Sat, 30 Aug 2025 00:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6D121D3DF;
	Sat, 30 Aug 2025 00:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a668jG9n"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F22033A;
	Sat, 30 Aug 2025 00:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756515318; cv=none; b=lUmZ7JawRnGRM4vqPY52t4oI5PTlFUheN+gbqj+xnepoFPrkYxW/SSa0oku4F/0DoT6fRbQHSZ+y0C52uR8lLI+txKO1OwVoX4qNAbsMuCZaUkiEnJ6VoXA7auTqUq2xo6rPedmROVnlRpGuexg2OYkfy44CdAgIZ/IHKpxgE70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756515318; c=relaxed/simple;
	bh=5Pxk7Q/Mh5IJS4y5ckkMXdtE7YuwQmCUpK8wYNzWC2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eM0Wvh+O7DirNXJH+TxxigE4D5+PfrqIBy/oFZBnfnbOgY0FpJQtDC5B9zqrLg3ort86Y8JgeReSihM+Seo4eb1t0ebgRYNuriyuVtMeDlJcw2FqpChinfwZon8mZExjfFF/dtjM14Vkf+ehC+oCSmcqWwtM+vpLWbIE+6CQwtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a668jG9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE01C4CEF0;
	Sat, 30 Aug 2025 00:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756515317;
	bh=5Pxk7Q/Mh5IJS4y5ckkMXdtE7YuwQmCUpK8wYNzWC2M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a668jG9nEv6whAoeeYAy5npAbc6I3gwwfuWqcKladQOf3flBraBBs+4I8sPtDc9OJ
	 bbBIXUnRa5q4bf3ydn8qa+ZrZR7k32/HXEZAM5pfx4wvJQqrdZAyXUmIdK59xg2TPN
	 nnee7AHMFQnlQjb5z7krMHFXFq9vO7D3L+G8OM0zl6HgeryapywCtaAIOC85QCnCTj
	 h5Wi9njmNkvXTIS4jAJdm5URR08X1JQgw5/P4FwyV1uXpjjqX2EK/EMm4zCRsH3nRO
	 9fWkULvh+2nfFkmdGDAC56zQij8LJP7mydB/KJsp+pD4FKZ4ZLbpShUgF4FlLOpD2/
	 UFRS+uF8W0HFg==
Message-ID: <6f7adfe7-a3ad-4439-91ed-bb65936368c9@kernel.org>
Date: Sat, 30 Aug 2025 09:55:13 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 07/10] blk-crypto: convert to use
 bio_submit_split_bioset()
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, song@kernel.org, neil@brown.name,
 akpm@linux-foundation.org, hch@infradead.org, colyli@kernel.org,
 hare@suse.de, tieren@fnnas.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250828065733.556341-1-yukuai1@huaweicloud.com>
 <20250828065733.556341-8-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250828065733.556341-8-yukuai1@huaweicloud.com>
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

Again same comment about the missing blkcg_bio_issue_init() call.
Other than that, this looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

