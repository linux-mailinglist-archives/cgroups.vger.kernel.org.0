Return-Path: <cgroups+bounces-7428-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5BCA8106A
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D3F8A5A02
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 15:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B267E1E5219;
	Tue,  8 Apr 2025 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dT8qa15h"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0E43FB1B;
	Tue,  8 Apr 2025 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126495; cv=none; b=FUOGq7jwmjC5ZRoMu6FfqfCuccFkolnzXXTVczKiH0Jjaq6WkiaCXA1h2SVk0iYPhkURfXaVHvV/nSHRJNI7cI2XdYYwU3pD44Yu6IHn27euI7W6v4XZ77yinbDDGpzzWlSR59bDbuN83jNStdT2rhmvuotjXVTTU5Kt/is8f3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126495; c=relaxed/simple;
	bh=/oiDkgTXrsiksDJP14zgHf0TgOqnYiJRdtOYGICwgKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B90SGyHwfKe8zbLvtCHP+mQ0Ki7td7Yx1NwbGKs7TvoLc9MyYpzPkXhG3BlqIsOK3V4Ho52cS2apjGp6QdYnq+wZiVK56SemYxw4nFNpoo8VKxhws3/i5e0UF2Nd9O25To8joP1a7J4ItNz9tnF+t3BdGdMJ6UO7D8jb+fKsP5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dT8qa15h; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f4c50a8fso52770116d6.1;
        Tue, 08 Apr 2025 08:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744126492; x=1744731292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR2lQ261f3N32nnAVTdEED+c/0wLSAdxgljnMtI0+iU=;
        b=dT8qa15heggF/UROmPuB/b6uWtndLcZAWJVRcZd8MCne0jRm7rtBU/wNohPfZcUJ/K
         DHiL6HBnub9F1v+mZCRXi0lTbWGOHmfTZWIGFzUHG1mhhqAcB1ETh0HLm03zfsY95dHs
         gvTFthGNgPzL2rL4AD5iUCurFl497zRSIl49RR018IHuRmD9TwrHcJEZB542J1TzCW8n
         baxcNzcZcFf8eCruLDI+NOUgLjjIWq1d/eNiIuRPE3b/WI2XrEqUR6cyLhyMtg0Pq8Ow
         MSZGcsoQOi06LVXr4oroW30y+luStSB8CuCHVQO1ZNUlXOyDTdwnLfwQS4JFCMJfuP0D
         i+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744126492; x=1744731292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XR2lQ261f3N32nnAVTdEED+c/0wLSAdxgljnMtI0+iU=;
        b=VaEvixs5V2FAP8l0CuqT+3xqQZkKAby8Q/3381CEARVtEVBX/qoyEevZUWnrNHXb2Y
         /QKEQ8oCPs6QU5Kzo7W6SiyS1SNndnGXFFjupxSdPPLpdIzM/5SaNZs9aqHO9kCo1Nti
         rR8k2BWKa9Dx4LIzhQF9sEyc1IcIYt8XlmICLLWDUv6R9lfuclG1XF1wJ0PU0d75TJ/7
         +9/TV8XI0JvmYkdkUWEn1+qP3SveZWNn3XwFVEQJhgd/XAXOjOJ90Rd/cU4+TyzFR+ah
         4S4tlifGWhXGkUZHSNhQzqG4ghxNqJ5rUqrzn3tMNOAXr7/FX1n9VodTXGvdMMckqWda
         +6PA==
X-Forwarded-Encrypted: i=1; AJvYcCUTLTXWRD5VgEewejvMymn4Pz2Qw+RC4TrhuKcoPmxaBD03oVHoH6jYmuIl0/I/ZNxSGu4DP7ltPDRx9kek@vger.kernel.org, AJvYcCV8xXlDkYkzLpy+XVnJ+R58Ojz4k/WhRgcQvwfQnPhk7vopdXbnY7sJyRB3GAegWwBfU7CN8WjXGPE=@vger.kernel.org, AJvYcCVULM0CIRG2FEVrHpIcSwi3zei8x6svZ6zRpSlSW6n9LAYOmuTWX2ncrqfVcZ0kLl3HjRHnEDxv@vger.kernel.org
X-Gm-Message-State: AOJu0YyfqyLhRLAJj+c1bMbmNHVZzYehyYTZVYjZj3GyFGPkt7zsow5u
	kJAHjMm9wIIW6u2pZ++0MfZY35zR0rHf2auxoQ3Q4cmVAnUSNAlPlewD+vWqBVmKkBNhZXfxWEV
	NqpCzkjnSG5ud4vssanRDIQSZ1EY=
