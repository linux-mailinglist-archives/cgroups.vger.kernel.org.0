Return-Path: <cgroups+bounces-12180-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 423A7C82B83
	for <lists+cgroups@lfdr.de>; Mon, 24 Nov 2025 23:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 531524E8CBA
	for <lists+cgroups@lfdr.de>; Mon, 24 Nov 2025 22:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB5E336EC3;
	Mon, 24 Nov 2025 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvYpd/Uk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WK4ptK7e"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73B431A04D
	for <cgroups@vger.kernel.org>; Mon, 24 Nov 2025 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023455; cv=none; b=j9uENjgmKE+/vcDmbMulaLjNZzq87LixAjJb9omkn5rCOTLPGD5z/fSh8LqDlNXZW8vdUU6r3rbQoVK0+63aapLoJoCqD5NeQVj1oVy2QA5nZC+yBiTEXm1D6v+0xdT+nAxYWoMse5Z+DbEPaXENrfvxux+xbF2ZUzhmO2bc92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023455; c=relaxed/simple;
	bh=Ma5Gp3Rn9XAktfuix9YxIsx1vONHyvcQA1nIX3sD0uU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=f7bDRn5v2EC7Mi/iDyhZx9vPXq2jT6b0QDYjmadngnhhJwQUz7+Rj0cHsZdN09IN+YAvwUjJNGYBRjYyh7eRUK63I012Y8eT9Slg7sgGRU09Y3/7FSDpGpKunoz2OW0POiDIQFLFyp+S70vZxpFMyKnC8evn3hWWvwN6vRwogb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gvYpd/Uk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WK4ptK7e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764023452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoP525ssCRg2OKlXGZXKs9q8PWYqzk3vCBsuJGMuCXY=;
	b=gvYpd/UkfgwALoNXQT0dV2FjZnWvynzp5k5u6iHCEJj5uYkPg71zOKJrokmfMeqKFHYm29
	jnOOLzzHiUAQCdMu4JAoqKbLdI5ohzbzkeS+RQrli+fAubOXFIqXilXpF1JnVwoy+VJXnL
	WEf/452BV0h/+5uMsShGIzL5RN1HGys=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-wp3AKBWsNOig1fOEhJuRVA-1; Mon, 24 Nov 2025 17:30:51 -0500
X-MC-Unique: wp3AKBWsNOig1fOEhJuRVA-1
X-Mimecast-MFC-AGG-ID: wp3AKBWsNOig1fOEhJuRVA_1764023451
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b23a64f334so1341364385a.2
        for <cgroups@vger.kernel.org>; Mon, 24 Nov 2025 14:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764023450; x=1764628250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KoP525ssCRg2OKlXGZXKs9q8PWYqzk3vCBsuJGMuCXY=;
        b=WK4ptK7eASrH3Mm/vi8usQ6m7a8MnaP00oZwfbKMm0kRV5CX0hf3aHTHt1/1wHBA1x
         SeNbREP9dS4U1iTTPfkz2ymeyXq6dBM+ia22XXtxxnPunJ4G8X1Yt/4r4vbMi8HRvnUW
         1RMdpBfLxteU05IEkmHChs6mfHhcTpdPLcbO64HYAj5/OM2I5fTTylmLALtuIYlvnlut
         2DB3O2fEm0LJC3rkVh+RgunObVxmCrEHrb9Wauxe1GN5ouqQFtQXaW6hXBmJVHiCkLZb
         bxeL/8h3evn2vLYe7YGlGLz4Qgzt86VMPidXgeLWUWp17OP2RIl149xEkzCy7/qGL+7c
         i/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764023450; x=1764628250;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KoP525ssCRg2OKlXGZXKs9q8PWYqzk3vCBsuJGMuCXY=;
        b=BhEHPoPg9P89tZ+5Op2pynYbymXXlYxkPKQGzKG8sumYKLc878+umd9iE6GbNN8RQx
         9GQjrb8HlFPAlGySF5bZUzvkPVsC9+m4sH4zpf83G8Ex4dIVf8h3+yKE1KFRj5af5WBQ
         RLS/Ec2+v/uPxNx79YQCV/s2cLKqxM56j+DNFcb8lRJeX+h/AEShiDxCkDrZWpItxVsv
         w+TicYiqq4s/Rs/Ao2DpaBwCnF3i7/jM4QjA7pEduqor3RgnVOaWsmjUSJSEoQfLfcyq
         yiaXourQNNb4fZ9EQN2WRU4vgnW8PwXcKLEciusbQFckGPV/mookf6/fGL2ryb8P6NJA
         DatQ==
X-Gm-Message-State: AOJu0Yx/OUWVlI2A2vZqZILaxfoWJuyA42b42yScerEg6zPzOZh1htWU
	84H4Btvrebc2N2zEYY7FNR4zvBrVPMyW5dcqKiBu6VXETv7PGL18FcMT5PGyqhrznWdVM+e65tq
	7GK9qpGhVmbAv4C/n8AFdGI6Zen8bANHzkxWzbpPgSVa+fLxcEYoXJ5xeJFY=
