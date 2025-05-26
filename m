Return-Path: <cgroups+bounces-8348-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C37AC444A
	for <lists+cgroups@lfdr.de>; Mon, 26 May 2025 22:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279BA178003
	for <lists+cgroups@lfdr.de>; Mon, 26 May 2025 20:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F3323DEB6;
	Mon, 26 May 2025 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1is5L/4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BBE187FEC
	for <cgroups@vger.kernel.org>; Mon, 26 May 2025 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748290395; cv=none; b=lUYl+oTOQBY+YGiSdXmwrqTm8eUDRz2sbFoTE8u3KcDDqvARUXKrsgh4C+QncAQnT46pc1zgcJUDIe5aQ9Y6Nj/leUTDzA1c3PveKZdnwe6/UgB61K5LouWZvLh9AYVJpq+dUMgxlcYFeOT+RXNv1LdZKW7EN5OhzASCIWb7lEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748290395; c=relaxed/simple;
	bh=LPLcXmjEvN5zgaCrDZpj44vsIHK9O6nGZ4JenY/PDtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OER8hPGMDZx5zIMX2ZCtlzKKYFih+Bfl2IjlCr5JynzczmkLYQOX9/V1g38wUmcgpiK91uoqppbBUO5/S4FzLnpWE5tXZ0MgI+VQxMgDfAaZ70Dvic9DcaqXPqQGTcBTg0EhX9bL/zWQ8GtxmnEh7QWnbFE0qaX0aiFSRgr+bL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1is5L/4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad53cd163d9so426342666b.0
        for <cgroups@vger.kernel.org>; Mon, 26 May 2025 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748290392; x=1748895192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QVxUxZwHwg4uTuTfEDeJdtWwn5qD8fnwcw3GYkwYxQ=;
        b=T1is5L/4Qh+ORQhW3M5Hrr3MUeVrOJYUz6KDo4sKsaLE22KNkkGS+rdAwLMtYMFXX4
         lSM2XziEj5W4/fahAvRp+uZ6LnrlqA3E6tW+OpuYv7r5bFHzAtjOC7xWnUtqJGqxT2Rj
         uFmSeu7jVNVigLMu4tmemf5jNU/v+XXLHXn08YkB8BgOF1u3GQy4v/+do3JNM+tg9rYm
         les/wApo41z0peG9BumSKE08k+eiP0gUZx52/ebJKQAB8lC0SmLUehwybCw5GDxMOM/0
         0IUZVjcBcljMzevD933AL+MSNmRTNgGy8oVceHtHaEJhSVxufsFSww1A8ArtG0f86Agl
         LzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748290392; x=1748895192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QVxUxZwHwg4uTuTfEDeJdtWwn5qD8fnwcw3GYkwYxQ=;
        b=TgcsuqYhOG1qfnRwAuq66FPeJ3Sv3cHEmK+IT41X3R3DtrrTi3PaTbbznLflRTLfI8
         2TDkZkZXiOwSB3QLWZQlIQqY0sArxmzIXbJvbEs+cKMMsnHqSYnAQgo/tci/VrqjRr72
         2dV2PbXqRgk0gfTCZr9xEMoVRR+JVPQtktgVp4DUb9RlATNOKg5BD2NBquiJ9l1whE05
         LdfhyZjK5ZD1KSDSkzUY4ESuIqhBz7Cy+ZV44lHqWyif1XTs/6lgnpKcIdMKtqomNFio
         k/z/piGTqcXXvf4bcEVNcXGl9NAHzswecjJWNTht7veZHhy6XFsiA4llksg4iRlq1HKF
         GOtA==
X-Forwarded-Encrypted: i=1; AJvYcCWtczkDLfnFVoRiu+4R2Op8ZdLbR1J9BuDucswNJ0hLU1w3t7gHqTIgDCla+FVcIm3zsVfs38yv@vger.kernel.org
X-Gm-Message-State: AOJu0YxikODBM6H/vnh6ccU8+NrWotUdZ04AjptkTjmCL/lC8kr5rwSe
	egJxAf0vscAoL3ejaliKaiRL/e4VhDMrLZnEBGw6Mw4HyN0nEKRUPPM2oTZVFy4fB0BEAnHa9e8
	ZMoLm1B+9MZPp0rFBntH+/PToEqqUlv4=
X-Gm-Gg: ASbGncszGIjOC6Nmdvt6BBYOeMKbee4BvPnkWGw3YXDzrRuTRPCIOUmQDUGWFkQQ3ri
	QBIHeK/6G7TSfMdqrujgDbsqOPy7RtqgQDgCNy5wnU2aes7R2MCMkVBmCe0XbfDiThWDdzHXXGn
	1eeJKIEgF1ansR1AT8kjIYRGSVQsYWaQs=
X-Google-Smtp-Source: AGHT+IEsLYMgdQaUEnxvSZpAzIznC3EYpmZakrcUwGrnSFgON5g1rgCn/LiPfFkI7A+TmLHbAEO0IfoL89+CqOhsa+s=
X-Received: by 2002:a17:907:1b2a:b0:ad6:53a8:32ad with SMTP id
 a640c23a62f3a-ad85b338a28mr943470966b.57.1748290391718; Mon, 26 May 2025
 13:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515160842.GA720744@cmpxchg.org> <bba93237-9266-4e25-a543-e309eb7bb4ec@amd.com>
 <20250516145318.GB720744@cmpxchg.org> <5000d284-162c-4e63-9883-7e6957209b95@amd.com>
 <20250516164150.GD720744@cmpxchg.org> <eff07695-3de2-49b7-8cde-19a1a6cf3161@amd.com>
 <20250516200423.GE720744@cmpxchg.org> <CAPM=9txLaTjfjgC_h9PLR4H-LKpC9_Fet7=HYBpyeoCL6yAQJg@mail.gmail.com>
 <aC-ALtcs8RF1yZ1y@slm.duckdns.org> <de476962-194f-4c77-aabb-559a74caf5ac@amd.com>
 <aDCrLTNoWC8oSS7Z@slm.duckdns.org> <d21be860-9cb2-4c21-af30-2c724ab58756@amd.com>
