Return-Path: <cgroups+bounces-2415-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2557E89ED40
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 10:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A41284D53
	for <lists+cgroups@lfdr.de>; Wed, 10 Apr 2024 08:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739E113D60D;
	Wed, 10 Apr 2024 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVldKFu2"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924FB1C0DD9
	for <cgroups@vger.kernel.org>; Wed, 10 Apr 2024 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736646; cv=none; b=o91Xra5dQSL23hmrybvz6eF3BgssGcWZuc/cG2uaIyJwAlwwDWKsRbaVzgVM130ew8uNmKQdPjXIXKwwCtqnlKxt54WO1tZCfaee22ciD/uYKm2YZzQ9vReEfc5wtE7Mu+KF66npgC574BhiTeGOfwSTE2RX3htq3D7fYtEGL8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736646; c=relaxed/simple;
	bh=bWW1bNKGnc9zNEcRrA9S2pmkEjgaoyLi7hnXgvIaYiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuW9aHrY0wMFM6AHmIjrt3PQViWutUO3Na654CZyTjY7M7cdJTHpGy9IXYbiAQkA+arNR/t/G1c5u0+diJi3I28oYgGp2qZOSK30lMgNph+z/hnGQC31PUdFxH27t8ppOE0Nzmw/uxYLM10wv/WGaQaaNlSXpT/ADsHYxEHxBSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVldKFu2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712736642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=t2gagp6gEUE2RSk0KLNNqhHYVxzL2Ql+nDMTWSDIXpM=;
	b=MVldKFu21fZWyXkh1DgSsMN8k+T7eqLqocmsBAthl1ChWefWqVav9xVI3iWUi+0Cs/oCu3
	HzfcXs1NmEpyRrbogKORN4FyoXS5/bsR01xRvN5hPc+95idMoqg4z+R57EcJxoc8LmAzMd
	/OAhjdFPy3QXOGOFeC49znXXK01Flm4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-YoWcev1XP-ajZHIZsjg7yg-1; Wed, 10 Apr 2024 04:10:41 -0400
X-MC-Unique: YoWcev1XP-ajZHIZsjg7yg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3455cbdea2cso1592873f8f.0
        for <cgroups@vger.kernel.org>; Wed, 10 Apr 2024 01:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712736640; x=1713341440;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t2gagp6gEUE2RSk0KLNNqhHYVxzL2Ql+nDMTWSDIXpM=;
        b=RBjO8i7Izw4Dgp3qgELOH4UHPqNf3eVebe+uUEjqorb6WyB8GSX1NNfy+IFM0428JC
         4A4r+xA+zqZmUBMiPj256NTQkx0uriEPyWnjjvyo2Twa2BaM6PIlYzsGyjfzC6DYoKvk
         /J4AltxHZD+l8rWCVHyjA7LegPd7thzU3kxSVJ7JfNHYLdt88DPBtgRfY9nkO9ad4VH4
         y+Qc7lq+1Adn1kWvXBrbr0LWIZ+5fhUPZGazpST4cnAGo4irfUdYCXPjBRVPObBVu6In
         5UgKEHe0f/J5QOICHGdu9lDb2jOJCmE/bG90XHIDRJe2F6Doa1af+DUKzYt68qYYKX+I
         Lm/g==
X-Forwarded-Encrypted: i=1; AJvYcCUIoUw89ZyZGwerUe7UQ1v5eNIZcqH5Z5Pb/iMdua8uyDp2C4pm6Hqv1gzA87yK0UPMnQL110SdAyHurS/CIYLK7+5gCQl/MA==
X-Gm-Message-State: AOJu0Yywd4j8EthVN0Q8Q4YVWQ95sti0L3fIjr1okfmCzZZ/Z2Wd2ZV6
	dGnJotd0TPl1c4x1+rT3ZVsCqlN5A5smf+2TvWgkIMgnoe3oQyYUmroTUO0AUzHCu/N3dkgUDnw
	frxzi1LzwTjDm3jkgI8Z+/YCJiGNGG7UVZsJWcVsP+kHEBmuvudmjuKc=
X-Received: by 2002:a05:6000:4025:b0:346:409d:51a4 with SMTP id cp37-20020a056000402500b00346409d51a4mr1548470wrb.24.1712736640161;
        Wed, 10 Apr 2024 01:10:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9UU0FQKU7nnMjJ7gB/9JLym+Z715gyghgHuNk4Q++d1oltyKfIeA5KFxmCyf46DkjI8aCYw==
