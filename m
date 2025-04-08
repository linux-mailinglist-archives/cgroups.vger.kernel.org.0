Return-Path: <cgroups+bounces-7429-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C80EA810AB
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 17:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF21188A234
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A140922D4FA;
	Tue,  8 Apr 2025 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ2SRjqZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A058B22CBD0;
	Tue,  8 Apr 2025 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127048; cv=none; b=W9gWzVP3uSCzLinEimfkz4i+bkNzUg5icBdw9cex1mfSOS2XlByUm58neHgcwneSv8B3a81XAXSxgjlZGOGfk1qPZipLsArC+ewDOegLwPIV0kt7jGVx/wkNlIp7sKGBWGAPnAhYNxQfSyQ8MvgRQ5TWiWLvZc8NBSv2jYOi1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127048; c=relaxed/simple;
	bh=HDWBIrxoIEOJTUhyncNcFX8jtIjekzzynwwrBz/zgJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RONM0PhRa8P4j9ruHdsABwA9/snEonr6LPTvp5lawiSIca6TEvIYl9x/vfP50A2mVA3uwFsOt/PZqgBJ3fo3EiKa6YRLJwMnqL24QPBrORcz/XFes7GgTq7Ta/2yvivtgRYMzLhAWl/E934eki+B8ogCnoQMb70iKoT/lrRcMJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQ2SRjqZ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6eeb7589db4so60205106d6.1;
        Tue, 08 Apr 2025 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744127045; x=1744731845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reeoYvxYItdd7KUhzGsTnl24tBhKlbJEGhQp4n5yZys=;
        b=jQ2SRjqZNk6UqRNVStlz7lrLHO7uxrD+etpZ5vbNXMcNmSzMs3BeQCiZQ/+TQd8Y9G
         utQwaob2nhmi8CtIPEHKx77QDjQ4g3zrSTPBqJs50dUH1xUCD2uE9UWvkxovPH+YZVRh
         Zw+R0Gnl+smOkm4Lf7RKXusGNpjTPDkTLjPssmQOrDKalGhGzRAAEdDFH7SUPg429g5s
         UcB5t9znIINYadSfEV2J93xPYsOGV81Bo39gfLqzF55xId+hhb+hTb4qCCnjv9eJAC1U
         GIEUtsgZ5EJvnc/MIhe1lO0yeqk1UkfTRP/YeZFvJiwhpadr9eklD7F5/ZYxKTyLviUF
         R9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127045; x=1744731845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reeoYvxYItdd7KUhzGsTnl24tBhKlbJEGhQp4n5yZys=;
        b=CuC0kWDzXhNEAW6P7K2rXZhm4j8D+17JBzlmVzkOZ3GzbN1nXpnDOP/a8iOhMF601S
         Mt0RcK6nwdkC8gpTL6gLq3bZNfOJrt2dNgaQeY2XWoaM6KCCUJLUC4BE3d8L+0IupwWo
         38wbLj0B03VOZkuDV6UI10+4KLGvGRPx3gZT8KLSfw1K2Yt43+VptEIGIz9gfsJYx77B
         Sb50LF7D8Das7lNqNfLjA8uZc0Js3HejHDKnONiwVw+/ZMb7Ez1TVzjTZkYVpSU6t4b1
         NqrBvkjqPX2Tehb+eXOaV5dPVKBWtv6ktfVMkoBg3RrGyK4BW+V0q9zZIW4Ek82xIct8
         Gw8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUs9dUmcMC8aYqvQPVgezQE2WdgziLEKBI0K3Ox4TyDstVDzuQF+yBRJHKcrEbzqAT45cGbtwwWJKqsGiw+@vger.kernel.org, AJvYcCVIBYU/eCFFSEgq6bLdNh57Mkr+tUoE9ZOAnUCcB+EnCmU7JsdnEl++rP21XavJyMEtEs9KaChAiLA=@vger.kernel.org, AJvYcCXc9BrK6YW5N+S6YtRuwOuOc9BJmPUqHzPH9M4I0Dt/FA6VJmqblYzyLyu5hbNU5Gk4DvJ5QBK2@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+QInt1DUc2EhIcH059RFmQjrI5fmfPH24d0CJOffwybQ7CJy
	y6qchCU5os2X5SzcHaQMHVJVw0b6+xR8TcyrzkjeM/EU7a1ZsTbWuJq43wDB/O+2zCtZwK43pg2
	HRlWOp+W1Ev5lM6qTGN6Tkp75Ag8=
