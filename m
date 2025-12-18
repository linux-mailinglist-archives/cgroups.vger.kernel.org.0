Return-Path: <cgroups+bounces-12481-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCECCCAA6C
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 08:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98AB1301FA4E
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 07:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919602C0298;
	Thu, 18 Dec 2025 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G+eE3zxE"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526772BEFED
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042944; cv=none; b=pby2g/z9AS3aiHvihkSb4Py7ytRNnTKKR625dlndy6PHxenbKFZaYWkFqnPF/DCRXFD0rTWIwadQQME0aW159dA6f4HEr9/wn+GFqU0QTvz9zdcd/z4lcMAQb6+9fgT9yU+Nkyw9Ga14PqOahZ8QJOaMF3PCAxADdSN72cvBPC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042944; c=relaxed/simple;
	bh=Yp42UK9ansoTFuI/uyCKUMaXrwvtuDvEbAYFGg2mEpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0Q1q5uaB41vHIQdPlU53R5B9VC3gO+JTklRtQwt2KY7mCUy2aUhnw+B2pWHp7iX8mVHqAMv25D/1k4N7rhVtzdRYwYGxrvtbiLmzCzpfOasnmu22w9ouRYlo5sRa8OI1jEnZEpVdAooNqNp4HfYX6NCnKwMJiTFiW4NVmlsyrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G+eE3zxE; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 17 Dec 2025 23:28:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766042930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5svmWFgnz5Evz4m+isNDa9d9j8Ihqrx/V7D7WfDtnow=;
	b=G+eE3zxEra0Qe0aRW27dlj+Ey4VUUiCruQ/xEkuFsjUpTww52dxhxAt+BrGIYgkMSdltxT
	b5+uWMjXqXLsJOjgeb9i0JzzMqRYxbxSdOyTvpz1nmtOw9yz31G6nYzzCEb3OXkVlSRG9F
	TplJHGiVglkaLbG8exJzXNwgbmXXCZ8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: reorder retry checks for clarity in
 try_charge_memcg
Message-ID: <hibelxfvkdvm6b2a6vmgdmwcne6e2z2hrshshacepgedduyejn@7kfdegbmwyvs>
References: <20251215145419.3097-1-kdipendra88@gmail.com>
 <20251215204624.GE905277@cmpxchg.org>
 <CAEKBCKM5aB0JHvF-0-GWeCjwPk00SE+TjbL2x64w0xH5Gmf-aA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEKBCKM5aB0JHvF-0-GWeCjwPk00SE+TjbL2x64w0xH5Gmf-aA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 18, 2025 at 12:51:04PM +0545, Dipendra Khadka wrote:
> Hi Johannes,
> 
> Thank you for the feedback. Let me clarify the scenario this patch
> addresses.
> 
> On Tue, 16 Dec 2025 at 02:31, Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, Dec 15, 2025 at 02:54:19PM +0000, Dipendra Khadka wrote:
> > > In try_charge_memcg(), reorder the retry logic checks to follow the
> > > early-exit pattern by testing for dying task before decrementing the
> > > retry counter:
> > >
> > > Before:
> > >     if (nr_retries--)
> > >         goto retry;
> > >
> > >     if (passed_oom && task_is_dying())
> > >         goto nomem;
> > >
> > > After:
> > >     if (passed_oom && task_is_dying())
> > >         goto nomem;
> > >
> > >     if (nr_retries--)
> > >         goto retry;
> > >
> > > This makes the control flow more obvious: check exit conditions first,
> > > then decide whether to retry. When current task is dying (e.g., has
> > > received SIGKILL or is exiting), we should exit immediately rather than
> > > consuming a retry count first.
> > >
> > > No functional change for the common case where task is not dying.
> >
> > It's definitely a functional change, not just code clarification.
> >
> > The oom kill resets nr_retries. This means that currently, even an OOM
> > victim is going to retry a full set of reclaims, even if they are
> > hopeless. After your patch, it'll retry for other reasons but can bail
> > much earlier as well. Check the other conditions.
> >
> > The dying task / OOM victim allocation path is tricky and it tends to
> > fail us in the rarest and most difficult to debug scenarios. There
> > should be a good reason to change it.
> 
> The task_is_dying() check in try_charge_memcg() identifies when the
> CURRENT task (the caller) is the OOM victim - not when some other
> process was killed.
> 
> Two scenarios:
> 
> 1. Normal allocator triggers OOM:
>   - Process A allocates → triggers OOM
>   - Process B is killed (victim)
>   - Process A continues with reset retries - task_is_dying() = false for A
>   → Unchanged by my patch
> 
> 2. Victim tries to allocate:
>  - Process B (victim, TIF_MEMDIE set) tries to allocate
>   - task_is_dying() = true
>   - Current code: wastes retries on hopeless reclaims

Why hopeless?

>   - My patch: exits immediately
>   → Optimization for this case

Why optimize for this case?

> 
> The victim has three safety mechanisms that make the retries unnecessary:
> 1. oom_reaper proactively frees its memory

Since oom_reaper will reap the memory of the killed process, do we
really care about if killed process is delayed a bit due to reclaim?

> 2. __alloc_pages_slowpath() grants reserves via oom_reserves_allowed()

How is this relevant here?

> 3. Critical allocations with __GFP_NOFAIL still reach force: label

Same, how is this relevant to victim safety?

> 
> The retry loop for a dying victim is futile because:
> - Reclaim won't help (victim is being killed to free memory!)
> - Victim will exit regardless
> - Just wastes CPU cycles
> 
> Would you like me to provide evidence showing the unnecessary retries,
> or run specific tests to verify the safety mechanisms are sufficient?
> 
> Best Regards,
> Dipendra

