Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B55723441B
	for <lists+cgroups@lfdr.de>; Fri, 31 Jul 2020 12:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbgGaKca (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 Jul 2020 06:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732487AbgGaKc3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 31 Jul 2020 06:32:29 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFEAC06174A
        for <cgroups@vger.kernel.org>; Fri, 31 Jul 2020 03:32:29 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y8so9217737vsq.8
        for <cgroups@vger.kernel.org>; Fri, 31 Jul 2020 03:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KtukYjoQzTo5Uawi1f9Z99wCqsvjvWIajPsIH/DMHxU=;
        b=Q9Gcpkb5/eDR2SCmKCxJFkRRneqgHXzgwpHaiC7GWF4iEP8Hx99StpyuOhd0dj5umY
         CZREIEd0I9h57Hp+/QlV+inw0qI0V995N1w/5zYQV4TyKPoXscLxtOnnD0QQPDLpoQ8K
         VtGf3Z2neeDdthloHxs6ZHqoeFW3MXnEDY9k8IsnEkfQ8oQ9vw+/DWcFoT5bzEBcQcuo
         7K7gnnvg061qPpfIIkI9+3jRLLOXyDeCY4eBfVlSR9rEVqcfIjAL1ipVQ1SjtDR/WJsV
         sChcwGQatRfxGeFLNvNW+LCPNkjzYbPrOzJnTWS3IDL7WNBEUsF0r8Pb7ERJIEF3hrtc
         uCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KtukYjoQzTo5Uawi1f9Z99wCqsvjvWIajPsIH/DMHxU=;
        b=UHtxz6k68i9jdfYffGdPXJo0EwWvXyJBlA8T+k5m5huszoPWiA+09bFeQL0AOpyIek
         MFEvw5NNDx87e6xQiHTuDm8lSIlMUwL4fdFyUBBeLzId28v2qradP2FMQB7Y/IKpADC4
         Lj0XeUViG4igVxRDb8jpe00OgVqVaSsYkQXoVj+6hqGHumAxG4aRlSN25vEUgHI1mfXj
         GBCf8CfORgtj+NFReHZ4uWazgytlYqPFiszVkhwJVn0RvjGuKRqglsnykdK5X7q9xJWf
         FCjAa/Vf+r8WGolv7kQ39UhD+9DHSAhdCIvdb74PMCQaFg0JZj+Vz0dcet6ZxZcGJ24j
         ox7w==
X-Gm-Message-State: AOAM530nB8a2jyjYysZAi5s52mEydO6GATVyaoVCIyGdFsVwBCNaNjL/
        tMeYQjx49qx17tvfniZZ6vuXoQ+pi5pQfJAObItuEg==
X-Google-Smtp-Source: ABdhPJyjS3cHbdoEG+p1LSSdBqLLwHM10icJxLwEmHYWwEL7lQoQGqFzSuaT2pyDBdP2sObaHEGXBb2VKhKyLX1Vzv0=
X-Received: by 2002:a67:f70c:: with SMTP id m12mr981520vso.238.1596191547952;
 Fri, 31 Jul 2020 03:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200730074420.502923740@linuxfoundation.org>
In-Reply-To: <20200730074420.502923740@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 31 Jul 2020 16:02:16 +0530
Message-ID: <CA+G9fYvCPwwmF-k=Z9Z6P2KYrOMHurcORwa3RW2H1j6pq1QEDg@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/19] 5.4.55-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-mm <linux-mm@kvack.org>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 30 Jul 2020 at 13:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.55 release.
> There are 19 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Aug 2020 07:44:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.55-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Regressions on arm64 Juno-r2 device running LTP controllers-tests

CONFIG_ARM64_64K_PAGES=3Dy

