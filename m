Return-Path: <cgroups+bounces-12436-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B27CC8EAF
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 17:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56AFA3009A82
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 16:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F52327F75C;
	Wed, 17 Dec 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/PnBILj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABFE32E6BE;
	Wed, 17 Dec 2025 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765989934; cv=none; b=lXKCSD0cFPVIwyuPvlBuxLX0bKvL3R4CTA/OoTmWmhuOad72sSGpgbmTVqK0vwNmjG3ydJOHqI9G2j1DJQ6maZmQI+pf2TR2UqL3SKHo56K5YaNrsQg07M0uQiDQsHm4DwzkHPG/0LZO8wSmrtis+lpBHAwUYqzS19RxaIHSEz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765989934; c=relaxed/simple;
	bh=TWQ9UgkbNxPz06NrD0E+jZ5WsZZzMK+24NbTh80/49w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilMAgt9UuFzKfmNjHJPG3d0V9ou7/ZyWY/D3ydZ6tq8keqqDJCXBzY0OpW8mt/tRqaJ648ipK7n7dcwjmuRt/tuEtlzkyHFAY5oBgPwZDv12pxq2ipW9XPbM2qWLAuEDyU4Qwtiz5bIcXkmOUNUClhxro3I/1ziPHlCWE48PA3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/PnBILj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B46AC4CEF5;
	Wed, 17 Dec 2025 16:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765989934;
	bh=TWQ9UgkbNxPz06NrD0E+jZ5WsZZzMK+24NbTh80/49w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/PnBILj+E20wzhKNsNyNBMxkkANrWAoR2keoYFpqIObMI/Vfi41+16KIG/5VOW2z
	 EalO6rPEOQmkm2Pj3pChSeSvAg4vuEJw9FZh2NKu1gNHhwnkbby48mJPJAfrh9Do/h
	 t9l/Ulv8GqMTKRpWgRFAiV+caUSasUmhdT7PhjmxCNuyV+quIOwmjpuv1ne9hPwQmx
	 AM60+/5EpqoaqsjqxVKbJtpPtUCDyfF6t3ZcOU0TVTqKMDZyzYhBYQPH05kuMf0xun
	 LCZeP2ti9Qas1IpRLPTed8/FxbZKhp1Ah0j7V+MGBZxCsBNMUJXt9LmIf9glxRZNMt
	 UcsQkNUcCKx0g==
Date: Wed, 17 Dec 2025 06:45:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH -next] cpuset: fix warning when disabling remote partition
Message-ID: <aULeLTUTnebo4GBc@slm.duckdns.org>
References: <20251127030450.1611804-1-chenridong@huaweicloud.com>
 <5cbfe54e-846a-4303-bb34-3a7b64a174f3@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cbfe54e-846a-4303-bb34-3a7b64a174f3@huaweicloud.com>

On Wed, Dec 17, 2025 at 09:10:07AM +0800, Chen Ridong wrote:
> > Fixes: 4449b1ce46bf ("cgroup/cpuset: Remove remote_partition_check() & make update_cpumasks_hier() handle remote partition")
> 
> Fixes: f62a5d39368e ("cgroup/cpuset: Remove remote_partition_check() & make update_cpumasks_hier()
> handle remote partition")
> 
> Apologies, the correct fixes commit id should be f62a5d39368e. The earlier one might be from stale
> code in my local repository.

Can you resend with the commit fixed and reviewed-by tag added?

Thanks.

-- 
tejun

