Return-Path: <cgroups+bounces-12096-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDBEC6FEBC
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 17:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8FD022FDE8
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 16:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C182E03F3;
	Wed, 19 Nov 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQJ1F6JR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668AD341043;
	Wed, 19 Nov 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567978; cv=none; b=pgqDpq9epAOB1XUlePc9Xl19+z3FcTmCqv+JDjcpzwdhKupdf8a28rFN5ytlTU+sCkYMHiO/MSpYJ/2+au7+14+amNFmKcOUGOipf+i2l+dn96U+9fmRFVfCE1uxa7TZpNet4FxANKGgoGohfwQdjQQjiSGHPzDaDurKetIDhuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567978; c=relaxed/simple;
	bh=CdjK4X48w1HdNQUKBNO5x4nNDYlk2RJu4rnbsLEZPkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGyHAva0ciTtxzZird3IhGu3eDWiYJT7DvjGCcqgDd2Iu14vfbUGJ1yowu8vzZMhykmyFLFhM446kBD0JnunQxH3d7PacW7c9pWMGt7/vgE8VkceKSF2Y7wI0+j44GtoMtSJ+D9hWzUJ48Wg7/FIl8uM5hGOeCwQRGhv1fGgWSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQJ1F6JR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F995C19423;
	Wed, 19 Nov 2025 15:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763567978;
	bh=CdjK4X48w1HdNQUKBNO5x4nNDYlk2RJu4rnbsLEZPkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQJ1F6JRiLHobcE3QBd39FfpLx+aWq491pgb6FtioSd+sHwVlQ4IJfVzZz+o9GOj6
	 YjFSrtEd1QDut5vMm0Ht/bZYdGoROX40tVljl2irmoJc+9eVetQHCJSHjXNAay7L4Y
	 D+BhhxLU7DYAScSakrTrZTOGeEkca//XKqTRN94qmr9bBcUTh7MVP4CkVYYf2UgHIz
	 hy30oZCB2yWJAKgEg1RGS6OuNONx3uxMVWAFzmf0HvmS1OjxaM87QkK6V6QRQhZC+e
	 QBJesCl6FQgsLF1ClWkJVviqcvRr158fjh5xgnZM78ypPMyMTVq52i+O2CqLUABVQw
	 HJucvGj+gWG7A==
Date: Wed, 19 Nov 2025 05:59:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] cgroup: drop preemption_disabled checking
Message-ID: <aR3paXRgyxdeO4sC@slm.duckdns.org>
References: <20251119111402.153727-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119111402.153727-1-jiayuan.chen@linux.dev>

Hello,

On Wed, Nov 19, 2025 at 07:14:01PM +0800, Jiayuan Chen wrote:
> BPF programs do not disable preemption, they only disable migration.
> Therefore, when running the cgroup_hierarchical_stats selftest, a
> warning [1] is generated.
> 
> The css_rstat_updated() function is lockless and reentrant, so checking
> for disabled preemption is unnecessary (please correct me if I'm wrong).

While it won't crash the kernel to schedule while running the function,
there are timing considerations here. If the thread which wins the lnode
competition gets scheduled out, there can be significant unexpected delays
for others that lost against it. Maybe just update the caller to disable
preemption?

Thanks.

-- 
tejun

