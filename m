Return-Path: <cgroups+bounces-9221-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A69BB28636
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 21:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7C21D031A7
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 19:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FFB25B305;
	Fri, 15 Aug 2025 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJvfjfy1"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5CD230BD5
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285240; cv=none; b=i0xvWYxHIdcqQxB+JexXBIA3FamMEiLNB8bjppbBNdJXAwYfos2NmXPsnrcJOX66FFdwDlWwISjKvz7OV0Rg2OX58qvMh296Bn+FFU87gGpixyUxubfyHrrYEw0Ve8Z0/5dFC1N1DlACUIMd/ihhpiexV9tjrNWl++Ub2juLT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285240; c=relaxed/simple;
	bh=oNhweOl6Iq/Hda3o5m5+6ZwPRynn8p1xkDuLuBJGJcY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KkBS9XKzVz/qkFMrQepVjeFPs4OvrBvhhkVn0TbMyeRo0y1jReZfds+Wd+BbVFzk1rowyy0bQP5NQqDC0xlfcl65pmlc4Ye7FWLFiB+zpSE3WTyWybYCXAInFyuzQy9Yw7qKgm90uUOiJnrHmTYL/Mzm79crwvOffAfwftBE5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJvfjfy1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755285237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NnFY7XGdPFGZ6/tk81vvfIJer3/1BjfcPoDujGBtK4=;
	b=BJvfjfy1AYUpxJe4rPBwFFc1wG0LVcONhKAcFKclRH21LmRJura9wUzPp7xqNvN+CAhFyo
	O/tPHTvOk+SIDYSEONLd8PMkQTfMi3viTYAv1Ag1DiVAIFToYKzyYg7zf1I+X/9782QcFv
	I9vcDqou2UvfhObPl8r+tBZrtd2iraQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-zrIhLgYuNXeSNspkoTGX1A-1; Fri, 15 Aug 2025 15:13:51 -0400
X-MC-Unique: zrIhLgYuNXeSNspkoTGX1A-1
X-Mimecast-MFC-AGG-ID: zrIhLgYuNXeSNspkoTGX1A_1755285231
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a928282a3so72039016d6.1
        for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 12:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755285230; x=1755890030;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NnFY7XGdPFGZ6/tk81vvfIJer3/1BjfcPoDujGBtK4=;
        b=h4lb18jodqYQrC9SKzOEGFtjgIg8U1zsnNj+HvCHjTmaSiuY+GjzcgPdOlEYBYjPLP
         z4kM5UPL7n6aQbpFkK0/0tftQdb5R8o7gInHOokYC/iG4caL9Za+eCAUYxdF0YHMu6PA
         In0bIEY7HWpGQcPF2F7mfRXjKcWkgfHV/S8Fd5p/cJjbk/vv3+s7zPOCr1mD/sdG/Xpn
         nZEhPO+wfdE6eaD5LDKVmFN/MWY3T0FCo/OPe/ObDpMzfyEEnG3mGP1xEUfEqatuCjIy
         3Up9lDbbvgELa2wpN514CZhRYluBXO1P2h1x8VLrdUbSHJWqUZrLNVDdxibsTslOkPXB
         Hezg==
X-Gm-Message-State: AOJu0YxqTLFPoXh/2p3Ug/AiApZW9R/2owtVLMMTTBKDlGNsTx3AJtTz
	9xOe62y+JPS6CyRVkDMDl/m962vrgBayw900koue8SDR/7riN0kibBGn0jwYsANIoVn1RLCXZmv
	lamlP6k6O7l/iKhA/o6Fbm3EYPcgP7khnoj09pQ8BzGTdwwmp2ZWa9cxalr0=
X-Gm-Gg: ASbGncsGnjhN/IXuOIj3q1UGZLapd/ccZjUfgjPyTCxVgfuvp2ecSszbRaWuV8yTXip
	qxFIgMQcWbpLNoG/Tc1XhyHxy+Pvjv3BEo7fjoFOwyBd7IkCKCk0IUX+0j9bmaamGZ7AMYTF8zZ
	jpzrKtbLWRqeyPHTwYB1jYthp90g0NVbALNc7nfQ0VUpvXjWeZU28hSY7iyzi7/G+OVT/9A7ld2
	95z0VYRtu9odKV7F3dY6RNWzBW3FG4EuPBhsJIHqedcX5F/5ie8cDeX838cFt2rXaoIN955z3Du
	BSpXR+ZXVrAMVA5iL4BB5ZwTG0URQiKXVLpOu6pOQkTJlgPUBZa5jzb3xn5WzovkcIxRciW9kzv
	Ga0nwQkPlUA==
X-Received: by 2002:ad4:5aa6:0:b0:6fd:236f:abb4 with SMTP id 6a1803df08f44-70ba7c33008mr39939526d6.34.1755285230510;
        Fri, 15 Aug 2025 12:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFWqragQ70JVZ9oModMUHd76UYFFhu+9iT3ePLx/Lzp8VZiH2Q7Yl1XvW0lTL2bJNoB5gssQ==
