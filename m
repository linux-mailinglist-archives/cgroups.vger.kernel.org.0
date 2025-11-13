Return-Path: <cgroups+bounces-11913-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA22C55A1C
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 05:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42B33349C79
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 04:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95D12DC798;
	Thu, 13 Nov 2025 04:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIG5KhQz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YiRJbblu"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FA72D9EE2
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 04:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763007139; cv=none; b=XUjv+E0syR3XIj3mnThpFzbZn9M6b7WXj+dMdjYHFGaV2+658He4fT15/C/1yqj05VvSrGytocZE9fyU+rfuHvierK6ld3V/wCPyCXzE2P2pEF8GtCMFMgl0Q9hNEM58MaZIqoAq4B/V0L8znwkxMMTLxk5hKl3oQbg86PxWmIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763007139; c=relaxed/simple;
	bh=5KVcUwFam+d3kfWZaKYqsgN5CXXYEyx0nSIK4JVGF1c=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BKgEDxJgXWNSazhLUZIFfGUhArXsCYuw9AUln7Ri/AaMOGqm6y4YcuK/RbaGbawK1WvGuMXJmH6nsnKGOH+YQLbsyeDHELHYN0IX0G/BhHZY6nmjaghVncBM4hT6BNDU4zd8UNUZP8XWBlI2824VZi23yd0qm3xhl0GOr/dFtxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIG5KhQz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YiRJbblu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763007137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXF2BvFrpcJte5UaMjynGshHJ8MIVF48yxM6S+pDvV4=;
	b=fIG5KhQzasVtoJSdBd9yG6ME2o2Tm8wmTbC6ZJA68bc40Nb707bajzHlJ8ikMyOim6fQcL
	s+XmXiLPI33A91abaDsABNFhdZoMOKMOMw1fMN4cH1FLDJW0uEiM/ZOrTOQyA3EkYgMqwX
	x27OuPZLbfeAGlGeYvgHFsP+cHBjZ9c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-fnMpvLsnP6OoVH8Qrs_kkg-1; Wed, 12 Nov 2025 23:12:15 -0500
X-MC-Unique: fnMpvLsnP6OoVH8Qrs_kkg-1
X-Mimecast-MFC-AGG-ID: fnMpvLsnP6OoVH8Qrs_kkg_1763007135
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8805054afa1so10662426d6.0
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 20:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763007135; x=1763611935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PXF2BvFrpcJte5UaMjynGshHJ8MIVF48yxM6S+pDvV4=;
        b=YiRJbblusMl0T6AQKNqzBM00P628i/eBpaDgGFXuoFGV1OyHPbO+9QhLPMWNdznaCO
         hwjjsdyasfWYPzvABQDVcAG8XVRS4MG9wWEFGVCaw9NfaJxFf9ZCgrr/29qSuoG4pwKo
         IOSmDWOPDDXFySES9PoFH88/LehNn/nlyo4BTIycZJV+oNBZe6slEcXXOb2nwnsw7mMW
         OEp5ZNyvPFyf/LKklj7i+gXrJ8qjl5nwW+96HROfKgjISpVU8XMXg4wvwurR5lwuFy6S
         /AXNaioXuGeIgnfN305mghZH/XBV0pPiph7AAuIYFBB8xWZG0IcGKzJ05W9rRpyaGUhy
         ixFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763007135; x=1763611935;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXF2BvFrpcJte5UaMjynGshHJ8MIVF48yxM6S+pDvV4=;
        b=IdO+tCdioJJUW1oWF67u8QxXC9P3O6oTJ0jg7hxgl1OmT9CeD6VvHWI8g9QzP0nARo
         VWQUuaCmDHCby2/DI112Qee9/vy9lwNqroRwiGJBlGKijKMc2d/e/WLI2Sb1WnaWfEHD
         NOJMNdas5Glyo1eF0Sqbs/iAmEnQrqiMmCmU2rtem5duhSfN/bM109bRHPInJ5XEvx7V
         PIcv9YlmDK9qT+/41MMS2Ctfc4qMY4/iF3GHrAr0ovgwf/YZgTPnBhsA2JcMOnBd7vnE
         ghbSRB48S6TeC+uXuqCbcqjTLtt3PxYSIOxUeLlJ0NGHNf0OXrHnnMj1oOTbDbQnAsI5
         U90A==
