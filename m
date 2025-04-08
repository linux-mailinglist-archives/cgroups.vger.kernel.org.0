Return-Path: <cgroups+bounces-7431-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271E6A81236
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 18:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4B9165C00
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 16:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2302B22D799;
	Tue,  8 Apr 2025 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu/PVtL+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C8E1991CB;
	Tue,  8 Apr 2025 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744129399; cv=none; b=Q5XMwjkgYk6X84LWpNDv6nYFvDatAzjgfAdpyDQjoMfe1susZDRJFoCmezVa96oLvyuae4dyCt+S1zck0bOqfjItIRP3vhI3pAmdivTKd3DrMRJY4k2b1P66VmLHZEm1YbolREiQgU5xcoy4THHbXf8pEerMObEnE2dzOqGk8ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744129399; c=relaxed/simple;
	bh=RfS/RPt20xT1FRrwznKp2niS7/MlF89JXFfqnnkdXcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wj2fRhUMQ90s0KUvk56IDXHmecyr3dBv7b5QmuGz5zSn0Rc4ATM3bD03XiYT66Dk3jmFk1NE9+E0H2zswQ6GN0cpy9vBsb2jUToeulEx2m6U1x3l2qY5V4qpTT3xELk9jnVWPFYfk2xMgY5MDjsXHLOnMBRBCCWNh19moLEhIjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu/PVtL+; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30ddad694c1so60929781fa.2;
        Tue, 08 Apr 2025 09:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744129396; x=1744734196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO/lkkmO99Xfr4W0KYk8tkPWToFmwEKNPxUMEMkq524=;
        b=Uu/PVtL+YtgQNHRoT2lXkWKlwUn7oahLJL7QLlwUWBzMtbjHpGpnPG+1OBHmaGVUY2
         ZhL7xzMGSRG95zW0ktP7TV7B7Y+JQCYlXtjz81Roh7zJblyhGt+jxQtLwn5iRtbO84Mn
         JO5z0rimPfx/o9P9FJJqOsKy48r230LGpSOKuJ2hdIa2oDGRCQOxPyItA7xSveIhgTCG
         7OZl8CuzOZ/Or1XfJSEDX6vKRMME6K8UEbAN5vJ7YJm2kCQsGBOL4gO8O0Y4CmSR0wTe
         8WTIIswuQpUlbL4WB54/bfl4JCQNkEXB0JrGgmWoWBe9JlheUrhz/zP/THWgIUj0j1y9
         qkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744129396; x=1744734196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cO/lkkmO99Xfr4W0KYk8tkPWToFmwEKNPxUMEMkq524=;
        b=CzYjo5yUPR4pw71oCFj7W1Bjc51x992RG9HbzQN7f76O/9nyxOLJigOGoD9rlDvwqN
         eWkbTK+JxvY+wO6oBlJFPrMKB9z1MwuAIid4Hi/nS6hAuUWUrZXq2nlzxPxIs++rH401
         c2TZ7cFTsGsivMMeyI9lUTAuBUDKrURyICQDyFBCJoQy6/WUWFw+d/gMPCSHMAp96UDO
         9AC0wC8oklX6g60JbUHROrUOCPY3DDnZlI5LRrjVZvaBZubipxXHsGG0goMOUMEOML5E
         Lbf1lxS2QPfa+fRkxIQrT1TlvZOO4DDAXr5985jNrY2jirwPlxOuC61DlrgZBoQhkaD0
         0K5A==
X-Forwarded-Encrypted: i=1; AJvYcCVx3iaC/okTehDBVwGwRQpSoCKYcMwXu/vTrIOUPQUgeVDgGAQvD7H03NecoVYlKhslI3zl4UVP1UQ=@vger.kernel.org, AJvYcCWD0jF25fDhjo8uHdGPu+B/H4kngp8fYO4HPZbiiXLlTpWSLFO5+4gHaRKOX1UGXTVZVwUwqOVy@vger.kernel.org, AJvYcCWqcwhszvEFus1yAq324HhF6PccxhpPaHXXuZxUWflclGyy5PruUEBnVxWTIDfnkx39asc5QQx4eTs1kt/J@vger.kernel.org
X-Gm-Message-State: AOJu0YyYoNCcTfsR7/+I/PSuYefj8mj3jfM6HdWosnNGZXyLpCGw8SnY
	bTz53EDqe5JhBr/uM8u1JeEFkxR+WUkj0BnsD0tTT7O0ITu5yV09BDCjiEJqLBv/bSNdYe4JHTO
	cf1nshb/hFxAAQguz1aflZWqP7JA=
X-Gm-Gg: ASbGncsBhU/6y4F6MtkzyDc+z37ja8ijXQDdZMJpTPt+VIH/GAeGyhVACudtkzqi7vb
	fllZop8zjQ3FkLMmwTQk2QfHAIR5SeMAre8pf3vQrNvGWJo4QTplP1W5HDb/02eQ6jGoG3rNjTH
	x6arW88C5rQua3SuuT7hYW3i/Cdw==
X-Google-Smtp-Source: AGHT+IEP7Nh9wOKkc5/HcoAMiiR8n7ueANOAM3TtdGIfWyMJemlif/wFUDHgutRmKYSexGttnFcOIpdcHd1q2LgcJ/o=
X-Received: by 2002:a2e:a553:0:b0:30d:b328:8394 with SMTP id
 38308e7fff4ca-30f0bf1eb07mr47215981fa.13.1744129395756; Tue, 08 Apr 2025
 09:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407234223.1059191-1-nphamcs@gmail.com>
