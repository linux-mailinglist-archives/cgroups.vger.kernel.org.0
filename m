Return-Path: <cgroups+bounces-12350-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F2FCBA4D8
	for <lists+cgroups@lfdr.de>; Sat, 13 Dec 2025 05:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 988E03082A30
	for <lists+cgroups@lfdr.de>; Sat, 13 Dec 2025 04:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8E02080C1;
	Sat, 13 Dec 2025 04:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFhkAoac";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lNvE8Mo2"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36D71F92E
	for <cgroups@vger.kernel.org>; Sat, 13 Dec 2025 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765601945; cv=none; b=WZgorJ18GIqIpG6KIIRwnkQDO8SEfcUJM7uYzC1E8okKB4KKGCioxX6yFd4aMl5w9Odi/VNoFtb7+6//wAE8k4BTiTTlNx7M6U2Or/KGDTApT+LPIyCR6L0JiUz/D6oOUsK55SW9+Wg5+2HND98EbIKtlQF3oOMosRnm0y14kGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765601945; c=relaxed/simple;
	bh=yPzs/f+Lh44vbmrhItPCB7ZJc+MI/3tKjjsKrA9CI9I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OEeOXlUXM00BJPH4ttUoc22dHvzCQE/fUtntWGL2ijVBYE9cnrwGAX0HnS64adW2FzbA/FDDyJnMbiinyJci6lYOPKt8W+i2vPUhECTJlqwHZHX6zflKSITLtXwS9o5Hy5er/gYkrvOM6vbWuU4nDCli7kIz6DUx8tUmZnMj4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IFhkAoac; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lNvE8Mo2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765601942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJGiqBB7uCME6Sbe4VgAoga7zrBVZpzS1c9EWdQdkYE=;
	b=IFhkAoaccnGuwxuxp+ngTdTFBfHM3z6lWwQDqQHPI+ANhfNtH7prDX2yQAK/7dBGO8sqCi
	//30P1s2cCXLsCt4G4q13AWikcShxMCfrn89p+KnQsTQ2UDnldj13dZqb92dImBfM+uG7m
	cL6LSZjVoSbIAXp+zk9Dtv1B+f2oa3s=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-McWcXbsNPW27YpmKDTqmGQ-1; Fri, 12 Dec 2025 23:59:01 -0500
X-MC-Unique: McWcXbsNPW27YpmKDTqmGQ-1
X-Mimecast-MFC-AGG-ID: McWcXbsNPW27YpmKDTqmGQ_1765601940
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2955f0b8895so19085645ad.0
        for <cgroups@vger.kernel.org>; Fri, 12 Dec 2025 20:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765601940; x=1766206740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vJGiqBB7uCME6Sbe4VgAoga7zrBVZpzS1c9EWdQdkYE=;
        b=lNvE8Mo2liI+cWn3q+4T0ifFJW3QL79udDs7ODRxeVFmapI6vxkxZNZkWMYTrWA+ob
         d44RHd52X46QGqCfXNHaGQsKYCKuPQpnFGDebwDiWK/+Omdpc5kpAKS7k+Vb0UBXh7g/
         2qCAThHRN6B3+scTgtjPfDWwEefs5z2+hpDEK2z725qgzIjGeraTqQvqyIhyMxu9yqJh
         cp73gqLxGArRcgzFAmXHMpdHnvOQ0kLDP2txs0LgRNTF0IZC92iSo0f+Gi9Ql2zzNMhL
         3Lynrcezx3yVDP+h5vDnDN3G58SAQid2q2hdAm+5cfmW4Lb2FCiY0+yIV7gKMBRvpK3D
         VHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765601940; x=1766206740;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJGiqBB7uCME6Sbe4VgAoga7zrBVZpzS1c9EWdQdkYE=;
        b=FFyqHzyw6keSLCmYaqXvITCxV5lEeIwHQiC9QZsN5AyS5jl9x6nZQpSBQn1nDEUOAR
         zzvzQi1a1n5HfEg9/tb20cUH1++VP78v01BnSGnHqwLK7jcoyK15/T6CHC2cVoDZ3fdY
         fokFTJlWzsupwJNdbtSKdsWkWCz2WTjWnqnJ4+3AMgfLNd4iiLmUM4EBvBjGUxUNxUl6
         i5RXw3y2LNjPBHOYr7H0aN3WaE8GmScnZ6+2hWJasLZmBLl5jejNXiqWS3Dwsgo8smJs
         Enyijd/J5JCB/ge+V+d74Ib0hL4reZdJBOOE84zA/mew9UsjEj99GG0pe2I27nBfkq71
         ervQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGj7cEkNIBvmsXg75qlQKSuAPBDlSHIApgLVbP6lGj0jqGabbC9/ZI5vrj1BFJVAsbW7/Rs6z2@vger.kernel.org
