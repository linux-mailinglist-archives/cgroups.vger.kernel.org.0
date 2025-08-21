Return-Path: <cgroups+bounces-9311-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1BCB302A2
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 21:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE43600F92
	for <lists+cgroups@lfdr.de>; Thu, 21 Aug 2025 19:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60D7345759;
	Thu, 21 Aug 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FLRo7wbp"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C0C346A13;
	Thu, 21 Aug 2025 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803402; cv=none; b=jXdoaQT1H1MCaQL4VnFuBOqc8b4DaEYKDxydwc6ida3z+fLsGiZBbF+327g68ebcD0OeVKdFNQyAPp+jWMvsauzmInZkbRqDVeFJ+Uf45dritbD+KNEb4Nvx02B7P8gU4ScS0MJXhw3itnQhL63Vk+hWzWRoq8Oug0maN3qcg3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803402; c=relaxed/simple;
	bh=RqaKHsUnY8ZpE16ezGuvNa6u2HglQRzPt+MIDv+XSik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKTQJaPpUdOrWGd1XSMExgG/2d9ziOQDuLHj1lS6O7TvjTgqoitqbHnBya8cD1GzYvXvapE8UY/6ue4N+p35W7UbLizOIkQfcAppS3U/4hlbw7Y60arhAo2NBzEipQhbGcJlhfL/Ap4uw4cGJGUx+bVyipczNwEFv8dN8oFOrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FLRo7wbp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=AZd0cgU/MbuYTGO6sr/f9a7i3dIJ9uqk3pbudrbqon4=; b=FLRo7wbpbNYwSsQW69+1lbiJKd
	p1kfY3fzg5EbM15+8HYEYzoJryC1zsHxTYFajiqtqqXE35tEaObAUtWhU0yV36NoTicov8m37Br2Q
	Mk4gMZWLA2togwH4iUyY+R1axjbWGR3D1A5PYHsRG2KridoJrnk5DUTa/FS8vcwhVRvU3lkDZ+rZZ
	fDFMUX/zLYZAwyKySCy7Wn5OR9MiTg9jRZcFPC5TzAHJwIB2a9iPw7x3ycCnQ8aHfXXQgstE5XyY3
	i8yiyMEKgdLb4pIzi3eJt88kmDm4haEfwFdY1/Sov7rAyjE7GPYROAkEeYBeAay2Tx79wvV6KZ731
	dtXtcOLA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upAfe-00000000E2q-3f3j;
	Thu, 21 Aug 2025 19:09:58 +0000
Message-ID: <4cae933a-d171-48aa-a854-b4323d10b347@infradead.org>
Date: Thu, 21 Aug 2025 12:09:57 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Fix documentation typos
To: Sahil Chandna <chandna.linuxkernel@gmail.com>, corbet@lwn.net,
 linux-doc@vger.kernel.org, kent.overstreet@linux.dev, tj@kernel.org,
 cem@kernel.org
Cc: linux-bcachefs@vger.kernel.org, cgroups@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
References: <20250821185145.18944-1-chandna.linuxkernel@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250821185145.18944-1-chandna.linuxkernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/25 11:51 AM, Sahil Chandna wrote:
> Fix several spelling mistakes in documentation:
> 
> - Availablity -> Availability
> - heirarchy  -> hierarchy
> - maping     -> mapping
> Findings are based on v6.17-rc2.
> 
> Signed-off-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst                  | 2 +-
>  Documentation/filesystems/bcachefs/future/idle_work.rst  | 6 +++---
>  Documentation/filesystems/xfs/xfs-online-fsck-design.rst | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 

Looks good, although there was just another patch that also fixed the maping/mapping
spelling for XFS.

And various maintainers might request that you split the patch up by
subsystem/filesystem (i.e., 3 patches here) unless Jon merges it as is.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy

