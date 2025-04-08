Return-Path: <cgroups+bounces-7424-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AC1A80DA6
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 16:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822E74A2CC5
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216AC1DB958;
	Tue,  8 Apr 2025 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="wsEX/Wc9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDD91D7998
	for <cgroups@vger.kernel.org>; Tue,  8 Apr 2025 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744121764; cv=none; b=sQAkpveUnhnV0SWwyJRpeIaggf7OIesYlkHWi2QOhXsA1OKwI1dU6qJVBEUERp/y41JCDcHpV5G15+BPJHJLAW+jBgeC8DkVXK1C5LoiL6qfs1Bl2esyeXMqfkFgmnQDsspT1q1Xl8nyEoSKyWKiRnSonb1pMHKhN8Y6lHiPTjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744121764; c=relaxed/simple;
	bh=ZOzyfMkpdpLdOqPYvJ6NG3Jr2p9hlkTo83L5zV3YmZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUYNrixSqlrTEX6s8Ad/4XfVnSpBDBiCRpYYvMFEAWbdjzHrigjN0P85qEAUgpsUfCQrAS7yV8pbDoustjhk6KGTELCIwjcA87YRcWsFpCWhnYsFs4N1yV2YcxQnuj6cp7WffVrfNoLjWhwTJrLiUzO+eTVcOgYEFCI3V7QeVTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=wsEX/Wc9; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4766cb762b6so56607361cf.0
        for <cgroups@vger.kernel.org>; Tue, 08 Apr 2025 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744121760; x=1744726560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ah6YTymBCtd5GZI1uE1J8/OvCttX8CmH9zAIXWl9EoY=;
        b=wsEX/Wc9ob1akzoKddbTlmnCfqSIQinJ1BaXHLWEo2YzInDgx0k0S3Bg744N9uw2Nz
         BtHoTFjIt4wMLIPMo+2KlLZYVnEAILJmkjPmMeRUE8BCCcN8hdKW34oJ7guWSnbXnA1B
         AWDfUxhoxaRsWbgoxIssPeieEdC0SrWtCUtVq3OxUbvMcTSd0GWzMgGkkCBqUt3vDMOy
         cg6y6ZlKty+W3nZirkyAAIrsyZSZRThuKpgdu0CbNtTbW98qUwoUBRLMcPnlkYBCisJu
         z6DQv2AZ2LdSLYyDFpNFotm61tZA8SDbUB8smmUbeYEY++NRiuA5S9z9Abu7OYVjwnKZ
         aGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744121760; x=1744726560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ah6YTymBCtd5GZI1uE1J8/OvCttX8CmH9zAIXWl9EoY=;
        b=NzSR/f/zMcHlChUpwpovpcliTd4rqDQ/pWbqy4Ge9Ed9lRyVRrYmIB9+X7W3K02XMw
         jvz5NuD1SUw6UbtRPE7SqFIOCQCXHDDEXRXpXrdtM0nkLY5g5ZXk/8dI4MT+LyvF8NiZ
         CLyjiw48NrUb66ie0epzVj8ehVbbrOJqsPxetrQH4uDKhkK2gsFTrjH6c83PORIZUcKX
         5q6FQb9nUFsdWiDCDuP8FtDLR+I/VkHCJ9/5pdpqSxlJunrNNba8w/Uw4pGHpAAZoFpa
         zjLgvNSYrDusAb7LKOKpEGZdzLJlcv2T5OrSyGWWXUuBhHkyJHGj/1KWHVAcNFJFOF7c
         xcww==
X-Forwarded-Encrypted: i=1; AJvYcCUixb1wG1u5H84CjKPHvZRa1FhrWoI7wPqpzAYI8W08Kcr/a060o2eYi0wGL13BkjNFJktCWthj@vger.kernel.org
X-Gm-Message-State: AOJu0YyGr/5YM5YUFu5Hsk85cnOrYA1tKW4vWTRlOZTPY7XqReWh8woj
	JyoEAmF+KWSpbG0eypXVYYhAPxKALGmb2LM/NB1PUwD5w4RpeA/Kji21SgXrNIo=
X-Gm-Gg: ASbGnct2eNgVaZc9SbKiHwS2qMxc1l4rdhpg/tTTsrjzJhDJyVR9zUGWkp1vSjDiKZi
	mKrEJYSBErczYKXU+E3yerVBaDQEsEZXMzB5exM+U7PYZmUkUjwkeOb/fZ8k+/3jLM8G9T78zC2
	Y21bbTImBBDGNPZuGx764kUtp2y2z+hHAuKtVKuzdgPPgBMd3WvWk54qs1Gk8uNYdkxqwh6a13k
	6vH/swxHPhgtQ7ECPaFurPqu8odOGyxtlO1vh8Q47BeQBczuRK5GJaYhbvd5V/MtCHUovMtfF2/
	FvW6Smey9B9lwz11Uf4AeW/YAsgsXyBbHbq9//eEcIg=
