Return-Path: <cgroups+bounces-9150-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2121BB256D3
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 00:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0EE5C16EF
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 22:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5962FCC02;
	Wed, 13 Aug 2025 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aNSs16S/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3D92F3C11;
	Wed, 13 Aug 2025 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124839; cv=none; b=rkfjP94zjGE71PhgZ6TZpK/BTnqkWhrAo5fz8uSfDN8ftijy0WR3ya2VXEvloKDeLX4gqFF3iNVcS8l0DX1iN1nBX8Ath6V5GEsuHzvQQ8RAzPxlFpcoYc/9aoHkmLPrPkUqYIJ63sIi7n2AvDsymIlr3uWQP2qgasWgP7E5A/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124839; c=relaxed/simple;
	bh=x+6Vi/XRLXHhmtIpq36fM3fBUFAdRIirEj2tBLR6nGs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GrYtbP9+JaD+E3aMlvp+PMHDn84z73TTHoKH/KZj1L4RV8/T01oSFHUG8zb4Os5Mk9toOdoZEKg1MGaTK9b+mOMhC8XCxqXkzq/1hX8z26U8WO6bsttEgaGVNeN89iM07NLH4e3VYcTnEdXTt3yBXdhclT3qSduYvPLM59Y6ss8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aNSs16S/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DF7C4CEEB;
	Wed, 13 Aug 2025 22:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755124839;
	bh=x+6Vi/XRLXHhmtIpq36fM3fBUFAdRIirEj2tBLR6nGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aNSs16S/O+GCzgCR/lVHsGqvnwDXgr7mkEgWPZzafz9LroGq4Ybv5WtgZnEnPvvAN
	 dxhZAZ4I55h/Ib8/IK/qHWr6vJL4iOCi2MD95zT5CvXkJkE+SNvYVqarZz5AsGSFzv
	 6ueF83Kdm+VdpP+y1r0Mxid/L/h+/69IbhaaXgWc=
Date: Wed, 13 Aug 2025 15:40:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org, LKML
 <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song
 <muchun.song@linux.dev>, cgroups@vger.kernel.org
Subject: Re: [PATCH] memcg: Optimize exit to user space
Message-Id: <20250813154038.dee67ecd858b7223d6b5cc6c@linux-foundation.org>
In-Reply-To: <hzvjjgzf4cdvj56zeysosb7otkvplbbozzcpij2yeka4a4kakl@4l26obz3karf>
References: <87tt2b6zgs.ffs@tglx>
	<hzvjjgzf4cdvj56zeysosb7otkvplbbozzcpij2yeka4a4kakl@4l26obz3karf>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 10:19:03 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Wed, Aug 13, 2025 at 04:57:55PM +0200, Thomas Gleixner wrote:
> > memcg uses TIF_NOTIFY_RESUME to handle reclaiming on exit to user
> > space. TIF_NOTIFY_RESUME is a multiplexing TIF bit, which is utilized by
> > other entities as well.
> > 
> > This results in a unconditional mem_cgroup_handle_over_high() call for
> > every invocation of resume_user_mode_work(), which is a pointless
> > exercise as most of the time there is no reclaim work to do.
> > 
> > Especially since RSEQ is used by glibc, TIF_NOTIFY_RESUME is raised
> > quite frequently and the empty calls show up in exit path profiling.
> > 
> > Optimize this by doing a quick check of the reclaim condition before
> > invoking it.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > Cc: Muchun Song <muchun.song@linux.dev>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Since this is seen in profiling data and it is simple enough, I think it
> is worth backporting to stable trees as well.

People will probably do this, but it's a big break of -stable rules.

If it is a regression fix (ie, has a Fixes:) and if it makes a big
difference (ie, comes with impressive quantitative testing results)
then maybe we could push it into -stable anyway...

> In the followup cleanup, we can remove the (!nr_pages) check inside
> __mem_cgroup_handle_over_high() as well.

yup, how about we do that now

--- a/mm/memcontrol.c~memcg-optimize-exit-to-user-space-fix
+++ a/mm/memcontrol.c
@@ -2213,9 +2213,6 @@ void __mem_cgroup_handle_over_high(gfp_t
 	struct mem_cgroup *memcg;
 	bool in_retry = false;
 
-	if (likely(!nr_pages))
-		return;
-
 	memcg = get_mem_cgroup_from_mm(current->mm);
 	current->memcg_nr_pages_over_high = 0;
 
_


