Return-Path: <cgroups+bounces-12600-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF0CCD83AD
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 07:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68D9F3028DB6
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 06:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332E02FBDE0;
	Tue, 23 Dec 2025 06:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3q5dXa3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1KAFwpb"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1DB2FAC14
	for <cgroups@vger.kernel.org>; Tue, 23 Dec 2025 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766469831; cv=none; b=XEDFwN9hkF7K4VGS0maDh857HdxWgcEPGWDyuc5V9oVdIYKu19vHbK3dmdW+yIK4t2bf+0IRBYRtL11LlxkpWQae/8AfNVU6w3S0gmfsikuVL5HrbDIn5Rp3Vq9SaVOo7pt2gbgPbPQOBjXpokedx0HmMkyc5QNZD1oUa/CBxFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766469831; c=relaxed/simple;
	bh=NNwShANLzZHeR0+zW/LDypRMNDkvH2iAcTxFUK0ZcwA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W5ayKLS97QMDRKUqf0c0W2xXnj2zNyw0BLfEEI8VFcKtRPmYrO12w6kVRYrPVLfL/i+N9/SAbkgwU9aemaOKw4BTDoDhSfB56+vDnrYdNatcKC8U1BBQMFUuMU++EgXOfv1tM7/OvotB0uo3rRvrASqvirUl5RuSqSwKBLpJHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E3q5dXa3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1KAFwpb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766469827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oeVrkGERtMPfZaI1nLVf2/F59VBQAfSYytPZrBMMIfs=;
	b=E3q5dXa3pkhtguE6xggbggpip+Tue1K5TvJJspM8Ml8w34Ag8i3hhJCR9KWsihDYDr0wYZ
	s9/Qd0W82Varep8LGyurWZcAfVmFvijQZWf7ZTZaO8HIBDYFYBPfthtOX1X728Cc7zpb4l
	ZXYy3HLToJAswT4t4BK/2wO6OXpaIaQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-UZ27qG0wN4qlLYni_E9oxw-1; Tue, 23 Dec 2025 01:03:45 -0500
X-MC-Unique: UZ27qG0wN4qlLYni_E9oxw-1
X-Mimecast-MFC-AGG-ID: UZ27qG0wN4qlLYni_E9oxw_1766469825
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88fcbe2e351so44562186d6.1
        for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 22:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766469825; x=1767074625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oeVrkGERtMPfZaI1nLVf2/F59VBQAfSYytPZrBMMIfs=;
        b=Y1KAFwpbXqwhPkxlXlYdMTQtpoxTrXJuEUP9bprnChweqa8KanCK048aMxaV2yU5cc
         RZiEUTQcrd3qH2oLT1OiiAMRfs2fiyRr0K21sSRya5KzzuC/zSOPMnL8YGoyOXyG8G+G
         TcDzAR/tx7gkuKIa0KWFpFofvar5f5lDA/1goDavrmcvELn684aPNqAMXtz1FjgOHYjq
         FosY9T7V/Daqr8tUFf803RwsN1+51FIRurhz9DwZWbEtdlPDhTIphWO9S9LX8y3qtko5
         OD2Z5198wyTpBOGLJs1lWftpT6EZ1Hum5H0OhKHvuqV/u6ThLXK0eB472nfPVcwS/n87
         +/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766469825; x=1767074625;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeVrkGERtMPfZaI1nLVf2/F59VBQAfSYytPZrBMMIfs=;
        b=IpUt+pxeu4zqlHdVA2oXPqMZj4VsX3S5dX6iAwwcxSkPctmB5D/85pmLEEbs+PXkqj
         1tM66UE41rU1dH4pZzInX6vjtxLKAzRVMUPyPYwTdp7odZy89BSlTXkTYtz+nhesMThh
         khgrGuxbKLmM6a3q4ukcUJpIPQ5weN7Tsx6DUlpXTHZP8X7oHiliib0P++bwgUu6ucKv
         uIzDMwXtRd1xkHpuko1EYAZhO01hgHP3hdE18U68p3ZT7Y+5jl1Fc3MLU+1RJe6fFtn7
         s02onEQekZ8USj46gp2o4VSBBZ+m9P4yf5m8a+DbbQTYoLJp6ss/MNngvUe5RkV1+Mo+
         +hCA==
