Return-Path: <cgroups+bounces-3252-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 166E2910763
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 16:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9D02872D8
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03601AED30;
	Thu, 20 Jun 2024 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m5MSdxqN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931DE1AD9ED
	for <cgroups@vger.kernel.org>; Thu, 20 Jun 2024 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892186; cv=none; b=pBwoYQp5XAOyapbB7KsnXlEfOAwz0+nglJvmfJaaYA7SRz6tZTwXNJYtxJ+lMgJAkgPVKIy4Ku7yP4v9O6WJGd81yzV0eoAwEhPPTnBkD5iLqmXrU3pF7l7tAfwksEqRvoch4+tzmkjeoRU4HD89rQpoMuhSv9F2q0aLRGPSDfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892186; c=relaxed/simple;
	bh=Oklm0Cw05TNvTzfvJtb1ocw12E15edBRA2IP+0NVAUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaBelRs/ud6n7btUOcW9nB2rQ4PriA7s7bRro2q8DiGAX4lRe2/2ta2Jr8r3QFK0QetDJL5V513Ry0B4U9IJDiJNtRn2uLBiRirllNrCSZ3z+XY3Ifj1oyVvXZnjBiZbhVRtQFFUKXSUaaVN72yINw3c+ro283/Mik1MSURbD6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m5MSdxqN; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6fc30e3237so93249366b.1
        for <cgroups@vger.kernel.org>; Thu, 20 Jun 2024 07:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718892182; x=1719496982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DivZWPPAJboyHT631bWOCfrq3h9RoUn6v0uBNxSBQyA=;
        b=m5MSdxqNJ1bGewFSOTaEjKNdFZigyFuq+r3O1zRuZUovN5lfP69M6gS4G9ok8fdMs1
         UV5A03E5mZlCMcKypyu7kFG/keY/sT0vZD9FEFOQ6Fb4regtt3WsUF6PV3VwiDPjUu3K
         S4yWYFgsJxSazUEXSxIPctALXndnBm0aHo0kpTzaqtOelWQ31e5w+L+gUACoP7nD/YAv
         fN3xqnVhPMtmW4+2u9vh/yRjE7JVoq6psSQzfUu6ar5cL/N4uZaYmdMyJ5ixkN6+M8wh
         4PINWqRGg1ARhh6mAsjkKAsO5nc8T66FH7LI3cS6qyl2/U4EJHLszL3jYXDiMBIVfkqh
         4Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718892182; x=1719496982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DivZWPPAJboyHT631bWOCfrq3h9RoUn6v0uBNxSBQyA=;
        b=qwvyOIymZqTE6RO1iBDXJkBGVjyKznGWrzmlfn6zjhcIOopxiEaCRKb8yTBir0C/E1
         x39kLwBmaS077BsoltCDq/chjvbKhsMPmfyNi2lg6qFrm0uh8VE4WvUvjG3BFqaBye6E
         xc9Um6bXjMJyxUfDyhyWVg9IqlYmBve0il+YMLCx9Re1BqnHYLLTtKDO98djKG6KilOl
         2G5dU2I1s8ZqxiL1JKdvp3AHGuAkGXYOyMyoWMBYn/z61LlQR4S0JdD4AU33hAxMjO+k
         gG9+UX2bxK2LeVYqLkDfowyUh0ufXl0K1PUcNvMxYnAbH+iafUTspcQwJ9UQWW1fpQ7q
         kLug==
X-Forwarded-Encrypted: i=1; AJvYcCV7C0BNHqyUgUwZF24mXaG/ZIHriz/8td7fASTblNeiwcT2ZRcMksiTSJ3N7txHkVWrsfMttlz5eaRw8NSiuFoIh+ufd/YfaA==
X-Gm-Message-State: AOJu0YwORItAH4SSycEuxveQQ0kCnSa6qnun5QqRHSzxBENlbSexlki4
	iDbp1Ob+skITJAe5+enG6y85lVWwQCZQqUabMxPyYvdliogD7oOa65ecJWB3z614bR+8ZRuCncj
	c4xuQrcQzSJ/oPOCrrzBicCP6uGaeDlduKlrjfg==
