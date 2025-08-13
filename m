Return-Path: <cgroups+bounces-9147-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF94BB2554D
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 23:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E94E9A5A57
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 21:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070AA2EFD8D;
	Wed, 13 Aug 2025 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iBz4Rpi9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FkoYUBMO"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B775188715;
	Wed, 13 Aug 2025 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120357; cv=none; b=Yuk2ZXwRMxFmCb53iU+ZrI/LhNFIBcAF0GmDQDpW9pqb11eSaVOC5GGo9oc+uVg8jeChW+tI65w1NemP64d45YmH4b2iT2dhUw5Ehzi04aQSKeM3w00FWuOuZ5M9MtomaqdVf/ah54MHH9RBfsapT+0BV7wq8JJa/oBmQBnqqAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120357; c=relaxed/simple;
	bh=slBihtdC0DP7pZeorIPrck2EAMxr5n4/nnJlNQuTyy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o6y8bM8yDMPBwkiKuHtOfoNuHa3zYVMCBxupeDeQblT8ifBcpghLkzbSvTQ37g2qec3EWqbto8HLongEHDrPglMANJXPyh7ZftCaIKnb3hqZJT/Kr/a2cMLuE2z82r6/XKWzGu0M3fOpEyiP8bBSVWp3EpW113TNBgmQ1/QLgSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iBz4Rpi9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FkoYUBMO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755120353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPsZZeB7DGQldN6iG3Vx6k5qI8fxoARth9f1NUHSsSI=;
	b=iBz4Rpi9WxTcQAgz21mRaJiXzGL0/voS7kE5lCyKIjSMewsaO/3ERnZxXIW82FckHBL1U/
	6bwe3ZiWDSa4u4KShETl99Jo2mhrHLHIPz1d8IOUGULcW009YpmeVAHe51C40XxRm+0Y8e
	p61sz3v271nRvXg8vD0GHdS/nun0rXYTev7bM/iyi3BbBqCK7LtQLntxgx4gNj8tTaiib3
	Y8cbNxj1XEmYmjulAd9klpfoZPjo8M7HJTudFf96eFNPTFIIQyMe8LJkwABeJ2OE3lSSH8
	xxHzXvSRhRt731NLqmY2sOK5/SyeeqkyHf3wxqyOlQ0z5LVAG2lOP6OjJQAMyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755120353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPsZZeB7DGQldN6iG3Vx6k5qI8fxoARth9f1NUHSsSI=;
	b=FkoYUBMOpck4thkYzrkH4Wn7bCKCkLVeeTC4Jc07kZMkjCMQCzbH85q3pzneGDLR2PhfLq
	Mig88eUXbmL7fsBg==
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko
 <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Muchun
 Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH] memcg: Optimize exit to user space
In-Reply-To: <hzvjjgzf4cdvj56zeysosb7otkvplbbozzcpij2yeka4a4kakl@4l26obz3karf>
References: <87tt2b6zgs.ffs@tglx>
 <hzvjjgzf4cdvj56zeysosb7otkvplbbozzcpij2yeka4a4kakl@4l26obz3karf>
Date: Wed, 13 Aug 2025 23:25:52 +0200
Message-ID: <87h5ya7w2n.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 13 2025 at 10:19, Shakeel Butt wrote:
> On Wed, Aug 13, 2025 at 04:57:55PM +0200, Thomas Gleixner wrote:
> Since this is seen in profiling data and it is simple enough, I think it
> is worth backporting to stable trees as well.

Your call.

> In the followup cleanup, we can remove the (!nr_pages) check inside
> __mem_cgroup_handle_over_high() as well.

Yes. I did not want to do that in one go, but that's an obvious follow
up.

Thanks,

        tglx