X-Gm-Gg: ASbGncuFuzoven0FGXjHLHlwjKvAcvBr5ov7U4c+F5CSyWTQjhn2eNqNwp6mjB+Clfs
	fyHeUQtoo+nj38TghPdvzNJEcta1NI5jZAOiIaB41usE/vsC7KnMYNrDnPtr5/dlRv7ktlrB1i4
	0hsWbfcMOigiX+QxuMmf0tmFKTSBRA/RMA1cMpRLW1RKqMUYeK60/IaDSRm1ce6WEeT1Fl/NCCg
	vqSm02V1UQULDIAb5urWdqVaiH6B+GjU9v3efrgGAYa9nrY86mnJFHierVVFIMbg3y6PJfJFukj
	4hnLxuZ2UYjQtT8NMPMxii5oQjmGi/JzStkEuotAOlh3MlKSDALXNfMvpXKfKkqBlZtyWsGMjr+
	2gynkpcaYwiyWeVnjaxtu2xodbNtgCN/8UA48KPxDO0nknwl3svn8OI3U
X-Received: by 2002:a05:620a:4103:b0:8b2:e986:2707 with SMTP id af79cd13be357-8b33d469944mr1613873985a.45.1764023450623;
        Mon, 24 Nov 2025 14:30:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxDBzOKv9gEGaZee+4kgDDEfxbFXSsDuGuND/YR/+VTzDbJflyatKadpotTWCFz9xhV/bULA==
X-Received: by 2002:a05:620a:4103:b0:8b2:e986:2707 with SMTP id af79cd13be357-8b33d469944mr1613867585a.45.1764023449993;
        Mon, 24 Nov 2025 14:30:49 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295c13ccsm1035133785a.26.2025.11.24.14.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 14:30:49 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <cae7a3ef-9808-47ac-a061-ab40d3c61020@redhat.com>
Date: Mon, 24 Nov 2025 17:30:47 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
To: Sun Shaojie <sunshaojie@kylinos.cn>, llong@redhat.com,
 chenridong@huaweicloud.com, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, tj@kernel.org
References: <f32d2f31-630f-450b-911f-b512bbeb380a@huaweicloud.com>
 <20251119105749.1385946-1-sunshaojie@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20251119105749.1385946-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/19/25 5:57 AM, Sun Shaojie wrote:
> Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
> with its sibling partition, the sibling's partition state becomes invalid.
> However, this invalidation is often unnecessary. If the cpuset being
> modified is exclusive, it should invalidate itself upon conflict.
>
> This patch applies only to the following two cases：
>
> Assume the machine has 4 CPUs (0-3).
>
>     root cgroup
>        /    \
>      A1      B1
>
> Case 1: A1 is exclusive, B1 is non-exclusive, set B1's cpuset.cpus
>
>   Table 1.1: Before applying this patch
>   Step                                       | A1's prstate | B1's prstate |
>   #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>   #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>   #3> echo "0" > B1/cpuset.cpus              | root invalid | member       |
>
> After step #3, A1 changes from "root" to "root invalid" because its CPUs
> (0-1) overlap with those requested by B1 (0). However, B1 can actually
> use CPUs 2-3(from B1's parent), so it would be more reasonable for A1 to
> remain as "root."
>
>   Table 1.2: After applying this patch
>   Step                                       | A1's prstate | B1's prstate |
>   #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>   #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>   #3> echo "0" > B1/cpuset.cpus              | root         | member       |
>
> Case 2: Both A1 and B1 are exclusive, set B1's cpuset.cpus
>
>   Table 2.1: Before applying this patch
>   Step                                       | A1's prstate | B1's prstate |
>   #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>   #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>   #3> echo "2" > B1/cpuset.cpus              | root         | member       |
>   #4> echo "root" > B1/cpuset.cpus.partition | root         | root         |
>   #5> echo "1-2" > B1/cpuset.cpus            | root invalid | root invalid |
>
> After step #4, B1 can exclusively use CPU 2. Therefore, at step #5,
> regardless of what conflicting value B1 writes to cpuset.cpus, it will
> always have at least CPU 2 available. This makes it unnecessary to mark
> A1 as "root invalid".
>
>   Table 2.2: After applying this patch
>   Step                                       | A1's prstate | B1's prstate |
>   #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>   #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>   #3> echo "2" > B1/cpuset.cpus              | root         | member       |
>   #4> echo "root" > B1/cpuset.cpus.partition | root         | root         |
>   #5> echo "1-2" > B1/cpuset.cpus            | root         | root invalid |
>
> In summary, regardless of how B1 configures its cpuset.cpus, there will
> always be available CPUs in B1's cpuset.cpus.effective. Therefore, there
> is no need to change A1 from "root" to "root invalid".
>
> All other cases remain unaffected. For example, cgroup-v1.

This patch is relatively simple. As others have pointed out, there are 
inconsistency depending on the operation ordering.

In the example above, the final configuration is A1:0-1 & B1:1-2. As the 
cpu lists overlap, we can't have both of them as valid partition roots. 
So either one of A1 or B1 is valid or they are both invalid. The current 
code makes them both invalid no matter the operation ordering.  This 
patch will make one of them valid given the operation ordering above. To 
minimize partition invalidation, we will have to live with the fact that 
it will be first-come first-serve as noted by Michal. I am not against 
this, we just have to document it. However, the following operation 
order will still make both of them invalid:

# echo "0-1" >A1/cpuset.cpus # echo "2" > B1/cpuset.cpus # echo "1-2" > 
B1/cpuset.cpus # echo "root" > A1/cpuset.cpus.partition # echo "root" > 
B1/cpuset.cpus.partition

To follow the "first-come first-serve" rule, A1 should be valid and B1 
invalid. That is the inconsistency with your current patch. To fix that, 
we still need to relax the overlap checking rule similar to your v4 patch.

Cheers,
Longman


