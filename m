Return-Path: <cgroups+bounces-11795-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D621EC4B9EB
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 07:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B1C334E6AC
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 06:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932572BE05A;
	Tue, 11 Nov 2025 06:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="GxQbPH2t"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5FB2BE029
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841580; cv=none; b=A3rkDBSgPCy616wCVu0DeApImJ4eVyFqmXS95HGLLHHcoDNdWw9pFvpWDGc1J6NSqEdUIx8CuhOOAsJ0IPxtqQzYtDW3EwzqI6h0qZNALpFsOnkaN8i7HSc9n642P09WvlZz8+tVnll29QsgNmYd40p1rAU8UlqLRm9Q7hXIOBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841580; c=relaxed/simple;
	bh=8rhcgK/uhFz5i+qhvU5QkcxFYGJ70HuDlKM0CIE/z1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQgcdXiTS4J9q/+BS44hvoAGrs6f8K6xxN79TUAaqzWIuHZoFrFX3tu1LXrWnvWWuoM4p9KflLfaqKDZY5rwSosSho0j3l65sq0mXnU0jFpWzQeM5TCa+QXk/pl+J3lu7hCCOS5Qttwz/FJTJT/IXQKkksWb6entk9PbJSmD798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=GxQbPH2t; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-295ceaf8dacso39551785ad.0
        for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 22:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762841578; x=1763446378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rhcgK/uhFz5i+qhvU5QkcxFYGJ70HuDlKM0CIE/z1s=;
        b=GxQbPH2tyxPcDPvVNUzGdo1a5EvMcuz/29m3gDhVvnHfP+GdmwY601QT+ibTwX7yn4
         RZkGIXWW7sUmOdb++U+5PiqU34g8qBFpGXl0m8epcHDdWOG0Nh2h8jX5rgUoy1WlPYYk
         tPQinxizh9XNeZfdIDpd9frQTjg26+WdohQ7Cr0uIugB5TZOldlPzzNjTGp23xFYirf8
         pzA0dtpsDXR+unPrs4CSAhAF2Oz1bx9Aqrafjw6zRoQ055MmcCYdi5sADfnFNMxKvPax
         FJRfyQG53qHW428nszW7p/ItW9SSNmODcEea8F6IKrM5eaWnSGvamX7M0toCow1VfGE7
         +d3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762841578; x=1763446378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8rhcgK/uhFz5i+qhvU5QkcxFYGJ70HuDlKM0CIE/z1s=;
        b=g+kwvdhh4w+StSqw8owJuRCx5BNC1XaVAJA2+FvzqKLfGTeOB2fo5TrCIwmRdqgKDt
         WY3t8uL66mo+2OGE3/URzNEUxW7jJw+atrp+zzWGUiFMwDjZKbc1DplhUNpJq9fzP8S5
         d25sYJVKam0GFD28gOtrGAM7y+j0yiAncUCX28HkgYj5gCsO2z+7xk9lSqEEODAH3QBZ
         0xbjaZAEWSV+HKw15En+q7DC5Uo5/yRJy41QAHsybmBcdO+hyCvETn6bAluOGSUTklff
         FD3dJ1eA+IgT7Wnk//oMXhOJUnOTYrYAfSboiJ1fR+QiO9zvUS/K2d4AbRlM65gG7i0G
         r7lg==
X-Forwarded-Encrypted: i=1; AJvYcCWWNd9J0j3kWlSAT9nqF088ZMr0K3jDzz3su4irr5UZytJM2rwSN+iJQ5H+L8N1o6P5Ld5vHkUp@vger.kernel.org
X-Gm-Message-State: AOJu0YzB38vMHYW1TnPlsU87aiLI0ehnn3Nlh/LTs7uY0hQZrDWl8hsw
	M1RNzJLyKxHcgMJ3icY1LbuCrcm/Gzfcix6R+P4T20zKe32CplAO0bSU8YNzkxqkgLo=
