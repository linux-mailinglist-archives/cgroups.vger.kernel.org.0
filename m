Return-Path: <cgroups+bounces-5846-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B759EE6A9
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 13:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13ECA16539E
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 12:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71390207A3F;
	Thu, 12 Dec 2024 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YdtHGBUY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF97205507
	for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006401; cv=none; b=py8l7KJEU+ZjLRFZwMh40E9rILqFgl9FUWAnqB+oucbpHz/MFnicCoAKYrbiF1ItBpBeX9wXdhzQOlBxV8Q4hp2u70WoAafQmFtEkMDy6cmplBzGPBfApr95CA1BIjUtJ/ijJFNbNcoj8Ui2jfBbXNJNiMgXWtgoCaXgmkjV8zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006401; c=relaxed/simple;
	bh=6+4ftoPMyDWJ/EW43OnEVwuexdTq2qMg/JFSAqyflIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV7HwQnAnQVX5oN3e2fquDSaKWJZjhcehObklHgdelwNDr8UOGtekg4d/+P08hGqBxnS1ZwHDqrOxaE2RaILc4xBm/rbfflix385P6CJJpvQxhX0zjjdFvl5bvtHKIrQ+ntW6jxDJm8/WLyrcVa0N0f5gC4+x1YMJXI4tiaCV2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YdtHGBUY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862f32a33eso260131f8f.3
        for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 04:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734006396; x=1734611196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMW58xtFVKDI069GjXZg2dD8GBgbY07ZYprS8XRa5kc=;
        b=YdtHGBUYcUvfyBfGeTubSJH8ajNazKhBaj5w8l6+rRLV3kKjWpWKRac4PRjvTccWxk
         6asPDPdlZ6ZWExwqfP5Il/QoF604HJ6vLIZf+54KbwR/2sl+rQDe7dvpL1ZVKObA/QIk
         dgo75cDz4xw5wldXfltnGR5XFuTbHgJ1rufzrs8WhoghYe7V0NYOp3mFhrDhhsmTJ/am
         rbbpwdFRFJZQu28Q61X0eno0I0/d/yhVO4wWsAtW7HzFoJGSPGkLxnnZHpfSWfkoCcc7
         i/VgzeCjXt88YONDiUBH6sGHePrkmDTVQvmR2tJR1TpO56/GMNO1yaKqacIA3pNkWH7Y
         J2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734006396; x=1734611196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMW58xtFVKDI069GjXZg2dD8GBgbY07ZYprS8XRa5kc=;
        b=dno4jQ+fcBNpdBSJeTMBJl4AJ/+b2/birYlp9ucAOdUNXkAXhOvJxBBfF6sSJhnjHS
         liuu84j/FzlVo9mDNtUYO+vUUrS6l4PNq6BfcP9AQ0SNt9ms1xgDQ27rEmo625vBxFvg
         xqS21/NaqLTBRgPfadeZ3FvragvfW2qtaSpXUrE41lsglbSgnM2+zV7oPmWmD575HnFO
         +AXAb3sQ9aVELWZJB1bnl31s1JV3GeEnd1+2UcUFFMMWQtMT3RdYP1HoKOK+IlWR31VB
         Lhsn21b/fPSBXI2rBDioB1ThoVuKtY2LH6i/6D6lDKogBk/I+184r4KbUqStizftTkap
         Cedw==
X-Forwarded-Encrypted: i=1; AJvYcCV02EKFM3bc3+TdYQDi+eaRcUW96hehK0V8P78jTRhV8My81Ry5n6lj5A7HNhT95rWkiPb84Fy5@vger.kernel.org
X-Gm-Message-State: AOJu0YzpHQkUlhoCoTPONpZgssIqvxq9nQaq0sMQQearFE0nChqHOWP5
	oMP9ioi8LNNnmh76lh0FPAqmro5It3D/jDBkBXgbqXFKLCObpnkDm2bgfKdpTCw=
X-Gm-Gg: ASbGncuqHzSPD68/YFYibHCIQNDEANGN6QnU1ZEtbXi8cyTLJzzZZ3IROginsCW0U/t
	1V0oMGZs2ywxudOaBpzSLspkCQrWeyeuYwJsOzaW3y5XtRYyJfBds1thHwe6gm5mEPlxxtK3xTZ
	CRB61k7VV4P+pvjFzTzU21H5sYpakpXcSKksMECGV2AjQEYw1PvPWjww3jjCA6qq0ka/ub8NtKb
	Mc86ZnD3fAHiNr9iBrTGmUVpj1D93XNt0BlVk1OI/2FX3A=
X-Google-Smtp-Source: AGHT+IG4/pMDJNly6UpcXjj9YqlCTPXUKoKZr4j95kG0fcImiNV2JPjd07+8pLaKIe3xJptBa0NikQ==
X-Received: by 2002:a05:6000:410f:b0:385:f2a2:50df with SMTP id ffacd0b85a97d-3864cea200amr4204805f8f.27.1734006396535;
        Thu, 12 Dec 2024 04:26:36 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ed8dsm15780115e9.23.2024.12.12.04.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 04:26:36 -0800 (PST)
Date: Thu, 12 Dec 2024 13:26:35 +0100
From: Michal Hocko <mhocko@suse.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] vmalloc: Fix accounting with i915
Message-ID: <Z1rWexnnXMmpIAEj@tiehlicka>
References: <20241211202538.168311-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211202538.168311-1-willy@infradead.org>

On Wed 11-12-24 20:25:37, Matthew Wilcox wrote:
> If the caller of vmap() specifies VM_MAP_PUT_PAGES (currently only the
> i915 driver), we will decrement nr_vmalloc_pages and MEMCG_VMALLOC in
> vfree().  These counters are incremented by vmalloc() but not by vmap()
> so this will cause an underflow.  Check the VM_MAP_PUT_PAGES flag before
> decrementing either counter.
> 
> Fixes: b944afc9d64d (mm: add a VM_MAP_PUT_PAGES flag for vmap)
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/vmalloc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index f009b21705c1..5c88d0e90c20 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3374,7 +3374,8 @@ void vfree(const void *addr)
>  		struct page *page = vm->pages[i];
>  
>  		BUG_ON(!page);
> -		mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
> +		if (!(vm->flags & VM_MAP_PUT_PAGES))
> +			mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
>  		/*
>  		 * High-order allocs for huge vmallocs are split, so
>  		 * can be freed as an array of order-0 allocations
> @@ -3382,7 +3383,8 @@ void vfree(const void *addr)
>  		__free_page(page);
>  		cond_resched();
>  	}
> -	atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
> +	if (!(vm->flags & VM_MAP_PUT_PAGES))
> +		atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
>  	kvfree(vm->pages);
>  	kfree(vm);
>  }
> -- 
> 2.45.2

-- 
Michal Hocko
SUSE Labs

