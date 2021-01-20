Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DD22FC5A0
	for <lists+cgroups@lfdr.de>; Wed, 20 Jan 2021 01:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbhATAUX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 19:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbhATAT2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 19:19:28 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A1DC0613D3;
        Tue, 19 Jan 2021 16:18:32 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id my11so2214650pjb.1;
        Tue, 19 Jan 2021 16:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tXzJgZeFW0MqXzTyG1CaFrbwaPZ1tQM/2q7+gv5S6M4=;
        b=mIXcBx3kExnFoF3rAgXg8Y0Wu3FiLWLpnEXS/UczJOdkeL0yC1hqypRtVpXgGacxkM
         jFXPPaebOVuteHEChay9KDmNeziCRTFDwPBe0G8qEWVc6Ajx6crLYnLLxo68GO6yg+op
         +ZQPcjIEheoIfceVbvtgM2rHoRQTgIAWWEOsSR4+VNmhA+MvKh3SVqkSe3CpsQVPs1MB
         ElUdO99Zv2hUhqifNRyDclRz0V/79CWbfIGu7qVORtMqlRfMz0R4QyjGf2E2hmDv425R
         SxAu+WEkc0bc8kdw4dGzwxmge1QMdYiKJ8GWP6IqhpGMnQzybv5bwGMCncMKSbwx/KpZ
         4snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tXzJgZeFW0MqXzTyG1CaFrbwaPZ1tQM/2q7+gv5S6M4=;
        b=NCtjFupzPvWH6wjyZbunyWRSprzqu/RQ25LRpUVopDUtWSCmRFF0MAnPzOXkWVfQdn
         vJpCwtVPc8eSnZLnny2DS0XUzDys8edM3LAqrEHn2MV10rXFozR+92H4p/lwxb8JsO0u
         7kauzVQZEKahXt5IsYM70H8XRNm6u9jv93s2iveSDaKAxZ9Mq+VL8+jKcqZf3sfX9Xqs
         qHK9F/p4npdKKXpK8uEHeu0QFEt7Nhdf3edcWrZ7p0TPtcpklHfF5NUHQbXBHbadiOaU
         qZlpZWM151gjmdS94dvNwMb6C5eRJkFRmXupHj0i9COBPiF6Hc6m1fzN1cFX1mgQUYuj
         uGGA==
X-Gm-Message-State: AOAM533bVqP/kbUtLbHH0oJchtiCdqspFq/u/qjUsuUOkEFj6mgnuQ5/
        IxlMh3AIDyYahhN1j8KfnA+RJfyxcTIEkw==
X-Google-Smtp-Source: ABdhPJyMf2Cd2x3S3zyTUWMkt3ynfH0UwolTGEyYSNQB8hhpfpLD3enhfPGJVNDJiZw2p94aOAtlCA==
X-Received: by 2002:a17:90a:34cb:: with SMTP id m11mr2394836pjf.59.1611101912193;
        Tue, 19 Jan 2021 16:18:32 -0800 (PST)
Received: from kir-rhat.lan (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id y6sm227452pfn.123.2021.01.19.16.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 16:18:31 -0800 (PST)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
        Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH 04/10] docs/scheduler/sched-bwc: add proper ref
Date:   Tue, 19 Jan 2021 16:18:18 -0800
Message-Id: <20210120001824.385168-5-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120001824.385168-1-kolyshkin@gmail.com>
References: <20210120001824.385168-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add a proper reference instead of just using the file name.

Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 Documentation/scheduler/sched-bwc.rst      | 3 ++-
 Documentation/scheduler/sched-rt-group.rst | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
index a44860d33ffc..dcec7440c222 100644
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -4,7 +4,8 @@ CFS Bandwidth Control
 
 .. note::
    This document only discusses CPU bandwidth control for SCHED_NORMAL.
-   The SCHED_RT case is covered in Documentation/scheduler/sched-rt-group.rst
+   The SCHED_RT case is covered in
+   :ref:`Documentation/scheduler/sched-rt-group.rst <sched-rt-group>`.
 
 CFS bandwidth control is a CONFIG_FAIR_GROUP_SCHED extension which allows the
 specification of the maximum CPU bandwidth available to a group or hierarchy.
diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
index 655a096ec8fb..a3b4aa51c271 100644
--- a/Documentation/scheduler/sched-rt-group.rst
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -1,3 +1,5 @@
+.. _sched-rt-group:
+
 ==========================
 Real-Time group scheduling
 ==========================
-- 
2.29.2