X-Google-Smtp-Source: AGHT+IE5IRidUBv1Rz0+z0UgilsHsNZAP3E8TZx/Yqczpa77Xl1ZAhegOmt9dztWkCt7PzES3N0d2ChrSeAxTflAWLc=
X-Received: by 2002:a17:906:b816:b0:a6f:5922:54e7 with SMTP id
 a640c23a62f3a-a6fab7d0bd8mr334461966b.65.1718892181739; Thu, 20 Jun 2024
 07:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619125609.836313103@linuxfoundation.org> <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
 <2024062028-caloric-cost-2ab9@gregkh> <CA+G9fYsr0=_Yzew1uyUtrZ7ayZFYqmaNzAwFZJPjFnDXZEwYcQ@mail.gmail.com>
 <36a38846-0250-4ac2-b2d0-c72e00d6898d@redhat.com>
In-Reply-To: <36a38846-0250-4ac2-b2d0-c72e00d6898d@redhat.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Jun 2024 19:32:48 +0530
Message-ID: <CA+G9fYv4fZiB-pL7=4SNfudh2Aqknf5+OXo1RFAFRhJFZMsEsg@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
To: David Hildenbrand <david@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org, 
	Miaohe Lin <linmiaohe@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Cgroups <cgroups@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, jbeulich@suse.com, 
	LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 19:23, David Hildenbrand <david@redhat.com> wrote:
>
> On 20.06.24 15:14, Naresh Kamboju wrote:
> > On Thu, 20 Jun 2024 at 17:59, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Thu, Jun 20, 2024 at 05:21:09PM +0530, Naresh Kamboju wrote:
> >>> On Wed, 19 Jun 2024 at 18:41, Greg Kroah-Hartman
> >>> <gregkh@linuxfoundation.org> wrote:
> >>>>
> >>>> This is the start of the stable review cycle for the 6.9.6 release.
> >>>> There are 281 patches in this series, all will be posted as a response
> >>>> to this one.  If anyone has any issues with these being applied, please
> >>>> let me know.
> >>>>
> >>>> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> >>>> Anything received after that time might be too late.
> >>>>
> >>>> The whole patch series can be found in one patch at:
> >>>>          https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
> >>>> or in the git tree and branch at:
> >>>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> >>>> and the diffstat can be found below.
> >>>>
> >>>> thanks,
> >>>>
> >>>> greg k-h
> >>>
> >>> There are two major issues on arm64 Juno-r2 on Linux stable-rc 6.9.6-rc1
> >>>
> >>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >>>
> >>> 1)
> >>> The LTP controllers cgroup_fj_stress test cases causing kernel crash
> >>> on arm64 Juno-r2 with
> >>> compat mode testing with stable-rc 6.9 kernel.
> >>>
> >>> In the recent past I have reported this issues on Linux mainline.
> >>>
> >>> LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline 6.10.rc3
> >>>    - https://lore.kernel.org/all/CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com/
> >>>
> >>> it goes like this,
> >>>    Unable to handle kernel NULL pointer dereference at virtual address
> >>>    ...
> >>>    Insufficient stack space to handle exception!
> >>>    end Kernel panic - not syncing: kernel stack overflow
> >>>
>
> How is that related to 6.9.6-rc1? That report is from mainline (6.10.rc3).
>
> Can you share a similar kernel dmesg output from  the issue on 6.9.6-rc1?

I request you to use this link for detailed boot log, test log and crash log.
 - https://lkft.validation.linaro.org/scheduler/job/7687060#L23314

Few more logs related to build artifacts links provided in the original
email thread and bottom of this email.

crash log:
---

[ 0.000000] Booting Linux on physical CPU 0x0000000100 [0x410fd033]
[ 0.000000] Linux version 6.9.6-rc1 (tuxmake@tuxmake)
(aarch64-linux-gnu-gcc (Debian 13.2.0-12) 13.2.0, GNU ld (GNU Binutils
for Debian) 2.42) #1 SMP PREEMPT @1718817000
...
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


1)
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.5-282-g93f303762da5/testrun/24410131/suite/log-parser-test/test/check-kernel-panic/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.5-282-g93f303762da5/testrun/24410131/suite/log-parser-test/test/check-kernel-panic-a44367e5836148d6e94412d6de8ab7a0ca37c18d2bfb6a639947ecd2704ad6b1/details/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2i6h1Ah6I8CP7ABUzTl9shfaW60
 - https://lkft.validation.linaro.org/scheduler/job/7687060#L23314

- Naresh

>
> --
> Cheers,
>
> David / dhildenb
>