X-Gm-Message-State: AOJu0YwjygNhCxj1P9nj8+N8dTJYkDk6wIWngg9cL4h8Vj4moCBgwL4S
	Ict+cipDXPKxa/te0u8i22ZmUrK8HMNcvtUuMVW1ckJN17Z3fXVuyg04VHI2BO+xPI1Br2rbTDM
	u6yZyCXNybO9AbLjnxLYAblLy4EnlTNNHMHGW+tbO0mQXcJKKF9Oz/nevzek=
X-Gm-Gg: AY/fxX6R0N0HCl/iNKgHurzbrehJNxR2hCZZGX1uh6rWQq1jAbELfcqWupEsZWyZB8h
	06RhtPTeMXeY9yMLPT+iUMb5f9ZFcefO0MxkvWuF9wNtwLr9+ZOEE6550WXk2ipw/xjISNnUW8y
	4p66763yVpBCPNVZdJX1Bp4N8JNiZ8YV1HCFZvHhZAx0csZ9WrKPzB0gYIxOlIARo4SfQYRIeze
	9NsYZ5gM5U1tfIIiZI3oum3tQ6mk9hplocghaXLZNLTLfllaQH3dkHwDCKUgaEf00DxyJXP74CE
	JZzSjf2bMpHexpPLr/OnnAnY3qxE5v+/KSsegZUFDnIg6cKX2oIBDhmoy165ITFoJIzwact7wzq
	WEi2w1Rpoy9NRFvn9xHI2GZ0rhNVge1dELqwqaBlkqu4=
X-Received: by 2002:a17:902:da92:b0:295:28a4:f0c6 with SMTP id d9443c01a7336-29f24800550mr46650805ad.0.1765601940316;
        Fri, 12 Dec 2025 20:59:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2XlZ804IhqEpFO2N9sRBt5uGyIMXcNGs6Cj7VK4kPb19a3EfN0cxzXdjmp0UnK+0tBp2ahw==
X-Received: by 2002:a17:902:da92:b0:295:28a4:f0c6 with SMTP id d9443c01a7336-29f24800550mr46650615ad.0.1765601939917;
        Fri, 12 Dec 2025 20:58:59 -0800 (PST)
Received: from [10.200.2.27] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f2e40765csm30273205ad.0.2025.12.12.20.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 20:58:59 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1e2eef0a-4637-4b4f-aea5-71e3e519757d@redhat.com>
Date: Fri, 12 Dec 2025 23:58:53 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Waiman Long <llong@redhat.com>
Cc: Sun Shaojie <sunshaojie@kylinos.cn>, chenridong@huaweicloud.com,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, tj@kernel.org
References: <f32d2f31-630f-450b-911f-b512bbeb380a@huaweicloud.com>
 <20251119105749.1385946-1-sunshaojie@kylinos.cn>
 <cae7a3ef-9808-47ac-a061-ab40d3c61020@redhat.com>
 <ur4ukfqtqq5jfmuia4tbvsdz3jn3zk6nx2ok4xtnlxth6ulrql@nmetgsxm3lik>
 <d5d635df-94f3-4909-afe3-f2e6141afa32@redhat.com>
 <3jkvuruuxdykpxjjdwhuqjfqi4nrtxojotswaoc7ehuwxp4s32@hfrvfato6q5b>
Content-Language: en-US
In-Reply-To: <3jkvuruuxdykpxjjdwhuqjfqi4nrtxojotswaoc7ehuwxp4s32@hfrvfato6q5b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/8/25 9:32 AM, Michal Koutný wrote:
> Hi Waiman.
>
> On Wed, Nov 26, 2025 at 02:43:50PM -0500, Waiman Long <llong@redhat.com> wrote:
>> Modification to cpumasks are all serialized by the cpuset_mutex. If you are
>> referring to 2 or more tasks doing parallel updates to various cpuset
>> control files of sibling cpusets, the results can actually vary depending on
>> the actual serialization results of those operations.
> I meant the latter when the difference in results when concurrent tasks
> do the update (e.g. two containers start in parallel), I don't see an
> issue with the race wrt consistency of in-kernel data. We're on the same
> page here.
>
>> One difference between cpuset.cpus and cpuset.cpus.exclusive is the fact
>> that operations on cpuset.cpus.exclusive can fail if the result is not
>> exclusive WRT sibling cpusets, but becoming a valid partition is guaranteed
>> unless none of the exclusive CPUs are passed down from the parent. The use
>> of cpuset.cpus.exclusive is required for creating remote partition.
>>
>> OTOH, changes to cpuset.cpus will never fail, but becoming a valid partition
>> root is not guaranteed and is limited to the creation of local partition
>> only.
>>
>> Does that answer your question?
> It does help my understanding. Do you envision that remote and local
> partitions should be used together (in one subtree)?

It should be rare to have both remote and local partition enabled in the 
same system, though it is not disallowed. The local partition should 
only be used on system that run a small number of applications with one 
or just a few that need partition support. For systems that run a large 
number of containerized applications like a Kubernetes managed system, 
local partition cannot be used because of the way container management 
is being done as the actual cgroups associated with a container can be a 
bit far from the cgroup root. Remote partition was created for such a 
use case where local partition will be used at all.

Cheers,
Longman


