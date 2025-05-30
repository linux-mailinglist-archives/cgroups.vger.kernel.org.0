Return-Path: <cgroups+bounces-8393-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9D5AC8876
	for <lists+cgroups@lfdr.de>; Fri, 30 May 2025 09:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDECE7B20E5
	for <lists+cgroups@lfdr.de>; Fri, 30 May 2025 07:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98098207A27;
	Fri, 30 May 2025 07:02:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395931E5705
	for <cgroups@vger.kernel.org>; Fri, 30 May 2025 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748588554; cv=none; b=TALtLFsnfQopnXtIdOG3X53usl6A9AX9Qpc9IucoOckaxSWUxPcxT36HtSERHwIFJXXDzH0IFAS9WWKUIKbRVWTPHzq+QN9LFSie086rfYm7dsY1ZKPULHBqbcpmleGtoR+B8Hkyyy7qf9rwpqZe4Ui6RyHHgNKWvO+5G/5bQLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748588554; c=relaxed/simple;
	bh=E/O9HAYc1pxKvwei2SjnR9l+4Xm5rk6K33BGfGo/hgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9s7Pa8CevPGbNxzmc4ETNSVauhoXOFl578yhLzIj241gt4oDHDZVZOF6yzfIQ7/dcT4OrKONWeLkIOUD0AGIDjkFHbUuRb/RxoUsnfSL6iQ3FLhPNL6CedWu7o6OS0AC0idd+aYp6E6039k/3ip5dUxoER7fxh95POFNS6nHIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 30 May 2025 15:47:30 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Fri, 30 May 2025 15:47:29 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk, baohua@kernel.org, osalvador@suse.de,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu,
	pavel@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org, peterx@redhat.com, gunho.lee@lge.com,
	taejoon.song@lge.com, iamjoonsoo.kim@lge.com
Subject: Re: [RFC PATCH v2 00/18] Virtual Swap Space
Message-ID: <aDlUgVFdA7rCUvHx@yjaykim-PowerEdge-T330>
References: <20250429233848.3093350-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250429233848.3093350-1-nphamcs@gmail.com>

On Tue, Apr 29, 2025 at 04:38:28PM -0700, Nhat Pham wrote:
> Changelog:
> * v2:
> 	* Use a single atomic type (swap_refs) for reference counting
> 	  purpose. This brings the size of the swap descriptor from 64 KB
> 	  down to 48 KB (25% reduction). Suggested by Yosry Ahmed.
> 	* Zeromap bitmap is removed in the virtual swap implementation.
> 	  This saves one bit per phyiscal swapfile slot.
> 	* Rearrange the patches and the code change to make things more
> 	  reviewable. Suggested by Johannes Weiner.
> 	* Update the cover letter a bit.

Hi Nhat,

Thank you for sharing this patch series.
I’ve read through it with great interest.

I’m part of a kernel team working on features related to multi-tier swapping,
and this patch set appears quite relevant
to our ongoing discussions and early-stage implementation.

I had a couple of questions regarding the future direction.

> * Multi-tier swapping (as mentioned in [5]), with transparent
>   transferring (promotion/demotion) of pages across tiers (see [8] and
>   [9]). Similar to swapoff, with the old design we would need to
>   perform the expensive page table walk.

Based on the discussion in [5], it seems there was some exploration
around enabling per-cgroup selection of multiple tiers.
Do you envision the current design evolving in a similar direction
to those past discussions, or is there a different direction you're aiming for?

>   This idea is very similar to Kairui's work to optimize the (physical)
>   swap allocator. He is currently also working on a swap redesign (see
>   [11]) - perhaps we can combine the two efforts to take advantage of
>   the swap allocator's efficiency for virtual swap.

I noticed that your patch appears to be aligned with the work from Kairui.
It seems like the overall architecture may be headed toward introducing
a virtual swap device layer.
I'm curious if there’s already been any concrete discussion
around this abstraction, especially regarding how it might be layered over
multiple physical swap devices?

From a naive perspective, I imagine that while today’s swap devices
are in a 1:1 mapping with physical devices,
this virtual layer could introduce a 1:N relationship —
one virtual swap device mapped to multiple physical ones.
Would this virtual device behave as a new swappable block device
exposed via `swapon`, or is the plan to abstract it differently?

Thanks again for your work, 
and I would greatly appreciate any insights you could share.

Best regards,  
YoungJun Park