X-Forwarded-Encrypted: i=1; AJvYcCVA+eXaOtySDRU49bMujFH33Ik0DwW5kiDde3Pi3ZTBBfjp7kHTs8SK9aNLu+utn3LZrCnyj2bm@vger.kernel.org
X-Gm-Message-State: AOJu0YzUnvUtk31fDPygI7jLTF6oZrU80w4QZxwow+EszHR/YZed9yia
	qy/7NzAHOQAXxFWulq8qisI7E12Lh2Bh966z4RZ9QDsYNShuoBTJ4QS2VLmZXPGZ/u9IhONiY36
	mgKFss17ZQGW3CPc1oTUfbTUgCf+XAvMfYMoYgBgjAgO7mcIhkmpy6h/3A4I=
X-Gm-Gg: AY/fxX7jLHcW7vCWUMePLSFlm9LmEkm2rAS2a0woY9mmWumh5nWxuIjLa0nH3RWw85r
	Div1Bh2Z1PI5qbcuRi5FivKtd9zsFyI2hFMsFDT0ktACk5VH9SLHfyvG5HBRf5uOeCLiF4FMwvq
	3Q/6TL5teoF/9+5gyUuKKwhJdIN2bTr7/aLW9P1oLGk/P7uTAigiuFPQXuYgVik3Tiau3+N+G30
	G6Cpyf0xB1NM6btk4g8hXxtyPhxhTx85+ZSVybhW9pqf/OenCHQZfSeYbes6V2eg4ilWS7MGHy4
	yPIiYq63A2E9QVrWCaYa+qH0G7Tn8NZp86VkFDV66qpIE7qoLxofRf4e4gALjLSgry6dn2FPCGV
	oW6DKlhzvTgHzrhYCTh1E4lMANjVj4WnOVLwtKERhjkL9Isl+dbBictTD
X-Received: by 2002:a05:6214:451d:b0:70f:b03d:2e85 with SMTP id 6a1803df08f44-88d83a7a462mr202581546d6.24.1766469825390;
        Mon, 22 Dec 2025 22:03:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv9gp6u6flV/YZxebl3MA6wauUNt9K1q2F4ABkv4Vi+T7RhJnKZ/tT3PCi1wcobmGERYY8ug==
X-Received: by 2002:a05:6214:451d:b0:70f:b03d:2e85 with SMTP id 6a1803df08f44-88d83a7a462mr202581376d6.24.1766469824940;
        Mon, 22 Dec 2025 22:03:44 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9a54485asm94803926d6.51.2025.12.22.22.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 22:03:44 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5b53f9ec-ebd5-4bea-b6a3-ef35a467e96c@redhat.com>
Date: Tue, 23 Dec 2025 01:03:42 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Sun Shaojie <sunshaojie@kylinos.cn>
Cc: llong@redhat.com, cgroups@vger.kernel.org, chenridong@huaweicloud.com,
 hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, tj@kernel.org
References: <cae7a3ef-9808-47ac-a061-ab40d3c61020@redhat.com>
 <20251201093806.107157-1-sunshaojie@kylinos.cn>
 <bzu7va4de6ylaww2xbq67hztyokpui7qm2zcqtiwjlniyvx7dt@wf47lg6etmas>
