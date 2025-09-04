Return-Path: <cgroups+bounces-9700-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 039AAB433F2
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 09:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AAF176993
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 07:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE9E29BD80;
	Thu,  4 Sep 2025 07:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl0LVh9J"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA4029B8DC;
	Thu,  4 Sep 2025 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970916; cv=none; b=MaULjyJPj88+6IiqM3ilkZhNio/GlfspqcFORPC2+McmyDnhdQi8CRidHwKpdvq/9oa/zCWD6X2bV+SKc9PYliu6LfH2Ueywzabn5dVgiMFHfcX616hJyVnAQnPgolwbm5UbLkrlxZDB/M62NKEjzV+qoH8daBxOgwXXZhn0QGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970916; c=relaxed/simple;
	bh=g8jAqqwvTf+B1bq0ge0QqOZnp61fXA9coqS2PyI5Y3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBXI1rUd+TKDW6Z138iwB2yYW8lvSbTjTtMbiAFnV4/e0sdV2U3rTQdW3/S4BR8MWJLniqPqgo4PD75l83L+qbQFVQ3Bav1w0srsPAJL6AfV4Pai2/9g1JQmHSYCsedlWGkZgLkfGSNkk5jkGL+lYi/ZHv6i8aNP7M7PLooCJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl0LVh9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36037C4CEF1;
	Thu,  4 Sep 2025 07:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756970916;
	bh=g8jAqqwvTf+B1bq0ge0QqOZnp61fXA9coqS2PyI5Y3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nl0LVh9J40I2SvwKD719bSyOZtQCwJDtcPXvxfKKE/7E42B+PGY9PiY0ooEA5xyGx
	 5fh5cvhVBgbtkXFPlmj2g7TpMJ9cVJCrTYb4Vtt+xscnC+3/xoISkCcdRtaJER/wDc
	 WBx4UOWLT23Cz383SVGfKgqvAutvOQs+M4B8LkuNR2vg6xHcKvXo5Y17KgUcGpYGpn
	 kdj+v/VAHQA4Bz7qOy/XCwndaNQ9+SHToP4iOW4MXXopCU2J3jFh7QKT9X8PsH3FCn
	 qOP2A3TDnn695VWw38h9P1X9zHuwG8Bzh0j9f0RSLF3OBVuLEPKr6xvK7Tx7MoNxHq
	 ieyDZ1vKB32Tw==
Date: Wed, 3 Sep 2025 21:28:35 -1000
From: Tejun Heo <tj@kernel.org>
To: escape <escape@linux.alibaba.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
Message-ID: <aLk_o0GUhC14T8f9@slm.duckdns.org>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <aLhykIPSGV1k_OG0@slm.duckdns.org>
 <cfe595a7-c20d-4891-aba1-35546c488024@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfe595a7-c20d-4891-aba1-35546c488024@linux.alibaba.com>

Hello,

On Thu, Sep 04, 2025 at 11:15:26AM +0800, escape wrote:
> 在 2025/9/4 00:53, Tejun Heo 写道:
> > Hello,
...
> As Ridong pointed out, in the current code, using CLONE_INTO_CGROUP
> still requires holding the threadgroup_rwsem, so contention with fork
> operations persists.

Sorry about my fumbling explanations repeatedly but this isn't true. On
cgroup2, if you create a cgroup, enable controllers and then seed it with
CLONE_INTO_CGROUP, threadgroup_rwsem is out of the picture. The only
remaining contention point is cgroup_mutex.

> CLONE_INTO_CGROUP helps alleviate the contention between cgroup creation
> and deletion, but its usage comes with significant limitations:
> 
> 1. CLONE_INTO_CGROUP is only available in cgroup v2. Although cgroup v2
> adoption is gradually increasing, many applications have not yet been
> adapted to cgroup v2, and phasing out cgroup v1 will be a long and
> gradual process.
> 
> 2. CLONE_INTO_CGROUP requires specifying the cgroup file descriptor at the
> time of process fork, effectively restricting cgroup migration to the
> fork stage. This differs significantly from the typical cgroup attach
> workflow. For example, in Kubernetes, systemd is the recommended cgroup
> driver; kubelet communicates with systemd via D-Bus, and systemd
> performs the actual cgroup attachment. In this case, the process being
> attached typically does not have systemd as its parent. Using
> CLONE_INTO_CGROUP in such a scenario is impractical and would require
> coordinated changes to both systemd and kubelet.

A percpu rwsem (threadgroup_rwsem) was used instead of per-threadgroup
locking to avoid adding overhead to hot paths - fork and exit - because
cgroup operations were expected to be a lot colder. Now, threadgroup rwsem
is *really* expensive for the writers, so the trade-off could be a bit too
extreme for some use cases.

However, now that the most common usage pattern doesn't involve
threadgroup_rwsem, I don't feel too enthusiastic about adding hot path
overhead to work around usage patterns that we want to move away from. Note
that dynamic migrations have other more fundamental problems for stateful
resources and we generally want to move away from it. Sure, a single rwsem
operation in fork/exit isn't a lot of overhead but it isn't nothing either
and this will impact everybody.

Maybe we can make it a mount option so that use cases that still depend on
it can toggle it on? In fact, there's already favordynmods mount option
which seems like a good fit. Maybe put the extra locking behind that flag?

Thanks.

-- 
tejun

