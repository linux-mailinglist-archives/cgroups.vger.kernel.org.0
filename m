Return-Path: <cgroups+bounces-7732-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B28A974AE
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 20:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0823BCCF7
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 18:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A6C2980C2;
	Tue, 22 Apr 2025 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKF8n26K"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE66228541A;
	Tue, 22 Apr 2025 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745347851; cv=none; b=ScmWd+/HCFyo5+T+5kXdNKL8gXTbK/MMcLS45X9hkmm6kdGMEbedVvQE5dKy5Hejf1Vzee7H1ye2AYYgrfUhaHhiJn5vju3nQQKSeRohmhdowTH5zpY3bMO8KOABwgS+3tvIrBCf3s+AwS0otF/61Pg//5P854cE9EbZ7wBaSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745347851; c=relaxed/simple;
	bh=zf/I1OqVjKhOlwy28hqS9k0+xMjwj+ajq0soJSE4Q9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byefcf4yq5Rg+SZCFlGW1qZHC1wkfvRxV4Vj7FJY3FRHagyiEMXIdCOyEhrPR9FCnX00Yz5q5ljc2K1gvjc5N0DomJt8rp1QUZDIQPnHVLjnrCVsIHWZGqdBHsbABzF2VjqvjIsRlfFEwqVQSpPL9agH6zdbeddmz6beUYMlO8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKF8n26K; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54af20849bbso6055851e87.0;
        Tue, 22 Apr 2025 11:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745347848; x=1745952648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ik4wMhUz7DWmnlFro2ty1aoiaCrY7XiTZ8hSwwJ7ppI=;
        b=RKF8n26K0pq41y8WBKS51BCk5s4aVnn+w6Vbmb1daDmfK5uDETAabYcg4HCgq0+Irx
         bc+vyXvK7bNwmnAlpmJTYC+2sKV6jq8H/niNIYOxwad3phSAqBpPvTeYgM8a6tybMD+q
         pF90tRfhTfg489AMnf0uPy0E+jJq+pb3TWp5h77LDQnXs7WOxxFK2kfJaycLnVuk0/cI
         kG4iOyHQREJZE8LiSTa+upx+5XM8icS2X3/do6oPpdAMQ04BiFN74mg76l2i8r1DoQbP
         LwH3XqKlkObgs+FBpMKIt4K7A1FgiidRiJqk5gV2Qf9Yq2yBazOSvVTcGm05HNYIF9AF
         PvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745347848; x=1745952648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ik4wMhUz7DWmnlFro2ty1aoiaCrY7XiTZ8hSwwJ7ppI=;
        b=O/4bkaN8oSZgRpQuM6SKbagMUtRHI+CWRZJuXJcEhE78OdxlNMrQPKdFefwojOZKxC
         HdyXhS9hWm78EKzeMSw1oXUqMjZ892RdI44YKix/dJmQ7UTSU04r0Qmonqg3i5vyDr1d
         rYLXAE2NRHAD3WSwCZtZ0kt/rRXIghQXnVIdgvFFRpQFmNsMHwhXJYcGV/c4jONqGDcB
         vR35Y8urSovoopFOvc1tIzIG8Xeijtq82WbOyo+o8Nrn3QQnA3ELmMlEKDe/Hgm4E2Zg
         t/KUH3uWTiRhdXRqCEuWlcx56x9RdvwCk+W0LjMlS7Ojbkp/E0yb1/IJ4Qpoms0Y0GU7
         ATWg==
X-Forwarded-Encrypted: i=1; AJvYcCVFJMzluOpXRDmUcXZbUAWWJxU/IN+8tzGZkNeJ2Tbv1rxJhhZruKi08nQoEM54odydMg9H0cYb@vger.kernel.org, AJvYcCWhAT1moZgO5QMK7qJUI4e8boYyJoHELzn9+s8V8y3BAXSOC5RSMKZohJj8O0In6dPFTGQeCvu7wg7nEj82@vger.kernel.org, AJvYcCXFuI0n3U6uzT/Tq8EpCC9aiveUVxwSLKBazFEHQqMGG+jb8dRXg2m+IkQfrIVmPcPjD90M6LPcDF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznK36rxl65CiY+2eEW+P5nm8n1TJd+OINdzaK9DehMogSPqGfG
	PO5kzfCrwC0mOoI70UXWdsP3tFIeio0dzwXXKh9NTIeBTB5t1wP94G8QhTTKaV39yCOQKBVyTyw
	iCmsbpg+y3dRuEdWzSsIRzzZkdwA=
