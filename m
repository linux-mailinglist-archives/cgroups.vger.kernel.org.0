Return-Path: <cgroups+bounces-5499-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A89729C2F3E
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 19:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52CFB21376
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 18:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D945719EED3;
	Sat,  9 Nov 2024 18:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxwCLhFS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ACD15746F;
	Sat,  9 Nov 2024 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731178740; cv=none; b=c/yTqW+DtCXPsqs0xJC9wlNB2N4oPBcNMAy1fAXJYoMxholR9bIyBMi2PFQhYVy7+xEHfTZMXfP5ibeAQRhhevl5ExZ4MKDjpGm+6ZVVHQvA9OJ4b5LbXnFUnqpBTFdebwQEbSK5mKMdvd6brFyJagEipqNO97I6hehWnb5awrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731178740; c=relaxed/simple;
	bh=dLqzm3ZitTZ8L4sHAmqE3K5A9i0Tg0n1djx0dR+vM54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLmiTMbqWZNlBKgNe4uMt88ja/O2SWhfFQ7jwMXCWptTph4JycFtsNvBrQ+Qkq1YD7fb4KbNM9fw0nktP9lINjkphGwELAx6ENUlOwLrvcci8u/YxOCGOwA9zLj3D1c1yPrlxM6D1aYjkGvyc9oyOdHR8wl3U6J/6/N5Q78zoWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxwCLhFS; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9acafdb745so649355266b.0;
        Sat, 09 Nov 2024 10:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731178737; x=1731783537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkXlVsWL0LDP2pYZSQamK9+dqruXX3tJOG4uBlgHeNY=;
        b=OxwCLhFS6jmfdhgX78PUZJbb4NavHOsR0CpPexnZkMWkgqFKcqbf9ECg+zTcpxdchg
         cbSkgl4cF8s0tGbuUTAPrXVPU1ZDP4X0PJwUkq4iG/f7K8NQCOodPFxVLudSVpYYZdVf
         hKTF0GmAunzNsPNoXFaqc0MDkmDZZTJSVNpKTJe9z733tLpRCFWaedkeTM7o+qjx3gkX
         L4j2adL/Qc+l7FcSfR/zlK271TDOzp4NZO5iuWUhBs32K+5gu733zNr1ESETIa4bHwtr
         D+d5cMBVgaD++rhKynp2NLuYbeDxQkQhwC6wDDYM3Am0DF9xAvi/s4/FfoCWNHTXEb6m
         kYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731178737; x=1731783537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkXlVsWL0LDP2pYZSQamK9+dqruXX3tJOG4uBlgHeNY=;
        b=iWfy5we+5ywz/7qW4TTLXjVDP5qm6Phbq9Fckc1MRL/ZBVUxF7CkzFYUmEqAn1Fz41
         jpfXAr+7cwcZrKFDuIg9q6GaXHJC+6/YMcPAwSuLSSWMYoWgapIQ2S8HtGYL9nLPEKCi
         nMf6ArwQ5VUJKiFq3nzqr/rS4bzvAM0GVk/FSiQklWQ/EgR+/WDxyBFqAfd4KvpCg1ZO
         NTqZep5omFhEIKbl6eJINfMcRgQW/4tgCNQ44ajhG6c0czjLKqocVd866LvcXqCOb+f/
         L0lowIEVLScrnlZsUQB+j906jysc0w3VrFoF9XeFcontcHHwtkppfldpaJu3EQtPOvNx
         ZZRw==
X-Forwarded-Encrypted: i=1; AJvYcCVV/MCcEXNbHtOhDn2BMegU1qkKp1jPJ1d84XX7sK0UpqmFgayT21vaAVw7jDjjmiF7ubAGXvXW@vger.kernel.org, AJvYcCVeQhILrX33WL3iWZD3tgQkrSCnSyfXO8LFHzsYBfHjwE2xpK6N14B+EC+rm0YogyWRdGULipG0O57mhxp9@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk7A+sBhCdsJscUk5uJ2u2EJT0kl9l022VkClkbjbfaEdruYSn
	I6wnnVgJl3HGYTzpYv9KdpdihPKZPYI6sTYG+dDSOodlNYIpt5H4VbByvkzbFK0nD9dITqIXo8t
	4q7ZtT2DNDhWCV+aBYifZH9wzkMkMvg==
