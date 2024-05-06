Return-Path: <cgroups+bounces-2808-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641708BD5D9
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 21:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FF6281AD1
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 19:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9320F15ADA4;
	Mon,  6 May 2024 19:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pb15iywg"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAFA15749D
	for <cgroups@vger.kernel.org>; Mon,  6 May 2024 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025018; cv=none; b=AEJLxtYSgFA6LQqcIS/fnaRt5csjeINvR52XZmQvLfQlsxORCBus4ljHMDNVqbhq74K/Rkz0WCIQHBXSMXvUfluopc1hiX0gnlUySec4LOm4qV4kwSxXT1505HnVGhSEChu7e2XA9LQqzub/OIYzvgoVygXq0WOUHOu9iBQPwp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025018; c=relaxed/simple;
	bh=UC6Ki0pIiVbiy3okjMnHafK7vvm5E/aH/pr4q15tdlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a74AxQ8TP0uLs5NlIWwa30WNvp+riYNJ6PXkapUjp0LOfEu1vH8MFzPKx4AoKsVy+jrHYyddV7ubyupZWyGN+q8MUYcLbCda+QqzOASRfKsu7PySxlLucHtxCiiKaUO/NJgGdKvJIj2kaNIj7NqoYP6TzPXG5mTjKSDny9YxAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pb15iywg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715025015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=43neyGYicA9em02DzDluHTB7rZaBqEtPcJZfV5lNzv4=;
	b=Pb15iywgaiFDh8Ev5bCbacxL/Z4PHLJYeatmDo3IHwhVQTVLbwstZYmyfxHnUwGf/aTpgW
	NT2C/ApGV5vhOoGggHKrc2hjPrOGzHiIAKu+7z4PUiP3sggx9cyorCAFPAdXJ0QCJ5gbOI
	jwrnhQdBPKqNu8p9g7caLNmaA9OEn4U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-wglO3_qZN_eqnO-OJd98sg-1; Mon, 06 May 2024 15:50:14 -0400
X-MC-Unique: wglO3_qZN_eqnO-OJd98sg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41c05442f92so12913445e9.2
        for <cgroups@vger.kernel.org>; Mon, 06 May 2024 12:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715025013; x=1715629813;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=43neyGYicA9em02DzDluHTB7rZaBqEtPcJZfV5lNzv4=;
        b=SscwlyupZw6nnX6g50PBbnt8nHAWv6ShZxseqGI+kou4+XgT5gmU//zhzw0+OZq9AU
         39ww7NHQIpLURiPnz2WI6zqnyLbD/0uSu25AvwY9OJnimjHZO9k9TxXWpB2xQvzh4h0/
         zHtdtGaX9TroSz3B7Rgvdjf1hXgCEruXfg2yuPSPMfALoDR2t/7Orcmtq4+Gzhoy5xve
         ZhwRdoFiPgqJ1a7pJpRl+56m5VHMBUb9XT9pykcVI+Se+xDVovxnzj3LXILfPJUB9/92
         22QYvqwOVKqceXsVTNfhkepmhCnhFFU9B/tgdWiaaeaXXCNZs9McWgCnazDoxzHyQoU3
         2v7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjHlRp4SSo8CBj9EBpCDA0R6VBuNHPnm+ThqETaW7QbX47T5TXGWz3XeKzSrywScqVj3qG57UvFRfzMyIg+4erjbCKEQGg8A==
X-Gm-Message-State: AOJu0YwOXhPRoKSz2AxvOsZcZL/Ih0GAb8wo7WtA5PSTWle7t/cx1UvI
	x0c9TH62cuiy2iitb+BlrCvqKzOXAgyz05GPQ6Q22vHeFj3QmqVeu9ZmsSHZQz8f4rEAhAWjI5a
	Q+tNfu4ofasRU61AVEb5yrjWKLnMaoRsCijenxCbNAKYkkrUsIKMnjbo=
X-Received: by 2002:a05:600c:1e0b:b0:41a:f936:5326 with SMTP id ay11-20020a05600c1e0b00b0041af9365326mr9691243wmb.15.1715025013214;
        Mon, 06 May 2024 12:50:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENNtNGUdZTGJY68HgN3RKZQR6LLY8lKJI77l/pO1a3Q0O4OYmrLWSXO0gjFG9wVxBPfKqt1w==
