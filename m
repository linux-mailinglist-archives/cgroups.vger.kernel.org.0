Return-Path: <cgroups+bounces-3531-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA52926C2B
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2024 00:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDC01F23273
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 22:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEA11946AD;
	Wed,  3 Jul 2024 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bloHxh0k"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758AA194136
	for <cgroups@vger.kernel.org>; Wed,  3 Jul 2024 22:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047563; cv=none; b=pYRgOUdNp3S/NvEKGz7agyMKwNwlIgC/fmp9ulTXQRuFWyK5iM1ocD9fRrhsSAOIE+gPUmiUdDEc26sPMF/hdCvJCa8bUHaxkS91jvXqHwQGf1FQDjlbdU+5WyRbV9YX57Z3aX1Ey4XXzLqa+P+S4Yaf0jNmpRHpF3vi+xdKHyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047563; c=relaxed/simple;
	bh=e413piQ6ohngTa1KgwEeLX2cZKwf/FcbFovnN+krFcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIo2L7A9DlcqgeHy96DDXke0I0iZHdlsnpYE0A9qazTL1PccSDv6LBWVYlzXdaySDarTnnzuG+EjCBQqZ7/2etmvnmaoemi8/5Eh36p9mJOHYqeOPEXk4KyZacVG4v74pxjVHVZGY3JvWCjSfn24wYAcWGy43SdVYOi4MV7hN+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bloHxh0k; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so33104276.2
        for <cgroups@vger.kernel.org>; Wed, 03 Jul 2024 15:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720047560; x=1720652360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O641zrdw12C+c0OOg6YL1Y9zyKGp2U7Zfh7m/aotDYo=;
        b=bloHxh0kSHOXYxRmOtgZirX4lFFNS439ZsKeuxOejQ8FOSAugLL4snU335thR0hidO
         CvrqJ0VJM0Ur+uQeI2mY3P6BQp4xIR8/8fmDH2uiEjQOlaaB9RXuiDfXwdk6KPKovguN
         v+hVJ3ATwMBXsUZMg/N05F9Ou0keeqt7kAAxDleqtLRaACxI1pcJHkjwxeoYQRlpBV4A
         Xe18XZoKJGw1WrNMn+DmKai4Hg6r2C11tnrm29LdTI73yeN7WbcjtVRWGyi91rtltAp3
         YN2vV7INLvSm0hFNOkHzcMzvOxPuQi2VKyg/fEgW3jUARxR1uo6uAmDlfm3Iq+pHi/0d
         9EDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047560; x=1720652360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O641zrdw12C+c0OOg6YL1Y9zyKGp2U7Zfh7m/aotDYo=;
        b=qbFvDIs+OxVTW3AxR/U/eDmfP8RgRr+vPU9v01VzDNpALWmA2X8hMdjtNoCkAtcyl/
         xQZEAoYjo8ayddgxUOLhlcprT/35EhVWsQQT4qLaFQomvyOWJbqgv52rg/k9tOF+Q7fJ
         A2la4Lma9jnE/RieAf4lv0Pk6w5klhxbtG35To+ALROf5OXIFtYOHD8qn1Ex70KOdnAb
         VXTE6t7iOQY8fCF/4qwzqpSwG/VCAE+w8gZC7dSakQsRcJXW0MT191a7qp83reRBFygd
         CsZHTe+7wUibtt3rpobuHM3gcrr0mvMcxU90thDcdF3iVCwWkfzAj2E7tMzItAHiHgKG
         onjg==
X-Forwarded-Encrypted: i=1; AJvYcCU/4U443APg7t29ECub/lrKpYDxxsRG8uQsc9UlJG/j6FgVDze8huGFHxQBWxV4G9L7ca/zHjX8QyTJe7KxxwNB4VYZDVSk0Q==
X-Gm-Message-State: AOJu0YyAjJZAJ9fX+1lw0BtpsLQfMGSL7Ken0rEsqqpZSeKiHLrRqhBg
	aGaXokNL52FkZS0f4CFmpAeKHBXKGKgnS7ppgXWlX6k7oQapiGj7Vf6o7mWFqKCDPjRj0RryJEU
	Sfyehd67EN78Wu+BuUYaCRLKnw8SLIKXCQ3Vo
