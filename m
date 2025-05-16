Return-Path: <cgroups+bounces-8248-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BACABA4A7
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 22:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED114A8361
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 20:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E3127FD58;
	Fri, 16 May 2025 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTHXdt1c"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F031C84A1
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747427117; cv=none; b=nZRJkEBFYHS6HtEcxWdzGkHc0xct5ySVdrQqxNlWQ3Lu0F7mfkQ1MGN7CNhENgLZv9sQ6DvwvlSsPcfZryEUZiT/Zy2ZikLh3h66QQ9n37zV6pHNDnZUa62S6Q2VDIFYwpaS2k6/G2AiBhz7181RV/xvlfInfyn5BdZvt2N8M8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747427117; c=relaxed/simple;
	bh=SJtI08ZdLCcw6bkpJ+rEQSFFcud7levmwZFe8IxZZO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFt/VxJCz1LUKOf8guaS0v6BUuOgtZcNA+zyEdM+kYomf7lhTRzymhNJsO0So6t5O92qbh1WOVTY52eMzXA93b7Re0euqxAiYqfyWW1OkLuzFLtjbWLSDzfWNKbliJHMb0mT/IuJukFXsfZb49QNJyJBQSgB47YH6DxpqXpRQDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTHXdt1c; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5fca2805ca4so3826877a12.1
        for <cgroups@vger.kernel.org>; Fri, 16 May 2025 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747427114; x=1748031914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJtI08ZdLCcw6bkpJ+rEQSFFcud7levmwZFe8IxZZO0=;
        b=jTHXdt1cXosWlTtAPnf+wXXSXXhy3qkuH87KXcSm6BiOCUtU7l4CS7tFRO7AiIoqAJ
         DwHFNi4T6XdinvdYEATD6We2Q4PYReJQaW7M4XaUZfbAxEdLMm9Ftlp8X4JOy8IYWz3O
         oe77FaSfsb3dH7W+kMTp0gxqyFV+zV0sUBLsq66m3xZtFLzq944XlMdD3m6TzXo3b/F2
         5dsLfwzuf2gRM4u07UmiSit/CW72kx3XuaiRdiuazbuIWwvkDQzwinuy4NDNR6sZMsgE
         IoRyvZ1azLIAILd3Bt4TQdgrNZ4J4A+/dheBto2ZdOpGqKTmhkGnh4O++HlkyV0ACoNf
         A1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747427114; x=1748031914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJtI08ZdLCcw6bkpJ+rEQSFFcud7levmwZFe8IxZZO0=;
        b=nYAsN4DE1bMc7d95QzF/BvzBlIRJ2ueCYZNa/OHQ+ntKBVA2rmj87TfY5nRBIP/wzo
         HAJDsIkSRG4Gv6umvVH9ySZ2+Q5F8JlF7W7LHfvFZoGJPiGuBkSbG/PrExcqJ+Skg2pg
         gN8tbSvzlqgo9wKnmHLHYO3PoZhplsEzTuSToAQyq+lXM81rc68SvZ1dQt20D55a0psU
         WOfpUXrK4Mb22TzsuXaG9uCYA56aLHOJiz7vpRKOgpZPA9tA3AyStsLIsWEUTnmo/7vK
         31JZQGLu0KkKVWWaw8gm4l3XEMFEcpOWyFqHhsdvEj4HIB2nuBbsoGwBQLeokrnK3VaC
         An0w==
X-Forwarded-Encrypted: i=1; AJvYcCXfm6Rk9rhBCGtNhW/E4gGMQRPluOOzXxICvwJME6IaFYdh3Zn+odR5F8Yiz2yOVPq7FALrql9G@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5SWm5QjM1SmDTq7MKNv9dsVVK6GnNbPq4asdfaiSjb/KuSRSb
	hfs+vsg0/xmAIKrpvoneqMItwUVtmFUtn45In1fX/ajYi+oI5kkNvKtzMEQYAsHYfJsrUpzoEWG
	Gf21TWbr/xzROiLA3ZEBXuVGPWtblPYE=
X-Gm-Gg: ASbGncutfdjbl6OxJxrimA+CJKjkKJBEsyAWcg+i/znfv8u4F856xyx7FNi7EyD9vw+
	UfSo6hCsR1kchvSR0cqgQ5Ug+5gunVYktfMAzCBTgR69Ix8Ovgf1UQ9dBpaxDfSnwHw4VzczPCA
	jj1qc/3Ffxx3kjdNXvwCux5c1xVke5QaY=
X-Google-Smtp-Source: AGHT+IF6IesSsloSzfaxg/M64Zjm1vE5MlDFW1s1cX1z2megWPE7Es4e+n2QFcDLhy0sKjm5auuB7s7yMTSxPsfEPL8=
X-Received: by 2002:a17:907:7d89:b0:ad2:5408:bf1a with SMTP id
 a640c23a62f3a-ad52d64216fmr467700466b.61.1747427113583; Fri, 16 May 2025
 13:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com>
 <20250513075446.GA623911@cmpxchg.org> <CAPM=9txLcFNt-5hfHtmW5C=zhaC4pGukQJ=aOi1zq_bTCHq4zg@mail.gmail.com>
 <b0953201-8d04-49f3-a116-8ae1936c581c@amd.com> <20250515160842.GA720744@cmpxchg.org>
 <bba93237-9266-4e25-a543-e309eb7bb4ec@amd.com> <20250516145318.GB720744@cmpxchg.org>
 <5000d284-162c-4e63-9883-7e6957209b95@amd.com> <20250516164150.GD720744@cmpxchg.org>
 <eff07695-3de2-49b7-8cde-19a1a6cf3161@amd.com> <20250516200423.GE720744@cmpxchg.org>
