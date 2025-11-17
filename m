Return-Path: <cgroups+bounces-12046-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CA1C65C19
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 19:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DAD34E4B4E
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 18:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4501331AF12;
	Mon, 17 Nov 2025 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUSUa9RV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="chk80gK5"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D9D3195E2
	for <cgroups@vger.kernel.org>; Mon, 17 Nov 2025 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404990; cv=none; b=L6leqJ/8J+tfbr0RTK1d9aOamOZqAoySN/z+D/lYGDPQbWXEkrcL5uASrNqA2xULn043OWoTBz1HjQJjfsAMeMUp0QvdpEL5wt5yHXQw5/5FXuL4OMvZbOBZ8ObmHaK9TjZjm26ZD/l9+MJXdyxXkDTJUKSO3GXKa/vkhojZXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404990; c=relaxed/simple;
	bh=GIG/iyDk/a3m0i27C/ULXzWZKuo5X7gaeRrIaW50xR8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V3A1NfLst3s9Q6GG+N/zAjc+phEHgusGtFD6s5utLWeRFpf1Y3RnF/5P7qpzN6LeYQesbE4nrHDEJaT5gn0ZGSftYQJR2NeHS1SiMC0h8w/ZkAyFaogNQhg8Nw1CBSXoGPkY7tteYSdiMk7i/aeyi78oM65ZeNq5g4rMU30vA8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUSUa9RV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=chk80gK5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763404987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XpfOGVqLv8brfQ8QJuGmJSNw8lcPJaQQkI4+G0V1iic=;
	b=iUSUa9RVFOlvyMQJ0VC5z82bSuZL2dEINUfYmRFYjEBpa/rtN9q08tMxoBF9dSo1lEijzI
	Vn317FG7u9osXruHm6IFDspvVl02PYp/RScqf+NuQ3h24yKZ4sQznCp0zk/sC5JxsJTQCs
	Xp6Qq8tK3LQ0lhK91md8DxtM8grKg8A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-foB5muRrNmWe4V3j3K3I-w-1; Mon, 17 Nov 2025 13:43:05 -0500
X-MC-Unique: foB5muRrNmWe4V3j3K3I-w-1
X-Mimecast-MFC-AGG-ID: foB5muRrNmWe4V3j3K3I-w_1763404984
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8805c2acd64so156578336d6.3
        for <cgroups@vger.kernel.org>; Mon, 17 Nov 2025 10:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763404984; x=1764009784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XpfOGVqLv8brfQ8QJuGmJSNw8lcPJaQQkI4+G0V1iic=;
        b=chk80gK5hGYLznobaSphkDvyCHLuUBNezstAp/yN6Q+9iWibx+9wGqMMH32wXnBw7f
         klRacwNqWWiUwix9ZMFxe6Tj1wHbLl3xJ7ZN8E2cwBavFLd61bDec7IoGPlrEZqD5nkN
         oVr7jehFhlKJO5zNlLrxYNCrphk9Je9ST3pOCAY1GMxZjzY3Qln91cP9mq7NBBZXsrus
         5r/DXTpjUuBfCICcePvs3Ao8mx+q2PFDkOZDv4qbyiadOVQUZ3mPl8uPshRhFy1knzjK
         0jd7QqpjZq1/M/y99318yqnsyHJR981BQPUiNWu7lwSlt4ZiGy2jMcOQ6/pT4YzcP1ft
         7JyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763404984; x=1764009784;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpfOGVqLv8brfQ8QJuGmJSNw8lcPJaQQkI4+G0V1iic=;
        b=Z0pB8bc1HyTqpNnzFSSgTCjb0QNCAeHLKT35mkVigQYVdSRkJyl1qmcseznJ24SFqf
         3D1/cP7hSGR0A/35h8c+XXqtCJcKMXDyEjBoOpFUbvFjI+G4JGgkJsOSflbLQQ3l2zdG
         rPlYKtNuuQY+F/tLaF5Pbk50LTVpzIjl4MCT7SAPd6viLYMvzqWf3N3a1gz9CGGKrXBc
         /FIylKyWZdVW0gvsvzFTOyhI7Jc2Z859lJVfYGEG+do3MA6YvOd973lqvL0SEf5iJhES
         1+Qsi64r/dGv9YkkErosHfY0nVxWXeji+tQVENcBHtgAcyMZmDikyYngKW9KJUBBVbjh
         xD8g==
