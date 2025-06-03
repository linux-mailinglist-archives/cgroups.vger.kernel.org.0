Return-Path: <cgroups+bounces-8417-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A60ACBEE8
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 05:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C0716BFDF
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 03:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AE918952C;
	Tue,  3 Jun 2025 03:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrVrPs9C"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF1938B
	for <cgroups@vger.kernel.org>; Tue,  3 Jun 2025 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748921937; cv=none; b=PDZ8D5Qky/Qa4kV8kPkI5VtSbfGeQci4TLEpygXrahStJwPVxGLUk+qhbHfcAqCHtoL8KwcFBmrvLLidfwFN3VT+KoYQVwsOtbc5gAe2igdhtph2SIt9J1vUFo1cFgfTvqEtSrSD1K5QILVa9PiNbzI5x35VnPtLCiFBo6jJU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748921937; c=relaxed/simple;
	bh=rOW8JBg/Kol8mNg0qSteFJk0fu+cHoWx2aOyzOyflco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx8fn3bgKqqT6YoLYC+5sXRxoQO2zaqDGxbhOP7u+09Oa9CAsd99llhLWr1BfL7zxaGe+6zS/1ISD61Y3xzwBvaYREhiS9qemjrejpZOQPZQrpiZnx+fZ6UYAf3HfkcTgvHyNezUont4I3KdX37vZoHOr+qZtH4y/KyemJfPWdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrVrPs9C; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c7a52e97so4201064b3a.3
        for <cgroups@vger.kernel.org>; Mon, 02 Jun 2025 20:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748921934; x=1749526734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdshqhfrK9A+GkNCMIMiok2VKYkDBtwMGG57IjQgZrc=;
        b=MrVrPs9C/CpjKZB74BrYRUjaZjeFFQ9nruVqXhO8vA4Hx7nocYEmP12IK/ZpQc2CPA
         ra1Ix+zNkbWENUPz4MNPAs2YBs/6gehbTAQcNiu3Ga7olcymA5VeyM+nD0DWErcDNuhh
         5fwhUJaU34RtzP1avpX8UyPiLoMbTk9DqCW96sjt9VJGOY7rHGnJZev7KNMLL4znuSzX
         //D6PcVdMTclKBouRQsAydVUnPZDVyxG+omGVOsn5mCknX43aQNg79fE+EuXRnahBvvB
         3g7cz8UFvNJtQxuCR831WTk1b/2vokpli7qqP9M+3XRTOboxOrOGeqDg4SxMfOQOeSZS
         69pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748921934; x=1749526734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdshqhfrK9A+GkNCMIMiok2VKYkDBtwMGG57IjQgZrc=;
        b=dmxUsd9Qo7TddMr9r5dp+LEG1gjjDFijUP8XwIhK8gME0XQ/OzK2YNvb8HJsYDwruc
         pJorDnnDqZJLxzn9nuzQWz0QjjfV3uPMkr+HLst9Q14ZqzdAGwKFGQ0rt6Xy5jKWEtQ6
         2JgKn0Nx+lpY23PI+XsaAsTVSY5tHFA6wEk0yCqHrLpabV2xzHB7CFn+dL26OLls6Jsj
         s5eNy+T8xC46HL2xmRm3tIq+FQufvSY2EpzlEfF9HZhMH0f0/TJ56NX6FRvvQDtsBmyd
         OAkd4MHs3/Mj80cCHOIuORiL0H4myV/C0+MkieRof6Gp0Y+BEsokWCeaqNibW6wdudwD
         /jjw==
X-Forwarded-Encrypted: i=1; AJvYcCUF+upKLkOHNvsDef3XtFZobYOd42MkCTIMb/csx7eWy3Sibwsz7jCAOy87h+Sv9bNiw7fHSFRg@vger.kernel.org
X-Gm-Message-State: AOJu0YzKP6dmZacc5npcA9p7ZpX6Sm6N9bmir9f4ETrqMkGjgIEVVHng
	tYW0R/yYqwhFRicvXulGj0qUfvmYipHt/nuVx5EnSM+xF6z7h1Zf6G5Y
X-Gm-Gg: ASbGncvXe813T9kMYxaS39Pl4LEs0FYpazmSC0KfOY19exbXLy9rIWP5ai/iMDKMIvK
	AbjeSEYNRNjVXxbRO4lIEB9ix7xIUGTzoekruUjr+0261H9YW7LHEda/O0bDK74q0XTrdnSPp7V
	4VLH+A4OAszbKz3zJdxhbfKKeyvvTjMEiaUXQjiqQ+ksn+9OfK6H9ApK1VrTtz5Ppla8vDtbxEK
	ZVl2ZLriry5lb+OiK6/v1FyEK9gRbKw0LagzNwU4mVodfW3YAORGH2B6dQvAWzkm476ebajNKzP
	G9MV5HWYLKXxY5rOpLT3SQuwClpmP0ev1LwsNJPxpv2wonNiRVCyWP+c72YVTBFU