X-Google-Smtp-Source: AGHT+IEMHnjxHRVQ6HWzYS26PEZzRqHV3qeSPEb7/kPtEKJPdNiw7SS5CEd5p4EzAj7+0bt3ktx36WVY1m/0KKac/QY=
X-Received: by 2002:a17:907:9455:b0:a9a:b818:521d with SMTP id
 a640c23a62f3a-a9eec9cf03dmr802199566b.18.1731178736956; Sat, 09 Nov 2024
 10:58:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108212946.2642085-1-joshua.hahnjy@gmail.com>
 <20241108212946.2642085-3-joshua.hahnjy@gmail.com> <kpxl646zwhqcyrq23kfnslqdjgqy5s72vlq2uoc6vhfvwza2ld@yjyj3j6rnlag>
In-Reply-To: <kpxl646zwhqcyrq23kfnslqdjgqy5s72vlq2uoc6vhfvwza2ld@yjyj3j6rnlag>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Sat, 9 Nov 2024 13:58:46 -0500
Message-ID: <CAN+CAwN34zQdjuOhH0Vm0k6=im9=vVvwH_yCh_z4zvuMzPSjTg@mail.gmail.com>
Subject: Re: [PATCH 2/3] memcg/hugetlb: Introduce mem_cgroup_charge_hugetlb
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Shakeel, thank you for reviewing my patch!

On Fri, Nov 8, 2024 at 5:43=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Fri, Nov 08, 2024 at 01:29:45PM -0800, Joshua Hahn wrote:
> > This patch introduces mem_cgroup_charge_hugetlb, which combines the
> > logic of mem_cgroup{try,commit}_hugetlb. This reduces the footprint of
> > memcg in hugetlb code, and also consolidates the error path that memcg
> > can take into just one point.
> >
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > -     if (!memcg_charge_ret)
> > -             mem_cgroup_commit_charge(folio, memcg);
> > -     lruvec_stat_mod_folio(folio, NR_HUGETLB, pages_per_huge_page(h));
> > -     mem_cgroup_put(memcg);
> > +     ret =3D mem_cgroup_charge_hugetlb(folio, gfp);
> > +     if (ret =3D=3D -ENOMEM) {
> > +             spin_unlock_irq(&hugetlb_lock);
>
> spin_unlock_irq??

Thank you for the catch. I completely missed this after I
swapped the position of mem_cgroup_charge_hugetlb
to be called without the lock. I will fix this.

> > +             free_huge_folio(folio);
>
> free_huge_folio() will call lruvec_stat_mod_folio() unconditionally but
> you are only calling it on success. This may underflow the metric.

I was actually thinking about this too. I was wondering what would
make sense -- in the original draft of this patch, I had the charge
increment be called unconditionally as well. The idea was that
even though it would not make sense to have the stat incremented
when there is an error, it would eventually be corrected by
free_huge_folio's decrement. However, because there is nothing
stopping the user from checking the stat in this period, they may
temporarily see that the value is incremented in memory.stat,
even though they were not able to obtain this page.

With that said, maybe it makes sense to increment unconditionally,
if free also decrements unconditionally. This race condition is
not something that will cause a huge problem for the user,
although users relying on userspace monitors for memory.stat
to handle memory management may see some problems.

Maybe what would make the most sense is to do both
incrementing & decrementing conditionally as well.
Thank you for your feedback, I will iterate on this for the next version!

> > +int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
> > +{
> > +     struct mem_cgroup *memcg =3D get_mem_cgroup_from_current();
> > +     int ret =3D 0;
> > +
> > +     if (mem_cgroup_disabled() || !memcg_accounts_hugetlb() ||
> > +             !memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
> > +             ret =3D -EOPNOTSUPP;
>
> why EOPNOTSUPP? You need to return 0 here. We do want
> lruvec_stat_mod_folio() to be called.

In this case, I was just preserving the original code's return statements.
That is, in mem_cgroup_hugetlb_try_charge, the intended behavior
was to return -EOPNOTSUPP if any of these conditions were met.
If I understand the code correctly, calling lruvec_stat_mod_folio()
on this failure will be a noop, since either memcg doesn't account
hugetlb folios / there is no memcg / memcg is disabled.

With all of this said, I think your feedback makes the most sense
here, given the new semantics of the function: if there is no
memcg or memcg doesn't account hugetlb, then there is no
way that the limit can be reached! I will go forward with returning 0,
and calling lruvec_stat_mod_folio (which will be a noop).

Thank you for your detailed feedback. I wish I had caught these
errors myself, thank you for your time in reviewing my patch.

I hope you have a great rest of your weekend!
Joshua

