Return-Path: <cgroups+bounces-2225-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328DB88FA8E
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 10:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33C229B3BB
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 09:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027295789B;
	Thu, 28 Mar 2024 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWsMcYla"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBE457895;
	Thu, 28 Mar 2024 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616452; cv=none; b=VNTYiE1x01GSFBeXLoFvP4UyL42y+QjuV96aT4P5pdF1SKmAMUXjnDjIUcRIcSuzNs9tkJKuf6F84SNxVNwXpJ2MjwhgRVlGyOOY0CmETsvkhp+RoN3xT73V7VeozYEG8qFvmZq8uyQOhHqOCOLjEbwgHXMRBdAQHI66l9d/cwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616452; c=relaxed/simple;
	bh=jwTb8m5Oxe0QJQMbCTgIs+0b0zIc3iCLsTfVp5oVSUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r49e4w+RmgdamlumwQUgXm8XWHU1xC4neAGKYLaWSBwnnAJOwhR1YEpKtzt8uPvshDKAxhT8wEoRb0AA2y64hJOf5XgpKcNBlo63ZwjWeGj3bobdtXvuP6zzeINNa63RDnQJrublTDL0K1X5Qz79SUTnP9Sj3AuICFrNtxaLPkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWsMcYla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ADFC433C7;
	Thu, 28 Mar 2024 09:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711616452;
	bh=jwTb8m5Oxe0QJQMbCTgIs+0b0zIc3iCLsTfVp5oVSUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZWsMcYlayNfOsP/+4zGuyJXY4ZKA4nmAZuH6gcY84qt21yrqh3yAYO3R2NBgl94QU
	 2a62Su8yLQ+ifGGfc9QZyGO9cKnf//lzgt8go0DJedTuCc+/gwKE+0DMUv6F9j9TK0
	 U74senp5eC7oqgoeEt+kE72HjBXnpKmKU2nPYC8++olZ0q4Ld1e+J8YvKlu/732vgo
	 kf50L1XGCz7oxm4h9KBi+OqNs4MN1YEkIgC4SBj6m8d1nLC5U6aPF6EcZXV4K7+IRS
	 Bk2UzH9C2Ixe+NIvwpJAISo/0OqJHv+rQpn27xzKuW+Uub43pG2smTpPw0RGvpBHye
	 GkMzf76zIHjrA==
Message-ID: <cee45f5f-8004-4b3f-b347-d297be761bd6@kernel.org>
Date: Thu, 28 Mar 2024 18:00:48 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: add a bio_list_merge_init helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Matthew Sakai <msakai@redhat.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, dm-devel@lists.linux.dev,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-btrfs@vger.kernel.org
References: <20240328084147.2954434-1-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240328084147.2954434-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/24 17:41, Christoph Hellwig wrote:
> Hi Jens,
> 
> the bio_list API is missing a helper that reinitializes the list
> spliced onto another one.  Add one to simplify the code similar
> to what the normal list.h can do.

For the series:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> 
> Diffstat:
>  block/blk-cgroup.c            |    3 +--
>  drivers/md/dm-bio-prison-v2.c |    3 +--
>  drivers/md/dm-cache-target.c  |   12 ++++--------
>  drivers/md/dm-clone-target.c  |   14 +++++---------
>  drivers/md/dm-era-target.c    |    3 +--
>  drivers/md/dm-mpath.c         |    3 +--
>  drivers/md/dm-thin.c          |   12 +++---------
>  drivers/md/dm-vdo/data-vio.c  |    3 +--
>  drivers/md/dm-vdo/flush.c     |    3 +--
>  fs/btrfs/raid56.c             |    3 +--
>  include/linux/bio.h           |    7 +++++++
>  11 files changed, 26 insertions(+), 40 deletions(-)
> 

-- 
Damien Le Moal
Western Digital Research