X-Gm-Gg: ASbGncuMHPi7+lwILoUpWjPDBRGxYFs7DVE4d9e1TQbO3pGu6MxJGzrmAjcp3F8Hos4
	O0OvIYcWssv5OoDaBNHfYykUjPe1vhxOXKjiB4wUZ6bF18SnfCvtgXUkXxEhwMwONlalsO5XW99
	N4gZTAMVGnPnNdXg4S1VYK+YVH1tG0UAN062BsKiovX3DQqvIGYk/nlP9fVA==
X-Google-Smtp-Source: AGHT+IF5WXdcFK/qrko60GZWMJ9z/lrRCbPJa3p0lyBkNeVsUG2gDnLUBctnRZfwUhghIHT3QEEGbxR/fcwxhONO0xY=
X-Received: by 2002:a05:6214:20ce:b0:6ed:1da2:afb9 with SMTP id
 6a1803df08f44-6f05848f418mr344645726d6.19.1744127045531; Tue, 08 Apr 2025
 08:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407234223.1059191-1-nphamcs@gmail.com> <20250407234223.1059191-5-nphamcs@gmail.com>
 <20250408150019.GB816@cmpxchg.org> <CAKEwX=PzsdYupTp=0pyHa48PbtmAwUe_JBKjV9N-fLvLwB0SwA@mail.gmail.com>
In-Reply-To: <CAKEwX=PzsdYupTp=0pyHa48PbtmAwUe_JBKjV9N-fLvLwB0SwA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 8 Apr 2025 08:43:54 -0700
X-Gm-Features: ATxdqUGz4vsP2W5hwYJQzhrTKN5NxXh5yEJOebR2aaMkEy7r_wMz7Iwxi5kHDXM
Message-ID: <CAKEwX=MVaS1RdaEePy_QsByGVN36YnKvzKzHPUUQ0woj7aDrKQ@mail.gmail.com>
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

On Tue, Apr 8, 2025 at 8:34=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Tue, Apr 8, 2025 at 8:00=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
> >
> > On Mon, Apr 07, 2025 at 04:42:05PM -0700, Nhat Pham wrote:
> > > Currently, the swap cache code assumes that the swap space is of a fi=
xed
> > > size. The virtual swap space is dynamically sized, so the existing
> > > partitioning code cannot be easily reused.  A dynamic partitioning is
> > > planned, but for now keep the design simple and just use a flat
> > > swapcache for vswap.
> > >
> > > Since the vswap's implementation has begun to diverge from the old
> > > implementation, we also introduce a new build config
> > > (CONFIG_VIRTUAL_SWAP). Users who do not select this config will get t=
he
> > > old implementation, with no behavioral change.
> > >
> > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > ---
> > >  mm/Kconfig      | 13 ++++++++++
> > >  mm/swap.h       | 22 ++++++++++------
> > >  mm/swap_state.c | 68 +++++++++++++++++++++++++++++++++++++++++------=
--
> > >  3 files changed, 85 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > index 1b501db06417..1a6acdb64333 100644
> > > --- a/mm/Kconfig
> > > +++ b/mm/Kconfig
> > > @@ -22,6 +22,19 @@ menuconfig SWAP
> > >         used to provide more virtual memory than the actual RAM prese=
nt
> > >         in your computer.  If unsure say Y.
> > >
> > > +config VIRTUAL_SWAP
> > > +     bool "Swap space virtualization"
> > > +     depends on SWAP
> > > +     default n
> > > +     help
> > > +             When this is selected, the kernel is built with the new=
 swap
