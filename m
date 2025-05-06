Return-Path: <cgroups+bounces-8031-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E8DAAB88A
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 08:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61AD71C41923
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 06:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1549F34EC29;
	Tue,  6 May 2025 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBlC7I9a"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A4B350DE8
	for <cgroups@vger.kernel.org>; Tue,  6 May 2025 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493207; cv=none; b=cabLo6g10RzEJ96FAXpNbjKO10mxMtIrL3kiZB1Q4WhWUiY7ohsK7ea0rhHJ1YA+TnmzQlJrjhIqsD2XOACXrcN9i/P6WzIrf/XJg58UyxE37COD1uCp2jNjjbnKcsjjYC97R4wBdG2Zs2CTRmT8CytZ6wYmRKLmHM3VmnPdLoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493207; c=relaxed/simple;
	bh=5R81D6pXLeI58Px4MI6+StkbIro9njk+44YwXX+iqYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjN0FDgj6G4EZ7XhyOKjpl1MRbWOSInYSZmTq9h8IGRnP2oTOeLe7s40FQ7MEYxxVemZ9m8PHjGpuxtKfnvs3nfzujozELQL0UDdQkaVQdgmNHKlwAZFLWUCRYiNkYv3AJUHC8vEeo1KIf5isdriDSGQz5e5QqDrI5RqV5y031Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBlC7I9a; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ace333d5f7bso958281566b.3
        for <cgroups@vger.kernel.org>; Mon, 05 May 2025 18:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746493203; x=1747098003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5R81D6pXLeI58Px4MI6+StkbIro9njk+44YwXX+iqYs=;
        b=DBlC7I9aPr1h98yVTulBDuoJ/i8+XWtxs+OSbIowes1Tc3rEYpfIB6xWeTfvko1hrK
         Q1lisMz72cpE8be3YBheDXbEgdXbs2EWfwYjx47guztt1vaWALtFda6xHZCRZwY1P7K/
         VJu6nRwxbq6Cy8Pcg/BA8nV0gwng97cUvvEt848/0eRs2RuekEraQG0oCLLfOINcWoIL
         pMCx+iJ7i4kSVZQgZ05jFhIbbQc10nHGfzGbHCrH45eu0F6k9PIKki9qBgb3bkk5bN1P
         gyhBm+5jo5ZXs0a7l1SAM754yQEeenQ6zbpLIbgYKoAcPl4k1j95uweyR1Jxg6p5CxcD
         8w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746493203; x=1747098003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5R81D6pXLeI58Px4MI6+StkbIro9njk+44YwXX+iqYs=;
        b=SKqsQuGJ4uU6l+hyxTPhvZar9GWdVj1g//PP3iH0/yfyBKMVLBiy6XB8V+H7+/8tcE
         wt/4C0n++6l0HA5P+XZ3mYeSHhc4NX+a2w4sWmOFd4HLmloMqhZN4SqGbZB0GB/g5vU8
         qz/rG8Hfnph1Kl94MjnhOv3887qPUWCN3iAcykAolsYY3UpJMJF2i14NRTI+z8csvw7J
         bO0Q9aA35AAPfPVL0mTO29n0hzLxJ2d0aL5nRGyBeh0mkwXsj1k4hY0qyjtermNfhpv+
         WU/ZG3b3O0syMkhC+XxiHknz//2dS8jp3FsCLe48dsn2Bo/YLoSO5NbOWiWkCUuJuLQY
         WrIw==
X-Forwarded-Encrypted: i=1; AJvYcCW3AqeblB21kkqihRWk8HEM74feVxnBeoTS4Oe9W1OsuYHYjuCaPsGPMn5sWwGgIJcCRKdvEXqv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tvf0+O07ipStnVXM9KnL6mo1vETN9OGw6Fv/AjcYNJI00acw
	zQ8VuTguhIcUWvmxE7thyvBp2LsBuaUcMGIrRWce+XGYyOdPE0GltaSOK56UmHJ4DMckXDS4sJ6
	Kr6isLoroCQ5OKDGV/30AVv6bn38=