X-Received: by 2002:a05:6000:4025:b0:346:409d:51a4 with SMTP id cp37-20020a056000402500b00346409d51a4mr1548448wrb.24.1712736639775;
        Wed, 10 Apr 2024 01:10:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:fa00:38eb:93ad:be38:d469? (p200300cbc712fa0038eb93adbe38d469.dip0.t-ipconnect.de. [2003:cb:c712:fa00:38eb:93ad:be38:d469])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d654b000000b003437fec702dsm13206489wrv.21.2024.04.10.01.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 01:10:39 -0700 (PDT)
Message-ID: <d1426c42-0630-4949-ac1d-a7f9ae89e6cb@redhat.com>
Date: Wed, 10 Apr 2024 10:10:37 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/18] mm: allow for detecting underflows with
 page_mapcount() again
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Peter Xu <peterx@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Yin Fengwei <fengwei.yin@intel.com>, Yang Shi <shy828301@gmail.com>,
 Zi Yan <ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Hugh Dickins <hughd@google.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Muchun Song <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <naoya.horiguchi@nec.com>,
 Richard Chang <richardycc@google.com>
References: <20240409192301.907377-1-david@redhat.com>
 <20240409192301.907377-2-david@redhat.com>
 <ZhW2RQtKDvUrbyWA@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZhW2RQtKDvUrbyWA@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.04.24 23:42, Matthew Wilcox wrote:
> On Tue, Apr 09, 2024 at 09:22:44PM +0200, David Hildenbrand wrote:
>> Commit 53277bcf126d ("mm: support page_mapcount() on page_has_type()
>> pages") made it impossible to detect mapcount underflows by treating
>> any negative raw mapcount value as a mapcount of 0.
> 
> Yes, but I don't think this is the right place to check for underflow.
> We should be checking for that on modification, not on read.

While I don't disagree (and we'd check more instances that way, for example
deferred rmap removal), that requires a bit more churn and figuring out of
if losing some information we would have printed in print_bad_pte() is worth
that change.

> I think
> it's more important for page_mapcount() to be fast than a debugging aid.

I really don't think page_mapcount() is a good use of time for
micro-optimizations, but let's investigate:

A big hunk of code in page_mapcount() seems to be the compound handling.
The code before that (reading mapcount, checking for the condition,
conditionally setting it to 0), would generate right now:

  177:	8b 42 30             	mov    0x30(%rdx),%eax
  17a:   b9 00 00 00 00          mov    $0x0,%ecx
  17f:	83 c0 01             	add    $0x1,%eax
  182:	0f 48 c1             	cmovs  %ecx,%eax

My variant is longer:

  17b:	8b 4a 30             	mov    0x30(%rdx),%ecx
  17e:	81 f9 7f ff ff ff    	cmp    $0xffffff7f,%ecx
  184:	8d 41 01             	lea    0x1(%rcx),%eax
  187:	b9 00 00 00 00       	mov    $0x0,%ecx
  18c:	0f 4e c1             	cmovle %ecx,%eax
  18f:	48 8b 0a             	mov    (%rdx),%rcx

The compiler does not seem to do the smart thing, which would
be rearranging the code to effectively be:

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef34cf54c14f..7392596882ae 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1232,7 +1232,7 @@ static inline int page_mapcount(struct page *page)
         int mapcount = atomic_read(&page->_mapcount) + 1;
  
         /* Handle page_has_type() pages */
-       if (mapcount < 0)
+       if (mapcount < PAGE_MAPCOUNT_RESERVE + 1)
                 mapcount = 0;
         if (unlikely(PageCompound(page)))
                 mapcount += folio_entire_mapcount(page_folio(page));


Which would result in:

  177:   8b 42 30                mov    0x30(%rdx),%eax
  17a:   31 c9                   xor    %ecx,%ecx
  17c:   83 c0 01                add    $0x1,%eax
  17f:   83 f8 80                cmp    $0xffffff80,%eax
  182:   0f 4e c1                cmovle %ecx,%eax


Same code length, one more instruction. No jumps.


I can switch to the above (essentially inlining
page_type_has_type()) for now and look into different sanity checks --
and extending the documentation around page_mapcount() behavior for
underflows -- separately.

... unless you insist that we really have to change that immediately.

Thanks!

-- 
Cheers,

David / dhildenb


