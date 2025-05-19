Return-Path: <cgroups+bounces-8265-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F31A6ABC862
	for <lists+cgroups@lfdr.de>; Mon, 19 May 2025 22:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A9E1B61A21
	for <lists+cgroups@lfdr.de>; Mon, 19 May 2025 20:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C83321322F;
	Mon, 19 May 2025 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsXNFUzO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11282D023
	for <cgroups@vger.kernel.org>; Mon, 19 May 2025 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747686520; cv=none; b=KKEaTpNFs7jYiyeN00xyCd+HMQuQ4GHDbCNVoAFOhLsMEYUc3phKz1e11Hv8nPiDKQ6ofxVdG5/FpJnkfvfPUCU+sWaRMs8NC90ZIhTui5zzhAFqV3I0Kmsq4UhXJE2dWoxxiK+1y2uTKYYCWTbgDHpmiM4dvcE4SJN3R0t0rFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747686520; c=relaxed/simple;
	bh=UPwSr6DRM3sYnSul+SIXjVsH6HKDAb8Vg/KaXpCf3d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZRL6/u4cfOf/aLc5fUJzINdpcgytQjznvRbvmUh25vFziJRS8BOzyracBvrAdJ0OVHVllCKt2QtzsvWZr48Ulu0UDafU8oAUVAGRNXaLpt9puJ7QOjBByxp/lOfJs1skelvfh3uA9QVE6wgvvSknIfABZQyTRqm/xkSF1q2KUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsXNFUzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DD6C4CEE4;
	Mon, 19 May 2025 20:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747686520;
	bh=UPwSr6DRM3sYnSul+SIXjVsH6HKDAb8Vg/KaXpCf3d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsXNFUzOTI4wnSKN4Gq0M8PTknrBjxrw6afGUvt9kyKbrZEGpBd+unxx35YjprtMp
	 +fdDo/gBTJ5KuXzHGbPHDad11ZI5mCb3lBJtqnixAEdDu/AS1ThvnKGLOW+WsyT4A3
	 lsdkkWtkRc4zzNvpXRiLMWqcuGkC7IiM27XpCOkRVS2563lq1lp2am0RuxBORjCeaw
	 mnMhdfXIkNp8Ern0twUD30eKAq0eShLMVVuD995/wsUGLbE8A55BSKDfaMkRoYn0UD
	 zwO/UVJKuddevgWx1QEhPnYej9t3BTx+LE7KmmMp0iv/MDiFGy0WP6YfSxFnWTAK+2
	 1NxA9U+ImE19A==
Date: Mon, 19 May 2025 10:28:39 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v6 6/6] cgroup: document the rstat per-cpu initialization
Message-ID: <aCuUd3EAE6GSQI3_@slm.duckdns.org>
References: <20250515001937.219505-1-inwardvessel@gmail.com>
 <20250515001937.219505-7-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515001937.219505-7-inwardvessel@gmail.com>

On Wed, May 14, 2025 at 05:19:37PM -0700, JP Kobryn wrote:
> The calls to css_rstat_init() occur at different places depending on the
> context. Document the conditions that determine which point of
> initialization is used.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Applied 3-6 to cgroup/for-6.16. If there still are issues, let's deal with
them with incremental patches.

Thanks.

-- 
tejun

