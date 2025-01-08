Return-Path: <cgroups+bounces-6069-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14625A06541
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 20:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45398168338
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2025 19:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263E5200BAA;
	Wed,  8 Jan 2025 19:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwv41VmQ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC0B19ABB6
	for <cgroups@vger.kernel.org>; Wed,  8 Jan 2025 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364057; cv=none; b=U/688Z6nQendjeYA/5cfc15+gCbCGmK4qNlQf5KacQZAlDjSi6Go0KgTbqKv3DoJwenHtgAp8y8Eg9LH4UAjKUhDgU5ig7SQtUjlRZKWyuOmkR6RcN+Sv/522dfao16p/Ioxf/HWtx/5FAuiqXmyyafbHJf7KYJk+MFhk3eBOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364057; c=relaxed/simple;
	bh=sZ8az9IQwguHdQauK3WQTyuVjxzPox/hCCDHYk8z6t4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=d9LqtUAfXCLg4dL53cmOyQbr3t5u3XoKT8A+S0ieCsfb4cBWgsHO8p6UaokpV9CctoXCQnSPnTm3ADHRnb7daOvamkZ2oGenlCuUkkbLxH7iD5u+9p4Hs/Clh+wbIh5nqBrUR+/jKLbO9MUmIa6cjKK7linaxpjI2lFVtNuXik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwv41VmQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736364054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2V4JI4zf/82nTWca/oANVymewXdEU3ef8uHnnduuvQ=;
	b=hwv41VmQimFkGBEJJneWhnDhHlIeY4N3gaZ8/1vjFQbzoriuqib0ZOhe3v0aSBEA8Ty/8V
	kiGXgXap0lEu/2k5BtLVsL1MTJH8Fzs4l5dxVSyHPmbhuDV3N3BtFA6w9Tan7K/ygbypqG
	yEnR4lttJ4HGJgHxVQK9tWHPAcKKXio=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-0Th0MXYvMsmIm9rZiDk4_Q-1; Wed, 08 Jan 2025 14:20:53 -0500
X-MC-Unique: 0Th0MXYvMsmIm9rZiDk4_Q-1
X-Mimecast-MFC-AGG-ID: 0Th0MXYvMsmIm9rZiDk4_Q
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6c6429421so23580985a.0
        for <cgroups@vger.kernel.org>; Wed, 08 Jan 2025 11:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736364053; x=1736968853;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C2V4JI4zf/82nTWca/oANVymewXdEU3ef8uHnnduuvQ=;
        b=NjykZ/Kpgn4Ecmqx6IgphtSf7vNy85KN5+nv6nHfza33PbAKVBkm9YYVAW4gSAMrug
         mFcfrya8BdcpLD8B2sLEb0gXXtTYcetRcjqbkV80N2lrAwQiUiRfgBa/U4cy9GwdePri
         ze0GgA8JFO0jtifNm8vLSuYlKR2789Z1bzARq8HEDKfAUJhOIpqh2wPEgrHHN/0qWitm
         y/it6uOh00S1jHELsy98ndguiLYDVnm8FkciEgjx4Jz5FFzIKl4H/Yd71e+XUGXEm663
         yd3mjNpbRcfqVAtrA5X/n77PgOWELf3Y05pAgxCMbolJRO0u6hTk7G/64wdR5dUdXX0C
         yocQ==
X-Gm-Message-State: AOJu0Yw1eB3I/gpmRbvv1xZgbUNU+974ALh6MROIeeiudC/c2N6TnRwP
	KTr2LaDFs+v4tZ8ALWgNky0N/JGoLBaCLfrXj65PMzPjf6e7KotTM2tuWM/xGUwKi6FOwVNAE6Z
	dP0yrmL72luiNHKmSm4GBzhT2jK4opyKNLaOZfN2Xx0+iX6M8bVXtw4MKkPZT5w8=
X-Gm-Gg: ASbGncv8Vw2Xi3ad+DsjZqBvA0ZcxD8l4Egf/QGuZsQ2TgfMzcRWJLqnc66DImVc69Y
	VfrO2HlPkts2mqQ3ga0TK9X7PXC/Gd9RE44gWDssRwVR96F50X+QH6rJdEwWm1kR0wnIQ9xfP+J
	lQhVBaVd5MLaCRg6ezujiGqadsX751shsysABisw+P6O/x/5fwrk5YPQwkE6Wu3Z6OW6B12zo0V
	s42eKO56Wp4M/Ivz0cIC5nMkfskh7wvL3p4Br3NfCU0VJTRLDDu7gXNhrdCthoHK7br3b/v/tl8
	Eoe9AxvSLV7R8tQZwxqymxrj
