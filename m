Return-Path: <cgroups+bounces-5973-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E179F8A53
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2024 03:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A29188E947
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2024 02:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CC4249EB;
	Fri, 20 Dec 2024 02:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuehYqVZ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E5482CD
	for <cgroups@vger.kernel.org>; Fri, 20 Dec 2024 02:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734663354; cv=none; b=IaAP7RxmFY2UNEXIby3xtErsbHJI6HatRgBh6N/ipmiAMmshIp0WJ1hSD4ZawherWr1Yml6yoM4XvKvLmbwh1fEfiCG3b8NrFrg31sVSggNpb3ecx+MopQmOfKeyPzCaRgQ34INBxRXwYFJYMv9CarpQrdFUsBAxSuFVLvfyPxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734663354; c=relaxed/simple;
	bh=ieMhFpf9C4ejCIoW8+5td2IpDbzbB0oOSssg6HTwgsE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qEBkTHrI9LJUM6hxi+IMNNQ7XMwKK3eygjkSDkg4kY+Vu4b5CsJgPU05dIBPAGUpoPYAs0cKhUGU0gSfUBFC40itFMeAMRzHLmKoAgGWP4CQL8+XqDLSzTiu8liZ5VgN9t2sw8kdq9hlnv1ragUXDtVHWJbGNBJ0kfE9NcvTl7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KuehYqVZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734663351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BzTObnhz0wg4RANutOTurV3ncdKw7hvlDkR37Aaxlxo=;
	b=KuehYqVZTDexCfu6j2zVYxofMPx3UT75hdJ+idhkH9iVke0cCRb+A8HghRNl/1XSU+9c/3
	dIP8gge/sW2Gt2IDopKDRtveevKG65FKGpDGihOs8D/a9tekTXdl1Qsqwsr75cYueOOrnU
	BMxc9iWEser+MI4Y0Xu6A5bzgB7QKlY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-exJPLVw4OHWLqEGXgWDiYQ-1; Thu, 19 Dec 2024 21:55:50 -0500
X-MC-Unique: exJPLVw4OHWLqEGXgWDiYQ-1
X-Mimecast-MFC-AGG-ID: exJPLVw4OHWLqEGXgWDiYQ
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-46799aa9755so38349561cf.0
        for <cgroups@vger.kernel.org>; Thu, 19 Dec 2024 18:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734663349; x=1735268149;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BzTObnhz0wg4RANutOTurV3ncdKw7hvlDkR37Aaxlxo=;
        b=Wed3XhM0nXnwb3UQaS8za3KMYIIuy4xgqlSwSLrWvvexJLzIDfNypSwRZYVFl0u6f8
         Xcg4rWbaFYAvWR+2kgIjfKuXxmMMmVrAC5CG7lZ1iyaT+3dDUYuxL4/rKPxCL0jC1Sbo
         kLFdnKqe7VX0vIpEQE0vqxFZkWZ0QrinqJdvmKYiF2rueufeWzX7gnu9xKenY8+ALrSj
         cqv9KFIXkEt9W9rqX265kEU1RGvR5u3hnmXEC6ZMTzIDlSevsRK78pZ198i66FWhx/IF
         sMpSlEi0egSPVvl57x2iZ/pKNbtaUQEN8qxdxkg1TuwcsgxJCRP2HvWNMfSvI6qXHkcq
         wIaQ==
X-Gm-Message-State: AOJu0Yyr1g1KFgbk/SOSPFWRc4Dh8wvAaq7zhCwGPz9Z+mC+iw8VM4wv
	q2+OB0i1KqO7CPerS31hxTQkuO7DB/iqyIWPVtEU19vXlLnTN2fJ3mMchOaCN4FT91RKz6V1vRx
	Bf4AGsvMw+R5zH2uBfnBOYqenCCnCzweXoUXfpfnEVlwxh0rNUb2o9p4=
X-Gm-Gg: ASbGncsjssXzdI0flye8I+d4rqmsmUoowMlAfPqItZKQM5y5rjzE2AhM2WlgR166cZa
	oWTiq0ZCJyDntbtPoiqNVImxZRaFRpWXFIIhF3hnfCSrBzNKK3D5IknbhG6wT2rE2iUsxk/KLIp
	sS1H1BVQymwm5oTMnNHOb7I8BMH7l/X1PYal+hbPcxizNuwch5T2bUDhvuPTdSbe48X/dVzeo0h
	JKTPD+YykR0spmtu1nmdhot6kVXBeU2zAueMCpmlPh2q1DWaA36Wh3vwbkZCX7WkdIbN1HlZAgr
	sG9G72xgwuqeHXbvRgaP2imF
