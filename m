Return-Path: <cgroups+bounces-6567-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF92A388E4
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2025 17:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E861886E64
	for <lists+cgroups@lfdr.de>; Mon, 17 Feb 2025 16:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5240A224B11;
	Mon, 17 Feb 2025 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/hfgcnQ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1553E499
	for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739808494; cv=none; b=BvYo60FKOW4PyjZCphAa4Hs9zry6tE4T//MlixDeZCC0C2Zvazfk/m/JVRTWAiOJ5ZikETz0A1H1EBsOypxlW83l+r5inZO8CCwEuE0RnpcDNrql+XhcUPO6hfw5V48US2huub7L71t0AGA5fqK9zExjSYvDAFlWOzrrvkLx2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739808494; c=relaxed/simple;
	bh=ySeYOXvSmxXWBW8hwEKrkTOnEX7P+1Uag8mJjwfcNWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5Ax++wEcKnmuuRG6jq9qmDYBbEMoBbMQJmD3y8mAvCvEFbFOk5jWmzzPMuI21mcAaIRYWrJlxDevrLT3QZOG8n4GCwsr9Cz8qoFEMlQ8/sBpUQ+CVIzteNLBiU8VA25DAuNlQQUEk1KIIG12xQAA6r3CzNgfIzrE1vVtcHuA6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/hfgcnQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739808490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijgLY9uzQsTOV54jeSKZ09Sq5iqd7soRtArc06yi5m0=;
	b=E/hfgcnQUOtglFEF7Kv2fYOAJi4yzLGzvJ5+hlbiJhna97MECCIJM6HgNY9mjTsLFYXcuY
	fpqMM9g9R8ffxS1ayJ7VMK9QqPjjEckXXT8FK2LnERFGmQzFTvQ02CR7OctSKSR5/w/BiH
	/WMK52QlxKYpsu2jyf2FUzw76YnjzcU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-oC65XfT0Mbq7zfbTW7e-wQ-1; Mon, 17 Feb 2025 11:08:08 -0500
X-MC-Unique: oC65XfT0Mbq7zfbTW7e-wQ-1
X-Mimecast-MFC-AGG-ID: oC65XfT0Mbq7zfbTW7e-wQ_1739808487
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f4bf0d5faso431056f8f.0
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 08:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739808487; x=1740413287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijgLY9uzQsTOV54jeSKZ09Sq5iqd7soRtArc06yi5m0=;
        b=HE3Wcdvj8xKzjXl0SpoCTsfIAldd0DtgQ2vtPDKoGTFhh7j6dSqEX7eXMkGL8bwT+A
         t2Fq0PPTkeVdB5bi3GtLlMhCJU5/rq9xsFqkr034VelucfOQDNldTN0eaxSdXcErHyPo
         jcWSaO4uV4wlJP09p0iDxEbZhj8rWmcLz0JW2tMKDESHkvVgpSliQpZB0EPyJOEFKsPc
         aBT55dZ+njGPkmNYeUkTp6DOoxxh3iFOMmJc+7BY9xSBOgBbqf2Dmqq5nw4cSCpHLqCK
         O5eMXkAlj9cY7EHhTp44nsYq34bm2eTvX2fWvIAvNMLuS1Hep5MSALBnY5m93Nkz9iKl
         isWg==
X-Forwarded-Encrypted: i=1; AJvYcCVpgZSKsGQ7BM5KpWNREba+dFp07bYIgvaJdbfKHYTfTs/CHYborQtlXLC+qM5Wx7jTERIv3+yN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29xC+/Vu3nCe9VaSsQ2t0Re/tHHUsWshfmQF4DoP2klrLf2Wk
	G6wFPNOiR2u4i3L385bURL2nCrUnWe8xczWErfWNzMBZIIvPRytrgusLcqAtBBFPgm+yRoBKuZX
	4saPHqSJh7d5UHrRwkHafpD6SCmf6IhvhvLIjDeED1puq9OFUAkbUWuM=
X-Gm-Gg: ASbGncsSLHN5pHMyrdSjtNsvtY1EBbux2yo9E5gMi8myWTCzEss5A26wIa0uNqAPrzz
	DWn0/UjGCQcnJ4dtxSYGDW3MrSGcQrsja6h+JCWzQTW0LWR2n8muMUlzMARS1/6QzDsJ96pWlYL
	Whv4fQB4OHFsh4EMoLIO3t8EFUePMO+u6kKd9HXbwMsJy/4/GD6W8LuzL2UVISHtHlbW8sB3ZqA
	SB+PCWsVe/1+zOZxrvfqRQO35LC54Zj0WSKz9s0xMvxIEWrLWvNw0ssK7MIrLVw6nw213a5+Ci/
	85N4objklFUFA0NsxYgn5VV4PnsWcy1Xzg==