X-Gm-Message-State: AOJu0YxxNV9+3haCfF7FdjHWM86OcFBGONZ5b/Obf8NjmPZCWOVbj7h8
	rxvpt0CpuKUn4lbuiO7dbgnDR1ZJmmAUojvJ5Z1RGryk098B54/TbaT4O9knEt7oK+RT4cmxDFE
	rgJxGygmk+uY2cbuNUK4yUKUyP6xAumqdnufxrjnJo6ngJMG/uEV23mtfSYs=
X-Gm-Gg: ASbGncuey2LEUn2rH68IVEMC9M9A6XM0YFrAM1/1H1HgZSWUERuumY95WYeZye0n7bl
	cFWwqi5Zgy+pQByDEKGqd6kEQc5WcMk3pYquHxb1hvSfVRCVlx8rQH9ZHNQtGgL/mnKNRSCTHgT
	bLnM8nJI8jMtm4Mg5zu7BJ1dILe4y2ZhPKFi09z1/qpascw+wZBn9CyfdfwDRAC/pEeeEwtWvxu
	o9bP2mCtJ/CXTqSIlrqEMn4eHSF5DwwNy7hQ+SmrqXgbS3xTqTDsl7T8xjJUkgtvFJUZQ22U+q4
	Lc7nvEZzQQDszNkafZlsabTTUhPspeB8ClXnwbm+6zSqklFhNDP8tTn/Z3smYdHfzyz8UY78aFC
	uq8cCoYks4Waa18puTpdDTK6PCqCPMnw/8BbzB+ySYy+EFQ==
X-Received: by 2002:a05:6214:4107:b0:809:19ab:599f with SMTP id 6a1803df08f44-882926025bbmr171908776d6.27.1763404984415;
        Mon, 17 Nov 2025 10:43:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQrDJLX+yOoO3ZzmOViiV0w0QFUdIMlBhGy2JuQArUWTmQJ0fqku/2pfP07YjDe5rOa6U05A==
X-Received: by 2002:a05:6214:4107:b0:809:19ab:599f with SMTP id 6a1803df08f44-882926025bbmr171908296d6.27.1763404983958;
        Mon, 17 Nov 2025 10:43:03 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828655e55bsm96747376d6.43.2025.11.17.10.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 10:43:03 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <52026e81-9cf6-4711-9bd0-4b57b31021a4@redhat.com>
Date: Mon, 17 Nov 2025 13:43:02 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
To: Sun Shaojie <sunshaojie@kylinos.cn>, chenridong@huaweicloud.com,
 mkoutny@suse.com, llong@redhat.com
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, tj@kernel.org
References: <19fa5a93-4cc9-4f84-891c-b3b096a68799@huaweicloud.com>
 <20251115060211.853449-1-sunshaojie@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20251115060211.853449-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/15/25 1:02 AM, Sun Shaojie wrote:
> On 2015/11/15 08:58, Chen Ridong wrote:
>> On 2025/11/15 0:14, Michal Koutný wrote:
>>> On Fri, Nov 14, 2025 at 09:29:20AM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>>>> After further consideration, I still suggest retaining this rule.
>>> Apologies, I'm slightly lost which rule. I hope the new iteration from
>>> Shaojie with both before/after tables will explain it.
>>>
>> The rule has changed in this patch from "If either cpuset is exclusive, check if they are mutually
>> exclusive" to
>> "If both cpusets are exclusive, check if they are mutually exclusive"
>>
>>   -    /* If either cpuset is exclusive, check if they are mutually exclusive */
>>   -    if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
>>   +    /* If both cpusets are exclusive, check if they are mutually exclusive */
>>   +    if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
>>   +        return !cpusets_are_exclusive(cs1, cs2);
>>
>> I suggest not modifying this rule and keeping the original logic intact:
>>
>>>> For am example:
>>>>    Step                                       | A1's prstate | B1's prstate |
>>>>    #1> mkdir -p A1                            | member       |              |
>>>>    #2> echo "0-1" > A1/cpuset.cpus.exclusive  | member       |              |
>>>>    #3> echo "root" > A1/cpuset.cpus.partition | root         |              |
>>>>    #4> mkdir -p B1                            | root         | member       |
>>>>    #5> echo "0" > B1/cpuset.cpus              | root invalid | member       |
>>>>
>>>> Currently, we mark A1 as invalid. But similar to the logic in this patch, why must A1 be
>>>> invalidated?
>>> A1 is invalidated becase it doesn't have exclusive ownership of CPU 0
>>> anymore.
>>>
>>>> B1 could also use the parent's effective CPUs, right?
>>> Here you assume some ordering between siblings treating A1 more
>>> important than B1. But it's symmetrical in principle, no?
>>>
>> I’m using an example to illustrate that if Shaojie’s patch is accepted, other rules could be relaxed
>> following the same logic—but I’m not in favor of doing so.
> Hi, Ridong,
>
> Thank you for pointing out the issue with the current patch; this is indeed
> not what our product intends. I must admit that I haven't thoroughly tested
> on such recent kernel versions.
>
> Obviously, this patch is flawed. However, patch v3 is needed. Regarding the
> "other rules" you mentioned, we do not intend to relax them. On the
> contrary, we aim to maintain them firmly.
>
> Our product need ensure the following behavior: in cgroup-v2, user
> modifications to one cpuset should not affect the partition state of its
> sibling cpusets. This is justified and meaningful, as it aligns with the
> isolation characteristics of cgroups.
>
> This can be divided into two scenarios:
> Scenario 1: Only one of A1 and B1 is "root".
> Scenario 2: Both A1 and B1 are "root".
>
> We plan to implement Scenario 1 first. This is the goal of patch v2.
> However, patch v2 is flawed because it does not strictly adhere to the
> following existing rule.
>
> However, it is worth noting that the current cgroup v2 implementation does
> not strictly adhere to the following rule either (which is also an
> objective for patch v3 to address).
>
> Rule 1: "cpuset.cpus" cannot be a subset of a sibling's "cpuset.cpus.exclusive".

Inside the cpuset code, the rule should be "cpuset.cpus should not be a 
subset of sibling's cpuset.cpus.exclusive".

Note that one rule that should always be followed in v2 is that writing 
any valid cpumask into cpuset.cpus is allowed, but writing to 
cpuset.cpus.exclusive may fail if some rules are violated. If the new 
cpuset.cpus violate the rules for a sibling partition root, the current 
code will invalidate the sibling partition. I am not against changing 
the cpuset.cpus.effective to a suitable value to avoid the conflict 
instead invalidating a sibling partition. We do need to make sure that 
the new behavior is consistent under different circumstances.

