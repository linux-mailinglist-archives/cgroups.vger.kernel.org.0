Return-Path: <cgroups+bounces-10459-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83957BA1355
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 21:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4279B4A0618
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 19:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3657431CA6D;
	Thu, 25 Sep 2025 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buwpZ08M"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3563A1DF27D
	for <cgroups@vger.kernel.org>; Thu, 25 Sep 2025 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828912; cv=none; b=DgMKL2xtruN0E/B0Uyk5RBtNRuiT7f0wtiG4bCDAdBDjQAVqOmx5UyRZwy2MGKtrx79Ll0jt7mv6pravqiXd+hCPxsAr5hEl+T43aJy5gA2eoHt7+kjDdqd0MepG+9VfD13Oy3eT0AywK/FG0f0lKz3Z06PEGtgxUFKWkuytfjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828912; c=relaxed/simple;
	bh=yy6R3RX7QKq2URoVhACzS9tBUVK/EYrCqKqEEOzYF7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b99zqqHcsbjzbPAMqzjIvev7GifwoepFcaGPY9Kh0H6tkR9b9ChxWeWjNFM7z+qn1TOEWWHHbdM8RO27me/kMG0GBjyludrebuV/N6leR5vShuazCKc1jW2GKDhtX56qMV+RVIJMVceghPj3Es1VWWO47iYW1qYk+DIhJuPW3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=buwpZ08M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758828909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VJwwywmn8MlVeferLmRGbOLpNjhdj0h30dn2f1aSujg=;
	b=buwpZ08MmWBYKSX5DglDcJC86LzHevyf1wHGU0qA0MDvIfz2FSkRMp/Vpjb7KTxdzwK20a
	3gy9pvdh4goKGliQNoTeXKDuvS7QqVvGnL6VwFTiAHU/3Nj/p1fhuRsBBz0d+AMaUFg3m2
	wfU5zm98KvVPK2dHMcreMtEAh7IhX+E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-vwrr7glyOf6HZ8VoVLlqSg-1; Thu, 25 Sep 2025 15:35:06 -0400
X-MC-Unique: vwrr7glyOf6HZ8VoVLlqSg-1
X-Mimecast-MFC-AGG-ID: vwrr7glyOf6HZ8VoVLlqSg_1758828905
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e330a1946so7069375e9.1
        for <cgroups@vger.kernel.org>; Thu, 25 Sep 2025 12:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758828905; x=1759433705;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJwwywmn8MlVeferLmRGbOLpNjhdj0h30dn2f1aSujg=;
        b=SNS3YYHiUyAuOjjEmPRmvFwNM6mpMEAPpxtwoe8qoWpILKA2YLkriwl95jIypqGU/U
         IJrW+g+GjgnyJevJofaKd+6H/0wlJBmJlKgXLgko1Rf6egMUzOva8UaHzJtvuGSwhJNY
         2igBAHA0ylGg/lSFrXaPGkZ2/YK8guouyCOvOjQXZeuJQ72RBnCpvejyUBAuyGTrfTN9
         vTYsVdLoI96k1kdNN5UXva+flHYFS0hMdaa2VCoAW1eAN8dmizmYWbKzo5gf4wmmdGLn
         WVJCRoc04cfP/9dtdp4nks34h4plcfPODuxQCJ5heMeIpCtw/yp7FwNoVMuBFltnnY8N
         K7tA==
X-Forwarded-Encrypted: i=1; AJvYcCW1u7/nfjNVF3b00VpFT7qWjDHQsZXcY/08ZdMUQP4Y04RmdXyjFrtkLIsBL7PSCgNgeT36ghlG@vger.kernel.org
X-Gm-Message-State: AOJu0YzysNh/qIBOK1e81SctrAAyQKtD4r+KyJPFxV5PyNPT4VhXLpM9
	6H5o5TCSqJt+eAaQ+9UlXCjcu/jbPaRIEdgpYMZKTy84loHHSBBLsMlxg6dYm6MNw6BsrvEjjNV
	uddafYmIMBQvt71uVELGEt3ytSYT2+036nWveo5gRFA+xfUmjN/BD5FvKR9o=