X-Received: by 2002:ad4:5aa6:0:b0:6fd:236f:abb4 with SMTP id 6a1803df08f44-70ba7c33008mr39939176d6.34.1755285230097;
        Fri, 15 Aug 2025 12:13:50 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba902f827sm12451976d6.10.2025.08.15.12.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 12:13:49 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <820ec990-9695-46d0-ae95-2c0eda66bf9c@redhat.com>
Date: Fri, 15 Aug 2025 15:13:48 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [-next v2 4/4] cpuset: add helpers for cpus read and cpuset_mutex
 locks
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com, christophe.jaillet@wanadoo.fr
References: <20250813082904.1091651-1-chenridong@huaweicloud.com>
 <20250813082904.1091651-5-chenridong@huaweicloud.com>
 <e0ac3594-deab-455c-9c2f-495b4e4422e2@redhat.com>
 <750ac0bd-42f9-47fa-8274-0ff4e4a7fa3d@huaweicloud.com>
 <93e37ccf-8ac8-40f5-840f-2f221f58131e@redhat.com>
 <d09c4e49-8a3a-49b9-9f63-0b39a4bea45f@redhat.com>
 <c88c6e2e-5988-405c-a037-651a8800ba83@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <c88c6e2e-5988-405c-a037-651a8800ba83@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/25 11:58 PM, Chen Ridong wrote:
>
> On 2025/8/14 11:27, Waiman Long wrote:
>> On 8/13/25 11:13 PM, Waiman Long wrote:
>>> On 8/13/25 8:44 PM, Chen Ridong wrote:
>>>> On 2025/8/14 4:09, Waiman Long wrote:
>>>>> On 8/13/25 4:29 AM, Chen Ridong wrote:
>>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>>>
>>>>>> cpuset: add helpers for cpus_read_lock and cpuset_mutex
>>>>>>
>>>>>> Replace repetitive locking patterns with new helpers:
>>>>>> - cpus_read_cpuset_lock()
>>>>>> - cpus_read_cpuset_unlock()
>>>>>>
>>>>>> This makes the code cleaner and ensures consistent lock ordering.
>>>>>>
>>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>>>> ---
>>>>>>     kernel/cgroup/cpuset-internal.h |  2 ++
>>>>>>     kernel/cgroup/cpuset-v1.c       | 12 +++------
>>>>>>     kernel/cgroup/cpuset.c          | 48 +++++++++++++++------------------
>>>>>>     3 files changed, 28 insertions(+), 34 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>>>>>> index 75b3aef39231..6fb00c96044d 100644
>>>>>> --- a/kernel/cgroup/cpuset-internal.h
>>>>>> +++ b/kernel/cgroup/cpuset-internal.h
>>>>>> @@ -276,6 +276,8 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int
>>>>>> turning_on)
>>>>>>     ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>>>>>                         char *buf, size_t nbytes, loff_t off);
>>>>>>     int cpuset_common_seq_show(struct seq_file *sf, void *v);
>>>>>> +void cpus_read_cpuset_lock(void);
>>>>>> +void cpus_read_cpuset_unlock(void);
>>>>> The names are not intuitive. I would prefer just extend the cpuset_lock/unlock to include
>>>>> cpus_read_lock/unlock and we use cpuset_lock/unlock consistently in the cpuset code. Also, there is
>>>>> now no external user of cpuset_lock/unlock, we may as well remove them from include/linux/cpuset.h.
>>>>>
>>>>> Cheers,
>>>>> Longman
>>>> I like the idea and have considered it.
>>>> However, I noticed that cpuset_locked is being used in __sched_setscheduler.
>>> Right, I overloooked the cpuset_lock() call in kernel/sched/syscall.c. So we can't remove it from
>>> include/linux/cpuset.h.
>>>
>>> This call is invoked to ensure cpusets information is stable. However, it doesn't hurt if the
>>> cpus_read_lock() is also acquired as a result. Alternatively, we can use a name like
>>> cpuset_full_lock() to include cpus_read_lock().
>> I have a correction. According to commit d74b27d63a8b ("cgroup/cpuset: Change cpuset_rwsem and
>> hotplug lock order") , sched_scheduler() can be called while holding cpus_hotplug_lock. So we should
>> keep cpuset_lock() as it is.
>>
>> Cheers,
>> Longman
> Thank you Longman, this is very helpful.
>
> I had considered whether we can add cpus_read_lock() to the cpuset_lock, but based on your
> explanation, I now understand this approach would not work.
>
> For clarity, would it be acceptable to rename:
> cpus_read_cpuset_lock() -> cpuset_full_lock()
> cpus_read_cpuset_unlock() -> cpuset_full_unlock()

Yes, that is what I want to see. Note that taking both cpus_read_lock() 
and cpuset_mutex are needed to modify cpuset data. Taking just 
cpuset_mutex will prevent other from making changes to the cpuset data, 
but is not enough to make modification.

Cheers,
Longman

>


