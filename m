Return-Path: <cgroups+bounces-8645-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A491AEBF50
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 20:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B395B1734DD
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 18:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003BA1EA7CF;
	Fri, 27 Jun 2025 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfDGsv/i"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111BA4502A;
	Fri, 27 Jun 2025 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751050491; cv=none; b=uoW2zNFdROdvkPqvYAiz5TF7pw1jVMORqytQI4AwDHTZs4EQgNNhPvny7puIhG9763QY/4TavAAZ/VO2cLx0ZYy7EgNvB8+yfDUrl1JvdRPq+xrQwY8SV+Cjq7JDy5NfmNqifjq9EhszKaop2vdyX12KZmndLCmSB8Rxa5dYbg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751050491; c=relaxed/simple;
	bh=MkZf/rGrOyK/HyrljMZNxwNo/mJruqVicCPTs40b2Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hn3y+lr4kEmks5B6i6yk98w8cmhFIQP9FXCpCQl0vCL86Z9BRIqgnUAJpFTeKujQgY4+BnRu05M36zSn5Vnco1rma4M+IJnyhoEsIDLHieD8G1zaW+zkotvpIaCtw0NCjpFvTKKPYTJlgEN7+BMXscOkyXGLSgRJpUaLZaPVTBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfDGsv/i; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32addf54a01so26769801fa.3;
        Fri, 27 Jun 2025 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751050488; x=1751655288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkZf/rGrOyK/HyrljMZNxwNo/mJruqVicCPTs40b2Ts=;
        b=UfDGsv/i3I2rDvc55KBfN+qQhUbEWEklzdcMYLRdaDs8i5HPH23/QAabzh+lA4rIQu
         AKVLahMvBSyPzE/hwaLBP1/aWNWs/xAEkfpKqfxdtNf7C1vecoGQ13WAzuuG0GiIM3fu
         I26fQDMbOEDMqy1lnoNRH7q8P2CqUZS2ELyS/2weZq7kf0a4bc8fcvPRBSl2vDdg/pbr
         p2Sv/09ev/lyV0REzpGn5e+41b77Y1T11Ng46OErAY3pYaNLLBBpC4a72BgPdvK25cUo
         wg2gOxqsjdDmG9uUJ6twJ5zYSnk2K31cuDSSoPeWjIB00SnhRUeEGGOL4Ps2dHglxZAH
         oh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751050488; x=1751655288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkZf/rGrOyK/HyrljMZNxwNo/mJruqVicCPTs40b2Ts=;
        b=vXSXJLmicCyeexmfF5Z6cftGjx6IhFeAi/WlUZVws3ynuhbkVMu3DI5aQuZbgSGaU0
         AAST1WTOsAFKo5KzjRgQEFMZcbKd+Q1MZ+XgX3Ow2XtcX6R8lvPtkdAMbjXAIwsHdE1j
         lqAw1Mzlw3wGNfnePIv+ky54Oj9h4vfOoCXgo4qPlQcCTGbWfkwn69Ksop4w7hv7c1fQ
         qWH4QgMb4ORB5jl4mEDSTj9HeuCEJSso047D2f9HXaVIleqxj3w7PyDcY0B6tjpgJrgx
         HnxhmXFf9kC7VdJqh6A/s1nQ3UfQWH8tJ6srVm8TwtPKye7BE2be5aE9tCwKtNMYCN4F
         ze+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWi5Go/3UbaKj/0Om5V4KDelSwjS89Wz4MdTo1WeBfg6SmpdKhf28H3w4TbgCWcEH8fIYP3w2AX@vger.kernel.org, AJvYcCXq/hfBwX2QwhtkNYMPYGOfFj76v+aFdSk0keTeIJ/2pTtFETd+XhWDVUADLckAw3qp8kII9097OQJzkxiw@vger.kernel.org
X-Gm-Message-State: AOJu0YwBVkr/KZdDnt8xOtI2NlKC8d11bgeI/2vv8G7/bWKNn7znyk60
	BI4LJjd7g/MXLuh6+EGv7uUHS2DCrquA4FOvYYdh9CoiFOIfm6EpojBPDiojT1Nz7ZdhwLWOJ9y
	v8fodnnQwMXGw0fL/LLmCgIvvXyNQyJ0=
X-Gm-Gg: ASbGncsdWHhJcVswA31syS0/PPyG4l62p2Q3pBFYHOw4bIipycsYuqxEnUQhKwL7fHI
	F0AUjcqHI7C1h9IcEc08qilts2pQdfD2pjdl39udzNCb1fbjltoFCtzdskT4+MYwYQmtgXIXEps
	FF8F1/XtbhOTd/rzsqaaIHhT5tPs5trFT3j90+ZV9B1hjhR0NyaT7CVw==
