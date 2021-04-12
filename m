Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08DB35CEDA
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbhDLQvI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 12:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345705AbhDLQrr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 12:47:47 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A285C06138D
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 09:45:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p67so4610472pfp.10
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 09:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rWd8qaffFtx7x0KdjfNiWGmezRnoMswRgKduJuFiO4A=;
        b=WEvsRmRxGAgXGh1Q+11q9oWawxwjMoAvDbSSeSLffAn+syXlTlKtqPce9hXAFsv1EQ
         Qb4wTXhTPMBsqKmhqz0/FGvuIwxwgtJg/ztFW9/GLhJ0DMS/jmc+AEkeZTG6K24Bu3oO
         XOh/0L2v5CfHP3Osp9aiNhDOgLXTApyKFSkZDjb6zsqHDa87D1g77S0vJJ8Oao9Tb0hV
         WO6V/slUu9coDshH8er9wOtVgm4guloaK/+HnxPUu/OvUSfysY50fvvNRDp16cfDlufZ
         knvN/TZXW1z20kQLfNVlBKXRGBADo7+gJzufp5eLhx0LmORqOs+NOCEmFRppfBV2DSrm
         sJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rWd8qaffFtx7x0KdjfNiWGmezRnoMswRgKduJuFiO4A=;
        b=f7e8BtyskQyGsdLpx2Ev7JYCK4DZoZEsNi9qlvhSQiDUsxeN69Fz7YW9sAkfQ1LkRJ
         bNfCmg7iG3B5An/aWEnuFHYYM07wX31wX2dc0TT90WYilpVbZlhrs4e/MW+cVdI5wpCZ
         9pm95pD8FyJzQpv0GYvZwOMFl0sh2f9TfRT4wkeK2zl1vovbPW+paf9ma2RhcVTKoRwQ
         ddpwjiROnZfRwCiFAsZeHQM/4IN9MlSlcW+YYMYITM8/yvgm7GS+jjoHf5l551c2jVfJ
         Ns+PGoBHHYncyZcJpWOEWF+Q/yBYnjTuYT0889Kn599g1mYyVpSIP73BrSS9w5TZIv09
         7y9g==
X-Gm-Message-State: AOAM530s9/mnnbI5SPc19roXr2Z/Wr+Nq4+l87k5Rw+u+/NGElqXGIVi
        VaKTlVRuRTC2cKzbIpxbT2g=
X-Google-Smtp-Source: ABdhPJxE1QMj5dmFOIHpOhFsicaP2pgieImBKJbesUVQj22RfaT6u8HtADXlZcW4c59RwD4dNaaH3A==
X-Received: by 2002:a65:40c7:: with SMTP id u7mr27828307pgp.29.1618245932707;
        Mon, 12 Apr 2021 09:45:32 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id s21sm12704044pgl.36.2021.04.12.09.45.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 09:45:32 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        christian@brauner.io
Cc:     cgroups@vger.kernel.org, benbjiang@tencent.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        linussli@tencent.com, herberthbli@tencent.com,
        Yulei Zhang <yuleixzhang@tencent.com>
Subject: [RFC v2 0/2] introduce new attribute "priority" to control group
Date:   Tue, 13 Apr 2021 00:40:09 +0800
Message-Id: <cover.1618219939.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Last time we introduce the idea of adding prioritized tasks management
to control group. Sometimes we may assign the same amount of resources
to multiple cgroups due to the environment restriction, but we still 
hope there are preference order to handle the tasks in those cgroups,
the 'prio' attribute may help to do the ranking jobs. 

The default value of "priority" is set to 0 which means the highest
priority, and the totally levels of priority is defined by
CGROUP_PRIORITY_MAX. Each subsystem could register callback to receive the
priority change notification for their own purposes. 

In this v2 patch we apply a simple rule to the oom hanlder base on the
order of priority to demonstrate the intention about adding this attribute.
When enable the prioritized oom, it will perfer to pick up the victim from the
memory cgroup with lower priority, and try the best to keep the tasks
alive in high ranked memcg.

V2->V1:
1. Introduce prioritized oom in memcg.

Lei Chen (1):
  cgroup: add support for cgroup priority

Yulei Zhang (1):
  memcg: introduce prioritized oom in memcg

 include/linux/cgroup-defs.h |  2 +
 include/linux/cgroup.h      |  2 +
 include/linux/memcontrol.h  | 38 ++++++++++++++
 include/linux/oom.h         |  1 +
 kernel/cgroup/cgroup.c      | 90 +++++++++++++++++++++++++++++++++
 mm/memcontrol.c             | 99 ++++++++++++++++++++++++++++++++++++-
 mm/oom_kill.c               |  6 +--
 7 files changed, 233 insertions(+), 5 deletions(-)

-- 
2.28.0

