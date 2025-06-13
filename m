Return-Path: <cgroups+bounces-8515-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D609AD84E4
	for <lists+cgroups@lfdr.de>; Fri, 13 Jun 2025 09:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E283A4F33
	for <lists+cgroups@lfdr.de>; Fri, 13 Jun 2025 07:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B332E6121;
	Fri, 13 Jun 2025 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbfxDFdg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30772E6110;
	Fri, 13 Jun 2025 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800338; cv=none; b=iw1TNvUlWvT+xV2KuNUxSpN8OtgDh5CuWS/MWKLzVQTKv47Ib2dfqBeDXIEro73z5nQ+VAe6SYK0DaqKRR+TiK00h2weQiYY8DxVEQ8wNA1GiNyQuEEZdO9WO0zcre1cjbP3F6AFSI5YQqaXjS/hrCp/ofbl6YUABO5Jr9Ep5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800338; c=relaxed/simple;
	bh=jlHx5hwuxTAqnwI8Qw4RJcIgRGyuIHjQkgvwwjwo2LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZeKVz5ZIvP9Kfr46z3fiq+7SBOR48SsL37q+ObGPJo4Z7mBg+Rc3QGS85UMOkwJWOASdsqdKoBzsJ61xyxdNN2ec+KyIj06+AkFfFW5kXahV3Kml3v0mJAJrxXUMj1CzihVJtDDmKVM887VVv1jwDzFC3eQE9PhObKhfL0LfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbfxDFdg; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b43c5c04fso1417131fa.0;
        Fri, 13 Jun 2025 00:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749800335; x=1750405135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2snE+bbgVXzx5opbdAh5YB6aoSkRDd4dkM12RKy9Zzo=;
        b=kbfxDFdg6v1kOz0nGAR1W9+SJDPfIv8zDUi9WjEgB4CYnjOYLgblkrfXE6ss5kR+M4
         YQ81YaEu6gRECn2dC1n0RSpR1wNcjFYCcOgtHieNwe3jBqs42Q14w/gArSUI0eYwSMUp
         P6BrkmsjFAsWAU5zYdigthy0TIId5hO722SehW2FrNubuPw3ub2mc//T8zbWULmSYF5M
         FhwIcwO3OgaNjPIEE1UO61S1NLGRIJBzLzBdSpYK2yrvdFDhECeg9fV8hWGy9A6QRyyX
         TUXW5Q/TK3Jjn3TOck45rhU+Mzt+yDADZRPnTGvJCLk7Js9GY7pKqTo0/v1Ec+a/azrj
         FudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749800335; x=1750405135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2snE+bbgVXzx5opbdAh5YB6aoSkRDd4dkM12RKy9Zzo=;
        b=ZQsQZHQlrovCTyvGwhirDPjmtk5xowfDEotWe0y7hfWz9QcUVekYyNEcJp6fkPxduK
         gwXd6u1urqV684jQq/BBpK8OAzpAcuWG4gmX/scpO8uS4HvwUJ7DWRz5MbxtMbkCFW+A
         sjugMUm/WFf0k+N12Z9uHttiuJUbuP/lKJdPQK64IFPDpQxZHxuqZE0Ja4MqHwjxYFKi
         ZkhgB27fJAGZC60jMrpNajrixEGfktEsCRokCBz3agKXUKZB89mMZ6Ipe6GNp7rpdSUF
         iC7i8sE6cpxomoHMqT/RW/9L9t4Jvcc0Evi8FIAslO7JHnn03ktarQA7hoewqXmLkZUr
         1hZw==
X-Forwarded-Encrypted: i=1; AJvYcCXP9g4STR9JGoAFRMSchFe4+WMlV/G2wGHveU9lb7QdV74iVyj6X+p0QbCcLH34Xym+OskFi9xC@vger.kernel.org, AJvYcCXxX0FmQSpQA3J9lwlgMI6CWQK8lBZY0De1W+Tptym6eWsoOLOlOvR78YiWaNrYv9U0AH64HTdFyh4cQtQG@vger.kernel.org
X-Gm-Message-State: AOJu0YynzhfTPqB8aQ7WzZbYu32kbwp9/bT5awYlv0F6HjsJ5ugoC2We
	WbE8DXE1HgxLSfB2cuO66Kr/G4PuLkvTV9GwcutPaJPdLwGVZpd7EqicAV4+dQPOl27KWMBvGtF
	qgH4bTmdwlHjd3qddWPqpBsBbp0qRsGM=
