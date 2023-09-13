Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB5679EDB0
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 17:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjIMPwY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 11:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjIMPwX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 11:52:23 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C91CE
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 08:52:19 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-450f8f1368cso6074137.1
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 08:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694620338; x=1695225138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1o+xAaY0eE6mqHpp9tQ0uQLU9Huay2534Teze/R2PM=;
        b=mP4K6tx6m8jDbVnwufSbH5lSLnoi99dPlXkX6G4rzn4sw8GKJ9rg1N/JznD4FvT3/k
         iPAQC7xNhgiQ8llAAATBxuJEqt2G+VxBxCHSEH+A/59YfeDqHbTrhcWrZQ1XOzCIGzWi
         kWVollAxCUs6hXYe8Gd9CjGjvkq0Qh2kZ3pgwSXC7xVqif8WFEap/s5PooeDjVIdD5vD
         kSEgWCIg38DPi0AOOjm2q1PEnE0vrEqFkTA38Ycsgf0kHf02SqBcjNAypSXD78RKDboq
         3zR6rYtxoh2ln9OVJ3F0pKKfLeWK2CnmqgSgFATMK84FABbb7sJx4NeL96heWUToqJ8n
         k0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694620338; x=1695225138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1o+xAaY0eE6mqHpp9tQ0uQLU9Huay2534Teze/R2PM=;
        b=OfGpHx2RHhkz1L/BStv0M8ZEzwFzBNwSuvDo57GEAMVbPx7vZ6Jri/h1SQsRPV/9bX
         M6ZpW09koL1CiLJvQRc0EvZJ9Ld3V2M8WC1JxWVShlpxDt3RGmEY3mPO65HG6ZfMkBBY
         qUHRtCz8EOZOyfAYTUxhHo7rqQahapGQIMVpe1Tj+FJa4zc7dbzYTS9whJUByt2wXMal
         OFl8fKDv+uQyjfIpncYdHILUUgWWr0WGoON3XHGqel9aRUfO+W6AL39SNVdM4Nxb//TJ
         c9aFs40XX3l5CGYRVRXBoKSAf4eRWAWtP0cpGOlO8HQfYcyetguihDVDkt6c3fFH8b8b
         jkow==
X-Gm-Message-State: AOJu0Yx9Dxp83J+L4R0Z2+5diA7Iz12zP/sto4By4QrRXwJcSYchVo03
        3B2BI5JNS17nO4hEv1ky2aIfVQ==
X-Google-Smtp-Source: AGHT+IEuCPN7mCVvNBSDsD7+IBZWRt5sWP6OLNzRugyBsPSLwhwSm1Njpa1czX8znYwNA1FxOwWATw==
X-Received: by 2002:a67:ea43:0:b0:44e:9cba:5f2 with SMTP id r3-20020a67ea43000000b0044e9cba05f2mr2088907vso.31.1694620338540;
        Wed, 13 Sep 2023 08:52:18 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id r1-20020a0cb281000000b0063cf4d0d558sm4513021qve.25.2023.09.13.08.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:52:18 -0700 (PDT)
