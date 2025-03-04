Return-Path: <cgroups+bounces-6807-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2B1A4DA49
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 11:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED65176931
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 10:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949BF1FF1A4;
	Tue,  4 Mar 2025 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijyBhMRt"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB921FF1B0
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083707; cv=none; b=l4EkflczV1daTN1oGq5K8AwliVKqb8wm8JPMcXLSvrmDL23Qs1So5SLRE44uqgAqWMaCQlmhr3xzcLypovOOJ/kPQkd0ilp3fPpLDehCg1QMKGT5Elb1B7qI85Abe/PymLkNl5abxJ9CfNN1LKDDsjreRKvbf/jQiTo/KS340w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083707; c=relaxed/simple;
	bh=e7RM6hNb9ihF8EOVgJ5wclsgFLjxdYyGBdLQpDqENwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eedP5cfS92rzlN+hFvCtykk1KgSRZNTvnFEeIVy1q7pVjro/VV4sQGGd9FZ4vU6PTJqJYGqCsiPp2aJYeb5yvrVYvvHkHhLWuj77si5Df9+NfDBdH4hSsMK0M8F8ybymzDLfz+/60UbLoWyAwHqlDbqNWhn28Wpq16/GUzADjXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijyBhMRt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741083704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G0GXHJX1K7E5e2wBQk1oB0WcGldIFjvSOHPSzQdYz+4=;
	b=ijyBhMRteUyGjH61jqUQ1bkWlIQVi2mFwJevBk2cQz2L+PV4i1mSwAcC1TqAAeCHmGUJaP
	QRkFN8QgkZCwQdUJqDocmOQ/dP6YsxBnV6hDv/OKltpi56gQuUl5aivtEBkePBp6n9Qx8i
	OGVkBGdYerDSV+1oZf+mVyE+/BsuqGk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-DjRgcHSZOHSLYEMZ2oY96g-1; Tue, 04 Mar 2025 05:21:41 -0500
X-MC-Unique: DjRgcHSZOHSLYEMZ2oY96g-1
X-Mimecast-MFC-AGG-ID: DjRgcHSZOHSLYEMZ2oY96g_1741083700
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390ee05e2ceso2543973f8f.3
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 02:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741083700; x=1741688500;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G0GXHJX1K7E5e2wBQk1oB0WcGldIFjvSOHPSzQdYz+4=;
        b=aqv7L5MPhfJwNHGaVzJ3PbeqTto7LQ7T7CzDFxVy76AGmhnQGnUIE8mommclsmM8/b
         8x4HE6p413c2RTGQ+5o+aP9HHMJCB5WHoD+C5DbA0UXVzLUCqhthmoAf0IvhQQa0Cg2g
         Zq3fRWSGRJYP6ajL+xTV9/wz8zC5QySZAn1Yf2iZPesp/xPJcxuFkURAI870cuIIqK2Y
         lxu40BA2m0F2PHcPpMiAgdPPf7m1/TTZN917dcnHD5p2CQJM8/R9CKYSEYgP1bS5vVg9
         D6PpBVrU0UitbI8Y1vn7N9XtNL4IoB+y79wmUa66MCEq/lmGVphO62BB8dlwNNQnusbj
         QotA==
X-Forwarded-Encrypted: i=1; AJvYcCUPlbB/Ai5bFeEcOPb0YOtsdGJGjCcD4xiVe14V5u2Lo7/cOkRY7qPcU4Xhurt+7Tl7yr/oCmTE@vger.kernel.org
X-Gm-Message-State: AOJu0Yysna4S4PT1On7mpMrpq2sBeHfGg6nWiq5rVFbQDKSdaaOrsxPq
	zY5iwpTFTUqHwOKJi9MZF6Y+dHCNXm2/IS7uFy4UOgc3Mz3vQnM/08LP/qPsD+DZXWfgoNd7tLM
	FeJuUz58usShxyLM2KP4itMcNeuDi5cJjDT38s/IR8NDP8GPtgSHyGFfsAK2nFCnG9g==
