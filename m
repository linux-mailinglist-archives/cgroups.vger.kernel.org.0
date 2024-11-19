Return-Path: <cgroups+bounces-5635-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FB59D1ED4
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2024 04:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A31281B7C
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2024 03:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2678014375D;
	Tue, 19 Nov 2024 03:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wc1AZhsA"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A9130E58
	for <cgroups@vger.kernel.org>; Tue, 19 Nov 2024 03:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731986924; cv=none; b=Rp/dW4XoDUxtYcQdo1YmCyBbFqb0TosOs+Onm9PjRoPTaxXt1cW2UyNBBymUA5gv6kVwR6Oyp6+w5L48/7gF/L4Bb6YB0Lms/NDIeyBKRAkddyGjWw5dEr3SwlMmOI27x+heMi6Y0ELGOw4YZxzv8S7hR41MMetMvzlR+zHDzXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731986924; c=relaxed/simple;
	bh=xRS4+hfrg3gCeRdM/kgrY9Q/qqbZgYGs1w5s9hrk8iY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rKcWVxNlDm7XNzakTWum1KaeTit3sz7H7F4hfS0TCC590trLLc0j7vFsecprohed668amxEkk+1YI7G0bd35Mp1TS4V6RiWfCXcr0G6jXUXGXVNEKXWj7DhJHctukP5BmyOLr+5ednG1d7ZDjh51joeI4Yr491PggZxsCpppnHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wc1AZhsA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731986922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8PlemWAggT45hfxEfheUGm2fsh9572BEWCOzq6YZBo=;
	b=Wc1AZhsAsOuGYfXaJ2CCtX/g6iw+3X1nc8aEtl/UOcYTdzONL8Xfr3f+AQ4y2PN9NdlhNy
	SU3X56BSdOR/jn6ulHuAMQbh58MLTDSJ1gZlQCD4j6IdpAptKBLEN8Z/RRL6svwpK333PX
	Cq1j+eNAJtxHGtrxj1KCQbD8DM9aJT4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-v1Lh0oOSM-GpM24ZSNF4wA-1; Mon, 18 Nov 2024 22:28:40 -0500
X-MC-Unique: v1Lh0oOSM-GpM24ZSNF4wA-1
X-Mimecast-MFC-AGG-ID: v1Lh0oOSM-GpM24ZSNF4wA
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-46354129681so7455091cf.2
        for <cgroups@vger.kernel.org>; Mon, 18 Nov 2024 19:28:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731986920; x=1732591720;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8PlemWAggT45hfxEfheUGm2fsh9572BEWCOzq6YZBo=;
        b=SfeTuL7naAh6eT+1TbTTKhaG6DXcgL33Xgzl200r0T9qHjF4kUNb925Be5gwMLRVFs
         f3xoNMDQOQnyIqlB2FGp41mFDxb27A9qeKB3EaGeoDPqUXN2QeQo03U2JJMtYAO6vxHI
         TgtarHC2HaxTdhODxB9ng6gWwciOTOUkbGTatwDhKML0AMcdI0TwinUrlq7Js66d66JV
         bNx4SpMrefCvTS4dtzNpW/LlKokrdW7E98HnA2BdcaHDHGh3ckEL5qo2+Zz70/GFIY6R
         F6EKrXzr2uNs2vdgqvcyZAvvLreRWc4TUd30QirP0baLYnSZjgVMv0Zwa+Zs7RO4fc0z
         h0ew==
X-Forwarded-Encrypted: i=1; AJvYcCWDCjQnzvWK8oW4kE4fdH+HRhGND0wumcELNArWp56yyI9gBJiPfRm/gZT8ZNkuExCNEhRI8dvj@vger.kernel.org
X-Gm-Message-State: AOJu0YwcMiw1aBqx257n0x22rtb0zimhkPZ2JU2zzXd42HiSAdjfepry
	pTBrxvWb4MUDr5K4Tqykcmc4/7GeFLrYGEImbK/rrE4n8BybV18M7grcw45XZvM8hp1BmV1bFnQ
	xVrqZQMqz9cS4q3U519D/2ImQwiNSso1JiFYbcmfxdpwQMA+/UEuGKkI=
X-Received: by 2002:ac8:7c55:0:b0:461:20b0:9909 with SMTP id d75a77b69052e-46363e3504dmr199036161cf.29.1731986920149;
        Mon, 18 Nov 2024 19:28:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdAeoC11ngzyylbKnDevm2EAHvD6G1i4Vrhlv5MIh5VT/D/Pe5FLQLw+zX3Y6Y55RoNo7Ozg==
X-Received: by 2002:ac8:7c55:0:b0:461:20b0:9909 with SMTP id d75a77b69052e-46363e3504dmr199036011cf.29.1731986919788;
        Mon, 18 Nov 2024 19:28:39 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46392bc364csm6120171cf.48.2024.11.18.19.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 19:28:39 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c3354d87-a856-421b-a03e-cda2f1346095@redhat.com>
Date: Mon, 18 Nov 2024 22:28:38 -0500
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
 <5a878687-9d08-472e-a387-02b2a150d2df@redhat.com>
Content-Language: en-US
In-Reply-To: <5a878687-9d08-472e-a387-02b2a150d2df@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/24 8:58 AM, Waiman Long wrote:
>>> The failing test isn't an isolated partition. The actual test 
>>> failure is
>>>
>>> Test TEST_MATRIX[62] failed result check!
>>> C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 . . X5 . . 0 
>>> A1:0-4,A2:1-4,A3:2-4
>>> A1:P0,A2:P-2,A3:P-1
>>>
>>> In this particular case, cgroup A3 has the following setting before 
>>> the X5
>>> operation.
>>>
>>> A1/A2/A3/cpuset.cpus: 2-4
>>> A1/A2/A3/cpuset.cpus.exclusive: 4
>>> A1/A2/A3/cpuset.cpus.effective: 4
>>> A1/A2/A3/cpuset.cpus.exclusive.effective: 4
>>> A1/A2/A3/cpuset.cpus.partition: root
>> Right, and is this problematic already?
> We allow nested partition setup. So there can be a child partition 
> underneath a parent partition. So this is OK.
>>
>> Then the test, I believe, does
>>
>> # echo 5 >cgroup/A1/A2/cpuset.cpus.exclusive
>>
>> and that goes through and makes the setup invalid - root domain reconf
>> and the following
>>
>> # cat cgroup/A1/cpuset.cpus.partition
>> member
>> # cat cgroup/A1/A2/cpuset.cpus.partition
>> isolated invalid (Parent is not a partition root)
>> # cat cgroup/A1/A2/A3/cpuset.cpus.partition
>> root invalid (Parent is an invalid partition root)
>>
>> Is this what shouldn't happen?
>>
> A3 should become invalid because none of the CPUs in 
> cpuset.cpus.exclusive can be granted. However A2 should remain a valid 
> partition. I will look further into that. Thank for spotting this 
> inconsistency. 

Sorry, I misread the test. The X5 entry above refers to "echo 5 > 
A1/A2/cpuset.cpus.exclusive" not to A3. This invalidates the A2 
partition which further invalidates the child A3 partition. So the 
result is correct.

Cheers,
Longman