X-Google-Smtp-Source: AGHT+IEHdx+HiYOgSblpEZh8SDfLHA9XpYlLidnzOOkWvb/luHuRDdm/V7HIvv/c8Pww7EOqqB70nluyXjebX6FRws4=
X-Received: by 2002:a05:6902:1b8a:b0:dff:2f2c:d6ad with SMTP id
 3f1490d57ef6-e036ec4ba6emr15942437276.51.1720047559760; Wed, 03 Jul 2024
 15:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702084423.1717904-1-link@vivo.com> <ZoRUukQUNqGHn_x1@google.com>
 <27a62e44-9d85-4ef2-b833-e977af039758@vivo.com>
In-Reply-To: <27a62e44-9d85-4ef2-b833-e977af039758@vivo.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 3 Jul 2024 15:59:07 -0700
Message-ID: <CABdmKX3+3YQMOynNyKgE-+XbS8Et4o-_s9ieWGwvUnWUUtSYqg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Introduce PMC(PER-MEMCG-CACHE)
To: Huan Yang <link@vivo.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Chris Li <chrisl@kernel.org>, 
	Dan Schatzberg <schatzberg.dan@gmail.com>, Kairui Song <kasong@tencent.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:23=E2=80=AFPM Huan Yang <link@vivo.com> wrote:
>
>
> =E5=9C=A8 2024/7/3 3:27, Roman Gushchin =E5=86=99=E9=81=93:
> > On Tue, Jul 02, 2024 at 04:44:03PM +0800, Huan Yang wrote:
> >> This patchset like to talk abount a idea about PMC(PER-MEMCG-CACHE).
> >>
> >> Background
> >> =3D=3D=3D
> >>
> >> Modern computer systems always have performance gaps between hardware,
> >> such as the performance differences between CPU, memory, and disk.
> >> Due to the principle of locality of reference in data access:
> >>
> >>    Programs often access data that has been accessed before
> >>    Programs access the next set of data after accessing a particular d=
ata
> >> As a result:
> >>    1. CPU cache is used to speed up the access of already accessed dat=
a
> >>       in memory
> >>    2. Disk prefetching techniques are used to prepare the next set of =
data
> >>       to be accessed in advance (to avoid direct disk access)
> >> The basic utilization of locality greatly enhances computer performanc=
e.
> >>
> >> PMC (per-MEMCG-cache) is similar, utilizing a principle of locality to=
 enhance
