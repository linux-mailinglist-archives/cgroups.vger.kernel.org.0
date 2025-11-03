Return-Path: <cgroups+bounces-11482-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB18C29ED4
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 04:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 859614E6790
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 03:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DEF9460;
	Mon,  3 Nov 2025 03:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTHY9x+z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PujspCJK"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B334D3B5
	for <cgroups@vger.kernel.org>; Mon,  3 Nov 2025 03:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139562; cv=none; b=XTLH5cYH05uE+Muhgzrvq9Qs6lVLOweGtI5bWfXsah8hTxCYII6hb2PrMXsjvpfsa3OkA8DWLPqhUbz1OWFlAseA4+GwYfIeF0Pyku7f3/Ip7pbhw+FGWiChvvTOF20grXRdeoSN38GDHKeFQzVCWptd88QGuQ423/cmok1JrYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139562; c=relaxed/simple;
	bh=S5lhzElP8mKmku7HndUOsllDqxcCj00rLtLHo93bS6U=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PcKIzYKYdSlDbnODaJBTYOfEIA7iCWW8vIHSrL8MP3y7CKM2/knsQ1a2+gZ7c7JZFKftgYe+kbVbceOzyHZ3Dy2J7Tc9z1LTWJILfJgkk09NpWcB2SQlxfMIPJEF5WtV7NEvp98fFL3Bar2gPn9t+CcXAFWFuLjNmeD8oJPaf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTHY9x+z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PujspCJK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762139559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfdEr1jxJKtYpq9KoY5qe0Z0hYY/0s/1RnPyyPEXS34=;
	b=OTHY9x+z2o8xACLodO7hrqmacgADuXqF4y5xb+ClQvOad+OAq9LpmS4cL/AC/+FGIQfZ6l
	ebdIIfhsUrUWSx0Eve2bvAZEjmqq2eoGiryFtTRTLck7xs5cnp+XZh5nCUUq97xSXrPJKU
	0wm25Syz8HdVlgG77Bz3X3HS+Soj6lY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-pzBocHDJM8meYIx_P2L90Q-1; Sun, 02 Nov 2025 22:12:37 -0500
X-MC-Unique: pzBocHDJM8meYIx_P2L90Q-1
X-Mimecast-MFC-AGG-ID: pzBocHDJM8meYIx_P2L90Q_1762139556
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78f2b1bacfcso89972296d6.3
        for <cgroups@vger.kernel.org>; Sun, 02 Nov 2025 19:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762139556; x=1762744356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qfdEr1jxJKtYpq9KoY5qe0Z0hYY/0s/1RnPyyPEXS34=;
        b=PujspCJKr5I5ja9cvUq/6AWaku4kgiIl6jbYNFJb32J7efL/FKhOnojvOVdfcejuih
         1tjdBv5I1NWhZx/QLIpC/9yuCq6SjVx1hMg28jGMACrjxGxtQx8nqitanQ2GC+jnXFSM
         KrNI82xRtgpAupxqWE0IV7nXw+Ly+q5rfJZeT1KCX0BjE/5emRqZv+EIzMxowZLy8LcZ
         gq5Q9Xf8uLxBdakFeKceb0HWlDKzhiBBeF7rpRreInjTkhNY1ZJEdh4/RwOiHy2AHDhr
         Hx0FxsVxXVVOIb+ZtcujEUrthDb05JhW4Qiv+eVcvGLujJ7exZOF9lpoUa12zbliPz+m
         XRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762139556; x=1762744356;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfdEr1jxJKtYpq9KoY5qe0Z0hYY/0s/1RnPyyPEXS34=;
        b=H6W1llF4dm+Fap5YApT2/xo/WOhMbcRvuJ8AisgXyqSqm+8V0oz3wPkFRXVVsDaTth
         AJE8awnG+4iomZ5tBbK3Yq+6PZadFRIhPmgPc4AnLnCeoIqwdVS2ja3cHYIikJZfOoR3
         x4sGTxEBVKte4hI/BS+E1g56SnV5vos6tK1QlsoNCM60/YtMZcH0FimYrq9U1Giz+vpe
         TX6UbNOGCDrNQMhFSJdS8VdA3LUlHFcIOjU0aHsKJyddYBGo0gKU0B+6BkDGXOwoA2Dd
         6C2uJauzIYUdr1+I9bn3/rKLO6iiF+di5VFcOGvU3v68L5YzKAJg0Rl5cmKFTgUjhWif
         faMQ==
X-Gm-Message-State: AOJu0YwZaQvA/HpfSGzRIFDRKtNAsY+hWSejxuI0ml2XAmmTCIXqKI2T
	a4fU5hd3H8cpx6OQpAeOMvkjoIuxO0OaRqnX8I4Js8PGJV3EMZy1IvwyxfA5XAlWEWmrI8VvEdA
	EoC8TFDdpd1m9J+H/H8I8bAMYkf3FF/chNBbZzID4gZIYEBYTAdafJ6m0qLQ=