X-Gm-Gg: ASbGncvwLTnmfgHaUZVsJs5vWcmF9TdrxlVNDcdXGKXstq3B3cHYcbKOlL2c1yLl535
	Xezl9BYjcLWrgVHYu6votnK7aQ2URosl0pRqod/saI+cFQXcx6nYGTpI77J/HHi73DgdoFhswWI
	jmohbVEK4/aQOCZF0lvttHlLqptkN6YBYszmRySKsnfS4sy4d0ySDRfnmpgJ1BnspmJIUsoyHM+
	/wYQ3/LuBi6e7HAfzhX9tu6QxLz2vkhqOBIxv/w9bE7kkkIsc2d3THCqNaLFhD8fSpBtH3GEhXf
	xAvu+yg9lHZ2fudt6lAIg9LrZdJ+3prb0fdhz45WdWUUbz3BELwZPt6n+kVdsFsmPuDCBY02Ayb
	4Cu8W+oAbTxrBAnWobn82Q7hrWVJ3t8umBwOSfupALJiSWDAlElbwMHoAARlaJg7YlIlHRelqRL
	KeDzWP0h6eWsSw3SCEaYk/y0nN
X-Google-Smtp-Source: AGHT+IELhVS7nb73OxbKeEmwDpZqhH0jCXP0hL6eUPlcCMaV+4//v9rB3bD5Gbbb7H8J9XLzDYxOIQ==
X-Received: by 2002:a17:902:cf42:b0:295:bedb:8d7 with SMTP id d9443c01a7336-297e56f6f5amr132204345ad.48.1762841577982;
        Mon, 10 Nov 2025 22:12:57 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343c4f6f78bsm650216a91.3.2025.11.10.22.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 22:12:57 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: harry.yoo@oracle.com
Cc: akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	hannes@cmpxchg.org,
	jack@suse.cz,
	joel.granados@kernel.org,
	kyle.meyer@hpe.com,
	lance.yang@linux.dev,
	laoar.shao@gmail.com,
	leon.huangfu@shopee.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mclapinski@google.com,
	mhocko@kernel.org,
	mkoutny@suse.com,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	tj@kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for on-demand stats flushing
Date: Tue, 11 Nov 2025 14:12:49 +0800
Message-ID: <20251111061251.70906-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <aRHR_zAx1HgyQJqR@hyeyoo>
References: <aRHR_zAx1HgyQJqR@hyeyoo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Harry,

