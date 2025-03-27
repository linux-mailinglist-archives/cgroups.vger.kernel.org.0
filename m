Return-Path: <cgroups+bounces-7244-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B24A73A7A
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 18:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673CC189B875
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 17:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9D721A437;
	Thu, 27 Mar 2025 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSzY06uC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E31A5B98
	for <cgroups@vger.kernel.org>; Thu, 27 Mar 2025 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743096609; cv=none; b=Bc8Wq5xW/HbYCLSzxkReZUG8R+uMYNlZMMoiJVHL7EHl0xOyicul/gK8JPq2AYKKm+Mq65ApUd62ICDlxY5NNGwE3w2WmrNlomapaCNxlPr287erpVdiskv4hu9ASMqCU9oSWPqUMhljXhNef17upKLx8TNqXUZWWLQddxQRcpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743096609; c=relaxed/simple;
	bh=K66Q38Lz90Nt3j6FO+oeTnlxzaJOsNINcLtmcpY+h10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPLIXRW63ScnIcPy5nQhRmoPRg2fxLPEXm11Ic3W5ZYKDHnhrxuXF6rnduQZQNpDOAerhikamN3sFLCmOWUS/wGQeKiKQKV0/MtTd1mEwLK2B7LQtzMlfC/uarDUFcZF6b7CQ8IBhALs7LL/xU0MuYECS6zkuo5CSiZXZR6RlF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lSzY06uC; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52446b21cfdso590358e0c.1
        for <cgroups@vger.kernel.org>; Thu, 27 Mar 2025 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743096606; x=1743701406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WDN1VKUJwLebN0ryWgo3KULQHNLf140Ja4ddZir7PXQ=;
        b=lSzY06uCq/AZ+mBfLQv2uI1GCPPeo82pbj9k8ByhEJZkXG2hpcgKvv/kz1995tx9DI
         evIfGKhV6osj4Kjelzivzi/w1JiyxOm8oVCi3VL0BkNqldzPewxQuDfH2TSSxtjhdoi1
         gBlHTz7mv5C9jZmzsO3xaU97uBKBttBtTd1rQT0BkJ6koNVX2FLJYuwpNoUJmmnidQ8n
         hJI3/zGME+xKq6O7CuH5/ZxuWG4a9TwyFlNI5K5bvyJN/vEEaMF63baWrNvSO1CL4Gxg
         Wx/MBKrLOkyTsJs03+ERKOMQzkqV9WI323s5ViP5UTlKPLosdpL9Hv0pYnwvBH88HVrA
         BBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743096606; x=1743701406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDN1VKUJwLebN0ryWgo3KULQHNLf140Ja4ddZir7PXQ=;
        b=CB59bC0jbWLqmmdOjk7bGA6pthXz0RgG5LaI8uNmv9E/9qxj1zCmOgieSGzEet/MU0
         ywX9mBc7l6A58TcYuj4MjCLd+YOfON5FlPNCg24ROmWGRr//7ZN0eOrvoPOX5JRlUedo
         svbEXR3afcTH6NI74q/rFyzNcHtk1pxjrm20G031ZOHJQ9qUr6hPzg+EQjyMyEI1w3Sj
         dRvboZuEsH8wzgCp7B2DnF5YbKu2XlRklKQakDCChTpVRjEHKo4mzSUECBB8g4Hy6hKd
         /GlWW6bCO5jejjIdOTB5XSb0Jn4M1J90FvkB8o2bLrS3FOlDgEjg9tabYThC4ovrulW6
         ln4A==
X-Forwarded-Encrypted: i=1; AJvYcCVT1lwJBs8puwyVi4OVE8td2QJZjTkHKplUQI0tfE9I/jCkaGhUXiNFQAjo1MMFrvZMxi7mAj30@vger.kernel.org
X-Gm-Message-State: AOJu0YzNT7znyb5F0VA07D9QU+BCJOkRst6T6hL3ok470uaSGrKSBw4a
	UX6ciaggx9bC4emA9CnPQzkSJMF3oAlzHqJKSPFwVHhwNCO8O8kWZF96xa8TVForHo3qSYqo4Wt
	MW6Jb2KvqqsI10OGxCN8rg3yAKOxtvRIGAndm5w==
X-Gm-Gg: ASbGncsVvvGWtGMyAMMzvR/5z82835qHP8srlHuaQ3xqDFGI0YZcfX4HR0AhxE2/apA
	mGDcvwHye22iZBBnD9lNYEYV7kKnUNbJ9QWlMz2MIDt7HnOFGN0BYqpUZi96Pzrkqxg6L6mgQMV
	AK99wjuKLu55CcvxAPrJDB+QCusnbY03TIpYdjE3jnRqmOa0xyXDPwHYAAfBbCkojNmMMmpQ==
