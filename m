Return-Path: <cgroups+bounces-5975-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27BA9F8B0B
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2024 05:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430B3160CC2
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2024 04:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3DD4CB5B;
	Fri, 20 Dec 2024 04:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJWiHwZz"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF89259489
	for <cgroups@vger.kernel.org>; Fri, 20 Dec 2024 04:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734668180; cv=none; b=UrmrR1bICX+VBMdmWRBKt4DIvEQ9Ip/5YcnnEFaWIMG7HaEtTlAJiRo1WimUDx4zzI+NgDBNdQlc9nHMV+qwUkCW6umlFq03/wkXVceeq9alvUqT+fak+OGAh0NEo2xYww3asWJyclLdNRGwBql0DXJrp7xlSXoFDQBvGt7EibE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734668180; c=relaxed/simple;
	bh=1TPR6+5eD6Y4D1v5KqgdUN1ulxbSv9xPLDY4nlfaMCU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oS9UdHDHq2BXq3x4u/I0GadyDg4q19CxdtaknuLUku/6E96AuW0/CeqK4902nLym8GtyT2DOyy/INrM947y5eRVNOaAjn6Y0zebxCkuepN7jdPcyM82iGockfaN3mwHi2QNVf6txVw47cG3i5XWj8UWfnKOetJn+dErBDuVKA/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJWiHwZz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734668177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=th0AmO08xmb+ulOWTIR6fSr7CH9etJ3gbJc/CigSXgk=;
	b=GJWiHwZzIxV2QkS32Im6Nhe6pRUKPtJZIFsFBnNyIotY2DM5F8scgcIKLutAtjAIPU6lSP
	X4nKAQstxSLGuDcDh0Mq5/nv6ctT5t/WUgHkcBFQsg64IZq7qLqY+IEhhEgDQGEqu9uoz4
	r65QrcGo8AtWo7xMkjbSpsx3m10Eh5A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-fMLqAABINe6XOy3JAYsotw-1; Thu, 19 Dec 2024 23:16:16 -0500
X-MC-Unique: fMLqAABINe6XOy3JAYsotw-1
X-Mimecast-MFC-AGG-ID: fMLqAABINe6XOy3JAYsotw
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d92f0737beso22388766d6.1
        for <cgroups@vger.kernel.org>; Thu, 19 Dec 2024 20:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734668175; x=1735272975;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=th0AmO08xmb+ulOWTIR6fSr7CH9etJ3gbJc/CigSXgk=;
        b=PGKm8kKtCGQSKHnvjRBjHR5mbKOR1+1Qb6cXLqxKEegiv7PNfbfTT2WIKkte1NPFGu
         oLBfQn9SML40HSsopzaOYtbkC8jNV4hnx0ZEsYAwWURr7UgsF5TLF3WiUIjQze1ZCNt+
         t7eLR7i7wgv5TEz4tiikE01BQMzpYX8WrCBQ40y2FvzxLcpm7bmP2amRZb5eF1pMeeF4
         FjZtk/PKW0ovViTnIiqgSkiDHC5JU4HihzAZeIo8LWX8wpYpw1ZZfwDq9X2x4Pr+uNHT
         nT4Yvcu8cL89kZExJhJgesCX90B1XWWn/N64lPzkoTv/IAMKJvq0qphbLmjZjxPycveo
         o/kw==
X-Gm-Message-State: AOJu0Ywezh8Eqe1fRARZzYosQOyk+zhm3zQeotlcXbWE8vs36whtrgSq
	79qiNRBGPJkUpkIaXmE+0ZxuoqaNwcro75XKdLa/4IShGDOw1oA5QB5VdeyZXrYHkVU3tmOFqEq
	5SH0P3vcVKlMpVLe58aLKZmjl1sa6KQbVPkWOGvR1rLJbJxARinPPt+0=
X-Gm-Gg: ASbGncsktl67glDlwHJIvE9APXlwAD8pczW1jDBomREZDocrW/7xrNyfiRnEeUIF+7j
	BxzzEfNRRQ55fJszohti6ca9xtbDjpGPBDaw0gqrPiYizH3rjvTThOv2mw1BjRsyJYJN0zfBhg9
	erzHiTj/3d1lPoDo8AtErvoSa7TUxqqpbJeEtR5/oG7dBrsKJtZL1ir0/2KcvnuxpfoXg8+TpSU
	NYg9Y2aq9cRDrpDwlFwgQ9qJNJjXkdWpnTvdlInFUifogfMd0mUuzSMWfPIQEbWMQYHZnB04kEl
	kULje4lOzKNtU/FQ+csMswqs
X-Received: by 2002:a05:6214:4006:b0:6d1:9f29:2e3b with SMTP id 6a1803df08f44-6dd2334555cmr28413996d6.13.1734668175478;
        Thu, 19 Dec 2024 20:16:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXU2VIrKYgUj//eDJDZtqhSIIjWwSEQOgLnWK0NsJ+VllcdxjtXRMoKCfFlYWBFyTg9pxmhQ==
X-Received: by 2002:a05:6214:4006:b0:6d1:9f29:2e3b with SMTP id 6a1803df08f44-6dd2334555cmr28413796d6.13.1734668175148;
        Thu, 19 Dec 2024 20:16:15 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd18208364sm12938396d6.126.2024.12.19.20.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 20:16:14 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <61b5749b-3e75-4cf6-9acb-23b63f78d859@redhat.com>
