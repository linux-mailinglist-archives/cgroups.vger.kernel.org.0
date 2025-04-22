Return-Path: <cgroups+bounces-7726-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B92A1A9719E
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 17:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FA1189C918
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 15:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5803C28FFDF;
	Tue, 22 Apr 2025 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmdIEcHy"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6B4290082;
	Tue, 22 Apr 2025 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337060; cv=none; b=V5GGAAzXkuf6E0mIfBy5wx9UsAL9cuPvteAbf/Uok55PbsXVXHJyE2zW5UVHdjQsRwKa/vz6vILahYlvArLCqPC5bxxroIrvj9zjLcQQNmQAwppeOX0m0UiQtoDqGknG18Lf9O2V+YB6c4LtVCKQQE82LI8+Jkogln1WNlZSGWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337060; c=relaxed/simple;
	bh=/dt0p1OzuOjf3abs0q6cnVxY9+yEPKqJWonGL82r5pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESWIMXqdPPbwNbUwf7Km9e8ZhPtObmxwCRmC5ed4uxdeXcF5TfQ3mLuwrk8QYgx3jtV+fjMSqDbKeS7QsLZOvQdvSWSF26FFFIXBhZucf3b29eJTarqg+BCFPW2rPGzcs3SQ35S9cQujt49tjh+1rSml9iefm3VC2ZAycgJLdeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmdIEcHy; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8f94c2698so25889706d6.0;
        Tue, 22 Apr 2025 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745337057; x=1745941857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oowU4ubiAR+sY0xZ++0AHuDMpFQG52efmVb/Y2eNfo=;
        b=fmdIEcHyU8tzsPPSCRp4mbY5iq3Z3PvFYhyHPKIJYeoCf8yn+mIy/ljxqhKQtpK8nQ
         mcE9qRR0x6B8vC65eXjHIDiYS3m1x3W89FVqSAwHEWznjv1Tw+T0thnKYJ3aHTTuKyWA
         McEfW36z7PBt7pBFkyn7puL13AStGRTJVzju5J7K/AG3XrfJFq9rK9kvdhI36W6oRbbQ
         TsGC6Zo9WM5hti9H+nhQd/rHmLAqot3nRM5Xos6qwyTi4EORnDI4NU68HQfarrK/gLps
         ufqhFpBP9F8AEYCvgt07KfiYGgkFj62P/BFCynauWaF/3UJihrzjQDqs8z9wnD0QksSK
         iTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337057; x=1745941857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oowU4ubiAR+sY0xZ++0AHuDMpFQG52efmVb/Y2eNfo=;
        b=YGWjVebtefQMwm+39RHuPc7vQ06lqjnX5+JVZ+gHbq8JvxfMlfGvNauV8Gs8qosaNs
         HH0tc8G+BRGc8JFTrdkAvybcr7mCzHpZigzS9aTkqomUr5RU3hSN153vj6+D5PXuo0/9
         2jW07xGSrBhx1fVSi88vum7bzyfqY3FA0q/Vrv4reYWHNNtrueWhJCzrFiv2bWqeKJJk
         VYLc+a66QUR3lclCoMvVDxv7qWQ2QYb5hG2NY32LclWZtWOwRGIzXe9uysRUNPJ6OeuK
         ZLyrmvZMvk3WSmEgXlM2LVPRTxboQhySVYQPDTkRKHQyJLRBFK6d7miX/UHdi5ZduGOp
         JKOg==
X-Forwarded-Encrypted: i=1; AJvYcCUX1IppSegkLm6AA8D8w7BK6ItUYqhw65N1o4iaxvhGdTg7l6zKivwrQFJeuTJf1c2GrCGW1eknXgY=@vger.kernel.org, AJvYcCUY9RQG+HtvZG7ePvpVuFD4gv9B3ZaoVGAVn8j9DGMSveP8hG/arG1vijp+Szqyl90mbBz9tnNAfd3cyMkQ@vger.kernel.org, AJvYcCVuudZD7SAlmWaLAvmULwp/RLBEtm1kReLeYs0DYtuXOKudGTSEy5dw5ssv2U2FoaBZH96c8Q1X@vger.kernel.org
X-Gm-Message-State: AOJu0YxHIB5crUSt5XMmCdAYfnqpH5qYSMKlc/EF1fa08r/sueHLVzb2
	a0aq/1NLHKZvZeDqzjj4OOa0fBMr2akbIrm+sA7PAcm3+R47RZBJpP9aLb9Tywk30p+swEKSIft
	qyLGayNTwqDNs1npzWSqHtCaFF6c=
X-Gm-Gg: ASbGnctHSwjsiSAfQxGJI8ak/HnsFHsKol7qWwKEAccU4Jp9bi6L4d+/JhxrQ2rROIf
	xiRNRpswg8rGZ45gnveLAA1UVVKK0G/7EFxDkaTCDxcyeqtAljUral129mme21X2ecrEP80Fm5E
	tVW5PtyhnvfT2Cx3PTQZKBmQ4=
X-Google-Smtp-Source: AGHT+IFTQJvOfea+03HAmL9GIosZ3IA3k3+2rYzqUw2jPSNa10A/2r2nDWdPOvptn58dV5riuFvJ00P+D2mvRKAx7Is=
X-Received: by 2002:a05:6214:262c:b0:6e6:5d61:4f01 with SMTP id
 6a1803df08f44-6f2c45125a4mr324053346d6.8.1745337056905; Tue, 22 Apr 2025
 08:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407234223.1059191-1-nphamcs@gmail.com> <20250407234223.1059191-4-nphamcs@gmail.com>
 <20250408141555.GA816@cmpxchg.org> <6807ab09.670a0220.152ca3.502fSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <6807ab09.670a0220.152ca3.502fSMTPIN_ADDED_BROKEN@mx.google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 22 Apr 2025 08:50:46 -0700