Unable to handle kernel paging request at virtual address dead000000000108
[dead000000000108] address between user and kernel address ranges
Internal error: Oops: 96000044 [#1] PREEMPT SMP

pc : get_page_from_freelist+0xa64/0x1030
lr : get_page_from_freelist+0x9c4/0x1030

We are trying to reproduce this kernel panic and trying to narrow down to
specific test cases.

Summary
------------------------------------------------------------------------

kernel: 5.4.55-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 6666ca784e9e47288180a15935061d88debc9e4b
git describe: v5.4.54-20-g6666ca784e9e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.54-20-g6666ca784e9e

arm64 kernel config and details:
config: https://builds.tuxbuild.com/iIsSV-1_WtyDUTe88iKaqw/kernel.config
vmlinux: https://builds.tuxbuild.com/iIsSV-1_WtyDUTe88iKaqw/vmlinux.xz
System.map: https://builds.tuxbuild.com/iIsSV-1_WtyDUTe88iKaqw/System.map

steps to reproduce:
- boot juno-r2 with 64k page size config
- run ltp controllers
  # cd /opt/ltp
  # ./runltp -f controllers

memcg_process: shmget() failed: Invalid argument
[  248.372285] Unable to handle kernel paging request at virtual
address dead000000000108
[  248.380223] Mem abort info:
[  248.383015]   ESR =3D 0x96000044
[  248.386071]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  248.391387]   SET =3D 0, FnV =3D 0
[  248.394440]   EA =3D 0, S1PTW =3D 0
[  248.397580] Data abort info:
[  248.400460]   ISV =3D 0, ISS =3D 0x00000044
[  248.404296]   CM =3D 0, WnR =3D 1
[  248.407264] [dead000000000108] address between user and kernel address r=
anges
[  248.414410] Internal error: Oops: 96000044 [#1] PREEMPT SMP
[  248.419989] Modules linked in: tda998x drm_kms_helper drm crct10dif_ce f=
use
[  248.426975] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.55-rc1 #1
[  248.433249] Hardware name: ARM Juno development board (r2) (DT)
[  248.439178] pstate: a0000085 (NzCv daIf -PAN -UAO)
[  248.443984] pc : get_page_from_freelist+0xa64/0x1030
[  248.448955] lr : get_page_from_freelist+0x9c4/0x1030
[  248.453923] sp : ffff80001000fbb0
[  248.457238] x29: ffff80001000fbb0 x28: ffff00097fdbfe48
[  248.462557] x27: 0000000000000010 x26: 0000000000000000
[  248.467877] x25: ffff00097feabdc0 x24: 0000000000000000
[  248.473196] x23: 0000000000000000 x22: 0000000000000000
[  248.478515] x21: 0000fff680154180 x20: ffff00097fdbfe38
[  248.483835] x19: 0000000000000000 x18: 0000000000000000
[  248.489154] x17: 0000000000000000 x16: 0000000000000000
[  248.494473] x15: 0000000000000000 x14: 0000000000000000
[  248.499792] x13: 0000000000000000 x12: 0000000034d4d91d
[  248.505111] x11: 0000000000000000 x10: 0000000000000000
[  248.510430] x9 : ffff80096e790000 x8 : ffffffffffffff40
[  248.515749] x7 : 0000000000000000 x6 : ffffffe002308b48
[  248.521068] x5 : ffff00097fdbfe38 x4 : dead000000000100
[  248.526387] x3 : 0000000000000000 x2 : 0000000000000000
[  248.531706] x1 : 0000000000000000 x0 : ffffffe002308b40
[  248.537026] Call trace:
[  248.539475]  get_page_from_freelist+0xa64/0x1030
[  248.544099]  __alloc_pages_nodemask+0x144/0x280
[  248.548635]  page_frag_alloc+0x70/0x140
[  248.552479]  __netdev_alloc_skb+0x158/0x188
[  248.556667]  smsc911x_poll+0x90/0x268
[  248.560342]  net_rx_action+0x114/0x340
[  248.564096]  __do_softirq+0x120/0x25c
[  248.567766]  irq_exit+0xb8/0xd8
[  248.570910]  __handle_domain_irq+0x64/0xb8
[  248.575010]  gic_handle_irq+0x50/0xa8
[  248.578675]  el1_irq+0xb8/0x180
[  248.581820]  tick_check_broadcast_expired+0x34/0x40
[  248.586705]  do_idle+0x8c/0x280
[  248.589848]  cpu_startup_entry+0x20/0x80
[  248.593777]  rest_init+0xd4/0xe0
[  248.597010]  arch_call_rest_init+0xc/0x14
[  248.601024]  start_kernel+0x418/0x44c
[  248.604693] Code: 54000a00 f10020c0 540009c0 a9400cc4 (f9000483)
[  248.610803] ---[ end trace 358f513e280e4dfd ]---
[  248.615426] Kernel panic - not syncing: Fatal exception in interrupt
[  248.621789] SMP: stopping secondary CPUs
[  249.740564] SMP: failed to stop secondary CPUs 0-2
[  249.745359] Kernel Offset: disabled
[  249.748849] CPU features: 0x0002,24006000
[  249.752859] Memory Limit: none
[  249.755921] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---


--
Linaro LKFT
https://lkft.linaro.org
