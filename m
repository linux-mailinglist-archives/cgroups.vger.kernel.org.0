Return-Path: <cgroups+bounces-4361-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734C6957ABE
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 03:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE201C20DB3
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 01:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E821429A;
	Tue, 20 Aug 2024 01:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="17kfsx7X"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772E412B73
	for <cgroups@vger.kernel.org>; Tue, 20 Aug 2024 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116045; cv=none; b=tVsVWKGEu7d7SMEh1opFku/jJ+MtJV/XfXvmLrgJbu8w4EP8NGog+nppaPU4ch+EIGum6BtWp3tb+COV4aQoKVmT79LMcg2EXiUmLdGMpVNVwOD8p0Lf4fMzKysI4j5JEnrGqA9CtiUQHZavNm79cwrlUMLFSACvYE3cv655nnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116045; c=relaxed/simple;
	bh=w9Z0/ePq+VtztcYvMD5t1di1u7sZ7xrCsQcAWPLd8vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cr6ImfRbBntHXqW14mo1wQ5ajKKDvdqiqX+M/IyldbnD8si57xY6umWZYXYnJhvetVVG2CmFE99eOmnL6Fvg4c8wQ/DL8QYnbE52pFf30Vw/9mqGp6cT/Otie4YDz0VQGlbF0HiJpyeG9gZCwUiGO6RFpY/OKN+UgkVZ/k93ytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=17kfsx7X; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a843bef98so555915966b.2
        for <cgroups@vger.kernel.org>; Mon, 19 Aug 2024 18:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724116042; x=1724720842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gqhda1EU3PbjzNUk/FZsxe6yiuKmVbG1fdaEhUu1EC0=;
        b=17kfsx7XLMlJgAQQ7pK7Fx/4kz4FxHwrjaQXjWel3qxhja7Wqf7Ayh6eGh1WP7Ff2P
         8t6zyhjyFNtuArFX3okmAzVXOs457fyORIrKqzAq35Z6q5P/rHMHuparzmIQF1CQObcP
         cfOo59O1+n1igY8wOzpjPt807mugFkziU3KJkIjhz5oXIkUQsvmjM51N7TWy0/6McY26
         zdVToH07t3OUH3tfGBpZeSWY6qlKcK2sXm8NaKz/3nUS7otH7cbkdaacW3FbrlUD3Z81
         /ASWIz64DVfBQ/KOgdXjH7+tPKX69zZZyehMzm7QMhld3SINPfyrV0s9BwDyiKa1QbBj
         nP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724116042; x=1724720842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gqhda1EU3PbjzNUk/FZsxe6yiuKmVbG1fdaEhUu1EC0=;
        b=JC02NDtw5mdtNxgkqKXCZvKHyEGuF3+SmUvrgUvdx/KOWH+Bc25Qd3p7gN8w/8eB74
         PeKpMUyR/5pAvCoALRgU3+6i+6p5iFf8xAjKYopmgcaLpsMUcXGzQTwkQp9T3/5ZfUNp
         tIwSXo7zp73STMbarOQrtMa7luRUnQCAo+1MtK6+CoTsdU/KzLK4rpKcWZJfnQ96NkqC
         mKoXUv1mWKZbvW8B7AN81Ny1vyEBa5r6t4/tcJBbMIW9NIJOJXrz371zGKfR94Xi4FAf
         bGaXjqv6bdrNvwZU41a4uajnQVDQQuN5E6sIzeM5Lv/ljyqWeA1MdVT9uq5awCYUM/6e
         3BXw==
X-Forwarded-Encrypted: i=1; AJvYcCWksfQjGgFaQSjIlVjrD+bL3WBC+rRwevojTUXhwaTMfcg+RGi70rVLStI1+cdP0aPvmISoRA5d@vger.kernel.org
X-Gm-Message-State: AOJu0Yywjz4wgJ6lJmwlbmLxHPGzCTm8im6XspdD+hDpsVuM1QtBwYEo
	BTXRP9TrTQAYmBdKV3qFgonWqphEmg54xtvp5zM1V1FtQfWeJpLEEAefSgPC3/A6sRJ/UAnpcOL
	gFEto8UaDbygdWeLu3CVbJpeKWoVcKf6BnMsh
X-Google-Smtp-Source: AGHT+IEpkyUPILcopb9spEmmNOJKOwpaXky/Jpzd8/ecb/9jPe0K0empPeLKdt9L4CjKeVSqvN+DMqH6lUtSvDsHlUw=
X-Received: by 2002:a17:907:7e84:b0:a77:b784:deba with SMTP id
 a640c23a62f3a-a83928a416cmr886060466b.6.1724116040985; Mon, 19 Aug 2024
 18:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814171800.23558-1-me@yhndnzj.com> <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
 <CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com>
 <a2f67cbcc987cdb2d907f9c133e7fcb6a848992d.camel@yhndnzj.com>
 <CAKEwX=MDZdAHei3=UyYrsgWqyt-41_vOdCvTxj35O62NZhcN2A@mail.gmail.com>
 <20240815150819.9873910fa73a3f9f5e37ef4d@linux-foundation.org>
 <CAJD7tkZ3v9N1D=0SSphPFMETbih5DadcAiOK=VVv=7J6_ohytQ@mail.gmail.com>
 <CAKEwX=Pz4Pe-CAevBvxUCpPZJ-fRseLN4T35Wt3mb84gqCY25w@mail.gmail.com>
 <CAJD7tkaY3FsL-9YeDuVG=QtCK-dgm71EJ2L_T3KfGUa9VW_JkA@mail.gmail.com> <20240819180131.27b0ea66dd50b83c85102540@linux-foundation.org>
In-Reply-To: <20240819180131.27b0ea66dd50b83c85102540@linux-foundation.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 19 Aug 2024 18:06:43 -0700
Message-ID: <CAJD7tkY5u4vYRytMb+nuW3VhA9xHEPVux=vv_+k9oA1haFxa9A@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from
 parent cg too
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 6:01=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 19 Aug 2024 12:05:44 -0700 Yosry Ahmed <yosryahmed@google.com> wr=
ote:
>
> > > Ah yeah, I was thinking this could be done in a follow-up patch.
> > >
> > > But yes, please - documentation. Preferably everything together as v2=
.
> > >
> > > >
> > > > Also, do we want a Fixes tag and to backport this so that current
> > > > users get the new behavior ASAP?
> > >
> > > Hmm, I wonder if it's more confusing for users to change the behavior
> > > in older kernels.
> > >
> > > (OTOH, if this already is what people expect, then yeah it's a good
> > > idea to backport).
> >
> > My rationale is that if people will inevitably get the behavior change
> > when they upgrade their kernel, I'd rather they get it sooner rather
> > than later, before more users start depending on the old behavior.
> >
> > I am guessing there is a chance this is not what backports are meant
> > for. Andrew, any thoughts on this?
>
> I agree.  It does depend on how long the old behavior has been out in
> the field, and on our assessment of how many people are likely to
> inconvenienced.  So... yes please, what is that Fixes:?
>

It's commit 501a06fe8e4c ("zswap: memcontrol: implement zswap
writeback disabling"). It landed in v6.8.

I suspect there aren't many users that depend on the old behavior so
far, so I would prefer to get this backported so that it's less likely
that more (or any) users start depending on the old behavior.