X-Gm-Gg: ASbGnct4tcSvbsL2gZNVKZR3/kQ4tDCrLpFmhFrB5GAMDS26yjcduG9XYhDzhVblNIn
	9anxglBhtFJPDza+ZGRAgcQzJedYi5Ecbv0/HSD09r9wI9nxibjEjKW9lxsVpbKLLnh+5nXoeok
	ZLUItDwcQWPLVHD3CxxNkkQlAur/0Kh6UWKnN0ydkdCqvr2uCB9ExIUQ==
X-Google-Smtp-Source: AGHT+IFh4Z8yJABYXTto0CU65jTSk1UpTtOC9b00IjTJotmc+C0ThKDtLHCbIRjhpDo5TyNPFR6UwC+r5s3jPRZRZ2s=
X-Received: by 2002:a2e:bea0:0:b0:30d:c4c3:eafa with SMTP id
 38308e7fff4ca-32b3fd76eb9mr4076051fa.7.1749800334347; Fri, 13 Jun 2025
 00:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612103743.3385842-1-youngjun.park@lge.com>
 <20250612103743.3385842-3-youngjun.park@lge.com> <CAMgjq7BJE9ALFG4N8wb-hdkC+b-8d1+ckXL9D6pbbfgiXfuzPA@mail.gmail.com>
 <CAKEwX=PsGKS5JHqQ-G29Fg8xLssPhM+E-4wV_QakhqrDOsV36g@mail.gmail.com>
 <CAMgjq7Aq1LW9wFgyQ4oCS5Su23X62S+5ZW_d5OydJj-pp2n21Q@mail.gmail.com>
 <CAKEwX=PD+P_wugkAJ83ti6YRo4-6QNM7HDFs+KDURVwx2JrnZg@mail.gmail.com>
 <aEvPBSObBrrQCsa3@yjaykim-PowerEdge-T330> <CAMgjq7BzQ8bKKXuHB=TiQnkdSdCuABXrRf8Z8w2QkjpD44jdgA@mail.gmail.com>
In-Reply-To: <CAMgjq7BzQ8bKKXuHB=TiQnkdSdCuABXrRf8Z8w2QkjpD44jdgA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 13 Jun 2025 15:38:37 +0800
X-Gm-Features: AX0GCFvf-NtVlOutH0cboEpQxncMH9Qo2kIalrzH-ZX5C1AFR5cVChJfxC3ceRc
Message-ID: <CAMgjq7BPQx93GhaUU0sURVkhf7AofE-qqzSwXS22RXnJhE=3Rw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm: swap: apply per cgroup swap priority
 mechansim on swap layer
To: YoungJun Park <youngjun.park@lge.com>
Cc: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shikemeng@huaweicloud.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, muchun.song@linux.dev, iamjoonsoo.kim@lge.com, 
	taejoon.song@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 3:36=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Fri, Jun 13, 2025 at 3:11=E2=80=AFPM YoungJun Park <youngjun.park@lge.=
com> wrote:
> >
> > On Thu, Jun 12, 2025 at 01:08:08PM -0700, Nhat Pham wrote:
> > > On Thu, Jun 12, 2025 at 11:20=E2=80=AFAM Kairui Song <ryncsn@gmail.co=
m> wrote:
> > > >
> > > > On Fri, Jun 13, 2025 at 1:28=E2=80=AFAM Nhat Pham <nphamcs@gmail.co=
m> wrote:
> > > > >
> > > > > On Thu, Jun 12, 2025 at 4:14=E2=80=AFAM Kairui Song <ryncsn@gmail=
.com> wrote:
> > > > > >
> > > > > > On Thu, Jun 12, 2025 at 6:43=E2=80=AFPM <youngjun.park@lge.com>=
 wrote:
