Return-Path: <cgroups+bounces-8374-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B9CAC6D27
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 17:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6483BC7B2
	for <lists+cgroups@lfdr.de>; Wed, 28 May 2025 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2545628C851;
	Wed, 28 May 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1/Toy5S"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6485F28B514
	for <cgroups@vger.kernel.org>; Wed, 28 May 2025 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447140; cv=none; b=sVSpPyAKN47ASrzqUnsj3mWmt8h0DF0iviV08Jvq4wBBawFSU+ygR24YI++mQv1KS+7Ffd1f2iZ/z7KWXq7hvGxkqEm3DZHL4hvgw16HvRzPLx+Z46WNwHwsvlGcHf4VuzzcLq9R5qixX/1ib/yGs6lu1TqNRDkKv2HsdjarapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447140; c=relaxed/simple;
	bh=/CbNirfnMFT6iFLSja2Zj2oVfKKWn3klp7446jTgwUs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=m/b46MIp5i7PIdSm+yZrokAkowQJXGLNWWuu/fqhCs3HlkjiGc3eXkXqarHpz5sYc0AIDPcFHliDFh1FRSspPePRsf0AEKuw37SPFfr/cLKHfLjslegpnfujKsyOAICEkgORojH40XW3oROBcy5jGy2dw8P/JodQkMfgDocyLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1/Toy5S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748447135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pyLOwGypbK7cil/VDfYgN1Gr/yfNRiyW37n+n15jPLw=;
	b=A1/Toy5SKHIKdWlAbplx241jrv89Hulz9k6UqHECKhMRxqoEYuqg1CMwBhKFDma/lAUKhZ
	3SPHV236Yec7gESIG46EFaeemtz0diN7Mj0g40CIhVfjQDY1C2fgqdlWd4s2wCEOtd8XAH
	xy83Xht99q4u98dOEWDU0R+AqM4w6x8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-RSMBshwVN3qjinh1_tPO9Q-1; Wed, 28 May 2025 11:45:32 -0400
X-MC-Unique: RSMBshwVN3qjinh1_tPO9Q-1
X-Mimecast-MFC-AGG-ID: RSMBshwVN3qjinh1_tPO9Q_1748447132
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7caee988153so783403785a.1
        for <cgroups@vger.kernel.org>; Wed, 28 May 2025 08:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748447132; x=1749051932;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pyLOwGypbK7cil/VDfYgN1Gr/yfNRiyW37n+n15jPLw=;
        b=oVp7S2RkpeAg7JJsLxpHEw5JnyLkCKjJbxUvgrLrOal0c4SurgsJQRg9d6NYFW/olx
         p9BZ5tjfgwfyRAbp42bmcRiz1d9p/9yJi8IbhFESN9iOk4iA7R75kWwAmJalUinsTI3t
         dyFBSm+9ZtSwfJZnI/NEP7DiD+3coNL/YZd6yeDTxyBiKL3k6cR0D9uQuFhZL2VcmUOg
         dsCcJYCo1EYxgFmJY/yo4/p66nj3kxTzEXtr73ohr6X3UYZteldlZhEwWknfqAIPsY9o
         ertJK7tlnc7P4IDNl8kCCFRdNlb737EhLfkqjvyhnchcCb1G4dN96ArXduplH8VheCpA
         cVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeRF1Re+CHxPwfWupevw47VsVAlOM/9r41x2lVXal3K2BR3vjRth7zOmlJzsShQ8X7Xnnt8HMh@vger.kernel.org
X-Gm-Message-State: AOJu0YxXyi8xnQeOXfmd0X3d4tnxgwpCTYkXh+KiHDxKChYCcpvsFA1H
	J/hItjsm9qYOwsKewzrcx6jrY32wOP7twX0pXP21QLfquvSPKLzAisJ3FmO35dsCk6U58915sMm
	z/KacDOYmxse3K/h9udXKZ7SlehsnwGWC7R8A+AvGI/6KIwqTDzcg6HpmeSE=
X-Gm-Gg: ASbGncvQhkP4P9jcbx/kJIO2UWaa0VABoEVzMJKJnmaHS6q7xlB8uKXIiAEkA6L7xp0
	ic0VcH7EpDI3lWF50dOHubKzl///MSNC5YembsjOdPnLLv2g8uSK2o8B0nfyvcMIqBFVNJdECLI
	AAyNUF9u3UWWKTL5i0c67+yKn2Uyi2OaCJbqhJmpU+DqTMDOo8S6Tbc/0/Vg9H9Lzn3aBL+1/vF
	wTko/9R4AZ/l/5DkSh7vUY/ufshM7RwxeTMbZGTE5wYHXnngGjEe1BpI2YrOOYH0lVtU4pC6UlG
	rApITLOllY/j
