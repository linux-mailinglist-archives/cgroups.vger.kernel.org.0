Return-Path: <cgroups+bounces-10885-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E850BEDCDF
	for <lists+cgroups@lfdr.de>; Sun, 19 Oct 2025 01:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C343234C218
	for <lists+cgroups@lfdr.de>; Sat, 18 Oct 2025 23:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7DC253359;
	Sat, 18 Oct 2025 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfcHCmDp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D45A1E9B3F
	for <cgroups@vger.kernel.org>; Sat, 18 Oct 2025 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760829737; cv=none; b=bgGjxFGrhnO7HhaRrA+ID6+mSaq6Iqs626Tsc1WgZki6tLnokchrPGJY44ShKgr3+NKmiw9AdqKgZgTk+bkPbNHJfkeMcP8KVy8PAYq6QaJLZev87gLeceWaeZKE0nb47sc2pRafNbGoKuUbLMHqlgFGDA7LOeOe/LDQNncadxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760829737; c=relaxed/simple;
	bh=YPdjdLJVQO2thN4bv43T6QagRGz8YzBPEemC1/mhtsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj5WlVjDGUx2LJD42iJXdX+9xAw8O936I2zMb8qgDS2+gGWYl9uzOkcZN8H9v2havnacCmGaLWMZJmCzNg7jKZ8LaWnzFEJyAHGzDVCDhENTxEisbiws6KeXFXywPAvjb3ogcXya+ykn1MWW5psUqu6QtlTbuud5UShWfMTdOvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfcHCmDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AF2C4CEF8;
	Sat, 18 Oct 2025 23:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760829736;
	bh=YPdjdLJVQO2thN4bv43T6QagRGz8YzBPEemC1/mhtsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfcHCmDpa6UI0Zz1UgeYs0eELzrNCrk6jGnQtXnxgGwJtAygjJn6YXd7zKph/nHgj
	 Kl0JJ502YuMNyh4tyFMvht9FohNryOq1R5DNeTtZGsiS5MVDzvo0tWtrgr8E21lJBF
	 K7iMGZOnDpP6J+Qvj82zhCIZuv3BVwTYPysbkw8sY1NWlOeIkPaEsXwl7nPbOUCwVE
	 18GGNrPGy/leQPnbGY5G8KmD3ahi6JenbLyvUoI3883pC92k6vxNosmbIGHbPh4PfZ
	 OlZx+E5b+W8+s7y9V3B/t4B+BHxMYcOCnYFHtLaX0I93MvwbwZHTzW8awZLxE8QyMt
	 JjYZojbSMuB1w==
Date: Sat, 18 Oct 2025 13:22:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: cgroups@vger.kernel.org
Subject: Re: freezing() returned false when the cgroup is being frozen
Message-ID: <aPQhJ2EW8wzuyjJr@slm.duckdns.org>
References: <d41dff2c-71e5-4ea3-b7d5-8412b5b0b3e6@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d41dff2c-71e5-4ea3-b7d5-8412b5b0b3e6@suse.com>

Hello,

On Sat, Oct 18, 2025 at 07:32:16PM +1030, Qu Wenruo wrote:
...
> Not familiar with cgroup, but it looks like the CGROUP_FREEZING bits are
> only set during freezer_css_online(), but not sure if for the long running
> ioctl case it's properly triggered.
> 
> Anyway the freezing() checks can be worked around by checking pending
> signals inside btrfs, as cgroup freezing will send a wakeup signal to the
> process.
> 
> Just curious if the freezing(current) is supposed to return false for the
> cgroup freezing case.

cgroup1 and cgroup2 have completely separate freezer implementation.
cgroup1's piggy back on the PM freezer which can freeze user and kthreads at
arbitrary freezing points. While that's fine for system-wide PM freezing, it
becomes a problem for cgroup freezing as users now can produce unkillable
frozen processes at will, which can create interesting problems (e.g. IIRC
the unkillable state can become transitive through ptrace).

Instead, cgroup2 freezer is a part of the task job control mechanism (the
same thing that SIGTSTP/SIGSTOP uses) and a frozen task behaves as if it has
sticky SIGSTOP signal pending. You can kill it, ptrace it and so on. As
such, it doesn't interact with the PM freezing mechanism at all. I suppose
you aren't talking about kthreads, right? It's just user threads doing
long-running ioctl's in btrfs code? If so, this should be no different from
getting any other signals. ie. If the code can handle signals and
task_work(), cgroup2 freezer should work fine too.

Thanks.

-- 
tejun