X-Received: by 2002:a5d:6d8c:0:b0:38f:36c7:b068 with SMTP id ffacd0b85a97d-38f36c80576mr8466208f8f.50.1739808486966;
        Mon, 17 Feb 2025 08:08:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxmTVvzhb7H3nRIpAmhvz5XR8Yr6/ssUwzzXzNF+D7sgC1o57tXE2NC7Vm3fB+nE+SrjlqVw==
X-Received: by 2002:a5d:6d8c:0:b0:38f:36c7:b068 with SMTP id ffacd0b85a97d-38f36c80576mr8466101f8f.50.1739808486122;
        Mon, 17 Feb 2025 08:08:06 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25913f5asm12800221f8f.52.2025.02.17.08.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:08:05 -0800 (PST)
Date: Mon, 17 Feb 2025 17:08:03 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Thierry Reding <treding@nvidia.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
Message-ID: <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
References: <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
 <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <78f627fe-dd1e-4816-bbf3-58137fdceda6@nvidia.com>
 <Z62ONLX4OLisCLKw@jlelli-thinkpadt14gen4.remote.csb>
 <30a8cda5-0fd0-4e47-bafe-5deefc561f0c@nvidia.com>
 <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>

On 14/02/25 10:05, Jon Hunter wrote:

...

> Sorry for the delay, the day got away from me. However, it is still not
> working :-(

Ouch.

> Console log is attached.

Thanks. Did you happen to also collect a corresponding trace?

> 
> Jon
> 
> -- 
> nvpublic

> U-Boot 2020.04-g6b630d64fd (Feb 19 2021 - 08:38:59 -0800)
> 
> SoC: tegra186
> Model: NVIDIA P2771-0000-500
> Board: NVIDIA P2771-0000
> DRAM:  7.8 GiB
> MMC:   sdhci@3400000: 1, sdhci@3460000: 0
> Loading Environment from MMC... *** Warning - bad CRC, using default environment
> 
> In:    serial
> Out:   serial
> Err:   serial
> Net:   
> Warning: ethernet@2490000 using MAC address from ROM
> eth0: ethernet@2490000
> Hit any key to stop autoboot:  2  1  0 
> MMC: no card present
> switch to partitions #0, OK
> mmc0(part 0) is current device
> Scanning mmc 0:1...
> Found /boot/extlinux/extlinux.conf
> Retrieving file: /boot/extlinux/extlinux.conf
> 489 bytes read in 17 ms (27.3 KiB/s)
> 1:	primary kernel
> Retrieving file: /boot/initrd
> 7236840 bytes read in 187 ms (36.9 MiB/s)
> Retrieving file: /boot/Image
> 47976960 bytes read in 1147 ms (39.9 MiB/s)
> append: earlycon console=ttyS0,115200n8 fw_devlink=on root=/dev/nfs rw netdevwait ip=192.168.99.2:192.168.99.1:192.168.99.1:255.255.255.0::eth0:off nfsroot=192.168.99.1:/home/ausvrl81104/nfsroot sched_verbose ignore_loglevel console=ttyS0,115200n8 console=tty0 fbcon=map:0 net.ifnames=0 isolcpus=1-2  video=tegrafb no_console_suspend=1 nvdumper_reserved=0x2772e0000 gpt rootfs.slot_suffix= usbcore.old_scheme_first=1 tegraid=18.1.2.0.0 maxcpus=6 boot.slot_suffix= boot.ratchetvalues=0.2031647.1 vpr_resize bl_prof_dataptr=0x10000@0x275840000 sdhci_tegra.en_boot_part_access=1 no_console_suspend root=/dev/nfs rw netdevwait ip=192.168.99.2:192.168.99.1:192.168.99.1:255.255.255.0::eth0:off nfsroot=192.168.99.1:/home/ausvrl81104/nfsroot sched_verbose ignore_loglevel console=ttyS0,115200n8 console=tty0 fbcon=map:0 net.ifnames=0 isolcpus=1-2 
> Retrieving file: /boot/dtb/tegra186-p2771-0000.dtb
> 108349 bytes read in 21 ms (4.9 MiB/s)
> ## Flattened Device Tree blob at 88400000
>    Booting using the fdt blob at 0x88400000
>    Using Device Tree in place at 0000000088400000, end 000000008841d73c
> copying carveout for /host1x@13e00000/display-hub@15200000/display@15200000...
> copying carveout for /host1x@13e00000/display-hub@15200000/display@15210000...
> copying carveout for /host1x@13e00000/display-hub@15200000/display@15220000...
> DT node /trusty missing in source; can't copy status
> DT node /reserved-memory/fb0_carveout missing in source; can't copy
> DT node /reserved-memory/fb1_carveout missing in source; can't copy
> DT node /reserved-memory/fb2_carveout missing in source; can't copy
> DT node /reserved-memory/ramoops_carveout missing in source; can't copy
> DT node /reserved-memory/vpr-carveout missing in source; can't copy
> 
> Starting kernel ...
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000100 [0x411fd073]
> [    0.000000] Linux version 6.13.0-rc6-next-20250110-00006-g8af20d375c86 (jonathanh@goldfinger) (aarch64-linux-gcc.br_real (Buildroot 2022.08) 11.3.0, GNU ld (GNU Binutils) 2.38) #2 SMP PREEMPT Fri Feb 14 01:41:10 PST 2025

> [    0.000000] rq_attach_root: cpu=0 old_span=NULL new_span=
> [    0.000000] rq_attach_root: cpu=1 old_span=NULL new_span=0
> [    0.000000] rq_attach_root: cpu=2 old_span=NULL new_span=0-1
> [    0.000000] rq_attach_root: cpu=3 old_span=NULL new_span=0-2
> [    0.000000] rq_attach_root: cpu=4 old_span=NULL new_span=0-3
> [    0.000000] rq_attach_root: cpu=5 old_span=NULL new_span=0-4

> [    0.000000] rq_attach_root: cpu=0 old_span=NULL new_span=
> [    0.000000] rq_attach_root: cpu=1 old_span=NULL new_span=0
> [    0.000000] rq_attach_root: cpu=2 old_span=NULL new_span=0-1
> [    0.000000] rq_attach_root: cpu=3 old_span=NULL new_span=0-2
> [    0.000000] rq_attach_root: cpu=4 old_span=NULL new_span=0-3
> [    0.000000] rq_attach_root: cpu=5 old_span=NULL new_span=0-4

> [    0.024665] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=0-5 type=DEF

> [    0.039973] smp: Bringing up secondary CPUs ...

> [    0.049237] CPU1: Booted secondary processor 0x0000000000 [0x4e0f0030]
> [    0.049311] __dl_add: cpus=1 tsk_bw=52428 total_bw=104856 span=0-5 type=DEF

> [    0.060738] CPU2: Booted secondary processor 0x0000000001 [0x4e0f0030]
> [    0.060792] __dl_add: cpus=2 tsk_bw=52428 total_bw=157284 span=0-5 type=DEF
> [    0.068381] Detected PIPT I-cache on CPU3
> [    0.068475] CPU3: Booted secondary processor 0x0000000101 [0x411fd073]
> [    0.068501] __dl_add: cpus=3 tsk_bw=52428 total_bw=209712 span=0-5 type=DEF
> [    0.076341] Detected PIPT I-cache on CPU4
> [    0.076406] CPU4: Booted secondary processor 0x0000000102 [0x411fd073]
> [    0.076430] __dl_add: cpus=4 tsk_bw=52428 total_bw=262140 span=0-5 type=DEF
> [    0.076974] Detected PIPT I-cache on CPU5
> [    0.077039] CPU5: Booted secondary processor 0x0000000103 [0x411fd073]
> [    0.077064] __dl_add: cpus=5 tsk_bw=52428 total_bw=314568 span=0-5 type=DEF
> [    0.077141] smp: Brought up 1 node, 6 CPUs
> [    0.077177] SMP: Total of 6 processors activated.
> [    0.077184] CPU: All CPU(s) started at EL2
> [    0.077196] CPU features: detected: 32-bit EL0 Support
> [    0.077203] CPU features: detected: 32-bit EL1 Support
> [    0.077211] CPU features: detected: CRC32 instructions
> [    0.077300] alternatives: applying system-wide alternatives
> [    0.085706] CPU0 attaching sched-domain(s):
> [    0.085726]  domain-0: span=0,3-5 level=MC
> [    0.085741]   groups: 0:{ span=0 cap=1020 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }
> [    0.085782] __dl_sub: cpus=6 tsk_bw=52428 total_bw=262140 span=0-5 type=DEF
> [    0.085789] __dl_server_detach_root: cpu=0 rd_span=0-5 total_bw=262140
> [    0.085796] rq_attach_root: cpu=0 old_span=NULL new_span=
> [    0.085801] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=0 type=DYN
> [    0.085805] __dl_server_attach_root: cpu=0 rd_span=0 total_bw=52428
> [    0.085809] CPU3 attaching sched-domain(s):
> [    0.085836]  domain-0: span=0,3-5 level=MC
> [    0.085846]   groups: 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 cap=1020 }
> [    0.085885] __dl_sub: cpus=5 tsk_bw=52428 total_bw=209712 span=1-5 type=DEF
> [    0.085889] __dl_server_detach_root: cpu=3 rd_span=1-5 total_bw=209712
> [    0.085894] rq_attach_root: cpu=3 old_span=NULL new_span=0
> [    0.085897] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=0,3 type=DYN
> [    0.085900] __dl_server_attach_root: cpu=3 rd_span=0,3 total_bw=104856
> [    0.085904] CPU4 attaching sched-domain(s):
> [    0.085930]  domain-0: span=0,3-5 level=MC
> [    0.085940]   groups: 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 cap=1020 }, 3:{ span=3 }
> [    0.085977] __dl_sub: cpus=4 tsk_bw=52428 total_bw=157284 span=1-2,4-5 type=DEF
> [    0.085981] __dl_server_detach_root: cpu=4 rd_span=1-2,4-5 total_bw=157284
> [    0.085985] rq_attach_root: cpu=4 old_span=NULL new_span=0,3
> [    0.085989] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0,3-4 type=DYN
> [    0.085993] __dl_server_attach_root: cpu=4 rd_span=0,3-4 total_bw=157284
> [    0.085996] CPU5 attaching sched-domain(s):
> [    0.086023]  domain-0: span=0,3-5 level=MC
> [    0.086033]   groups: 5:{ span=5 }, 0:{ span=0 cap=1020 }, 3:{ span=3 }, 4:{ span=4 }
> [    0.086070] __dl_sub: cpus=3 tsk_bw=52428 total_bw=104856 span=1-2,5 type=DEF
> [    0.086075] __dl_server_detach_root: cpu=5 rd_span=1-2,5 total_bw=104856
> [    0.086079] rq_attach_root: cpu=5 old_span=NULL new_span=0,3-4
> [    0.086082] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0,3-5 type=DYN
> [    0.086085] __dl_server_attach_root: cpu=5 rd_span=0,3-5 total_bw=209712
> [    0.086089] root domain span: 0,3-5
> [    0.086114] default domain span: 1-2