In-Reply-To: <20250516200423.GE720744@cmpxchg.org>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 17 May 2025 06:25:02 +1000
X-Gm-Features: AX0GCFtasG3sWnbvC4qlI42fwzXP33Z7Y2iUUh9fyHDZOgHKzoSPu0dwVStFEkg
Message-ID: <CAPM=9txLaTjfjgC_h9PLR4H-LKpC9_Fet7=HYBpyeoCL6yAQJg@mail.gmail.com>
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org, tj@kernel.org, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 17 May 2025 at 06:04, Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, May 16, 2025 at 07:42:08PM +0200, Christian K=C3=B6nig wrote:
> > On 5/16/25 18:41, Johannes Weiner wrote:
> > >>> Listen, none of this is even remotely new. This isn't the first cac=
he
> > >>> we're tracking, and it's not the first consumer that can outlive th=
e
> > >>> controlling cgroup.
> > >>
> > >> Yes, I knew about all of that and I find that extremely questionable
> > >> on existing handling as well.
> > >
> > > This code handles billions of containers every day, but we'll be sure
> > > to consult you on the next redesign.
> >
> > Well yes, please do so. I'm working on Linux for around 30 years now an=
d halve of that on device memory management.
> >
> > And the subsystems I maintain is used by literally billion Android devi=
ces and HPC datacenters
> >
> > One of the reasons we don't have a good integration between device memo=
ry and cgroups is because specific requirements have been ignored while des=
igning cgroups.
> >
> > That cgroups works for a lot of use cases doesn't mean that it does for=
 all of them.
> >
> > >> Memory pools which are only used to improve allocation performance
> > >> are something the kernel handles transparently and are completely
> > >> outside of any cgroup tracking whatsoever.
> > >
> > > You're describing a cache. It doesn't matter whether it's caching CPU
> > > work, IO work or network packets.
> >
> > A cache description doesn't really fit this pool here.
> >
> > The memory properties are similar to what GFP_DMA or GFP_DMA32
> > provide.
> >
> > The reasons we haven't moved this into the core memory management is
> > because it is completely x86 specific and only used by a rather
> > specific group of devices.
>
> I fully understand that. It's about memory properties.
>
> What I think you're also saying is that the best solution would be
> that you could ask the core MM for pages with a specific property, and
> it would hand you pages that were previously freed with those same
> properties. Or, if none such pages are on the freelists, it would grab
> free pages with different properties and convert them on the fly.
>
> For all intents and purposes, this free memory would then be trivially
> fungible between drm use, non-drm use, and different cgroups - except
> for a few CPU cycles when converting but that's *probably* negligible?
> And now you could get rid of the "hack" in drm and didn't have to hang
> on to special-property pages and implement a shrinker at all.
>
> So far so good.
>
> But that just isn't the implementation of today. And the devil is very
> much in the details with this:
>
> Your memory attribute conversions are currently tied to a *shrinker*.
>
> This means the conversion doesn't trivially happen in the allocator,
> it happens from *reclaim context*.
>
> Now *your* shrinker is fairly cheap to run, so I do understand when
> you're saying in exasperation: We give this memory back if somebody
> needs it for other purposes. What *is* the big deal?
>
> The *reclaim context* is the big deal. The problem is *all the other
> shrinkers that run at this time as well*. Because you held onto those
> pages long enough that they contributed to a bonafide, general memory
> shortage situation. And *that* has consequences for other cgroups.

I think this is where we have 2 options:
(a) moving this stuff into core mm and out of shrinker context
(b) fix our shrinker to be cgroup aware and solve that first.

The main question I have for Christian, is can you give me a list of
use cases that this will seriously negatively effect if we proceed
with (b).

From my naive desktop use case and HPC use case scenarios, I'm not
seeing a massive hit, now maybe I see more consistency from an
application overheads inside a cgroup.

Desktop use-case:
The user session and everything inside the user-session, compositor,
apps are all in a single cgroup, any pools memory usage will be
reusable between all the users active session, if there are multiple
users, they won't have the benefit of pages from others but their own
pool will be available.

HPC use-case:
One cgroup per application running in some sort of batch system. There
will be a downside at app launch if there has already been a bunch of
other applications launched on the machine the have filled the pool,
but by default in the cold start case the app won't get any worse
behaviour than it's current worst case, it will get consistent
behaviour of initial allocations being worst case in a new cgroup vs
now where they might benefit from previously running cgroups having
allocated pooled memory, but I'm not sure the benefit outweighs the
upside here since they reallly want containers contained.

Android? I've no idea.

Like what can we live with here, vs what needs to be a Kconfig option
vs what needs to be a kernel command line option,

I'm also happy to look at (a) but I think for (a) it's not just
uncached pool that is the problem, the dma pools will be harder to
deal with.

Dave.

