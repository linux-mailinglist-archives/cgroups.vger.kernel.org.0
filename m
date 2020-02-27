Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A542172903
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2020 20:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbgB0T4N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Feb 2020 14:56:13 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36616 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbgB0T4N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Feb 2020 14:56:13 -0500
Received: by mail-qt1-f196.google.com with SMTP id t13so247445qto.3
        for <cgroups@vger.kernel.org>; Thu, 27 Feb 2020 11:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHZKSP3VYnp46GXjDiGlb2OsfVMbe+Fm/ufXK0JaZec=;
        b=ghhFE02MoIHofcbDHVRBX9U/7eYfI4j70g1jWmFx0XEAoGpx7H47Gm0IWki1DRpFWc
         AqetnajsS/aYstusDRdzWPmEqTkl4wXNs/GAvuHu+DaaQM59ogrAZGzjP0MCSo19sPDL
         Poe40EqlTElaA/+u1CqJaB2Z6SxWrAQw6x9MBcfaUuZoc51ePJ+a3oYqcvBWc0OBDBry
         h8ctnmZ6CZdjFXHF2seaePaRSJrTPH8gi7/+I0suTK/cROfvShjCwDl5XMmcxabuH+Jq
         JbVgIl+KZ5Ygbamyx4ahqc89JV07ytB/RvEZSH6GcE+40H9BMjdM4i0yhnwIUqYm/xka
         U1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pHZKSP3VYnp46GXjDiGlb2OsfVMbe+Fm/ufXK0JaZec=;
        b=Qd4CTo/yErGbds87o9Phllz5HUtWC4q/VjNrREf9TOKdaDhXTimJB1zJNtAvne0WTJ
         /HNnfhfpj60BaugTH/SI5dQ5C0+RG1IK7roWNjdrEbb44R8iEgf03aTSV/XNA67tGvp6
         pDA5b8wVKK96FRuUWU9aCfriQ8/MgVr8HrlcU/uskLKHIObhqhz1vggRCLWf2CSNntD9
         D+c69jlcOlzCRdc+OMpgfEI6hyLOVZzavGaSZ+nF/wuwfqRlag1v3Yf8VGj43i5DBJbm
         +S9yMJ74q2wECYyEv2beLh9w2BWzV/BPMfY/Wjd+kGMgx7cu07WPU4WbrDXto6oMPnQo
         fhOA==
X-Gm-Message-State: APjAAAUNVQmSzzHQtAalyihdigEkMJdcJ+CtSJo28SumAzynsX1K7SeE
        vggqAEqzwoPmE8QaP2vT7KM9EA==
X-Google-Smtp-Source: APXvYqzh0jqRZctAqyIQSv9JTnGx+dvR+KkZIYZ3fOMX0S/d4oZuqtuZNihdMoguFDPnTcO4mHEgzQ==
X-Received: by 2002:ac8:1a30:: with SMTP id v45mr958788qtj.80.1582833371894;
        Thu, 27 Feb 2020 11:56:11 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:2450])
        by smtp.gmail.com with ESMTPSA id o17sm3788427qtj.80.2020.02.27.11.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:56:11 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] mm: memcontrol: recursive memory.low protection
Date:   Thu, 27 Feb 2020 14:56:03 -0500
Message-Id: <20200227195606.46212-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Changes since v2:
- Changelog & documentation updates (Michal Hocko, Michal Koutny)

Changes since v1:
- improved Changelogs based on the discussion with Roman. Thanks!
- fix div0 when recursive & fixed protection is combined
- fix an unused compiler warning

The current memory.low (and memory.min) semantics require protection
to be assigned to a cgroup in an untinterrupted chain from the
top-level cgroup all the way to the leaf.

In practice, we want to protect entire cgroup subtrees from each other
(system management software vs. workload), but we would like the VM to
balance memory optimally *within* each subtree, without having to make
explicit weight allocations among individual components. The current
semantics make that impossible.

They also introduce unmanageable complexity into more advanced
resource trees. For example:

          host root
          `- system.slice
             `- rpm upgrades
             `- logging
          `- workload.slice
             `- a container
                `- system.slice
                `- workload.slice
                   `- job A
                      `- component 1
                      `- component 2
                   `- job B

From a host-level perspective, we would like to protect the outer
workload.slice subtree as a whole from rpm upgrades, logging etc. But
for that to be effective, right now we'd have to propagate it down
through the container, the inner workload.slice, into the job cgroup
and ultimately the component cgroups where memory is actually,
physically allocated. This may cross several tree delegation points
and namespace boundaries, which make such a setup near impossible.

CPU and IO on the other hand are already distributed recursively. The
user would simply configure allowances at the host level, and they
would apply to the entire subtree without any downward propagation.

To enable the above-mentioned usecases and bring memory in line with
other resource controllers, this patch series extends memory.low/min
such that settings apply recursively to the entire subtree. Users can
still assign explicit shares in subgroups, but if they don't, any
ancestral protection will be distributed such that children compete
freely amongst each other - as if no memory control were enabled
inside the subtree - but enjoy protection from neighboring trees.

In the above example, the user would then be able to configure shares
of CPU, IO and memory at the host level to comprehensively protect and
isolate the workload.slice as a whole from system.slice activity.

Patch #1 fixes an existing bug that can give a cgroup tree more
protection than it should receive as per ancestor configuration.

Patch #2 simplifies and documents the existing code to make it easier
to reason about the changes in the next patch.

Patch #3 finally implements recursive memory protection semantics.

Because of a risk of regressing legacy setups, the new semantics are
hidden behind a cgroup2 mount option, 'memory_recursiveprot'.

More details in patch #3.

 Documentation/admin-guide/cgroup-v2.rst |  11 ++
 include/linux/cgroup-defs.h             |   5 +
 kernel/cgroup/cgroup.c                  |  17 ++-
 mm/memcontrol.c                         | 220 +++++++++++++++++-------------
 mm/page_counter.c                       |  12 +-
 5 files changed, 160 insertions(+), 105 deletions(-)


