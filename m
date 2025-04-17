Return-Path: <cgroups+bounces-7619-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821C3A922AC
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 18:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0603A7C8A
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 16:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBD4253B59;
	Thu, 17 Apr 2025 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNZM39fu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046B525335A;
	Thu, 17 Apr 2025 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744907278; cv=none; b=UE5EL/zqPP8fPjVugVyXF9ecVwXZkNRacbooAEEnO2+LBq0RCKbc5f0u8K1uYtaEmQMOSDhPf72wCaOEtnG6zTXr84lNpELCmcR2Mtrw7AFeDEsOYWL5qZ26IdnQ/UAERX9nQQdmckNcmRuuVjsnRVmsfBCtqBDECRVySms1ZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744907278; c=relaxed/simple;
	bh=4sRq40JH/ISI0UBvuCqCuGv7ETOqS4v59COSIUShOxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kodjpuQMgrqIJ3yscWY7xN25Fwtd9l1Z2C1bHg7bWVQtPjrl3il1lNafa2uMixktxkL6kBotrj5g3Jc2v4S6oU19E00W+em5pcemTnwQviiyHXL54U44ixafDI8rjS4ZmxrS73kZ4vdu+jkIgvH7UBcu1t1LSkXQB+9f/+uq/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNZM39fu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E66C4CEE4;
	Thu, 17 Apr 2025 16:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744907277;
	bh=4sRq40JH/ISI0UBvuCqCuGv7ETOqS4v59COSIUShOxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNZM39fuNQmF+Oy343fYSZMqmC+oaOGw+Fh93KA5zze+js1zftz3VNk16IiGsjL+M
	 ON2U69G5t9TgorBRiHzWPXLL+6DWcvK6OOmMXGJ+p94goKUNfx+dXVviLyYMy9QiGG
	 2DjvlVyTO2/7d7BaZDbJqVTD1V738rF/Xc1wJhiXTEs0bdOYlET9eCielQI/Bfi0NG
	 zqd2QdpRd+r0/TD588R+XSWe4UkxI3017RSZSFHMiG/AUOnX/bJFBmmQXanSmz/R/I
	 vY0Qkxf49vfiSNUSXUbZ0RdljpvMRn7X2vOhM38wQpIWdCyJd2Wc/bdc1LWF3U9SgW
	 DTHXdyMvBZBcA==
Date: Thu, 17 Apr 2025 06:27:56 -1000
From: Tejun Heo <tj@kernel.org>
To: gaoxu <gaoxu2@honor.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?iso-8859-1?B?Ik1pY2hhbCBLb3V0bv0i?= <mkoutny@suse.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"surenb@google.com" <surenb@google.com>,
	yipengxiang <yipengxiang@honor.com>
Subject: Re: [PATCH] cgroup: Fix compilation issue due to cgroup_mutex not
 being exported
Message-ID: <aAEsDKh79cBV4P3i@slm.duckdns.org>
References: <24763f5c8a13421fa6dc3672a57a7836@honor.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24763f5c8a13421fa6dc3672a57a7836@honor.com>

On Thu, Apr 17, 2025 at 07:30:00AM +0000, gaoxu wrote:
> When adding folio_memcg function call in the zram module for
> Android16-6.12, the following error occurs during compilation:
> ERROR: modpost: "cgroup_mutex" [../soc-repo/zram.ko] undefined!
> 
> This error is caused by the indirect call to lockdep_is_held(&cgroup_mutex)
> within folio_memcg. The export setting for cgroup_mutex is controlled by
> the CONFIG_PROVE_RCU macro. If CONFIG_LOCKDEP is enabled while
> CONFIG_PROVE_RCU is not, this compilation error will occur.
> 
> To resolve this issue, add a parallel macro CONFIG_LOCKDEP control to
> ensure cgroup_mutex is properly exported when needed.
> 
> Signed-off-by: gao xu <gaoxu2@honor.com>

Applied to cgroup/for-6.15-fixes.

Thanks.

-- 
tejun

