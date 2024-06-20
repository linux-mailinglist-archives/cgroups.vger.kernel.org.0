Return-Path: <cgroups+bounces-3247-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD7E910369
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 13:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271521F22CB5
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 11:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1B81ABCBE;
	Thu, 20 Jun 2024 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MT5/8lgm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129D1ABCBC
	for <cgroups@vger.kernel.org>; Thu, 20 Jun 2024 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884283; cv=none; b=kpHFAf2I/xMrwZslWbu+thcG7G9pIyHtrgeEASDzEpsu+HcgrIy8KCCB5M3MO4+PKbFIGgqXMvNvn0SPbPiWrWaQYs0SQfMop3ve/LHHHegm2UYrQO6zABXyf13yxVGUoicDhSOAUMPBuBK2WbTRlEL1TkmAQeZpWVowRY/IuIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884283; c=relaxed/simple;
	bh=85K2pu2AWoZroBZXPpv3PmtyqrZDCsmZjDUn3hT8WIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzLJ8xLbJgwjTGUIZ8Ko+tGcTYfjTY26xzTq1kqqHXxEMLgWF+hMsJPfevb0i33POOYzD1ERnZsinBZNW6davYmwOVAmHKEEcA8brkah/7/MA7H4h/8hvzuhnIC89TWmk1k8W0Ts3TKtDVc+UNKjsSwyQhTOuAJkiL8bPdgD1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MT5/8lgm; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-48f12b4f5b6so296817137.0
        for <cgroups@vger.kernel.org>; Thu, 20 Jun 2024 04:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718884281; x=1719489081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2bgNJiFTvXzfd9V1Bu90Pdh0gTgubeWAK8jGjDQQDkY=;
        b=MT5/8lgmCPF8h843eHPKv9STEMWwOfnYc14PGV4dpdA4qqUbJ/954Holi3aZOThtPI
         IUJANusHHILBsKJTKbtx7ZW2BYlHwZ0mTFye0/6nOBcbvWY1uSN0Evlzt4YtnwzWkVtz
         BWTRK3InmGx9ScQSr3bhOu6BtGNXEdFrhFwvF7nZYO5+htgtipVUijEC+kL3PKGekJ3n
         Dz5wjKREJxiZS+rTRJkFB3ak66s9VdBiyK/gs23YnIq6NEIrqvkMWUVA6szbF0gvqWwj
         LBFty+CCLTYhFlctAe/8kq9fhgTZ/Q/v4UjNhmG/wBohequ5pvJtkKAvFsDL6P0CCbtq
         suAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718884281; x=1719489081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bgNJiFTvXzfd9V1Bu90Pdh0gTgubeWAK8jGjDQQDkY=;
        b=D1bySXET+JVFxYDNok1seXAuTX8+BvvoJG1gAtJZ8SX5IxzJ5ySFpQtrLdkjZL0Ug8
         lrRDfPg+Xr1M0ofDFBq97c2Ey0zZk7eoz4RxB2/4Dq11gvKn/W6q/Sh9utdVP6yh1lOR
         LNPfRwxhawqtyWTxTUzarre0JsgSClBQfELHP0c4uwIT9wQrEpRY77rFLE09l0h9Yj8w
         fXz2R3e8p2tDgOnQdy35mwma9nP5Mdtumcj6VLUdoV4BkrAYnVSQ8sM3dFTmLLbL6Tdz
         O3N2ssX1/N489BoaaCf/+ilPeK6o/6EbvZHdNd+EQMQRIOfYxXW5YUgLdKroxZw9dxxw
         SrMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXts5vIdFHGU4f0mynVI2WaygdKzW6ubjZDjsVSp2iDRGqU2XMGzxgQ0qnXhmMB1TVUU4l3VBphrFdI0xkEYRvgHuNAGXcPYA==
X-Gm-Message-State: AOJu0Yy+L7CD0JOZdj7ev389JRysrK6WVKJkimv2LoI5PvQvJkccfRhT
	xzfi2q5b3KW/pyedSxrqss9Cgct6uT4VpG+zgtgewBm8SSFzuXGiHpdOifTNDnWKW0BJ9NeYqUK
	hFtnRaAmNhkvkPbOQdifWoeCAnmg3OezxmdddQA==
