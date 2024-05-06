Return-Path: <cgroups+bounces-2812-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0198BD643
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 22:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479221F22790
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 20:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77560158D64;
	Mon,  6 May 2024 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMELAxaz"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9931E13D521
	for <cgroups@vger.kernel.org>; Mon,  6 May 2024 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027504; cv=none; b=Ib01IX7G63n85GY2/yqrM4GZq2swFBBYWw4Bq41aWLLNNbHsuo/+IO6g3AD7s9eCarum8MOjV8PddDBl2s3zunFtVA2VZwgrRUxoTtktuX0V8fSfhDFbPq4S9+AM67ywjIAVE/61guy6ZnJ30LS+qrFA8oO9ZwYQuoYovYFwSGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027504; c=relaxed/simple;
	bh=8J9HCTMFlsb3siLQBsDJafo+aPcJo4k9kbndliCU/5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/YsuUYgi1fIVDyheyYmcq4kxyazAetz4Pq4DuOUr6HArQ9tLHFDApGW7vMRBzbuj4GPvleJGjcV2HEmABpnQOAuPMFZXAkZSTvxJwCJf8xshUJqCbCyVFbEZ2qcpAtaghv/+7mFaLA+ermuf1q1sH+RpfzKMFWmxtnWYx3DriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eMELAxaz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715027501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ufdh+EVuNbhhg/Fs9LCV9pYz2tN7lfjT8/BykYZkopE=;
	b=eMELAxazqj/nN+EFK4vv8h0A/AstxCtGv1HCewAt7qhdTlHtIzcCsbGaIfhRca3uk4iR20
	tX7kasL6QSsj5+k7tb2rYoepfAtw3HlNY4800j91JIZ/kxR1EdxMhnXUWSRtFtAI2YSu2n
	1cT2l3W2dWRyVXKaYZRLwrnxhbeSrIo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-Gsl-jEsnP1aHVHJHr16MIg-1; Mon, 06 May 2024 16:31:40 -0400
X-MC-Unique: Gsl-jEsnP1aHVHJHr16MIg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34e0d47c9b7so2157257f8f.0
        for <cgroups@vger.kernel.org>; Mon, 06 May 2024 13:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715027499; x=1715632299;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ufdh+EVuNbhhg/Fs9LCV9pYz2tN7lfjT8/BykYZkopE=;
        b=HPc6BXHysAWZDeE/WjEsPIvAn7ALBtexHiSKy05owjspw5vO8qxp0giPPXDPbg29Vz
         XohFUe33gqDkyTAADlHyEfPb+wj3cbSubidBJKd7W8/lUowAckRMSsFSJ25Bzpt96pwj
         qYpwQlCfs3hWKC0wvUbX+SP2pf+qRqrffPyZ0SuiPjnjwcrFme5A9rPG82Q2jtGkGCkD
         ogUa/+3Z+fzPMgr1Vu4L3PMFNuXWTtGL6gFM1/RWXnrP2heKO1VMXtZESl1H0HQoidWs
         InPG2N9VeanxgxIs2px9ztSwwGPr8oHW+LMD/1KTh1ztRlI+EJg5du6WAeFt/AwV1fhp
         ASrw==
X-Forwarded-Encrypted: i=1; AJvYcCXjM4HULhitCCSAF+O2TI/TFSGWNCMkKmfAHpVixi1p0jrWbxUcDIhouRGI/lKJdPdAo4azizMJP0or+itLe3yXQs9YbO7S/w==
X-Gm-Message-State: AOJu0YwkA9j0+eFKMZgXuPOr3DowAsLY4ubGToJXIbDsPSWuyYL4VzTH
	PT0wpJ9jqzVtS5YvhVkdeNczDUmyY0sQjhY1IchLqSYHianx0dGWKBNXiKp9T1qORu9nrSMpXOR
	R38ziZddaVmj2JXl9IorXOeJMOgL2JYZYvtAbYV5DtnGy83e+zLttz/c=
X-Received: by 2002:a05:600c:458f:b0:418:2ab6:7123 with SMTP id r15-20020a05600c458f00b004182ab67123mr640864wmo.10.1715027498746;
        Mon, 06 May 2024 13:31:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgIhgjTXfy7cH+2Xg/BsJQfExLF3SgXQuDXaGqKfDiCw4z80uW+oCT8B9ZGn9i82fViDezTw==
X-Received: by 2002:a05:600c:458f:b0:418:2ab6:7123 with SMTP id r15-20020a05600c458f00b004182ab67123mr640827wmo.10.1715027498275;
        Mon, 06 May 2024 13:31:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:bf00:182c:d606:87cf:6fea? (p200300cbc74bbf00182cd60687cf6fea.dip0.t-ipconnect.de. [2003:cb:c74b:bf00:182c:d606:87cf:6fea])
        by smtp.gmail.com with ESMTPSA id v23-20020a5d5917000000b00346ceb9e060sm11412293wrd.103.2024.05.06.13.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 13:31:37 -0700 (PDT)
Message-ID: <42b09dc5-cfb1-4bd7-b5e3-8b631498d08f@redhat.com>
Date: Mon, 6 May 2024 22:31:36 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: do not update memcg stats for
 NR_{FILE/SHMEM}_PMDMAPPED
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
References: <20240506192924.271999-1-yosryahmed@google.com>
 <d99b6375-cbae-41f1-9221-f1dd25aab150@redhat.com>
 <Zjk7AJGUsjR7TOBr@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zjk7AJGUsjR7TOBr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.05.24 22:18, Yosry Ahmed wrote:
> On Mon, May 06, 2024 at 09:50:10PM +0200, David Hildenbrand wrote:
>> On 06.05.24 21:29, Yosry Ahmed wrote:
>>> Previously, all NR_VM_EVENT_ITEMS stats were maintained per-memcg,
>>> although some of those fields are not exposed anywhere. Commit
>>> 14e0f6c957e39 ("memcg: reduce memory for the lruvec and memcg stats")
>>> changed this such that we only maintain the stats we actually expose
>>> per-memcg via a translation table.
>>>
>>> Additionally, commit 514462bbe927b ("memcg: warn for unexpected events
>>> and stats") added a warning if a per-memcg stat update is attempted for
>>> a stat that is not in the translation table. The warning started firing
>>> for the NR_{FILE/SHMEM}_PMDMAPPED stat updates in the rmap code. These
>>> stats are not maintained per-memcg, and hence are not in the translation
>>> table.
>>>
>>> Do not use __lruvec_stat_mod_folio() when updating NR_FILE_PMDMAPPED and
>>> NR_SHMEM_PMDMAPPED. Use __mod_node_page_state() instead, which updates
>>> the global per-node stats only.
>>>
>>> Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/lkml/0000000000001b9d500617c8b23c@google.com
>>> Fixes: 514462bbe927 ("memcg: warn for unexpected events and stats")
>>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
>>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>>> ---
>>>    mm/rmap.c | 15 +++++++++------
>>>    1 file changed, 9 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 12be4241474ab..ed7f820369864 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1435,13 +1435,14 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
>>>    		struct page *page, int nr_pages, struct vm_area_struct *vma,
>>>    		enum rmap_level level)
>>>    {
>>> +	pg_data_t *pgdat = folio_pgdat(folio);
>>>    	int nr, nr_pmdmapped = 0;
>>>    	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
>>>    	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
>>>    	if (nr_pmdmapped)
>>> -		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
>>> +		__mod_node_page_state(pgdat, folio_test_swapbacked(folio) ?
>>>    			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
>>>    	if (nr)
>>>    		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);
>>> @@ -1493,6 +1494,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>    		enum rmap_level level)
>>>    {
>>>    	atomic_t *mapped = &folio->_nr_pages_mapped;
>>> +	pg_data_t *pgdat = folio_pgdat(folio);
>>>    	int last, nr = 0, nr_pmdmapped = 0;
>>>    	bool partially_mapped = false;
>>>    	enum node_stat_item idx;
>>> @@ -1540,13 +1542,14 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
>>>    	}
>>>    	if (nr_pmdmapped) {
>>> +		/* NR_{FILE/SHMEM}_PMDMAPPED are not maintained per-memcg */
>>>    		if (folio_test_anon(folio))
>>> -			idx = NR_ANON_THPS;
>>> -		else if (folio_test_swapbacked(folio))
>>> -			idx = NR_SHMEM_PMDMAPPED;
>>> +			__lruvec_stat_mod_folio(folio, NR_ANON_THPS, -nr_pmdmapped);
>>>    		else
>>> -			idx = NR_FILE_PMDMAPPED;
>>> -		__lruvec_stat_mod_folio(folio, idx, -nr_pmdmapped);
>>> +			__mod_node_page_state(pgdat,
>>
>> folio_pgdat(folio) should fit here easily. :)
>>
>> But I would actually suggest something like the following in mm/rmap.c
> 
> I am not a big fan of this. Not because I don't like the abstraction,
> but because I think it doesn't go all the way. It abstracts a very
> certain case: updating nr_pmdmapped for file folios.
> 

Right. It only removes some of the ugliness ;)

> I think if we opt for abstracting the stats updates in mm/rmap.c, we
> should go all the way with something like the following (probably split
> as two patches: refactoring then bug fix). WDYT about the below?
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 12be4241474ab..70d6f6309da01 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1269,6 +1269,28 @@ static void __page_check_anon_rmap(struct folio *folio, struct page *page,
>   		       page);
>   }
>   
> +static void __foio_mod_stat(struct folio *folio, int nr, int nr_pmdmapped)
> +{
> +	int idx;
> +
> +	if (nr) {
> +		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
> +		__lruvec_stat_mod_folio(folio, idx, nr);
> +	}
> +	if (nr_pmdmapped) {
> +		if (folio_test_anon(folio)) {
> +			idx = NR_ANON_THPS;
> +			__lruvec_stat_mod_folio(folio, idx, nr_pmdmapped);
> +		} else {
> +			/* NR_*_PMDMAPPED are not maintained per-memcg */
> +			idx = folio_test_swapbacked(folio) ?
> +				NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED;
> +			__mod_node_page_state(folio_pgdat(folio), idx,
> +					      nr_pmdmapped);
> +		}
> +	}
> +}
> +

I didn't suggest that, because in the _anon and _file functions we'll 
end up introducing unnecessary folio_test_anon() checks that the 
compiler cannot optimize out.

But at least in the removal path it's a clear win.

-- 
Cheers,

David / dhildenb