X-Gm-Gg: ASbGncs3f6TwD9So0/+V40F61weGQpFuY1HzthHbF+s2G8KXs3JkUQrQxh9TnuS09TP
	q6SCpXBVMaBcns3w0PQoPNkjoReku9sokfWFn2rHyqP7rITyJnOtfzoqOXsoBeNrC0DX7eHVYja
	3Lnc0e1v+Y25+LU3gZfmvm37x3Lo3SRzSVNtV4ivDT4MOgaCHwW/9Iiq9Gh8LgOLUDRDKk/m6d/
	L/ToE+2gGdqPqisAz7/85Cbm65aD55TPdh0r9u47GkZn2nbLYrXct9zo1yNSpoQvvnGYGVNEyNA
	Uz1TYqYsKiP7wqsXwxPZvJ5kpaPJQuu3acWVxfACjqRUu70k7kRgbUV5Qsr7mqGK4uzQiIQYgA/
	DfMZMGRKc5P922y+Nu0Ai/u0cQ8ghp2Q72nY0Ma2iSY8=
X-Received: by 2002:a5d:6c6e:0:b0:38d:c364:d516 with SMTP id ffacd0b85a97d-390eca81d4emr15654529f8f.54.1741083700179;
        Tue, 04 Mar 2025 02:21:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoe+t9reG+q1KXFWE83QujE4ro+8v9oe5SMfx3hNgMcGBMtEEMSM8d0V6pJPgREtHTPyF6dQ==
X-Received: by 2002:a5d:6c6e:0:b0:38d:c364:d516 with SMTP id ffacd0b85a97d-390eca81d4emr15654508f8f.54.1741083699822;
        Tue, 04 Mar 2025 02:21:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c736:1000:9e30:2a8a:cd3d:419c? (p200300cbc73610009e302a8acd3d419c.dip0.t-ipconnect.de. [2003:cb:c736:1000:9e30:2a8a:cd3d:419c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796517sm16996820f8f.5.2025.03.04.02.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 02:21:39 -0800 (PST)
Message-ID: <54433b22-edaa-421e-9c99-6ee99734ab6d@redhat.com>
Date: Tue, 4 Mar 2025 11:21:37 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/20] mm: MM owner tracking for large folios
 (!hugetlb) + CONFIG_NO_PAGE_MAPCOUNT
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Muchun Song <muchun.song@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
References: <20250303163014.1128035-1-david@redhat.com>
 <20250303144332.4cb51677966b515ee0c89a44@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250303144332.4cb51677966b515ee0c89a44@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.03.25 23:43, Andrew Morton wrote:
> On Mon,  3 Mar 2025 17:29:53 +0100 David Hildenbrand <david@redhat.com> wrote:
> 
>> Some smaller change based on Zi Yan's feedback (thanks!).
>>
>>
>> Let's add an "easy" way to decide -- without false positives, without
>> page-mapcounts and without page table/rmap scanning -- whether a large
>> folio is "certainly mapped exclusively" into a single MM, or whether it
>> "maybe mapped shared" into multiple MMs.
>>
>> Use that information to implement Copy-on-Write reuse, to convert
>> folio_likely_mapped_shared() to folio_maybe_mapped_share(), and to
>> introduce a kernel config option that let's us not use+maintain
>> per-page mapcounts in large folios anymore.
>>
>> ...
>>
>> The goal is to make CONFIG_NO_PAGE_MAPCOUNT the default at some point,
>> to then slowly make it the only option, as we learn about real-life
>> impacts and possible ways to mitigate them.
> 
> I expect that we'll get very little runtime testing this way, and we
> won't hear about that testing unless there's a failure.
> 
> Part of me wants to make it default on right now, but that's perhaps a
> bit mean to linux-next testers.

Yes, letting this sit at least for some time before we enable it in 
linux-next as default might make sense.

 > > Or perhaps default-off for now and switch to default-y for 6.15-rcX?

Maybe default-off for now, until we rebase mm-unstable to 6.15-rcX. 
Then, default on first in linux-next, and then upstream (6.16).

> 
> I suggest this just to push things along more aggressively - we may
> choose to return to default-off after a few weeks of -rcX.

Yeah, I'm usually very careful; sometimes a bit too careful :)

-- 
Cheers,

David / dhildenb


