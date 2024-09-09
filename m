Return-Path: <cgroups+bounces-4779-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A7397254E
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 00:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84A71C2235B
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 22:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E9818CC02;
	Mon,  9 Sep 2024 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fGARQLp7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA361791EB;
	Mon,  9 Sep 2024 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920999; cv=none; b=LR5Fxlv9SfVPq0787OdgHPTbD8YR2Vf3XmCGmcIIYbJF0lcv80TwrZ2rV9s95y9tP6M/P0rXGFtHS3hPO7E1TOO+NUudJzSKGCxeQz+Mgkf49Gjx2Hf2waNlPrQ8uU+vONw3WferWls+CyxNEqrx7EbBUMQwDbVBHqWy++TZwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920999; c=relaxed/simple;
	bh=qJ0xsOPGneJ9o+apQBK8rKN15U71Go1quiMy+DWSIdM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MPtb16r/LiJ0O6HH3arZwWAP4n8m3P/ROSe3NaFuIyHhx5XxWFggIQGiNtOZxcxvD54t+VsGFB8VlK6dLhF6jCZsCmRbKzKZkCzMmuUos0grYpM6TuwODvaB7wd8faFfCdEzZFKWVQ07C9T/gGLLJAs1c0jtNaRTotJW5J0uo7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fGARQLp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDB6C4CEC5;
	Mon,  9 Sep 2024 22:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725920998;
	bh=qJ0xsOPGneJ9o+apQBK8rKN15U71Go1quiMy+DWSIdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fGARQLp7dysAWus/Tj+ffB7ylN/IfM1r7UY5FquA2dS5Jz8BEt4g6lkaPxnou8dT8
	 wvnXYBZbVzBYnGhNB20wp2X/I+IsP4mcM48ok0qTLy+3K/tYiFSGErbF/smpXMSAcK
	 rd6fBL2dw4N3QkS+J2ajpNvO477aZHJcTiNfftfs=
Date: Mon, 9 Sep 2024 15:29:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jingxiang Zeng <linuszeng@tencent.com>
Cc: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>, linux-mm@kvack.org,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: add per-memcg pgpgin/pswpin counter
Message-Id: <20240909152957.f3d57c43fc6a21319c6e3776@linux-foundation.org>
In-Reply-To: <20240830082244.156923-1-jingxiangzeng.cas@gmail.com>
References: <20240830082244.156923-1-jingxiangzeng.cas@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 16:22:44 +0800 Jingxiang Zeng <jingxiangzeng.cas@gmail.com> wrote:

> From: Jingxiang Zeng <linuszeng@tencent.com>
> 
> In proactive memory reclamation scenarios, it is necessary to
> estimate the pswpin and pswpout metrics of the cgroup to
> determine whether to continue reclaiming anonymous pages in
> the current batch. This patch will collect these metrics and
> expose them.

Could we have some reviewer input on this please?

> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index b37c0d870816..44803cbea38a 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -2729,6 +2729,8 @@ static const char *const memcg1_stat_names[] = {
>  static const unsigned int memcg1_events[] = {
>  	PGPGIN,
>  	PGPGOUT,
> +	PSWPIN,
> +	PSWPOUT,
>  	PGFAULT,
>  	PGMAJFAULT,
>  };
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 087a8cb1a6d8..dde3d026f174 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -418,6 +418,8 @@ static const unsigned int memcg_vm_event_stat[] = {
>  	PGPGIN,
>  	PGPGOUT,
>  #endif
> +	PSWPIN,
> +	PSWPOUT,
>  	PGSCAN_KSWAPD,
>  	PGSCAN_DIRECT,
>  	PGSCAN_KHUGEPAGED,
> diff --git a/mm/page_io.c b/mm/page_io.c
> index b6f1519d63b0..4bc77d1c6bfa 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -310,6 +310,7 @@ static inline void count_swpout_vm_event(struct folio *folio)
>  	}
>  	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
>  #endif
> +	count_memcg_folio_events(folio, PSWPOUT, folio_nr_pages(folio));
>  	count_vm_events(PSWPOUT, folio_nr_pages(folio));
>  }
>  
> @@ -505,6 +506,7 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
>  		for (p = 0; p < sio->pages; p++) {
>  			struct folio *folio = page_folio(sio->bvec[p].bv_page);
>  
> +			count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
>  			folio_mark_uptodate(folio);
>  			folio_unlock(folio);
>  		}
> @@ -588,6 +590,7 @@ static void swap_read_folio_bdev_sync(struct folio *folio,
>  	 * attempt to access it in the page fault retry time check.
>  	 */
>  	get_task_struct(current);
> +	count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
>  	count_vm_event(PSWPIN);
>  	submit_bio_wait(&bio);
>  	__end_swap_bio_read(&bio);
> @@ -603,6 +606,7 @@ static void swap_read_folio_bdev_async(struct folio *folio,
>  	bio->bi_iter.bi_sector = swap_folio_sector(folio);
>  	bio->bi_end_io = end_swap_bio_read;
>  	bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
> +	count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
>  	count_vm_event(PSWPIN);
>  	submit_bio(bio);
>  }
> -- 
> 2.43.5
> 