X-Gm-Gg: ASbGncsdkAcaQwKeyvUij7mCnoXCHjxwkXnROagjK3A6SEbX6IhsvToxhTEpzbCy98G
	Ss/xfAh2T09T6cTfKecKHIkdweKGBB0m/jklNKbHKlMDFPuXeO74QePOHDTdzXnRVsl48yn8E5r
	ZqY+6GetZ8sQaY+4RpTbosuwgpICd7xY84nWeiDnlrE0OC7nZzHirnBHOHQw==
X-Google-Smtp-Source: AGHT+IFUpXmXWJKWMZv3V9DtL3vViqbCboSNOKEE8R91fe5FlL/e42WDLJl44r7KI72dl040ZEnUpd6fg0qrhQGPaiU=
X-Received: by 2002:a05:6214:c6d:b0:6e6:602f:ef68 with SMTP id
 6a1803df08f44-6f05842ba01mr248129896d6.10.1744126492505; Tue, 08 Apr 2025
 08:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407234223.1059191-1-nphamcs@gmail.com> <20250407234223.1059191-5-nphamcs@gmail.com>
 <20250408150019.GB816@cmpxchg.org>
In-Reply-To: <20250408150019.GB816@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 8 Apr 2025 08:34:41 -0700
X-Gm-Features: ATxdqUEmNiQer3ue-dIoVb66m9x5pWIpJ0DGhNSQfNMn9jkNT1SAme32S8nBtCo
Message-ID: <CAKEwX=PzsdYupTp=0pyHa48PbtmAwUe_JBKjV9N-fLvLwB0SwA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/14] mm: swap: swap cache support for virtualized swap
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hughd@google.com, 
	yosry.ahmed@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, len.brown@intel.com, 
	chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org, 
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com, viro@zeniv.linux.org.uk, 
	baohua@kernel.org, osalvador@suse.de, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 8:00=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Mon, Apr 07, 2025 at 04:42:05PM -0700, Nhat Pham wrote:
> > Currently, the swap cache code assumes that the swap space is of a fixe=
d
> > size. The virtual swap space is dynamically sized, so the existing
> > partitioning code cannot be easily reused.  A dynamic partitioning is
> > planned, but for now keep the design simple and just use a flat
> > swapcache for vswap.
> >
> > Since the vswap's implementation has begun to diverge from the old
> > implementation, we also introduce a new build config
> > (CONFIG_VIRTUAL_SWAP). Users who do not select this config will get the
> > old implementation, with no behavioral change.
> >
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  mm/Kconfig      | 13 ++++++++++
> >  mm/swap.h       | 22 ++++++++++------
> >  mm/swap_state.c | 68 +++++++++++++++++++++++++++++++++++++++++--------
> >  3 files changed, 85 insertions(+), 18 deletions(-)
> >
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 1b501db06417..1a6acdb64333 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -22,6 +22,19 @@ menuconfig SWAP
> >         used to provide more virtual memory than the actual RAM present
> >         in your computer.  If unsure say Y.
> >
> > +config VIRTUAL_SWAP
> > +     bool "Swap space virtualization"
> > +     depends on SWAP
> > +     default n
> > +     help
> > +             When this is selected, the kernel is built with the new s=
wap
> > +             design. This will allow us to decouple the swap backends
> > +             (zswap, on-disk swapfile, etc.), and save disk space when=
 we
> > +             use zswap (or the zero-filled swap page optimization).
> > +
> > +             There might be more lock contentions with heavy swap use,=
 since
