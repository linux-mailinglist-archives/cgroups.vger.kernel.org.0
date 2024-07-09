Return-Path: <cgroups+bounces-3575-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A1192ACFB
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 02:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935652810FD
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 00:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F5382;
	Tue,  9 Jul 2024 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJ4i4R+C"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29035620
	for <cgroups@vger.kernel.org>; Tue,  9 Jul 2024 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720483932; cv=none; b=N/mzDER1AH36vxKvImjzt9F3gmkun8z+EiAch/PhLBUzXLt5j8CqRoUi1O8RvzDeshSTYCnu4SQ65j6vk1I6xYs7YTDQqOupwQI/ABy/C3s4VL5OMg5xXGsVu8mRJSVam4onkvJSWdNnBq3agJNWqUD0RSZTNhVfWUQawgtu3CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720483932; c=relaxed/simple;
	bh=LebjbOEOY9GIJTmim423yQ+GPPbwu1cHfdBjuHcl0jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R81e/QT02Z/KoNRhuWwn4++5qwlG6b4x7/1ZuoUradgYy6ibFAK6uvXlmE8PQiu+YyLN3h8n7j+9RbAfveSOhtbKlexViOxvCKu/ZZ0MwGVXKZP7MOvM1AHmDaGNv7WQUWhP4dpFBc5OQ7LZmPBKxbRglceHTy+XaVQAH+aFwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJ4i4R+C; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e026a2238d8so4924744276.0
        for <cgroups@vger.kernel.org>; Mon, 08 Jul 2024 17:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720483929; x=1721088729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVbaaS6scR3r/YQCj7vaVWFVSsqXZHGDW0NIfp1BYWA=;
        b=OJ4i4R+C24IXIynqkUdsX7rAjaoguYMK4Xzlkdl17PBIpU2dFWwUx7QC2adSbuuUOF
         s2nLkK35HNRPiTvyXg5A197DByTq9FW/upYJ3StyO3ftsbXhIzpNw7vtQYYOB0v2nNnW
         M+UFuG+ZHpGzp4jyZTnZdCRdiAokzZTTuc+JX/fYmdW6F4jrIrt7AsAdV5n0935vYsEr
         2/fCs+Dw8OMZ880suKohtVYK4wOxx6nu0iGF0uOX2qoUmrAEwVmGgcEeB8mM0L0jpah9
         zt1folACTT7aVS9TQNsgTfdPwFVyjqtqfR4StZgSrUEeC4HRRMkSYQUMintMzknbUu6I
         tDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720483929; x=1721088729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVbaaS6scR3r/YQCj7vaVWFVSsqXZHGDW0NIfp1BYWA=;
        b=ID9rBfXHMWOftDRTW/KsCwddgTaKqVOUD/Jlrv9it/LNZOkhJ6kHk/oweS5dpxtTrs
         ngwZ2kjbPa3esKTj8QEaQGO3rmTLb9wHWfYDVklBFa9Ccmmg7EfZ9mW+r89JW5IUkO9i
         ujnEnv9n79Fciii7r3Kr4MhKBlyeCeVjwF1uAFGZsPqrtXuzUNpVW9u4yhuGGpSlFvxf
         KA4L9ZHg6Q1XsDhTNX6HP7EMT4BVH2j3ygshtoaKFS9Ss8o5yLwvLcPCPt8iPL977AiX
         BcKwz2yqlofoIrWytC7KkEQe3NYTr5D2t2r8AgcbQ1HP85h4zyDRjjTtdskziogemIm+
         uukA==
