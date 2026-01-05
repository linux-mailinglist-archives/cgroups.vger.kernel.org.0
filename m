Return-Path: <cgroups+bounces-12903-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA0ACF1CCB
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 05:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 402593007D86
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 04:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755C8322C73;
	Mon,  5 Jan 2026 04:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWK/ly1H";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTIBGjVo"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BACA322B82
	for <cgroups@vger.kernel.org>; Mon,  5 Jan 2026 04:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767587652; cv=none; b=OlQ3kIQgsAkHutScbWj9Se7JzDQdqUH4uWRh/7cHsr8LCbKssbzZsyJTtmeMzLNkQnOVV9UZEjx15CKeWkv0t6Ny/9N/BiEfqIvDv/59tFEpLglVviJ6lSIuTV5pvL9XS69GsMcMzulCADNJ5FBCbStbIyImo0SlUGXe+lD6ygE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767587652; c=relaxed/simple;
	bh=3T+/lZggk41ZmUSEFDvnQxirFhUhk6Siu7jiOBQHW2Y=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aQOTuGXPJWtJzBiF+DW1EKYk0PJGFTAsM0mAWFUVHhrLV0BaKe3MQDo8jV7G+TQz+r0s3uX55QnOxJYmaA8MRk55FWaZLbTgo0ja1OsqL0mqDBGWXdXa4rnfKBi4CGEMaDNhGC5MSv/UxdT8pwKF2W8kQ8E01KT83EnGCayvtjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWK/ly1H; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gTIBGjVo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767587639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EsXkG064xWImXuIpJmll/7yvRdGEkNLFfXmtwpzJncw=;
	b=BWK/ly1HfNsiyTFr6GLv6mScSOhJdgKdd1oQtCBmJquuQ14wtmwbrzseCYx2ZURtw6PbRp
	e1f0uZ4kxnlyISVztiIrDVz8BhRXT1yKO7DlyHfHyQx02FMU6YR5YE0AqAE8pExNt2Humx
	3N/6PEt6aUHAP10AoeJsS2osjO/TYLY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-_QZvH2r7OIudGtlJ2ABLYQ-1; Sun, 04 Jan 2026 23:33:58 -0500
X-MC-Unique: _QZvH2r7OIudGtlJ2ABLYQ-1
X-Mimecast-MFC-AGG-ID: _QZvH2r7OIudGtlJ2ABLYQ_1767587638
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88883a2cabbso540557186d6.0
        for <cgroups@vger.kernel.org>; Sun, 04 Jan 2026 20:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767587638; x=1768192438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EsXkG064xWImXuIpJmll/7yvRdGEkNLFfXmtwpzJncw=;
        b=gTIBGjVoEUlb8GDTnQYnLQR0f11uOglTwBVuZmWJN1Fxv0xsv06Ej+n+dByOBOxE0Y
         D99hGzIEU3zxd/Pqm0Gyhg7QeIPlQUGUZJ2jI8b0CYMaqlBTyFqQFQbGhtAWUwiKnVrw
         s1mbqBAiKbRGRA4DvpGw3wpPJUB+GO7G2oP6xJM5eqK7/5Z7oL3uY9SELSuFOKLp6qCR
         xaUhuZs4JsVwZMYTGN6DvoyxYkFMP6aRcj1e8Rl1ez3ilE3oeOhsIw11IpsB+dMdx8UY
         49BErWOoKeGnYmkkgqXw8fZa3Dp+rCIos0UtvHkfQA8L36ASXVab4TsZmyM5ro050mUM
         Mwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767587638; x=1768192438;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EsXkG064xWImXuIpJmll/7yvRdGEkNLFfXmtwpzJncw=;
        b=M7OnOSXNpz9O4yQ4TZXLFkvsuoxJhHOt5MixkPBevp4UDTRHDMOMj1SqtlhSixMT6S
         m2HU6497/y3opVcvePuJw0bBVvEQnxq9dy/7yb1/CYTao3iFjN8Rv/tkMesTlHX5i5t6
         cpLSahEDkAolRTzObULTnnGXAa2/Y7LNZdyLSVhbOJtkSKQZ/IAGqs88cLZnly1sg+Dr
         QWrcog9L6KcOdZC0IwsTNAj1HW4PmpN+flgAJ1ZKXwvHfmsIsOYyHxGgykAJEBmfAF6z
         8p40WqkYYH7GlUfMvwN28aifeO31gVAudXCxZ30yoNpnCcfgmOFmP5AaTO/WhIk+NIEn
         HaAA==
X-Gm-Message-State: AOJu0Yw1Vj4NPWYpjjDbIFVXNKZLwX8KFFnmOFW1OgATtV3bclwJDkGS
	KR7eedezESXEZkjVRlXq+KoGqcCoZHofA0khHSmulatS6S0uvlTiUnD7+d+Tv4k/DKXDD1joNO3
	9pR9sU5VpowImXkJ/2/s04lWLqX1EYMALGd8srSwv0q7L//W4yTYUN9cejnU=
X-Gm-Gg: AY/fxX5kcMghRBoZC+3tJ7nwxme1GaLx6oaR7/TRxd+c0zxsC2YK8dlOAKn7dMnKG/M
	++NoBLO3vt/hJDuJ8juSl4m1w5btdncy70vxDD7RXBWNCtskPokf1bjurQZUF7ulRmPvD4j9IJy
	+7grkiYul5Z1s5Odn8BEqFUiWJANeeFI5kHglE3gcyYYp0T0Dn49LyEWvu/Wkvq+nm5YsEoDPyc
	iOdfsNiPfJXW8E0tIzCbfzpUF9LkJQajh4LPAQb77LXY0dIHU/DcycumPMfdU1fy4oDctUB9Jno
	NNfDDqaYgtnobX8XukXG/Mwgd9JxvXIFHFJzgmmC4S3snf8MLw2kqlvm8Mikd20Ff4pIjcJEBEa
	4Bork/dITKULy/J5myWrBeQgRJARKptmkeb37oHyds2Bn+B2Sz1NHw9/9
