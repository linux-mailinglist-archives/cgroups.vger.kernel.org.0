Return-Path: <cgroups+bounces-2803-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCED8BD548
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 21:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B8B28319A
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91DB158DC7;
	Mon,  6 May 2024 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yi2CiAxz"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275513C69F
	for <cgroups@vger.kernel.org>; Mon,  6 May 2024 19:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023104; cv=none; b=T0+/3LtfqUWIOOnMaq18r3PIhUM6ZkNtNEnM8Yl7/dx0SCBPjRyEfjeSKw5ziDD/KKsB5clDjYoiPVSVFnmSrFI0E3UaUzMFokX/CzxbhYpjSajoEsKCUngdjBjbYhS5TgBMJg4LIP92DPwIDR8c21JKNqwnltNx5dIbhio04ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023104; c=relaxed/simple;
	bh=k0daznuM1+QYLnXWQbrsmVcekWkDjUl+NqlKnkli4NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctpxLY8L7iJTKMsCPrAxP+UFj2w4eSWZtsNzG3QZBdZ/HXbyQV+uDIxNMuWoV6RqQ1wNzQFArXOi8TRkw1nJ6X7raNeWFFsVPrm6e8KSn0r2AJXek7EcxZyWXM5h9Cf4cF+A9mxjp1L3HF+PfhUk89gcsJFoVxmOq1CcWkFjThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yi2CiAxz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715023101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L0itG5n8en1QP9QC0UQ1zw+U4P2Qru8sUoqUPu1ADzA=;
	b=Yi2CiAxzjAVYqVaftV2CSIvxjmoiN3A4HhsRiFWRHlwaAsp2Mv98s+llByL55rXUE0Z8B+
	mNA/BOUan1IcfKYzeg7S8OZjv191hMbOjIUO3SgVQqHcFcbZyGjVjfefolD20HQaQn+e+l
	6t9rWAVvK6uqkAcJ+4JNAGOuPgK7l90=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-izghjLz0OBedhaudHjoGQQ-1; Mon, 06 May 2024 15:18:20 -0400
X-MC-Unique: izghjLz0OBedhaudHjoGQQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2e25bab1424so15470611fa.3
        for <cgroups@vger.kernel.org>; Mon, 06 May 2024 12:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715023099; x=1715627899;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L0itG5n8en1QP9QC0UQ1zw+U4P2Qru8sUoqUPu1ADzA=;
        b=NBjxmQ/ULv6ntNGLzlfje24UGlXuJlMPoL2bBNSF6g7LhcQCCVhNTM9l4cBfMHsfb6
         UIEcnEfXtd81PwExNJ+zwh5pJsXpaMOc0s2ES3OZmkabvKWuEVz+qu9POThsry8uvy18
         ft2mjODilpqa45kUTbWf4V/nV9Bd2h2lGiuEvd0G0go7ADpXGZXm9d958fIcANbsCi09
         WY9eWF+nE5nX8IGmDaZhaWqAHZSTwN03VFndR45eK5YqFyUxvYYzL6EMSUlXBtV5ctC4
         eC0f09k9PaguN86ZFVfLJuYwluiCNF/a37WbyUROI25aPPuE2N0EzV2JbdsGjZVO5mUa
         /yow==
X-Forwarded-Encrypted: i=1; AJvYcCUAnplOLx8MJfZ0Lu/AkfknM90/+qQqYe9lZZeR2AW6ADwdrGNnv7+oD8XpbXxQkIpfMF2bEbjpiQtrHTOCbdzvHzpNxvFgTg==
X-Gm-Message-State: AOJu0Yz4150TRE4RQYSmE5vJ0qzYJBCLBz6jficX/utNH0w0WOw2cBJa
	re7+I/zsyi0QU7iuWUwrq1weBQtBw0id5TBWGQ9W438GjEsPZSs0Rs+RwuJ2B3Cf2As3FGmN1wy
	bJ1FfdgERa6tGxzDMXR62l4NLKSlW1D2bU2iC3pXujWJFSCod54r52vQ=
X-Received: by 2002:a2e:be03:0:b0:2e0:c6ec:bcc1 with SMTP id z3-20020a2ebe03000000b002e0c6ecbcc1mr7571404ljq.45.1715023098948;
        Mon, 06 May 2024 12:18:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo2gUPC1i/xcQESDY8BN5lT9tpYqSixSUd/jFbyXrwtj5agefi6tPI4djtTPG8IslTx/Frjg==
X-Received: by 2002:a2e:be03:0:b0:2e0:c6ec:bcc1 with SMTP id z3-20020a2ebe03000000b002e0c6ecbcc1mr7571377ljq.45.1715023098303;
        Mon, 06 May 2024 12:18:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:bf00:182c:d606:87cf:6fea? (p200300cbc74bbf00182cd60687cf6fea.dip0.t-ipconnect.de. [2003:cb:c74b:bf00:182c:d606:87cf:6fea])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b0041be609b1c7sm20714480wmg.47.2024.05.06.12.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 12:18:17 -0700 (PDT)
Message-ID: <d189730a-aab7-4a3b-bc0f-6abe17ea2c91@redhat.com>
Date: Mon, 6 May 2024 21:18:16 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: do not update memcg stats for
 NR_{FILE/SHMEM}_PMDMAPPED
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
References: <20240506170024.202111-1-yosryahmed@google.com>
 <d546b804-bb71-45c7-89c4-776f98a48e77@redhat.com>
 <CAJD7tkaPvYWhrMSHmM0n0hitFaDdusq7gQ=7+DTUQLODGdo6RQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAJD7tkaPvYWhrMSHmM0n0hitFaDdusq7gQ=7+DTUQLODGdo6RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06.05.24 20:52, Yosry Ahmed wrote:
> On Mon, May 6, 2024 at 11:35 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 06.05.24 19:00, Yosry Ahmed wrote:
>>> Do not use __lruvec_stat_mod_folio() when updating NR_FILE_PMDMAPPED and
>>> NR_SHMEM_PMDMAPPED as these stats are not maintained per-memcg. Use
>>> __mod_node_page_state() instead, which updates the global per-node stats
>>> only.
>>
>> What's the effect of this? IIUC, it's been that way forever, no?
> 
> Yes, but it has been the case that all the NR_VM_EVENT_ITEMS stats
> were maintained per-memcg, although some of those fields are not
> exposed anywhere.
> 
> Shakeel recently added commit14e0f6c957e39 ("memcg: reduce memory for
> the lruvec and memcg stats"), which changed this such that we only
> maintain the stats we actually expose per-memcg (via a translation
> table).

Valuable information we should add to the patch description :)

> 
> He also added commit 514462bbe927b ("memcg: warn for unexpected events
> and stats"), which warns if we try to update a stat per-memcg that we
> do not maintain per-memcg (i.e. the warning firing here). The goal is
> to make sure the translation table has all the stats it needs to have.
> 
> Both of these commits were just merged today into mm-stable, hence the
> need for the fix now. It is the warning working as intended. No Fixes
> or CC stable are needed, but if necessary I would think:

WARN* should usually be "Fixes:"d, because WARN* expresses a condition 
that shouldn't be happening.

Documentation/process/coding-style.rst contains details.

> 
> Fixes: 514462bbe927b ("memcg: warn for unexpected events and stats")
> 
> , because without the warning, the stat update will just be ignored.
> So if anything the warning should have been added *after* this was
> fixed up.

Ideally, yes. But if it's in mm-stable, we usually can no longer 
reshuffle patches (commit IDs stable).

-- 
Cheers,

David / dhildenb