In-Reply-To: <d21be860-9cb2-4c21-af30-2c724ab58756@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 27 May 2025 06:13:00 +1000
X-Gm-Features: AX0GCFvvHdd7Hcm15H2tyzhV0DazUrjPKTrGJfpLMdSyHMJpn-ef4wjs0ccd16c
Message-ID: <CAPM=9txhOq9NvTJ9sYpntQ5ajSXrCPAKwkPqBssycwAxqn05dg@mail.gmail.com>
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, dri-devel@lists.freedesktop.org, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 26 May 2025 at 18:19, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Hi Tejun,
>
> On 5/23/25 19:06, Tejun Heo wrote:
> > Hello, Christian.
> >
> > On Fri, May 23, 2025 at 09:58:58AM +0200, Christian K=C3=B6nig wrote:
> > ...
> >>> - There's a GPU workload which uses a sizable amount of system memory=
 for
> >>>   the pool being discussed in this thread. This GPU workload is very
> >>>   important, so we want to make sure that other activities in the sys=
tem
> >>>   don't bother it. We give it plenty of isolated CPUs and protect its=
 memory
> >>>   with high enough memory.low.
> >>
> >> That situation simply doesn't happen. See isolation is *not* a require=
ment
> >> for the pool.
> > ...
> >> See the submission model of GPUs is best effort. E.g. you don't guaran=
tee
> >> any performance isolation between processes whatsoever. If we would st=
art
> >> to do this we would need to start re-designing the HW.
> >
> > This is a radical claim. Let's table the rest of the discussion for now=
. I
> > don't know enough to tell whether this claim is true or not, but for th=
is to
> > be true, the following should be true:
> >
> >  Whether the GPU memory pool is reclaimed or not doesn't have noticeabl=
e
> >  performance implications on the GPU performance.
> >
> > Is this true?
>
> Yes, that is true. Today the GPUs need the memory for correctness, not fo=
r performance anymore.
>
> The performance improvements we have seen with this approach 15 or 20 yea=
rs ago are negligible by todays standards.
>
> It's just that Windows still offers the functionality today and when you =
bringup hardware on Linux you sometimes run into problems and find that the=
 engineers who designed the hardware/firmware relied on having this.
>
> > As for the scenario that I described above, I didn't just come up with =
it.
> > I'm only supporting from system side but that's based on what our ML fo=
lks
> > are doing right now. We have a bunch of lage machines with multiple GPU=
s
> > running ML workloads. The workloads can run for a long time spread acro=
ss
> > many machines and they synchronize frequently, so any performance drop =
on
> > one GPU lowers utiliization on all involved GPUs which can go up to thr=
ee
> > digits. For example, any scheduling disturbances on the submitting thre=
ad
> > propagates through the whole cluster and slows down all involved GPUs.
>
> For the HPC/ML use case this feature is completely irrelevant. ROCm, Cuda=
, OpenCL, OpenMP etc... don't even expose something like this in their high=
er level APIs as far as I know.

What do we consider higher level here btw? HIP and CUDA both expose
something like hipHostMallocWriteCombined, there is also
hipHostMallocCoherent which may or may not have an effect.

>
> Where this here matters is things like scanout on certain laptops, digita=
l rights management in cloud gaming, hacks for getting high end GPUs to wor=
k on ARM boards (e.g. rasberry pie etc...).
>
> > Also, because these machines are large on the CPU and memory sides too =
and
> > aren't doing whole lot other than managing the GPUs, people want to put=
 on a
> > significant amount of CPU work on them which can easily create at least
> > moderate memory pressure. Is the claim that the combined write memory p=
ool
> > doesn't have any meaningful impact on the GPU workload performance?
>
> When the memory pool is active on such systems I would strongly advise to=
 question why it is used in the first place.
>
> The main reason why we still need it for business today is cloud gaming. =
And for this particular use case you absolutely do want to share the pool b=
etween cgroups or otherwise the whole use case breaks.

I'm still not convinced on this being totally true, which means either
I'm misunderstanding how cloud gaming works or you are underestimating
how cgroups work,

My model for cloud gaming is, you have some sort of orchestrator
service running that spawns a bunch of games in their own cgroups and
those games would want to operate as independently as possible.

Now if the toplevel cgroup or if none the root cgroup exists and the
game cgroups are all underneath it, then I think this would operate
more optimally for each game, since

a) if a game uses uncached memory continuously it will have it's own
pool of uncached memory that doesn't get used by anyone else, thus
making that game more consistent.
b) if and when the game exits, the pool will be returned to the parent
cgroup to use, this memory should then be reused by other games the
are started subsequently.

The only thing I'm not sure is how the parent pool gets used once it's
built up for new children, need to spend more time reading list_lru
code.

The list_lru change might actually be useful for us without cgroups as
it might be able to hide some of our per-numa stuff.

Dave.