X-Gm-Gg: ASbGncvw+miYUME5Gofqw5Tp9C3Bb5/sGHDNtmCzI7lfuc3TthvzrAtv1zPKIVTK+tQ
	jSttEk5UgD1+Ua7kOcapROSkydZwN8EUm6CzhwwiIsjVquUdxCvTVJ5B6R72Yjri3Sn/aiyMS+z
	iUz4nLcpHS+W01O3DytAzQCpLNoc51wYxc8G0ZbdXJ9Ule3Nf+pYR2S+do4Rw2RkfAnGKWHdAYt
	odJKjHblKDoaxJIUbviPWXdRbH8MF1RF+pPYgs1QCt40JLvW2YXzDq1s7Jcka6abpBKf2SKvlRc
	nYUJ5EAprP7J41g6h76JBjqg9YTZqbrD+GnVl4BFc9z0ZSJsqastIl90HnwB2BLmhwNyajzeJDC
	jNY7UJeonclbRaENp0G59rokyLaHDVJOEtGc2fPtNkhvivRTKhbOh/ezOwPPvK0utimAH
X-Received: by 2002:a05:600c:c04b:10b0:46e:2d0d:8053 with SMTP id 5b1f17b1804b1-46e32a30481mr40382325e9.18.1758828904929;
        Thu, 25 Sep 2025 12:35:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd82MPk0+1Hmip3UQRbBk+SH7Cq3z6WmT4cbaRtBd04WMOf1YdLsAcp6Q0b+Vu83a2w7bdQg==
X-Received: by 2002:a05:600c:c04b:10b0:46e:2d0d:8053 with SMTP id 5b1f17b1804b1-46e32a30481mr40382185e9.18.1758828904542;
        Thu, 25 Sep 2025 12:35:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08? (p200300d82f3ff800c1015c9f3bc93d08.dip0.t-ipconnect.de. [2003:d8:2f3f:f800:c101:5c9f:3bc9:3d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9b6e1bsm99082945e9.10.2025.09.25.12.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:35:04 -0700 (PDT)
Message-ID: <39f22c1a-705e-4e76-919a-2ca99d1ed7d6@redhat.com>
Date: Thu, 25 Sep 2025 21:35:02 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
To: Qi Zheng <zhengqi.arch@bytedance.com>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
 <b041b58d-b0e4-4a01-a459-5449c232c437@redhat.com>
 <46da5d33-20d5-4b32-bca5-466474424178@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <46da5d33-20d5-4b32-bca5-466474424178@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.09.25 08:11, Qi Zheng wrote:
> Hi David,

Hi :)

[...]

>>> +++ b/include/linux/mmzone.h
>>> @@ -1346,6 +1346,7 @@ struct deferred_split {
>>>        spinlock_t split_queue_lock;
>>>        struct list_head split_queue;
>>>        unsigned long split_queue_len;
>>> +    bool is_dying;
>>
>> It's a bit weird to query whether the "struct deferred_split" is dying.
>> Shouldn't this be a memcg property? (and in particular, not exist for
> 
> There is indeed a CSS_DYING flag. But we must modify 'is_dying' under
> the protection of the split_queue_lock, otherwise the folio may be added
> back to the deferred_split of child memcg.

Is there no way to reuse the existing mechanisms, and find a way to have 
the shrinker / queue locking sync against that?

There is also the offline_css() function where we clear CSS_ONLINE. But 
it happens after calling ss->css_offline(css);

Being able to query "is the memcg going offline" and having a way to 
sync against that would be probably cleanest.

I'll let all the memcg people comment on how that could be done best.

> 
>> the pglist_data part where it might not make sense at all?).
> 
> Maybe:
> 
> #ifdef CONFIG_MEMCG
>       bool is_dying;
> #endif
> 

Still doesn't quite look like it would belong here :(

Also, is "dying" really the right terminology? It's more like "going 
offline"?

But then, the queue is not going offline, the memcg is ...

-- 
Cheers

David / dhildenb


