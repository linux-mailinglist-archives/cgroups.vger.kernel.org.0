Return-Path: <cgroups+bounces-8079-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8384AAEE8B
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 00:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F6A7B7661
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 22:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE70242928;
	Wed,  7 May 2025 22:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuZhRAhI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9CE28D8C9
	for <cgroups@vger.kernel.org>; Wed,  7 May 2025 22:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746655892; cv=none; b=lu09fa3JrpyxNOeizC3PrmB8GOZgx7jT05uM8iGEWABjS2qe8zlNHwofiNui5MrQEtbQd5PJkdttNlzNGZH7d/94XL/G7qYGgVgBvFM/MRfbpewCQ+UvVGbKda9UR/S+tO+oKPQfFN+GNH1KmLGBEFcWoMDycK95F4o0QI6hjFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746655892; c=relaxed/simple;
	bh=e/wF8jWPpKP/omVW3/Oh2nVdWf6erCfnXqTkbwt05XE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRhCHC1brvx3B2R3KjRBp3UgFnMeGbcmkSR5TbvFLY+K74TBw1hiCTGg0l+CsomTE4TACL7uqtEUmSKTvOBkclY1RIOLctxj/+dBz9gt+pd3euDiB7ToaqGoeZVQ2IfxTAJmah2Hn6OYYSMjt8o47DikNOOmgQYkLPIw5l0l0L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuZhRAhI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so43239566b.1
        for <cgroups@vger.kernel.org>; Wed, 07 May 2025 15:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746655888; x=1747260688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/wF8jWPpKP/omVW3/Oh2nVdWf6erCfnXqTkbwt05XE=;
        b=QuZhRAhIIbIOe+NNCzk1/RZ/BjrFzqhT/MdnWPox7dpxTbGppWG/6NMleXpYGQ4/jD
         2tFKrRog8ZGhb4HSpO8Eqnd5YzPTWs4+fBbFcXXiPaNGfn31gnEky9Ji0U3icbQ0SSb3
         LZLBV//3Ju7uEM0kECPq485efRlRrmt3KTCGg4b444Q6wAYGKNnO28VAsdbW9TuYB4mk
         G7Yb9o/kyPk6/PB6lqWZspoKIrRqX5kBj4zecsGXlAJF/XYuqOYP2w2O165QcKXZaeyY
         ixBMWG/GUMmklfkNqNAAWlmUF1PnKPLBzMlj+Kilrf3a8UxaeX5B1X4O4EucPBh7RQjk
         xdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746655888; x=1747260688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/wF8jWPpKP/omVW3/Oh2nVdWf6erCfnXqTkbwt05XE=;
        b=FJl7sF8BY80Qbx5L/mdwUkchTRWB9lB62WrwwwHLbFx6OfitQk8YCOOso05PGpgWAM
         VxtXMPk7xrfTzcfcln8Nu+SyK/5IQta3jZUVicPYkP1eOg0l88eGWcg69zjnXFu7MW6Y
         Qe1jOXsb8gbs/BHvEh/iVa3eUn1T6cFxNWItRHaKfo4MCorwto0yuirHIu6zKIiMmiku
         7GglNhciqyAjNZRf2hAKM1uKs1PeGrY7CsR2j0+JviIxCtY9p03mNw1ehMLJ080WKnT0
         cqiT+ESpG5AusOdUVKc66ZGrGB/+v1G4qTCIdwqG9BstKDzV/ZtYDmgct2Yd3m4ooWBP
         5A5g==
X-Forwarded-Encrypted: i=1; AJvYcCUcLULk8dV6RLnWBNNnV31xYv1yVbomeZAoEet8jFjWo3OBBnR42jffiA2gQaKOncFbyijGpgwf@vger.kernel.org
X-Gm-Message-State: AOJu0YxpJHGAiUeUly7p+1U18zQKQB3eMVzN7DCxdVjkGgehz8tX6Lo1
	n6sVwpJcu2XkqUjkFvk0yKy800EkCNeMESqymVBowmtrqoLwE2/RJvZQUGUBvy/skOn8aEyvsqC
	BvlNwN0CpsR/1qwm2ZUAxO3VawOQ=
X-Gm-Gg: ASbGncugduQQJHEwq4RqamSBWetXiqRxMpaM+NKRukDcrKsdYK3CBaJxbjvLwFuuKYY
	6KAeflNWxxDQLlSTkqjvhI/mm1UXjRKbYGl4X1HDuTzGElrn7oebLsd8TbkvjkCdVB5spiRYgv4
	gkzSLBW2ED8wrfdmEnwG10QgvPM6UtGY0=