X-Received: by 2002:a05:600c:1e0b:b0:41a:f936:5326 with SMTP id ay11-20020a05600c1e0b00b0041af9365326mr9691228wmb.15.1715025012753;
        Mon, 06 May 2024 12:50:12 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6c2e.dip0.t-ipconnect.de. [91.12.108.46])
        by smtp.gmail.com with ESMTPSA id gb30-20020a056000459e00b0034e0346317dsm11349632wrb.13.2024.05.06.12.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 12:50:12 -0700 (PDT)
Message-ID: <d99b6375-cbae-41f1-9221-f1dd25aab150@redhat.com>
Date: Mon, 6 May 2024 21:50:10 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: do not update memcg stats for
 NR_{FILE/SHMEM}_PMDMAPPED
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
References: <20240506192924.271999-1-yosryahmed@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240506192924.271999-1-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.05.24 21:29, Yosry Ahmed wrote:
> Previously, all NR_VM_EVENT_ITEMS stats were maintained per-memcg,
> although some of those fields are not exposed anywhere. Commit
> 14e0f6c957e39 ("memcg: reduce memory for the lruvec and memcg stats")
> changed this such that we only maintain the stats we actually expose
> per-memcg via a translation table.
> 
> Additionally, commit 514462bbe927b ("memcg: warn for unexpected events
> and stats") added a warning if a per-memcg stat update is attempted for
> a stat that is not in the translation table. The warning started firing
> for the NR_{FILE/SHMEM}_PMDMAPPED stat updates in the rmap code. These
> stats are not maintained per-memcg, and hence are not in the translation
> table.
> 
> Do not use __lruvec_stat_mod_folio() when updating NR_FILE_PMDMAPPED and
> NR_SHMEM_PMDMAPPED. Use __mod_node_page_state() instead, which updates
> the global per-node stats only.
> 
> Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/0000000000001b9d500617c8b23c@google.com
> Fixes: 514462bbe927 ("memcg: warn for unexpected events and stats")
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>   mm/rmap.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 12be4241474ab..ed7f820369864 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1435,13 +1435,14 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
>   		struct page *page, int nr_pages, struct vm_area_struct *vma,
>   		enum rmap_level level)
>   {
> +	pg_data_t *pgdat = folio_pgdat(folio);
>   	int nr, nr_pmdmapped = 0;
>   
>   	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
>   
>   	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
>   	if (nr_pmdmapped)
> -		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
> +		__mod_node_page_state(pgdat, folio_test_swapbacked(folio) ?
>   			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
>   	if (nr)
>   		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);
> @@ -1493,6 +1494,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>   		enum rmap_level level)
>   {
>   	atomic_t *mapped = &folio->_nr_pages_mapped;
> +	pg_data_t *pgdat = folio_pgdat(folio);
>   	int last, nr = 0, nr_pmdmapped = 0;
>   	bool partially_mapped = false;
>   	enum node_stat_item idx;
> @@ -1540,13 +1542,14 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>   	}
>   
>   	if (nr_pmdmapped) {
> +		/* NR_{FILE/SHMEM}_PMDMAPPED are not maintained per-memcg */
>   		if (folio_test_anon(folio))
> -			idx = NR_ANON_THPS;
> -		else if (folio_test_swapbacked(folio))
> -			idx = NR_SHMEM_PMDMAPPED;
> +			__lruvec_stat_mod_folio(folio, NR_ANON_THPS, -nr_pmdmapped);
>   		else
> -			idx = NR_FILE_PMDMAPPED;
> -		__lruvec_stat_mod_folio(folio, idx, -nr_pmdmapped);
> +			__mod_node_page_state(pgdat,

folio_pgdat(folio) should fit here easily. :)

But I would actually suggest something like the following in mm/rmap.c

static void __folio_mod_node_file_state(folio, int nr_pages)
{
	enum node_stat_item idx = NR_FILE_PMDMAPPED;

	if (folio_test_swapbacked(folio))
		idx = NR_SHMEM_PMDMAPPED;

	__mod_node_page_state(folio_pgdat(folio), idx, nr_pages);
}

And then simply calling here

__folio_mod_node_file_state(folio, -nr_pmdmapped);

And likewise in __folio_add_file_rmap()


... will be cleaner.

In any case

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


