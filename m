Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311D32FC59A
	for <lists+cgroups@lfdr.de>; Wed, 20 Jan 2021 01:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbhATATh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 19:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbhATATN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 19:19:13 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94860C0613CF;
        Tue, 19 Jan 2021 16:18:31 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id y12so1023267pji.1;
        Tue, 19 Jan 2021 16:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dy2pnLpsAFKq7islomu6TWMlHm9Rk82D2CDlsTBcWI0=;
        b=naT/XIXtZwh8ZhNEUBOxM8iuEh6mYxXK9rhpLpkUwFQaJXd1hSq+CA3foBsUkzleFV
         HoqnOX/dxdtx5f797wfPcjH906lQi8ZS4PZkSkHe/8aPui88Ma02tblQhJLHsayUOVPn
         QrchhKnV0M5ofcTlzMN9WWPCff1rSo+QJ5p4YzV2frY1hswimH+FZgY/ANikY6H2iN3p
         DgmXwXPdlGU2VsTfQKDjQEju3/TD8QXfP2P5ijIwbtzHbq6uY473o0RpJcI+V6BK6OGs
         VW4pDqMD5fAUjtoTEtXPUIN1TPP6LIr9N0efRNa99bFHpxbloaGNQw4nZW9bS+uay36X
         bNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dy2pnLpsAFKq7islomu6TWMlHm9Rk82D2CDlsTBcWI0=;
        b=Jn6HD/Ze0nb0/FfLApvKgxaswNxaux0sL92fGQkQb4TKJAtCikajtDW5QQ0gwd+a0l
         7Rx+NjFkn8dBIhpTpiu3ZO5I8PON9Cxux+mBRFZb4FRrHJ59P9ZVI77yDoDbeNTSeq8k
         X/P2uW0J3rwCuGwgSvhtzSThYp9ERtR7hWGrlo4rZJHST4UFT46xZTYdIYn3N78TFHkG
         9hrpSx++YzOiWXgIMWrpT8LMIPQLKVX8fUCrzKhaHIXMWRiaYfe/3GP/JMaH9KqL3sCE
         jI429FgIXlUEqOJik0OvrFu+HCHMiuiJRLWKb6pPsEIMuWowFEvKKwoHdNF0jXeFyfGB
         mquQ==
X-Gm-Message-State: AOAM530tYkaB5xT/uwZMyePjFxuYGveNwTyWS/eaWCW3genEkY4xrYJy
        sXhtivY2KGpehekepwpsVzaROIP6kABiZA==
X-Google-Smtp-Source: ABdhPJyDsIjA3Tox2jhjGCWKz1iAZkrdK78c+g7FUZS6O83w9Iw5AOfE1UFLllm05jJfqX+h7awFpw==
X-Received: by 2002:a17:902:e885:b029:de:abac:f9c4 with SMTP id w5-20020a170902e885b02900deabacf9c4mr7169174plg.30.1611101911143;
        Tue, 19 Jan 2021 16:18:31 -0800 (PST)
Received: from kir-rhat.lan (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id y6sm227452pfn.123.2021.01.19.16.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 16:18:30 -0800 (PST)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
        Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH 03/10] docs/scheduler/sched-bwc: fix note rendering
Date:   Tue, 19 Jan 2021 16:18:17 -0800
Message-Id: <20210120001824.385168-4-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120001824.385168-1-kolyshkin@gmail.com>
References: <20210120001824.385168-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 Documentation/scheduler/sched-bwc.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
index 4af4ee1f3600..a44860d33ffc 100644
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -2,8 +2,9 @@
 CFS Bandwidth Control
 =====================
 
-[ This document only discusses CPU bandwidth control for SCHED_NORMAL.
-  The SCHED_RT case is covered in Documentation/scheduler/sched-rt-group.rst ]
+.. note::
+   This document only discusses CPU bandwidth control for SCHED_NORMAL.
+   The SCHED_RT case is covered in Documentation/scheduler/sched-rt-group.rst
 
 CFS bandwidth control is a CONFIG_FAIR_GROUP_SCHED extension which allows the
 specification of the maximum CPU bandwidth available to a group or hierarchy.
-- 
2.29.2

