Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C06515539
	for <lists+cgroups@lfdr.de>; Fri, 29 Apr 2022 22:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380581AbiD2UPG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Apr 2022 16:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380570AbiD2UPE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Apr 2022 16:15:04 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3B63BBDF
        for <cgroups@vger.kernel.org>; Fri, 29 Apr 2022 13:11:45 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o7-20020a17090a0a0700b001d93c491131so7348591pjo.6
        for <cgroups@vger.kernel.org>; Fri, 29 Apr 2022 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=an+yRArve5ZrSQoHDO73aNF7aPP+aWpAaWAPrlB9pIk=;
        b=rVCOmuzI6Jkg0VCtxq3Vv4tNhvcYa/7dy0aktfX+JU+3ABY/r1NuUYg6gNufzdzZyl
         TDx1/jOeHCUYV9kesQSDCM7gJuIkuCPZ3CI4xBiGyBYzao4KJxWyjV/wpOnUty7d2gkO
         xxgzezsPH49IA+C2wqMwqPUxHg+sr/u2pJ62e25BKh1gnBlY4tBxVuP6uCBRMMN8Bn0A
         o1aa0m514YE3U+J37NsZZ2A48FIIXDI4WlykXmRNEDZ9x5sTM9dO2kFgrvtI4EV9z//v
         PwFQ3hahtu5wgS2IyOj4qxw1dMwLZ0jJ58K/MjgmBn8W0hkXkDKsnnvkTtmina/ADpu8
         G4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=an+yRArve5ZrSQoHDO73aNF7aPP+aWpAaWAPrlB9pIk=;
        b=Ko2bdtdNeBSraj7n/df7m5zAh3Qf83jKKKTOTZ4vkEXWLpKoyJOewK01X8kd3yOBC6
         1eBahqTcb1DZ01I1T5Dbq/rl81eaLoBR07AdY4rIivAZGweDSFohvj7B44RqhyF2nEXc
         kQdn9ylRcaD9rcxMkQ81YNyUhHrWgBUf6sEMgb3iZFLi/+kFqk7V3X81qq8yO6iDkrUX
         tnT6l3FQClTFKebzlZBHQbj85859cZ+orprNbb1kYw7Qn5HiPzUfLqByT/Lm2IVrACyX
         6kMyiv1oownE1dRLHnWxMRJ6wSgSVWtcTqP+038+7Dsq5KzlBEuGDt6j4lwlWLe9RZNK
         VXNA==
X-Gm-Message-State: AOAM530pGhcBZ/mowlefSzUm+h+rtDOplZMMrohWX6b5Dkl5tZNE+vF3
        RGiNh6nLY5g6sUDzAJlnffjgd2F9iN83lSQZ
X-Google-Smtp-Source: ABdhPJxGZ1WYv4PcG6KKKG7/eOxb6RjoyzIw3GgB/7NGUVZUE3/7d2UGeWsMnv6NDpe3G1grI1WrkTwZdxjSyZ2c
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:e510:b0:1d9:ee23:9fa1 with SMTP
 id t16-20020a17090ae51000b001d9ee239fa1mr438392pjy.0.1651263104394; Fri, 29
 Apr 2022 13:11:44 -0700 (PDT)
Date:   Fri, 29 Apr 2022 20:11:27 +0000
Message-Id: <20220429201131.3397875-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 0/4] KVM: mm: count KVM mmu usage in memory stats
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Oliver Upton <oupton@google.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We keep track of several kernel memory stats (total kernel memory, page
tables, stack, vmalloc, etc) on multiple levels (global, per-node,
per-memcg, etc). These stats give insights to users to how much memory
is used by the kernel and for what purposes.

Currently, memory used by kvm mmu is not accounted in any of those
kernel memory stats. This patch series accounts the memory pages
used by KVM for page tables in those stats in a new
NR_SECONDARY_PAGETABLE stat.

---

Changes in V4:
- Changed accounting hooks in arm64 to only account s2 page tables and
  refactored them to a much cleaner form, based on recommendations from
  Oliver Upton and Marc Zyngier.
- Dropped patches for mips and riscv. I am not interested in those archs
  anyway and don't have the resources to test them. I posted them for
  completeness but it doesn't seem like anyone was interested.

Changes in V3:
- Added NR_SECONDARY_PAGETABLE instead of piggybacking on NR_PAGETABLE
  stats.

Changes in V2:
- Added accounting stats for other archs than x86.
- Changed locations in the code where x86 KVM page table stats were
  accounted based on suggestions from Sean Christopherson.

---

Yosry Ahmed (4):
  mm: add NR_SECONDARY_PAGETABLE to count secondary page table uses.
  KVM: mmu: add a helper to account memory used by KVM mmu.
  KVM: x86/mmu: count KVM mmu usage in secondary pagetable stats.
  KVM: arm64/mmu: count KVM s2 mmu usage in secondary pagetable stats

 Documentation/admin-guide/cgroup-v2.rst |  5 ++++
 Documentation/filesystems/proc.rst      |  4 +++
 arch/arm64/kvm/mmu.c                    | 35 ++++++++++++++++++++++---
 arch/x86/kvm/mmu/mmu.c                  | 16 +++++++++--
 arch/x86/kvm/mmu/tdp_mmu.c              | 16 +++++++++--
 drivers/base/node.c                     |  2 ++
 fs/proc/meminfo.c                       |  2 ++
 include/linux/kvm_host.h                |  9 +++++++
 include/linux/mmzone.h                  |  1 +
 mm/memcontrol.c                         |  1 +
 mm/page_alloc.c                         |  6 ++++-
 mm/vmstat.c                             |  1 +
 12 files changed, 89 insertions(+), 9 deletions(-)

-- 
2.36.0.464.gb9c8b46e94-goog

