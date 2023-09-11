Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DEE79BBA7
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 02:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377466AbjIKW03 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 18:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242693AbjIKQIb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 12:08:31 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8701B8
        for <cgroups@vger.kernel.org>; Mon, 11 Sep 2023 09:08:26 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-649c6ea6e72so29806356d6.2
        for <cgroups@vger.kernel.org>; Mon, 11 Sep 2023 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694448506; x=1695053306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OpK471urcTKFhaEEiu2Y7Ctk71H7kGAYVejmdBrLuVg=;
        b=qXBzv6zXqpFaPW0WDtiAxbUeFE2eeqfUM0Ioy+Gby2UX3k8jg8ihHdQM8fTTwRSJ3X
         bVXI5M2XAoYmskSSdzLL9ca/823siSnYgN5xe0r3kbXb4OPrE+g2G774G4WYA7hm/3A4
         OlRFVa6jm9bRcFjFDto+Ywe4e/OB97U1PnAeFSaS5eA5SBV0S5eXeui3XQ5cZCPbRz0V
         VALgcZQ9Jd0XdeGgsuTH5cqr+jo5KzR5lvM2lL+baJTkU2kD94fEPbqN/RznDTN8/ewk
         hG/qDobfKa4PLboTR6RvJepKYf//CQrC3XnRR8K+z7dknwHO/QhdBEa+xxXXtksk2EPz
         hyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694448506; x=1695053306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpK471urcTKFhaEEiu2Y7Ctk71H7kGAYVejmdBrLuVg=;
        b=wpF08dH/Z1UfV0bj9gMmp6h9NpcnBJR1c3DaIU1Ij1dnKdgtCczzmZetsPjtWfIiV+
         waCXETyTTIe9q7ncgUZFhsMFzBascuWkCI1Izlkmy8Oy244qD5EHFTX9TPIv2H/Jsr3S
         CII4HyI6V7dUJpv6OaGH3uSLvL5fjoiCfr/WudJbRUGnlqDoP9mje0URU0/vfnabc13P
         D4sj8dN5SddQgLzMkEGGHxw9ttFcoFat0nn0S+AAgnoQIN8i04xbdgLhJuhDmNHQkv9s
         kh55VgUafWV12keWsUZTJ9SgXVGyt8Mir8Hu1rWv4bMFxf77K/U/TkjQHLO/yOOXfrAu
         P7sA==
X-Gm-Message-State: AOJu0YzRv/1i0fRDdjl7VErXMkCN0sfh/Rbp1yHP2ZmM+XGvThd/Pqkv
        q1R5Z6A9bvtfLTHYznZSgOLyFg==
X-Google-Smtp-Source: AGHT+IFO1yeb4lCNE0WAccBqbLcdu+KdRUkm4PTopxo1o8AH7WuyX6E2VktVhHwaQ4F1MKaR+oEl8A==
X-Received: by 2002:a0c:b34f:0:b0:64f:7751:9d46 with SMTP id a15-20020a0cb34f000000b0064f77519d46mr9827259qvf.62.1694448505863;
        Mon, 11 Sep 2023 09:08:25 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id l4-20020a0ce504000000b0064a5de64668sm2986998qvm.141.2023.09.11.09.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:08:25 -0700 (PDT)
Date:   Mon, 11 Sep 2023 12:08:24 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Xin Hao <haoxing990@gmail.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: add THP swap out info for anonymous reclaim
Message-ID: <20230911160824.GB103342@cmpxchg.org>
References: <20230909155242.22767-1-vernhao@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909155242.22767-1-vernhao@tencent.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Sep 09, 2023 at 11:52:41PM +0800, Xin Hao wrote:
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

That sounds reasonable. A few comments below:

> @@ -4131,6 +4133,10 @@ static const unsigned int memcg1_events[] = {
>  	PGPGOUT,
>  	PGFAULT,
>  	PGMAJFAULT,
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	THP_SWPOUT,
> +	THP_SWPOUT_FALLBACK,
> +#endif
>  };

Cgroup1 is maintenance-only, please drop this hunk.

>  static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
> diff --git a/mm/page_io.c b/mm/page_io.c
> index fe4c21af23f2..008ada2e024a 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -208,8 +208,10 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
>  static inline void count_swpout_vm_event(struct folio *folio)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (unlikely(folio_test_pmd_mappable(folio)))
> +	if (unlikely(folio_test_pmd_mappable(folio))) {
> +		count_memcg_events(folio_memcg(folio), THP_SWPOUT, 1);

count_memcg_folio_events()

>  		count_vm_event(THP_SWPOUT);
> +	}
>  #endif
>  	count_vm_events(PSWPOUT, folio_nr_pages(folio));
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ea57a43ebd6b..29a82b72345a 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1928,6 +1928,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  								folio_list))
>  						goto activate_locked;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +					count_memcg_events(folio_memcg(folio),
> +							   THP_SWPOUT_FALLBACK, 1);

count_memcg_folio_events()