X-Google-Smtp-Source: AGHT+IGZfPkWsM7N3Gsj51E+988dSB/D/Zg80mWbI0dZpf/96I1y1F/MMX2R+yCoqRRbh8zOr1KuVEtFD2at1ZvS9fM=
X-Received: by 2002:a05:6102:743:b0:48f:205e:9b8 with SMTP id
 ada2fe7eead31-48f205e0aafmr2808952137.34.1718884280677; Thu, 20 Jun 2024
 04:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619125609.836313103@linuxfoundation.org>
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Jun 2024 17:21:09 +0530
Message-ID: <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Miaohe Lin <linmiaohe@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Hildenbrand <david@redhat.com>, 
	Cgroups <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, jbeulich@suse.com, 
	LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 18:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.6 release.
> There are 281 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

There are two major issues on arm64 Juno-r2 on Linux stable-rc 6.9.6-rc1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

1)
The LTP controllers cgroup_fj_stress test cases causing kernel crash
on arm64 Juno-r2 with
compat mode testing with stable-rc 6.9 kernel.

In the recent past I have reported this issues on Linux mainline.

LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline 6.10.rc3
  - https://lore.kernel.org/all/CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com/

it goes like this,
  Unable to handle kernel NULL pointer dereference at virtual address
  ...
  Insufficient stack space to handle exception!
  end Kernel panic - not syncing: kernel stack overflow

2)
The LTP controllers cgroup_fj_stress test suite causing kernel oops on
arm64 Juno-r2 (with the clang-night build toolchain).
  Unable to handle kernel NULL pointer dereference at virtual address
0000000000000009
  Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
  pc : xprt_alloc_slot+0x54/0x1c8
  lr : xprt_alloc_slot+0x30/0x1c8


Details of crash log:
1)
Crash log:
-----------
cgroup_fj_stress 1 TINFO: Running: cgroup_fj_stress.sh cpuacct 200 1 none
cgroup_fj_stress 1 TINFO: timeout per run is 0h 50m 0s
tst_cgroup.c:764: TINFO: Mounted V1 cpuacct CGroup on
/scratch/ltp-iiltEE0UOm/cgroup_cpuacct
cgroup_fj_stress 1 TINFO: test starts with cgroup version 1
cgroup_fj_stress 1 TINFO: Creating subgroups ...
[ 1785.477847] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000070
[ 1785.486682] Mem abort info:
[ 1785.489477]   ESR = 0x0000000096000004
[ 1785.493232]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1785.498555]   SET = 0, FnV = 0
[ 1785.501613]   EA = 0, S1PTW = 0
[ 1785.504757]   FSC = 0x04: level 0 translation fault
[ 1785.509643] Data abort info:
[ 1785.512526]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1785.518021]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1785.523082]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
..
[ 1786.235715] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000070
..
[ 1786.286238] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000070
..
[ 1786.336761] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000070
[ 1786.345564] Mem abort info:
[ 1786.348359]   ESR = 0x0000000096000004
[ 1786.352112]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1786.357434]   SET = 0, FnV = 0
[ 1786.360492]   EA = 0, S1PTW = 0
[ 1786.363637]   FSC = 0x04: level 0 translation fault
[ 1786.368523] Data abort info:
[ 1786.371405]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[ 1786.376900]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[ 1786.381960]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1786.387284] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000070
[ 1786.387293] Insufficient stack space to handle exception!
[ 1786.387296] ESR: 0x0000000096000047 -- DABT (current EL)
[ 1786.387302] FAR: 0xffff80008399ffe0
[ 1786.387306] Task stack:     [0xffff8000839a0000..0xffff8000839a4000]
[ 1786.387312] IRQ stack:      [0xffff8000837f8000..0xffff8000837fc000]
[ 1786.387319] Overflow stack: [0xffff00097ec95320..0xffff00097ec96320]
[ 1786.387327] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 6.9.6-rc1 #1
[ 1786.387338] Hardware name: ARM Juno development board (r2) (DT)
[ 1786.387344] pstate: a00003c5 (NzCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1786.387355] pc : _prb_read_valid (kernel/printk/printk_ringbuffer.c:2109)
[ 1786.387374] lr : prb_read_valid (kernel/printk/printk_ringbuffer.c:2183)
[ 1786.387385] sp : ffff80008399ffe0
[ 1786.387390] x29: ffff8000839a0030 x28: ffff000800365f00 x27: ffff800082530008
[ 1786.387407] x26: ffff8000834e33b8 x25: ffff8000839a00b0 x24: 0000000000000001
[ 1786.387423] x23: ffff8000839a00a8 x22: ffff8000830e3e40 x21: 0000000000001e9e
[ 1786.387438] x20: 0000000000000000 x19: ffff8000839a01c8 x18: 0000000000000010
[ 1786.387453] x17: 72646461206c6175 x16: 7472697620746120 x15: 65636e6572656665
[ 1786.387468] x14: 726564207265746e x13: 3037303030303030 x12: 3030303030303030
[ 1786.387483] x11: 2073736572646461 x10: ffff800083151ea0 x9 : ffff80008014273c
[ 1786.387498] x8 : ffff8000839a0120 x7 : 0000000000000000 x6 : 0000000000000e9f
[ 1786.387512] x5 : ffff8000839a00c8 x4 : ffff8000837157c0 x3 : 0000000000000000
[ 1786.387526] x2 : ffff8000839a00b0 x1 : 0000000000000000 x0 : ffff8000830e3f58
[ 1786.387542] Kernel panic - not syncing: kernel stack overflow
[ 1786.387549] SMP: stopping secondary CPUs
[ 1787.510055] SMP: failed to stop secondary CPUs 0,4
[ 1787.510065] Kernel Offset: disabled
[ 1787.510068] CPU features: 0x4,00001061,e0100000,0200421b
[ 1787.510076] Memory Limit: none
[ 1787.680436] ---[ end Kernel panic - not syncing: kernel stack overflow ]---

