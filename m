Return-Path: <cgroups+bounces-5981-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978519F951D
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2024 16:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9D8165D3F
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2024 15:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A544218AC7;
	Fri, 20 Dec 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMYlJJwX"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A19A21883F
	for <cgroups@vger.kernel.org>; Fri, 20 Dec 2024 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707640; cv=none; b=nVUK6yZOfyf1EAID6Fm9PjAJ5EOGTp6qeGQxMROVXEAPfb+pU1c52jF8M78n06VFKWDHR9mXB+tgF5sycfN4FgCd+iEfTg9npU/QREmY9r2kIpGbtvdVaax7tIGWhxKqoVEU2Ug7VvpiBStrG2KIEWaUGRgJ0ndHMSRlSysEcNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707640; c=relaxed/simple;
	bh=VFEZyMOjdpDM1V+/RTFHx2bxnVXYZIlNyKKBmQrw8Wo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YLPdcteJSb700PTEAJLDhWMe6nPf8B4ka7V9JJWGwD1NBYDxo7yJhg2jEjBBENRXa2toKJoN674XFups3OHfpSW5DsqbXJgInfce0Tqlj3xiL5ynLC619Wyy2suruu3sUPkV3xfckkovtJEyHysB3ennzHLtctt3xMx/TUaoY8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CMYlJJwX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734707638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJuuSUC6jezmGOkZ1u2qYgr2h4szp0A5vDHb5jcrn8w=;
	b=CMYlJJwXiQbErMdA8n8/LfsdJ2NSWEBRBiL+oviNqtdBTcHg4aCuqIz8N3X5ns06cBOVC0
	bZKo2KmhzPEHjKPV95xtYL8Aje4k0SPnwQe9Uk6c8K5q51PUr2bwjgG62zAT3bs282OUYS
	Amw6aApgjQT8bfkDJ2+wo4s7Llibb7Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-zu27UYEVMzue3U4Rfc-SyA-1; Fri, 20 Dec 2024 10:13:56 -0500
X-MC-Unique: zu27UYEVMzue3U4Rfc-SyA-1
X-Mimecast-MFC-AGG-ID: zu27UYEVMzue3U4Rfc-SyA
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8f51b49e5so39147596d6.1
        for <cgroups@vger.kernel.org>; Fri, 20 Dec 2024 07:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707636; x=1735312436;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJuuSUC6jezmGOkZ1u2qYgr2h4szp0A5vDHb5jcrn8w=;
        b=SsNOn/2eWHDyrnZQiwwoKuKgqnrkxDfrHBjVSQMNRtxQt7PhymbwibT8a2aU0su2tE
         FjdW0AEmfAjJHxsaIufrcMGDIVIc7aIFx8mcHwHgSyVb1mA31bjk8qgEBAtbw8IQvI4i
         H2e54rlI57g1v7VDUiDEVRwehDm8yiE01RF8Sm7rmxmKeE4dIXLz9VMtLT15fAtfTUTh
         Shg4vP7tUxVJThf9KvbvoUfessZNI/O+vsn6gvtUp6lfoxWL2XUxDtCXD7MlQB3HvM1t
         /GHOhpMRW7zU1RGOdT9rgzLhpWs8uED3CQPoCUwLWBGnxl4nXQ9M7dI8JitQHtGKZzYx
         cqXQ==
X-Gm-Message-State: AOJu0YyD/yVJl5X/jp8R2jzbmlwFTp6ovae3zPbh3qH1xZV3FDdycxk/
	Dph0if+xmOZdA2vgUiSjHC7cjR3nPy1eUQhs6t/vTJObJ8sj6WerxrOK+MMOyJZk8u9DXKg5x7F
	p4Gk5AqhzU1W5AwdHQHhy2Hmfjmv2bUncBFCKry7HmAxsQQGD0vgRV90=
X-Gm-Gg: ASbGncuEyjBfcmUxLeyKSgRCrYeYcv8MWan95aAvlzmI7BonXRMGVW6CsoS+UEh2p31
	T8XAHaXCqhPYm+zloGhbqKTQNhV/O24W2Urt6nSltQJg3fpBd/dW2H5kxj0vPdWVgn/7UsFqV7u
	2xP0QV8OXEoMHKl3bkfBKV6XQkwnZWOAONrUp1vp3SQJERzKfvj4izuDQUUJmLbrusyWSUgY8gI
	Ug0b1Pn2SQewHeD4UeYK7U5M5K1mTlQ5gY5gkupbcHPRg+zT4LwqB7PH4qQi/6RLr3eH9JikITY
	HSppTV8/CjOeUThaQdbsFm4V
