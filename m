Return-Path: <cgroups+bounces-8508-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4873FAD79B4
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 20:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2ACA3A297B
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 18:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A29529C32B;
	Thu, 12 Jun 2025 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDmlL8lq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418E10957;
	Thu, 12 Jun 2025 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749752428; cv=none; b=oSre6s33fWQHooK/e2PpOKPzi5lxxeKxOXZXS1uJsC7zC/CygEXIvb7JyUQyLf9dCL8IdcDHGVWd8KKeNhialfjKU0hi5Tp1dQJ95Uuk5rEJeJ6yDi72msn71Le498J3gqHW2JK/FWkfH1beEsD0fVfFFQoMF6X6IefTXMimpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749752428; c=relaxed/simple;
	bh=M7yz7I1wAuRxqw4oRRjVoSOCqi9Pxn5c71tnJhYggcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJcqjR6/cq9KIpgV4p1yvZ7Mvfxhe7bNsBL+i+vBjgjEAY7m0JvYQ0fU0PXkAtxUXtXu4lnYWvTtUnX7XllHyFpbO2Qw9FLNnx6b6Keiv8UeMiYZLsf1W/4bxSPP0WxHRsURryNPlg4pkQ9rPLCZ643kxemQiJxhvIrGxDt0SJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDmlL8lq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so10623241fa.2;
        Thu, 12 Jun 2025 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749752425; x=1750357225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7yz7I1wAuRxqw4oRRjVoSOCqi9Pxn5c71tnJhYggcw=;
        b=nDmlL8lqLI0rBCElL5VFI5hmIW2wjmFtj7+2cUTjQXE6IZ6yXKD9CTEGdgWhAy/eRV
         trWKZ/BZzJsM5upM8kNc7qovLi7pEPyALm5D3VbUlyawlbHRw7YJ9r32n0RtPKqLn3sb
         6c1fyp8K5C5CkrAbfpPrRQYrajroKYPovQkkvBsbfERmTb/cFmLEPiY8cQKzCC1XlF0b
         Vo1n7BilU1MOaF6kZsuIZBBhxxvUdvCf4/NHng/pkpJT/yURbwxPfjnXWbiF8FOi42Vb
         ASJ548nGFO7PbZg3cco14K+CwElTApR/gGBIP3dKhqCk4f+ecX20z4aEXqrTdwjX3Usf
         zzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749752425; x=1750357225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7yz7I1wAuRxqw4oRRjVoSOCqi9Pxn5c71tnJhYggcw=;
        b=Ma7ZOZMQTOVCM7AOjPcScFnGUoSsOBZvhb7DFXjbtseDwfnMCGIX8YEeZ31u3szKqH
         St/beAUOwpXWkpuNigtHqOggWVA4ydjv80GXPOh+jPJ+XfJOyVRJkkA4C9tNxxNIrQkv
         PR7WCVVgfmVlsWt6qVX2UW0XWSTtVyifhTExSZ5FYLFeWLuwgoMeX0Xbd3HCotiLy3ZF
         BD5WYulLcO7fSpcxzawDv8hBUmXmP5WMP0tyXAG70P+nF2XLh3FdMU/VX1KaIleV8EFw
         eTzanigOHstpC+N9MQ9Qg8+r3Or75UZOlcqcFsYP5jPaenLLXmGK+1eGxcxAlHbSWF54
         /ZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM+znPvW9xOAD2QYAefzs50Q1zBUWIebxD+7jOiBNkTJZNA09SI0eEKcJPNOaXCtuyrmW7DofjjXd8lsNu@vger.kernel.org, AJvYcCXubSdNgfZTuswJG/Z/WRoy17VUAFhqIqaPXuimNJmdCMhoSv4nBCnWfaNlUr1rEQylxOD7GCHS@vger.kernel.org
X-Gm-Message-State: AOJu0YwA5ZbHFzRgOyWeyG1/OmR+LAXOd2LUibp+HJCSHuPV7bqOXA9c
	2+HnblPXi8WwoCpWa68G8hkX+S+VWEKVt4djKQjzQ7nDm36L0+6lWt9POoqJh9jEySa+8N1km3M
	YXPBaDYg6skSMjS4NUnz11WbZQXSLMzM=
