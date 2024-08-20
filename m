Return-Path: <cgroups+bounces-4360-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E16A3957AB1
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 03:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA22284676
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 01:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746C3101C4;
	Tue, 20 Aug 2024 01:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DAh8Q1mq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B2C8E9;
	Tue, 20 Aug 2024 01:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115693; cv=none; b=fPGWZYm5Evu1jeW56UZOMLZ2QDC/qF4BI0PLhLGI7JpQU3JwbobuTZ3lhZqClksf1i7akRD8GUbbJB3kANvM8CeQQ6nNpkBOW70iOmMkqPm2nv2ci0fDU6aRljfQFGB2H6YXbjq1u5IHFBAvoB+tLcZ0UZsy3/0vG8WhopLDQpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115693; c=relaxed/simple;
	bh=vCG/7EpNWV9MCkM7KPhgmJCNxcxQVYJ412oNcR79CpQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Y7VLMm//rMUooFWU4bS1lt8mYu9Dfa9XjdTh6yygSFwgar/7tec6eNAFxwrJHlAAn05wgLVOLBeFoVUg8HfWaZd9pRPTY+A9zM53lXYzUfDeIhwwCbWB/tltwAwAC+n5PrxkvSa5MaWAtGZsYeOfUa9BcSWw3q4VO4iEDj6ixM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DAh8Q1mq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B09C32782;
	Tue, 20 Aug 2024 01:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724115692;
	bh=vCG/7EpNWV9MCkM7KPhgmJCNxcxQVYJ412oNcR79CpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DAh8Q1mqXkhQInNT/qhhFFmsnlZecwU+De2iRX4YCms7YUv2I8VBB+MSNpiA9iykY
	 xyYncceolzB0iOOXCfPB/XtGUgqydXUG2ucXhNX3nLslQgwy7OHH0BNFNE0TnqdEey
	 s0PzuTPf4EyYItzzEY31Xa6XdjWR7HcWWdhxhSBI=
Date: Mon, 19 Aug 2024 18:01:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Mike Yuan <me@yhndnzj.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko
 <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from
 parent cg too
Message-Id: <20240819180131.27b0ea66dd50b83c85102540@linux-foundation.org>
In-Reply-To: <CAJD7tkaY3FsL-9YeDuVG=QtCK-dgm71EJ2L_T3KfGUa9VW_JkA@mail.gmail.com>
References: <20240814171800.23558-1-me@yhndnzj.com>
	<CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
	<CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com>
	<a2f67cbcc987cdb2d907f9c133e7fcb6a848992d.camel@yhndnzj.com>
	<CAKEwX=MDZdAHei3=UyYrsgWqyt-41_vOdCvTxj35O62NZhcN2A@mail.gmail.com>
	<20240815150819.9873910fa73a3f9f5e37ef4d@linux-foundation.org>
	<CAJD7tkZ3v9N1D=0SSphPFMETbih5DadcAiOK=VVv=7J6_ohytQ@mail.gmail.com>
	<CAKEwX=Pz4Pe-CAevBvxUCpPZJ-fRseLN4T35Wt3mb84gqCY25w@mail.gmail.com>
	<CAJD7tkaY3FsL-9YeDuVG=QtCK-dgm71EJ2L_T3KfGUa9VW_JkA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 12:05:44 -0700 Yosry Ahmed <yosryahmed@google.com> wrote:

> > Ah yeah, I was thinking this could be done in a follow-up patch.
> >
> > But yes, please - documentation. Preferably everything together as v2.
> >
> > >
> > > Also, do we want a Fixes tag and to backport this so that current
> > > users get the new behavior ASAP?
> >
> > Hmm, I wonder if it's more confusing for users to change the behavior
> > in older kernels.
> >
> > (OTOH, if this already is what people expect, then yeah it's a good
> > idea to backport).
> 
> My rationale is that if people will inevitably get the behavior change
> when they upgrade their kernel, I'd rather they get it sooner rather
> than later, before more users start depending on the old behavior.
> 
> I am guessing there is a chance this is not what backports are meant
> for. Andrew, any thoughts on this?

I agree.  It does depend on how long the old behavior has been out in
the field, and on our assessment of how many people are likely to
inconvenienced.  So... yes please, what is that Fixes:?