X-Google-Smtp-Source: AGHT+IHjj4MgbYS8ZxVYXdi4tjA8mIF1AgEuXmh5FbR2yMsDFWAWr9GN3UnFHbHD2D1SbT1qBgClxA==
X-Received: by 2002:ac8:5e12:0:b0:479:1a0:3448 with SMTP id d75a77b69052e-47953ea88bfmr52199611cf.10.1744121760367;
        Tue, 08 Apr 2025 07:16:00 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4791b057a6esm76771061cf.16.2025.04.08.07.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:15:59 -0700 (PDT)
Date: Tue, 8 Apr 2025 10:15:55 -0400
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
Subject: Re: [RFC PATCH 03/14] mm: swap: add a separate type for physical
 swap slots
Message-ID: <20250408141555.GA816@cmpxchg.org>
References: <20250407234223.1059191-1-nphamcs@gmail.com>
 <20250407234223.1059191-4-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407234223.1059191-4-nphamcs@gmail.com>

On Mon, Apr 07, 2025 at 04:42:04PM -0700, Nhat Pham wrote:
> In preparation for swap virtualization, add a new type to represent the
> physical swap slots of swapfile. This allows us to separates:
> 
> 1. The logical view of the swap entry (i.e what is stored in page table
>    entries and used to index into the swap cache), represented by the
>    old swp_entry_t type.
> 
> from:
> 
> 2. Its physical backing state (i.e the actual backing slot on the swap
>    device), represented by the new swp_slot_t type.
> 
> The functions that operate at the physical level (i.e on the swp_slot_t
> types) are also renamed where appropriate (prefixed with swp_slot_* for
> e.g). We also take this opportunity to re-arrange the header files
> (include/linux/swap.h and swapops.h), grouping the swap API into the
> following categories:
> 
> 1. Virtual swap API (i.e functions on swp_entry_t type).
> 
> 2. Swap cache API (mm/swap_state.c)
> 
> 3. Swap slot cache API (mm/swap_slots.c)
> 
> 4. Physical swap slots and device API (mm/swapfile.c).

This all makes sense.

However,

> @@ -483,50 +503,37 @@ static inline long get_nr_swap_pages(void)
>  	return atomic_long_read(&nr_swap_pages);
>  }
>  
> -extern void si_swapinfo(struct sysinfo *);
> -swp_entry_t folio_alloc_swap(struct folio *folio);
> -bool folio_free_swap(struct folio *folio);
> -void put_swap_folio(struct folio *folio, swp_entry_t entry);
> -extern swp_entry_t get_swap_page_of_type(int);
> -extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
> -extern int add_swap_count_continuation(swp_entry_t, gfp_t);
> -extern void swap_shmem_alloc(swp_entry_t, int);
> -extern int swap_duplicate(swp_entry_t);
> -extern int swapcache_prepare(swp_entry_t entry, int nr);
> -extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> -extern void swapcache_free_entries(swp_entry_t *entries, int n);
> -extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> +void si_swapinfo(struct sysinfo *);
> +swp_slot_t swap_slot_alloc_of_type(int);
> +int swap_slot_alloc(int n, swp_slot_t swp_slots[], int order);
> +void swap_slot_free_nr(swp_slot_t slot, int nr_pages);
> +void swap_slot_cache_free_slots(swp_slot_t *slots, int n);
>  int swap_type_of(dev_t device, sector_t offset);
> +sector_t swapdev_block(int, pgoff_t);
>  int find_first_swap(dev_t *device);
> -extern unsigned int count_swap_pages(int, int);
> -extern sector_t swapdev_block(int, pgoff_t);
> -extern int __swap_count(swp_entry_t entry);
> -extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry);
> -extern int swp_swapcount(swp_entry_t entry);
> -struct swap_info_struct *swp_swap_info(swp_entry_t entry);
> +unsigned int count_swap_pages(int, int);
> +struct swap_info_struct *swap_slot_swap_info(swp_slot_t slot);
>  struct backing_dev_info;
> -extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
> -extern void exit_swap_address_space(unsigned int type);
> -extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
> +struct swap_info_struct *swap_slot_tryget_swap_info(swp_slot_t slot);
>  sector_t swap_folio_sector(struct folio *folio);

this is difficult to review.

Can you please split out:

1. Code moves / cut-and-paste

2. Renames

3. New code

into three separate steps