> [    4.717856] cpufreq: cpufreq_online: CPU0: Running at unlisted initial frequency: 1344000 kHz, changing to: 1382400 kHz
> [    4.728789] dl_clear_root_domain: span=0,3-5 type=DYN
> [    4.728796] __dl_add: cpus=4 tsk_bw=52428 total_bw=52428 span=0,3-5 type=DYN
> [    4.728802] __dl_add: cpus=4 tsk_bw=52428 total_bw=104856 span=0,3-5 type=DYN
> [    4.728806] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> [    4.728810] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0,3-5 type=DYN
> [    4.728815] rd 0,3-5: Checking EAS, CPUs do not have asymmetric capacities
> [    4.769218] dl_clear_root_domain: span=1-2 type=DEF
> [    4.769222] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=1-2 type=DEF
> [    4.769227] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=1-2 type=DEF
> [    4.769301] __dl_sub: cpus=4 tsk_bw=104857 total_bw=104855 span=0,3-5 type=DYN

Not sure where this dl_sub is coming from. The stacktrace in the trace
should probably tell. tsk_bw looks similar to sugov, so maybe still a
missing spot where we should ignore that?

> [    4.769377] dl_clear_root_domain: span=0,3-5 type=DYN
> [    4.769382] __dl_add: cpus=4 tsk_bw=52428 total_bw=52428 span=0,3-5 type=DYN
> [    4.769387] __dl_add: cpus=4 tsk_bw=52428 total_bw=104856 span=0,3-5 type=DYN
> [    4.769392] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> [    4.769396] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0,3-5 type=DYN
> [    4.769400] rd 0,3-5: Checking EAS, CPUs do not have asymmetric capacities
> [    4.835665] dl_clear_root_domain: span=1-2 type=DEF
> [    4.835669] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=1-2 type=DEF
> [    4.835673] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=1-2 type=DEF
> [    4.835733] __dl_sub: cpus=4 tsk_bw=104857 total_bw=104855 span=0,3-5 type=DYN
> [    4.835784] cpufreq: cpufreq_online: CPU3: Running at unlisted initial frequency: 1344000 kHz, changing to: 1382400 kHz
> [    4.872499] dl_clear_root_domain: span=0,3-5 type=DYN
> [    4.872504] __dl_add: cpus=4 tsk_bw=52428 total_bw=52428 span=0,3-5 type=DYN
> [    4.872509] __dl_add: cpus=4 tsk_bw=52428 total_bw=104856 span=0,3-5 type=DYN
> [    4.872513] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> [    4.872517] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0,3-5 type=DYN
> [    4.872521] rd 0,3-5: Checking EAS, CPUs do not have asymmetric capacities
> [    4.912870] dl_clear_root_domain: span=1-2 type=DEF
> [    4.912874] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=1-2 type=DEF
> [    4.912879] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=1-2 type=DEF
> [    4.912973] cpufreq: cpufreq_online: CPU4: Running at unlisted initial frequency: 1344000 kHz, changing to: 1382400 kHz
> [    4.942474] dl_clear_root_domain: span=0,3-5 type=DYN
> [    4.942478] __dl_add: cpus=4 tsk_bw=52428 total_bw=52428 span=0,3-5 type=DYN
> [    4.942483] __dl_add: cpus=4 tsk_bw=52428 total_bw=104856 span=0,3-5 type=DYN
> [    4.942487] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> [    4.942491] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0,3-5 type=DYN
> [    4.942495] rd 0,3-5: Checking EAS, CPUs do not have asymmetric capacities
> [    4.982819] dl_clear_root_domain: span=1-2 type=DEF
> [    4.982821] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=1-2 type=DEF
> [    4.982824] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=1-2 type=DEF
> [    4.982889] cpufreq: cpufreq_online: CPU5: Running at unlisted initial frequency: 1344000 kHz, changing to: 1382400 kHz
> [    5.012384] dl_clear_root_domain: span=0,3-5 type=DYN
> [    5.012388] __dl_add: cpus=4 tsk_bw=52428 total_bw=52428 span=0,3-5 type=DYN
> [    5.012393] __dl_add: cpus=4 tsk_bw=52428 total_bw=104856 span=0,3-5 type=DYN
> [    5.012397] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> [    5.012401] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0,3-5 type=DYN
> [    5.012405] rd 0,3-5: Checking EAS, CPUs do not have asymmetric capacities
> [    5.052728] dl_clear_root_domain: span=1-2 type=DEF
> [    5.052730] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=1-2 type=DEF
> [    5.052733] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=1-2 type=DEF
> [    5.054374] dl_clear_root_domain: span=0,3-5 type=DYN
> [    5.054380] __dl_add: cpus=4 tsk_bw=52428 total_bw=52428 span=0,3-5 type=DYN
> [    5.054383] __dl_add: cpus=4 tsk_bw=52428 total_bw=104856 span=0,3-5 type=DYN
> [    5.054386] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> [    5.054389] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0,3-5 type=DYN
> [    5.054392] rd 0,3-5: Checking EAS, CPUs do not have asymmetric capacities
> [    5.060615] sdhci-tegra 3440000.mmc: Adding to iommu group 4
> [    5.066085] dl_clear_root_domain: span=1-2 type=DEF
> [    5.066090] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=1-2 type=DEF
> [    5.066092] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=1-2 type=DEF

