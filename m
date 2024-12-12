Return-Path: <cgroups+bounces-5868-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF9E9EFAD0
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 19:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81ED7188EF23
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 18:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D56223E77;
	Thu, 12 Dec 2024 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX5S7Css"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A0A22332E;
	Thu, 12 Dec 2024 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027546; cv=none; b=EzFbhhbfOgsebXS36Rjr9SIYLx2uNtgq3QIKo8PGSGPASIzenaBMaV6OVGFAfjJAr9I3jiQwExpujnVf8fhpsHoLYfEvLXygiJ6RBkRThw3iWWq4DNH52Wf22knzkgTHpGNjXL5XPOhm9D2u1mhM8xjuZEKj1DDePAJ7xiL1GnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027546; c=relaxed/simple;
	bh=Ko2oS+MRlT4GT5PWtXrB9gMB+qbOgZcujdySYKtFg+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsLOyr//ld3qf6P0Hkmg37JNxgEGwJBo06D7P4RlRl5mGPB/dZ/wSyfkwrUzPBh9cEVr+ngqAC1S7Rypx5N53/UTyg52N2WaqAcTWKFomRcn4CT4BahU9fpNGgAoAapqVcrwKPeItTx0GNUZ+3I/m83T6cwxs0IoUakyQvXUyFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bX5S7Css; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d87ceb58a0so7507416d6.0;
        Thu, 12 Dec 2024 10:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734027542; x=1734632342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ko2oS+MRlT4GT5PWtXrB9gMB+qbOgZcujdySYKtFg+w=;
        b=bX5S7CssoTjtg5/GFEfs5Q9hSYxmV9JPEvl4LXP/6h0E0qaMUqiVJI7AT9/46wv0AA
         hXvVolT7NGujtL9Z4U7E3aBnXth/XEyl4JpQmXO74qE7OBdlBS1pmg/kW2Ptr7Ielgbr
         e3jfYrPk/eURF+Y7rB2siAFKhZWxZc5HOb5rF2TYtY+JOiF/2zBNPyfgPzsgz07S5y1f
         UpUNGUe9MbWFBryvCxaQCHhWxQszSjmmX3X3hJ9ZoME3fFuBEHmpN6MEzb2JFrht+aUr
         jz0u34hjZF5ecOgBSE15i326V+fgaTIQZbNNwLs9Svdfwsk5l5nt6Ei21JX+QPRdqm76
         y8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734027542; x=1734632342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ko2oS+MRlT4GT5PWtXrB9gMB+qbOgZcujdySYKtFg+w=;
        b=E0a0bsdgC92gl9apkdhlC+ST7mfLDNdeyTk2nlvkUPwP7dWOrPo3SFMhAkWhBGwUoh
         ixVmiS0CSYbCA6QCpPqNwOtfQK83ZiLOYtZXQlJ4oM5RsiYYumikMInq99/CntO1oM08
         m1OuobuvYSSFXI6YLMG7+Q2WlLeqWTbcDGVTHS+fNWPq7Cn23z2DU09GFrKiRk6fxMpd
         AHV5U9aySsecYpT8wRKHaRrDsflT2ATFlPf8N9S6lsyy/dixYvNCITUZ21XdeRpmBrL+
         20FZrIALHSO42AzETlLt/vBg17AWHWeNtQ+yPTfb0FzS6DmEu7MHynYPOC1Kgh8anRx9
         rF8A==
X-Forwarded-Encrypted: i=1; AJvYcCVVr611Jpsl3zQbtwxSLcLYUsXFzDYubhfLLaOb4MVINHOIsDkbcarRwY5P4RsJYk624DBEprqkNBum4JDK@vger.kernel.org, AJvYcCXdPR+ygBHQicQVG4SggfMqCI0p2MrGdK69weO5mmDQ14HX8bsqghyuiZtmLMwgDiAX0PG6Iiig@vger.kernel.org
X-Gm-Message-State: AOJu0YxuYtv9NXXz1JuX+fd92vjfSMnJXP/QT81tWWsdXS/NcKEoyZG2
	L+y+0M8gDAJPiBaAoSHqXYi8TonqM3cc09YFmNYplqNCZbkmZxgrOMxubqYu9DObb0vqgxbQ+JC
	weXB5H7sEzaN8k4QYe+7LyAw1A3w=
X-Gm-Gg: ASbGncsXcObZhpoJ+ktE6IKCpRlmArIDhQQp9/rwH3w8jbMRFkYuC21XAHE2zczOikH
	4UGkngA2JRBcK2VRa8jTyCZEKLSYYaBK0xkWpmN1ltBfxQXPoHf/Yqg==
X-Google-Smtp-Source: AGHT+IFNoU3CLIuT8qLnj94iT37F6awSRZbDnnjbgfCpFQ8D7WtTtHoh9SG4GO68UHHvEcwk+QowvfA25aJLdANqXQU=
X-Received: by 2002:a05:6214:2388:b0:6d8:9124:878e with SMTP id
 6a1803df08f44-6db0f709160mr20363076d6.4.1734027542519; Thu, 12 Dec 2024
 10:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212115754.38f798b3@fangorn> <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
 <4oxovutecmn7mkbbmbk3rhqudilivf6fkedvmcbcttmcspwebl@fp6pv2a45x6n> <0d9e676686db8e2025bc0c6dc2b55d17d9f16290.camel@surriel.com>
In-Reply-To: <0d9e676686db8e2025bc0c6dc2b55d17d9f16290.camel@surriel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Dec 2024 10:18:51 -0800
Message-ID: <CAKEwX=P9583dX+r31AFBTkMzr9f7jrXNO8cAmYupqizkaxU=Pg@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
To: Rik van Riel <riel@surriel.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, 
	Balbir Singh <balbirs@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 10:03=E2=80=AFAM Rik van Riel <riel@surriel.com> wr=
ote:
>
> On Thu, 2024-12-12 at 09:51 -0800, Shakeel Butt wrote:
> >
> > The fundamental issue is that the exiting process (killed by oomd or
> > simple exit) has to allocated memory but the cgroup is at limit and
> > the
> > reclaim is very very slow.
> >
> > I can see attacking this issue with multiple angles.
>
> Besides your proposed ideas, I suppose we could also limit
> the gfp_mask of an exiting reclaimer with eg. __GFP_NORETRY,
> but I do not know how effective that would be, since a single
> pass through the memory reclaim code was still taking dozens
> of seconds when I traced the "stuck" workloads.

I know we already discussed this, but it'd be nice if we can let the
exiting task go ahead with the page fault and bypass the memory
limits, if the page fault is crucial for it to make forward progress.
Not sure how feasible that is, and how to decide which page fault is
really crucial though :)

For the pathological memory.zswap.writeback disabling case in
particular, another thing we can do here is to make these
incompressible pages ineligible for further reclaim attempt, either by
putting them on a non-reclaim LRU, or putting them in the zswap LRU to
maintain total ordering of the LRUs. That way we can move on to other
sources (slab caches for example) quicker, or fail earlier? That said,
it remains to be seen what will happen if these incompressible pages
are literally all that are left...?

I'm biased to this idea though, because they have other benefits.
Maybe I'm just looking for excuses to revive the project ;)