X-Received: by 2002:a05:6214:240d:b0:6d8:e5f4:b977 with SMTP id 6a1803df08f44-6dd23308369mr57106766d6.5.1734707635999;
        Fri, 20 Dec 2024 07:13:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGeE3+QWYmL4dvrThhExmFw6vdzbUiltIjz5iaNeHVVquZflUJZ1wL+CPXVXgMuJIurz6pVsg==
X-Received: by 2002:a05:6214:240d:b0:6d8:e5f4:b977 with SMTP id 6a1803df08f44-6dd23308369mr57106366d6.5.1734707635611;
        Fri, 20 Dec 2024 07:13:55 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1810ced1sm17743546d6.37.2024.12.20.07.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 07:13:55 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5cb32477-7346-4417-a49e-de2b7dda7401@redhat.com>
Date: Fri, 20 Dec 2024 10:13:53 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/cpuset: remove kernfs active break
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 chenridong <chenridong@huawei.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, roman.gushchin@linux.dev
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, wangweiyang2@huawei.com
References: <20241220013106.3603227-1-chenridong@huaweicloud.com>
 <5c48f188-0059-46a2-9ccd-aad6721d96bb@redhat.com>
 <cafb38a5-0832-4af4-a3b2-cca32ce63d10@huawei.com>
 <61b5749b-3e75-4cf6-9acb-23b63f78d859@redhat.com>
 <d3ebff6a-9866-40e2-a1ff-07bd77d20187@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <d3ebff6a-9866-40e2-a1ff-07bd77d20187@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/20/24 1:11 AM, Chen Ridong wrote:
