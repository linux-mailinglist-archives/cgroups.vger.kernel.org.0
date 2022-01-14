Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D3448EDFC
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 17:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243236AbiANQUr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 11:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243304AbiANQUq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 11:20:46 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B40EC061574;
        Fri, 14 Jan 2022 08:20:46 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 128so3154257pfe.12;
        Fri, 14 Jan 2022 08:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tI6w3Ew9uGi/4Ws14FKORId620oBYfchKOW7qmy41Pg=;
        b=HY0j4wzABS+0tmo1ciIn9OCG9WYpveD9/CRFtxUR5s4EpAiRsgOpumJrKXnwlBLfUL
         nVTvlv9ycgETcPJb61MfGbv5wMjcEITUx+zvjfNb9MSHX3XDDVcs8WNed6zhGA/KHzpT
         /0t5yY66BEYEhydFy2UABlDPGDoxaQK15gknPQK7D8LvUKMoq5f3vrxo1x4jwLBMNAed
         ouJ8OYK2gG/XOpNdyjeGecwrfQJdJXzOt+Zg3LREIvkRtn1kp8iMmHxNEdLvqlDvkclD
         5MTmBAXXOL2LFhOX4Y44zMm+rfapaNeNkeTsUL+oV76GFKVa65cE/NaWThNwlXb/cjPg
         7arQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tI6w3Ew9uGi/4Ws14FKORId620oBYfchKOW7qmy41Pg=;
        b=JW+MXlaK+gtTGg/Hwud5e6LSiOo+IN2Xh5S8D1aeXdeF5MNjzFVR9xkWoAkhEXWTP8
         YMekO2M26chHIqDmM77veF0RnUAcCIjhy9dJUH2Rr/IEZEqgjtMTJAk0JxPEDS47jC8Z
         iq4hDy0sFEVVSD3mUNHcyf4rGNrOgkJD9x0cWXfcOmA156BkHGUEa/egnEvEg+wZ/cVD
         J6IuMbEtsCKUklXexSrHjIfUKtBq7ghyURsElGbU52azrGfZ6h34HaAvZFg6jJZkHoA5
         iVs0snkK2FtZwRNT115vgmGERBC1l307h79+j5efbKoXNk7xJPBHpMbM/hUhSNMXwV7H
         ocKg==
X-Gm-Message-State: AOAM5325m1qdjek7hbfXPyssbmCfC4ITSarNOMLAcbB+2NFuMxLx+Asy
        UIO/4+NVpbkGriih6pap1p2Nn0u1KsbFTw==
X-Google-Smtp-Source: ABdhPJz6AVfa1WVT3ozV52/TTxxA7+rA/ZqLs7Z7WpjzPYU6ZTkx0kgKz7dEkwGow9hAHyUPSb0OMA==
X-Received: by 2002:a05:6a00:22d1:b0:4c2:5a55:960e with SMTP id f17-20020a056a0022d100b004c25a55960emr6081874pfj.74.1642177245436;
        Fri, 14 Jan 2022 08:20:45 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id h189sm1241535pfg.141.2022.01.14.08.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 08:20:44 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 14 Jan 2022 06:20:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [Question] set_cpus_allowed_ptr() call failed at cpuset_attach()
Message-ID: <YeGi2yjRi/uZIF/2@slm.duckdns.org>
References: <09ce5796-798e-83d0-f1a6-ba38a787bfc5@huawei.com>
 <4415cd09-6de3-bb2d-386d-8beb4927fb46@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4415cd09-6de3-bb2d-386d-8beb4927fb46@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