> > > > > > >
> > > > > > > From: "youngjun.park" <youngjun.park@lge.com>
> > > > > > >
> > > > > >
> > > > > > Hi, Youngjun,
> > > > > >
> > > > > > Thanks for sharing this series.
> > > > > >
> > > > > > > This patch implements swap device selection and swap on/off p=
ropagation
> > > > > > > when a cgroup-specific swap priority is set.
> > > > > > >
> > > > > > > There is one workaround to this implementation as follows.
> > > > > > > Current per-cpu swap cluster enforces swap device selection b=
ased solely
> > > > > > > on CPU locality, overriding the swap cgroup's configured prio=
rities.
> > > > > >
> > > > > > I've been thinking about this, we can switch to a per-cgroup-pe=
r-cpu
> > > > > > next cluster selector, the problem with current code is that sw=
ap
> > > > >
> > > > > What about per-cpu-per-order-per-swap-device :-? Number of swap
> > > > > devices is gonna be smaller than number of cgroups, right?
> > > >
> > > > Hi Nhat,
> > > >
> > > > The problem is per cgroup makes more sense (I was suggested to use
> > > > cgroup level locality at the very beginning of the implementation o=
f
> > > > the allocator in the mail list, but it was hard to do so at that
> > > > time), for container environments, a cgroup is a container that run=
s
> > > > one type of workload, so it has its own locality. Things like syste=
md
> > > > also organize different desktop workloads into cgroups. The whole
> > > > point is about cgroup.
> > >
> > > Yeah I know what cgroup represents. Which is why I mentioned in the
> > > next paragraph that are still making decisions based per-cgroup - we
> > > just organize the per-cpu cache based on swap devices. This way, two
> > > cgroups with similar/same priority list can share the clusters, for
> > > each swapfile, in each CPU. There will be a lot less duplication and
> > > overhead. And two cgroups with different priority lists won't
> > > interfere with each other, since they'll target different swapfiles.
> > >
> > > Unless we want to nudge the swapfiles/clusters to be self-partitioned
> > > among the cgroups? :) IOW, each cluster contains pages mostly from a
> > > single cgroup (with some stranglers mixed in). I suppose that will be
> > > very useful for swap on rotational drives where read contiguity is
> > > imperative, but not sure about other backends :-?
> > > Anyway, no strong opinions to be completely honest :) Was just
> > > throwing out some ideas. Per-cgroup-per-cpu-per-order sounds good to
> > > me too, if it's easy to do.
> >
> > Good point!
> > I agree with the mention that self-partitioned clusters and duplicated =
priority.
> > One concern is the cost of synchronization.
> > Specifically the one incurred when accessing the prioritized swap devic=
e
> > From a simple performance perspective, a per-cgroup-per-CPU implementat=
ion
> > seems favorable - in line with the current swap allocation fastpath.
> >
> > It seems most reasonable to carefully compare the pros and cons of the
> > tow approaches.
> >
> > To summaraize,
> >
> > Option 1. per-cgroup-per-cpu
> > Pros: upstream fit. performance.
> > Cons: duplicate priority(some memory structure consumtion cost),
> > self partioned cluster
> >
> > Option 2. per-cpu-per-order(per-device)
> > Pros: Cons of Option1
> > Cons: Pros of Option1
> >
> > It's not easy to draw a definitive conclusion right away,
> > I should also evaluate other pros and cons that may arise during actual
> > implementation.
> > so I'd like to take some time to review things in more detail
> > and share my thoughs and conclusions in the next patch series.
> >
> > What do you think, Nhat and Kairui?
>
> Ah, I think what might be best fits here is, each cgroup have a pcp
> device list,  and each device have a pcp cluster list:
>
> folio -> mem_cgroup -> swap_priority (maybe a more generic name is
> better?) -> swap_device_pcp (recording only the *si per order)
> swap_device_info -> swap_cluster_pcp (cluster offset per order)

Sorry the truncate made this hard to read, let me try again:

folio ->
  mem_cgroup ->
    swap_priority (maybe a more generic name is better?) ->
      swap_device_pcp (recording only the *si per order)

And:
swap_device_info ->
  swap_cluster_pcp (cluster offset per order)

And if mem_cgroup -> swap_priority is NULL,
fallback to a global swap_device_pcp.