> > > +             design. This will allow us to decouple the swap backend=
s
> > > +             (zswap, on-disk swapfile, etc.), and save disk space wh=
en we
> > > +             use zswap (or the zero-filled swap page optimization).
> > > +
> > > +             There might be more lock contentions with heavy swap us=
e, since
> > > +             the swap cache is no longer range partitioned.
> > > +
> > >  config ZSWAP
> > >       bool "Compressed cache for swap pages"
> > >       depends on SWAP
> > > diff --git a/mm/swap.h b/mm/swap.h
> > > index d5f8effa8015..06e20b1d79c4 100644
> > > --- a/mm/swap.h
> > > +++ b/mm/swap.h
> > > @@ -22,22 +22,27 @@ void swap_write_unplug(struct swap_iocb *sio);
> > >  int swap_writepage(struct page *page, struct writeback_control *wbc)=
;
> > >  void __swap_writepage(struct folio *folio, struct writeback_control =
*wbc);
> > >
> > > -/* linux/mm/swap_state.c */
> > > -/* One swap address space for each 64M swap space */
> > > +/* Return the swap device position of the swap slot. */
> > > +static inline loff_t swap_slot_pos(swp_slot_t slot)
> > > +{
> > > +     return ((loff_t)swp_slot_offset(slot)) << PAGE_SHIFT;
> > > +}
> >
> > In the same vein as the previous email, please avoid mixing moves,
> > renames and new code as much as possible. This makes it quite hard to
> > follow what's going on.
> >
> > I think it would be better if you structure the series as follows:
> >
> > 1. Prep patches. Separate patches for moves, renames, new code.
> >
> > 3. mm: vswap
> >    - config VIRTUAL_SWAP
> >    - mm/vswap.c with skeleton data structures, init/exit, Makefile hook=
up
> >
> > 4. (temporarily) flatten existing address spaces
> >
> >    IMO you can do the swapcache and zswap in one patch
> >
> > 5+. conversion patches
> >
> >     Grow mm/vswap.c as you add discrete components like the descriptor
> >     allocator, swapoff locking, the swap_cgroup tracker etc.
> >
> >     You're mostly doing this part already. But try to order them by
> >     complexity and on a "core to periphery" gradient. I.e. swapoff
> >     locking should probably come before cgroup stuff.
> >
> > Insert move and rename patches at points where they make the most
> > sense. I.e. if they can be understood in the current upstream code
> > already, put them with step 1 prep patches. If you find a move or a
> > rename can only be understood in the context of one of the components,
> > put them in a prep patch right before that one.
>
> Makes sense, yeah! I'll try to avoid mixing moves/renames/new code as
> much as I can.
>
> >
> > > @@ -260,6 +269,28 @@ void delete_from_swap_cache(struct folio *folio)
> > >       folio_ref_sub(folio, folio_nr_pages(folio));
> > >  }
> > >
> > > +#ifdef CONFIG_VIRTUAL_SWAP
> > > +void clear_shadow_from_swap_cache(int type, unsigned long begin,
> > > +                             unsigned long end)
> > > +{
> > > +     swp_slot_t slot =3D swp_slot(type, begin);
> > > +     swp_entry_t entry =3D swp_slot_to_swp_entry(slot);
> > > +     unsigned long index =3D swap_cache_index(entry);
> > > +     struct address_space *address_space =3D swap_address_space(entr=
y);
> > > +     void *old;
> > > +     XA_STATE(xas, &address_space->i_pages, index);
> > > +
> > > +     xas_set_update(&xas, workingset_update_node);
> > > +
> > > +     xa_lock_irq(&address_space->i_pages);
> > > +     xas_for_each(&xas, old, entry.val + end - begin) {
> > > +             if (!xa_is_value(old))
> > > +                     continue;
> > > +             xas_store(&xas, NULL);
> > > +     }
> > > +     xa_unlock_irq(&address_space->i_pages);
> >
> > I don't think you need separate functions for this, init, exit etc. if
> > you tweak the macros to resolve to one tree. The current code already
> > works if swapfiles are smaller than SWAP_ADDRESS_SPACE_PAGES and there
> > is only one tree, after all.
>
> For clear_shadow_from_swap_cache(), I think I understand what you want
> - keep clear_shadow_from_swap_cache() the same for two
> implementations, but at caller sites, have the callers themselves
> determine the range in swap cache (i.e (begin, end)).
>
> I'm a bit confused with init and exit, but I assume there is a way to
> do it for them as well.
>
> I will note though, that it might increase the number of ifdefs
> sections (or alternatively, IS_ENABLED() checks), because these
> functions are called in different contexts for the two
> implementations:
>
> 1. init and exit are called in swapon/swapoff in the old
> implementation. They are called in swap initialization in the virtual
> swap implementation.
>
> 2. Similarly, we clear swap cache shadows when we free physical swap
> slots in the old implementation, and when we free virtual swap slots
> in the new implementation,
>
> I think it is good actually, because it makes the difference explicit
> rather than implicit. Also, it helps us know exactly which code block
> to target when we unify the two implementations :) Just putting it out
> there.

Actually, I think I was confused.

At this stage, we have no real difference in the implementations yet -
it's purely single tree vs multiple trees. So you're right - we
shouldn't even need two implementations of the code...

I'll fix this.

>
> >
> > This would save a lot of duplication and keep ifdefs more confined.

