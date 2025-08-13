Return-Path: <cgroups+bounces-9139-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9C2B252DD
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 20:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5221C831C3
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 18:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1C32C1580;
	Wed, 13 Aug 2025 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfbwJd9K"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C02C0F7D;
	Wed, 13 Aug 2025 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108908; cv=none; b=bErmZMS9egDnExy9o59QDuM7OgsJuKEsS8hNH4SM7PRjpwbDd0ZOcISIsYnDinJW+LUZQVBkbvmLW/4plaZ49RlcYbkz4y2ZZkARa0VAqJ2XeUbF40VpliiXmDT7NIxo/rAtv22M5S5ecashPJ7mvx5/RxR0d4LXeZvV9MX7EMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108908; c=relaxed/simple;
	bh=ih3ruAxQQOFwKz2zHFrhMmxj6DoHrxLcFjwzpymrr64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hd0XVkJxcKdG1y9hnnhfs+yOvGCmdALtbhT0BqvpDuzsHo9hUOJDaaAvK2Oga9TTPO+kBZKLBrdE9ChfXr3B4oFbrnn5yhKSREZkEQ86Qxld+REchSloGNUJKDZUKVxNMpzmbvcLNKl/J62o8b/ptYMUYXzfeSdYv1RyC/g6e7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfbwJd9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390E0C4CEEB;
	Wed, 13 Aug 2025 18:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755108907;
	bh=ih3ruAxQQOFwKz2zHFrhMmxj6DoHrxLcFjwzpymrr64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XfbwJd9KzsbHnhXhgGwRB2cSr784Zfs2cpET2qFcVX/tPlSkg80RHm2Ee3BvVeQbc
	 NsvhR09QsRtboSPnN7mUl0ZqHZuAG/I8G0Fo8GQevMcpOBtrvRR90sYyh6JshIjwIC
	 RzsMYaLV0k+vmQjgxqaPrWZ4NyGkFzZY1Ze+bRyl3D5zmUyPNUlDEs0ETYrmfT2s+I
	 kaEVPpkPWINfxdypX3Lr45cTWkNU9MYzzchAM0zj5p/DwqszEmHtAYI9PAjAykgu2a
	 VrazTAmcEuj7o6l/NxIdLSNygsdID7nOqXvri1nNxchBZwIBd4cmz9wjgZ5QDmUB5A
	 3nlU2wsipFv8A==
Date: Wed, 13 Aug 2025 08:15:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, longman@redhat.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com,
	christophe.jaillet@wanadoo.fr
Subject: Re: [-next v2 1/4] cpuset: remove redundant CS_ONLINE flag
Message-ID: <aJzWKq81QWCte4MZ@slm.duckdns.org>
References: <20250813082904.1091651-1-chenridong@huaweicloud.com>
 <20250813082904.1091651-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813082904.1091651-2-chenridong@huaweicloud.com>

On Wed, Aug 13, 2025 at 08:29:01AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The CS_ONLINE flag was introduced prior to the CSS_ONLINE flag in the
> cpuset subsystem. Currently, the flag setting sequence is as follows:
> 
> 1. cpuset_css_online() sets CS_ONLINE
> 2. css->flags gets CSS_ONLINE set
> ...
> 3. cgroup->kill_css sets CSS_DYING
> 4. cpuset_css_offline() clears CS_ONLINE
> 5. css->flags clears CSS_ONLINE
> 
> The is_cpuset_online() check currently occurs between steps 1 and 3.
> However, it would be equally safe to perform this check between steps 2
> and 3, as CSS_ONLINE provides the same synchronization guarantee as
> CS_ONLINE.
> 
> Since CS_ONLINE is redundant with CSS_ONLINE and provides no additional
> synchronization benefits, we can safely remove it to simplify the code.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Acked-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.18.

Thanks.

-- 
tejun