>
> On 2024/12/20 12:16, Waiman Long wrote:
>> On 12/19/24 11:07 PM, chenridong wrote:
>>> On 2024/12/20 10:55, Waiman Long wrote:
>>>> On 12/19/24 8:31 PM, Chen Ridong wrote:
>>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>>
>>>>> A warning was found:
>>>>>
>>>>> WARNING: CPU: 10 PID: 3486953 at fs/kernfs/file.c:828
>>>>> CPU: 10 PID: 3486953 Comm: rmdir Kdump: loaded Tainted: G
>>>>> RIP: 0010:kernfs_should_drain_open_files+0x1a1/0x1b0
>>>>> RSP: 0018:ffff8881107ef9e0 EFLAGS: 00010202
>>>>> RAX: 0000000080000002 RBX: ffff888154738c00 RCX: dffffc0000000000
>>>>> RDX: 0000000000000007 RSI: 0000000000000004 RDI: ffff888154738c04
>>>>> RBP: ffff888154738c04 R08: ffffffffaf27fa15 R09: ffffed102a8e7180
>>>>> R10: ffff888154738c07 R11: 0000000000000000 R12: ffff888154738c08
>>>>> R13: ffff888750f8c000 R14: ffff888750f8c0e8 R15: ffff888154738ca0
>>>>> FS:  00007f84cd0be740(0000) GS:ffff8887ddc00000(0000)
>>>>> knlGS:0000000000000000
>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> CR2: 0000555f9fbe00c8 CR3: 0000000153eec001 CR4: 0000000000370ee0
>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>> Call Trace:
>>>>>     kernfs_drain+0x15e/0x2f0
>>>>>     __kernfs_remove+0x165/0x300
>>>>>     kernfs_remove_by_name_ns+0x7b/0xc0
>>>>>     cgroup_rm_file+0x154/0x1c0
>>>>>     cgroup_addrm_files+0x1c2/0x1f0
>>>>>     css_clear_dir+0x77/0x110
>>>>>     kill_css+0x4c/0x1b0
>>>>>     cgroup_destroy_locked+0x194/0x380
>>>>>     cgroup_rmdir+0x2a/0x140
>>>> Were you using cgroup v1 or v2 when this warning happened?
>>> I was using cgroup v1.
>> Thanks for the confirmation.
>>>>> It can be explained by:
>>>>> rmdir                 echo 1 > cpuset.cpus
>>>>>                   kernfs_fop_write_iter // active=0
>>>>> cgroup_rm_file
>>>>> kernfs_remove_by_name_ns    kernfs_get_active // active=1
>>>>> __kernfs_remove                      // active=0x80000002
>>>>> kernfs_drain            cpuset_write_resmask
>>>>> wait_event
>>>>> //waiting (active == 0x80000001)
>>>>>                   kernfs_break_active_protection
>>>>>                   // active = 0x80000001
>>>>> // continue
>>>>>                   kernfs_unbreak_active_protection
>>>>>                   // active = 0x80000002
>>>>> ...
>>>>> kernfs_should_drain_open_files
>>>>> // warning occurs
>>>>>                   kernfs_put_active
>>>>>
>>>>> This warning is caused by 'kernfs_break_active_protection' when it is
>>>>> writing to cpuset.cpus, and the cgroup is removed concurrently.
>>>>>
>>>>> The commit 3a5a6d0c2b03 ("cpuset: don't nest cgroup_mutex inside
>>>>> get_online_cpus()") made cpuset_hotplug_workfn asynchronous, which
>>>>> grabs
>>>>> the cgroup_mutex. To avoid deadlock. the commit 76bb5ab8f6e3 ("cpuset:
>>>>> break kernfs active protection in cpuset_write_resmask()") added
>>>>> 'kernfs_break_active_protection' in the cpuset_write_resmask. This
>>>>> could
>>>>> lead to this warning.
>>>>>
>>>>> After the commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
>>>>> processing synchronous"), the cpuset_write_resmask no longer needs to
>>>>> wait the hotplug to finish, which means that cpuset_write_resmask won't
>>>>> grab the cgroup_mutex. So the deadlock doesn't exist anymore.
>>>>> Therefore,
>>>>> remove kernfs_break_active_protection operation in the
>>>>> 'cpuset_write_resmask'
>>>> The hotplug operation itself is now being done synchronously, but task
>>>> transfer (cgroup_transfer_tasks()) because of lacking online CPUs is
>>>> still being done asynchronously. So kernfs_break_active_protection()
>>>> will still be needed for cgroup v1.
>>>>
>>>> Cheers,
>>>> Longman
>>>>
>>>>
>>> Thank you, Longman.
>>> IIUC, The commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
>>> processing synchronous") deleted the 'flush_work(&cpuset_hotplug_work)'
>>> in the cpuset_write_resmask. And I do not see any process within the
>>> cpuset_write_resmask that will grab cgroup_mutex, except for
>>> 'flush_work(&cpuset_hotplug_work)'.
>>>
>>> Although cgroup_transfer_tasks() is asynchronous, the
>>> cpuset_write_resmask will not wait any work that will grab cgroup_mutex.
>>> Consequently, the deadlock does not exist anymore.
>>>
>>> Did I miss something?
>> Right. The flush_work() call is still needed for a different work
>> function. cpuset_write_resmask() will not need to grab cgroup_mutex, but
>> the asynchronously executed cgroup_transfer_tasks() will. I will work on
>> a patch to fix that issue.
>>
>> Cheers,
>> Longman
> If flush_work() is added back, this warning still exists. Do you have a
> idea to fix this warning?

I was wrong. The flush_work() call isn't needed in this case and we 
shouldn't need to break kernfs protection. However, your patch 
description isn't quite right.

> After the commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
> processing synchronous"), the cpuset_write_resmask no longer needs to
> wait the hotplug to finish, which means that cpuset_write_resmask won't
> grab the cgroup_mutex. So the deadlock doesn't exist anymore.

cpuset_write_resmask() never needs to grab the cgroup_mutex. The act of calling flush_work() can create a multiple processes circular locking dependency that involve cgroup_mutex which can cause a deadlock. After making cpuset hotplug synchronous, concurrent hotplug and cpuset operations are no longer possible. However, concurrent task transfer out of a previously empty CPU cpuset and adding CPU back to that cpuset is possible. This will result in what the comment said "keep removing tasks added
after execution capability is restored". That should be rare though and we should probably add a check in cgroup_transfer_tasks() to detect such a case and break out of it.

Cheers,
Longman


