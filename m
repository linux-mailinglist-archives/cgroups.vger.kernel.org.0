Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A108F391CD2
	for <lists+cgroups@lfdr.de>; Wed, 26 May 2021 18:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhEZQTx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 May 2021 12:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhEZQTw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 May 2021 12:19:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6B2C061574
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 09:18:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso637080pjq.3
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A0w/o3IkjMbtzBP+G5B7RkNRxwztBrjISmACawCMzhc=;
        b=BzhDZu2ZZfru6U5oCb5BuNBaDkOXDDmaGoh9ZU4xsSlhADs1QRoctIFAj4OB+56NtW
         cS3vx8lvM1pT3lqCZOeMHAGgGF85CNGH7vd8UxYSKanRD288+mz2AXdrCZTmKTqjJiVj
         hN/7NL6lGceX+7YklcQSnP29WGQ2s4ezLgmhy9Jed5XTpz/IKptb8Y1KlnPC0crLxCbN
         IknFuUNLAa19NEvBu/HG8POdOBtEPWtIZKo9yhZPnobFAFOICR6e3KO+FAiDU81jOGyb
         velQ4TlIMO7c62fcM8fZvocIaWL3ZmwYTYE7vTGccl/ex2qts0mDyDqTXNh1vXmEuE/n
         kExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A0w/o3IkjMbtzBP+G5B7RkNRxwztBrjISmACawCMzhc=;
        b=chBFXwjrW4m51eXYbpSns8oZIGnvprZhDw15c6RTq/1wTOM3JPGR2w88XwHd7ib2WX
         +mvI2L2bU0VOC8ZlSSMvklykESnNg805ObMfxlPIQ2+ImuNKS2Lx9O2bh5w5mq4FG83D
         f4ax+BxeNIWgMObrw13MJ/znsQrZzWB1z3xw6i1cdcUvrMonlTLhEZn3BwW1+DUQzoOh
         kGGuK8TxfVHR5lES1MDMUmfcfMEeBqVsR9JIshgCz1N0SkYx2krEOQq7EraJU4QyLxbz
         Db81sxT1iO97p6wYc9oe1j3p2hRiw7gaJZx92c/sg/qRFkqOhOsdMDIj6wFh6D/BFXpa
         OQuQ==
X-Gm-Message-State: AOAM533qKNsIGp48ZuCqZwS7DsIeJbHHPFl+xeGKrhMbmD2xNteDYOYp
        3xATYQp9vGpG4nZiK4BqnRY=
X-Google-Smtp-Source: ABdhPJwrN7XZ2/n8hYqla7p4gVwOog4RkAolnECvlGaju4zXuMKijaBkkHnQKSmxjvWsPDeZxQE3vQ==
X-Received: by 2002:a17:90a:9704:: with SMTP id x4mr4646032pjo.202.1622045900059;
        Wed, 26 May 2021 09:18:20 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id v2sm15950447pfm.134.2021.05.26.09.18.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 09:18:19 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        christian@brauner.io
Cc:     cgroups@vger.kernel.org, benbjiang@tencent.com,
        kernellwp@gmail.com, Yulei Zhang <yuleixzhang@tencent.com>
Subject: [RFC 0/7] Introduce memory allocation speed throttle in memcg
Date:   Thu, 27 May 2021 00:17:57 +0800
Message-Id: <cover.1622043596.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

In this patch set we present the idea to suppress the memory allocation
speed in memory cgroup, which aims to avoid direct reclaim caused by
memory allocation burst while under memory pressure.

As minimum watermark could be easily broken if certain tasks allocate
massive amount of memory in a short period of time, in that case it will
trigger the direct memory reclaim and cause unacceptable jitters for
latency critical tasks, such as guaranteed pod task in K8s.

With memory allocation speed throttle(mst) mechanism we could lower the
memory allocation speed in certian cgroup, usually for low priority tasks,
so that could avoid the direct memory reclaim in time.

And per-memcg interfaces are introduced under memcg tree, not visiable for
root memcg.
- <cgroup_root>/<cgroup_name>/memory.alloc_bps
 - 0 -> means memory speed throttle disabled
 - non-zero -> value in bytes for memory allocation speed limits

- <cgroup_root>/<cgroup_name>/memory.stat:mst_mem_spd_max
  it records the max memory allocation speed of the memory cgroup in the
  last period of time slice

- <cgroup_root>/<cgroup_name>/memory.stat:mst_nr_throttled
  it represents the number of times for allocation throttling

Yulei Zhang (7):
  mm: record total charge and max speed counter in memcg
  mm: introduce alloc_bps to memcg for memory allocation speed throttle
  mm: memory allocation speed throttle setup in hierarchy
  mm: introduce slice analysis into memory speed throttle mechanism
  mm: introduce memory allocation speed throttle
  mm: record the numbers of memory allocation throttle
  mm: introduce mst low and min watermark

 include/linux/memcontrol.h   |  23 +++
 include/linux/page_counter.h |   8 +
 init/Kconfig                 |   8 +
 mm/memcontrol.c              | 295 +++++++++++++++++++++++++++++++++++
 mm/page_counter.c            |  39 +++++
 5 files changed, 373 insertions(+)

-- 
2.28.0