Wonder what is triggering the below rebuild now that cpufreq should be
up and running. Again trace data should hopefully tell.

> [   16.698922] dl_clear_root_domain: span=0,3-5 type=DYN
> [   16.698933] __dl_add: cpus=4 tsk_bw=52428 total_bw=52428 span=0,3-5 type=DYN
> [   16.698941] __dl_add: cpus=4 tsk_bw=52428 total_bw=104856 span=0,3-5 type=DYN
> [   16.698946] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> [   16.698951] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0,3-5 type=DYN
> [   16.698956] rd 0,3-5: Checking EAS, CPUs do not have asymmetric capacities
> [   16.739375] dl_clear_root_domain: span=1-2 type=DEF
> [   16.739382] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=1-2 type=DEF
> [   16.739386] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=1-2 type=DEF
> [   16.758528] dl_clear_root_domain: span=0,3-5 type=DYN
> [   16.758536] __dl_add: cpus=4 tsk_bw=52428 total_bw=52428 span=0,3-5 type=DYN
> [   16.758541] __dl_add: cpus=4 tsk_bw=52428 total_bw=104856 span=0,3-5 type=DYN
> [   16.758544] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> [   16.758548] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0,3-5 type=DYN
> [   16.758551] rd 0,3-5: Checking EAS, CPUs do not have asymmetric capacities
> [   16.799668] dl_clear_root_domain: span=1-2 type=DEF
> [   16.799676] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=1-2 type=DEF
> [   16.799680] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=1-2 type=DEF
> [   16.814674] dl_clear_root_domain: span=0,3-5 type=DYN
> [   16.814681] __dl_add: cpus=4 tsk_bw=52428 total_bw=52428 span=0,3-5 type=DYN
> [   16.814686] __dl_add: cpus=4 tsk_bw=52428 total_bw=104856 span=0,3-5 type=DYN
> [   16.814689] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> [   16.814692] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0,3-5 type=DYN
> [   16.814696] rd 0,3-5: Checking EAS, CPUs do not have asymmetric capacities
> [   16.860445] dl_clear_root_domain: span=1-2 type=DEF
> [   16.860450] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=1-2 type=DEF
> [   16.860454] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=1-2 type=DEF
> Welcome to Ubuntu 18.04.6 LTS (GNU/Linux[   16.879557] dl_clear_root_domain: span=0,3-5 type=DYN
>  6.13.0-rc6-next-20250110-00006-[   16.879564] __dl_add: cpus=4 tsk_bw=52428 total_bw=52428 span=0,3-5 type=DYN
> g8af20d375c86 aarch64)
> 
>  * Doc[   16.879569] __dl_add: cpus=4 tsk_bw=52428 total_bw=104856 span=0,3-5 type=DYN
> umentation:  https://help.ubuntu[   16.879572] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> .com
>  * Management:    [   16.879575] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0,3-5 type=DYN
>  https://landsca[   16.879578] rd 0,3-5: Checking EAS, CPUs do not have asymmetric capacities
> pe.canonical.com
>  * Support:        https://ubuntu.com/pro
> This system[   16.934775] dl_clear_root_domain: span=1-2 type=DEF
> [   16.934781] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=1-2 type=DEF
> [   16.934784] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=1-2 type=DEF
>  has been minimized by removing packages[   16.959842] dl_clear_root_domain: span=0,3-5 type=DYN
>  and content that are
> not requi[   16.959853] __dl_add: cpus=4 tsk_bw=52428 total_bw=52428 span=0,3-5 type=DYN
> red on a system that users do no[   16.959861] __dl_add: cpus=4 tsk_bw=52428 total_bw=104856 span=0,3-5 type=DYN
> t log into.
> 
> To restor[   16.959868] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> e this content, [   16.959873] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0,3-5 type=DYN
> you can run the [   16.959879] rd 0,3-5: Checking EAS, CPUs do not have asymmetric capacities
> 'unminimize' command.
> 
> The programs in[   17.013809] dl_clear_root_domain: span=1-2 type=DEF
> cluded w[   17.013817] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=1-2 type=DEF
> ith the [   17.013822] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=1-2 type=DEF
> Ubuntu system are free software;[   17.026473] dl_clear_root_domain: span=0,3-5 type=DYN
> 
> the exact distribution[   17.026480] __dl_add: cpus=4 tsk_bw=52428 total_bw=52428 span=0,3-5 type=DYN
>  terms for each [   17.026485] __dl_add: cpus=4 tsk_bw=52428 total_bw=104856 span=0,3-5 type=DYN
> program are desc[   17.026488] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> ribed in the
> in[   17.026491] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0,3-5 type=DYN
> dividual files i[   17.026495] rd 0,3-5: Checking EAS, CPUs do not have asymmetric capacities
> n /usr/share/doc/*/copyright.
> 
> Ubuntu [   17.088060] dl_clear_root_domain: span=1-2 type=DEF
> [   17.088066] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=1-2 type=DEF
> comes wi[   17.088071] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=1-2 type=DEF

At this point I believe you triggered suspend.

> [   57.290150] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [   57.335619] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
> [   57.353364] dwc-eth-dwmac 2490000.ethernet eth0: Link is Down
> [   57.397022] Disabling non-boot CPUs ...

Offlining CPU5.

> [   57.400904] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4 type=DYN span=0,3-5
> [   57.400949] CPU0 attaching NULL sched-domain.
> [   57.415298] span=1-2
> [   57.417483] __dl_sub: cpus=3 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> [   57.417487] __dl_server_detach_root: cpu=0 rd_span=0,3-5 total_bw=157284
> [   57.417496] rq_attach_root: cpu=0 old_span=NULL new_span=1-2
> [   57.417501] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DEF
> [   57.417504] __dl_server_attach_root: cpu=0 rd_span=0-2 total_bw=157284
> [   57.417507] CPU3 attaching NULL sched-domain.
> [   57.454804] span=0-2
> [   57.456987] __dl_sub: cpus=2 tsk_bw=52428 total_bw=104856 span=3-5 type=DYN
> [   57.456990] __dl_server_detach_root: cpu=3 rd_span=3-5 total_bw=104856
> [   57.456998] rq_attach_root: cpu=3 old_span=NULL new_span=0-2
> [   57.457000] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0-3 type=DEF
> [   57.457003] __dl_server_attach_root: cpu=3 rd_span=0-3 total_bw=209712
> [   57.457006] CPU4 attaching NULL sched-domain.
> [   57.493964] span=0-3
> [   57.496152] __dl_sub: cpus=1 tsk_bw=52428 total_bw=52428 span=4-5 type=DYN
> [   57.496156] __dl_server_detach_root: cpu=4 rd_span=4-5 total_bw=52428
> [   57.496162] rq_attach_root: cpu=4 old_span=NULL new_span=0-3
> [   57.496165] __dl_add: cpus=5 tsk_bw=52428 total_bw=262140 span=0-4 type=DEF
> [   57.496168] __dl_server_attach_root: cpu=4 rd_span=0-4 total_bw=262140
> [   57.496171] CPU5 attaching NULL sched-domain.
> [   57.532952] span=0-4
> [   57.535143] rq_attach_root: cpu=5 old_span= new_span=0-4
> [   57.535147] __dl_add: cpus=5 tsk_bw=52428 total_bw=314568 span=0-5 type=DEF

Maybe we shouldn't add the dl_server contribution of a CPU that is going
to be offline.

> [   57.535149] __dl_server_attach_root: cpu=5 rd_span=0-5 total_bw=314568
> [   57.535211] CPU0 attaching sched-domain(s):
> [   57.558178]  domain-0: span=0,3-4 level=MC
> [   57.562276]   groups: 0:{ span=0 }, 3:{ span=3 }, 4:{ span=4 }
> [   57.568126] __dl_sub: cpus=5 tsk_bw=52428 total_bw=262140 span=0-5 type=DEF
> [   57.568129] __dl_server_detach_root: cpu=0 rd_span=0-5 total_bw=262140
> [   57.568136] rq_attach_root: cpu=0 old_span=NULL new_span=
> [   57.568139] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=0 type=DYN
> [   57.568142] __dl_server_attach_root: cpu=0 rd_span=0 total_bw=52428
> [   57.568145] CPU3 attaching sched-domain(s):
> [   57.604141]  domain-0: span=0,3-4 level=MC
> [   57.608242]   groups: 3:{ span=3 }, 4:{ span=4 }, 0:{ span=0 }
> [   57.614088] __dl_sub: cpus=4 tsk_bw=52428 total_bw=209712 span=1-5 type=DEF
> [   57.614091] __dl_server_detach_root: cpu=3 rd_span=1-5 total_bw=209712
> [   57.614098] rq_attach_root: cpu=3 old_span=NULL new_span=0
> [   57.614100] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=0,3 type=DYN
> [   57.614103] __dl_server_attach_root: cpu=3 rd_span=0,3 total_bw=104856
> [   57.614106] CPU4 attaching sched-domain(s):
> [   57.650710]  domain-0: span=0,3-4 level=MC
> [   57.654812]   groups: 4:{ span=4 }, 0:{ span=0 }, 3:{ span=3 }
> [   57.660656] __dl_sub: cpus=3 tsk_bw=52428 total_bw=157284 span=1-2,4-5 type=DEF
> [   57.660660] __dl_server_detach_root: cpu=4 rd_span=1-2,4-5 total_bw=157284
> [   57.660666] rq_attach_root: cpu=4 old_span=NULL new_span=0,3
> [   57.660669] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0,3-4 type=DYN
> [   57.660671] __dl_server_attach_root: cpu=4 rd_span=0,3-4 total_bw=157284
> [   57.660675] root domain span: 0,3-4
> [   57.697801] default domain span: 1-2,5
> [   57.701560] rd 0,3-4: Checking EAS, CPUs do not have asymmetric capacities
> [   57.709917] psci: CPU5 killed (polled 0 ms)

Offlining CPU4.

> [   57.714734] dl_bw_manage: cpu=4 cap=2048 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3 type=DYN span=0,3-4
> [   57.714773] CPU0 attaching NULL sched-domain.
> [   57.729120] span=1-2,5
> [   57.731483] __dl_sub: cpus=2 tsk_bw=52428 total_bw=104856 span=0,3-4 type=DYN
> [   57.731488] __dl_server_detach_root: cpu=0 rd_span=0,3-4 total_bw=104856
> [   57.731496] rq_attach_root: cpu=0 old_span=NULL new_span=1-2,5
> [   57.731499] __dl_add: cpus=3 tsk_bw=52428 total_bw=209712 span=0-2,5 type=DEF
> [   57.731503] __dl_server_attach_root: cpu=0 rd_span=0-2,5 total_bw=209712
> [   57.731506] CPU3 attaching NULL sched-domain.
> [   57.769309] span=0-2,5
> [   57.771670] __dl_sub: cpus=1 tsk_bw=52428 total_bw=52428 span=3-4 type=DYN
> [   57.771673] __dl_server_detach_root: cpu=3 rd_span=3-4 total_bw=52428
> [   57.771680] rq_attach_root: cpu=3 old_span=NULL new_span=0-2,5
> [   57.771682] __dl_add: cpus=4 tsk_bw=52428 total_bw=262140 span=0-3,5 type=DEF
> [   57.771685] __dl_server_attach_root: cpu=3 rd_span=0-3,5 total_bw=262140
> [   57.771688] CPU4 attaching NULL sched-domain.
> [   57.808967] span=0-3,5
> [   57.811327] rq_attach_root: cpu=4 old_span= new_span=0-3,5
> [   57.811331] __dl_add: cpus=4 tsk_bw=52428 total_bw=314568 span=0-5 type=DEF
> [   57.811334] __dl_server_attach_root: cpu=4 rd_span=0-5 total_bw=314568
> [   57.811378] CPU0 attaching sched-domain(s):
> [   57.834511]  domain-0: span=0,3 level=MC
> [   57.838437]   groups: 0:{ span=0 }, 3:{ span=3 }
> [   57.843067] __dl_sub: cpus=4 tsk_bw=52428 total_bw=262140 span=0-5 type=DEF
> [   57.843070] __dl_server_detach_root: cpu=0 rd_span=0-5 total_bw=262140
> [   57.843075] rq_attach_root: cpu=0 old_span=NULL new_span=
> [   57.843078] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=0 type=DYN
> [   57.843080] __dl_server_attach_root: cpu=0 rd_span=0 total_bw=52428
> [   57.843083] CPU3 attaching sched-domain(s):
> [   57.879064]  domain-0: span=0,3 level=MC
> [   57.882987]   groups: 3:{ span=3 }, 0:{ span=0 }
> [   57.887613] __dl_sub: cpus=3 tsk_bw=52428 total_bw=209712 span=1-5 type=DEF
> [   57.887617] __dl_server_detach_root: cpu=3 rd_span=1-5 total_bw=209712
> [   57.887622] rq_attach_root: cpu=3 old_span=NULL new_span=0
> [   57.887625] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=0,3 type=DYN
> [   57.887628] __dl_server_attach_root: cpu=3 rd_span=0,3 total_bw=104856
> [   57.887632] root domain span: 0,3
> [   57.923352] default domain span: 1-2,4-5
> [   57.927282] rd 0,3: Checking EAS, CPUs do not have asymmetric capacities
> [   57.934554] psci: CPU4 killed (polled 0 ms)

Offlining CPU3.

> [   57.939539] dl_bw_manage: cpu=3 cap=1024 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2 type=DYN span=0,3
> [   57.939579] CPU0 attaching NULL sched-domain.
> [   57.953763] span=1-2,4-5
> [   57.956301] __dl_sub: cpus=1 tsk_bw=52428 total_bw=52428 span=0,3 type=DYN
> [   57.956305] __dl_server_detach_root: cpu=0 rd_span=0,3 total_bw=52428
> [   57.956313] rq_attach_root: cpu=0 old_span=NULL new_span=1-2,4-5
> [   57.956317] __dl_add: cpus=3 tsk_bw=52428 total_bw=262140 span=0-2,4-5 type=DEF
> [   57.956320] __dl_server_attach_root: cpu=0 rd_span=0-2,4-5 total_bw=262140
> [   57.956322] CPU3 attaching NULL sched-domain.
> [   57.994121] span=0-2,4-5
> [   57.996656] rq_attach_root: cpu=3 old_span= new_span=0-2,4-5
> [   57.996660] __dl_add: cpus=3 tsk_bw=52428 total_bw=314568 span=0-5 type=DEF
> [   57.996663] __dl_server_attach_root: cpu=3 rd_span=0-5 total_bw=314568
> [   57.996700] CPU0 attaching NULL sched-domain.
> [   58.020170] span=0-5
> [   58.022357] __dl_sub: cpus=3 tsk_bw=52428 total_bw=262140 span=0-5 type=DEF
> [   58.022361] __dl_server_detach_root: cpu=0 rd_span=0-5 total_bw=262140
> [   58.022367] rq_attach_root: cpu=0 old_span=NULL new_span=
> [   58.022370] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=0 type=DYN
> [   58.022372] __dl_server_attach_root: cpu=0 rd_span=0 total_bw=52428
> [   58.022375] root domain span: 0
> [   58.057313] default domain span: 1-5
> [   58.060900] rd 0: Checking EAS, CPUs do not have asymmetric capacities
> [   58.068835] psci: CPU3 killed (polled 0 ms)

Offlining CPU2.

> [   58.073751] dl_bw_manage: cpu=2 cap=1024 fair_server_bw=52428 total_bw=262140 dl_bw_cpus=2 type=DEF span=1-5
> [   58.073882] dl_clear_root_domain: span=0 type=DYN
> [   58.073895] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=0 type=DYN
> [   58.073909] rd 0: Checking EAS, CPUs do not have asymmetric capacities
> [   58.103900] psci: CPU2 killed (polled 0 ms)

We also probably need to remove isolated CPUs contributions to DEF root
domain when they are offlined (missing __dl_sub).

Offlining CPU1 (fail).

> [   58.108365] dl_bw_manage: cpu=1 cap=0 fair_server_bw=52428 total_bw=262140 dl_bw_cpus=1 type=DEF span=1-5
> [   58.108466] Error taking CPU1 down: -16
> [   58.121881] Non-boot CPUs are not disabled
> [   58.126007] Enabling non-boot CPUs ...

Revert follows.

Still wondering why it doesn't fail for me, now that it doesn't seem
related to sugov anymore. :/

Anyway, apart from possibly sharing tracing data. Could you please try
to repro with performance governor (from boot)?

Thanks,
Juri