X-Google-Smtp-Source: AGHT+IEztlgWSCIn71l6XVgidilEQsC+WgA0rVBDr66THcB1Yab03MEJKS8U8SF8aZ91Fp8ddjC6/zH3JJFfZRywj4k=
X-Received: by 2002:a05:6122:887:b0:520:652b:ce18 with SMTP id
 71dfb90a1353d-5260071ccf2mr3310045e0c.0.1743096605264; Thu, 27 Mar 2025
 10:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326154349.272647840@linuxfoundation.org>
In-Reply-To: <20250326154349.272647840@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 27 Mar 2025 22:59:52 +0530
X-Gm-Features: AQ5f1JqUE3wEB4mA5ovU8cCdeyrT-Beu7WuvHFYj9Q6LMIcb26hTI9Y51kQelGw
Message-ID: <CA+G9fYtHXcRhFd9BH3sDYBNBT2XcP42amy5QqpLhNKesLUb8WA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/197] 6.1.132-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shakeel Butt <shakeelb@google.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Cgroups <cgroups@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 21:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.132 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 28 Mar 2025 15:43:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.132-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

In Addition to previous build regressions,

Regressions on arm and arm64 devices cpu hotplug tests failed and
kernel oops triggered
with gcc-13 and clang-20 the stable-rc 6.1.132-rc2.

First seen on the 6.1.132-rc1
Good: v6.1.131
Bad: Linux 6.1.132-rc1 and Linux 6.1.132-rc2

* Juno-r2, rockpi-4, dragonboard 845c, e850-96,
  - selftests: cpu-hotplug: cpu-on-off-test.sh
  - ltp-controllers: cpuset_hotplug_test.sh
  - selftests: rseq: basic_percpu_ops_test

Regression Analysis:
- New regression? yes
- Reproducibility? Yes

Test regression: arm64 arm cpuhotplug kernel NULL pointer dereference
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log
command: cpuset_hotplug_test.sh
[ 1912.782804] /usr/local/bin/kirk[465]: starting test cpuset_hotplug
(cpuset_hotplug_test.sh)
cpuset_hotplug 1 TINFO: CPUs are numbered continuously starting at 0 (0-5)
cpuset_hotplug 1 TINFO: Nodes are numbered continuously starting at 0 (0)
[ 1917.567011] psci: CPU1 killed (polled 0 ms)
cpuset_hotplug 1 TPASS: Cpuset vs CPU hotplug test succeeded.
[ 1918.804896] Detected VIPT I-cache on CPU1
[ 1918.805388] cacheinfo: Unable to detect cache hierarchy for CPU 1
[ 1918.805957] GICv3: CPU1: found redistributor 1 region 0:0x00000000fef20000
[ 1918.806683] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[ 1919.086059] psci: CPU1 killed (polled 0 ms)
[ 1919.120969] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[ 1919.121807] Mem abort info:
[ 1919.122086]   ESR = 0x0000000096000004
[ 1919.122451]   EC = 0x25: DABT (current EL), IL = 32 bits
[ 1919.122956]   SET = 0, FnV = 0
[ 1919.123262]   EA = 0, S1PTW = 0
[ 1919.123574]   FSC = 0x04: level 0 translation fault
[ 1919.124038] Data abort info:
[ 1919.124380]   ISV = 0, ISS = 0x00000004
[ 1919.124754]   CM = 0, WnR = 0
[ 1919.125051] user pgtable: 4k pages, 48-bit VAs, pgdp=000000000a2b8000
[ 1919.125655] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[ 1919.126341] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[ 1919.126912] Modules linked in: snd_soc_hdmi_codec dw_hdmi_cec
dw_hdmi_i2s_audio brcmfmac rockchipdrm hantro_vpu hci_uart brcmutil
dw_mipi_dsi analogix_dp btqca v4l2_h264 btbcm v4l2_vp9 dw_hdmi
panfrost v4l2_mem2mem cfg80211 cec bluetooth snd_soc_audio_graph_card
videobuf2_v4l2 drm_display_helper gpu_sched snd_soc_simple_card
videobuf2_dma_contig crct10dif_ce snd_soc_spdif_tx
snd_soc_rockchip_i2s snd_soc_simple_card_utils videobuf2_memops
phy_rockchip_pcie rockchip_saradc rtc_rk808 drm_shmem_helper
drm_dma_helper videobuf2_common rfkill industrialio_triggered_buffer
drm_kms_helper pcie_rockchip_host rockchip_thermal coresight_cpu_debug
kfifo_buf fuse drm ip_tables x_tables
[ 1919.132505] CPU: 0 PID: 67249 Comm: kworker/0:0 Not tainted 6.1.132-rc2 #1
[ 1919.133132] Hardware name: Radxa ROCK Pi 4B (DT)
[ 1919.133555] Workqueue: events work_for_cpu_fn
[ 1919.133983] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 1919.134617] pc : memcg_hotplug_cpu_dead
(include/linux/percpu-refcount.h:174
include/linux/percpu-refcount.h:332
include/linux/percpu-refcount.h:351 include/linux/memcontrol.h:795
mm/memcontrol.c:2382)
[ 1919.135076] lr : memcg_hotplug_cpu_dead
(include/linux/percpu-refcount.h:174
include/linux/percpu-refcount.h:332
include/linux/percpu-refcount.h:351 include/linux/memcontrol.h:795
mm/memcontrol.c:2382)
[ 1919.135528] sp : ffff80000e78bc60
[ 1919.135835] x29: ffff80000e78bc60 x28: 0000000000000000 x27: ffff80000a1c81f8
[ 1919.136501] x26: 0000000000000028 x25: ffff0000f7534778 x24: ffff80000a1aeb08
[ 1919.137166] x23: 0000000000000000 x22: ffff80000a16e240 x21: 0000000000000000
[ 1919.137830] x20: ffff8000ed3d5000 x19: 0000000000000000 x18: 00000000a2704302
[ 1919.138495] x17: 0000000000000000 x16: 0000000000000312 x15: 0000040000000000
[ 1919.139159] x14: 0000000000000000 x13: ffff80000e788000 x12: ffff80000e78c000
[ 1919.139823] x11: 0bb2d4910b917800 x10: 0000000000000000 x9 : 0000000000000001
[ 1919.140487] x8 : ffff000013406300 x7 : 00000072b5503510 x6 : 0000000000300000
[ 1919.141151] x5 : 00000000801c0011 x4 : 0000000000000000 x3 : ffff80000e78bca0
[ 1919.141815] x2 : ffff80000e78bbf8 x1 : ffff8000080a11e4 x0 : ffff0000f7543240
[ 1919.142480] Call trace:
[ 1919.142709] memcg_hotplug_cpu_dead
(include/linux/percpu-refcount.h:174
include/linux/percpu-refcount.h:332
include/linux/percpu-refcount.h:351 include/linux/memcontrol.h:795
mm/memcontrol.c:2382)
[ 1919.143133] cpuhp_invoke_callback (kernel/cpu.c:193)
[ 1919.143554] _cpu_down (kernel/cpu.c:0 kernel/cpu.c:724
kernel/cpu.c:1157 kernel/cpu.c:1218)
[ 1919.143882] __cpu_down_maps_locked (kernel/cpu.c:1249)
[ 1919.144291] work_for_cpu_fn (kernel/workqueue.c:5184)
[ 1919.144647] process_one_work (kernel/workqueue.c:2297)
[ 1919.145028] worker_thread (include/linux/list.h:292
kernel/workqueue.c:2352 kernel/workqueue.c:2444)
[ 1919.145386] kthread (kernel/kthread.c:378)
[ 1919.145687] ret_from_fork (arch/arm64/kernel/entry.S:865)
[ 1919.146041] Code: d51b4235 8b160280 97ffec72 97f73691 (f9400269)
All code
========

