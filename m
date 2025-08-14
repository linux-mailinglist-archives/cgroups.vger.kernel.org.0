Return-Path: <cgroups+bounces-9156-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2069CB259BB
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 05:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40C52A8308
	for <lists+cgroups@lfdr.de>; Thu, 14 Aug 2025 03:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E873925A2C4;
	Thu, 14 Aug 2025 03:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5+x+Udt"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E36239E92
	for <cgroups@vger.kernel.org>; Thu, 14 Aug 2025 03:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755141233; cv=none; b=SSqLpDc/Ucd+1ZBNkrhG6pRrqkuEdvy2LywRAQvIqwRyQQ26TZHJBnUeHJeklh8HEULDJ94PvD7RquNeWnJoIksx/0gC4FWaK7Q281cY+0QwhOi3nA3itdxmXr5BFCh/gXCXkdWdbM6OYn/sZ/NxinCbmL57dM/Zz0aBPLQ1WOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755141233; c=relaxed/simple;
	bh=iHqjsY4MfwDqWbGNqm5cbcklEGuylreMnuzVcA9KZnY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=p6/3lUx+dxhxgZ4HtvVMZuoETM8BwIPpYqHuVWOXuWkWd2623ZRUmxZ3rA+JRoxBQxou+o54/+qlzlsTNBvwedEPV5JkliGsmxdwOFulgOd7X0CFo7o59Zlo02DVJUL9e3049p7CBX/M478ELH0y8QEtFYBqaYeN4sn76vjUlBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5+x+Udt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755141230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tg3g0W3TnLPMEjK0YCe2ung/C6H2Ffd72IZHE9zkrW0=;
	b=b5+x+UdtBMepFI9/Nyid5BHvDe0aNVtCBRzPfsMg55nvDB7UuTtUfxV3fnATDFTyMniPKG
	/gMKMCJgu95vxABmKPfxsOqsH3KYP+ecHCUsEDTAre97RpGO2amBfdsC1ivDKYTZz+zY6o
	UZTViXY3YSi75gYUkO+Y28oEoyX/RzM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-rPAqXNTnOAe4k2AeQJhTCg-1; Wed, 13 Aug 2025 23:13:46 -0400
X-MC-Unique: rPAqXNTnOAe4k2AeQJhTCg-1
X-Mimecast-MFC-AGG-ID: rPAqXNTnOAe4k2AeQJhTCg_1755141226
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109be41a1so20391201cf.2
        for <cgroups@vger.kernel.org>; Wed, 13 Aug 2025 20:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755141226; x=1755746026;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tg3g0W3TnLPMEjK0YCe2ung/C6H2Ffd72IZHE9zkrW0=;
        b=e/0hdNvEv07a2k6HgJiwe0iltSARIJT4sreOb3WWATa7xv5qFtiEEkvy5Je8B4KlB/
         Iq3YiOdu66gGweUsKZy2OAlp183HDvOPyLxMn5NV2m3k34DKF1aBGgvfp1aIPwZV0hxE
         fMMt1k7qcwFf907cyDZMgCpLKcZrW7F958i3q99CO0dATTZ3JP4EISb1h5oOKuhNHKuu
         SHpCL/shyq8ShCM5ESXsZ3QQSmWtFLpg0JDMaRg7vxQQK8xMxvO1hQJMTsUPcamp0KRU
         PbXnM0t1uLFLOgG5ZyrK+byTGbE9EqhsCINjzylIhuPFg3foczuWvnrtpRt/NV6Zmbf+
         wjDQ==
X-Gm-Message-State: AOJu0YxHZ84fFHRbx2Vt0hzro3XJ7/+ARyqu0L8T4aPm4JXRmwtSk2OG
	kHwv5g9webEstmGXaHYv0KkCM7y6JdN7obuy2Aer5an6oEsm3VQRznebcycR/JRuXsHjcczQeoj
	ZpJg+1uUNXgJ3x5KcVo2KQlVktPJWkfanhpYDGefAm08wg3YnoR7du3TesRE=
