Return-Path: <cgroups+bounces-5615-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98829D1283
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 14:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0F62832EF
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 13:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F7E19D087;
	Mon, 18 Nov 2024 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCOzXL+f"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669421E505
	for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731938306; cv=none; b=aMCpvyOz1CYt5DInnrL1tGDUNuGzPDlGJKZKOU8qaPczsW4Gs9qqyeZ3m74WEsAFv+IPZ0zKKhgPtE8LUQ15/kBS5qz5AAmJuz9Cr2EZTOy/ilR6MN0kMIJJKDTd454+DikOlwCfy+bsbRljMBstEt4fEFi4haBoQjIiwJBhp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731938306; c=relaxed/simple;
	bh=UiU/qtJW4f9XJc/dQnT7DENCuscjm2Y3iOhArlBgCzc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kThl2hgkYydb5/QhaXZc9jkWGUiDgeOLKzgOIJlMAg7v1fGThfz3S7VRJqa1npGOUCk6Ia7/82rCjkUUfBZCfZnnh8wAuzxiRMqlq5u7aKA/SJ5ePvyDqis/b1xaV/tPdtWv1oYmf735Sbg8fh17ajPiM/FnizJLejSNm3xqK0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OCOzXL+f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731938303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MV9t7PeyS5fNDfqXNOqFnhhI7vbfFrtvKXlM5jfsTc=;
	b=OCOzXL+fImhH17RW19XIn6LauU9uZniRngeZ+XtYHQMwKt9nwSZ+p18U7AMA2Gb2m2BFA/
	mZjtlGIGy1HD/cxeQTjZPa390sCo2YdJsLsncT//zGUqUPuWs/cxD87BEVeRsTGA63e6jU
	B7/TqTxTZJJXHh2kMIm3awiZFlfIMeY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-UsLzK3PxMt6tFqhmvYkG1w-1; Mon, 18 Nov 2024 08:58:21 -0500
X-MC-Unique: UsLzK3PxMt6tFqhmvYkG1w-1
X-Mimecast-MFC-AGG-ID: UsLzK3PxMt6tFqhmvYkG1w
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b15d3cd6dcso386730985a.0
        for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 05:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731938301; x=1732543101;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9MV9t7PeyS5fNDfqXNOqFnhhI7vbfFrtvKXlM5jfsTc=;
        b=MCVuaYnXHKHFN9Twv5LdXP1/ntJTL9n0tDmxVlldPDktYanpFVlPvN1Pdwm9WMpDiK
         nJhtk30F/qsIfYgk4LokF+apQRyIiqBOgWgoPaz4VjuPnAvJELNdv1mrs/rRAeQIlwZ8
         rpZreGbpJZhCIvQVQ+busv2yhRcKlwn/rkhfvIRYc19peuE6S7fXclARzCbRXlEq2Mew
         rJ6OvadvdQ1riuTzI/OyrJ2TeSrvfxIrQEcOWeTsiCkhD4EAl/if/4saYATotpi/cB/G
         QVuhoUhyvzUpYm0ZnTu5JgZOmaKprpuEjllWGjScYzJ0KmEq+0jJA6yzftBigKMlkWtC
         IQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWfTwl5b/JtwMYyc/2rzle38ZUu/KKoUIAJgBDmPVtfHyYthRD+1wkOQxkiCXpcTWYLm0x3Wgy@vger.kernel.org
X-Gm-Message-State: AOJu0YxDzTyqw4NMDX3Fxf26Yu0fVI97b4EgHoWGgCLdQaSXLvHg/eAv
	7iKoRM0VqfbtCGENXy8FI5+IyNRulEOtUdlOTq4pv3P8iIAcRebaelavzV97mFCIxcflhuhhoSh
	Ca5Htk9/2tdFSNEZnhVsAqrXjRReeO4V0eu7AmWAD87iFNoccfdUG3oo=
X-Received: by 2002:a05:620a:440a:b0:7ac:e30e:f6f with SMTP id af79cd13be357-7b36235bbb9mr1865985785a.43.1731938301363;
        Mon, 18 Nov 2024 05:58:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg8zld4k6YPeW4BIJQGymHWq+9Oz05egcq1pXqCLPnt9QIgQqJxwWe9aQ3E+6DdEczTLGLTg==
X-Received: by 2002:a05:620a:440a:b0:7ac:e30e:f6f with SMTP id af79cd13be357-7b36235bbb9mr1865983785a.43.1731938301103;
        Mon, 18 Nov 2024 05:58:21 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c984557sm483231885a.10.2024.11.18.05.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 05:58:20 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5a878687-9d08-472e-a387-02b2a150d2df@redhat.com>
Date: Mon, 18 Nov 2024 08:58:19 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Disable cpuset_cpumask_can_shrink() test
 if not load balancing
To: Juri Lelli <juri.lelli@redhat.com>, Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
References: <20241114181915.142894-1-longman@redhat.com>
 <ZzcoZj90XeYj3TzG@jlelli-thinkpadt14gen4.remote.csb>
 <1515c439-32ef-4aee-9f69-c5af1fca79e3@redhat.com>
 <ZzsLTLEAPMljtaIK@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <ZzsLTLEAPMljtaIK@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/18/24 4:39 AM, Juri Lelli wrote:
> On 15/11/24 12:55, Waiman Long wrote:
>> On 11/15/24 5:54 AM, Juri Lelli wrote:
>>> Hi Waiman,
>>>
>>> On 14/11/24 13:19, Waiman Long wrote:
>>>> With some recent proposed changes [1] in the deadline server code,
>>>> it has caused a test failure in test_cpuset_prs.sh when a change
>>>> is being made to an isolated partition. This is due to failing
>>>> the cpuset_cpumask_can_shrink() check for SCHED_DEADLINE tasks at
>>>> validate_change().
>>> What sort of change is being made to that isolated partition? Which test
>>> is failing from the test_cpuset_prs.sh collection? Asking because I now
>>> see "All tests PASSED" running that locally (with all my 3 patches on
>>> top of cgroup/for-6.13 w/o this last patch from you).
>> The failing test isn't an isolated partition. The actual test failure is
>>
>> Test TEST_MATRIX[62] failed result check!
>> C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 . . X5 . . 0 A1:0-4,A2:1-4,A3:2-4
>> A1:P0,A2:P-2,A3:P-1
>>
>> In this particular case, cgroup A3 has the following setting before the X5
>> operation.
>>
>> A1/A2/A3/cpuset.cpus: 2-4
>> A1/A2/A3/cpuset.cpus.exclusive: 4
>> A1/A2/A3/cpuset.cpus.effective: 4
>> A1/A2/A3/cpuset.cpus.exclusive.effective: 4
>> A1/A2/A3/cpuset.cpus.partition: root
> Right, and is this problematic already?
We allow nested partition setup. So there can be a child partition 
underneath a parent partition. So this is OK.
>
> Then the test, I believe, does
>
> # echo 5 >cgroup/A1/A2/cpuset.cpus.exclusive
>
> and that goes through and makes the setup invalid - root domain reconf
> and the following
>
> # cat cgroup/A1/cpuset.cpus.partition
> member
> # cat cgroup/A1/A2/cpuset.cpus.partition
> isolated invalid (Parent is not a partition root)
> # cat cgroup/A1/A2/A3/cpuset.cpus.partition
> root invalid (Parent is an invalid partition root)
>
> Is this what shouldn't happen?
>
A3 should become invalid because none of the CPUs in 
cpuset.cpus.exclusive can be granted. However A2 should remain a valid 
partition. I will look further into that. Thank for spotting this 
inconsistency.

Cheers,
Longman


