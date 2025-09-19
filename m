Return-Path: <cgroups+bounces-10295-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E44B8A97D
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 18:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00BD3BD99E
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 16:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6247267AF1;
	Fri, 19 Sep 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deAkMIz0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890A0481B1;
	Fri, 19 Sep 2025 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299963; cv=none; b=qW1xFV1PsMWgHcW9dd2RhVDgC1NQui8Jsz4//Bc/nUsXT/9bDqxp4+M5uhSneYROHsb67S3B9l3ZFDzMIvvUAlAM3imt5QD0k/PAdqswWfc6mKXSKzIJB3DTwroEBrBNqIEc//+Cmru05PPtYHMxSH0eX6qaZYCehODFBhoAHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299963; c=relaxed/simple;
	bh=GL0do6mb4KcsRXMq54iJOE4G0ziZ3GPT2BTM3Z1+8DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcNWUjSpRQwz/OMiq7tHpm+qPaBRxAa36oq/xmlcCS6oA/6CUemX4aU+W9Bwbl4gMVLtOI3IHgCL0Bsid/qgazzIycuiVBWzuooawEChWdnA3tV9RFklm/f6UsFf2mB1e7+NO/92DC3T5hHUztUfRFwY4IodtHwKpRoa74bHs+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deAkMIz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147ADC4CEF0;
	Fri, 19 Sep 2025 16:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758299963;
	bh=GL0do6mb4KcsRXMq54iJOE4G0ziZ3GPT2BTM3Z1+8DU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=deAkMIz0sxGvFoJH8wwFXVoG4HsTDy/JWetYwsvd5uxrziud25U7PrdrT7cflVidD
	 ATNNFs1iyxR2BAAAWRX0Cp2kYqIlqsYkQiNdTcCsW+KTN6aPStiGaxxVpXJpFFVAze
	 thJiQyYrZEEUXV2nhzIa/quRCUb5C/pRTNFxOHIRHE4sRTEPIMat8Zs4a3oWSyC/pf
	 iMdua92qVSYorBJxwoT69l5bbBEFfvUOClmh9JAXESEY6nXgOQ5daZBOq6FIw3WPcE
	 WIeXPIWMce+lIdnN/NO6oRRiHrdgc2CCnOHGjeyyinh+M/N4+qmflMiYfR38puszwO
	 RyzeP4tkRspNg==
Date: Fri, 19 Sep 2025 06:39:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4] Documentation: cgroup-v2: Sync manual toctree
Message-ID: <aM2HOklfVET3yF_e@slm.duckdns.org>
References: <20250919074347.33465-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919074347.33465-2-bagasdotme@gmail.com>

On Fri, Sep 19, 2025 at 02:43:48PM +0700, Bagas Sanjaya wrote:
> Manually-arranged toctree comment in cgroup v2 documentation is a rather
> out-of-sync with actual contents: a few sections are missing and/or
> named differently.
> 
> Sync the toctree.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Applied to cgroup/for-6.18.

Thanks.

-- 
tejun

