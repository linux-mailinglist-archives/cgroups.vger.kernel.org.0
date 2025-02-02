Return-Path: <cgroups+bounces-6409-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9001FA24F09
	for <lists+cgroups@lfdr.de>; Sun,  2 Feb 2025 17:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C671884953
	for <lists+cgroups@lfdr.de>; Sun,  2 Feb 2025 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E431D86E8;
	Sun,  2 Feb 2025 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saL55M12"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF4B1D5154;
	Sun,  2 Feb 2025 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738515382; cv=none; b=brqSpRnhZcakDHei11Mo/8KXqqWlZ6wKfTMZYcPtI8bCn57xuqaJYPjHtVG0AqIJ0c0lABTdbIfsU5tyZ9EDqUj5B6A1QjzV0aLHIEQPYSxzQeIHzP97kZwJwHVgs8s0dr6fydq5Ah1MDbl6wLe9nATc2CoL4OzyNHtEiZu4KlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738515382; c=relaxed/simple;
	bh=JLT4Nr7NojIi7+uTBH3L/Cu64XQRCmLEXiT/0vWNAA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeJQJCYwIHEf7takWc0IGF8cFr0djjGAXwcz+DwKSmpQKWnrxvmuCPGJy/UkgNGwCaPscSDwLS84p403jzKJCm6gWNS9nVYQhXXP+bqNzd+y2X7YcetJ7BJDmyVvHH9tHIl0HHOQqGCzKcPSBAUR060FkFK3BfZ0pYWAnouugAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saL55M12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DD6C4CED1;
	Sun,  2 Feb 2025 16:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738515382;
	bh=JLT4Nr7NojIi7+uTBH3L/Cu64XQRCmLEXiT/0vWNAA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=saL55M12DYz5DzOBcMgvURXev2srBNofON9XHCdDWr6c3Ncnh3f2k1eV1VCmBfSAJ
	 Un+XbLV/n+N75nVF9hX349pd7boSho6gCh8PBCn53m0TccN6xM14eoLf1nseK593Zb
	 UkGlS1H0AdU8RoByeG/rFT2Sitnox2NoiDcd5rfdlEwAK/VdNmmlDtKrr1F1RC9n4/
	 wJEnbbi4G2zvslV/1yOEfeDERSN6UWPPhq3+L/UBf3g4s2NuELBbvSBoC3w6+4xkmv
	 epZVNuVC2EF9FMDjdug9rYH3IVgnqEsy5yHCqr7Fp42nygaAf9QSLTnOCFr8SYMtTX
	 vkaENA5dfWS+Q==
Date: Sun, 2 Feb 2025 06:56:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Christian Brauner <brauner@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] cgroup: fix race between fork and cgroup.kill
Message-ID: <Z5-jtI26V845YRDz@slm.duckdns.org>
References: <20250131000542.1394856-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131000542.1394856-1-shakeel.butt@linux.dev>

On Thu, Jan 30, 2025 at 04:05:42PM -0800, Shakeel Butt wrote:
> Tejun reported the following race between fork() and cgroup.kill at [1].
> 
> Tejun:
>   I was looking at cgroup.kill implementation and wondering whether there
>   could be a race window. So, __cgroup_kill() does the following:
> 
>    k1. Set CGRP_KILL.
>    k2. Iterate tasks and deliver SIGKILL.
>    k3. Clear CGRP_KILL.
> 
>   The copy_process() does the following:
> 
>    c1. Copy a bunch of stuff.
>    c2. Grab siglock.
>    c3. Check fatal_signal_pending().
>    c4. Commit to forking.
>    c5. Release siglock.
>    c6. Call cgroup_post_fork() which puts the task on the css_set and tests
>        CGRP_KILL.
> 
>   The intention seems to be that either a forking task gets SIGKILL and
>   terminates on c3 or it sees CGRP_KILL on c6 and kills the child. However, I
>   don't see what guarantees that k3 can't happen before c6. ie. After a
>   forking task passes c5, k2 can take place and then before the forking task
>   reaches c6, k3 can happen. Then, nobody would send SIGKILL to the child.
>   What am I missing?
> 
> This is indeed a race. One way to fix this race is by taking
> cgroup_threadgroup_rwsem in write mode in __cgroup_kill() as the fork()
> side takes cgroup_threadgroup_rwsem in read mode from cgroup_can_fork()
> to cgroup_post_fork(). However that would be heavy handed as this adds
> one more potential stall scenario for cgroup.kill which is usually
> called under extreme situation like memory pressure.
> 
> To fix this race, let's maintain a sequence number per cgroup which gets
> incremented on __cgroup_kill() call. On the fork() side, the
> cgroup_can_fork() will cache the sequence number locally and recheck it
> against the cgroup's sequence number at cgroup_post_fork() site. If the
> sequence numbers mismatch, it means __cgroup_kill() can been called and
> we should send SIGKILL to the newly created task.
> 
> Reported-by: Tejun Heo <tj@kernel.org>
> Closes: https://lore.kernel.org/all/Z5QHE2Qn-QZ6M-KW@slm.duckdns.org/ [1]
> Fixes: 661ee6280931 ("cgroup: introduce cgroup.kill")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Applied to cgroup/for-6.14-fixes.

Thanks.

-- 
tejun

