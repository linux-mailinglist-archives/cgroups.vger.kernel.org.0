Return-Path: <cgroups+bounces-2934-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A131C8C7CFB
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 21:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E8EAB22674
	for <lists+cgroups@lfdr.de>; Thu, 16 May 2024 19:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917B6157A55;
	Thu, 16 May 2024 19:07:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2232157A53;
	Thu, 16 May 2024 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886440; cv=none; b=pHd2T977uXCkLabNamcHuSp+XmGlmmHcBy5mJ/Gi/TKHE3yodt1gkggfSqwCxDuGQerR5p+1NgzxwafRzJQostBMTdfBcgzOPAyd0soO8GP8G+/NzwIY0h2wM4pIhCOU/iKwNt/dilz6ypTWV7smblzyem6cUz3Ij7+N+8y1NlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886440; c=relaxed/simple;
	bh=MHoT4Jo3RAzz8eEtqv+1iklBPBBHf3L8xhNTgPY77mk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=b5LGj4UH74bPdvMDZ58/raUYdUo/fuDZgl74dhALsDgCBtQNA9fLy0EEItwKmHzRpHqZOEBRBWR4JZSVhZa8yRLM4PuyV6YT6V8YIrEEPgPG50fSqbcocZr1xxWk//7zV05crclIc1CknynM0vZXw+8VNPxWfDyq/z9XZILFWB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4202cea9a2fso6606215e9.3;
        Thu, 16 May 2024 12:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715886437; x=1716491237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TGl25VI/bdS9cA0cwaeR3veGamr8DGMylL6oozmJjQ8=;
        b=Q3EfbISFKyD1A/FwAF8KVvvIJ6CxUPtTUfX/dayyD/Hmn9JkBUL3E+9krxTt12rHkr
         Yy2CNf7o8XjBekzZ6X7rTwNc6MINBP8nIYy85GMijoTZ22vdmkzOjuzwzj75WKa3o5UH
         D3Ilru+TG6N5a5IXgct1FDtGy0mwOys2fRnLp7VBy6Gqvmgsc2u1IoP1Xez7RRHjSXbB
         Qk1tBKlONVnvKEUZYnNVySSUXnsh368G4SsYeixi/I9/tG5v4UoGysDnEDhZZyU97Xgf
         kL87o30pH7FUQYAoterl5/HlGkrsZxOEFm/HNKmgiyNOZq8qqcv1rYbLgEIi/Y9mAWiE
         cE8g==
X-Forwarded-Encrypted: i=1; AJvYcCVDPeNhvNFzTcUJnUajeOzqPuAmcz53AA1jzVo1Nd3GdnltCX1O0WMJGnQFpIriDHGumxJHg01KKWL6XRpzgMwd702CKGim93IYPO6Aen1PCkEkHHrQCCNdlB8cAj4dKjsqaPQxYA==
X-Gm-Message-State: AOJu0Yx64P/eAkWtEVEomprRprqW1l9i7R0NDixlDaMJ9Ai5zb2nz/EV
	g1zq89ZERPdOUnjFaanD0jiUolU441NbNaEwRk2iAk6VQmWMPwrL
X-Google-Smtp-Source: AGHT+IHU5PR5Vspk+t1XLlDt07CkPjZ43WOOq9u4XxhlmWZ+EEOyNz1/pOKCz5lmgQmKNi0bY+Qa4A==
X-Received: by 2002:a05:600c:5008:b0:41b:dca6:a3fa with SMTP id 5b1f17b1804b1-41fead6dc7amr143740775e9.39.1715886436833;
        Thu, 16 May 2024 12:07:16 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a040:1a3:c059:8b18:f13e:da9b:5a8e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee9335sm275834155e9.29.2024.05.16.12.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:07:16 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: longman@redhat.com,
	pauld@redhat.com,
	juri.lelli@redhat.com,
	prarit@redhat.com,
	vschneid@redhat.com,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Zefan Li <lizefan.x@bytedance.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Petr Mladek <pmladek@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yoann Congal <yoann.congal@smile.fr>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [PATCH v1 0/7] sched: Adjust affinity according to change of housekeeping cpumask
Date: Thu, 16 May 2024 22:04:30 +0300
Message-ID: <20240516190437.3545310-1-costa.shul@redhat.com>
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
CPUs from running some kernel housekeeping facilities to minimize
disturbance to latency sensitive userspace applications such as DPDK.

However, these options can have negative consequences for "normal"
workloads. Both nohz_full and rcu_nocbs can be applied to a subset of
the CPUs on a server (so as to not impact the "normal" workloads), but
they can only be changed with a reboot. This is a problem for
containerized workloads running on OpenShift (i.e. kubernetes) where a
mix of low latency and "normal" workloads can be created/destroyed
dynamically and the number of CPUs allocated to each workload is often
not known at boot time.

This series of patches is based on series
"isolation: Exclude dynamically isolated CPUs from housekeeping masks"
https://lore.kernel.org/lkml/20240229021414.508972-1-longman@redhat.com/
Its purpose is to exclude dynamically isolated CPUs from some
housekeeping masks so that subsystems that check the housekeeping masks
at run time will not use those isolated CPUs.

However, some of subsystems can use obsolete housekeeping CPU masks.
Therefore, to prevent the use of these isolated CPUs, it is necessary to
explicitly propagate changes of the housekeeping masks to all subsystems
depending on the mask.

Costa Shulyupin (7):
  sched/isolation: Add infrastructure to adjust affinity for dynamic CPU
    isolation
  sched/isolation: Adjust affinity of timers according to change of
    housekeeping cpumask
  sched/isolation: Adjust affinity of hrtimers according to change of
    housekeeping cpumask
  sched/isolation: Adjust affinity of managed irqs according to change
    of housekeeping cpumask
  [NOT-FOR-MERGE] test timers affinity adjustment
  [NOT-FOR-MERGE] test timers and hrtimers affinity adjustment
  [NOT-FOR-MERGE] test managed irqs affinity adjustment

 include/linux/hrtimer.h  |   2 +
 include/linux/timer.h    |   2 +
 init/Kconfig             |   1 +
 kernel/cgroup/cpuset.c   |   3 +-
 kernel/sched/isolation.c | 119 +++++++++++++++++++++++++++++++++++++--
 kernel/time/hrtimer.c    |  81 ++++++++++++++++++++++++++
 kernel/time/timer.c      |  64 +++++++++++++++++++++
 tests/managed_irq.c      |  71 +++++++++++++++++++++++
 tests/timers.c           |  58 +++++++++++++++++++
 9 files changed, 395 insertions(+), 6 deletions(-)
 create mode 100644 tests/managed_irq.c
 create mode 100644 tests/timers.c

-- 
2.45.0


