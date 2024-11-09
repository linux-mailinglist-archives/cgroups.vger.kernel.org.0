Return-Path: <cgroups+bounces-5497-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEE19C2F2B
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 19:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CE3BB21979
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894FF19ABAB;
	Sat,  9 Nov 2024 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dV6taRWo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C7E13BACB;
	Sat,  9 Nov 2024 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731177294; cv=none; b=VT0Xytokg6Rd378N1HfvnBAPbqVwj1BBn2z0QI4/ZBhR0Fr6RwukpmVVuteE9v/Gd2NUT7vvBS6kkETPT5b0+ez07XHOpNPfAV+z6icPoxBomOnsXEvd0AtATdJSqYS/f26o7oRlv4oLC3bSHmXhpNuuyDCARS+1skbsNQqk4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731177294; c=relaxed/simple;
	bh=Y9UwVErHmVJvfwqmBtKpEzqsP0sdSI7VmMWVCV0njN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BClInbQb7wj+WUtZV9Xx5/QNCVOayOd2WmLchMeUrgtFENFPPeGbMnU7r79Qs9SjaAihvLUBzQXkZ5pJ7t9BWfmLpGST2ZfUYT54YDXqi209//qFa0zBt2RsSzMPwQPc57b8JR9ElJGEIyxNy9yoUlOuQeGSFxM9YhUnXCM84xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dV6taRWo; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso546026566b.1;
        Sat, 09 Nov 2024 10:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731177291; x=1731782091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9UwVErHmVJvfwqmBtKpEzqsP0sdSI7VmMWVCV0njN8=;
        b=dV6taRWosDW1LmN7IJVFDgb6EAFSizbN9/mu+AOj6YRZUZiMYC2wH9BoNaQ9yB3ZZO
         a2m0epIZ7tmyQ/k6tq/Xf5pI2q/QG48L0z40BjnQ3KWi7U4QYqm5nkj1be9vKZsPtf4c
         XwR3ai4clKFXJlTQDT/L+BiChdHTLjzSAcfm+NuU3/iftSrFGV+Y/UfOwxBezSY2+Gcy
         3ZBFwYI/vwDpJNiEBr6N6ZV+6/+0uye8IUN/YCWSzZLCVZgf6mxPf4RtiKnBCxTNR6CI
         ghXtwYw2eCe9kbIN07PgHW6o9c6gj2iA8II5Loato+/lIUy182HU+L0bDL6KxWc2YFg1
         U4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731177291; x=1731782091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9UwVErHmVJvfwqmBtKpEzqsP0sdSI7VmMWVCV0njN8=;
        b=T4BbRM1RmNnRQm1fRdfjHdLqJYMJzwqkBuQCHsd+vn8QYoHY84HAaoSwHRURVa4Muu
         AhB185lf9b0hfZgddTwHSnqfb83coO5wULL1rBayK67662x9i6/TmEkmynGW2Iikl/3B
         sd52n3oqsYoqGPm53/zpss1DY1eK1QSqphSvZpr+xvLmJQ9Gf0TDsaY81tBkXzHoNXVU
         wwbmhgHA+tXs39vYvdO9vSQ9B4E5+k/dYl2IJ0PYmNxXxIcejLQ15wgLAzTgAewBRUnd
         kj9STInUaRIdTR13TU7SaWHiH57GOU80y3ylMxC2o7j7IBINHNo8DPRRbeFOhLHy9ety
         rwXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUStZFn+y4xpbvdUuPfpJedRFlx07UQdzMgqptxdo5AChOk5VU1HYnlw8Ugj+BlOzAaG0W7AArpb2b5vExW@vger.kernel.org, AJvYcCXJBFkkguHpXtwoeqquUJ1vHflhX+HVCqXL/uTyh0k/JoDvhQo358jH0KxQGjnFD/Bgmmycbu3H@vger.kernel.org
X-Gm-Message-State: AOJu0YzeB8QYoXpvG50LodVwrRkUxhfWgwMSBHSqrV41wpHx/seFkTnM
	5+0gkFs9LzyB71/sNwL5xePhqLWg+3sUB7qsbsWl2s8xuAcsgn/Rtora295zc5h6l/gSOh7K2RQ
	d3e714W3KFcvS0hFZ/pMDVYsc7lc=
X-Google-Smtp-Source: AGHT+IHXb1Fi848c0NJ3KrNiUrX9EnIwnwvCobZKUoqzJV31JvxaGAsQV9fqaCb5MlSzG/o/oz2VVcvFt5pYuFzZvnU=
X-Received: by 2002:a17:907:26c2:b0:a9e:c442:2c15 with SMTP id
 a640c23a62f3a-a9eefff1869mr760216366b.38.1731177290630; Sat, 09 Nov 2024
 10:34:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108212946.2642085-1-joshua.hahnjy@gmail.com>
 <20241108212946.2642085-4-joshua.hahnjy@gmail.com> <CAJD7tkaKzLu0DfMynvPg+-78YAZNMCcEoM3wXPx9qfcAxZzUgg@mail.gmail.com>
In-Reply-To: <CAJD7tkaKzLu0DfMynvPg+-78YAZNMCcEoM3wXPx9qfcAxZzUgg@mail.gmail.com>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Sat, 9 Nov 2024 13:34:39 -0500
Message-ID: <CAN+CAwOKUP7QAfzRAY53VT=qCHoVPT_RG4FMyxvha3XTg1xX6g@mail.gmail.com>
Subject: Re: [PATCH 3/3] memcg/hugetlb: Deprecate memcg hugetlb
 try-commit-cancel protocol
To: Yosry Ahmed <yosryahmed@google.com>
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 6:08=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Fri, Nov 8, 2024 at 1:30=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.c=
om> wrote:
> >
> > This patch fully deprecates the mem_cgroup_{try, commit, cancel} charge
> > functions, as well as their hugetlb variants. Please note that this
> > patch relies on [1], which removes the last references (from memcg-v1)
> > to some of these functions.
>
> Nit: We are not really "deprecating" them, we are removing them.
> Deprecation is usually tied to user-visible APIs that we cannot just
> remove, at least not right away. Please rephrase the subject and
> commit log accordingly.
>
> >
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> >
> > [1] https://lore.kernel.org/linux-mm/20241025012304.2473312-1-shakeel.b=
utt@linux.dev/

Hi Yosry,

Thank you for letting me know. To be completely honest, I think
I have been misusing the word in that case. You are correct,
the goal was to try and not change any functionality from the
user perspective, so I think removing is a better word, as you
suggested. I will make this change in the v3!

Have a great day,
Joshua

