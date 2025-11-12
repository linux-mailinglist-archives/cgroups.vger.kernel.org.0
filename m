Return-Path: <cgroups+bounces-11852-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC908C507F7
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 05:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 721C24E31EE
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 04:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BF127FD72;
	Wed, 12 Nov 2025 04:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsQqfgCm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHO7xKxj"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8151B87C9
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 04:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762921202; cv=none; b=i7zpbe37ne/RayAAwNmh/VNVADNbEF/qJlabJpF2kJP5fD26j0VHzpcnsEBodfzbAbBZGf1yHF9xeRVE6o3qE/V9X9Fzy8P9TIkdHLk3Wgf0VfPrKVSvMWHCUxc8LJ88aoxqUwnkgOdzafp+1oIfn7Wjdv4HEfsmwOIamEQ1FLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762921202; c=relaxed/simple;
	bh=99ZkEBdOVrlrgRWH5y+oIYLqPCwO/Ovyudmk2p0QKNg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SROhGvt9R9m/6qYtAdb63NXet6UQVgeQi5RfMnPwtkmC2/LDno06Sm1Cn5VEe0PVWNL7K0p507usNPytZyba73PiPwhRYdnU1Yj9s6JGiOerTwD+1XWhYR1ta6iyCEDVTb+MzyXBv9HWE1FLYlR/IP0gXip+uLzRz/BcMregB2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GsQqfgCm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gHO7xKxj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762921199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AclnRmvTYc5uBIch2ljEKodBb0PluAr47F+xl2MP6pE=;
	b=GsQqfgCmTuK9PidBUYN9ms/GwQukcA0f0bqYjJM/eLOxixve2VD9G1MtceKs8CV4GTQY1O
	JmeGbIMGpBWq2nTI0+lfKcTeB30Jx4MMYS8v31QwmtMBD5aiSgH8GStgD7ar7NKDDyudPB
	EDT9J2LLa2A9Cr22Vc85lXU5+gULsV4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-NSYXBqMlMFWYyKZ6gMb5_w-1; Tue, 11 Nov 2025 23:19:58 -0500
X-MC-Unique: NSYXBqMlMFWYyKZ6gMb5_w-1
X-Mimecast-MFC-AGG-ID: NSYXBqMlMFWYyKZ6gMb5_w_1762921198
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88236bcdfc4so10489086d6.1
        for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 20:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762921198; x=1763525998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AclnRmvTYc5uBIch2ljEKodBb0PluAr47F+xl2MP6pE=;
        b=gHO7xKxjVjS1yz6EQyDjIKakWn043OJJeZ7D25YhPgoj6VrDNr2b/4oD58BEQhUJ3t
         qjwDj1KFulA2d82MafhImo8H/AqP+b6TNj0z9K7/tloXULTdffk8WxT1AeZRZBNI/p2z
         nz7QDLeC8rUKCIt7GdjDYJuxVGA2fsObG6Gqrasd9QD8pez6qgH1R5CJXLtQuKxMMXde
         naGEXisFYhsazqor3V73s8RIPfS491poumdHnaMoLzgkcq28lsoSX+tW22P4Wvb3wdTv
         4ViVu8tKquv7UUMT6ccxmdyCTc7WLKIPSl4DmObC9d5k8yzT+zlYJn9C2MJsnCaPNcnf
         bo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921198; x=1763525998;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AclnRmvTYc5uBIch2ljEKodBb0PluAr47F+xl2MP6pE=;
        b=ZMzmDjgZyWORAPlGniI8P2zpXVSWpzjQO0ZrCyDSUuYDcz/Pw3eFDn0GvWikc0J2lj
         fiKX/3yMBDeSsTu/zK+fmZFKIQTZHN+Zyqsj6BL8Tn7lQU4jItQ2BbUu+ArM6c8shBl/
         Ohj07jQ1mRF45+RTKF2m+rAFvOCN0VuLzIV6Pl56l0nhcKvwBFqpaq3xgouLOsJR3Jtp
         /1Ch9d4XGWwGblnJPDKfgxwWkgF8jFhmkfT2RnkrRYXSl6laqdA8RB+dLXaLggEX4EiE
         ESHZ8tkLdFgp0VDsayJiGy/EHuT51YA6mCN9kjAsu7nscEc6k2veAQupysm5msW1q879
         I4Ow==
X-Gm-Message-State: AOJu0Yy6dRzXT6W5d+gwYFsIDHXsAdqdaEIYPM9nrx/nFG8Bk6gTfF97
	pLIf/Ke5F/KwHe2Y6VpvBMOZtohj2kz7nLZ3mvPVqCfB4fu5Y0bwi3ehX1gj2NCuq/WXiyDdeav
	Gg8VElDL60ty6T96PkKWuWP3Xg39oplez1i6022ZX3ezoq1bpgZiiGk75+tk=
X-Gm-Gg: ASbGncuYVlxVdOWuW5BkNVDKdxHnbaOweZHzlZjy1OL22+qWYpXaJsddIpyD+PFTUEB
	bCx4vbsIgNgyz5cFLn95/ZVlRV8bV5bT8EwRMKdDlCxfXw4GNepv0lFgoSJ+zybapmwgAjjY7Yt
	qlb9sB6BllTAvzcEx7upM6NsTJAtZOfd/2mJYXBhIt/S6uq1V8YnpzZcVjQbINK5BVJJTo1Ls2d
	6whrvCOTw6Ctd+oaakjr8x9yl4fOyhH1WbsITmF42M6gODcpEPbcxLxvSUTMPxQvhzKP6ccsWmE
	8RtmlXm1+wLQutqsEndCOAeQ/hxOlwEWNafrxKpJqO0MCuZ5N1XuNwFTCXIQHZqcQD07CKZOt4s
	gXDeA58JmPT8WbMFMX6OcKB6n845bfsg7ghWEUyxk5KLomQ==
