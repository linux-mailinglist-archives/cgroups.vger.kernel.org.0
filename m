Return-Path: <cgroups+bounces-7690-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2951BA95A0E
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 02:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53298174856
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 00:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C905C3D81;
	Tue, 22 Apr 2025 00:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ktqy0BvR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EFDA59
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 00:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745280649; cv=none; b=TAxwNvrEUdqfRgFswY5JHJxU1od5GLZO6QyRAKwEYzUTrva4cAdscVdrrE1snaIOeht3i+3I8UFrRsG1HtiWQ2pHViQkHLStnueC5eG/URYa1l7ZwaPP2OEfaSphy0HRg/vH4UCFVlz7EM+LkDuiAcNr6GUH+n0vUDcTV/GV2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745280649; c=relaxed/simple;
	bh=FvoSljFN8/r2VwCMywICDkZSUYEM4G4HDnz9q8/nbqQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PN51r9F3D9o+DvNPJiR30ZhJJVhaHPefVzrlWSCQBM6s53jyUUqPj33KplWQPJhpoScIPs7MPDyvBrlsyMea1C0PkPOxNmTAPx5UQMIlZRH+c7VKTJXiJFC4YW5ZChiG1MHsvzyCB4uqasfUC976mO5alkv01rypyF20m38gNTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ktqy0BvR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745280646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDtoLS1gBPoKuxtRvVU2gx7fBBeeu41JuptA9opePq4=;
	b=Ktqy0BvRCrdEYAqat71lmG/QDukNxDk3EVUN4pSkCOC4qL/IRioGcMWxT+D15NlnjaiZNK
	bA/3PSNlNR0/rV5jj9b3EzXlCYDYoPgqpDJiKj3tvq3TRd996Nwi0hWEpAnPU2A5UDoviN
	40RJ5kiljIf+CxYgmJt+dR9pnA8Ptns=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-QGAIBanjOjywKVbS-MnJ2w-1; Mon, 21 Apr 2025 20:10:44 -0400
X-MC-Unique: QGAIBanjOjywKVbS-MnJ2w-1
X-Mimecast-MFC-AGG-ID: QGAIBanjOjywKVbS-MnJ2w_1745280644
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5f3b94827so671766785a.0
        for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 17:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745280644; x=1745885444;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDtoLS1gBPoKuxtRvVU2gx7fBBeeu41JuptA9opePq4=;
        b=Rl5W3C23YvqyZKZziQvI66qijnYhlS5U1YvZrYwYpxENs3LjgQM3pbXIEmAt5jPo9m
         gHgVSMFvOY6d6CCOPnbGCrbvztvlaiO3HeYCDFG44bPReW4bDf3soSLh7id+sT/wLRB7
         jodlHl1fF3OnuqHdIhN2UN/XTj363f9d2kW4viSJ2y6DZGOYnopxmcbEM1J/oNN1d34L
         d7791B2ZPmcDjBBM8X/9xXVxFTS6cJB+/eEzo4ZjG4/EcaXO/mFs8F3H0aQgslg+qdWd
         xWo32IxxsDSJo/weBrlznW0cLkpw/+JDwzyYriee95bh/UnAnxnndqMUMEr5RTc4cKGy
         J28w==
X-Forwarded-Encrypted: i=1; AJvYcCXi/u9Pms4gSb3tjCgQYwZ2zD/PfMy91yH4TT2KhOF31BoiuT6s+hTitovVy5QS5s/AGepMppPw@vger.kernel.org
X-Gm-Message-State: AOJu0YwucqH+FRfZr1/B7udJKNxuv0dsEHoFAjtQK+p5fbYarZPg9LmI
	MkOPle0kePqp1o8GVowg+TSnQcj2A3VLlkk113SmZg4MdzgrTOM7YdrrRb1FiOvor+w0AhZv/21
	74oxm0wqfzWZw3fzo71W1Qxp3WLV85Wwc6TRFJLO0X8QdyUFHSLwcJTo=
X-Gm-Gg: ASbGnctYCVKJl0vMrqkH58sJod9yh7Siw1/I/jbfJ8YLg2j8q8AeSjNQNE3yuC0THO5
	qMit/cpUdjN+h4/LWdkduZ5oxGRHRFmCReHVJlpanZ/58AqXqzm8DLoVTEDoI4MfsmYT2fkFPf4
	uAU52iNFd9HmPpEvPyYchkrv9Oq6Brqz+4cFx/CbcQxtpo4EJn4pjx9kfHdiFGuVdU8KsJk40No
	UcAnZUisoAW1mrZIDmom/pC5pffdQUZ+1S6CxnDrk/slJ1cBUeTeiCK90hQ6OxQqPEIzQhzgZBb
	yVfeGD7rAg+pQa8+y8NE15mANAffZmet9+Vu90vYhy+ZFlcX1UzxZnnssg==
