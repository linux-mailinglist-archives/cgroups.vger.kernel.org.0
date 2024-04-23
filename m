Return-Path: <cgroups+bounces-2678-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C897E8AF4B0
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 18:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837AE285D99
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 16:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA4513D61F;
	Tue, 23 Apr 2024 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ezxoz0JN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E526F4CB55;
	Tue, 23 Apr 2024 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891327; cv=none; b=U0UdfTqvQBnhDOcQZoE03N6Mp6HR7e7UHYfWBHxVy6gBubY6jXvZJaC9QoPjwtzYbLBaDlV1LrkB4enOYQVgAaSgcvRTLu9GSE3YTN/c0Oilh7jO7Zp1vutPzTGiC0xJIfV+yqVrS3AZp+ets/1xf6+5eqOKLSobRUre1Rb7ZZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891327; c=relaxed/simple;
	bh=WqT3utdI5b+8PdLzOvnk+8UFlfoDWKCG6SiuaqMuXF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maYeJMuTImUM2rkkcEN6K/BB0UjyI8/SlBsgaVU/T/iVLWsnO3IbxSkbMLGDPSIgHJIQoYD1ODMCF4fge3Eai8ISlCL3K0TeIEyv2nO+NTlo10pWaf2ijQAVIc40tb+5fiRcRmo2SF/7Y15YoRzKGksKwPpiN5uSqJaN/f2dBaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ezxoz0JN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE96C116B1;
	Tue, 23 Apr 2024 16:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713891326;
	bh=WqT3utdI5b+8PdLzOvnk+8UFlfoDWKCG6SiuaqMuXF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ezxoz0JNznH9GtJky0APUGmvH44iFk14b5gOc+DVzHoY1xMrKl9A0trliOrFeNpFq
	 6tcPCid7kcCUghefRnMDOphFnmYbjh2RbBsVJxr31hb76uVVKv3kOgdX86YU7HcESF
	 HP3G97AVXmfAyRe/LzYoxxa1tH7TtpdxUAInja1sb55AIxSzlibrCquZMRfdxb77qh
	 eLABCmNkjhrLmbscr5CvbdX5OqP0nyzIR6d/TE6+/q1jd6NpJq1eLUoPEZs8g3ReL2
	 PGk+5XUO0Ix5GLLUXDn2NsGltlKTzx8byGgJcrDw48nxpYsvohSClO8D7xaLPFt3OR
	 rXOaz5Pk5cxNQ==
Date: Tue, 23 Apr 2024 17:53:50 +0100
From: Simon Horman <horms@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
	cgroups@vger.kernel.org, yosryahmed@google.com, longman@redhat.com,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, shakeel.butt@linux.dev,
	kernel-team@cloudflare.com,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	mhocko@kernel.org
Subject: Re: [PATCH v1 1/3] cgroup/rstat: add cgroup_rstat_lock helpers and
 tracepoints
Message-ID: <20240423165350.GY42092@kernel.org>
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328988660.3930751.17537768209042139758.stgit@firesoul>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171328988660.3930751.17537768209042139758.stgit@firesoul>

On Tue, Apr 16, 2024 at 07:51:26PM +0200, Jesper Dangaard Brouer wrote:

...

>  /**
>   * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
>   */

Hi Jesper,

as a follow-up could you add an entry for cgrp to the kernel doc above?

> -void cgroup_rstat_flush_release(void)
> +void cgroup_rstat_flush_release(struct cgroup *cgrp)
>  	__releases(&cgroup_rstat_lock)
>  {
> -	spin_unlock_irq(&cgroup_rstat_lock);
> +	__cgroup_rstat_unlock(cgrp, -1);
>  }

...