X-Received: by 2002:a05:6214:4107:b0:880:54ac:79f8 with SMTP id 6a1803df08f44-88271a5b788mr22274216d6.48.1762921197566;
        Tue, 11 Nov 2025 20:19:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbMi8UVm64iXlaFa6Bci1MOgHNeZ6t6/Lf2J2rdZ6Af7CSNMp6WRlYJamjOLJvlFJXARjjXg==
X-Received: by 2002:a05:6214:4107:b0:880:54ac:79f8 with SMTP id 6a1803df08f44-88271a5b788mr22274086d6.48.1762921197146;
        Tue, 11 Nov 2025 20:19:57 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b293a6sm84556446d6.37.2025.11.11.20.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 20:19:56 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <01a859a8-c678-4fd3-8d01-f45759c61c72@redhat.com>
Date: Tue, 11 Nov 2025 23:19:55 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 00/22] cpuset: rework local partition logic
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <31b58b15-0b46-4eba-bd50-afc99203695a@huaweicloud.com>
 <c5c4e977-9194-42c8-9045-0ed0ff16f5a5@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <c5c4e977-9194-42c8-9045-0ed0ff16f5a5@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/11/25 11:11 PM, Chen Ridong wrote:
>
> On 2025/11/3 19:18, Chen Ridong wrote:
>>
>> On 2025/10/25 14:48, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> The current local partition implementation consolidates all operations
>>> (enable, disable, invalidate, and update) within the large
>>> update_parent_effective_cpumask() function, which exceeds 300 lines.
>>> This monolithic approach has become increasingly difficult to understand
>>> and maintain. Additionally, partition-related fields are updated in
>>> multiple locations, leading to redundant code and potential corner case
>>> oversights.
>>>
>>> This patch series refactors the local partition logic by separating
>>> operations into dedicated functions: local_partition_enable(),
>>> local_partition_disable(), and local_partition_update(), creating
>>> symmetry with the existing remote partition infrastructure.
>>>
>>> The series is organized as follows:
>>>
>>> 1. Fix a bug that isolcpus stat in root partition.
>>>
>>> 2. Infrastructure Preparation (Patches 2-3):
>>>     - Code cleanup and preparation for the refactoring work
>>>
>>> 3. Introduce partition operation helpers (Patches 4-6):
>>>     - Intoduce out partition_enable(), partition_disable(), and
>>>       partition_update() functions.
>>>
>>> 4. Use new helpers for remote partition (Patches 7-9)
>>>
>>> 5. Local Partition Implementation (Patches 10-13):
>>>     - Separate update_parent_effective_cpumask() into dedicated functions:
>>>       * local_partition_enable()
>>>       * local_partition_disable()
>>>       * local_partition_invalidate()
>>>       * local_partition_update()
>>>
>>> 6. Optimization and Cleanup (Patches 14-22):
>>>     - Remove redundant partition-related operations
>>>     - Additional optimizations based on the new architecture
>>>
>>> ---
>>>
>>> Changes in v2:
>>> - Added bugfix for root partition isolcpus at series start.
>>> - Completed helper function implementations when first introduced.
>>> - Split larger patches into smaller, more reviewable units.
>>> - Incorporated feedback from Longman.
>>>
>>> Chen Ridong (22):
>>>    cpuset: fix isolcpus stay in root when isolated partition changes to
>>>      root
>>>    cpuset: add early empty cpumask check in partition_xcpus_add/del
>>>    cpuset: generalize validate_partition() interface
>>>    cpuset: introduce partition_enable()
>>>    cpuset: introduce partition_disable()
>>>    cpuset: introduce partition_update()
>>>    cpuset: use partition_enable() for remote partition enablement
>>>    cpuset: use partition_disable() for remote partition disablement
>>>    cpuset: use partition_update() for remote partition update
>>>    cpuset: introduce local_partition_enable()
>>>    cpuset: introduce local_partition_disable()
>>>    cpuset: introduce local_partition_invalidate()
>>>    cpuset: introduce local_partition_update()
>>>    cpuset: remove update_parent_effective_cpumask
>>>    cpuset: remove redundant partition field updates
>>>    cpuset: simplify partition update logic for hotplug tasks
>>>    cpuset: unify local partition disable and invalidate
>>>    cpuset: use partition_disable for compute_partition_effective_cpumask
>>>    cpuset: use validate_local_partition in local_partition_enable
>>>    cpuset: introduce validate_remote_partition
>>>    cpuset: simplify update_prstate() function
>>>    cpuset: remove prs_err clear when notify_partition_change
>>>
>>>   kernel/cgroup/cpuset.c | 1000 +++++++++++++++++++---------------------
>>>   1 file changed, 463 insertions(+), 537 deletions(-)
>>>
>> Hi Longman,
>>
>> I'd appreciate it if you could have a look at this series when you have a moment.
>>
> Hi Longman,
>
> Could you kindly take a look at this series when you have a moment?
> I'd appreciate any feedback you might have, and I’ll update the series accordingly.

I will take a look at this series tomorrow, though it has to be updated 
again anyway.

Cheers,
Longman

>


