Return-Path: <cgroups+bounces-7425-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2E0A80F26
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 17:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC9319E6514
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 15:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDDB22370C;
	Tue,  8 Apr 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="NtMkXn6Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914DA1DF252
	for <cgroups@vger.kernel.org>; Tue,  8 Apr 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124439; cv=none; b=DLaVFiJ2E5kfvjQASmwQ0c4mEkYH3J4cOVHlcUIc5mEqKcT0EpNpwBlw0JEk2Si19x26cRP9/F8a9kqbRd3jQdsRRxaMT8yS3Cg4ZTdseA3FmOegDpzAIsGktvdnEoeMRxndYCAykzzElA4f3rleR9GTRFLJWNVTxD0tiDxcD0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124439; c=relaxed/simple;
	bh=p/PzL0lY97r0zZWWojJbCACzIyLA8XnwuAilw+dmSfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odEkIVxzPvrsQrG6NRHsDAQwXG+TdRfz5SCFcqK6LkRRa0a1itbRLERd4VRXLAtaYJxsXxq899gYmBPcSMOnvm21AKIV4kY2MeqSafupDxW9ipfrIfnGxIcNx6sLFK4uko/4KvuclRc/foBqHkA0psmZJVYA/y3jtYiQTuTiHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=NtMkXn6Y; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-60402c94319so2791376eaf.1
        for <cgroups@vger.kernel.org>; Tue, 08 Apr 2025 08:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744124435; x=1744729235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQd2HuYVMB2uA19lAP4G3r1tUf16qS+73yi0Zu+QUgU=;
        b=NtMkXn6Yg8RKgbnpBhItrNjn9cia7eFnx+D66EWSRD2SaCf4xMnAjuRXkbBl1bfBPf
         0A6t9+ta9sFfz8XfzizymzRCHy60ORaT03C5gAViNVAL7LfG0COWuCp62z0m76f91DWm
         BJEJJoKADiWV5OWZ9OOiUfraywre01OfGTUUfcp9JSRbEdz+IUT3JGZS9bTpQHfV79ZD
         1nPkJWfWdEiq/1izj4p1qLrQ0BFSqZ0YF4AjIXz3yBlSIuLizHde0vyI0uLl994adpvO
         IcFqaQ63QqCuiOWN30ZkFo+EcI+FQDu0VBMx8gKWoVzceXuff1zzDiCdqANJTYJkfnVm
         Lvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744124435; x=1744729235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQd2HuYVMB2uA19lAP4G3r1tUf16qS+73yi0Zu+QUgU=;
        b=SLk3IzRAvv78+E+rOZzYZJC+bqsyHICyudn1JewxsRHGf4lKMKn/C0UDR4vdG26dQc
         SzOsNidzUxZdGozXmjjPVtMLV1RLdEkWHpedy5fquF0m4XxB1YI7mwdzVXLUvH8CEJGK
         TABJ5jRcwcf5yeSYnq2PPRaAhaCkt/nwBLlpk7pe5rILWoasTSjzGVvzqiduRwZ+20Hz
         1/hLa+KByQ9LUDxoBtYDw58J6eQpxT5iXaekG26wSuoO3+NhsbiagjM6evehQNWwz7J+
         9u04cuqr1el4mLFkEISg0iLsqX65Ml42NTHaJnWj7zdtm83rJNha7HiEA8RimLelKudp
         hbIA==
X-Forwarded-Encrypted: i=1; AJvYcCUZutdoKfby3gH5SveNxpj5IWpNd8/BYRVKuf8L5kGyt7f65AJQHcmyyW8fSMSmi+uCthcS4ygn@vger.kernel.org
X-Gm-Message-State: AOJu0Yydqv4ZqD4W07JvwRf6SlOk2qlaE23De1akPwUjIp9o7qysHZIs
	7qr7wmjuI61eV4TMPbzP0S+jjuZjAkap7VDz6rbvGM0XlzbOE1pY3Ie8FoN5xZPsMTJmXIF2TGA
	b
X-Gm-Gg: ASbGnctMgjuNGLqagy5y2jzCYfGLid1bbjV4AWojmcK9jOBJ7mNxwxrKRauFs4nzJAL
	ZvK43faS64nAUibTWJfMBDDmyjSyLSA7RIXrv+JNFCWHOiN6HoM5W+F5bU7QARv2vwvRG4LC3B5
	Ht8lBsRW9UbxqzXHQK0iJHoKpZOyap+Lwixr4rUEjJhOCQasZekt5rnq6et33Zpvudi8YdiITqj
	dSZ3CEvhkep//HA0ztQ+VZQisedAe4LX4bFu7qjRctKtqoldqN7upu0cZq3gNQQ3+2ntwj9eHLk
	J/xaAjR0Yy6P/lgyHygoPO3WVjj/Isx3K8QRhKgghk0=
X-Google-Smtp-Source: AGHT+IHoaiiimay/jkn42/i4mLcJ/qG34wLV5JJdRiDmu8nloHtzgfEmtFoYsMdVM1i1HbahBBGarQ==
X-Received: by 2002:a05:620a:d8c:b0:7c5:5d9b:b617 with SMTP id af79cd13be357-7c774d531e4mr2153900785a.23.1744124424489;
        Tue, 08 Apr 2025 08:00:24 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c76e7354a3sm770574985a.10.2025.04.08.08.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:00:23 -0700 (PDT)