X-Google-Smtp-Source: AGHT+IGvLwYBgIzKTGJF2+LnrGkWsZgaUU5bS6y0rTLlIiC+7fSFJrt3NEMZMI7ZwNCpTziCDaQinw==
X-Received: by 2002:a05:6a21:110:b0:21a:d503:f47c with SMTP id adf61e73a8af0-21ae00b15c1mr18162559637.28.1748921934310;
        Mon, 02 Jun 2025 20:38:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb048dcsm6287622a12.12.2025.06.02.20.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 20:38:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 2 Jun 2025 20:38:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, klarasmodin@gmail.com, shakeel.butt@linux.dev,
	yosryahmed@google.com, mkoutny@suse.com, hannes@cmpxchg.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH cgroup/for-6.16] cgroup: avoid per-cpu allocation of size
 zero rstat cpu locks
Message-ID: <b9824a99-cca6-43d3-81db-14f4366c5fef@roeck-us.net>
References: <20250522013202.185523-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522013202.185523-1-inwardvessel@gmail.com>

On Wed, May 21, 2025 at 06:32:02PM -0700, JP Kobryn wrote:
> Subsystem rstat locks are dynamically allocated per-cpu. It was discovered
> that a panic can occur during this allocation when the lock size is zero.
> This is the case on non-smp systems, since arch_spinlock_t is defined as an
> empty struct. Prevent this allocation when !CONFIG_SMP by adding a
> pre-processor conditional around the affected block.
> 

It may be defined as empty struct, but it is still dereferenced. This patch
is causing crashes on non-SMP systems such as xtensa, m68k, or with x86
non-SMP builds.

Examples:

m68k:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
Oops: 00000000
PC: [<000593d6>] __raw_spin_lock_init+0x6/0x1c
SR: 2000  SP: 0086bef8  a2: 0086f440
d0: 00000001    d1: 000001ff    d2: 00000001    d3: 00000002
d4: 008e3a20    d5: 00000001    a0: 00000000    a1: 00000114
Process swapper (pid: 0, task=0086f440)
Frame format=7 eff addr=00000000 ssw=0405 faddr=00000000
wb 1 stat/addr/data: 0000 00000000 00000000
wb 2 stat/addr/data: 0000 00000000 00000000
wb 3 stat/addr/data: 0000 00000000 00000000
push data: 00000000 00000000 00000000 00000000
Stack from 0086bf60:
        0099d64c 00000000 007ff7a1 0092e6c0 00000002 008eed3c 00938c60 0099cf92
        008eed3c 00000008 008eed3c 008e3a84 008e3a20 0099d300 008eed3c 00000000
        00000000 00000000 00000000 00000000 00000000 00000000 00703cc2 00003b18
        0003f9a2 008e44c0 0086bff8 0099639e 00000000 00000000 00000000 00000000
        00000000 00000000 00000000 00000000 009cc000 009b8a7c 00000000 009952b8
Call Trace: [<0099d64c>] ss_rstat_init+0x5a/0x66
 [<0099cf92>] cgroup_init_subsys+0x102/0x1b4
 [<0099d300>] cgroup_init+0x18e/0x47c
 [<00703cc2>] strlen+0x0/0x1a
 [<00003b18>] _printk+0x0/0x18
 [<0003f9a2>] parse_args+0x0/0x380
 [<0099639e>] start_kernel+0x5c0/0x5cc
 [<009952b8>] _sinittext+0x2b8/0x8f0

x86 noSMP build:

[    1.151991] BUG: kernel NULL pointer dereference, address: 0000000000000020
[    1.151991] #PF: supervisor write access in kernel mode
[    1.151991] #PF: error_code(0x0002) - not-present page
[    1.151991] PGD 0 P4D 0
[    1.151991] Oops: Oops: 0002 [#1] NOPTI
[    1.151991] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-10402-g4cb6c8af8591 #1 PREEMPT(voluntary)
[    1.151991] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    1.151991] RIP: 0010:lockdep_init_map_type+0x1b/0x260
[    1.151991] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 54 41 89 cc 55 48 89 d5 8b 15 9d fc b0 03 53 48 89 fb 8b 44 24 20 <48> c7 47 08 00 00 00 00 48 c7 47 10 00 00 00 00 85 d2 0f 85 8e 00
[    1.151991] RSP: 0000:ffffffff8b203e38 EFLAGS: 00010246
[    1.151991] RAX: 0000000000000000 RBX: 0000000000000018 RCX: 0000000000000000
[    1.151991] RDX: 0000000000000000 RSI: ffffffff8b0387bf RDI: 0000000000000018
[    1.151991] RBP: ffffffff8cc48c20 R08: 0000000000000002 R09: 0000000000000000
[    1.151991] R10: 0000000000000001 R11: ffffffff8a786934 R12: 0000000000000000
[    1.151991] R13: 0000000000000002 R14: ffffffff8b3c8fc0 R15: ffffffff8b3c9028
[    1.151991] FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[    1.151991] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.151991] CR2: 0000000000000020 CR3: 00000000220a0000 CR4: 00000000000006f0
[    1.151991] Call Trace:
[    1.151991]  <TASK>
[    1.151991]  __raw_spin_lock_init+0x3a/0x70
[    1.151991]  ss_rstat_init+0x4b/0x80
[    1.151991]  cgroup_init_subsys+0x170/0x1c0
[    1.151991]  cgroup_init+0x3d8/0x4c0
[    1.151991]  start_kernel+0x68e/0x770
[    1.151991]  x86_64_start_reservations+0x18/0x30
[    1.151991]  x86_64_start_kernel+0x101/0x110
[    1.151991]  common_startup_64+0xc0/0xc8

Guenter

