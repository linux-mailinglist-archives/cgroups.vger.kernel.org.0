Return-Path: <cgroups+bounces-4894-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B2897A217
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 14:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D496285D13
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2024 12:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF82154423;
	Mon, 16 Sep 2024 12:22:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C815E446D1;
	Mon, 16 Sep 2024 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489368; cv=none; b=K2BQTaysKGqdxwB9WWGeudg/HLF8vhKp4KSqnTaN4mxDDsqUxkhR9sDp+74/wgDSmn9Ggbfbs/7KlwRpQQpqmsJy/1FiVZ2Qj06mwlsfxatTeDIFbbJDKQ028ZYeC9MJTf7dpAOYjThp1C8qd25eD6NmyyUTNWIp/fGQucKbPGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489368; c=relaxed/simple;
	bh=c9AiiezAPdeJA/5W/KzoQlDGuhF8uWLafjZpQwETSnE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IoEK5zTFugiQo4GiBxB2rueeT/g/C5uqmSrJxgP/+mgFgCdq1HgcY9jv4L3BI0GxUTiBrH46p14JpCJGfSI2p/17yRJTCMRzI4RUtq5KIRc4+XJFn7FNE+tQ7C/dNYhWy+4hdH9PHCKC7A+sWQAri8fqvB6T9v1iX/BF4toeyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374c3eef39eso2655454f8f.0;
        Mon, 16 Sep 2024 05:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726489365; x=1727094165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZBGRbBIGV5X5xLZ+rni4rJi5KtmpNZvI6X54qPGr6M=;
        b=HUyqhj/Voty/DWOpvvuDaIwUOV0AF7u7mWQG9fMd+bQ89lzaxk0dcUcEq55nk1dS1q
         FxSmGr5loYyRB32skUDRkhX0hhCOYRRZg0yAJhKdANAz8rVw0Gu/sz4NP2ASH9vXq/oQ
         /k185IgQP4aYFdWZUWIN7blHufBOCvfNzC0h9Kxncby0DP8X//mWeexbopTmu8+F5em4
         vgbG5Ix3s5arIWa5s8FEDYX7+YHuojrygy6Ad+4m0kdxYRDHz54UUTR+qF0ppjJnnNQH
         IQNPeO7WCnwqLYqfw7xdjL+XorCtr/Cv8P5SpGySDToSAfFMej4FFp4WnEsDnOVth5VQ
         vrOw==
X-Forwarded-Encrypted: i=1; AJvYcCUh0Vd4/1y5Y64O4m1X0J4NRM8A0ZkPoCwxkjFH7t1tdQC8W42GGNc+vLSmwxrNj5mEGBRcUXwmwLaJ2KiD@vger.kernel.org, AJvYcCVgcmM1W1CZHFwLXFspSCp8KJ5svFm0IBEyo8p66+usF/aFHOkxiAFBTFaLcVxV5Z1p+ah8wc6C@vger.kernel.org
X-Gm-Message-State: AOJu0YykBUU/HU0xb2+sw967bzCog8mM7WVa90hkYZzW/K7CdNadauFu
	G8MDJUG8/bAp+IYTyYDGgrbtNEJPE4kwOEeo8l4tABP/GPA9GHDA
X-Google-Smtp-Source: AGHT+IGnUnioaOxDZX1BUgvxFZDQXINgpAKMfpUC4aZJf56RSiMwVoLkPknPemhA8R9PyXrbvWBA7w==
X-Received: by 2002:a5d:5747:0:b0:374:c4e2:3cad with SMTP id ffacd0b85a97d-378c2d5b237mr7952757f8f.52.1726489364668;
        Mon, 16 Sep 2024 05:22:44 -0700 (PDT)
Received: from costa-tp.. ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7800243sm7117272f8f.86.2024.09.16.05.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 05:22:43 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	ming.lei@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	vschneid@redhat.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v3 0/3] genirq/cpuhotplug: Adjust managed interrupts according to change of housekeeping cpumask
Date: Mon, 16 Sep 2024 15:20:41 +0300
Message-ID: <20240916122044.3056787-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The housekeeping CPU masks, set up by the "isolcpus" and "nohz_full"
boot command line options, are used at boot time to exclude selected
CPUs from running some kernel housekeeping subsystems to minimize
disturbance to latency sensitive userspace applications such as DPDK.
This options can only be changed with a reboot. This is a problem for
containerized workloads running on OpenShift/Kubernetes where a
mix of low latency and "normal" workloads can be created/destroyed
dynamically and the number of CPUs allocated to each workload is often
not known at boot time.

Theoretically, complete CPU offlining/onlining could be used for
housekeeping adjustments, but this approach is not practical.
Telco companies use Linux to run DPDK in OpenShift/Kubernetes containers.
DPDK requires isolated cpus to run real-time processes.
Kubernetes manages allocation of resources for containers.
Unfortunately Kubernetes doesn't support dynamic CPU offlining/onlining:
https://github.com/kubernetes/kubernetes/issues/67500
and is not planning to support it.
Addressing this issue at the application level appears to be even
less straightforward than addressing it at the kernel level.

This series of patches is based on series
isolation: Exclude dynamically isolated CPUs from housekeeping masks:
https://lore.kernel.org/lkml/20240821142312.236970-1-longman@redhat.com/
Its purpose is to exclude dynamically isolated CPUs from some
housekeeping masks so that subsystems that check the housekeeping masks
at run time will not use those isolated CPUs.

However, some of subsystems can use obsolete housekeeping CPU masks.
Therefore, to prevent the use of these isolated CPUs, it is necessary to
explicitly propagate changes of the housekeeping masks to all subsystems
depending on the mask.

Changes in v2:
- Focusing in this patch series on interrupts only.

v1:
- https://lore.kernel.org/lkml/20240516190437.3545310-1-costa.shul@redhat.com/

References:
- Linux Kernel Dynamic CPU Isolation: https://pretalx.com/devconf-us-2024/talk/AZBQLE/

Costa Shulyupin (3):
  sched/isolation: Add infrastructure for dynamic CPU isolation
  genirq/cpuhotplug: Adjust managed irqs according to change of
    housekeeping CPU
  DO NOT MERGE: test for managed irqs adjustment

 include/linux/irq.h      |   2 +
 kernel/cgroup/cpuset.c   |   1 +
 kernel/irq/cpuhotplug.c  |  95 ++++++++++++++++++++++++++++++++
 kernel/sched/isolation.c |  46 ++++++++++++++--
 tests/managed_irq.sh     | 113 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 254 insertions(+), 3 deletions(-)
 create mode 100755 tests/managed_irq.sh

-- 
2.45.0