X-Received: by 2002:ad4:5b8a:0:b0:880:5a05:925f with SMTP id 6a1803df08f44-88d851fd7f5mr880375226d6.13.1767587638075;
        Sun, 04 Jan 2026 20:33:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6DcRe9C6u3k7gb2s0ee5NzGtfc03MoZnKJsOHm3lHdWNWpkBMcV5gluaDDwHAB/FLg7kV9Q==
X-Received: by 2002:ad4:5b8a:0:b0:880:5a05:925f with SMTP id 6a1803df08f44-88d851fd7f5mr880375106d6.13.1767587637713;
        Sun, 04 Jan 2026 20:33:57 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997ada77sm341759336d6.37.2026.01.04.20.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 20:33:57 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <13975af6-97af-49d8-ae85-d126a65715ee@redhat.com>
Date: Sun, 4 Jan 2026 23:33:56 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND -next 00/21] cpuset: rework local partition logic
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251225123058.231765-1-chenridong@huaweicloud.com>
 <7937ad21-8c98-4bd8-8a5d-93f868bcb8b5@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <7937ad21-8c98-4bd8-8a5d-93f868bcb8b5@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/4/26 11:01 PM, Chen Ridong wrote:
>
> On 2025/12/25 20:30, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The current local partition implementation consolidates all operations
>> (enable, disable, invalidate, and update) within the large
>> update_parent_effective_cpumask() function, which exceeds 300 lines.
>> This monolithic approach has become increasingly difficult to understand
>> and maintain. Additionally, partition-related fields are updated in
>> multiple locations, leading to redundant code and potential corner case
>> oversights.
>>
>> This patch series refactors the local partition logic by separating
>> operations into dedicated functions: local_partition_enable(),
>> local_partition_disable(), and local_partition_update(), creating
>> symmetry with the existing remote partition infrastructure.
>>
>> The series is organized as follows:
>>
>> 1. Infrastructure Preparation (Patches 1-2):
>>     - Code cleanup and preparation for the refactoring work
>>
>> 2. Introduce partition operation helpers (Patches 3-5):
>>     - Introduce out partition_enable(), partition_disable(), and
>>       partition_update() functions.
>>
>> 3. Use new helpers for remote partition (Patches 6-8)
>>
>> 4. Local Partition Implementation (Patches 9-12):
>>     - Separate update_parent_effective_cpumask() into dedicated functions:
>>       * local_partition_enable()
>>       * local_partition_disable()
>>       * local_partition_update()
>>
>> 5. Optimization and Cleanup (Patches 13-21):
>>     - Remove redundant partition-related operations
>>     - Additional optimizations based on the new architecture
>>
>> base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
>>
>> ---
>>
>> Changes in RESEND:
>> 1. Rebase on the next-20251219
>>
>> Changes from RFC v2:
>> 1. Dropped the bugfix (already merged/fixed upstream)
>> 2. Rebased onto next
>> 3. Introduced partition_switch to handle root state switches
>> 4. Directly use local_partition_disable()—no longer first introduce
>>     local_partition_invalidate() before unifying the two
>> 5. Incorporated modifications based on Longman's suggestions
>>
>> Changes in RFC v1:
>> 1. Added bugfix for root partition isolcpus at series start.
>> 2. Completed helper function implementations when first introduced.
>> 3. Split larger patches into smaller, more reviewable units.
>> 4. Incorporated feedback from Longman.
>>
>> Chen Ridong (21):
>>    cpuset: add early empty cpumask check in partition_xcpus_add/del
>>    cpuset: generalize the validate_partition() interface
>>    cpuset: introduce partition_enable()
>>    cpuset: introduce partition_disable()
>>    cpuset: introduce partition_update()
>>    cpuset: use partition_enable() for remote partition enablement
>>    cpuset: use partition_disable() for remote partition disablement
>>    cpuset: use partition_update() for remote partition update
>>    cpuset: introduce local_partition_enable()
>>    cpuset: introduce local_partition_disable()
>>    cpuset: user local_partition_disable() to invalidate local partition
>>    cpuset: introduce local_partition_update()
>>    cpuset: remove update_parent_effective_cpumask
>>    cpuset: remove redundant partition field updates
>>    cpuset: simplify partition update logic for hotplug tasks
>>    cpuset: use partition_disable for compute_partition_effective_cpumask
>>    cpuset: use validate_local_partition in local_partition_enable
>>    cpuset: introduce validate_remote_partition
>>    cpuset: simplify the update_prstate() function
>>    cpuset: remove prs_err clear when notify_partition_change
>>    cpuset: Remove unnecessary validation in partition_cpus_change
>>
>>   kernel/cgroup/cpuset.c | 1023 ++++++++++++++++++----------------------
>>   1 file changed, 454 insertions(+), 569 deletions(-)
>>
> Hi Longman,
>
> This series has been out for a while. I'd appreciate it if you could take some time to review it.
>
Sorry for being late in reviewing this updated series. However, there 
are also other cpuset related patch series that are being reviewed at 
the moment. Since this is mainly a cleanup patch making the code easier 
to understand, but it does a major restructuring of the existing code 
which will likely make the other patches harder to merge. So I would 
like to prioritize the other fix and feature patches first. I will try 
to review the patches when I have time, but I want this series to be 
merged after other cpuset patches are done.

Sorry for the inconvenience caused as you may have to redo the patch 
series again when the code base is settled down.

Cheers,
Longman


