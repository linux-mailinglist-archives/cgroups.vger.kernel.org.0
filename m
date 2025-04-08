Return-Path: <cgroups+bounces-7426-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50086A80F8A
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 17:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20FD8A4B22
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 15:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EF5228CBE;
	Tue,  8 Apr 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8qNatti"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86F6227E96;
	Tue,  8 Apr 2025 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125095; cv=none; b=EgEPmK5ijGlwgnvJfkDV97PlHSP2E4y9qPHAKZWuh9MhAOjcaCBGvaZkR4T9I89cwc5UUcITzDmBYZ+HxFozxWxIt1Ei3d0c04FENFYcSm539Sr3f0UFT28lCOeo688B0Eam7ekldPzPJ80q0fYUXtiGdJhCIAuMnQpqc96fcwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125095; c=relaxed/simple;
	bh=iAge/TCQFEQxz188bugCjBSt7K57C1F/d/6gwLwpoCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJLp85aK0h689+UOfgdFIgBK5CcMJMeu/6rD8r6n0VDAaWML2lzEQ1tVi460GPhLtSn2sjzOVe6B0UgapyBcGeO2ylLRalvDSl2WWBPJQ56zcA8M1yfkponcafROHBJNFC1gHassCrvEAEtcFDxZdSXJm/PTN3WrkcDz+1X/Iaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8qNatti; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8fb83e137so51574916d6.0;
        Tue, 08 Apr 2025 08:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744125092; x=1744729892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi2eBmkzJiBdyrJlnjIzeZPmXlpwSuN6LV/0MwZZJQk=;
        b=U8qNatti0qrsZHGCzmGv6ql/rwWpZHtmzA50WAQ4421wkZqGdyl9JFha6twjgSdiEG
         h8qJ7vSvKoJUev+0rWt626i6ltKZ6FOpeC8LbxDs3KkGoe/vzid+N6ZelIGKBnpa+z6n
         QAvRiPiU6AakIk/1FC+3p4BlbSalFX96U97oBSejJFNGfJ1QT8xfDvCtFUgtny0FJc95
         hKKDD8JuX5uJwbiddRTt6MgLn2FvMZs2Ur0vNxJrquSiSDxpuAkTzjOK6YLPjMKwF06+
         +E5a1ZyY3S9sEJHaAXglWAcRzdvWRU9nYcTj18+utn2yWrMaTJtg17v2DecgkOjG63HU
         8+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744125092; x=1744729892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fi2eBmkzJiBdyrJlnjIzeZPmXlpwSuN6LV/0MwZZJQk=;
        b=LxLsFkSxYHTEZugp/ZEBiX0aESm/JpGC1UmfAqvNuxWX+BcUwvhz5lxx2o9L8wpvPT
         0tQgQRuYU5HYJBQR51f+CNAKh2wXx1ch8XbPfWmi6MhfkuiPFTEUSDOn4yqdUW91fSzK
         5BdyU1TfYSFgz//yxT/LQ5TjhaHvbWUq2PMucEdy1fB7sM1FWuFyJyNa1PGYs13LhCbC
         x283g+svvqcjCr5k2nfv4XeDb/Y6renZJM2GBBj8GkhrnPO40/T4C1bkE1XB2IxPakdC
         P+Ae9D458BhmnZhK3FsT2W/mJEuyZuuPIbhWqL/49D7mBzrQoC5TfLqBOt6WOQZhkk7I
         dNig==
X-Forwarded-Encrypted: i=1; AJvYcCUPO2hqRq8/gq78clrLHCRTU7TGV0AFGMxRHg3G4fHWJ1th4Pgpvdmi7tdFJRNujO65MdxPAQn00+g=@vger.kernel.org, AJvYcCUai74JV9RYvmbGBvBde2a552mywVKtTQG6evmmmtxKtvghgwPC4OZbzC1oMJRzwORwfphl4nte@vger.kernel.org, AJvYcCVbkomYQ75rcuU+sLmelldOPEtgYDrVA3VS9J8mMwmM2H2pLLWBYMVYp0Gc9IAYwHuyb7CJcUnMcUzPbpr/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxugec4ui2UqWqTxjUgU2vsEwZHvyTg9GgRy8bQ/0/I2xJpjyYz
	MfDnd9NzBjA/qwVZzG5VJY27e8FCFsNx3PxDpeOVDM6tRAo4cAO8uB8LDQhtBykuZy+gnbjGDFR
	BpTgwNUmjysVlk6oXLvEc2EltIf4=
X-Gm-Gg: ASbGncsCb4EpquGEroieiB8VLfKetR+0MsGNBf+N/KZ3xQf8dzc/eo+sW/T8EPCu/5o
	fQgln+2GnpLXpqYGExbChNVXLyFPwrKe2vV1LQiVxuI5Tz46SSOzhoN4gqA3ZPpw/lvcE5UUcg3
	4RcMQ80v1kHv+fQ2v5cu+MrU2JwLlr7NOtXfUWf3N2KwcSigOIRkFxLsqjpw==
