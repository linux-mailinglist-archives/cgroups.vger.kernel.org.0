Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB1B367D2B
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 11:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhDVJGw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 05:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhDVJGv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Apr 2021 05:06:51 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0914DC06174A
        for <cgroups@vger.kernel.org>; Thu, 22 Apr 2021 02:06:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y62so7400237pfg.4
        for <cgroups@vger.kernel.org>; Thu, 22 Apr 2021 02:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EYXXwg5Y7nC4zs4zd2VmOocoYMpttk3QU3l+Cpc74uo=;
        b=YXceGHI6kIHAxxpMboOHb4OMSuGJ1q1HQYajf8Oq91oaFhbUUXfo9Ss0O8W2UcJ1PB
         q492iPRf6fKko2cX3x0i2aKzA4lD1NiIKEuEKU1e94mzyqcqwzkiNXDr4icU0y1+YS88
         BOnXqeFXYHoNAeJoNfg1DGIj0EKEG8UPfAIrO5s739t5F1RmzCkuCV7DY+Led05gXT6G
         j7kwgC1EULkycVVIVdmDJHm2j0KgH3hTDq81cRGMjwpdEivWXbzcVMwFL3bhUKPClb5d
         IIJiclrreuoAp4iWy7dVXZCLp2Uz4JK3fZpuOjyL8OnoR5NFeiUTPd99eOG8a206hmxw
         Iy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EYXXwg5Y7nC4zs4zd2VmOocoYMpttk3QU3l+Cpc74uo=;
        b=D2Q/HgXYkCXtoG5cP7oQwlIUfJ6iqksHdixJNbG/BuKeEWF5QIfksBdLPk06/QS4HU
         w5zdKIdvrAeHt46Sryillr4CpDnJI1PSkNtk5TZSBzCEG3dFk/t81FeROoS5NS9dBvBk
         2KllkcQX3pdesOxf0kwRZ+uBRrL326uGW/u8LFbgUG4M4HbTgH2T0UizzVqTNT6Pwu17
         XMz2dDoZ+vt2OFWASZBpXfAiuuXKBsa8NUR4Fm1CZhMAEd24jLES3TZ6enTuR7+hIpQo
         MWrJy4cGj3d2TT2wb8LiryI/z0i5AC+Dm5+dAzpf3J9+XKs9gZWq6JJQQZN0qTRtEbbK
         b2yw==
X-Gm-Message-State: AOAM533MG4pSWZ5GmMDygy0XfUJtUTGSRgWaXtKH3GAH7gKKdzNqc5d9
        Z4+tGTtdN313STmv9Dh+UusClw==
X-Google-Smtp-Source: ABdhPJwWIXi27dzgUehhcvPRdxYt9NyqBzE5Fa2wtOl5sxNCDxs5johDTxYr7yVso9SJcHb+1/p7gQ==
X-Received: by 2002:a65:6095:: with SMTP id t21mr2513990pgu.383.1619082374302;
        Thu, 22 Apr 2021 02:06:14 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id x2sm1514348pfu.77.2021.04.22.02.06.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Apr 2021 02:06:14 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     akpm@linux-foundation.org, lizefan.x@bytedance.com, tj@kernel.org,
        hannes@cmpxchg.org, corbet@lwn.net
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/3] cgroup2: introduce cpuset.mems.migration
Date:   Thu, 22 Apr 2021 17:06:05 +0800
Message-Id: <20210422090608.7160-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Some of our services are quite performance sensitive and
actually NUMA-aware designed, aka numa-service. The SLOs
can be easily violated when co-locate numa-services with
other workloads. Thus they are granted to occupy the whole
NUMA node and when such assignment applies, the workload
on that node needs to be moved away fast and complete.

This new cgroup v2 interface is an enhancement of cgroup
v1 interface cpuset.memory_migrate by adding a new mode
called "lazy". With the help of the "lazy" mode migration
we solved the aforementioned problem on fast eviction.

Patch 1 applies cpusets limits to tasks that using default
memory policies, which makes pages inside mems_allowed are
preferred when autoNUMA is enabled. This is also necessary
for the “lazy” mode of cpuset.mems.migration.

Patch 2&3 introduce cpuset.mems.migration, see the patches
for detailed information please.

Abel Wu (3):
  mm/mempolicy: apply cpuset limits to tasks using default policy
  cgroup/cpuset: introduce cpuset.mems.migration
  docs/admin-guide/cgroup-v2: add cpuset.mems.migration

 Documentation/admin-guide/cgroup-v2.rst |  36 ++++++++
 kernel/cgroup/cpuset.c                  | 104 +++++++++++++++++++-----
 mm/mempolicy.c                          |   7 +-
 3 files changed, 124 insertions(+), 23 deletions(-)

-- 
2.31.1