Date: Thu, 19 Dec 2024 23:16:13 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/cpuset: remove kernfs active break
To: chenridong <chenridong@huawei.com>, Waiman Long <llong@redhat.com>,
 Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, roman.gushchin@linux.dev
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, wangweiyang2@huawei.com
References: <20241220013106.3603227-1-chenridong@huaweicloud.com>
 <5c48f188-0059-46a2-9ccd-aad6721d96bb@redhat.com>
 <cafb38a5-0832-4af4-a3b2-cca32ce63d10@huawei.com>
Content-Language: en-US
In-Reply-To: <cafb38a5-0832-4af4-a3b2-cca32ce63d10@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/19/24 11:07 PM, chenridong wrote:
>
> On 2024/12/20 10:55, Waiman Long wrote:
>> On 12/19/24 8:31 PM, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> A warning was found:
>>>
>>> WARNING: CPU: 10 PID: 3486953 at fs/kernfs/file.c:828
>>> CPU: 10 PID: 3486953 Comm: rmdir Kdump: loaded Tainted: G
>>> RIP: 0010:kernfs_should_drain_open_files+0x1a1/0x1b0
>>> RSP: 0018:ffff8881107ef9e0 EFLAGS: 00010202
>>> RAX: 0000000080000002 RBX: ffff888154738c00 RCX: dffffc0000000000
>>> RDX: 0000000000000007 RSI: 0000000000000004 RDI: ffff888154738c04
>>> RBP: ffff888154738c04 R08: ffffffffaf27fa15 R09: ffffed102a8e7180
>>> R10: ffff888154738c07 R11: 0000000000000000 R12: ffff888154738c08
>>> R13: ffff888750f8c000 R14: ffff888750f8c0e8 R15: ffff888154738ca0
>>> FS:  00007f84cd0be740(0000) GS:ffff8887ddc00000(0000)
>>> knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 0000555f9fbe00c8 CR3: 0000000153eec001 CR4: 0000000000370ee0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> Call Trace:
>>>    kernfs_drain+0x15e/0x2f0
>>>    __kernfs_remove+0x165/0x300
>>>    kernfs_remove_by_name_ns+0x7b/0xc0
>>>    cgroup_rm_file+0x154/0x1c0
>>>    cgroup_addrm_files+0x1c2/0x1f0
>>>    css_clear_dir+0x77/0x110
>>>    kill_css+0x4c/0x1b0
>>>    cgroup_destroy_locked+0x194/0x380
>>>    cgroup_rmdir+0x2a/0x140
>> Were you using cgroup v1 or v2 when this warning happened?
> I was using cgroup v1.
Thanks for the confirmation.
>
>>> It can be explained by:
>>> rmdir                 echo 1 > cpuset.cpus
>>>                  kernfs_fop_write_iter // active=0
>>> cgroup_rm_file
>>> kernfs_remove_by_name_ns    kernfs_get_active // active=1
>>> __kernfs_remove                      // active=0x80000002
>>> kernfs_drain            cpuset_write_resmask
>>> wait_event
>>> //waiting (active == 0x80000001)
>>>                  kernfs_break_active_protection
>>>                  // active = 0x80000001
>>> // continue
>>>                  kernfs_unbreak_active_protection
>>>                  // active = 0x80000002
>>> ...
>>> kernfs_should_drain_open_files
>>> // warning occurs
>>>                  kernfs_put_active
>>>
>>> This warning is caused by 'kernfs_break_active_protection' when it is
>>> writing to cpuset.cpus, and the cgroup is removed concurrently.
>>>
>>> The commit 3a5a6d0c2b03 ("cpuset: don't nest cgroup_mutex inside
>>> get_online_cpus()") made cpuset_hotplug_workfn asynchronous, which grabs
>>> the cgroup_mutex. To avoid deadlock. the commit 76bb5ab8f6e3 ("cpuset:
>>> break kernfs active protection in cpuset_write_resmask()") added
>>> 'kernfs_break_active_protection' in the cpuset_write_resmask. This could
>>> lead to this warning.
>>>
>>> After the commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
>>> processing synchronous"), the cpuset_write_resmask no longer needs to
>>> wait the hotplug to finish, which means that cpuset_write_resmask won't
>>> grab the cgroup_mutex. So the deadlock doesn't exist anymore. Therefore,
>>> remove kernfs_break_active_protection operation in the
>>> 'cpuset_write_resmask'
>> The hotplug operation itself is now being done synchronously, but task
>> transfer (cgroup_transfer_tasks()) because of lacking online CPUs is
>> still being done asynchronously. So kernfs_break_active_protection()
>> will still be needed for cgroup v1.
>>
>> Cheers,
>> Longman
>>
>>
> Thank you, Longman.
> IIUC, The commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
> processing synchronous") deleted the 'flush_work(&cpuset_hotplug_work)'
> in the cpuset_write_resmask. And I do not see any process within the
> cpuset_write_resmask that will grab cgroup_mutex, except for
> 'flush_work(&cpuset_hotplug_work)'.
>
> Although cgroup_transfer_tasks() is asynchronous, the
> cpuset_write_resmask will not wait any work that will grab cgroup_mutex.
> Consequently, the deadlock does not exist anymore.
>
> Did I miss something?

Right. The flush_work() call is still needed for a different work 
function. cpuset_write_resmask() will not need to grab cgroup_mutex, but 
the asynchronously executed cgroup_transfer_tasks() will. I will work on 
a patch to fix that issue.

Cheers,
Longman