> >> program performance.
> >>
> >> In modern computers, especially in smartphones, services are provided =
to
> >> users on a per-application basis (such as Camera, Chat, etc.),
> >> where an application is composed of multiple processes working togethe=
r to
> >> provide services.
> >>
> >> The basic unit for managing resources in a computer is the process,
> >> which in turn uses threads to share memory and accomplish tasks.
> >> Memory is shared among threads within a process.
> >>
> >> However, modern computers have the following issues, with a locality d=
eficiency:
> >>
> >>    1. Different forms of memory exist and are not interconnected (anon=
ymous
> >>       pages, file pages, special memory such as DMA-BUF, various memor=
y alloc in
> >>       kernel mode, etc.)
> >>    2. Memory isolation exists between processes, and apart from specif=
ic
> >>       shared memory, they do not communicate with each other.
> >>    3. During the transition of functionality within an application, a =
process
> >>       usually releases memory, while another process requests memory, =
and in
> >>       this process, memory has to be obtained from the lowest level th=
rough
> >>       competition.
> >>
> >> For example abount camera application:
> >>
> >> Camera applications typically provide photo capture services as well a=
s photo
> >> preview services.
> >> The photo capture process usually utilizes DMA-BUF to facilitate the s=
haring
> >> of image data between the CPU and DMA devices.
> >> When it comes to image preview, multiple algorithm processes are typic=
ally
> >> involved in processing the image data, which may also involve heap mem=
ory
> >> and other resources.
> >>
> >> During the switch between photo capture and preview, the application t=
ypically
> >> needs to release DMA-BUF memory and then the algorithms need to alloca=
te
> >> heap memory. The flow of system memory during this process is managed =
by
> >> the PCP-BUDDY system.
> >>
> >> However, the PCP and BUDDY systems are shared, and subsequently reques=
ted
> >> memory may not be available due to previously allocated memory being u=
sed
> >> (such as for file reading), requiring a competitive (memory reclamatio=
n)
> >> process to obtain it.
> >>
> >> So, if it is possible to allow the released memory to be allocated wit=
h
> >> high priority within the application, then this can meet the locality
> >> requirement, improve performance, and avoid unnecessary memory reclaim=
.
> >>
> >> PMC solutions are similar to PCP, as they both establish cache pools a=
ccording
> >> to certain rules.
> >>
> >> Why base on MEMCG?
> >> =3D=3D=3D
> >>
> >> The MEMCG container can allocate selected processes to a MEMCG based o=
n certain
> >> grouping strategies (typical examples include grouping by app or UID).
> >> Processes within the same MEMCG can then be used for statistics, upper=
 limit
> >> restrictions, and reclamation control.
> >>
> >> All processes within a MEMCG are considered as a single memory unit,
> >> sharing memory among themselves. As a result, when one process release=
s
> >> memory, another process within the same group can obtain it with the
> >> highest priority, fully utilizing the locality of memory allocation
> >> characteristics within the MEMCG (such as APP grouping).
> >>
> >> In addition, MEMCG provides feature interfaces that can be dynamically=
 toggled
> >> and are fully controllable by the policy.This provides greater flexibi=
lity
> >> and does not impact performance when not enabled (controlled through s=
tatic key).
> >>
> >>
> >> Abount PMC implement
> >> =3D=3D=3D
> >> Here, a cache switch is provided for each MEMCG(not on root).
> >> When the user enables the cache, processes within the MEMCG will share=
 memory
> >> through this cache.
> >>
> >> The cache pool is positioned before the PCP. All order0 page released =
by
> >> processes in MEMCG will be released to the cache pool first, and when =
memory
> >> is requested, it will also be prioritized to be obtained from the cach=
e pool.
> >>
> >> `memory.cache` is the sole entry point for controlling PMC, here are s=
ome
> >> nested keys to control PMC:
> >>    1. "enable=3D[y|n]" to enable or disable targeted MEMCG's cache
> >>    2. "keys=3Dnid=3D%d,watermark=3D%u,reaper_time=3D%u,limit=3D%u" to =
control already
> >>    enabled PMC's behavior.
> >>      a) `nid` to targeted a node to change it's key. or else all node.
> >>      b) The `watermark` is used to control cache behavior, caching onl=
y when
> >>         zone free pages above the zone's high water mark + this waterm=
ark is
> >>         exceeded during memory release. (unit byte, default 50MB,
> >>         min 10MB per-node-all-zone)
> >>      c) `reaper_time` to control reaper gap, if meet, reaper all cache=
 in this