X-Forwarded-Encrypted: i=1; AJvYcCXCv3L05GLnpujkMIabbqC1YVBWHWMl/EGFTohI7VPBiGV9J8Cb2Hr7yzB5waKYQi8PslA0ce3vaI/qwWIFx8v6c/GkoVsAQA==
X-Gm-Message-State: AOJu0YwMcFtM9W2SjNACYOz7ZU8nCRYEdFGeaLYkwTBGGW6yPMiE/KNn
	vDJt+x09bmZs4t7CG6sZDQK+zuMOlIjRDhV6Cfnl3o7JbL/dkwcVby2bYwyK5sjBprGelNbMZOn
	e/uOv8d8dzyCS2aqOa8fWVtcsIW5UzhrwAd8+
X-Google-Smtp-Source: AGHT+IEvOP5YgTU9NpaKmjdo45GdXyB6IULqBv9Iv4UMXSFc+i2Xm5Ackgx2bhCetWSIWrnTOedKP/EoCHDgLCSgLhY=
X-Received: by 2002:a25:c441:0:b0:e03:3d38:fb26 with SMTP id
 3f1490d57ef6-e041b078a64mr1551144276.28.1720483928711; Mon, 08 Jul 2024
 17:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702084423.1717904-1-link@vivo.com> <ZoRUukQUNqGHn_x1@google.com>
 <27a62e44-9d85-4ef2-b833-e977af039758@vivo.com> <CABdmKX3+3YQMOynNyKgE-+XbS8Et4o-_s9ieWGwvUnWUUtSYqg@mail.gmail.com>
 <ff1e3407-d8ee-4696-bd8d-cab4e162f42c@vivo.com>
In-Reply-To: <ff1e3407-d8ee-4696-bd8d-cab4e162f42c@vivo.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 8 Jul 2024 17:11:56 -0700
Message-ID: <CABdmKX3n+wWQ-hCBsx2dLH2DWrZg9sPw0f5nLcuQ1barEoOW=w@mail.gmail.com>
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

On Wed, Jul 3, 2024 at 7:29=E2=80=AFPM Huan Yang <link@vivo.com> wrote:
>
>
> =E5=9C=A8 2024/7/4 6:59, T.J. Mercier =E5=86=99=E9=81=93:
> > On Tue, Jul 2, 2024 at 7:23=E2=80=AFPM Huan Yang <link@vivo.com> wrote:
> >>
> >> =E5=9C=A8 2024/7/3 3:27, Roman Gushchin =E5=86=99=E9=81=93:
> >>> On Tue, Jul 02, 2024 at 04:44:03PM +0800, Huan Yang wrote:
> >>>> This patchset like to talk abount a idea about PMC(PER-MEMCG-CACHE).
> >>>>
> >>>> Background
> >>>> =3D=3D=3D
> >>>>
> >>>> Modern computer systems always have performance gaps between hardwar=
e,
> >>>> such as the performance differences between CPU, memory, and disk.
> >>>> Due to the principle of locality of reference in data access:
> >>>>
> >>>>     Programs often access data that has been accessed before
> >>>>     Programs access the next set of data after accessing a particula=
r data
> >>>> As a result:
> >>>>     1. CPU cache is used to speed up the access of already accessed =
data
> >>>>        in memory
> >>>>     2. Disk prefetching techniques are used to prepare the next set =
of data
> >>>>        to be accessed in advance (to avoid direct disk access)
> >>>> The basic utilization of locality greatly enhances computer performa=
nce.
> >>>>
> >>>> PMC (per-MEMCG-cache) is similar, utilizing a principle of locality =
to enhance
> >>>> program performance.
> >>>>
> >>>> In modern computers, especially in smartphones, services are provide=
d to
> >>>> users on a per-application basis (such as Camera, Chat, etc.),
> >>>> where an application is composed of multiple processes working toget=
her to
> >>>> provide services.
> >>>>
> >>>> The basic unit for managing resources in a computer is the process,
> >>>> which in turn uses threads to share memory and accomplish tasks.
> >>>> Memory is shared among threads within a process.
> >>>>
> >>>> However, modern computers have the following issues, with a locality=
 deficiency:
> >>>>
> >>>>     1. Different forms of memory exist and are not interconnected (a=
nonymous
> >>>>        pages, file pages, special memory such as DMA-BUF, various me=
mory alloc in
> >>>>        kernel mode, etc.)
> >>>>     2. Memory isolation exists between processes, and apart from spe=
cific
> >>>>        shared memory, they do not communicate with each other.
> >>>>     3. During the transition of functionality within an application,=
 a process
> >>>>        usually releases memory, while another process requests memor=
y, and in
> >>>>        this process, memory has to be obtained from the lowest level=
 through
> >>>>        competition.
> >>>>
> >>>> For example abount camera application:
> >>>>
> >>>> Camera applications typically provide photo capture services as well=
 as photo
> >>>> preview services.
> >>>> The photo capture process usually utilizes DMA-BUF to facilitate the=
 sharing
> >>>> of image data between the CPU and DMA devices.
> >>>> When it comes to image preview, multiple algorithm processes are typ=
ically
> >>>> involved in processing the image data, which may also involve heap m=
emory
> >>>> and other resources.
> >>>>
> >>>> During the switch between photo capture and preview, the application=
 typically
> >>>> needs to release DMA-BUF memory and then the algorithms need to allo=
cate
> >>>> heap memory. The flow of system memory during this process is manage=
d by
> >>>> the PCP-BUDDY system.
> >>>>
> >>>> However, the PCP and BUDDY systems are shared, and subsequently requ=
ested
> >>>> memory may not be available due to previously allocated memory being=
 used
> >>>> (such as for file reading), requiring a competitive (memory reclamat=
ion)
> >>>> process to obtain it.
> >>>>
> >>>> So, if it is possible to allow the released memory to be allocated w=
ith
> >>>> high priority within the application, then this can meet the localit=
y
> >>>> requirement, improve performance, and avoid unnecessary memory recla=
im.
> >>>>
> >>>> PMC solutions are similar to PCP, as they both establish cache pools=
 according
> >>>> to certain rules.
> >>>>
> >>>> Why base on MEMCG?
> >>>> =3D=3D=3D
> >>>>
> >>>> The MEMCG container can allocate selected processes to a MEMCG based=
 on certain
> >>>> grouping strategies (typical examples include grouping by app or UID=
).
> >>>> Processes within the same MEMCG can then be used for statistics, upp=
er limit
> >>>> restrictions, and reclamation control.
> >>>>
> >>>> All processes within a MEMCG are considered as a single memory unit,
> >>>> sharing memory among themselves. As a result, when one process relea=
ses
> >>>> memory, another process within the same group can obtain it with the
> >>>> highest priority, fully utilizing the locality of memory allocation
> >>>> characteristics within the MEMCG (such as APP grouping).
> >>>>
> >>>> In addition, MEMCG provides feature interfaces that can be dynamical=
ly toggled
> >>>> and are fully controllable by the policy.This provides greater flexi=
bility
> >>>> and does not impact performance when not enabled (controlled through=
 static key).
> >>>>
> >>>>
> >>>> Abount PMC implement
> >>>> =3D=3D=3D
> >>>> Here, a cache switch is provided for each MEMCG(not on root).
> >>>> When the user enables the cache, processes within the MEMCG will sha=
re memory
> >>>> through this cache.
> >>>>
> >>>> The cache pool is positioned before the PCP. All order0 page release=
d by
> >>>> processes in MEMCG will be released to the cache pool first, and whe=
n memory
> >>>> is requested, it will also be prioritized to be obtained from the ca=
che pool.
> >>>>
> >>>> `memory.cache` is the sole entry point for controlling PMC, here are=
 some
