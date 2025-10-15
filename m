Return-Path: <cgroups+bounces-10788-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9783ABE04E7
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 21:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC84119C01BC
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 19:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A2D302750;
	Wed, 15 Oct 2025 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcA/iRLp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE851F4CB7
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555316; cv=none; b=K5KgddU3kfeG2pcvDclqJbPFjSS+5MEywyOku8DTYMNN63ou71O6wfPS2MWQANYRjH6HH6HZGeEdinb+pd71amaITpLNtJWovN5oNpXDxQr+jiiMn62PuX0zKfj8tK9f7Q27d2+c46tr8wtPBJpXP5Gel/y01OueLqdMszeUP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555316; c=relaxed/simple;
	bh=EMZKqTSnOfnBuvdExLH/0/j3qYB9lnczgf7ubSdND4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E1l1MuHTwcMd2RkLu+/TYCxg/IGL8wLNFzctYClG6bojMnIjGJzHm9x034JOfqjBaC/XmjnxLfUv5Tt0dN0lMgW+K+L2kJL8g2c+6NfyK6b+jSgTSPH0SX11mxhyt2B0oCB05nYMwIpCikwy6fRGgkA3NrbHjlOjnEFNw/gxbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcA/iRLp; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so5576216b3a.2
        for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760555315; x=1761160115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QmSbXI2ApsZqfklDnKMr9/VcpSy3bad84AJw3uoOIms=;
        b=bcA/iRLpY9K8P/XezsHMElhfPCNILJ5H/Z45fIm/C4CjcYUfQBREAGqs95rUyQCFg7
         RnWVGvwRM/j5p/JQgFgiqAsfbZSNtiVOjMcGKqOdIsdXIAEEUAdYGrOrNjDDVNYInJL9
         8y2pKY+ZZ2xO+XDTc/14F3s1K/PG0CkbD4Gt2O1erNlfUGubleO0WB4TMgMUwCnHpalm
         +Gk5luKxbLFPEepiqUtiZmqCdx4AYHvOrOTkTV7z19UJAyfWBrUDexHxwhsm6iqkGdTU
         DzdvWyXv8yFZA5vm4WVkuBPFJaoaXiRTcS0C0RLV60+W86HIJy31+EpfPdFVfoRj+9+C
         e64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760555315; x=1761160115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmSbXI2ApsZqfklDnKMr9/VcpSy3bad84AJw3uoOIms=;
        b=Mdx8zW6PO/k8IX7TRpMKhqRuMJ8ZWNaNtCMNHVZJNCrtCui8PyYv9EK8wlQZyhA1WB
         t/V9hTp3s8JgTdsQ5tx5hdqIwKP1sSp+c/IH4uxnUShKDax75rOMG0Q0NOktYXx9q93S
         RGlZUKnZHr6Z1PPmZeIzwU5zxU/Mr4m5DDFWLV0wTPWeV9XVlMNy4kP3kt23i9jtxmnE
         jGWfUMS1FiSej/U34+4RLl3QT3LmNzPyycl/mf6MmIp01iyYIVpll3R6KW42r8ybQ817
         Jwc0a3TmGm+PV+IYNfy7PDsdB/E2zVGitPaQY4BO2enuteJrPyowTem7ycHs5EmsDo/H
         I37g==
X-Forwarded-Encrypted: i=1; AJvYcCWI/yHnnmirTGZAoJQEwmM0rWD2N2ueR5uD7ucb+LbsKP2xIDsUddCVTXSq38r6r15ZZaeDaEbx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0YlbCu/p17HPJQ3Hx3wUwW7nychBz1jLICowZZAQ/jyaeos6m
	oGVhJYqdrUV6+tY2YFC3zZIHhldstOXXV3aL1h3weuYCKERi2FjK5iyZ
X-Gm-Gg: ASbGncs3m7eyLsFHrXUYxptmHRsOo4UhRDUEzkbW20jSeJPwlk88l5kie5l0Cnvra6p
	LwOZg+Dkmgm/1HLNRNPRMuPIMBZORD5O08+upzgQYESsUk+Nrb0YOuglrYJn9uZS91gelTuMRjq
	2ZDU+S5M8QHwQ+HPsTa1jg/FQXv6f4MqEEX8WsosFRHOB3X4+JcclvkISd3iKSCAPSgJERm7jdA
	JgpWV1V3mwITquxlktfSc7BGCmfiHxPG9U3iWgqIo2II5z+S7ZtDZx/1vQ4qrIynrRoyF7Rxl92
	w86p8sYqqpwDTQdtvy9Br0QPngfVdwEiWle9BLYkUwsOamfx71HdVp/SIVG9/pvqeT0GJtJFwAR
	CjncDAITcEsLkuS0fB2QDLIoVjAi5/7/3q/0oLY56NVneXFjtoMZoVaPz7JNc3I0cWaCtWA==