> >>          MEMCG(unit us, default 5s, 0 is disable.)
> >>      d) `limit` is to limit the maximum memory used by the cache pool(=
unit bytes,
> >>         default 100MB, max 500MB per-node-all-zone)
> >>
> >> Performance
> >> =3D=3D=3D
> >> PMC is based on MEMCG and requires performance measurement through the
> >> sharing of complex workloads between application processes.
> >> Therefore, at the moment, we unable to provide a better testing soluti=
on
> >> for this patchset.
> >>
> >> Here is the internal testing situation we provide, using the camera
> >> application as an example. (1-NODE-1-ZONE-8GRAM)
> >>
> >> Test Case: Capture in rear portrait HDR mode
> >> 1. Test mode: rear portrait HDR mode. This scene needs more than 800M =
ram
> >>     which memory types including dmabuf(470M), PSS(150M) and APU(200M)
> >> 2. Test steps: take a photo, then click thumbnail to view the full ima=
ge
> >>
> >> The overall performance benefit from click shutter button to showing w=
hole
> >> image improves 500ms, and the total slowpath cost of all camera thread=
s reduced
> >> from 958ms to 495ms.
> >> Especially for the shot2shot in this mode, the preview dealy of each f=
rame have
> >> a significant improve.
> > Hello Huan,
> >
> > thank you for sharing your work.
> thanks
> >
> > Some high-level thoughts:
> > 1) Naming is hard, but it took me quite a while to realize that you're =
talking
> Haha, sorry for my pool english
> > about free memory. Cache is obviously an overloaded term, but per-memcg=
-cache
> > can mean absolutely anything (pagecache? cpu cache? ...), so maybe it's=
 not
>
> Currently, my idea is that all memory released by processes under memcg
> will go into the `cache`,
>
> and the original attributes will be ignored, and can be freely requested
> by processes under memcg.
>
> (so, dma-buf\page cache\heap\driver, so on). Maybe named PMP more
> friendly? :)
>
> > the best choice.
> > 2) Overall an idea to have a per-memcg free memory pool makes sense to =
me,
> > especially if we talk 2MB or 1GB pages (or order > 0 in general).
> I like it too :)
> > 3) You absolutely have to integrate the reclaim mechanism with a generi=
c
> > memory reclaim mechanism, which is driven by the memory pressure.
> Yes, I all think about it.
> > 4) You claim a ~50% performance win in your workload, which is a lot. I=
t's not
> > clear to me where it's coming from. It's hard to believe the page alloc=
ation/release
> > paths are taking 50% of the cpu time. Please, clarify.
>
> Let me describe it more specifically. In our test scenario, we have 8GB
> of RAM, and our camera application
>
> has a complex set of algorithms, with a peak memory requirement of up to
> 3GB.
>
> Therefore, in a multi-application background scenario, starting the
> camera and taking photos will create a
>
> very high memory pressure. In this scenario, any released memory will be
> quickly used by other processes (such as file pages).
>
> So, during the process of switching from camera capture to preview,
> DMA-BUF memory will be released,
>
> while the memory used for the preview algorithm will be simultaneously
> requested.
>
> We need to take a lot of slow path routes to obtain enough memory for
> the preview algorithm, and it seems that the
>
> just released DMA-BUF memory does not provide much help.
>
Hi Huan,

I find this part surprising. Assuming the dmabuf memory doesn't first
go into a page pool (used for some buffers, not all) and actually does
get freed synchronously with fput, this would mean it gets sucked up
by other supposedly background processes before it can be allocated by
the preview process. I thought the preview process was the one most
desperate for memory? You mention file pages, but where is this
newly-freed memory actually going if not to the preview process? My
initial reaction was the same as Roman's that the PMC should be hooked
up to reclaim instead of depending on the reaper. But I think this
might suggest that wouldn't work because the system is under such high
memory pressure that it'd be likely reclaim would have emptied the
PMCs before the preview process could use it.

One more thing I find odd is that for this to work a significant
portion of your dmabuf pages would have to be order 0, but we're
talking about a ~500M buffer. Does whatever exports this buffer not
try to use higher order pages like here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/dma-buf/heaps/system_heap.c?h=3Dv6.9#n54

Thanks!
-T.J.

> But using PMC (let's call it that for now), we are able to quickly meet
> the memory needs of the subsequent preview process
>
> with the just released DMA-BUF memory, without having to go through the
> slow path, resulting in a significant performance improvement.
>
> (of course, break migrate type may not good.)
>
> >
> > There are a lot of other questions, and you highlighted some of them be=
low
> > (and these are indeed right questions to ask), but let's start with som=
ething.
> >
> > Thanks
> Thanks
>