Content-Language: en-US
In-Reply-To: <bzu7va4de6ylaww2xbq67hztyokpui7qm2zcqtiwjlniyvx7dt@wf47lg6etmas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/22/25 10:26 AM, Michal Koutný wrote:
> Hello Shaojie.
>
> On Mon, Dec 01, 2025 at 05:38:06PM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
>> Currently, when setting a cpuset's cpuset.cpus to a value that conflicts
>> with its sibling partition, the sibling's partition state becomes invalid.
>> However, this invalidation is often unnecessary.
>>
>> For example: On a machine with 128 CPUs, there are m (m < 128) cpusets
>> under the root cgroup. Each cpuset is used by a single user(user-1 use
>> A1, ... , user-m use Am), and the partition states of these cpusets are
>> configured as follows:
>>
>>                             root cgroup
>>          /             /                  \                 \
>>         A1            A2        ...       An                Am
>>       (root)        (root)      ...     (root) (root/root invalid/member)
>>
>> Assume that A1 through Am have not set cpuset.cpus.exclusive. When
>> user-m modifies Am's cpuset.cpus to "0-127", it will cause all partition
>> states from A1 to An to change from root to root invalid, as shown
>> below.
>>
>>                             root cgroup
>>          /              /                 \                 \
>>         A1             A2       ...       An                Am
>>   (root invalid) (root invalid) ... (root invalid) (root invalid/member)
>>
>> This outcome is entirely undeserved for all users from A1 to An.
> s/cpuset.cpus/memory.max/
>
> When the permissions are such that the last (any) sibling can come and
> claim so much to cause overcommit, then it can set up large limit and
> (potentially) reclaim from others.
>
> s/cpuset.cpus/memory.min/
>
> Here is the overcommit approached by recalculating effective values of
> memory.min, again one sibling can skew toward itself and reduce every
> other's effective value.
>
> Above are not exact analogies because first of them is Limits, the
> second is Protections and cpusets are Allocations (refering to Resource
> Distribution Models from Documentation/admin-guide/cgroup-v2.rst).
>
> But the advice to get some guarantees would be same in all cases -- if
> some guarantees are expected, the permissions (of respective cgroup
> attributes) should be configured so that it decouples the owner of the
> cgroup from the owner of the resource (i.e. Ai/cpuset.cpus belongs to
> root or there's a middle level cgroup that'd cap each of the siblings
> individually).
>
 From sibling point of view, CPUs in partitions are exclusive. A cpuset 
either have all the requested CPUs to form a partition (assuming that at 
least one can be granted from the parent cpuset) or it doesn't have all 
of them and fails to form a valid partition. It is different from memory 
that a cgroup can have a reduced amount of memory than requested and can 
still work fine.

Anyway, I consider using cpuset.cpus to form a partition is legacy and 
is supported for backward compatibility reason. Now the proper way to 
form a partition is to use cpuset.cpus.exclusive, the setting of it can 
fail if it conflicts with siblings.

By using cpuset.cpus only to form partitions, the cpuset.cpus value will 
be treated the same as cpuset.cpus.exclusive if a valid partition is 
formed. In that sense, the examples listed in the patch will have the 
same result if cpuset.cpu.exclusive is used instead of cpuset.cpus. The 
difference is that writing to the cpuset.cpus.exclusive will fail 
instead of forming an invalid partition in the case of cpust.cpus.

>> After applying this patch, the first party to set "root" will maintain
>> its exclusive validity. As follows:
>>
>>   Step                                       | A1's prstate | B1's prstate |
>>   #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>   #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>   #3> echo "1-2" > B1/cpuset.cpus            | root         | member       |
>>   #4> echo "root" > B1/cpuset.cpus.partition | root         | root invalid |
>>
>>   Step                                       | A1's prstate | B1's prstate |
>>   #1> echo "0-1" > B1/cpuset.cpus            | member       | member       |
>>   #2> echo "root" > B1/cpuset.cpus.partition | member       | root         |
>>   #3> echo "1-2" > A1/cpuset.cpus            | member       | root         |
>>   #4> echo "root" > A1/cpuset.cpus.partition | root invalid | root         |
> I'm worried that the ordering dependency would lead to situations where
> users may not be immediately aware their config is overcommitting the system.
> Consider that CPUs are vital for A1 but B1 can somehow survive the
> degraded state, depending on the starting order the system may either
> run fine (A1 valid) or fail because of A1.
>
> I'm curious about Waiman's take.

That is why I will recommend users to use cpuset.cpus.exclusive to form 
partition as they can get early feedback if they are overcommitting. Of 
course, setting cpuset.cpus.exclusive without failure still doesn't 
guarantee the formation of a valid partition if none of the exclusive 
CPUs can be granted from the parent.

Cheers,
Longman