X-Gm-Gg: ASbGncukt6YU98PcCCRUHyEqvM6LD8kS6JM8O22Ak3C5RQVKLwsXF4FHIFvw+35DOiB
	ti3O/hBeAugXkVq3UtZ7JK7j9OBUrbCJtw7/Nk+1Gjs8IxamEmml+XKejfA172VVzbO589sSMsW
	/23EwRpcMSO12ptVgYpgb6TAIM3h6uwZ5+a2yFQSznV2vDEemBgyh1rhyn8l57StkWSp5r/Lk37
	RomsGU2SVsh3WZhbV7LfQBYlDZsliqD+IsGdiHmpUh3YHq+4WbDuxOp2Ndc3lO/jWeSaWDrtes3
	njRauoCRKLYYWygKPPgPOmIJmIfYfFEsC5Ja6gWiXlrgZHWL1I5NqdhtP9KjdBctFjEdH6BWXOQ
	uhmJXwAI+pA==
X-Received: by 2002:a05:622a:180e:b0:4b0:a07f:c1d0 with SMTP id d75a77b69052e-4b10a9df06fmr20521191cf.5.1755141226261;
        Wed, 13 Aug 2025 20:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlPMhkNapB6PW9gJ4xsfcttM+z5+l4+YuV0ppOAeh+8NYEEGvbvW3eRbtqNMeL16JO0FbMvA==
X-Received: by 2002:a05:622a:180e:b0:4b0:a07f:c1d0 with SMTP id d75a77b69052e-4b10a9df06fmr20521041cf.5.1755141225950;
        Wed, 13 Aug 2025 20:13:45 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b093596ff5sm115726061cf.30.2025.08.13.20.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 20:13:45 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <93e37ccf-8ac8-40f5-840f-2f221f58131e@redhat.com>
Date: Wed, 13 Aug 2025 23:13:44 -0400
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
Content-Language: en-US
In-Reply-To: <750ac0bd-42f9-47fa-8274-0ff4e4a7fa3d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/25 8:44 PM, Chen Ridong wrote:
>
> On 2025/8/14 4:09, Waiman Long wrote:
>> On 8/13/25 4:29 AM, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> cpuset: add helpers for cpus_read_lock and cpuset_mutex
>>>
>>> Replace repetitive locking patterns with new helpers:
>>> - cpus_read_cpuset_lock()
>>> - cpus_read_cpuset_unlock()
>>>
>>> This makes the code cleaner and ensures consistent lock ordering.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>    kernel/cgroup/cpuset-internal.h |  2 ++
>>>    kernel/cgroup/cpuset-v1.c       | 12 +++------
>>>    kernel/cgroup/cpuset.c          | 48 +++++++++++++++------------------
>>>    3 files changed, 28 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>>> index 75b3aef39231..6fb00c96044d 100644
>>> --- a/kernel/cgroup/cpuset-internal.h
>>> +++ b/kernel/cgroup/cpuset-internal.h
>>> @@ -276,6 +276,8 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int turning_on)
>>>    ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>>                        char *buf, size_t nbytes, loff_t off);
>>>    int cpuset_common_seq_show(struct seq_file *sf, void *v);
>>> +void cpus_read_cpuset_lock(void);
>>> +void cpus_read_cpuset_unlock(void);
>> The names are not intuitive. I would prefer just extend the cpuset_lock/unlock to include
>> cpus_read_lock/unlock and we use cpuset_lock/unlock consistently in the cpuset code. Also, there is
>> now no external user of cpuset_lock/unlock, we may as well remove them from include/linux/cpuset.h.
>>
>> Cheers,
>> Longman
> I like the idea and have considered it.
> However, I noticed that cpuset_locked is being used in __sched_setscheduler.

Right, I overloooked the cpuset_lock() call in kernel/sched/syscall.c. 
So we can't remove it from include/linux/cpuset.h.

This call is invoked to ensure cpusets information is stable. However, 
it doesn't hurt if the cpus_read_lock() is also acquired as a result. 
Alternatively, we can use a name like cpuset_full_lock() to include 
cpus_read_lock().

Cheers,
Longman


