Return-Path: <cgroups+bounces-5811-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560F99ED0E4
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 17:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C70288C6C
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB191D9A70;
	Wed, 11 Dec 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="S+pe8beD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AA61D5CDD
	for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933406; cv=none; b=JgrvpgozMinrUfV8pRHDXCCIS7Ckn/HxrStAibPYKekKjjWZ27vrvb8w6QyLQ4Wx/a6e8IzcZjcINDc2mLUiueeQfRhx6kB8ga9DnVvJlA5Oa0ohZW4JaxihAXlHe/Dm9MOQCcDARGwwb32T/pL5LKT4nWphti7zayOMXRmIMuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933406; c=relaxed/simple;
	bh=17vLRmRqENYSYUK2jmWxRWMQPaMn8mxRYzFR8+i4nZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d36QDwGdtKBpAQS416q9KhQLzcOqpqNSiEQrOZQAX2RwQpaydKuqpcQ3dnV+kw2rzDJ79MH9f0l7uqJFUu8O0ih2LHWzSBe4EVafYhCfAQHGkMaGqDhfc5Fn7V8qh/Rx9MN7z/b4UDwGPlgVDHONYrtpAuwa0pw8DmMGYd09qTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=S+pe8beD; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d8f544d227so29646676d6.1
        for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 08:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1733933402; x=1734538202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUp3RhBBfdr/dtfuqHm+FsIlOBYLF3QZPu3JwNbarhc=;
        b=S+pe8beDkSWStjiw3V0quGUjsw9ti7S4pFC83EwOwB1/eKpbenOwqSAI5aDAdGP57d
         M9PTjcRQ6kboVZ+C9vWSCeU7CWpR17dd12mEzOTI16yms/sI41Yg3B9SrDVYduKzVxuv
         5NPLiUGDsUEYNhdCPJL3lwKVloWC3g30lDy2lXt267DJ02J82d7MBc3mhCRz2D8CNKiu
         GQwWn+thUojcS35D4XCGKQxmORRss+zggMew9GKdq98jwBxAMP8L5+0i4Rt4sN9FAOlF
         4Ymr5PwLKRS+KiV+ywpv4Zw2Xk2crQmfXVTu/4Zpo7y+QRZdtJWrqV53jcDHd1KoNvsp
         o8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733933402; x=1734538202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUp3RhBBfdr/dtfuqHm+FsIlOBYLF3QZPu3JwNbarhc=;
        b=sroqAgJMYNr8vBey2L7jYPB7/OkTsesq17xxONoRLxTVMPb9sbiHjna0bSyitrZoXr
         nB9aSreC8VmSpcyAX4y9k949Dg3M4dtePzUSk+Bux4VT50NRsgYlgLKMw9mBtk24QAbs
         EyxIfpYOhzjdK8fvcORSi+WKMjznf9KkQPHsZm9QAEsBSp1x2rFMZ3VUO39X0OSGCXH7
         /hBZZxTX8v7yITVTatWyQB+4GDmR++Qbdd4x4JANaaR07yBgzNZ6tGo020X5d5EtFiU2
         c8LQJ4oWVE3U/MI0sbYoYbZunfbm+3nBsvNMM777EUt4GvatfDpLtdLoaiCeRBoChP+b
         ODZw==
X-Forwarded-Encrypted: i=1; AJvYcCVSIwLe0XHBSRIo7dNbFPoLWZuk0R91YnoUfLOIXl4ogYF51DZ+YrIEg1iiG8gtK2+z5OPlg0sC@vger.kernel.org
X-Gm-Message-State: AOJu0YzFHFqr1GPM2tiSuzNkDTcErcxRdStBpqsApJEixzNKpyjD/rJr
	BHSsEkzt7I3rHplP1xKdXjGS4dc0nkjy261AMF+lk4pZlZZjmMLA1olWq4e/js8=
X-Gm-Gg: ASbGncs456x1qa5xVbfBX2a7ZP+jTB0XcEu83BAHnb1/XYP+EavvetKVYLGztgbf0fj
	nn+wuJlT7FoD+Pks/zNAjZ5gzLofKZmcXpgVXwR6pf2e8sfj5yQV+05+jndLMOxrRNsSIS7yH6L
	uGnXllMcdm0Wd6l+Jq6w91MyikupuVad3Tly2j3wGkIl+ErPbi6QSRowe5dHZUG9264x9dRET8m
	GZGx/sFHPQc2ORpJPJLAnla5TDEunMUAkPSGtrp27YZcmNY0wDB
X-Google-Smtp-Source: AGHT+IHCFur8c2yRjAwCiXsHUZUv9CFzmKzR3fV7Tyv8vhH9XqzcHHhtRhxQu8/ilDdv1ZOYjn4iJA==
X-Received: by 2002:a05:6214:1d2b:b0:6d8:8a60:ef2c with SMTP id 6a1803df08f44-6dae29c185bmr4727736d6.2.1733933401867;
        Wed, 11 Dec 2024 08:10:01 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8f5af294asm52335306d6.48.2024.12.11.08.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:10:01 -0800 (PST)
Date: Wed, 11 Dec 2024 11:09:56 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] vmalloc: Account memcg per vmalloc
Message-ID: <20241211160956.GB3136251@cmpxchg.org>
References: <20241211043252.3295947-1-willy@infradead.org>
 <20241211043252.3295947-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211043252.3295947-2-willy@infradead.org>

On Wed, Dec 11, 2024 at 04:32:50AM +0000, Matthew Wilcox (Oracle) wrote:
> Today we account each page individually to the memcg, which works well
> enough, if a little inefficiently (N atomic operations per page instead
> of N per allocation).  Unfortunately, the stats can get out of sync when
> i915 calls vmap() with VM_MAP_PUT_PAGES.  The pages being passed were not
> allocated by vmalloc, so the MEMCG_VMALLOC counter was never incremented.
> But it is decremented when the pages are freed with vfree().
>
> Solve all of this by tracking the memcg at the vm_struct level.
> This logic has to live in the memcontrol file as it calls several
> functions which are currently static.
>
> Fixes: b944afc9d64d (mm: add a VM_MAP_PUT_PAGES flag for vmap)
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/memcontrol.h |  7 ++++++
>  include/linux/vmalloc.h    |  3 +++
>  mm/memcontrol.c            | 46 ++++++++++++++++++++++++++++++++++++++
>  mm/vmalloc.c               | 14 ++++++------
>  4 files changed, 63 insertions(+), 7 deletions(-)

This would work, but it seems somewhat complicated. The atomics in
memcg charging and the vmstat updates are batched, and the per-page
overhead is for the most part cheap per-cpu ops. Not an issue per se.

You could do for MEMCG_VMALLOC what you did for nr_vmalloc_pages:

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 634162271c00..a889bb04405c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3353,7 +3353,11 @@ void vfree(const void *addr)
 		struct page *page = vm->pages[i];
 
 		BUG_ON(!page);
-		mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
+
+		/* Pages were allocated elsewhere */
+		if (!(vm->flags & VM_MAP_PUT_PAGES))
+			mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
+
 		/*
 		 * High-order allocs for huge vmallocs are split, so
 		 * can be freed as an array of order-0 allocations


