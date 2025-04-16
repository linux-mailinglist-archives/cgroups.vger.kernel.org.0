Return-Path: <cgroups+bounces-7604-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15721A90B56
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 20:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B3F3AEE15
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 18:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5FF221D8B;
	Wed, 16 Apr 2025 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbDpN3R2"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7965222585
	for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828359; cv=none; b=r+/fpPLlmzB8HhhUqWRCTp20iFKJd5UIuKfIcTIif5eU0f6lCZXP5T4HCzSnGBDxObzKiLTA8tQiNcBnE/TkkKP6XmEygtE0ixKDmk8c+Num6XTG83REy+frD+0rPef6i4Ca+ZCSMMnRnMg++ygsFDFYXKW+UuUsG9P9SHx/Nts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828359; c=relaxed/simple;
	bh=OK7Ey0BtUgWW06lWGTLWuND0IOi3KmXEKO+Sis0kdmM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=De1rwS0PIvUjhQO+pxIZUP4tRQ9e40CkYQMS7LRJ+zjlahbvTr/6NnA9C4wXI4TSYPb0yn1l+bb803fs30kK73WeM+DmKyEjxT10QlmCCL5uOFmOcvaFL7sRYeX7OkNrJnAxHarJ4zfkx2jZDi17OYh9+b1MO/mjJAefe6v3ysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KbDpN3R2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744828356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kr323rRxdGFQw1WKQ9MW3DvmEsbp5Of61M1I1hHN3QI=;
	b=KbDpN3R2t/Z50rognJfDsnl+dIepv2+mCPHOrq03iwfncOVJwNKNeIgXBCHhY8y7zm5ZhG
	45XhCs1XVrpeWIUthyMPGTgIrVSCBUPEJ6AfXS+Uk8EqlRM9VIyxPev5KH3Vl0S75edSsi
	CBC96YTx5ERd3gMSPNBCkygnRHTYJV4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-cltIrlwfMmyle97TsUgBNg-1; Wed, 16 Apr 2025 14:32:35 -0400
X-MC-Unique: cltIrlwfMmyle97TsUgBNg-1
X-Mimecast-MFC-AGG-ID: cltIrlwfMmyle97TsUgBNg_1744828354
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d81820d5b3so9686615ab.3
        for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 11:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744828354; x=1745433154;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kr323rRxdGFQw1WKQ9MW3DvmEsbp5Of61M1I1hHN3QI=;
        b=vzwqX8B5JG4uRaGrnbkNX9JBmcSp51eeOtF3nBo7/ILpTm5Po/RnS7paOOGjqFVxEL
         8nqFZeGoWb99cmkJ2coCjKIgwJs6oLcbhOUU3pRLFZ3Cvh5MMUAFVMsTXMg+DIzDKJvb
         dEilh3za4Z/8DtW8Qey9PBkN18Rb1P/mG7mJa9oJLCWxb6RtCJ86GjkZa5OxEQZAGLQR
         inki0cRuPJJPfwfYFCAki632Oh/21GWJ1svXFJvup5VPrZyx4kyzb4vd2h6nVJt6dxLZ
         p4FCzjZ4Pn2Gn+kJq2BW8lYviTOZZFVQOibwWOru29zbbFlqipQsg1UkvzfOQ972ogIo
         hTMw==
X-Forwarded-Encrypted: i=1; AJvYcCWWBQo9iX+I111TwIwwTez80MFqjjepibWT+89D3pJxN2/bxzo++EmLoT3kXde4MQIoiVUYmw96@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Q3nJ/AD8Gu0XOa+cWiY3iuuoJMnCKZcUJE76ywxMrSM9/FP8
	0FOwibb0CyrEElo4v8lzVqAJQqt5nhCzUl4udtCsrjJzL5PbFoWILpJS9LOb9o33oKXOQM2NmS2
	uPlEaTJD73FY8ZfQ0LhqCuHnEnaLKg90AuWl5KrDxjccSurJ1W1ODFa8=
X-Gm-Gg: ASbGncszgH9mSgSZWLxfwcjhPwPL1jTHkpU5PhXrCb9pH6XoNOF9wet/w5Jr9vCYkd3
	XN4ZbNBcwK+KFYSxwekuZHGaAVlsB3U7qFIdX3TZ653DOW8pExiXagVI484WyqWgkSyLrXX7NXy
	1O6IN13tzMCt5uGbBPO8u6ZEzLd9h5KwvPq1BwnSqQ82RftInN4g6QsWINKvbuNYuDqIeKCQFeF
	7hjrt2hjfjCnfFtSdTTrE8Oe6N2JPyyYOPQ5PRTy++S+tudeXINfzdHElebgLRZ5BRj7L4T8kS4
	cTypsFcDHi/CR0kA51Ljld/8aH8EJMIXDFmDIEkMp8P4E+7up/R/bUYqMQ==
X-Received: by 2002:a05:6e02:12c1:b0:3d0:239a:c46a with SMTP id e9e14a558f8ab-3d815b0a02amr29297015ab.9.1744828354535;
        Wed, 16 Apr 2025 11:32:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7UgFUryELyGYt+PcajPg95c5+km8NAhtDH/hDSoVhhN906AZjpwVw2Zy63FslCAWW+/bhsA==
X-Received: by 2002:a05:6e02:12c1:b0:3d0:239a:c46a with SMTP id e9e14a558f8ab-3d815b0a02amr29296885ab.9.1744828354204;
        Wed, 16 Apr 2025 11:32:34 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d80b6b0392sm9732595ab.63.2025.04.16.11.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 11:32:33 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8dafdb1b-e404-4862-836a-0bdf7e6efd23@redhat.com>
Date: Wed, 16 Apr 2025 14:32:32 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset-v1: Add missing support for
 cpuset_v2_mode