> >>>> nested keys to control PMC:
> >>>>     1. "enable=3D[y|n]" to enable or disable targeted MEMCG's cache
> >>>>     2. "keys=3Dnid=3D%d,watermark=3D%u,reaper_time=3D%u,limit=3D%u" =
to control already
> >>>>     enabled PMC's behavior.
> >>>>       a) `nid` to targeted a node to change it's key. or else all no=
de.
> >>>>       b) The `watermark` is used to control cache behavior, caching =
only when
> >>>>          zone free pages above the zone's high water mark + this wat=
ermark is
> >>>>          exceeded during memory release. (unit byte, default 50MB,
> >>>>          min 10MB per-node-all-zone)
> >>>>       c) `reaper_time` to control reaper gap, if meet, reaper all ca=
che in this
> >>>>           MEMCG(unit us, default 5s, 0 is disable.)
> >>>>       d) `limit` is to limit the maximum memory used by the cache po=
ol(unit bytes,
> >>>>          default 100MB, max 500MB per-node-all-zone)
> >>>>
> >>>> Performance
> >>>> =3D=3D=3D
> >>>> PMC is based on MEMCG and requires performance measurement through t=
he
> >>>> sharing of complex workloads between application processes.
> >>>> Therefore, at the moment, we unable to provide a better testing solu=
tion
> >>>> for this patchset.
> >>>>
> >>>> Here is the internal testing situation we provide, using the camera
> >>>> application as an example. (1-NODE-1-ZONE-8GRAM)
> >>>>
> >>>> Test Case: Capture in rear portrait HDR mode
> >>>> 1. Test mode: rear portrait HDR mode. This scene needs more than 800=
M ram
> >>>>      which memory types including dmabuf(470M), PSS(150M) and APU(20=
0M)
> >>>> 2. Test steps: take a photo, then click thumbnail to view the full i=
mage
> >>>>
> >>>> The overall performance benefit from click shutter button to showing=
 whole
> >>>> image improves 500ms, and the total slowpath cost of all camera thre=
ads reduced
> >>>> from 958ms to 495ms.
> >>>> Especially for the shot2shot in this mode, the preview dealy of each=
 frame have
> >>>> a significant improve.
> >>> Hello Huan,
> >>>
> >>> thank you for sharing your work.
> >> thanks
> >>> Some high-level thoughts:
> >>> 1) Naming is hard, but it took me quite a while to realize that you'r=
e talking
> >> Haha, sorry for my pool english
> >>> about free memory. Cache is obviously an overloaded term, but per-mem=
cg-cache
> >>> can mean absolutely anything (pagecache? cpu cache? ...), so maybe it=
's not
> >> Currently, my idea is that all memory released by processes under memc=
g
> >> will go into the `cache`,
> >>
> >> and the original attributes will be ignored, and can be freely request=
ed
> >> by processes under memcg.
> >>
> >> (so, dma-buf\page cache\heap\driver, so on). Maybe named PMP more
> >> friendly? :)
> >>
> >>> the best choice.
> >>> 2) Overall an idea to have a per-memcg free memory pool makes sense t=
o me,
> >>> especially if we talk 2MB or 1GB pages (or order > 0 in general).
> >> I like it too :)
> >>> 3) You absolutely have to integrate the reclaim mechanism with a gene=
ric
> >>> memory reclaim mechanism, which is driven by the memory pressure.
> >> Yes, I all think about it.
> >>> 4) You claim a ~50% performance win in your workload, which is a lot.=
 It's not
