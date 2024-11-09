Return-Path: <cgroups+bounces-5496-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6489C2F28
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 19:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F881C21530
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 18:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED1F19ABAB;
	Sat,  9 Nov 2024 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XddECZ3D"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6AF4086A;
	Sat,  9 Nov 2024 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731177092; cv=none; b=r9/gyk/ZwlZJjkRB5F4x8ly8p8ciLfeIOCcUx8QLLjcwMtW78tagv5zSXotNyQlBcmDuP/0r2ti3KJp7wJUzX1m2ij0d8tJ1BHx8NQUrbUu8pRIqoIYWuwb9lA3zKnOBNa8q4ghJn8zWLvGuF0e9XkQsriy2NTAsiq5J8Rn0Iho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731177092; c=relaxed/simple;
	bh=k2DGsCYAdqZAvOnbgZKLhHDCTayax/zRf/CgqK6OKBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Elb13czyw2w41ctsvyMzVfKQ0YgI9GRFXYaJbMLpJzGYeAbGPsuwTAv6Iu4OUKzT9sXxK8plJVdqclWSLltkFNqkjDUIGGATv7ueMX0KrxpZPcntBQrSbkAodvTT1ad4YOUAdQ2kGF1qXkvs8zCTU6T1lmVx1LJ+iE4/uZD0FQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XddECZ3D; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4314b316495so26615535e9.2;
        Sat, 09 Nov 2024 10:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731177089; x=1731781889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfzWuC2VKQci1LCs0LoMNHQCT/EDdpW8OmOePIav1QE=;
        b=XddECZ3D3t4GEXCV42XJJTECCI0kVfmxmGcbs08+1bibsgyzkEvANVNbcp08RvKskF
         Mk6dQy17RYDD8Y8+kbJfooE4M9Bz2Kdq815B1WQg7zEnbwvotIJhttnbrv3Kigm8+rEs
         PNHpm2bFLiU2eWLb0lxHaGDfAocuQx5L0Pt3UfBkr8oObpxTEF3tSK7LWoFDoORx38B1
         I8mOMRBgF+WD0OpN33uTJ6SsUamJqOaHlIsYmCQB1bCFSCaBKhU8PonObW09Drh8Yvg3
         rYQqfh85gUmofGRZNLfgt/qifocmfHdTqOO6rWjFvJYwySER9Evc/7QV24csnSf/wCm0
         DAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731177089; x=1731781889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfzWuC2VKQci1LCs0LoMNHQCT/EDdpW8OmOePIav1QE=;
        b=Riii1lN5dBVrL8pccH0eFZ1AanecKowHBbzbdwRrOBHlNrNYIxBdjBrmkjRbd7IFPR
         HGKPCu7ghXmEi/r7MFQDz5kobVH0ZfKmasX+vK/FDvqQbuvXH5PU4P/c8KeQ1+AWR/de
         8EAylBrPn20KDxlL4cqaf1zVWuXdv+dqpz71WQVe1bQgpxjWbRtxLHhhutgKHpvYGRLL
         FXNFqG1arF5u/E49su4H0AZbBy1NL04hz45GbkN4jdYDCTEvS9i6g5LQ1YX/ssjT0R0E
         YJ9FaEj9GqyPHkXXDyRoC9NzBfbbDJgwmrLiLHqs0q0iOK6Cgr/PEBszxpYi6zzj59+f
         BwUw==
X-Forwarded-Encrypted: i=1; AJvYcCV5IFebpDD5DrHnrYarLUVCMzyiN3OFwAH0T7vOF6gBRzfJoOVIRWKRE1RMz76Bkbk+J15ApF1T@vger.kernel.org, AJvYcCVNbbuJ6QqHNXEuj1fTjNOsS+YhGdsqUT7UFvf3X+AGOfQtkNGyZWiyQ5fYHFPQeP9m2CSufY6rUTXtkWNF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ECbNeRbZcjF/Kt+Fqpcz+jl8Ic8uUJYToq9/iY0VMd40/CJa
	67Fzbw7DE6YWvSE8ip3usgbhFnH/K4e8wHSYY1r7POh2rD5VsE/JHy1nTXGSEGGvgwXfPsijZ6s
	UeAXAYssLARsbi0mDzEGIUx4zfqLPqw==
X-Google-Smtp-Source: AGHT+IF0NLYn7BIi/5HfOrx5IQ1AKJhnHgQtzt5a3COJdCArMWWpavCEutjEHDS7K1qQAzfml+9qN8xV04WAvvqwTsA=
X-Received: by 2002:a50:8adc:0:b0:5cf:f20:2b34 with SMTP id
 4fb4d7f45d1cf-5cf0f202b52mr4319002a12.17.1731177078136; Sat, 09 Nov 2024
 10:31:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108212946.2642085-1-joshua.hahnjy@gmail.com>
 <20241108212946.2642085-2-joshua.hahnjy@gmail.com> <elww7lzpj4htuhgdeu2e3j5mhogi54x6w75fk5sodaptletk3x@r2fnnh7gz72h>
 <CAJD7tkYdSeBDnR7rxpTJ5ZGVvLKbMcv_yH_U05Z_ycDWn8AQOg@mail.gmail.com>
In-Reply-To: <CAJD7tkYdSeBDnR7rxpTJ5ZGVvLKbMcv_yH_U05Z_ycDWn8AQOg@mail.gmail.com>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Sat, 9 Nov 2024 13:31:07 -0500
Message-ID: <CAN+CAwMMXxBdZQ+vQOsQAtrkEPyq_a=7Y6GQbfuzyUci--N=HQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] memcg/hugetlb: Introduce memcg_accounts_hugetlb
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 6:03=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Fri, Nov 8, 2024 at 2:21=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
> >
> > On Fri, Nov 08, 2024 at 01:29:44PM -0800, Joshua Hahn wrote:
> > > This patch isolates the check for whether memcg accounts hugetlb.
> > > This condition can only be true if the memcg mount option
> > > memory_hugetlb_accounting is on, which includes hugetlb usage
> > > in memory.current.
> > >
> > > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > >
> > > ---
> > >  mm/memcontrol.c | 17 ++++++++++++++---
> > >  1 file changed, 14 insertions(+), 3 deletions(-)
> > > +/* Forward declaration */
> > > +bool memcg_accounts_hugetlb(void);
> >
> > No need for forward declaration. Just define it here and make it static=
.
>
> Also please pull the #ifdef outside the function definition, e.g.
>
> #ifdef CONFIG_HUGETLB_PAGE
> static bool memcg_accounts_hugetlb(void)
> {
>      return cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
> }
> #else /* CONFIG_HUGETLB_PAGE */
> static bool memcg_accounts_hugetlb(void) { return false; }
> {
>      return false;
> }
> #endif /* CONFIG_HUGETLB_PAGE */
>

Hello Shakeel and Yosry,

Thank you for taking the time to review my patch.
Yes -- I will just declare the function & make it static. It was my
intention to group the new memcg charging functions together,
and in that effort I just made a forward declaration above.
However, I think that it does make the code look a bit more
messy, which is against the spirit of this patch series!

And Yosry, thank you for your feedback, I will separate the
definitions based on the #ifdef.

Thank you both, I hope you have a great day!
Joshua