Code starting with the faulting instruction
===========================================
[ 1919.146592] ---[ end trace 0000000000000000 ]---


## Test log 2
kselftest: Running tests in rseq
TAP version 13
1..9
timeout set to 0
selftests: rseq: basic_test
testing current cpu
basic_test: basic_test.c:30: void test_cpu_pointer(void): Assertion
`sched_getcpu() == i' failed.
Aborted
not ok 1 selftests: rseq: basic_test # exit=134
timeout set to 0
selftests: rseq: basic_percpu_ops_test
Segmentation fault
not ok 2 selftests: rseq: basic_percpu_ops_test # exit=139

The bisection pointing to,
 memcg: drain obj stock on cpu hotplug teardown
  upsteam commit 9f01b4954490d4ccdbcc2b9be34a9921ceee9cbb upstream.

## Source
* Kernel version: 6.1.132-rc2
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: f5ad54ef021f6fb63ac97b3dec5efa9cc1a2eb51
* Git describe: v6.1.131-198-gf5ad54ef021f
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/Test/v6.1.131-198-gf5ad54ef021f/

## Test
* Test log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-198-gf5ad54ef021f/testrun/27793089/suite/log-parser-test/test/internal-error-oops-oops-preempt-smp/log
* Test history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-198-gf5ad54ef021f/testrun/27793089/suite/log-parser-test/test/internal-error-oops-oops-preempt-smp-01e5a0f146f52056a08c01ad73b44c893f7748e5cd1533e30c989289a90e821b/history/
* Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.131-198-gf5ad54ef021f/testrun/27793089/suite/log-parser-test/test/internal-error-oops-oops-preempt-smp/
* Test link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2urSwSZQOGBhePbuN1hwUGDHIT8/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2urSwSZQOGBhePbuN1hwUGDHIT8/config


--
Linaro LKFT
https://lkft.linaro.org