X-Google-Smtp-Source: AGHT+IEBzzayKvqC39EUgHVBWtu/wY1YXqZBYY6cBaTXuY1bD1506pK2P8WVCfFC0SJvQwUENGg3TY07BxlZ30qZMmY=
X-Received: by 2002:a05:6214:20a1:b0:6ed:df6:cdcd with SMTP id
 6a1803df08f44-6f0b749934amr221872706d6.21.1744125092487; Tue, 08 Apr 2025
 08:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407234223.1059191-1-nphamcs@gmail.com> <20250407234223.1059191-4-nphamcs@gmail.com>
 <20250408141555.GA816@cmpxchg.org>
In-Reply-To: <20250408141555.GA816@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 8 Apr 2025 08:11:21 -0700
X-Gm-Features: ATxdqUHmaTfVyV2I-0EHfU2y-rKG2ACn3QSFVY1QEBvNDfhELczRDQ5ahbXOhYE
Message-ID: <CAKEwX=PSK-f0mK=Ffsvqs72qicPAoUWW-MdcNurj4PO0NMuJ3w@mail.gmail.com>
Subject: Re: [RFC PATCH 03/14] mm: swap: add a separate type for physical swap slots
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

On Tue, Apr 8, 2025 at 7:16=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Mon, Apr 07, 2025 at 04:42:04PM -0700, Nhat Pham wrote:
> > In preparation for swap virtualization, add a new type to represent the
> > physical swap slots of swapfile. This allows us to separates:
> >
> > 1. The logical view of the swap entry (i.e what is stored in page table
> >    entries and used to index into the swap cache), represented by the
> >    old swp_entry_t type.
> >
> > from:
> >
> > 2. Its physical backing state (i.e the actual backing slot on the swap
> >    device), represented by the new swp_slot_t type.
> >
> > The functions that operate at the physical level (i.e on the swp_slot_t
> > types) are also renamed where appropriate (prefixed with swp_slot_* for
> > e.g). We also take this opportunity to re-arrange the header files
> > (include/linux/swap.h and swapops.h), grouping the swap API into the
> > following categories:
> >
> > 1. Virtual swap API (i.e functions on swp_entry_t type).
> >
> > 2. Swap cache API (mm/swap_state.c)
> >
> > 3. Swap slot cache API (mm/swap_slots.c)
> >
> > 4. Physical swap slots and device API (mm/swapfile.c).
>
> This all makes sense.
>
> However,
>
> > @@ -483,50 +503,37 @@ static inline long get_nr_swap_pages(void)
> >       return atomic_long_read(&nr_swap_pages);
> >  }
> >
> > -extern void si_swapinfo(struct sysinfo *);
> > -swp_entry_t folio_alloc_swap(struct folio *folio);
> > -bool folio_free_swap(struct folio *folio);
> > -void put_swap_folio(struct folio *folio, swp_entry_t entry);
> > -extern swp_entry_t get_swap_page_of_type(int);
> > -extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order)=
;
> > -extern int add_swap_count_continuation(swp_entry_t, gfp_t);
> > -extern void swap_shmem_alloc(swp_entry_t, int);
> > -extern int swap_duplicate(swp_entry_t);
> > -extern int swapcache_prepare(swp_entry_t entry, int nr);
> > -extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> > -extern void swapcache_free_entries(swp_entry_t *entries, int n);
> > -extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> > +void si_swapinfo(struct sysinfo *);
> > +swp_slot_t swap_slot_alloc_of_type(int);
> > +int swap_slot_alloc(int n, swp_slot_t swp_slots[], int order);
> > +void swap_slot_free_nr(swp_slot_t slot, int nr_pages);
> > +void swap_slot_cache_free_slots(swp_slot_t *slots, int n);
> >  int swap_type_of(dev_t device, sector_t offset);
> > +sector_t swapdev_block(int, pgoff_t);
> >  int find_first_swap(dev_t *device);
> > -extern unsigned int count_swap_pages(int, int);
> > -extern sector_t swapdev_block(int, pgoff_t);
> > -extern int __swap_count(swp_entry_t entry);
> > -extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t ent=
ry);
> > -extern int swp_swapcount(swp_entry_t entry);
> > -struct swap_info_struct *swp_swap_info(swp_entry_t entry);
> > +unsigned int count_swap_pages(int, int);
> > +struct swap_info_struct *swap_slot_swap_info(swp_slot_t slot);
> >  struct backing_dev_info;
> > -extern int init_swap_address_space(unsigned int type, unsigned long nr=
_pages);
> > -extern void exit_swap_address_space(unsigned int type);
> > -extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
> > +struct swap_info_struct *swap_slot_tryget_swap_info(swp_slot_t slot);
> >  sector_t swap_folio_sector(struct folio *folio);
>
> this is difficult to review.
>
> Can you please split out:
>
> 1. Code moves / cut-and-paste
>
> 2. Renames
>
> 3. New code
>
> into three separate steps

Makes sense, yeah.

I will reorganize the series as follows:

1. Rearrange in the first patch (which I already did for
mm/swapfile.c, but now I'll also rearrange the functions in header
files as well).
2. One more patch to rename the function and add the new type.
3. The rest of the series (new API, new code, etc.).