> >>> clear to me where it's coming from. It's hard to believe the page all=
ocation/release
> >>> paths are taking 50% of the cpu time. Please, clarify.
> >> Let me describe it more specifically. In our test scenario, we have 8G=
B
> >> of RAM, and our camera application
> >>
> >> has a complex set of algorithms, with a peak memory requirement of up =
to
> >> 3GB.
> >>
> >> Therefore, in a multi-application background scenario, starting the
> >> camera and taking photos will create a
> >>
> >> very high memory pressure. In this scenario, any released memory will =
be
> >> quickly used by other processes (such as file pages).
> >>
> >> So, during the process of switching from camera capture to preview,
> >> DMA-BUF memory will be released,
> >>
> >> while the memory used for the preview algorithm will be simultaneously
> >> requested.
> >>
> >> We need to take a lot of slow path routes to obtain enough memory for
> >> the preview algorithm, and it seems that the
> >>
> >> just released DMA-BUF memory does not provide much help.
> >>
> > Hi Huan,
> HI T.J.
> >
> > I find this part surprising. Assuming the dmabuf memory doesn't first
> > go into a page pool (used for some buffers, not all) and actually does
> Actually, when PMC enabled, we let page free avoid free into page pool.
> > get freed synchronously with fput, this would mean it gets sucked up
> > by other supposedly background processes before it can be allocated by
> > the preview process. I thought the preview process was the one most
> > desperate for memory? You mention file pages, but where is this
> > newly-freed memory actually going if not to the preview process? My
> This was discovered through the meminfo observation program.
> When the dma-buf is released, there is a noticeable increase in cache.
>
> This may be triggered by pagecache when loading the algorithm model.
>
> Additionally, the algorithm heap memory cannot benefit from the release
> of the dma-buf.
> I believe this is related to the migratetype. The stack/heap cannot
> obtain priority access to
> the dma-buf memory released by the kernel.(HIGHUSER_MOVABLE)
>
> So, PMC break it, share each memory. Even if it's incorrect :)(If my
> understanding of the
> fragmentation issue is incorrect, please correct me.)
>
Oh that would make sense, but then the memory *is* going to your
preview process just not in the form you were hoping for. So model
loading and your heap allocations were fighting for memory, probably
thrashing the file pages? I guess it's more important to get the heap
allocations done first for performance for your app, and I think I can
understand how PMC would give a sort of priority to those over the
file pages during the preview transition. Ok. Sorry I don't have an
opinion on this part yet if that's what's happening.

> > initial reaction was the same as Roman's that the PMC should be hooked
> > up to reclaim instead of depending on the reaper. But I think this
> > might suggest that wouldn't work because the system is under such high
> > memory pressure that it'd be likely reclaim would have emptied the
> > PMCs before the preview process could use it.
> The point you raised is indeed very likely to happen, as there is immense
> memory pressure.
> Currently, we only open the PMC when the application is in the foreground=
,
> and close it when it goes to the background.
> It is indeed unnecessary to drain the PMC when the application is in the
> foreground,
> and a longer reaper timeout would be more useful.(Thanks for the
> flexibility provided by memcg.)
> >
> > One more thing I find odd is that for this to work a significant
> > portion of your dmabuf pages would have to be order 0, but we're
> > talking about a ~500M buffer. Does whatever exports this buffer not
> > try to use higher order pages like here?
> Yes, actually our heap configured order 8 4 0, but In our practical
> application and observation processes,
> it is often difficult to meet the high-order memory allocation, so
> falling back to order 0 is the most common.
> Therefore, for our MID_ORDER allocation, we use LOW_ORDER_GFP.
> Just like the testing scenario I mentioned earlier, with 8GB of RAM and
> the camera peaking at around 3GB,
>
> the fragmentation at this point will cause most of the DMA-BUF
> allocations to fall back to order 0.
> The use of PMC is for real-world, high-load applications. I don't think
> it's very practical for regular applications.

Got it, thanks.
>
> Thanks
> HY
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/dma-buf/heaps/system_heap.c?h=3Dv6.9#n54
> >
> > Thanks!
> > -T.J.
> >
> >> But using PMC (let's call it that for now), we are able to quickly mee=
t
> >> the memory needs of the subsequent preview process
> >>
> >> with the just released DMA-BUF memory, without having to go through th=
e
> >> slow path, resulting in a significant performance improvement.
> >>
> >> (of course, break migrate type may not good.)
> >>
> >>> There are a lot of other questions, and you highlighted some of them =
below
> >>> (and these are indeed right questions to ask), but let's start with s=
omething.
> >>>
> >>> Thanks
> >> Thanks
> >>

