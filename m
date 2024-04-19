Return-Path: <cgroups+bounces-2610-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 720078AAB40
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 11:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2BC81F22AEC
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 09:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF997BAEE;
	Fri, 19 Apr 2024 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMXjs/Ac"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F17279DC5
	for <cgroups@vger.kernel.org>; Fri, 19 Apr 2024 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518065; cv=none; b=bC7WEfHC9Yxi9WppPLr/N68Rc5qb2410/DVsjxfLPYsrwVAYnzDvH7tb3P4ZFQAdhprTRmQPASuZFrpjlTQXvsv1Gxe3Dz1qktJmeI2d1jDWSje+0zURGACQgMtBhQ/l2kxPgzDtvSwOGgiDOFyEYE5T7NTLWICq7e7H9Vw3irw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518065; c=relaxed/simple;
	bh=Xp2EiSEdIviNVxs+Qz+eQmTpkeDvxnaGWVXfC1igFFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFZ6WYMeaTR+8TdIuaDsQIiJMV1HI/jx083vAuRoHq6Grg/dCoiG/E4wy8wWrO8dqGMdf1GkTCakof4ufACJa7qu2DiKdGR4bWnK591ZpYtAcplWKeoUhjbmVVjZdGj/wQ+nD/NnpnCYTy60TQPgFh+oasOh2E5orgnyu7jIVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMXjs/Ac; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713518063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EqwO0572yowA0TBakaonePZNHGnWtzDXOOjoM1DutVs=;
	b=OMXjs/AcDnlzE8Fg8DdXZdl/HWq3t1iz+OHCSaTzsdNSjvpw+ReyEa4elfLS8gVoHxamBM
	bxX8WVNZrSjoICtNaeZT6KZwLen96xnoIzWRiKhGqKTmKd4862j6oaUiRogyIWty/G+Zcg
	D9tvYE9beibbK1WIfNe7oRBjGZGwCFc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-zVEMGgUNPG6nH8J4TwDcgA-1; Fri, 19 Apr 2024 05:14:21 -0400
X-MC-Unique: zVEMGgUNPG6nH8J4TwDcgA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-417de456340so10314235e9.2
        for <cgroups@vger.kernel.org>; Fri, 19 Apr 2024 02:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713518061; x=1714122861;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EqwO0572yowA0TBakaonePZNHGnWtzDXOOjoM1DutVs=;
        b=rLm3FOjFjlTFrsKmj9rLrx2U8HQ0BcmetMi7y+rLPn/c5cQOXijIC0EPMa7w4peUZ8
         /TS/Hd2zoArAn7N7Sej8h3cZIkCzsjazRk82NyvT3D/HCN6CgVaxvCx0IaoElMp/Vq1a
         j7TxzN5fwqgEqPqv/tZq1G3t5tSXbWc2+cHKC5z9qDK1DwtpfKr+OOl69VQ0GZ/ZjSWB
         mrhwYmtX8zozvHfG87azIYpYixvYugA1W3qelG9ENIA7Mr1a35YfP8uvmvFjldwW2q5U
         gVTO7jC8IrMk9ty+Veeh7yxA9rUxoswMrHOXA8jSQTPHJNFhSRuyO2ghGkfz3O5rr0uy
         IJaA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0IXaaghkLNhrdrRMlYVqbO9KKqqiNBszd586528zlojw8MqRc1t0zMH1edqyXrdAFZqBplIr44V+WQt+ynR5BqOYlb25EA==
X-Gm-Message-State: AOJu0YwC9OfT/uH+4hZvak/J4xa85YUyAuRsUePRdaNSuQ92srxB/wD6
	edHRtOCHnz7rYNOFX4/YmpYI/L1mNiv0iFwyLNnzggzn/ms72DyLaVZratjUER7rKtcSBwxWpxL
	KMaiX3KZsemkymGgucJTOHs7Y9bu7ukjkVjfpgBfMry4WVUaRYHQYwuM=
X-Received: by 2002:a05:600c:c16:b0:418:fdcc:7080 with SMTP id fm22-20020a05600c0c1600b00418fdcc7080mr1087559wmb.12.1713518060737;
        Fri, 19 Apr 2024 02:14:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5KCUiiuZF9OZuh6RkThz19zIB1mi9FMS0XWUZ94xu1t5eHJnPpGKa3Ly3AFrnJLxt6FqYug==
X-Received: by 2002:a05:600c:c16:b0:418:fdcc:7080 with SMTP id fm22-20020a05600c0c1600b00418fdcc7080mr1087525wmb.12.1713518060295;
        Fri, 19 Apr 2024 02:14:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c716:f300:c9f0:f643:6aa2:16? (p200300cbc716f300c9f0f6436aa20016.dip0.t-ipconnect.de. [2003:cb:c716:f300:c9f0:f643:6aa2:16])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c358f00b00418ef96472asm4398962wmq.0.2024.04.19.02.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 02:14:19 -0700 (PDT)
Message-ID: <bcd887c8-9830-42ed-b43a-2fdaa11dc837@redhat.com>
Date: Fri, 19 Apr 2024 11:14:18 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/18] mm/rmap: always inline anon/file rmap
 duplication of a single PTE
To: "Yin, Fengwei" <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Peter Xu
 <peterx@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Muchun Song <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <naoya.horiguchi@nec.com>,
 Richard Chang <richardycc@google.com>
References: <20240409192301.907377-1-david@redhat.com>
 <20240409192301.907377-3-david@redhat.com>
 <c5c2ae26-d405-4b0f-8bf6-281abcdb3239@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c5c2ae26-d405-4b0f-8bf6-281abcdb3239@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.04.24 04:25, Yin, Fengwei wrote:
> 
> 
> On 4/10/2024 3:22 AM, David Hildenbrand wrote:
>> As we grow the code, the compiler might make stupid decisions and
>> unnecessarily degrade fork() performance. Let's make sure to always inline
>> functions that operate on a single PTE so the compiler will always
>> optimize out the loop and avoid a function call.
>>
>> This is a preparation for maintining a total mapcount for large folios.
>>
>> Signed-off-by: David Hildenbrand<david@redhat.com>
> The patch looks good to me. Just curious: Is this change driven by code
> reviewing or performance data profiling? Thanks.

It was identified while observing an performance degradation with small 
folios in the fork() microbenchmark discussed in the cover letter 
(mentioned here as "unnecessarily degrade fork() performance").

The added atomic_add() was sufficient for the compiler not inline and 
optimize-out nr_pages, inserting a function call to a function where 
nr_pages is not optimized out.

-- 
Cheers,

David / dhildenb