Date:   Wed, 13 Sep 2023 11:52:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vern Hao <haoxing990@gmail.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xin Hao <vernhao@tencent.com>
Subject: Re: [PATCH v2] mm: memcg: add THP swap out info for anonymous reclaim
Message-ID: <20230913155217.GC45543@cmpxchg.org>
References: <20230912021727.61601-1-vernhao@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912021727.61601-1-vernhao@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 12, 2023 at 10:17:25AM +0800, Vern Hao wrote:
> From: Xin Hao <vernhao@tencent.com>
> 
> At present, we support per-memcg reclaim strategy, however we do not
> know the number of transparent huge pages being reclaimed, as we know
> the transparent huge pages need to be splited before reclaim them, and
> they will bring some performance bottleneck effect. for example, when
> two memcg (A & B) are doing reclaim for anonymous pages at same time,
> and 'A' memcg is reclaiming a large number of transparent huge pages, we
> can better analyze that the performance bottleneck will be caused by 'A'
> memcg.  therefore, in order to better analyze such problems, there add
> THP swap out info for per-memcg.
> 
> Signed-off-by: Xin Hao <vernhao@tencent.com>
> ---
> v1 -> v2
> 	- Do some fix as Johannes Weiner suggestion.
> v1: 
> https://lore.kernel.org/linux-mm/20230911160824.GB103342@cmpxchg.org/T/
> 
>  mm/memcontrol.c | 2 ++
>  mm/page_io.c    | 4 +++-
>  mm/vmscan.c     | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ecc07b47e813..32d50db9ea0d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -752,6 +752,8 @@ static const unsigned int memcg_vm_event_stat[] = {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	THP_FAULT_ALLOC,
>  	THP_COLLAPSE_ALLOC,
> +	THP_SWPOUT,
> +	THP_SWPOUT_FALLBACK,

Can you please add documentation to
Documentation/admin-guide/cgroup-v2.rst?

Sorry, I missed this in v1.

> @@ -208,8 +208,10 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>  static inline void count_swpout_vm_event(struct folio *folio)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (unlikely(folio_test_pmd_mappable(folio)))
> +	if (unlikely(folio_test_pmd_mappable(folio))) {
> +		count_memcg_folio_events(folio, THP_SWPOUT, 1);
>  		count_vm_event(THP_SWPOUT);
> +	}
>  #endif
>  	count_vm_events(PSWPOUT, folio_nr_pages(folio));
>  }

Looking through the callers, they seem mostly fine except this one:

static void sio_write_complete(struct kiocb *iocb, long ret)
{
	struct swap_iocb *sio = container_of(iocb, struct swap_iocb, iocb);
	struct page *page = sio->bvec[0].bv_page;
	int p;

	if (ret != sio->len) {
		/*
		 * In the case of swap-over-nfs, this can be a
		 * temporary failure if the system has limited
		 * memory for allocating transmit buffers.
		 * Mark the page dirty and avoid
		 * folio_rotate_reclaimable but rate-limit the
		 * messages but do not flag PageError like
		 * the normal direct-to-bio case as it could
		 * be temporary.
		 */
		pr_err_ratelimited("Write error %ld on dio swapfile (%llu)\n",
				   ret, page_file_offset(page));
		for (p = 0; p < sio->pages; p++) {
			page = sio->bvec[p].bv_page;
			set_page_dirty(page);
			ClearPageReclaim(page);
		}
	} else {
		for (p = 0; p < sio->pages; p++)
			count_swpout_vm_event(page_folio(sio->bvec[p].bv_page));

This is called at the end of IO where the page isn't locked
anymore. Since it's not locked, page->memcg is not stable and might
get freed (charge moving is deprecated but still possible).

The fix is simple, though. Every other IO path bumps THP_SWPOUT before
starting the IO while the page is still locked. We don't really care
if we get SWPOUT events even for failed IOs. So we can just adjust
this caller to fit the others, and count while still locked:

diff --git a/mm/page_io.c b/mm/page_io.c
index fe4c21af23f2..7925e19aeedd 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -278,9 +278,6 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 			set_page_dirty(page);
 			ClearPageReclaim(page);
 		}
-	} else {
-		for (p = 0; p < sio->pages; p++)
-			count_swpout_vm_event(page_folio(sio->bvec[p].bv_page));
 	}
 
 	for (p = 0; p < sio->pages; p++)
@@ -296,6 +293,7 @@ static void swap_writepage_fs(struct page *page, struct writeback_control *wbc)
 	struct file *swap_file = sis->swap_file;
 	loff_t pos = page_file_offset(page);
 
+	count_swpout_vm_event(page_folio(sio->bvec[p].bv_page));
 	set_page_writeback(page);
 	unlock_page(page);
 	if (wbc->swap_plug)