To: "T.J. Mercier" <tjmercier@google.com>, Waiman Long <llong@redhat.com>
Cc: Kamalesh Babulal <kamalesh.babulal@oracle.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250415235308.424643-1-tjmercier@google.com>
 <46892bf4-006b-4be1-b7ce-d03eb38602b3@oracle.com>
 <CABdmKX2zmQT=ZvRAHOjfxg9hgJ_9iCpQj_SDytHVG2UobdsfMw@mail.gmail.com>
 <146ecd0e-7c4c-4c8c-a11f-029fafb1f2e3@redhat.com>
 <CABdmKX2Basoq0Sk6qemcP3Mne6-nJPNN0Mz9WYjvdKWNagoaZg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABdmKX2Basoq0Sk6qemcP3Mne6-nJPNN0Mz9WYjvdKWNagoaZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/16/25 2:27 PM, T.J. Mercier wrote:
> On Wed, Apr 16, 2025 at 11:05 AM Waiman Long <llong@redhat.com> wrote:
>> On 4/16/25 1:55 PM, T.J. Mercier wrote:
>>> On Wed, Apr 16, 2025 at 2:19 AM Kamalesh Babulal
>>> <kamalesh.babulal@oracle.com> wrote:
>>>> Hi,
>>>>
>>>> On 4/16/25 5:23 AM, T.J. Mercier wrote:
>>>>> Android has mounted the v1 cpuset controller using filesystem type
>>>>> "cpuset" (not "cgroup") since 2015 [1], and depends on the resulting
>>>>> behavior where the controller name is not added as a prefix for cgroupfs
>>>>> files. [2]
>>>>>
>>>>> Later, a problem was discovered where cpu hotplug onlining did not
>>>>> affect the cpuset/cpus files, which Android carried an out-of-tree patch
>>>>> to address for a while. An attempt was made to upstream this patch, but
>>>>> the recommendation was to use the "cpuset_v2_mode" mount option
>>>>> instead. [3]
>>>>>
>>>>> An effort was made to do so, but this fails with "cgroup: Unknown
>>>>> parameter 'cpuset_v2_mode'" because commit e1cba4b85daa ("cgroup: Add
>>>>> mount flag to enable cpuset to use v2 behavior in v1 cgroup") did not
>>>>> update the special cased cpuset_mount(), and only the cgroup (v1)
>>>>> filesystem type was updated.
>>>>>
>>>>> Add parameter parsing to the cpuset filesystem type so that
>>>>> cpuset_v2_mode works like the cgroup filesystem type:
>>>>>
>>>>> $ mkdir /dev/cpuset
>>>>> $ mount -t cpuset -ocpuset_v2_mode none /dev/cpuset
>>>>> $ mount|grep cpuset
>>>>> none on /dev/cpuset type cgroup (rw,relatime,cpuset,noprefix,cpuset_v2_mode,release_agent=/sbin/cpuset_release_agent)
>>>>>
>>>>> [1] https://cs.android.com/android/_/android/platform/system/core/+/b769c8d24fd7be96f8968aa4c80b669525b930d3
>>>>> [2] https://cs.android.com/android/platform/superproject/main/+/main:system/core/libprocessgroup/setup/cgroup_map_write.cpp;drc=2dac5d89a0f024a2d0cc46a80ba4ee13472f1681;l=192
>>>>> [3] https://lore.kernel.org/lkml/f795f8be-a184-408a-0b5a-553d26061385@redhat.com/T/
>>>>>
>>>>> Fixes: e1cba4b85daa ("cgroup: Add mount flag to enable cpuset to use v2 behavior in v1 cgroup")
>>>>> Signed-off-by: T.J. Mercier <tjmercier@google.com>
>>>> The patch looks good to me, please feel free to add
>>>>
>>>> Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
>>>>
>>>> One nit below:
>>>>
>>>>> ---
>>>>>    kernel/cgroup/cgroup.c | 29 +++++++++++++++++++++++++++++
>>>>>    1 file changed, 29 insertions(+)
>>>>>
>>>>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>>>>> index 27f08aa17b56..cf30ff2e7d60 100644
>>>>> --- a/kernel/cgroup/cgroup.c
>>>>> +++ b/kernel/cgroup/cgroup.c
>>>>> @@ -2353,9 +2353,37 @@ static struct file_system_type cgroup2_fs_type = {
>>>>>    };
>>>>>
>>>>>    #ifdef CONFIG_CPUSETS_V1
>>>>> +enum cpuset_param {
>>>>> +     Opt_cpuset_v2_mode,
>>>>> +};
>>>>> +
>>>>> +const struct fs_parameter_spec cpuset_fs_parameters[] = {
>>>>> +     fsparam_flag  ("cpuset_v2_mode", Opt_cpuset_v2_mode),
>>>>> +     {}
>>>>> +};
>>>> A minor optimization you may want to convert the cpuset_fs_parameters into
>>>> a static const.
>>> Thanks, I copied from cgroup1_fs_parameters since that's where
>>> cpuset_v2_mode lives, which doesn't have the static currently
>>> (cgroup2_fs_parameters does). Let me update cpuset_fs_parameters in
>>> v3, and add a second patch for cgroup1_fs_parameters.
>> Besides not exposing the structure outside the current file or maybe a
>> tiny bit of linker speedup, is there other performance benefit by adding
>> "static"?
>>
>> Regards,
>> Longman
>>
> I thought it might decrease the text size a tiny bit, but it doesn't
> because the symbol isn't exported and I guess the compiler knows to
> just inline.
>
Since the structure already have a "const" modifier, I doubt there is 
any further optimization that the compiler can do whether the symbol is 
visible externally or not. Anyway, I am not objecting to v3 with static 
modifier added.

Cheers,
Longman


