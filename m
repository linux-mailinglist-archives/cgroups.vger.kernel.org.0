Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBEA29A60B
	for <lists+cgroups@lfdr.de>; Tue, 27 Oct 2020 09:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508642AbgJ0IDP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Oct 2020 04:03:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34555 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508596AbgJ0IDO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Oct 2020 04:03:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id r3so350478plo.1
        for <cgroups@vger.kernel.org>; Tue, 27 Oct 2020 01:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kG6PqPw8H5tvrqd/aB6QZ20Kiu7xsv86CzlJPEIAW18=;
        b=CvS4lGhbaduFgXwzlkmjhkqLZ9Hbub8RGApcEu/x2HgIai6Ow8JRCxzFzMUUer/bQg
         l3YlphLdok80JRdVICtVtMdnrz7E/IIzYX5Z2KHV/3FFu9czYXaAQooNmjalAPgReeds
         rH7pI0kvJZA2YpVpZgkR4ymZIcCCRP/nzIFHLHEjBT25oI0fXea8GFaTc48z56evVCOK
         GISXlr7jEVbdJufRsIEkvdWmvWOWP2zvoo52TV8Y4Y8qzFA/sgMKuWm8k1CICy9F5ydZ
         9HJir1FdSLBiNegj458SP8b65nBbm0M7xW7k6qafuo08INH1fvs1djvDOwMtmqaEaFO6
         EyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kG6PqPw8H5tvrqd/aB6QZ20Kiu7xsv86CzlJPEIAW18=;
        b=nh8n9zCoxoXNLqy06Sc/lMbimq85uMC9O5wk22Ss2uWMJjN+bsvUPWcDnfG9x3t1W7
         0YrjqOPV3AGrlG4QH4B/dZgHfCq6ygvamsENUMJ/VF8N9vkop2Hlhx9vSQ9pkicP5td3
         1H5LQJRJfLPOWKL8km8T5ynCBFIyRF/Eim0NrSA1HnFc6QehLDownMuVG0Tp26T2+Wff
         4dJUrJJ3kDN5F5M4wiCouXMZsFiR51pQGfWtp3G6ji1hLx/Xap6PxWth3zNLCnney7VN
         7v+mcm/vVG36/1bMUks+jxI6V7Ryw99ur5G7la5LiU1MPAvjI/6gKpMNoG1v2gM/n0Xl
         y89A==
X-Gm-Message-State: AOAM530axVFfXBqRDPMgfVXDaGTSkhkb73bvrtA31b/X7Vs8FlrL1gRK
        8uSHTqg01WD4w4OVFkNBRFCT0A==
X-Google-Smtp-Source: ABdhPJzbXiMQsBgYxlsjt2Io4BYixEljD+9tk1ro5+5ZbEcMHWoNgcTxsqBcL9t2bgs7uBV4yTMXqw==
X-Received: by 2002:a17:90b:e96:: with SMTP id fv22mr907206pjb.134.1603785793701;
        Tue, 27 Oct 2020 01:03:13 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id p8sm1039580pgs.34.2020.10.27.01.03.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 01:03:12 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        iamjoonsoo.kim@lge.com, laoar.shao@gmail.com, chris@chrisdown.name,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        mingo@kernel.org, keescook@chromium.org, tglx@linutronix.de,
        esyr@redhat.com, surenb@google.com, areber@redhat.com,
        elver@google.com
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/5] Fix some bugs in memcg/slab
Date:   Tue, 27 Oct 2020 16:02:51 +0800
Message-Id: <20201027080256.76497-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch series fixes some bugs and simplify the code in the
memcontrol.c.

Muchun Song (5):
  mm: memcg/slab: Fix return child memcg objcg for root memcg
  mm: memcg/slab: Fix use after free in obj_cgroup_charge
  mm: memcg/slab: Rename *_lruvec_slab_state to *_lruvec_kmem_state
  mm: memcg/slab: Fix root memcg vmstats
  mm: memcontrol: Simplify the mem_cgroup_page_lruvec

 include/linux/memcontrol.h | 62 +++++++++++++++++++++++++-------------
 kernel/fork.c              |  2 +-
 mm/memcontrol.c            | 61 ++++++++++---------------------------
 mm/workingset.c            |  8 ++---
 4 files changed, 62 insertions(+), 71 deletions(-)

-- 
2.20.1