X-Received: by 2002:a05:620a:2952:b0:7ce:e010:88bb with SMTP id af79cd13be357-7cfc5d3bea0mr319655585a.22.1748447132197;
        Wed, 28 May 2025 08:45:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUqlAX9B3FIW5eZMrtvbf91YzWhqy3WejI0SBLhs/OnmLka0kFn2dRtq7rU7LdniOGPnZkrQ==
X-Received: by 2002:a05:620a:2952:b0:7ce:e010:88bb with SMTP id af79cd13be357-7cfc5d3bea0mr319652185a.22.1748447131835;
        Wed, 28 May 2025 08:45:31 -0700 (PDT)
Received: from [172.20.4.10] ([50.234.147.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cfb82002bdsm84495085a.17.2025.05.28.08.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 08:45:31 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a9d0e503-ec70-41a7-adb2-989082e4d9f2@redhat.com>
Date: Wed, 28 May 2025 11:45:29 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: cgroup: clarify controller enabling
 semantics
To: Vishal Chourasia <vishalc@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250527085335.256045-2-vishalc@linux.ibm.com>
 <99be9c8e-a5c4-4378-b03b-2af01608de9f@redhat.com>
Content-Language: en-US
In-Reply-To: <99be9c8e-a5c4-4378-b03b-2af01608de9f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/28/25 11:23 AM, Waiman Long wrote:
> On 5/27/25 4:53 AM, Vishal Chourasia wrote:
>> The documentation for cgroup controller management has been updated to
>> be more consistent regarding following concepts:
>>
>> What does it mean to have controllers
>> 1) available in a cgroup, vs.
>> 2) enabled in a cgroup
>>
>> Which has been clearly defined below in the documentation.
>>
>> "Enabling a controller in a cgroup indicates that the distribution of
>> the target resource across its immediate children will be controlled.
>> Consider the following sub-hierarchy"
>>
>> As an example, consider
>>
>> /sys/fs/cgroup # cat cgroup.controllers
>> cpuset cpu io memory hugetlb pids misc
>> /sys/fs/cgroup # cat cgroup.subtree_control # No controllers by default
>> /sys/fs/cgroup # echo +cpu +memory > cgroup.subtree_control
>> /sys/fs/cgroup # cat cgroup.subtree_control
>> cpu memory                   # cpu and memory enabled in /sys/fs/cgroup
>> /sys/fs/cgroup # mkdir foo_cgrp
>> /sys/fs/cgroup # cd foo_cgrp/
>> /sys/fs/cgroup/foo_cgrp # cat cgroup.controllers
>> cpu memory                   # cpu and memory available in 'foo_cgrp'
>> /sys/fs/cgroup/foo_cgrp # cat cgroup.subtree_control  # empty by default
>> /sys/fs/cgroup/foo_cgrp # ls
>> cgroup.controllers      cpu.max.burst           memory.numa_stat
>> cgroup.events           cpu.pressure            memory.oom.group
>> cgroup.freeze           cpu.stat                memory.peak
>> cgroup.kill             cpu.stat.local          memory.pressure
>> cgroup.max.depth        cpu.weight              memory.reclaim
>> cgroup.max.descendants  cpu.weight.nice         memory.stat
>> cgroup.pressure         io.pressure memory.swap.current
>> cgroup.procs            memory.current memory.swap.events
>> cgroup.stat             memory.events           memory.swap.high
>> cgroup.subtree_control  memory.events.local     memory.swap.max
>> cgroup.threads          memory.high             memory.swap.peak
>> cgroup.type             memory.low memory.zswap.current
>> cpu.idle                memory.max              memory.zswap.max
>> cpu.max                 memory.min memory.zswap.writeback
>>
>> Once a controller is available in a cgroup it can be used to resource
>> control processes of the cgroup.
>>
>> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst 
>> b/Documentation/admin-guide/cgroup-v2.rst
>> index 1a16ce68a4d7..0e1686511c45 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -438,8 +438,8 @@ Controlling Controllers
>>   Enabling and Disabling
>>   ~~~~~~~~~~~~~~~~~~~~~
>>   -Each cgroup has a "cgroup.controllers" file which lists all
>> -controllers available for the cgroup to enable::
>> +Each cgroup has a cgroup.controllers file, which lists all the 
>> controllers
>> +available for that cgroup and which can be enabled for its children.
>
> I believe breaking the sentence into two separate components is 
> actually making it less correct. There are implicit controllers that 
> are always enabled and do not show up in cgroup.controllers. Prime 
> examples are perf_event and freezer. IOW, only controllers that are 
> available and need to be explicitly enabled will show up.

A correction: The cgroup.controllers file shows the controllers that are 
available in the current cgroup and which have to be explicitly enabled 
in cgroup.subtree_control to make them available in the child cgroups.

Cheers,
Longman