X-Gm-Features: ATxdqUETwwP-bJUx8AP5nTAO6LFG9MhYiOS8p8tUjdEza2vLaCtWajTH1zIUKgY
Message-ID: <CAKEwX=Mjx4LYe60ErJasFofkq-uH_R9R0TZD9ROdN1vn4V=Yjw@mail.gmail.com>
Subject: Re: [RFC PATCH 03/14] mm: swap: add a separate type for physical swap slots
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	hughd@google.com, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, len.brown@intel.com, 
	chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org, 
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com, viro@zeniv.linux.org.uk, 
	baohua@kernel.org, osalvador@suse.de, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 7:43=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Tue, Apr 08, 2025 at 10:15:55AM -0400, Johannes Weiner wrote:
> > On Mon, Apr 07, 2025 at 04:42:04PM -0700, Nhat Pham wrote:
> > > In preparation for swap virtualization, add a new type to represent t=
he
> > > physical swap slots of swapfile. This allows us to separates:
> > >
> > > 1. The logical view of the swap entry (i.e what is stored in page tab=
le
> > >    entries and used to index into the swap cache), represented by the
> > >    old swp_entry_t type.
> > >
> > > from:
> > >
> > > 2. Its physical backing state (i.e the actual backing slot on the swa=
p
> > >    device), represented by the new swp_slot_t type.
> > >
> > > The functions that operate at the physical level (i.e on the swp_slot=
_t
> > > types) are also renamed where appropriate (prefixed with swp_slot_* f=
or
> > > e.g). We also take this opportunity to re-arrange the header files
> > > (include/linux/swap.h and swapops.h), grouping the swap API into the
> > > following categories:
> > >
> > > 1. Virtual swap API (i.e functions on swp_entry_t type).
> > >
> > > 2. Swap cache API (mm/swap_state.c)
> > >
> > > 3. Swap slot cache API (mm/swap_slots.c)
> > >
> > > 4. Physical swap slots and device API (mm/swapfile.c).
> >
> > This all makes sense.
> >
> > However,
> >
> > > @@ -483,50 +503,37 @@ static inline long get_nr_swap_pages(void)
> > >     return atomic_long_read(&nr_swap_pages);
> > >  }
> > >
> > > -extern void si_swapinfo(struct sysinfo *);
> > > -swp_entry_t folio_alloc_swap(struct folio *folio);
> > > -bool folio_free_swap(struct folio *folio);
> > > -void put_swap_folio(struct folio *folio, swp_entry_t entry);
> > > -extern swp_entry_t get_swap_page_of_type(int);
> > > -extern int get_swap_pages(int n, swp_entry_t swp_entries[], int orde=
r);
> > > -extern int add_swap_count_continuation(swp_entry_t, gfp_t);
> > > -extern void swap_shmem_alloc(swp_entry_t, int);
> > > -extern int swap_duplicate(swp_entry_t);
> > > -extern int swapcache_prepare(swp_entry_t entry, int nr);
> > > -extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> > > -extern void swapcache_free_entries(swp_entry_t *entries, int n);
> > > -extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> > > +void si_swapinfo(struct sysinfo *);
> > > +swp_slot_t swap_slot_alloc_of_type(int);
> > > +int swap_slot_alloc(int n, swp_slot_t swp_slots[], int order);
> > > +void swap_slot_free_nr(swp_slot_t slot, int nr_pages);
> > > +void swap_slot_cache_free_slots(swp_slot_t *slots, int n);
> > >  int swap_type_of(dev_t device, sector_t offset);
> > > +sector_t swapdev_block(int, pgoff_t);
> > >  int find_first_swap(dev_t *device);
> > > -extern unsigned int count_swap_pages(int, int);
> > > -extern sector_t swapdev_block(int, pgoff_t);
> > > -extern int __swap_count(swp_entry_t entry);
> > > -extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t e=
ntry);
> > > -extern int swp_swapcount(swp_entry_t entry);
> > > -struct swap_info_struct *swp_swap_info(swp_entry_t entry);
> > > +unsigned int count_swap_pages(int, int);
> > > +struct swap_info_struct *swap_slot_swap_info(swp_slot_t slot);
> > >  struct backing_dev_info;
> > > -extern int init_swap_address_space(unsigned int type, unsigned long =
nr_pages);
> > > -extern void exit_swap_address_space(unsigned int type);
> > > -extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
> > > +struct swap_info_struct *swap_slot_tryget_swap_info(swp_slot_t slot)=
;
> > >  sector_t swap_folio_sector(struct folio *folio);
> >
> > this is difficult to review.
> >
> > Can you please split out:
> >
> > 1. Code moves / cut-and-paste
> >
> > 2. Renames
> >
> > 3. New code
> >
> > into three separate steps
>
> +1, I agree with the fundamental change (and is something that I
> attempted before), but it's really difficult to parse :)
>
> Also, weren't the swap slots scheduled for removal or is my brain making
> stuff up again?

You mean the swap slot cache? That's the one Kairui wants to remove (I
think he removed a huge chunk of it already).

This "swap slot" is basically just a new type I introduced to separate
the physical and virtual swap types.

>