X-Gm-Gg: ASbGncuvcsyvJAwwEWTPN/qIhYavyUaSt/Hsn/S6kyxQjcMLWNRIXVMzhBgUnGpi7Jk
	0z+4qCbPo84Mqt6MGdy0QrSdFVZz/oVaLx1+mab3OOtd3RdkMqIu8mQCyIwfbmB8HDcYIArWIRy
	Pt8wnOtLTtzFn77ozXlrdb
X-Google-Smtp-Source: AGHT+IHCYyQWNIpyLCWc9H3OVPlOxI0B4ZTcatIhbhJ4lVyxoRZR5kJpe0A6MugPIL+frHkwoQgRIG0qKc11n5ViUZE=
X-Received: by 2002:a17:907:3d90:b0:aca:c9b5:31a8 with SMTP id
 a640c23a62f3a-ad1a4abedc0mr786336866b.45.1746493203215; Mon, 05 May 2025
 18:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502034046.1625896-1-airlied@gmail.com> <xa5d2zjyihtihuqu4zd63fqnwxwx57ss7rrfpiiubki3cxib25@kkgn26b2xcso>
In-Reply-To: <xa5d2zjyihtihuqu4zd63fqnwxwx57ss7rrfpiiubki3cxib25@kkgn26b2xcso>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 6 May 2025 10:59:51 +1000
X-Gm-Features: ATxdqUEQ1N5j7DpwIaP1vTgakJKUDxDussvNRSLElxjY-Wz8ZBJ_yuyPcyS4o3o
Message-ID: <CAPM=9txmnq2S3C_fyGysRt+DXCMq85QYXgnXfpwq=3v6=HAMDw@mail.gmail.com>
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, christian.koenig@amd.com, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Waiman Long <longman@redhat.com>, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 10:37, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>
> On Fri, May 02, 2025 at 01:35:59PM +1000, Dave Airlie wrote:
> > Hey all,
> >
> > This is my second attempt at adding the initial simple memcg/ttm
> > integration.
> >
> > This varies from the first attempt in two major ways:
> >
> > 1. Instead of using __GFP_ACCOUNT and direct calling kmem charges
> > for pool memory, and directly hitting the GPU statistic,
>
> Why was the first attempt abandoned? What was the issue with the above
> approach?

I had to export a bunch of memcg functionality to drivers (like stat
mod and kmem charge interfaces),
whereas the new version keeps all of that under a GPU API.

> > Waiman
> > suggested I just do what the network socket stuff did, which looks
> > simpler. So this adds two new memcg apis that wrap accounting.
> > The pages no longer get assigned the memcg, it's owned by the
> > larger BO object which makes more sense.
>
> The issue with this approach is that this new stat is only exposed in
> memcg. For networking, there are interfaces like /proc/net/sockstat and
> /proc/net/protocols which expose system wide network memory usage. I
> think we should expose this new "memory used by gpus" at the system
> level possibly through /proc/meminfo.

We do have some places where we could expose this info via debugfs,
but maybe /proc/meminfo
should grow this stat, so that it makes sense.

>
> >
> > 2. Christian suggested moving it up a layer to avoid the pool business,
> > this was a bit tricky, since I want the gfp flags, but I think it only
> > needs some of them and it should work. One other big difference is that
> > I aligned it with the dmem interaction, where it tries to get space in
> > the memcg before it has even allocated any pages,
>
> I don't understand the memcg reference in the above statement. Dmem is a
> separate cgroup controller orthogonal to memcg.
>

The TTM code that deals with dmem in the tree is at a level in the TTM code,
v1 of this added memcg interactions at a lower level, but Christian suggested,
that ttm could interact with both controllers in the same level, and
with the new
approach it seems right.

Dave.