X-Received: by 2002:a05:622a:1a17:b0:467:48f3:3452 with SMTP id d75a77b69052e-46a4a9bf50emr28065651cf.56.1734663349566;
        Thu, 19 Dec 2024 18:55:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFW5BqhgJP+GV5BqmALj048AUeUhe26cTgktJuOWdQcFA9OFPsoSJCdX9GZOAMjhSEHRnS8Q==
X-Received: by 2002:a05:622a:1a17:b0:467:48f3:3452 with SMTP id d75a77b69052e-46a4a9bf50emr28065461cf.56.1734663349250;
        Thu, 19 Dec 2024 18:55:49 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb16ca0sm12081751cf.65.2024.12.19.18.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 18:55:48 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5c48f188-0059-46a2-9ccd-aad6721d96bb@redhat.com>
Date: Thu, 19 Dec 2024 21:55:47 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cgroup/cpuset: remove kernfs active break
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, roman.gushchin@linux.dev
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241220013106.3603227-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20241220013106.3603227-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/24 8:31 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> A warning was found:
>
> WARNING: CPU: 10 PID: 3486953 at fs/kernfs/file.c:828
> CPU: 10 PID: 3486953 Comm: rmdir Kdump: loaded Tainted: G
> RIP: 0010:kernfs_should_drain_open_files+0x1a1/0x1b0
> RSP: 0018:ffff8881107ef9e0 EFLAGS: 00010202
> RAX: 0000000080000002 RBX: ffff888154738c00 RCX: dffffc0000000000
> RDX: 0000000000000007 RSI: 0000000000000004 RDI: ffff888154738c04
> RBP: ffff888154738c04 R08: ffffffffaf27fa15 R09: ffffed102a8e7180
> R10: ffff888154738c07 R11: 0000000000000000 R12: ffff888154738c08
> R13: ffff888750f8c000 R14: ffff888750f8c0e8 R15: ffff888154738ca0
> FS:  00007f84cd0be740(0000) GS:ffff8887ddc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555f9fbe00c8 CR3: 0000000153eec001 CR4: 0000000000370ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   kernfs_drain+0x15e/0x2f0
>   __kernfs_remove+0x165/0x300
>   kernfs_remove_by_name_ns+0x7b/0xc0
>   cgroup_rm_file+0x154/0x1c0
>   cgroup_addrm_files+0x1c2/0x1f0
>   css_clear_dir+0x77/0x110
>   kill_css+0x4c/0x1b0
>   cgroup_destroy_locked+0x194/0x380
>   cgroup_rmdir+0x2a/0x140
Were you using cgroup v1 or v2 when this warning happened?
>
> It can be explained by:
> rmdir 				echo 1 > cpuset.cpus
> 				kernfs_fop_write_iter // active=0
> cgroup_rm_file
> kernfs_remove_by_name_ns	kernfs_get_active // active=1
> __kernfs_remove					  // active=0x80000002
> kernfs_drain			cpuset_write_resmask
> wait_event
> //waiting (active == 0x80000001)
> 				kernfs_break_active_protection
> 				// active = 0x80000001
> // continue
> 				kernfs_unbreak_active_protection
> 				// active = 0x80000002
> ...
> kernfs_should_drain_open_files
> // warning occurs
> 				kernfs_put_active
>
> This warning is caused by 'kernfs_break_active_protection' when it is
> writing to cpuset.cpus, and the cgroup is removed concurrently.
>
> The commit 3a5a6d0c2b03 ("cpuset: don't nest cgroup_mutex inside
> get_online_cpus()") made cpuset_hotplug_workfn asynchronous, which grabs
> the cgroup_mutex. To avoid deadlock. the commit 76bb5ab8f6e3 ("cpuset:
> break kernfs active protection in cpuset_write_resmask()") added
> 'kernfs_break_active_protection' in the cpuset_write_resmask. This could
> lead to this warning.
>
> After the commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
> processing synchronous"), the cpuset_write_resmask no longer needs to
> wait the hotplug to finish, which means that cpuset_write_resmask won't
> grab the cgroup_mutex. So the deadlock doesn't exist anymore. Therefore,
> remove kernfs_break_active_protection operation in the
> 'cpuset_write_resmask'

The hotplug operation itself is now being done synchronously, but task 
transfer (cgroup_transfer_tasks()) because of lacking online CPUs is 
still being done asynchronously. So kernfs_break_active_protection() 
will still be needed for cgroup v1.

Cheers,
Longman