2) Kernel oops log:
-----------
[ 1094.253182]  __secondary_switched+0xb8/0xc0
[ 1094.258306] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000009
[ 1094.267132] Mem abort info:
[ 1094.269938]   ESR = 0x0000000096000044
[ 1094.273701]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1094.279031]   SET = 0, FnV = 0
[ 1094.282097]   EA = 0, S1PTW = 0
[ 1094.285242]   FSC = ranslation fault
[ 1094.290136] Data abort info:
[ 1094.293019]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
[ 1094.298523]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[ 1094.303592]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[ 1094.308921] user pgtable: 4k bit VAs, pgdp=00000008a2a34000
[ 1094.315383] [0000000000000009] pgd=0000000000000000, p4d=0000000000000000
[ 1094.322211] Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
[ 1094.328489] Modules linked in: btrfs xor xor_neon raid6_pq
zstd_compress libcrc38x hdlcd cec drm_dma_helper onboard_usb_hub
crct10dif_ce drm_kms_helper fuse drm backlight dm_mod ip_tables
x_tables
[ 1094.346744] CPU: 1 PID: 161 Comm: systemd-journal Tainted: G
W          6.9.6-rc1 #1
[ 1094.355112] Hardware name: ARM Juno development board (r2) (DT)
[ 1094.361038] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1094.368013] pc : xprt_alloc_slot+0x54/0x1c8
[ 1094.372208] lr : xprt_alloc_slot+0x30/0x1c8
[ 1094.376398] sp : ffff800082dc37e0
[ 1094.379713] x29: ffff800082dc37e0 x28: ffff8000814d31c8 x27: 0000000000008080
[ 1094.386868] x26: ffff8000825da000 x25: 0000000000000001 x24: 0000000000440100
[ 1094.394022] x23: ffff000821759300 x22: 0000000000002102 x21: ffff00082d39d000
[ 1094.401176] x20: ffff00082201f800 x19: ffff0008225bf400 x18: 0000000000000000
[ 1094.408329] x17: 0000000000000000 x16: 0000000000000800 x15: 8080008000000000
[ 1094.415483] x14: 0000ff0064656873 x13: ffff800082dc0000 x12: 0000000000000022
[ 1094.422636] x11: dead000000000100 x10: 0000000000000001 x9 : 0000000000000000
[ 1094.429790] x8 : ffff00082d39d0c8 x7 : 0000000000000000 x6 : 0000000000000000
[ 1094.436942] x5 : 0000000000000000 x4 : ffff00097ec4c530 x3 : ffff800082dc3790
[ 1094.444096] x2 : ffff000821759300 x1 : 0000000000000000 x0 : ffff800081583770
[ 1094.451249] Call trace:
[ 1094.453694]  xprt_alloc_slot+0x54/0x1c8
[ 1094.457536]  xprt_reserve+0x6c/0xe8
[ 1094.461029]  call_reserve+0x2c/0x40
[ 1094.464522]  __rpc_execute+0x124/0x640
[ 1094.468280]  rpc_execute+0x100/0x280
[ 1094.471862]  rpc_run_task+0x124/0x1e8
[ 1094.475528]  rpc_call_sync+0x58/0xc0
[ 1094.479106]  nfs3_proc_getattr+0x94/0xf8
[ 1094.483037]  __nfs_revalidate_inode+0x13c/0x310
[ 1094.487575]  nfs_access_get_cached+0x23c/0x3b8
[ 1094.492024]  nfs_do_access+0x74/0x2b8
[ 1094.495689]  nfs_permission+0xb8/0x1e0
[ 1094.499441]  inode_permission+0xc4/0x170
[ 1094.503371]  link_path_walk+0x100/0x3e0
[ 1094.507215]  path_lookupat+0x74/0x130
[ 1094.510882]  filename_lookup+0xdc/0x1d8
[ 1094.514724]  user_path_at_empty+0x58/0x108
[ 1094.518828]  do_faccessat+0x178/0x330
[ 1094.522495]  __arm64_sys_faccessat+0x30/0x48
[ 1094.526771]  invoke_syscall+0x4c/0x118
[ 1094.530528]  el0_svc_common+0x8c/0xf0
[ 1094.534197]  do_el0_svc+0x28/0x40
[ 1094.537518]  el0_svc+0x40/0x88
[ 1094.540576]  el0t_64_sync_handler+0x90/0x100
[ 1094.544853]  el0t_64_sync+0x190/0x198
[ 1094.548522] Code: d280200b f2fbd5ab 5280044c d1032115 (f9000549)
[ 1094.554623] ---[ end trace 0000000000000000 ]---
[ 1094.559268] note: systemd-journal[161] exited with preempt_count 1
[ 1115.569495] rcu: INFO: rcu_preempt self-detected stall on CPU


Links:
------
1)
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.5-282-g93f303762da5/testrun/24410131/suite/log-parser-test/test/check-kernel-panic/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.5-282-g93f303762da5/testrun/24410131/suite/log-parser-test/test/check-kernel-panic-a44367e5836148d6e94412d6de8ab7a0ca37c18d2bfb6a639947ecd2704ad6b1/details/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2i6h1Ah6I8CP7ABUzTl9shfaW60
 - https://lkft.validation.linaro.org/scheduler/job/7687060#L23314

2)
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.5-282-g93f303762da5/testrun/24410890/suite/log-parser-test/test/check-kernel-oops/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.5-282-g93f303762da5/testrun/24410890/suite/log-parser-test/test/check-kernel-exception-55b962f42ea3dfdcb5c7b6c7ceee184b48ae8d479f430f7b31241f220adcb542/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.5-282-g93f303762da5/testrun/24410890/suite/log-parser-test/tests/
 - https://lkft.validation.linaro.org/scheduler/job/7688690#L16336


Build details:
-------
* kernel: 6.9.6-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.9.y
* git commit: 93f303762da5a9d9c2c72cac615d4d092ce42b1f
* git describe: v6.9.5-282-g93f303762da5


--
Linaro LKFT
https://lkft.linaro.org