> > +             the swap cache is no longer range partitioned.
> > +
> >  config ZSWAP
> >       bool "Compressed cache for swap pages"
> >       depends on SWAP
> > diff --git a/mm/swap.h b/mm/swap.h
> > index d5f8effa8015..06e20b1d79c4 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -22,22 +22,27 @@ void swap_write_unplug(struct swap_iocb *sio);
> >  int swap_writepage(struct page *page, struct writeback_control *wbc);
> >  void __swap_writepage(struct folio *folio, struct writeback_control *w=
bc);
> >
> > -/* linux/mm/swap_state.c */
> > -/* One swap address space for each 64M swap space */
> > +/* Return the swap device position of the swap slot. */
> > +static inline loff_t swap_slot_pos(swp_slot_t slot)
> > +{
> > +     return ((loff_t)swp_slot_offset(slot)) << PAGE_SHIFT;
> > +}
>
> In the same vein as the previous email, please avoid mixing moves,
> renames and new code as much as possible. This makes it quite hard to
> follow what's going on.
>
> I think it would be better if you structure the series as follows:
>
> 1. Prep patches. Separate patches for moves, renames, new code.
>
> 3. mm: vswap
>    - config VIRTUAL_SWAP
>    - mm/vswap.c with skeleton data structures, init/exit, Makefile hookup
>
> 4. (temporarily) flatten existing address spaces
>
>    IMO you can do the swapcache and zswap in one patch
>
> 5+. conversion patches
>
>     Grow mm/vswap.c as you add discrete components like the descriptor
>     allocator, swapoff locking, the swap_cgroup tracker etc.
>
>     You're mostly doing this part already. But try to order them by
>     complexity and on a "core to periphery" gradient. I.e. swapoff
>     locking should probably come before cgroup stuff.
>
> Insert move and rename patches at points where they make the most
> sense. I.e. if they can be understood in the current upstream code
> already, put them with step 1 prep patches. If you find a move or a
> rename can only be understood in the context of one of the components,
> put them in a prep patch right before that one.

Makes sense, yeah! I'll try to avoid mixing moves/renames/new code as
much as I can.

>
> > @@ -260,6 +269,28 @@ void delete_from_swap_cache(struct folio *folio)
> >       folio_ref_sub(folio, folio_nr_pages(folio));
> >  }
> >
> > +#ifdef CONFIG_VIRTUAL_SWAP
> > +void clear_shadow_from_swap_cache(int type, unsigned long begin,
> > +                             unsigned long end)
> > +{
> > +     swp_slot_t slot =3D swp_slot(type, begin);
> > +     swp_entry_t entry =3D swp_slot_to_swp_entry(slot);
> > +     unsigned long index =3D swap_cache_index(entry);
> > +     struct address_space *address_space =3D swap_address_space(entry)=
;
> > +     void *old;
> > +     XA_STATE(xas, &address_space->i_pages, index);
> > +
> > +     xas_set_update(&xas, workingset_update_node);
> > +
> > +     xa_lock_irq(&address_space->i_pages);
> > +     xas_for_each(&xas, old, entry.val + end - begin) {
> > +             if (!xa_is_value(old))
> > +                     continue;
> > +             xas_store(&xas, NULL);
> > +     }
> > +     xa_unlock_irq(&address_space->i_pages);
>
> I don't think you need separate functions for this, init, exit etc. if
> you tweak the macros to resolve to one tree. The current code already
> works if swapfiles are smaller than SWAP_ADDRESS_SPACE_PAGES and there
> is only one tree, after all.

For clear_shadow_from_swap_cache(), I think I understand what you want
- keep clear_shadow_from_swap_cache() the same for two
implementations, but at caller sites, have the callers themselves
determine the range in swap cache (i.e (begin, end)).

I'm a bit confused with init and exit, but I assume there is a way to
do it for them as well.

I will note though, that it might increase the number of ifdefs
sections (or alternatively, IS_ENABLED() checks), because these
functions are called in different contexts for the two
implementations:

1. init and exit are called in swapon/swapoff in the old
implementation. They are called in swap initialization in the virtual
swap implementation.

2. Similarly, we clear swap cache shadows when we free physical swap
slots in the old implementation, and when we free virtual swap slots
in the new implementation,

I think it is good actually, because it makes the difference explicit
rather than implicit. Also, it helps us know exactly which code block
to target when we unify the two implementations :) Just putting it out
there.

>
> This would save a lot of duplication and keep ifdefs more confined.

