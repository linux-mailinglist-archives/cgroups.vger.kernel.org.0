Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1C1126E61
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2019 21:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfLSUHa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Dec 2019 15:07:30 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42157 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfLSUH3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Dec 2019 15:07:29 -0500
Received: by mail-qv1-f68.google.com with SMTP id dc14so2722964qvb.9
        for <cgroups@vger.kernel.org>; Thu, 19 Dec 2019 12:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYiIu2mk1O8LA2y0MiTcNVGhftZjp6jwMi9mmwJQac4=;
        b=fj3AGRXKmJEfNgQiRcISC7HVWkSocovlBpyW/qprUYO7Mqg0zHOgkFsuEL7bj09x0e
         GNo2GUYrsgl7gu9dZcbcOreUdSZizGPe/8vnYBkegdu2BxjdPOUvTm4HQ1/a3N5I0rXy
         9qpO/VYJ59U2ZDJGyC2A1xNdpYrFDsJ9gEb5CkN+86hhOcJ6Cn8RTlBgbbxf4iDPI0Tg
         YA+xDeChfCuXtKz4PvRQ6A8oZN68sfPVub+RuWdmP+SXFjeLsXVA8d9CtSWvc4YGlADS
         a3oNuCkGPu+UUDyczUUDqcEq9SzvZUSvXzvruEBOZhoP+9RWO3jTbPYNnqin1YdpVr/y
         er1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYiIu2mk1O8LA2y0MiTcNVGhftZjp6jwMi9mmwJQac4=;
        b=g/5KHvZZBrQHc40PxvIVHvf0aMP7ETika25ru0w+nrMRf0AMCqYcNt/u1foL684dT+
         7c3i+wAdngC5cNlXGXiCss2VCCVsWgaziqMOme05dU4EIyW6THXHJGQGQJ+RlaIHRdMv
         OoIZY5M5I39oII8QmeI5/AlWFv/N9BY0CsaiEfdhUP3SIvRKBi9KIOjTxp4qAUSAClP4
         bCZBqO8l5m6fJyVRes4zI1xC4okI1iqQJaRWsZwsPSbgkMaYAUtk2gfleEqtanWrefxf
         5XIJgn6LRGrAxYw8pqYPBJcOmMrqNmIeG/O7MwlE5m3PqURVqGq90enuOxzztIuzhaQQ
         qjiA==
X-Gm-Message-State: APjAAAX9ChBiz38HcC5N5N1BQc4x9wZS6rLej4sKsS0jja19Zv8I0NGx
        8Du8JRY4IpznSC6nehcMghdbkw==
X-Google-Smtp-Source: APXvYqw9MlnwX1RpRt+FpodJ+Md/4AlRpjp73kv5sZLkkuJshWziV52bT3S99wB33K3ObJsu/FL+bg==
X-Received: by 2002:ad4:450a:: with SMTP id k10mr8841247qvu.136.1576786048621;
        Thu, 19 Dec 2019 12:07:28 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::91a1])
        by smtp.gmail.com with ESMTPSA id g21sm1995456qkl.116.2019.12.19.12.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:07:27 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 0/3] mm: memcontrol: recursive memory protection
Date:   Thu, 19 Dec 2019 15:07:15 -0500
Message-Id: <20191219200718.15696-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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

This patch series extends memory.low/min such that the knobs apply
recursively to the entire subtree. Users can still assign explicit
protection to subgroups, but if they don't, the protection set by the
parent cgroup will be distributed dynamically such that children
compete freely - as if no memory control were enabled inside the
subtree - but enjoy protection from neighboring trees.

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
 mm/memcontrol.c                         | 243 +++++++++++++++++++-----------
 mm/page_counter.c                       |  12 +-
 5 files changed, 192 insertions(+), 96 deletions(-)


