Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 908BD1616EC
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2020 17:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgBQQDK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Feb 2020 11:03:10 -0500
Received: from mail.efficios.com ([167.114.26.124]:44718 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgBQQDJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Feb 2020 11:03:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5D610246CD6;
        Mon, 17 Feb 2020 11:03:08 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id e0lvVQGs2aMn; Mon, 17 Feb 2020 11:03:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 050D6246CD2;
        Mon, 17 Feb 2020 11:03:08 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 050D6246CD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1581955388;
        bh=ItetYfhyUN3Od1AdIKdi+P2SdF7YtthR2OI+B/myaSg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=LhaTpr8BYveOuIvueX4LsWIFOh7NNIGwzdgqHJlB/zVleyL1Yq+WK2EQ0hGrvkNCr
         GsHA058KjlCcv4mLuUpNiJbLhWT0gGVdKz0LLQ03k6iIYp1xAAQpEQQ3n3b1Zveed0
         x6GEbP9PqmxWxcpjngKkESyuehj2aPHE6626f1BKIB9LGTOYnG2sLx81Yci1g23HsM
         iUeS/S8MQ39/JoDFKW4x64yqmiRgMCSxdc5kotXu5C3oN3GnV4WtmuDAruGuPZqC7a
         v1JHihpoewGyMKQoaChVdOu9jujOmCoUk1d71pct0a5U9jpfYTRWzoWA9Xlu2bLbPt
         uh9KJV1vXVuVQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TFmX5MCKtcDj; Mon, 17 Feb 2020 11:03:07 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E3762246D23;
        Mon, 17 Feb 2020 11:03:07 -0500 (EST)
Date:   Mon, 17 Feb 2020 11:03:07 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <1317969050.4131.1581955387909.JavaMail.zimbra@efficios.com>
In-Reply-To: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com>
References: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com>
Subject: Re: [regression] cpuset: offlined CPUs removed from affinity masks
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3899 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: cpuset: offlined CPUs removed from affinity masks
Thread-Index: LCpgHYsKGbsNKD4rV33Ft2KJ/GZob0k9f2Q3
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

Adding Tejun and the cgroups mailing list in CC for this cpuset regression I
reported last month.

Thanks,

Mathieu

----- On Jan 16, 2020, at 12:41 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Hi,
> 
> I noticed the following regression with CONFIG_CPUSET=y. Note that
> I am not using cpusets at all (only using the root cpuset I'm given
> at boot), it's just configured in. I am currently working on a 5.2.5
> kernel. I am simply combining use of taskset(1) (setting the affinity
> mask of a process) and cpu hotplug. The result is that with
> CONFIG_CPUSET=y, setting the affinity mask including an offline CPU number
> don't keep that CPU in the affinity mask, and it is never put back when the
> CPU comes back online. CONFIG_CPUSET=n behaves as expected, and puts back
> the CPU into the affinity mask reported to user-space when it comes back
> online.
> 
> 
> * With CONFIG_CPUSET=y (unexpected behavior):
> 
> # echo 0 > /sys/devices/system/cpu/cpu1/online
> 
> % taskset 0x7 ./loop &
> % taskset -p $!
> pid 1341's current affinity mask: 5
> 
> # echo 1 > /sys/devices/system/cpu/cpu1/online
> 
> taskset -p $!
> pid 1341's current affinity mask: 5
> 
> kill $!
> 
> 
> * With CONFIG_CPUSET=n (expected behavior):
> 
> (Offlining CPU, then start task)
> 
> # echo 0 > /sys/devices/system/cpu/cpu1/online
> 
> % taskset 0x7 ./loop &
> % taskset -p $!
> pid 1358's current affinity mask: 5
> 
> # echo 1 > /sys/devices/system/cpu/cpu1/online
> 
> taskset -p $!
> pid 1358's current affinity mask: 7
> 
> kill $!
> 
> 
> Test system lscpu output:
> 
> Architecture:        x86_64
> CPU op-mode(s):      32-bit, 64-bit
> Byte Order:          Little Endian
> CPU(s):              32
> On-line CPU(s) list: 0-31
> Thread(s) per core:  2
> Core(s) per socket:  8
> Socket(s):           2
> NUMA node(s):        2
> Vendor ID:           GenuineIntel
> CPU family:          6
> Model:               60
> Model name:          Intel Core Processor (Haswell, no TSX, IBRS)
> Stepping:            1
> CPU MHz:             2399.996
> BogoMIPS:            4799.99
> Hypervisor vendor:   KVM
> Virtualization type: full
> L1d cache:           32K
> L1i cache:           32K
> L2 cache:            4096K
> NUMA node0 CPU(s):   0-7,16-23
> NUMA node1 CPU(s):   8-15,24-31
> Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc
> rep_good nopl cpuid tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1
> sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
> hypervisor lahf_lm abm cpuid_fault invpcid_single pti ibrs ibpb fsgsbase bmi1
> avx2 smep bmi2 erms invpcid xsaveopt
> 
> 
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
