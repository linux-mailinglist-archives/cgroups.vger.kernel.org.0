Return-Path: <cgroups+bounces-4315-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D900A953D2E
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2024 00:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9131A288516
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 22:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAD1155330;
	Thu, 15 Aug 2024 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dqq4S1TX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C8F154BF8
	for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723759846; cv=none; b=lhAJmn851OPXtN1auTncQl25boo6JLXvB30tsDEmS55qeolCrmiHqetwHe7ylaZn4CeiS6XRRM21U3qePJ/g/vSFP7/lYDsoDpuCbG6ajOfpQXYMd3Cts4ahtQd/o0RoHDeoY+GCGVuxLRM98NKJFN6QFjd2ZisUCJlI/25LMt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723759846; c=relaxed/simple;
	bh=WbC5d4M1KKpH56P3a+lNKOT6nVYNXfHRA4vpXTBhih8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tD97CXg1aOaSl06io6Sy+ZK5TrMfsSfbCUHl9bUMO5BeJJOyBYtSO7FiIXFB3mPp/dOCKbMUVaJ/r37iWTeTR/tSr5wOWjac1R33MhBaT/rfrujVM5qYHqr6H+jRPihNWB164y76diJLsq0fcEG694uDyq1dEcAfVzbMUR5iAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dqq4S1TX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso2121112a12.1
        for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 15:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723759842; x=1724364642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbC5d4M1KKpH56P3a+lNKOT6nVYNXfHRA4vpXTBhih8=;
        b=Dqq4S1TXDgFuofU+xhw5Bw38sJ0yJNqcC2R//lHlTbhNUJAbmP2TDh/W4+LmhcSZ+X
         vEzs6QaolhXCsGZ3v/qSI/9ysK/c9QVIk9jxy/s+tMcfosX62dqGDlaUatycvFee/ZvJ
         oJGMYpY0Ma5gWXZfZDoGItUlTJB1U6PSYvnhFbkNaH7ObWnllr4MKYTuJxDiEUcUhCVv
         kKo79GCfxaOOzi6Rq+eNmGigFMC840hbkjLFxkwKFepJ7ll9W9yuvOF2UfJHg6hxjysC
         dSACqv7LvRbx6tw+C4NJ4OnOzUZfjM9r7H3hJnRVhRW/YTEBB4olf+gDu50wun0xxj4b
         IeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723759842; x=1724364642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbC5d4M1KKpH56P3a+lNKOT6nVYNXfHRA4vpXTBhih8=;
        b=Wzpiu55bS5uRqIm0jaT3/XPuGuw23QI5VE8TGAYF117+4WM39p1FBJ3/GG6LQrJj+Y
         ZpXSK09UztbczpfjabDqzQeE4VLYrC8NmX0uC839oeF/mHJvBNtH/A9+AXxwENcj3Urq
         JfWjIE7S8LJhYPrPQbrGbDawBL3qq1OmbFvA17M82T3mmMTkReJ7EC6n9E0WdSAuDdJU
         Mhe4RvBwbzFweTCHYhJ/PAjB2qZqVXMEIess9tu1QA2j4ltqGxvdrV/6Fk7kwBahopU7
         vu0ioZ8hA9ziwqY/cWy2bm9UL7+EzIOJmWGLERZrsB8jDx31e6Hjo3hN/O8ZdZgaZzGq
         wUrg==
X-Forwarded-Encrypted: i=1; AJvYcCWMPZ3ufbdi/9+JbhvwAd95Cc6GtfbQ0gR9QVSdSAkPTyd3mO24xkMAu8AiTx9gOHPXyyF8AWkE8BqrLJFDanB67XwowgkcDg==
X-Gm-Message-State: AOJu0YwMy1MVCzWHJaMSp6Xv8zTwd6TL90opEDQC9kA5314xrSGHuJKI
	9PSLbXYFWQCPWMYYjMmM3Jks1JMeGNZRClFwtJVOjjEW0h12jLEA+5Eg+GF2WqxjhJbunmEqUlM
	O+Y1Y5uwgS0YtawlAul8OPcSvUK/A43d+pWuo
X-Google-Smtp-Source: AGHT+IHDPmf6+ClOONhZk9Nso0W2EhtmarkGmfQfspzadJOIG/HidFZptnUBVVUkiTtl79ePE2onlXdj3/v0NAL6Wxc=
X-Received: by 2002:a17:907:97c3:b0:a7a:bae8:f2a1 with SMTP id
 a640c23a62f3a-a8392a03c21mr69498266b.42.1723759841582; Thu, 15 Aug 2024
 15:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814171800.23558-1-me@yhndnzj.com> <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
 <CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com>
 <a2f67cbcc987cdb2d907f9c133e7fcb6a848992d.camel@yhndnzj.com>
 <CAKEwX=MDZdAHei3=UyYrsgWqyt-41_vOdCvTxj35O62NZhcN2A@mail.gmail.com> <20240815150819.9873910fa73a3f9f5e37ef4d@linux-foundation.org>
In-Reply-To: <20240815150819.9873910fa73a3f9f5e37ef4d@linux-foundation.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 15 Aug 2024 15:10:05 -0700
Message-ID: <CAJD7tkZ3v9N1D=0SSphPFMETbih5DadcAiOK=VVv=7J6_ohytQ@mail.gmail.com>
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

On Thu, Aug 15, 2024 at 3:08=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 15 Aug 2024 12:12:26 -0700 Nhat Pham <nphamcs@gmail.com> wrote:
>
> > > Yeah, I thought about the other way around and reached the same
> > > conclusion.
> > > And there's permission boundary in the mix too - if root disables zsw=
ap
> > > writeback for its cgroup, the subcgroups, which could possibly be own=
ed
> > > by other users, should not be able to reenable this.
> >
> > Hmm yeah, I think I agree with your and Yosry's reasonings :) It
> > doesn't affect our use case AFAICS, and the code looks solid to me,
> > so:
> >
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
>
> But you'd still like an update to Documentation/admin-guide/cgroup-v2.rst=
?


Yeah I'd rather see a v2 with updated docs, and hopefully a selftest
if the existing tests problem is resolved.

Also, do we want a Fixes tag and to backport this so that current
users get the new behavior ASAP?