(cc'ing Waiman and Michal and quoting whole body)

Seems sane to me but let's hear what Waiman and Michal think.

On Fri, Jan 14, 2022 at 09:15:06AM +0800, Zhang Qiao wrote:
> 
> Hello everyone
> 
> 	I found the following warning log on qemu. I migrated a task from one cpuset cgroup to
> another, while I also performed the cpu hotplug operation, and got following calltrace.
> 
> 	This may lead to a inconsistency between the affinity of the task and cpuset.cpus of the
> dest cpuset, but this task can be successfully migrated to the dest cpuset cgroup.
> 
> 	Can we use cpus_read_lock()/cpus_read_unlock() to guarantee that set_cpus_allowed_ptr()
> doesn't fail, as follows:
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d0e163a02099..2535d23d2c51 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2265,6 +2265,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>         guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
> 
>         cgroup_taskset_for_each(task, css, tset) {
> +               cpus_read_lock();
>                 if (cs != &top_cpuset)
>                         guarantee_online_cpus(task, cpus_attach);
>                 else
> @@ -2274,6 +2275,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>                  * fail.  TODO: have a better way to handle failure here
>                  */
>                 WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
> +               cpus_read_unlock();
> 
> 
> 	Is there a better solution?
> 
> 	Thanks
> 
> log:
> [   43.853794] ------------[ cut here ]------------
> [   43.853798] WARNING: CPU: 7 PID: 463 at ../kernel/cgroup/cpuset.c:2279 cpuset_attach+0xee/0x1f0
> [   43.853806] Modules linked in:
> [   43.853807] CPU: 7 PID: 463 Comm: bash Not tainted 5.16.0-rc4+ #10
> [   43.853810] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
> [   43.853811] RIP: 0010:cpuset_attach+0xee/0x1f0
> [   43.853814] Code: ff ff 48 85 c0 48 89 c3 74 24 48 81 fd 40 42 54 82 75 96 80 bb 38 07 00 00 6f 48 8b 05 93 b3 55 01 48 89 05 bc 05 bb 01 75 97 <0f> 0b eb b3 48 8b 85 e8 00 00 00 48 85
> [   43.853816] RSP: 0018:ffffc90000623c30 EFLAGS: 00010246
> [   43.853818] RAX: 0000000000000000 RBX: ffff888101f39c80 RCX: 0000000000000001
> [   43.853819] RDX: 0000000000007fff RSI: ffffffff82cd5708 RDI: ffff888101f39c80
> [   43.853821] RBP: ffff8881001afe00 R08: 0000000000000000 R09: ffffc90000623d00
> [   43.853822] R10: ffffc900000a3de8 R11: 0000000000000001 R12: ffffc90000623cf0
> [   43.853823] R13: ffffffff82cd56d0 R14: ffffffff82544240 R15: 0000000000000001
> [   43.853824] FS:  00007f012414d740(0000) GS:ffff8882b5bc0000(0000) knlGS:0000000000000000
> [   43.853828] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   43.853829] CR2: 000055cfdb27de28 CR3: 00000001020cc000 CR4: 00000000000006e0
> [   43.853830] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   43.853831] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   43.853832] Call Trace:
> [   43.853846]  <TASK>
> [   43.853848]  cgroup_migrate_execute+0x319/0x410
> [   43.853853]  cgroup_attach_task+0x159/0x200
> [   43.853857]  ? __cgroup1_procs_write.constprop.21+0x10d/0x170
> [   43.853858]  __cgroup1_procs_write.constprop.21+0x10d/0x170
> [   43.853860]  cgroup_file_write+0x65/0x160
> [   43.853863]  kernfs_fop_write_iter+0x12a/0x1a0
> [   43.853870]  new_sync_write+0x11d/0x1b0
> [   43.853877]  vfs_write+0x232/0x290
> [   43.853880]  ksys_write+0x9c/0xd0
> [   43.853882]  ? fpregs_assert_state_consistent+0x19/0x40
> [   43.853886]  do_syscall_64+0x3a/0x80
> [   43.853896]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   43.853902] RIP: 0033:0x7f012381f224
> [   43.853904] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8d 05 c1 07 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 45
> [   43.853906] RSP: 002b:00007ffd3f411f28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [   43.853908] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f012381f224
> [   43.853909] RDX: 0000000000000004 RSI: 000055cfdb297a70 RDI: 0000000000000001
> [   43.853910] RBP: 000055cfdb297a70 R08: 000000000000000a R09: 0000000000000003
> [   43.853911] R10: 000000000000000a R11: 0000000000000246 R12: 00007f0123afb760
> [   43.853913] R13: 0000000000000004 R14: 00007f0123af72a0 R15: 00007f0123af6760
> [   43.853914]  </TASK>
> [   43.853915] ---[ end trace 8292bcee7ea90403 ]---

-- 
tejun