On Mon, Nov 10, 2025 at 7:52 PM Harry Yoo <harry.yoo@oracle.com> wrote:
>
> On Mon, Nov 10, 2025 at 06:19:48PM +0800, Leon Huang Fu wrote:
> > Memory cgroup statistics are updated asynchronously with periodic
> > flushing to reduce overhead. The current implementation uses a flush
> > threshold calculated as MEMCG_CHARGE_BATCH * num_online_cpus() for
> > determining when to aggregate per-CPU memory cgroup statistics. On
> > systems with high core counts, this threshold can become very large
> > (e.g., 64 * 256 = 16,384 on a 256-core system), leading to stale
> > statistics when userspace reads memory.stat files.
> >
> > This is particularly problematic for monitoring and management tools
> > that rely on reasonably fresh statistics, as they may observe data
> > that is thousands of updates out of date.
> >
> > Introduce a new write-only file, memory.stat_refresh, that allows
> > userspace to explicitly trigger an immediate flush of memory statistics.
> >
> > Writing any value to this file forces a synchronous flush via
> > __mem_cgroup_flush_stats(memcg, true) for the cgroup and all its
> > descendants, ensuring that subsequent reads of memory.stat and
> > memory.numa_stat reflect current data.
> >
> > This approach follows the pattern established by /proc/sys/vm/stat_refresh
> > and memory.peak, where the written value is ignored, keeping the
> > interface simple and consistent with existing kernel APIs.
> >
> > Usage example:
> >   echo 1 > /sys/fs/cgroup/mygroup/memory.stat_refresh
> >   cat /sys/fs/cgroup/mygroup/memory.stat
> >
> > The feature is available in both cgroup v1 and v2 for consistency.
> >
> > Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
> > ---
> > v2 -> v3:
> >   - Flush stats by memory.stat_refresh (per Michal)
> >   - https://lore.kernel.org/linux-mm/20251105074917.94531-1-leon.huangfu@shopee.com/
> >
> > v1 -> v2:
> >   - Flush stats when write the file (per Michal).
> >   - https://lore.kernel.org/linux-mm/20251104031908.77313-1-leon.huangfu@shopee.com/
> >
> >  Documentation/admin-guide/cgroup-v2.rst | 21 +++++++++++++++++--
> >  mm/memcontrol-v1.c                      |  4 ++++
> >  mm/memcontrol-v1.h                      |  2 ++
> >  mm/memcontrol.c                         | 27 ++++++++++++++++++-------
> >  4 files changed, 45 insertions(+), 9 deletions(-)
>
> Hi Leon, I have a few questions on the patch.
>
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 3345961c30ac..ca079932f957 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1337,7 +1337,7 @@ PAGE_SIZE multiple when read back.
> >       cgroup is within its effective low boundary, the cgroup's
> >       memory won't be reclaimed unless there is no reclaimable
> >       memory available in unprotected cgroups.
> > -     Above the effective low boundary (or
> > +     Above the effective low boundary (or
>
> Is this whitespace change? it looks the same as before.
>

Yes, that hunk just trims the trailing whitespace.

If you'd prefer to avoid the churn, I'm happy to drop it from the series.

> >       effective min boundary if it is higher), pages are reclaimed
> >       proportionally to the overage, reducing reclaim pressure for
> >       smaller overages.
> > @@ -1785,6 +1785,23 @@ The following nested keys are defined.
> >               up if hugetlb usage is accounted for in memory.current (i.e.
> >               cgroup is mounted with the memory_hugetlb_accounting option).
> >
> > +  memory.stat_refresh
> > +     A write-only file which exists on non-root cgroups.
>
> Why don't we create the file for the root cgroup?
>

Thanks for pointing that out—I copied the wording from the memory.stat section without double-checking.

All three files, memory.{stat,numa_stat,stat_refresh}, are created for the root cgroup.

> > +     Writing any value to this file forces an immediate flush of
> > +     memory statistics for this cgroup and its descendants. This
> > +     ensures subsequent reads of memory.stat and memory.numa_stat
> > +     reflect the most current data.
> > +
> > +     This is useful on high-core count systems where per-CPU caching
> > +     can lead to stale statistics, or when precise memory usage
> > +     information is needed for monitoring or debugging purposes.
> > +
> > +     Example::
> > +
> > +       echo 1 > memory.stat_refresh
> > +       cat memory.stat
> > +
> >    memory.numa_stat
> >       A read-only nested-keyed file which exists on non-root cgroups.
> >
> > @@ -2173,7 +2190,7 @@ of the two is enforced.
> >
> >  cgroup writeback requires explicit support from the underlying
> >  filesystem.  Currently, cgroup writeback is implemented on ext2, ext4,
> > -btrfs, f2fs, and xfs.  On other filesystems, all writeback IOs are
> > +btrfs, f2fs, and xfs.  On other filesystems, all writeback IOs are
> >  attributed to the root cgroup.
>
> Same here, not sure what's changed...

That's just trimming the trailing whitespace.

>
> >  There are inherent differences in memory and writeback management
> > diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> > index 6358464bb416..a14d4d74c9aa 100644
> > --- a/mm/memcontrol-v1.h
> > +++ b/mm/memcontrol-v1.h
> > @@ -4666,6 +4675,10 @@ static struct cftype memory_files[] = {
> >               .name = "stat",
> >               .seq_show = memory_stat_show,
> >       },
> > +     {
> > +             .name = "stat_refresh",
> > +             .write = memory_stat_refresh_write,
>
> I think we should use the CFTYPE_NOT_ON_ROOT flag to avoid creating
> the file for the root cgroup if that's intended?
>

I kept memory.stat_refresh aligned with the existing memory.stat entry, so
I left CFTYPE_NOT_ON_ROOT unset.

That said, the documentation is behind the current behavior; I'll update
it to spell out that the files exist on the root cgroup too.

Thanks,
Leon

