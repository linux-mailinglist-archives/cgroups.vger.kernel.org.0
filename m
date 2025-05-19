Return-Path: <cgroups+bounces-8262-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2184ABC847
	for <lists+cgroups@lfdr.de>; Mon, 19 May 2025 22:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479C13BEED4
	for <lists+cgroups@lfdr.de>; Mon, 19 May 2025 20:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734E02116EE;
	Mon, 19 May 2025 20:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ew++4TmR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278315A848
	for <cgroups@vger.kernel.org>; Mon, 19 May 2025 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747685885; cv=none; b=qnnre7KR3E3kjeEsZaXCOuVkcC33jw9FThWZLYIA9jCUiOp8gQF7vXvW117LbgY+m82vZyUu+1ssfV6odBWTcLYgTJueGuxNZvEU5GQ932JMEJfUZUZjOqbHDU6t/jLY4cZ/mWHWpWgO9A/YVH3ODd/5XZY6UY2cmDGxdfoTQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747685885; c=relaxed/simple;
	bh=h3JCZc7bj8cLz1d1GFZyxDsKpWCiGlgS2mtOJMVmo70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1HgdVo0Zbakaj4WFPrmW2qIfieEfglhIj0YCZTsjek0WO0ZKfKbgmG6QCrjx56s/GzZLpY0P0tUnTG7lS/81+7YnBPoKftXV09tlE5YXfIEXf8E4SVg1DSQUFXFHyeUDLaiViIruxrA/4cgoWtUKSbZoyAUNHUMpTGiP4wIswU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ew++4TmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD2AC4CEE4;
	Mon, 19 May 2025 20:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747685884;
	bh=h3JCZc7bj8cLz1d1GFZyxDsKpWCiGlgS2mtOJMVmo70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ew++4TmRYtR7VXx0370JR9jJdiTMvUtiqJZjafgPKef3xSNtP83NKmNJ1pGlWoFDL
	 2FZQbHUmdk0iiPU8cS4r+5dB5Bvi6cKMBxvJj0h5JJLkMI3PCEOMxfSiD8bmS1/MdI
	 gtlm2dakesu5mGh7rA1407RmiVjPdtWh9uqAaAZCmwT3Cy8hk1E/3XxhjEQp8IdWws
	 BRsexHR0hi4kkjw1mIoyHv0eD19Hc1FwXsbjS42tjhZ2nLZKPibf/TgZ+KCpUAuax3
	 l3gqxBBwmJV+Gqgy04GAL7nUGPhc8nWGGfmPZSD32DuPCB+J6CdUaVx4oMCqIT0iUt
	 bKvvzmcdoq8mA==
Date: Mon, 19 May 2025 10:18:03 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v6 1/6] cgroup: warn on rstat usage by early init
 subsystems
Message-ID: <aCuR-1wHin4gMa-V@slm.duckdns.org>
References: <20250515001937.219505-1-inwardvessel@gmail.com>
 <20250515001937.219505-2-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515001937.219505-2-inwardvessel@gmail.com>

On Wed, May 14, 2025 at 05:19:32PM -0700, JP Kobryn wrote:
> An early init subsystem that attempts to make use of rstat can lead to
> failures during early boot. The reason for this is the timing in which the
> css's of the root cgroup have css_online() invoked on them. At the point of
> this call, there is a stated assumption that a cgroup has "successfully
> completed all allocations" [0]. An example of a subsystem that relies on
> the previously mentioned assumption [0] is the memory subsystem. Within its
> implementation of css_online(), work is queued to asynchronously begin
> flushing via rstat. In the early init path for a given subsystem, having
> rstat enabled leads to this sequence:
> 
> cgroup_init_early()
> 	for_each_subsys(ss, ssid)
> 	    if (ss->early_init)
> 		cgroup_init_subsys(ss, true)
> 
> cgroup_init_subsys(ss, early_init)
>     css = ss->css_alloc(...)
>     init_and_link_css(css, ss, ...)
>     ...
>     online_css(css)
> 
> online_css(css)
>     ss = css->ss
>     ss->css_online(css)
> 
> Continuing to use the memory subsystem as an example, the issue with this
> sequence is that css_rstat_init() has not been called yet. This means there
> is now a race between the pending async work to flush rstat and the call to
> css_rstat_init(). So a flush can occur within the given cgroup while the
> rstat fields are not initialized.
> 
> Since we are in the early init phase, the rstat fields cannot be
> initialized because they require per-cpu allocations. So it's not possible
> to have css_rstat_init() called early enough (before online_css()). This
> patch treats the combination of early init and rstat the same as as other
> invalid conditions.
> 
> [0] Documentation/admin-guide/cgroup-v1/cgroups.rst (section: css_online)
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Applied to cgroup/for-6.16.

Thanks.

-- 
tejun