Date: Tue, 8 Apr 2025 11:00:19 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hughd@google.com,
	yosry.ahmed@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk, baohua@kernel.org, osalvador@suse.de,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu,
	pavel@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 04/14] mm: swap: swap cache support for virtualized
 swap
Message-ID: <20250408150019.GB816@cmpxchg.org>
References: <20250407234223.1059191-1-nphamcs@gmail.com>
 <20250407234223.1059191-5-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407234223.1059191-5-nphamcs@gmail.com>

On Mon, Apr 07, 2025 at 04:42:05PM -0700, Nhat Pham wrote:
> Currently, the swap cache code assumes that the swap space is of a fixed
> size. The virtual swap space is dynamically sized, so the existing
> partitioning code cannot be easily reused.  A dynamic partitioning is
> planned, but for now keep the design simple and just use a flat
> swapcache for vswap.
> 
> Since the vswap's implementation has begun to diverge from the old
> implementation, we also introduce a new build config
> (CONFIG_VIRTUAL_SWAP). Users who do not select this config will get the
> old implementation, with no behavioral change.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/Kconfig      | 13 ++++++++++
>  mm/swap.h       | 22 ++++++++++------
>  mm/swap_state.c | 68 +++++++++++++++++++++++++++++++++++++++++--------
>  3 files changed, 85 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 1b501db06417..1a6acdb64333 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -22,6 +22,19 @@ menuconfig SWAP
>  	  used to provide more virtual memory than the actual RAM present
>  	  in your computer.  If unsure say Y.
>  
> +config VIRTUAL_SWAP
> +	bool "Swap space virtualization"
> +	depends on SWAP
> +	default n
> +	help
> +		When this is selected, the kernel is built with the new swap
> +		design. This will allow us to decouple the swap backends
> +		(zswap, on-disk swapfile, etc.), and save disk space when we
> +		use zswap (or the zero-filled swap page optimization).
> +
> +		There might be more lock contentions with heavy swap use, since
> +		the swap cache is no longer range partitioned.
> +
>  config ZSWAP
>  	bool "Compressed cache for swap pages"
>  	depends on SWAP
> diff --git a/mm/swap.h b/mm/swap.h
> index d5f8effa8015..06e20b1d79c4 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -22,22 +22,27 @@ void swap_write_unplug(struct swap_iocb *sio);
>  int swap_writepage(struct page *page, struct writeback_control *wbc);
>  void __swap_writepage(struct folio *folio, struct writeback_control *wbc);
>  
> -/* linux/mm/swap_state.c */
> -/* One swap address space for each 64M swap space */
> +/* Return the swap device position of the swap slot. */
> +static inline loff_t swap_slot_pos(swp_slot_t slot)
> +{
> +	return ((loff_t)swp_slot_offset(slot)) << PAGE_SHIFT;
> +}

In the same vein as the previous email, please avoid mixing moves,
renames and new code as much as possible. This makes it quite hard to
follow what's going on.

I think it would be better if you structure the series as follows:

1. Prep patches. Separate patches for moves, renames, new code.

3. mm: vswap
   - config VIRTUAL_SWAP
   - mm/vswap.c with skeleton data structures, init/exit, Makefile hookup

4. (temporarily) flatten existing address spaces

   IMO you can do the swapcache and zswap in one patch

5+. conversion patches

    Grow mm/vswap.c as you add discrete components like the descriptor
    allocator, swapoff locking, the swap_cgroup tracker etc.

    You're mostly doing this part already. But try to order them by
    complexity and on a "core to periphery" gradient. I.e. swapoff
    locking should probably come before cgroup stuff.

Insert move and rename patches at points where they make the most
sense. I.e. if they can be understood in the current upstream code
already, put them with step 1 prep patches. If you find a move or a
rename can only be understood in the context of one of the components,
put them in a prep patch right before that one.

> @@ -260,6 +269,28 @@ void delete_from_swap_cache(struct folio *folio)
>  	folio_ref_sub(folio, folio_nr_pages(folio));
>  }
>  
> +#ifdef CONFIG_VIRTUAL_SWAP
> +void clear_shadow_from_swap_cache(int type, unsigned long begin,
> +				unsigned long end)
> +{
> +	swp_slot_t slot = swp_slot(type, begin);
> +	swp_entry_t entry = swp_slot_to_swp_entry(slot);
> +	unsigned long index = swap_cache_index(entry);
> +	struct address_space *address_space = swap_address_space(entry);
> +	void *old;
> +	XA_STATE(xas, &address_space->i_pages, index);
> +
> +	xas_set_update(&xas, workingset_update_node);
> +
> +	xa_lock_irq(&address_space->i_pages);
> +	xas_for_each(&xas, old, entry.val + end - begin) {
> +		if (!xa_is_value(old))
> +			continue;
> +		xas_store(&xas, NULL);
> +	}
> +	xa_unlock_irq(&address_space->i_pages);

I don't think you need separate functions for this, init, exit etc. if
you tweak the macros to resolve to one tree. The current code already
works if swapfiles are smaller than SWAP_ADDRESS_SPACE_PAGES and there
is only one tree, after all.

This would save a lot of duplication and keep ifdefs more confined.

