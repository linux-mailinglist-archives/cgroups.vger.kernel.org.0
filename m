Return-Path: <cgroups+bounces-8463-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866CBAD2405
	for <lists+cgroups@lfdr.de>; Mon,  9 Jun 2025 18:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE4E16DEEC
	for <lists+cgroups@lfdr.de>; Mon,  9 Jun 2025 16:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E165B21C186;
	Mon,  9 Jun 2025 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlVh02FI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9977C21ABB4;
	Mon,  9 Jun 2025 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486884; cv=none; b=BovdVHpd7q3+8XgtoynK0hJsvvbf6M1h6/DC24dbtVhlRy/TZTjV4nLQOVQxeZXoP3ADt6BTLBtuAEEUvy2kvGC71KcPoNclARFXsDhUamPjITLNbjXVPgoOcdG58EgfDcpzFNmitoTeZBRJictyLnud7odHW+nPzdZRX44Qpyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486884; c=relaxed/simple;
	bh=sfvI4exa5y1xUxJQrirry+A/qvKeilSqQTra6fvux3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNyB/uCR40J+Y4mQdbtJMTcSvjH/r2C7126sUwpydWtjPoiSe2oyQkGxv8XB9RsL8P1S+BeJDTwWuugDCMwHsTm3sihQ5BElVP00sXDdkqkmVCP9f6SNWnlp9wUolxUCoKH+90EwUdmhCKhZC1rWU/xJbUBHtr4em9tyc/ZXGXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlVh02FI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA2CC4CEEB;
	Mon,  9 Jun 2025 16:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749486884;
	bh=sfvI4exa5y1xUxJQrirry+A/qvKeilSqQTra6fvux3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WlVh02FIIlBRY93JLNx5v2/Ae4jVl7TR3vS7YnbFJNHtHI/LK5dzfWCQHuYD7p6Ri
	 AFMj3RHW3vtlxlUFOmkBXKBJnOYbiKEBPvJpAQ7puV4xWqG+xY3I4MVnvI9rDgskZ0
	 ptPpuWH2i4a77zWxA8fN13vvQQzX0XzHImrsgXr4J4EU6fQFsOB5GtR5BPOcLYK39Z
	 gS6VFE+oXOAvOn3WuGik7Ngkef31bGZu+p5RvmhIPQRiaycjxOUqHRnpd73eW795yW
	 u11xxD8l45r5+zlQX1Y9nvmDYjNGm2i2a0Ve0jOIQx6ITiHEi1314ZM+RYgUPYH5TA
	 pgetudX6Y/2ug==
Date: Mon, 9 Jun 2025 06:34:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Jemmy Wong <jemmywong512@gmail.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] cgroup: Add lock guard support
Message-ID: <aEcNIvp4TcGUXUmD@slm.duckdns.org>
References: <20250606161841.44354-1-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606161841.44354-1-jemmywong512@gmail.com>

On Sat, Jun 07, 2025 at 12:18:38AM +0800, Jemmy Wong wrote:
> v1 changes:
> - remove guard support for BPF
> - split patch into parts
> 
> v0 link:
> https://lore.kernel.org/all/20250605211053.19200-1-jemmywong512@gmail.com/
> 
> Jemmy Wong (3):
>   cgroup: add lock guard support for cgroup_muetx
>   cgroup: add lock guard support for css_set_lock and rcu
>   cgroup: add lock guard support for others

So, I'm rather ambivalent about this patchset but leaning towards not
applying them. The lock guards are fine but I'm not sure what converting the
existing code base wholesale buys us. We're already pretty good at detecting
locking problems with lockdep and all and the code being modified hasn't
seen significant locking changes in ages. There are no practical benefits to
converting the code base at this point.

Thanks.

-- 
tejun

