Return-Path: <cgroups+bounces-8264-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFBEABC853
	for <lists+cgroups@lfdr.de>; Mon, 19 May 2025 22:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3FD1885D65
	for <lists+cgroups@lfdr.de>; Mon, 19 May 2025 20:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C2C213244;
	Mon, 19 May 2025 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUxdAtxH"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1423720FAA9
	for <cgroups@vger.kernel.org>; Mon, 19 May 2025 20:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747686102; cv=none; b=n54XISmFA3NgJiHVoSgPNsjdCN4zU1PncPl5D6Tyv1WrGTpIluZFKbZZ29sslaqfNVEqXW+VwqW2VTguw4SVfOGV07uukJ4paSL7EOlVql+gN1JK+FwVX1FcztMpypKCHU65MogOIgYJCCW7JVyD9oxtIwF1VFtEx1+AhP8wydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747686102; c=relaxed/simple;
	bh=vW4s9vl1jjJSv0Q7db/ADq8V0LR+P8ubsD7psX77KGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9jKWhKc1HzkPwOIbiqnuvjsH3dLFrjkMzjo1wrOMcMgito53mXBctIYQyqz60MQKlbZ63r/6mlBHPgRMQWvlsh2/dwPWao4aBdnXEGRFJVoLod4942SHCFTCaJasy3X0RpytekbEwpn9opYHa/JKeEXO1B1YDg4txbLowP7JbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUxdAtxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60034C4CEE4;
	Mon, 19 May 2025 20:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747686100;
	bh=vW4s9vl1jjJSv0Q7db/ADq8V0LR+P8ubsD7psX77KGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jUxdAtxHJzJQqJ+7l4XmiZEOQa3xRk8NRDEygHyZXHJ3eUmFDxv0rxNiJKiNv8QeR
	 MYYg3tIWe6Haa57iWA7oDyH50QY0lmWnt+5NvA+ZzVtw197l7kKogpuX4BvI2Weq0z
	 Bsd2e+is7RFm8Ln9z04HVz61hD2DOwelXVR4wkH4SAKEWyPnpd1Q9LPnmXHt71UkTm
	 V3lBNsQl0DC9RJ9X8k+Uip8WgX5JILBw0KLd3gErB0WN+FJq9W/dkE5QO2wOqvN4eF
	 KkZxfb22U82gRn2n+Jm2vE16iHjW0OdIWR29YeJJA9Vyq59etdQYPMsov9eFIQeHgh
	 B8p6JdpF2wuTA==
Date: Mon, 19 May 2025 10:21:39 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v6 2/6] cgroup: compare css to cgroup::self in helper for
 distingushing css
Message-ID: <aCuS09QlsqD24fV_@slm.duckdns.org>
References: <20250515001937.219505-1-inwardvessel@gmail.com>
 <20250515001937.219505-3-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515001937.219505-3-inwardvessel@gmail.com>

On Wed, May 14, 2025 at 05:19:33PM -0700, JP Kobryn wrote:
> Adjust the implementation of css_is_cgroup() so that it compares the given
> css to cgroup::self. Rename the function to css_is_self() in order to
> reflect that. Change the existing css->ss NULL check to a warning in the
> true branch. Finally, adjust call sites to use the new function name.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Applied to cgroup/for-6.16.

Thanks.

-- 
tejun