X-Google-Smtp-Source: AGHT+IGK7hg699O1G7VtUqCETSuLiVGeMCxq5LNunpXF8PyQyX9K++c1adNqP9CZdwpu+p8E+labArtI2sBMixds4Bw=
X-Received: by 2002:a17:907:7da9:b0:ace:c540:ffda with SMTP id
 a640c23a62f3a-ad1e8bf69cemr435027066b.26.1746655888273; Wed, 07 May 2025
 15:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502034046.1625896-1-airlied@gmail.com> <20250507175238.GB276050@cmpxchg.org>
 <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com>
In-Reply-To: <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 8 May 2025 08:11:17 +1000
X-Gm-Features: ATxdqUE0t48D_J4NfX8UkSO40rS_eMQ8jOodU_q5EzZlkEyIHfblTJQ2jv6pXbc
Message-ID: <CAPM=9tw--fB7S75THKQQtLav2XPq9REU76keggKy2_jCJe+tYg@mail.gmail.com>
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, christian.koenig@amd.com, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 May 2025 at 08:03, Dave Airlie <airlied@gmail.com> wrote:
>
> On Thu, 8 May 2025 at 03:52, Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > Hello Dave,
> >
> > On Fri, May 02, 2025 at 01:35:59PM +1000, Dave Airlie wrote:
> > > Hey all,
> > >
> > > This is my second attempt at adding the initial simple memcg/ttm
> > > integration.
> > >
> > > This varies from the first attempt in two major ways:
> > >
> > > 1. Instead of using __GFP_ACCOUNT and direct calling kmem charges
> > > for pool memory, and directly hitting the GPU statistic, Waiman
> > > suggested I just do what the network socket stuff did, which looks
> > > simpler. So this adds two new memcg apis that wrap accounting.
> > > The pages no longer get assigned the memcg, it's owned by the
> > > larger BO object which makes more sense.
> >
> > Unfortunately, this was bad advice :(
> >
> > Naked-charging like this is quite awkward from the memcg side. It
> > requires consumer-specific charge paths in the memcg code, adds stat
> > counters that are memcg-only with no system-wide equivalent, and it's
> > difficult for the memcg maintainers to keep track of the link between
> > what's in the counter and the actual physical memory that is supposed
> > to be tracked.
> >
> > The network and a few others like it are rather begrudging exceptions
> > because they do not have a suitable page context or otherwise didn't
> > fit the charging scheme. They're not good examples to follow if it can
> > at all be avoided.
>
> I unfortunately feel GPU might fit in this category as well, we aren't
> allocating pages in the traditional manner, so we have a number of
> problems with doing it at the page level.
>
> I think the biggest barrier to doing page level tracking is with the
> page pools we have to keep. When we need CPU uncached pages, we
> allocate a bunch of pages and do the work to fix their cpu mappings to
> be uncached, this work is costly, so when we no longer need the
> uncached pages in an object, we return them to a pool rather than to
> the central allocator. We then use a shrinker to empty the pool and
> undo the cpu mapping change. We also do equivalent pools for dma able
> and 32-bit dma able pages if they are used.
>
> This means that if userspace allocates a large uncached object, and we
> account it to the current memcg with __GFP_ACCOUNT, then when it gets
> handed back to the pool we have to remove it from the memcg
> accounting. This was where I used the memcg kmem charge/uncharges,
> uncharge on adding to pool and charge on reuse. However kmem seems
> like the wrong place to charge, but it's where the initial
> __GFP_ACCOUNT will put those pages. This is why the suggestions to use
> the network solution worked better for me, I can do all the work
> outside the pool code at a slightly higher level (the same level where
> we charge/uncharge dmem), and I don't have to worry about handling the
> different pool types etc. We also don't need page->memcg to be set for
> these pages I don't think as all pages are part of a large object and
> the object is what gets swapped or freed, not parts of it.

With all that said we also manage moving objects to swap and maybe for
proper accounting of
swapping I need the more detailed integrated approach at the lower
levels, so objects that have
been swapped get removed from the gpu counter and added to the normal
swap counters.

Dave.

>
> >
> > __GFP_ACCOUNT and an enum node_stat_item is the much preferred way. I
> > have no objections to exports if you need to charge and account memory
> > from a module.
>
> Now maybe it makes sense to add a node_stat_item for this as well as
> the GPU memcg accounting so we can have it accounted in both places,
> right now mm has no insight statistics wise into this memory at all,
> other than it being pages allocated.
>
> Dave.