X-Gm-Gg: ASbGncvsffaoczMT4zq9Rj9l8q1LyLVYlYVyGk4ZBtIvqBVRwSZjJyVPxJMyP3LzHcg
	6VkUoLIEbfKHhAinQ00Q+R2XhivG2RkdKEbLiTnitPAzLowW7G6q9t7k3DiEZKPjFZ/d2Vazhu0
	5QjLB2KpzAyWGdcL/drYgAiw==
X-Google-Smtp-Source: AGHT+IFECvUxK/U/6K7wE1qIHI7cyjrKwKN10Zq6Tl5Y1zH18ONpTEa9mG5f0LF53kkT9psSYucYWpdLvLEmfUvl9B0=
X-Received: by 2002:a05:6512:3c87:b0:549:8924:2212 with SMTP id
 2adb3069b0e04-54d6e62c0damr5429654e87.17.1745347847305; Tue, 22 Apr 2025
 11:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407234223.1059191-1-nphamcs@gmail.com> <20250407234223.1059191-4-nphamcs@gmail.com>
 <20250408141555.GA816@cmpxchg.org> <6807ab09.670a0220.152ca3.502fSMTPIN_ADDED_BROKEN@mx.google.com>
 <CAKEwX=Mjx4LYe60ErJasFofkq-uH_R9R0TZD9ROdN1vn4V=Yjw@mail.gmail.com>
In-Reply-To: <CAKEwX=Mjx4LYe60ErJasFofkq-uH_R9R0TZD9ROdN1vn4V=Yjw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 23 Apr 2025 02:50:29 +0800
X-Gm-Features: ATxdqUGmNlJy_pbW-0fTae4V13peiJz7II-wVjd0eabDB5V7Nz6eDeyVg6cui1w
Message-ID: <CAMgjq7BNP9PbvuQSLH90dhb1vUtbA7nVHw5TGJxXDfzpmWfbVQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/14] mm: swap: add a separate type for physical swap slots
To: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, hughd@google.com, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	len.brown@intel.com, chengming.zhou@linux.dev, chrisl@kernel.org, 
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com, viro@zeniv.linux.org.uk, 
	baohua@kernel.org, osalvador@suse.de, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 11:51=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Tue, Apr 22, 2025 at 7:43=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.de=
v> wrote:
> >
> > On Tue, Apr 08, 2025 at 10:15:55AM -0400, Johannes Weiner wrote:
> > > On Mon, Apr 07, 2025 at 04:42:04PM -0700, Nhat Pham wrote:
> > > > In preparation for swap virtualization, add a new type to represent=
 the