X-Google-Smtp-Source: AGHT+IEEWJL2fzTT6sp/iFnXIOYPN7CNjGrDkAoMvUyzyseYP2O8kfk5drk0YGN9ll3GTdOreVTaWBEIEhSZBaQSC1w=
X-Received: by 2002:a05:651c:32a:b0:32b:5eb3:280 with SMTP id
 38308e7fff4ca-32cdc50e821mr13050961fa.29.1751050487729; Fri, 27 Jun 2025
 11:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <CAMgjq7BAfh-op06++LEgXf4UM47Pp1=ER+1WvdOn3-6YYQHYmw@mail.gmail.com>
 <F9BDE357-C7DA-4860-A167-201B01A274FC@linux.dev> <CAMgjq7D+GXce=nTzxPyR+t6YZSLWf-8eByo+0NpprQf61gXjPA@mail.gmail.com>
 <aAF2eUG26_xDYIDU@google.com> <CAMgjq7BNUMFzsFCOt--mvTqSmgdA65PWcn57G_6-gEj0ps-jCg@mail.gmail.com>
 <5f622eec-a039-4e82-9f37-3cad1692f268@huaweicloud.com>
In-Reply-To: <5f622eec-a039-4e82-9f37-3cad1692f268@huaweicloud.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 28 Jun 2025 02:54:10 +0800
X-Gm-Features: Ac12FXwDAS0QUytrD_AyHHgfvBJCFweeNF9Ytnf0eONhRRe-M_Ek30p9WmZQNCE
Message-ID: <CAMgjq7ASpGjJme4OwHu+=ys95W4jNZaJd3Yn9t2cL-qeCs4W-Q@mail.gmail.com>
Subject: Re: [PATCH RFC 00/28] Eliminate Dying Memory Cgroup
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org, mhocko@kernel.org, 
	shakeel.butt@linux.dev, akpm@linux-foundation.org, david@fromorbit.com, 
	zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 5:02=E2=80=AFPM Chen Ridong <chenridong@huaweicloud=
.com> wrote:
> On 2025/4/28 11:43, Kairui Song wrote:
> > On Fri, Apr 18, 2025 at 5:45=E2=80=AFAM Roman Gushchin <roman.gushchin@=
linux.dev> wrote:
> >>
> >> On Fri, Apr 18, 2025 at 02:22:12AM +0800, Kairui Song wrote:
> >>>
> >>> We currently have some workloads running with `nokmem` due to objcg
> >>> performance issues. I know there are efforts to improve them, but so
> >>> far it's still not painless to have. So I'm a bit worried about
> >>> this...
> >>
> >> Do you mind sharing more details here?
> >>
> >> Thanks!
> >
> > Hi,
> >
> > Sorry for the late response, I was busy with another series and other w=
orks.
> >
> > It's not hard to observe such slow down, for example a simple redis
> > test can expose it:
> >
> > Without nokmem:
> > redis-benchmark -h 127.0.0.1 -q -t set,get -n 80000 -c 1
> > SET: 16393.44 requests per second, p50=3D0.055 msec
> > GET: 16956.34 requests per second, p50=3D0.055 msec
> >
> > With nokmem:
> > redis-benchmark -h 127.0.0.1 -q -t set,get -n 80000 -c 1
> > SET: 17263.70 requests per second, p50=3D0.055 msec
> > GET: 17410.23 requests per second, p50=3D0.055 msec
> >
> > And I'm testing with latest kernel:
> > uname -a
> > Linux localhost 6.15.0-rc2+ #1594 SMP PREEMPT_DYNAMIC Sun Apr 27
> > 15:13:27 CST 2025 x86_64 GNU/Linux
> >
> > This is just an example. For redis, it can be a workaround by using
> > things like redis pipeline, but not all workloads can be adjusted
> > that flexibly.
> >
> > And the slowdown could be amplified in some cases.
>
> Hi Kairui,
>
> We've also encountered this issue in our Redis scenario. May I confirm
> whether your testing is based on cgroup v1 or v2?
>
> In our environment using cgroup v1, we've identified memcg_account_kmem
> as the critical performance bottleneck function - which, as you know, is
> specific to the v1 implementation.
>
> Best regards,
> Ridong

Hi Ridong

I can confirm I was testing using Cgroup V2, and I can still reproduce
it, it seems the performance gap is smaller with the latest upstream
though, but still easily observable.

My previous observation is that the performance drain behaves
differently with different CPUs, my current test machine is an Intel
8255C. I'll do a more detailed performance analysis of this when I
have time to work on this. Thanks for the tips!