In-Reply-To: <20250407234223.1059191-1-nphamcs@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 9 Apr 2025 00:22:58 +0800
X-Gm-Features: ATxdqUFrOA5poLk2LCvT8r-ZavahScL1G90R_uOdgsK8qiGr9BEUgLKAk8ly3mA
Message-ID: <CAMgjq7CdARdTEZB3ik4X9cAzNUFa6GRqjT61brygihGUYFBAeQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] Virtual Swap Space
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	len.brown@intel.com, chengming.zhou@linux.dev, chrisl@kernel.org, 
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com, viro@zeniv.linux.org.uk, 
	baohua@kernel.org, osalvador@suse.de, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 7:47=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> This RFC implements the virtual swap space idea, based on Yosry's
> proposals at LSFMMBPF 2023 (see [1], [2], [3]), as well as valuable
> inputs from Johannes Weiner. The same idea (with different
> implementation details) has been floated by Rik van Riel since at least
> 2011 (see [8]).
>
> The code attached to this RFC is purely a prototype. It is not 100%
> merge-ready (see section VI for future work). I do, however, want to show
> people this prototype/RFC, including all the bells and whistles and a
> couple of actual use cases, so that folks can see what the end results
> will look like, and give me early feedback :)
>
> I. Motivation
>
> Currently, when an anon page is swapped out, a slot in a backing swap
> device is allocated and stored in the page table entries that refer to
> the original page. This slot is also used as the "key" to find the
> swapped out content, as well as the index to swap data structures, such
> as the swap cache, or the swap cgroup mapping. Tying a swap entry to its
> backing slot in this way is performant and efficient when swap is purely
> just disk space, and swapoff is rare.
>
> However, the advent of many swap optimizations has exposed major
> drawbacks of this design. The first problem is that we occupy a physical
> slot in the swap space, even for pages that are NEVER expected to hit
> the disk: pages compressed and stored in the zswap pool, zero-filled
> pages, or pages rejected by both of these optimizations when zswap
> writeback is disabled. This is the arguably central shortcoming of
> zswap:
> * In deployments when no disk space can be afforded for swap (such as
>   mobile and embedded devices), users cannot adopt zswap, and are forced
>   to use zram. This is confusing for users, and creates extra burdens
>   for developers, having to develop and maintain similar features for
>   two separate swap backends (writeback, cgroup charging, THP support,
>   etc.). For instance, see the discussion in [4].
> * Resource-wise, it is hugely wasteful in terms of disk usage, and
>   limits the memory saving potentials of these optimizations by the
>   static size of the swapfile, especially in high memory systems that
>   can have up to terabytes worth of memory. It also creates significant
>   challenges for users who rely on swap utilization as an early OOM
>   signal.
>
> Another motivation for a swap redesign is to simplify swapoff, which
> is complicated and expensive in the current design. Tight coupling
> between a swap entry and its backing storage means that it requires a
> whole page table walk to update all the page table entries that refer to
> this swap entry, as well as updating all the associated swap data
> structures (swap cache, etc.).
>
>
> II. High Level Design Overview
>
> To fix the aforementioned issues, we need an abstraction that separates
> a swap entry from its physical backing storage. IOW, we need to
> =E2=80=9Cvirtualize=E2=80=9D the swap space: swap clients will work with =
a dynamically
> allocated virtual swap slot, storing it in page table entries, and
> using it to index into various swap-related data structures. The
> backing storage is decoupled from the virtual swap slot, and the newly
> introduced layer will =E2=80=9Cresolve=E2=80=9D the virtual swap slot to =
the actual
> storage. This layer also manages other metadata of the swap entry, such
> as its lifetime information (swap count), via a dynamically allocated
> per-swap-entry descriptor:
>
> struct swp_desc {
>         swp_entry_t vswap;
>         union {
>                 swp_slot_t slot;
>                 struct folio *folio;
>                 struct zswap_entry *zswap_entry;
>         };
>         struct rcu_head rcu;
>
>         rwlock_t lock;
>         enum swap_type type;
>
>         atomic_t memcgid;
>
>         atomic_t in_swapcache;
>         struct kref refcnt;
>         atomic_t swap_count;
> };

Thanks for sharing the code, my initial idea after the discussion at
LSFMM is that there is a simple way to combine this with the "swap
table" [1] design of mine to solve the performance issue of this
series: just store the pointer of this struct in the swap table. It's
a bruteforce and glue like solution but the contention issue will be
gone.

Of course it's not a good approach, ideally the data structure can be
simplified to an entry type in the swap table. The swap table series
handles locking and synchronizations using either cluster lock
(reusing swap allocator and existing swap logics) or folio lock (kind
of like page cache). So many parts can be much simplified, I think it
will be at most ~32 bytes per page with a virtual device (including
the intermediate pointers).Will require quite some work though.

The good side with that approach is we will have a much lower memory
overhead and even better performance. And the virtual space part will
be optional, for non virtual setup the memory consumption will be only
8 bytes per page and also dynamically allocated, as discussed at
LSFMM.

So sorry that I still have a few parts undone, looking forward to
posting in about one week, eg. After this weekend it goes well. I'll
also try to check your series first to see how these can be
collaborated better.

A draft version is available here though, just in case anyone is
really anxious to see the code, I wouldn't recommend spend much effort
check it though as it may change rapidly:
https://github.com/ryncsn/linux/tree/kasong/devel/swap-unification

But the good news is the total LOC should be reduced, or at least
won't increase much, as it will unify a lot of swap infrastructures.
So things might be easier to implement after that.

[1] https://lore.kernel.org/linux-mm/CAMgjq7DHFYWhm+Z0C5tR2U2a-N_mtmgB4+idD=
2S+-1438u-wWw@mail.gmail.com/T/