> > > > physical swap slots of swapfile. This allows us to separates:
> > > >
> > > > 1. The logical view of the swap entry (i.e what is stored in page t=
able
> > > >    entries and used to index into the swap cache), represented by t=
he
> > > >    old swp_entry_t type.
> > > >
> > > > from:
> > > >
> > > > 2. Its physical backing state (i.e the actual backing slot on the s=
wap
> > > >    device), represented by the new swp_slot_t type.
> > > >
> > > > The functions that operate at the physical level (i.e on the swp_sl=
ot_t
> > > > types) are also renamed where appropriate (prefixed with swp_slot_*=
 for
> > > > e.g). We also take this opportunity to re-arrange the header files
> > > > (include/linux/swap.h and swapops.h), grouping the swap API into th=
e
> > > > following categories:
> > > >
> > > > 1. Virtual swap API (i.e functions on swp_entry_t type).
> > > >
> > > > 2. Swap cache API (mm/swap_state.c)
> > > >
> > > > 3. Swap slot cache API (mm/swap_slots.c)
> > > >
> > > > 4. Physical swap slots and device API (mm/swapfile.c).
> > >
> > > This all makes sense.
> > >
> > > However,
> > >
> > > > @@ -483,50 +503,37 @@ static inline long get_nr_swap_pages(void)
> > > >     return atomic_long_read(&nr_swap_pages);
> > > >  }
> > > >
> > > > -extern void si_swapinfo(struct sysinfo *);
> > > > -swp_entry_t folio_alloc_swap(struct folio *folio);
> > > > -bool folio_free_swap(struct folio *folio);
> > > > -void put_swap_folio(struct folio *folio, swp_entry_t entry);
> > > > -extern swp_entry_t get_swap_page_of_type(int);
> > > > -extern int get_swap_pages(int n, swp_entry_t swp_entries[], int or=
der);
> > > > -extern int add_swap_count_continuation(swp_entry_t, gfp_t);
> > > > -extern void swap_shmem_alloc(swp_entry_t, int);
> > > > -extern int swap_duplicate(swp_entry_t);
> > > > -extern int swapcache_prepare(swp_entry_t entry, int nr);
> > > > -extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> > > > -extern void swapcache_free_entries(swp_entry_t *entries, int n);
> > > > -extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> > > > +void si_swapinfo(struct sysinfo *);
> > > > +swp_slot_t swap_slot_alloc_of_type(int);
> > > > +int swap_slot_alloc(int n, swp_slot_t swp_slots[], int order);
> > > > +void swap_slot_free_nr(swp_slot_t slot, int nr_pages);
> > > > +void swap_slot_cache_free_slots(swp_slot_t *slots, int n);
> > > >  int swap_type_of(dev_t device, sector_t offset);
> > > > +sector_t swapdev_block(int, pgoff_t);
> > > >  int find_first_swap(dev_t *device);
> > > > -extern unsigned int count_swap_pages(int, int);
> > > > -extern sector_t swapdev_block(int, pgoff_t);
> > > > -extern int __swap_count(swp_entry_t entry);
> > > > -extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t=
 entry);
> > > > -extern int swp_swapcount(swp_entry_t entry);
> > > > -struct swap_info_struct *swp_swap_info(swp_entry_t entry);
> > > > +unsigned int count_swap_pages(int, int);
> > > > +struct swap_info_struct *swap_slot_swap_info(swp_slot_t slot);
> > > >  struct backing_dev_info;
> > > > -extern int init_swap_address_space(unsigned int type, unsigned lon=
g nr_pages);
> > > > -extern void exit_swap_address_space(unsigned int type);
> > > > -extern struct swap_info_struct *get_swap_device(swp_entry_t entry)=
;
> > > > +struct swap_info_struct *swap_slot_tryget_swap_info(swp_slot_t slo=
t);
> > > >  sector_t swap_folio_sector(struct folio *folio);
> > >
> > > this is difficult to review.
> > >
> > > Can you please split out:
> > >
> > > 1. Code moves / cut-and-paste
> > >
> > > 2. Renames
> > >
> > > 3. New code
> > >
> > > into three separate steps
> >
> > +1, I agree with the fundamental change (and is something that I
> > attempted before), but it's really difficult to parse :)
> >
> > Also, weren't the swap slots scheduled for removal or is my brain makin=
g
> > stuff up again?
>
> You mean the swap slot cache? That's the one Kairui wants to remove (I
> think he removed a huge chunk of it already).

Right, I wanted to remove it to simplify the code and it is already complet=
ely
gone now, see 0ff67f990bd45726e0d9e91111d998e7a3595b32, it's in 6.14

And the whole HAS_CACHE pinning thing will be gone too after the swap
table series if it went smoothly.

My bad, the series I promoted is still not posted yet :(, which is not
as I planned... encountered several mysterious WARNs testing with
the mm-unstable, some are related to swap table and recent
unstable changes, so spent quite some time checking other
components and revisiting the series for better debugging
and sanity checks.

Good thing is there seems to be no more blocking issues now.