X-Gm-Gg: ASbGnctwLH5xyIzVh5lW4A+tUtS0hEKvaGQEV3dKJJ6j5w4zdjScUwbBc4snoccNkpG
	zmaIqMGJYDmByKXE6MwWsDEZvab9nlTplNBTL3W5zL5wUxt0FcP/0EEK3TElWD6pki0vLVDPCZS
	3osetpCTh5pNw649gDPbECL+PUaXEzqVetdyFsWVC+u3VIyKh8+B2hJl0WQwUb29f7JdiVnx9n7
	2Al+CIGDZ2OmnsuFA5huvwtTic08nB0z+z8QutEy2LppOqGYOOczefiLYPH0CoQDF5BYrrm9BHx
	DBf/ussXas8FAoOlUoyndqqLEDK+zHIxjKiK1FDT9EIgeTYwH2Cs8P5zffj6+9Wi/Bx/1AsAZCk
	Je/cH40YSzkilYVl4LtQEaELitMM/0qUTI/2fuN6Trs5Baw==
X-Received: by 2002:a05:6214:d64:b0:880:4f33:4666 with SMTP id 6a1803df08f44-8804f334d94mr58783016d6.20.1762139556269;
        Sun, 02 Nov 2025 19:12:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcfeKBmG70eDimSeDmwKwC562nYZpblijcMB08FrdeomYXqHJAlEgptfXX8UOLwzXJtatUYw==
X-Received: by 2002:a05:6214:d64:b0:880:4f33:4666 with SMTP id 6a1803df08f44-8804f334d94mr58782786d6.20.1762139555843;
        Sun, 02 Nov 2025 19:12:35 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8804ba4b832sm31857146d6.36.2025.11.02.19.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 19:12:35 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b34dc762-5a90-428b-815f-0c2b351078bf@redhat.com>
Date: Sun, 2 Nov 2025 22:12:34 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH 2/3] cgroup/cpuset: Fail if isolated and
 nohz_full don't leave any housekeeping
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251103013411.239610-1-longman@redhat.com>
 <20251103013411.239610-3-longman@redhat.com>
 <8da89966-b891-4088-9699-e82863e52415@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <8da89966-b891-4088-9699-e82863e52415@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/25 9:55 PM, Chen Ridong wrote:
>
> On 2025/11/3 9:34, Waiman Long wrote:
>> From: Gabriele Monaco <gmonaco@redhat.com>
>>
>> Currently the user can set up isolated cpus via cpuset and nohz_full in
>> such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
>> domain isolated nor nohz full). This can be a problem for other
>> subsystems (e.g. the timer wheel imgration).
>>
>> Prevent this configuration by blocking any assignation that would cause
>> the union of domain isolated cpus and nohz_full to covers all CPUs.
>>
>> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>> Reviewed-by: Waiman Long <longman@redhat.com>
>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 67 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 66 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index da770dac955e..d6d459c95d82 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1329,6 +1329,19 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
>>   		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
>>   }
>>   
>> +/*
>> + * isolated_cpus_should_update - Returns if the isolated_cpus mask needs update
>> + * @prs: new or old partition_root_state
>> + * @parent: parent cpuset
>> + * Return: true if isolated_cpus needs modification, false otherwise
>> + */
>> +static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
>> +{
>> +	if (!parent)
>> +		parent = &top_cpuset;
>> +	return prs != parent->partition_root_state;
>> +}
>> +
> Hi Longman,
>
> I am confused about this function.
>
> Why do we need to compare the partition_root_state (prs) with the parent's partition_root_state?
>
> For example, when a local partition is assigned to a member, I don't think the isolated cpumasks
> should be updated in this case.
>
> In my understanding, the isolated CPUs should only be updated when an isolated partition is being
> disabled or enabled. I was thinking of something like this:
>
> bool isolated_cpus_should_update(int new_prs, int old_prs)
> {
>      if (new_prs == old_prs)
>          return false;
>      if (old_prs == 2 || new_prs == 2)
>          return true;
>      return false;
> }
>
> I would really appreciate it if you could provide some further explanation on this.

This function should only be called when both the current and the parent 
(top_cpuset for remote) are valid partition roots. For both local and 
remote partition, the child cpuset takes CPUs from the parent. The list 
of isolated CPUs will only change if parent and child cpusets have 
different partition root types. If parent is an isolated partition, 
taking CPUs from parent to form another isolated partition will not 
change isolated_cpus. The same is true if both parent and child are root.

You are right that this check may not be obvious for a casual observer. 
I can add some more comments to clarify that.

Cheers,
Longman

>