X-Forwarded-Encrypted: i=1; AJvYcCWQEPwWrId2lYG+izhBsbTyS8fRP7S+KSz3yPN8AgSaPbBXQWSJYRJJngjBgVnOSqq38vfZ0Uap@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ghz4xp1ff0P1Gw/erYh6NHCl9TR96Ul9KKpPHXTDkTUD5dGb
	78IwXam2OmgbzVRN9CPtAGWpRsWA1rt+42331eoKgoU1IyVUqB4QDPv3aJ6zTheRebb6OlZm22i
	TMVagxbQ34NYttRbwKeK3IdgruOARaFYq+scXGD7yXR7Fz0BJrVst/AHFNtU=
X-Gm-Gg: ASbGncuYtCc927/neo8ASy9tI3ut2kdNsnPPeskNhu4Gc+gevkfbrSbvMQKAA1r53xT
	4ESHHj8PHnKcbW5LfatQPDPWhDZWlfmohh+JEWkqam6kN4uCcMv0NNHYKf7q3I1ksufh2g2Z8Xj
	D13ru3VaTsilZF9iOnmuHLUgxt4MJOMOZlEtJQiFFjeyuaJJXh/Rnvsuoj8k1jp+TH8Z20SkCpt
	QoheSWD5SPgzDxJyn90DbC4KJZvZWA+XqEvGFKg2Col5vKJKdpwZodQa/uGY6yamJvmCEDKq7Hk
	qUvUy7E/g2MBtAFdjba6QV2VrpKzdvq/aSntVmDkDRJZJ/cN+E7UTsnt43OQWu8NpZl677GwUL3
	GgxstZzbCR0VdcOVhgdOiIfc6rFNnbfI9M89WgnFvQPvTuw==
X-Received: by 2002:a05:6214:1c48:b0:880:4bdd:eb99 with SMTP id 6a1803df08f44-88271a39bf8mr81658496d6.50.1763007135031;
        Wed, 12 Nov 2025 20:12:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRDhCLizq1RLY3ln4mDWmpcPMOmzDiMDvejsHPgswmKFEfCLHM0V9nS2E9rZHYrxzUs/bBHw==
X-Received: by 2002:a05:6214:1c48:b0:880:4bdd:eb99 with SMTP id 6a1803df08f44-88271a39bf8mr81658336d6.50.1763007134668;
        Wed, 12 Nov 2025 20:12:14 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286318333sm4839906d6.24.2025.11.12.20.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 20:12:14 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b97e1f53-3b6a-4d2a-82fc-3150565e266a@redhat.com>
Date: Wed, 12 Nov 2025 23:12:13 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuset: Avoid unnecessary partition invalidation
To: Sun Shaojie <sunshaojie@kylinos.cn>, chenridong@huaweicloud.com
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <b9dce00a-4728-4ac8-ae38-7f41114c7c81@redhat.com>
 <20251113033322.431859-1-sunshaojie@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20251113033322.431859-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/25 10:33 PM, Sun Shaojie wrote:
> The reviewer mentioned they couldn't see my original patch, so I'm
> re-quoting the key changes below for clarity:
>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 52468d2c178a..e0d27c9a101a 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -586,14 +586,14 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>>   * Returns: true if CPU exclusivity conflict exists, false otherwise
>>   *
>>   * Conflict detection rules:
>> - * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
>> + * 1. If both cpusets are exclusive, they must be mutually exclusive
>>   * 2. exclusive_cpus masks cannot intersect between cpusets
>>   * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
>>   */
>> static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>> {
>> -	/* If either cpuset is exclusive, check if they are mutually exclusive */
>> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>> +	/* If both cpusets are exclusive, check if they are mutually exclusive */
>> +	if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
>> 		return !cpusets_are_exclusive(cs1, cs2);
>>
>> 	/* Exclusive_cpus cannot intersect */
> Here are the main changes, where the conflict check for step #6 in Table 2
> is performed. And these changes have no effect on cgroup v1.

cpus_excl_conflict() is called by validate_change() which is used for 
both v1 and v2.

Cheers,
Longman