X-Received: by 2002:a05:620a:3902:b0:7c8:c97:627f with SMTP id af79cd13be357-7c92803946cmr2242839385a.46.1745280644271;
        Mon, 21 Apr 2025 17:10:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6cQMQH+I86QARuGvdAqE6cTglxCEoXqyfkreYE8mt033hhYtUssBCdHGEdhmRbI12nDLDRA==
X-Received: by 2002:a05:620a:3902:b0:7c8:c97:627f with SMTP id af79cd13be357-7c92803946cmr2242836185a.46.1745280643960;
        Mon, 21 Apr 2025 17:10:43 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8f8c5sm480770885a.44.2025.04.21.17.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 17:10:43 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3478a69d-b4e9-4561-a09a-d64397ced130@redhat.com>
Date: Mon, 21 Apr 2025 20:10:41 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] vmscan,cgroup: apply mems_effective to reclaim
To: Shakeel Butt <shakeel.butt@linux.dev>, Gregory Price <gourry@gourry.net>
Cc: Waiman Long <llong@redhat.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com,
 akpm@linux-foundation.org
References: <20250419053824.1601470-1-gourry@gourry.net>
 <20250419053824.1601470-3-gourry@gourry.net>
 <ro3uqeyri65voutamqttzipfk7yiya4zv5kdiudcmhacrm6tej@br7ebk2kanf4>
 <babdca88-1461-4d47-989a-c7a011ddc2bd@redhat.com>
 <7dtp6v5evpz5sdevwrexhwcdtl5enczssvuepkib2oiaexk3oo@ranij7pskrhe>
 <aAbNyJoi_H5koD-O@gourry-fedora-PF4VCD3F>
 <ekug3nktxwyppavk6tfrp6uxfk3djhqb36xfkb5cltjriqpq5l@qtuszfrnfvu6>
Content-Language: en-US
In-Reply-To: <ekug3nktxwyppavk6tfrp6uxfk3djhqb36xfkb5cltjriqpq5l@qtuszfrnfvu6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/25 7:15 PM, Shakeel Butt wrote:
> On Mon, Apr 21, 2025 at 06:59:20PM -0400, Gregory Price wrote:
>> On Mon, Apr 21, 2025 at 10:39:58AM -0700, Shakeel Butt wrote:
>>> On Sat, Apr 19, 2025 at 08:14:29PM -0400, Waiman Long wrote:
>>>> On 4/19/25 2:48 PM, Shakeel Butt wrote:
>>>>> On Sat, Apr 19, 2025 at 01:38:24AM -0400, Gregory Price wrote:
>>>>>> +bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
>>>>>> +{
>>>>>> +	struct cgroup_subsys_state *css;
>>>>>> +	unsigned long flags;
>>>>>> +	struct cpuset *cs;
>>>>>> +	bool allowed;
>>>>>> +
>>>>>> +	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
>>>>>> +	if (!css)
>>>>>> +		return true;
>>>>>> +
>>>>>> +	cs = container_of(css, struct cpuset, css);
>>>>>> +	spin_lock_irqsave(&callback_lock, flags);
>>>>> Do we really need callback_lock here? We are not modifying and I am
>>>>> wondering if simple rcu read lock is enough here (similar to
>>>>> update_nodemasks_hier() where parent's effective_mems is accessed within
>>>>> rcu read lock).
>>>> The callback_lock is required to ensure the stability of the effective_mems
>>>> which may be in the process of being changed if not taken.
>>> Stability in what sense? effective_mems will not get freed under us
>>> here or is there a chance for corrupted read here? node_isset() and
>>> nodes_empty() seems atomic. What's the worst that can happen without
>>> callback_lock?
>> Fairly sure nodes_empty is not atomic, it's a bitmap search.
> For bitmaps smaller than 64 bits, it seems atomic and MAX_NUMNODES seems
> smaller than 64 in all the archs.

RHEL sets MAX_NUMNODES to 1024 for x86_64. So it is not really atomic 
for some distros. In reality, it is rare to have a system with more than 
64 nodes (nr_node_ids <= 64). So it can be considered atomic in most cases.


>
> Anyways I am hoping that we can avoid taking a global lock in reclaim
> path which will become a source of contention for memory pressure
> situations.

It is a valid conern. I will not oppose to checking effective_mems 
without taking the callback_lock, but we will have to take rcu_read_lock 
to make sure that the cpuset structure won't go away and clearly 
document that this is an exceptional case as it is against our usual 
rule and the check may be incorrect in some rare cases.

Cheers,
Longman


