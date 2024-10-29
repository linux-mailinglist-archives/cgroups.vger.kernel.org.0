Return-Path: <cgroups+bounces-5309-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFFC9B4918
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 13:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCFE285FC9
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 12:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EFF205ADA;
	Tue, 29 Oct 2024 12:07:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F50205AD9;
	Tue, 29 Oct 2024 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203643; cv=none; b=AxgK6O4sKaTrUWlJtCXU5BEyHpEv+mdlCnzjTKLJhPP69SDcgqX+/yOUj1Wi8BMsIGGGhlIj+ggZ7+hP+9uT9wJ6SkTzrnixftDlslL7KJxWocNyMog2kedX2NOv8k1GMi7HqF1edrim6eIsy1Xn0lOIOmH2IjnF1iQzEMbRADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203643; c=relaxed/simple;
	bh=mkNcJKo8sCrSWHJxuCVYznN5Vop0DXbUpeJ737Di1E0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=H9weMNnwtDPjlsVcfEINt3W5VbORHZUqsJhfkmpl8IDJzBzpvgAK6Nq0G2q1Mfz54366bkfGi9X9k5KKiz9GexMkHhghdYOR5/1kA4/HijLIVA091r4cybwmzMfv/QOZkocyqZGZjBNZeXPuGh7AzP2l1kZB7EdrGEvab1cFluo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so51538125e9.1;
        Tue, 29 Oct 2024 05:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730203639; x=1730808439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ty1fxFzKROeUo9rzY1+fw6OU6BrsaH3T5FVmlIlWZR8=;
        b=h0cvtl8kruaqpa+CRMXXB/1HdULXrF0oicZp1bkUnzfGRwhIkYimi6ITYRKULq1vgQ
         mWJIg2uKkf1TSuucKmWDIVO2imStteZ48ILLacwpZ5UfKwWfmeqHHqUFrGlOYl74HMgG
         ZGDpP+rTZMfKa3ZwXmgc0UQyLEz9YnwST3h+hvKwzcZ2goFNzntVK3tnzIrROmZg3p98
         rh2MhHpVA+55RZoGGNizCDunf0qSYl0c3IV6votLh4wmTtV9nIbwVJu0wLfXBnKBve5p
         z2IdSd6D2N/4DEfjMp1bih6isRi7nB6oyKb0vXlk6Z9aNMxdT6XiCBBuXWx8N/3MHBkV
         OKtw==
X-Forwarded-Encrypted: i=1; AJvYcCW5ofr1MmzcUtJqkSGEtdROIi7uyADDO3gx4JpfLY4k6f77RXEz1N0csazfuaCPlIucXj2BJUf9@vger.kernel.org, AJvYcCWH37Z9RNj3cMVVX4hFJLExIUlO54g+ZfDU7nmTDahLFkTxJXK9oeWfUxpj6wcBYsUJ6EtaDMUOWkfMjqo=@vger.kernel.org, AJvYcCWdShKsvfJOPCmwaTs7M9ZmXG9yJADiAG7ALd/6MhcjfyEUy6Irz6o+0TvKq+eLkVroU9wkT9WhwGtxyphD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7YBlxXJ+c36Bf9Kc1mYJSRxOhSLsHCLErjRHfXBzeth1i3vDs
	Jp98TkaONS2GG3BAF/cW2mBiFTvOnvYMVA4IPW1Z4dHpkiD1PAZe
X-Google-Smtp-Source: AGHT+IEOeA+OZ0yw9yqaKWtX6mdYBBWuDI1niDnSG6Vm6l9UwNvtICDDeaLubdhHsidrH3cNZxegXg==
X-Received: by 2002:a5d:4311:0:b0:374:c17a:55b5 with SMTP id ffacd0b85a97d-3806111a1bemr8266674f8f.14.1730203638735;
        Tue, 29 Oct 2024 05:07:18 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b13309sm12362152f8f.3.2024.10.29.05.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 05:07:18 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	ming.lei@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	vschneid@redhat.com,
	Jens Axboe <axboe@kernel.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v3 0/3] genirq/cpuhotplug: Adjust managed interrupts according to change of housekeeping cpumask
Date: Tue, 29 Oct 2024 14:05:31 +0200
Message-ID: <20241029120534.3983734-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
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

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

Changes in v3:
- Address the comments by Thomas Gleixner.

Changes in v2:
- Focus in this patch series on managed interrupts only.
- https://lore.kernel.org/lkml/20240916122044.3056787-1-costa.shul@redhat.com/

Changes in v1:
- https://lore.kernel.org/lkml/20240516190437.3545310-1-costa.shul@redhat.com/

References:
- Linux Kernel Dynamic CPU Isolation: https://pretalx.com/devconf-us-2024/talk/AZBQLE/

Costa Shulyupin (3):
  sched/isolation: Add infrastructure for dynamic CPU isolation
  DO NOT MERGE: test for managed irqs adjustment
  genirq/cpuhotplug: Adjust managed irqs according to change of
    housekeeping CPU

 block/blk-mq.c           |  19 +++++++
 include/linux/blk-mq.h   |   2 +
 include/linux/cpu.h      |   4 ++
 include/linux/irq.h      |   2 +
 kernel/cgroup/cpuset.c   |   1 +
 kernel/cpu.c             |   2 +-
 kernel/irq/cpuhotplug.c  |  99 +++++++++++++++++++++++++++++++++
 kernel/sched/isolation.c |  51 +++++++++++++++--
 tests/managed_irq.sh     | 116 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 291 insertions(+), 5 deletions(-)
 create mode 100755 tests/managed_irq.sh

-- 
2.47.0


