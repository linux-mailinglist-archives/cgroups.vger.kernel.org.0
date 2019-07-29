Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A4578ED3
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2019 17:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfG2PNo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jul 2019 11:13:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33313 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfG2PNo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jul 2019 11:13:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id f20so19188411pgj.0;
        Mon, 29 Jul 2019 08:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CReZX3ZIW9UVm3F381oja+qdURlLghUskZk6mGhexL4=;
        b=DF5eQiR/9iQxp/I05TpQxh96+yZz7SV9RG6uhl8zm5tQDkywRpo7tBrHo6+JYi9DMP
         aIHtjuXNygQy++dokdfX3GdSr9dlSz9bgGKf6DU4b9xcRtUDPafirv5OFFt7xntBUlZn
         j9XvmuoU2MOmMqnoKS+Lf5IRijAZXLO3YL5YivUqg9npFcmjI7ffrnyM4bxclXLs+p3V
         89IiySx2lv/p3CIxLGE/Lan/Kj6cJbPLYkh7Npa85VJ89wVuDve2mibdyFGFJyGUsvSq
         UdQYN969Ua7dgZYoTV74bAdwxPJ56h4tOpoaX8SKamq34W+W1tIrFUBiMsFps7A/3pBX
         3Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CReZX3ZIW9UVm3F381oja+qdURlLghUskZk6mGhexL4=;
        b=NPxkspTDJFyFQibADXQUIiq1bAZx+9WbrRHocrZG1WUVwNa46G4C3UDLvxr/vZUXv1
         pNig3bmR0+8khKEnwumTk7dapvg55wqbQVt/CMSaNShidUQDj2pmxhQ7x03js6lRp4B8
         tUiaG/ANJw41KwEV35yaGg+FoLcflXmcB+z2TXDZk2u+6hWRV1rHGODnG+IGnYvS3s93
         5X516HNC00WHT5AADrjMXXtAWfm5mh8BQh9BTski2+/rrHDHwfssMwwW5QCwQrVXsM8H
         utKPeQa5P95+RMBZi5g8IG78kWbY3NMWced6QGg0bpet+c/teNd7hGR7lfB9mryQiCc/
         PLIA==
X-Gm-Message-State: APjAAAVH4ihe5WZKK91DPtMPTV3Me732kspcPsDMt2TDWUFPHUqjYFEH
        qq0V3VLM3UYamOOc6CO22iM=
X-Google-Smtp-Source: APXvYqxycRdMpLgXrpeUG1h0C8XXmc1sTfWKOqLpMdVBbrO+ryHMITBy2w3gpaZ3FHBwmuORXJgyLw==
X-Received: by 2002:a63:6056:: with SMTP id u83mr100397059pgb.181.1564413223953;
        Mon, 29 Jul 2019 08:13:43 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id v184sm57845951pgd.34.2019.07.29.08.13.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:13:43 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jessica Yu <jeyu@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 00/12] Replace strncmp with str_has_prefix
Date:   Mon, 29 Jul 2019 23:13:23 +0800
Message-Id: <20190729151323.9226-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The commit 72921427d46b
("string.h: Add str_has_prefix() helper function")
introduced str_has_prefix() to substitute error-prone
strncmp(str, const, len).

The commit b6b2735514bc
("tracing: Use str_has_prefix() instead of using fixed sizes")
has fixed some codes.

These patches use str_has_prefix to replace
such pattern of strncmp usages.

Chuhong Yuan (12):
  rdmacg: Replace strncmp with str_has_prefix
  kdb: Replace strncmp with str_has_prefix
  dma-debug: Replace strncmp with str_has_prefix
  gcov: Replace strncmp with str_has_prefix
  genirq/debugfs: Replace strncmp with str_has_prefix
  module: Replace strncmp with str_has_prefix
  power: Replace strncmp with str_has_prefix
  printk: Replace strncmp with str_has_prefix
  reboot: Replace strncmp with str_has_prefix
  sched: Replace strncmp with str_has_prefix
  userns: Replace strncmp with str_has_prefix
  watchdog: Replace strncmp with str_has_prefix

 kernel/cgroup/rdma.c        | 2 +-
 kernel/debug/kdb/kdb_main.c | 2 +-
 kernel/dma/debug.c          | 2 +-
 kernel/gcov/fs.c            | 2 +-
 kernel/irq/debugfs.c        | 2 +-
 kernel/module.c             | 2 +-
 kernel/power/hibernate.c    | 8 ++++----
 kernel/power/main.c         | 2 +-
 kernel/printk/braille.c     | 4 ++--
 kernel/printk/printk.c      | 6 +++---
 kernel/reboot.c             | 2 +-
 kernel/sched/debug.c        | 2 +-
 kernel/sched/isolation.c    | 4 ++--
 kernel/user_namespace.c     | 4 ++--
 kernel/watchdog.c           | 8 ++++----
 15 files changed, 26 insertions(+), 26 deletions(-)

-- 
2.20.1