X-Google-Smtp-Source: AGHT+IHMSB7YdnX8tgv3hAnoptITEW+v5c6/QGjesZK24TcZjCmiCjAy3xCUPKMz1WHLBr4gr+e/lA==
X-Received: by 2002:a05:6a00:1884:b0:77f:416e:de8e with SMTP id d2e1a72fcca58-79387efb06cmr33823101b3a.26.1760555314450;
        Wed, 15 Oct 2025 12:08:34 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::7:1069])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm19483106b3a.69.2025.10.15.12.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:08:33 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	andrii@kernel.org,
	ast@kernel.org,
	mkoutny@suse.com,
	yosryahmed@google.com,
	hannes@cmpxchg.org,
	tj@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 0/2] memcg: reading memcg stats more efficiently
Date: Wed, 15 Oct 2025 12:08:11 -0700
Message-ID: <20251015190813.80163-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading cgroup memory.stat files there is significant kernel overhead
in the formatting and encoding of numeric data into a string buffer. Beyond
that, the given user mode program must decode this data and possibly
perform filtering to obtain the desired stats. This process can be
expensive for programs that periodically sample this data over a large
enough fleet.

As an alternative to reading memory.stat, introduce new kfuncs that allow
fetching specific memcg stats from within cgroup iterator based bpf
programs. This approach allows for numeric values to be transferred
directly from the kernel to user mode via the mapped memory of the bpf
program's elf data section. Reading stats this way effectively eliminates
the numeric conversion work needed to be performed in both kernel and user
mode. It also eliminates the need for filtering in a user mode program.
i.e. where reading memory.stat returns all stats, this new approach allows
returning only select stats.

An experiment was setup to compare the performance of a program using these
new kfuncs vs a program that uses the traditional method of reading
memory.stat. On the experimental side, a libbpf based program was written
which sets up a link to the bpf program once in advance and then reuses
this link to create and read from a bpf iterator program for 1M iterations.
Meanwhile on the control side, a program was written to open the root
memory.stat file and repeatedly read 1M times from the associated file
descriptor (while seeking back to zero before each subsequent read). Note
that the program does not bother to decode or filter any data in user mode.
The reason for this is because the experimental program completely removes
the need for this work.

The results showed a significant perf benefit on the experimental side,
outperforming the control side by a margin of 80% elapsed time in kernel
mode. The kernel overhead of numeric conversion on the control side is
eliminated on the experimental side since the values are read directly
through mapped memory of the bpf program. The experiment data is shown
here:

control: elapsed time
real    0m13.062s
user    0m0.147s
sys     0m12.876s

experiment: elapsed time
real    0m2.717s
user    0m0.175s
sys     0m2.451s

control: perf data
22.23% a.out [kernel.kallsyms] [k] vsnprintf
18.83% a.out [kernel.kallsyms] [k] format_decode
12.05% a.out [kernel.kallsyms] [k] string
11.56% a.out [kernel.kallsyms] [k] number
 7.71% a.out [kernel.kallsyms] [k] strlen
 4.80% a.out [kernel.kallsyms] [k] memcpy_orig
 4.67% a.out [kernel.kallsyms] [k] memory_stat_format
 4.63% a.out [kernel.kallsyms] [k] seq_buf_printf
 2.22% a.out [kernel.kallsyms] [k] widen_string
 1.65% a.out [kernel.kallsyms] [k] put_dec_trunc8
 0.95% a.out [kernel.kallsyms] [k] put_dec_full8
 0.69% a.out [kernel.kallsyms] [k] put_dec
 0.69% a.out [kernel.kallsyms] [k] memcpy

experiment: perf data
10.04% memcgstat bpf_prog_.._query [k] bpf_prog_527781c811d5b45c_query
 7.85% memcgstat [kernel.kallsyms] [k] memcg_node_stat_fetch
 4.03% memcgstat [kernel.kallsyms] [k] __memcg_slab_post_alloc_hook
 3.47% memcgstat [kernel.kallsyms] [k] _raw_spin_lock
 2.58% memcgstat [kernel.kallsyms] [k] memcg_vm_event_fetch
 2.58% memcgstat [kernel.kallsyms] [k] entry_SYSRETQ_unsafe_stack
 2.32% memcgstat [kernel.kallsyms] [k] kmem_cache_free
 2.19% memcgstat [kernel.kallsyms] [k] __memcg_slab_free_hook
 2.13% memcgstat [kernel.kallsyms] [k] mutex_lock
 2.12% memcgstat [kernel.kallsyms] [k] get_page_from_freelist

Aside from the perf gain, the kfunc/bpf approach provides flexibility in
how memcg data can be delivered to a user mode program. As seen in the
second patch which contains the selftests, it is possible to use a struct
with select memory stat fields. But it is completely up to the programmer
on how to lay out the data.

JP Kobryn (2):
  memcg: introduce kfuncs for fetching memcg stats
  memcg: selftests for memcg stat kfuncs

 mm/memcontrol.c                               |  67 ++++
 .../testing/selftests/bpf/cgroup_iter_memcg.h |  18 ++
 .../bpf/prog_tests/cgroup_iter_memcg.c        | 294 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_iter_memcg.c   |  61 ++++
 4 files changed, 440 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/cgroup_iter_memcg.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c

-- 
2.47.3