>
> Using your example to illustrate.
>   Step (refer to the steps in the table below）
>   #1> mkdir -p A1
>   #2> echo "0-1" > A1/cpuset.cpus.exclusive
>   #3> echo "root" > A1/cpuset.cpus.partition
>   #4> mkdir -p B1
>   #5> echo "0" > B1/cpuset.cpus
>
> Table 1: Current result
>   Step | return | A1's excl_cpus | B1's cpus | A1's prstate | B1's prstate |
>   #1   | 0      |                |           | member       |              |
>   #2   | 0      | 0-1            |           | member       |              |
>   #3   | 0      | 0-1            |           | root         |              |
>   #4   | 0      | 0-1            |           | root         | member       |
>   #5   | 0      | 0-1            | 0         | root invalid | member       |
>
> Table 2: Expected result
>   Step | return | A1's excl_cpus | B1's cpus | A1's prstate | B1's prstate |
>   #1   | 0      |                |           | member       |              |
>   #2   | 0      | 0-1            |           | member       |              |
>   #3   | 0      | 0-1            |           | root         |              |
>   #4   | 0      | 0-1            |           | root         | member       |
>   #5   | error  | 0-1            |           | root         | member       |
>
> Currently, after step #5, the operation returns success, which clearly
> violates Rule 1, as B1's "cpuset.cpus" is a subset of A1's
> "cpuset.cpus.exclusive".
>
> Therefore, after step #5, the operation should return error, with A1
> remaining as "root". This better complies with the Rule 1.
>
> ------
> The following content is provided for reference, and we hope it may be
> adopted in the future.
> !!These are not part of what patch v3 will implement.
>
> As for Scenario 2 (Both A1 and B1 are "root")， we will retain the current
> cgroup v2 behavior. This patch series does not modify it, but we hope to
> draw the maintainers' attention, as we indeed have plans for future
> modifications. Our intent can be seen from the following examples.
>
> For example:
>   Step (refer to the steps in the table below）
>   #1> mkdir -p A1
>   #2> echo "0-1"  > A1/cpuset.cpus
>   #3> echo "root" > A1/cpuset.cpus.partition
>   #4> mkdir -p B1
>   #5> echo "2-3"  > B1/cpuset.cpus
>   #6> echo "root" > B1/cpuset.cpus.partition
>   #7> echo "1-2"  > B1/cpuset.cpus
>
> Table 1: Current result
>   Step | A1's eft_cpus | B1's eft_cpus | A1's prstate | B1's prstate |
>   #1   | from parent   |               | member       |              |
>   #2   | 0-1           |               | member       |              |
>   #3   | 0-1           |               | root         |              |
>   #4   | 0-1           | from parent   | root         | member       |
>   #5   | 0-1           | 2-3           | root         | member       |
>   #6   | 0-1           | 2-3           | root         | root         |
>   #7   | 0-1           | 1-2           | root invalid | root invalid |
>
> Table 2: Expected result
>   Step | A1's eft_cpus | B1's eft_cpus | A1's prstate | B1's prstate |
>   #1   | from parent   |               | member       |              |
>   #2   | 0-1           |               | member       |              |
>   #3   | 0-1           |               | root         |              |
>   #4   | 0-1           | from parent   | root         | member       |
>   #5   | 0-1           | 2-3           | root         | member       |
>   #6   | 0-1           | 2-3           | root         | root         |
>   #7   | 0-1           | 2             | root         | root invalid |
>
> After step #7, we expect A1 to remain "root" (unaffected), while only B1
> becomes "root invalid".
>
>   
> The following Rule 2 and Rule 3 are alsomplemented and adhered to by our
> product. The current cgroup v2 implementation does not enforce them.
> Likewise, we hope this will draw the maintainers' attention. Maybe, they can
> be applied in the future.
>
> Rule 2: In one cpuset, when "cpuset.cpus" is not null, "cpuset.cpus.effective"
>          must either be a subset of it, or "cpuset.cpus.effective" is null.

cpuset.cpus.effective will never be null in v2 with the exception of a 
partition root distributing out all its CPUs to child sub-partitions.


>
> Rule 3: In one cpuset, when "cpuset.cpus" is not null, "cpuset.cpus.exclusive"
>          must either be a subset of it, or "cpuset.cpus.exclusive" is null.

We currently don't have this rule in the cpuset code as 
cpuset.cpus.exclusive can be independent of "cpuset.cpus".  We could 
implement this rule by failing the cpuset.cpus.exclusive write in this 
case, but we can't fail the write to "cpuset.cpus" if the rule is violated.

Cheers,
Longman