X-Received: by 2002:a05:620a:2a08:b0:7b6:c92e:2e74 with SMTP id af79cd13be357-7bcd9709396mr554560985a.20.1736364052863;
        Wed, 08 Jan 2025 11:20:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfEC0CmcmCBxH4495Kx8QULF7SSuDbAA6X5OwuPEfjlTqaHZ114EzPSxwJXB4wwnwdOokL5Q==
X-Received: by 2002:a05:620a:2a08:b0:7b6:c92e:2e74 with SMTP id af79cd13be357-7bcd9709396mr554558385a.20.1736364052514;
        Wed, 08 Jan 2025 11:20:52 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac4be716sm1703908585a.97.2025.01.08.11.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 11:20:51 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ac57c73f-2146-408f-9916-f606354b6316@redhat.com>
Date: Wed, 8 Jan 2025 14:20:50 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: remove kernfs active break
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250106081904.721655-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250106081904.721655-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/25 3:19 AM, Chen Ridong wrote:
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
> get_online_cpus()") made cpuset_hotplug_workfn asynchronous, This change
> involves calling flush_work(), which can create a multiple processes
> circular locking dependency that involve cgroup_mutex, potentially leading
> to a deadlock. To avoid deadlock. the commit 76bb5ab8f6e3 ("cpuset: break
> kernfs active protection in cpuset_write_resmask()") added
> 'kernfs_break_active_protection' in the cpuset_write_resmask. This could
> lead to this warning.
>
> After the commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug
> processing synchronous"), the cpuset_write_resmask no longer needs to
> wait the hotplug to finish, which means that concurrent hotplug and cpuset
> operations are no longer possible. Therefore, the deadlock doesn't exist
> anymore and it does not have to 'break active protection' now. To fix this
> warning, just remove kernfs_break_active_protection operation in the
> 'cpuset_write_resmask'.
>
> Fixes: 76bb5ab8f6e3 ("cpuset: break kernfs active protection in cpuset_write_resmask()")
> Reported-by: Ji Fa <jifa@huawei.com>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 25 -------------------------
>   1 file changed, 25 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 7ea559fb0cbf..0f910c828973 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3124,29 +3124,6 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   	int retval = -ENODEV;
>   
>   	buf = strstrip(buf);
> -
> -	/*
> -	 * CPU or memory hotunplug may leave @cs w/o any execution
> -	 * resources, in which case the hotplug code asynchronously updates
> -	 * configuration and transfers all tasks to the nearest ancestor
> -	 * which can execute.
> -	 *
> -	 * As writes to "cpus" or "mems" may restore @cs's execution
> -	 * resources, wait for the previously scheduled operations before
> -	 * proceeding, so that we don't end up keep removing tasks added
> -	 * after execution capability is restored.
> -	 *
> -	 * cpuset_handle_hotplug may call back into cgroup core asynchronously
> -	 * via cgroup_transfer_tasks() and waiting for it from a cgroupfs
> -	 * operation like this one can lead to a deadlock through kernfs
> -	 * active_ref protection.  Let's break the protection.  Losing the
> -	 * protection is okay as we check whether @cs is online after
> -	 * grabbing cpuset_mutex anyway.  This only happens on the legacy
> -	 * hierarchies.
> -	 */
> -	css_get(&cs->css);
> -	kernfs_break_active_protection(of->kn);
> -
>   	cpus_read_lock();
>   	mutex_lock(&cpuset_mutex);
>   	if (!is_cpuset_online(cs))
> @@ -3179,8 +3156,6 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   out_unlock:
>   	mutex_unlock(&cpuset_mutex);
>   	cpus_read_unlock();
> -	kernfs_unbreak_active_protection(of->kn);
> -	css_put(&cs->css);
>   	flush_workqueue(cpuset_migrate_mm_wq);
>   	return retval ?: nbytes;
>   }

That looks good to me. Breaking active lock protection is no longer needed.

Acked-by: Waiman Long <longman@redhat.com>