X-Gm-Gg: ASbGncstxZCjFvSv2v/LlrckRTT4m02ZC3FVMXqjtcJqCFVGdfn0mdl1XNvwHK3B8EH
	vLUFsPatoCbk0Xxzpcdfp4mHRm7gfscU46cjUV6VnDduH5clB1oQqMrhOxtJDQnHXeYRiHSjYhi
	eWCrDHD5R0ed54kUlHVKinH1SlEUK2Vb1AbAf8OC3xIls=
X-Google-Smtp-Source: AGHT+IEb+Lpdx0f3VX9m0FhFY+QrMuqs6KMCM/kEXd7ilkczmtR2sPgb/2jEOeB2AklczYCK2s9Wo4pxPWUF40AJsDI=
X-Received: by 2002:a05:651c:2001:b0:32a:6994:59f0 with SMTP id
 38308e7fff4ca-32b3064f5cemr10252401fa.14.1749752424805; Thu, 12 Jun 2025
 11:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612103743.3385842-1-youngjun.park@lge.com>
 <20250612103743.3385842-3-youngjun.park@lge.com> <CAMgjq7BJE9ALFG4N8wb-hdkC+b-8d1+ckXL9D6pbbfgiXfuzPA@mail.gmail.com>
 <CAKEwX=PsGKS5JHqQ-G29Fg8xLssPhM+E-4wV_QakhqrDOsV36g@mail.gmail.com>
In-Reply-To: <CAKEwX=PsGKS5JHqQ-G29Fg8xLssPhM+E-4wV_QakhqrDOsV36g@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 13 Jun 2025 02:20:07 +0800
X-Gm-Features: AX0GCFuzE_a5aODtIcS9UuAT-NiQYIQMItNrAipneIN3jwWZCFv5rQ2PTK9ZqZY
Message-ID: <CAMgjq7Aq1LW9wFgyQ4oCS5Su23X62S+5ZW_d5OydJj-pp2n21Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm: swap: apply per cgroup swap priority
 mechansim on swap layer
To: Nhat Pham <nphamcs@gmail.com>
Cc: youngjun.park@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shikemeng@huaweicloud.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, muchun.song@linux.dev, iamjoonsoo.kim@lge.com, 
	taejoon.song@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 1:28=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Jun 12, 2025 at 4:14=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Thu, Jun 12, 2025 at 6:43=E2=80=AFPM <youngjun.park@lge.com> wrote:
> > >
> > > From: "youngjun.park" <youngjun.park@lge.com>
> > >
> >
> > Hi, Youngjun,
> >
> > Thanks for sharing this series.
> >
> > > This patch implements swap device selection and swap on/off propagati=
on
> > > when a cgroup-specific swap priority is set.
> > >
> > > There is one workaround to this implementation as follows.
> > > Current per-cpu swap cluster enforces swap device selection based sol=
ely
> > > on CPU locality, overriding the swap cgroup's configured priorities.
> >
> > I've been thinking about this, we can switch to a per-cgroup-per-cpu
> > next cluster selector, the problem with current code is that swap
>
> What about per-cpu-per-order-per-swap-device :-? Number of swap
> devices is gonna be smaller than number of cgroups, right?

Hi Nhat,

The problem is per cgroup makes more sense (I was suggested to use
cgroup level locality at the very beginning of the implementation of
the allocator in the mail list, but it was hard to do so at that
time), for container environments, a cgroup is a container that runs
one type of workload, so it has its own locality. Things like systemd
also organize different desktop workloads into cgroups. The whole
point is about cgroup.

There could be a lot of cgroups indeed, but not every one of them is
going to enable a cgroup level swap configuration. Youngjun used a
pointer in mem_cgroup, so disabled cgroups have no overhead.

We had a per-device-per-cpu-per-order table previously (before
1b7e90020eb77). It works. Only minor problem is allocation has to
iterate the plist first, then use the si->percpu, and usually there
are only a few swap devices, much less flexible than cgroups.

>
> At swap slot allocation time, we check the folio's swap device
> priority list, then pump that all the way to the swap allocator.
>
> swap allocator, given a priority list, for each priority level, try to
> allocate from that level first. It will get a cluster (either locally
> cached or a new one) from swap devices in that priority level, before
> moving on to the next priority level.

