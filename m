Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F432FC590
	for <lists+cgroups@lfdr.de>; Wed, 20 Jan 2021 01:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbhATATU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 19:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbhATATN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 19:19:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7180C0613C1;
        Tue, 19 Jan 2021 16:18:30 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id g15so1013406pjd.2;
        Tue, 19 Jan 2021 16:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ds7LbWxzhg+PnTvKnERBaZN4CXWnLXd13Bbn6mXPVrs=;
        b=MHD5vUTu8gJAqj4AhIxwlTGrc3vUszPT28BiOkxTmEossnViyHWk9uCptCJKUsSw73
         kO6E9k93ZTY/7fEdNZErxnjRvohFOinV1nbCq8oWrNey+a3q4CpgzZoMwrYINk5IXd7V
         tekXOPN2kSxpagU4SRKxMbvsBuOOrItVehziAa/yBv14SboQfyeeacj4/IsUYAF7zQsr
         6Fn8j7wii9fvl8zrF+LWd7OqFIIf2hIlhGaanFzFS19YyuXjAozUYfjPGiFZ2jgzCh2v
         1CkII2PaiKdeD8z9qfg8nP7wcy8eBXQX9OoWf6gM0Z8VnLjYMEDzNhEw4TYPXD2XbpwS
         dfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ds7LbWxzhg+PnTvKnERBaZN4CXWnLXd13Bbn6mXPVrs=;
        b=sBwxBPCNmFq7R2+hGWZs0vZqm8wGKqVg62xJohgUKf67GVe0z7DsSAfWsePMBPCSsO
         pHXytINrafvxOo6EyZl4EEScbodl7TVu9Zf8m4hC+3IkmXuh8mqOm92iJXCOVppDuBon
         TKqf5jfOF2xFSQasV6Ca4XALuSOY6XozQLZL62dDbTDgTEfQ0OVlBEfnaf5ZUwEaBNCr
         KJiK3D/BcSoqcmf4Vpk0pIKaKAsMln1GVrdTkWTlpGL4QfSs0/AWPyGkgr8JuaBVmYDh
         tCp5ryOZYHDwG8RPS+rn1v7QzWWUx4edtWKkDGbti8i7Zf2AGwgyTbwe8otS/DTVGJi2
         Cz/Q==
X-Gm-Message-State: AOAM533XXb2MIijp5EVyrp/SraJwIQo3Rl9ppT/L0eNRE7YVTGdS4a7T
        Ckr53lZhQj/4KXYcX6sDmAo=
X-Google-Smtp-Source: ABdhPJwLxn5RHQn7n7+tDPZ/BtWE7c4EwKgULks8nRxhavWxNgwygVWAFt8P3xysmxRp8vTPSRmb1A==
X-Received: by 2002:a17:90a:cb0f:: with SMTP id z15mr2514872pjt.88.1611101910203;
        Tue, 19 Jan 2021 16:18:30 -0800 (PST)
Received: from kir-rhat.lan (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id y6sm227452pfn.123.2021.01.19.16.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 16:18:29 -0800 (PST)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
        Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH 02/10] docs/scheduler/sched-design-CFS: formatting fix
Date:   Tue, 19 Jan 2021 16:18:16 -0800
Message-Id: <20210120001824.385168-3-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120001824.385168-1-kolyshkin@gmail.com>
References: <20210120001824.385168-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Fix the rendering of the paragraph. Before the fix, the first line is
rendered in bold (I'm not quite sure why) and is also separated from the
rest of the paragraph, which is rendered with an indent.

Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 Documentation/scheduler/sched-design-CFS.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentation/scheduler/sched-design-CFS.rst
index a96c72651877..59b2d1fb4dc4 100644
--- a/Documentation/scheduler/sched-design-CFS.rst
+++ b/Documentation/scheduler/sched-design-CFS.rst
@@ -34,9 +34,9 @@ In CFS the virtual runtime is expressed and tracked via the per-task
 p->se.vruntime (nanosec-unit) value.  This way, it's possible to accurately
 timestamp and measure the "expected CPU time" a task should have gotten.
 
-[ small detail: on "ideal" hardware, at any time all tasks would have the same
-  p->se.vruntime value --- i.e., tasks would execute simultaneously and no task
-  would ever get "out of balance" from the "ideal" share of CPU time.  ]
+   Small detail: on "ideal" hardware, at any time all tasks would have the same
+   p->se.vruntime value --- i.e., tasks would execute simultaneously and no task
+   would ever get "out of balance" from the "ideal" share of CPU time.
 
 CFS's task picking logic is based on this p->se.vruntime value and it is thus
 very simple: it always tries to run the task with the smallest p->se.vruntime
-- 
2.29.2

