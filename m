Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2D53A3A20
	for <lists+cgroups@lfdr.de>; Fri, 11 Jun 2021 05:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhFKDKx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Jun 2021 23:10:53 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:43629 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhFKDKx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Jun 2021 23:10:53 -0400
Received: by mail-pl1-f179.google.com with SMTP id v12so2093676plo.10;
        Thu, 10 Jun 2021 20:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EeiiZk029aDgyJMHooCPOqX+d9TplBH+7i69WXM5i/M=;
        b=WT2aoFBdPydSDmrn1yO0fHAUPDEAYD8a9mHe8XjvtW9fLhxMHmjcnM+pkx9v0Xrpv5
         jDd7sTd3hYf4vh0OkgSUC2lxL0buxzs1POSItzfLDAVmy0v2DUSoJuCzlt9Kx7iFY6YJ
         pM76Wuo1vpzDqz1fDOuXgnCo+QOtu9SHZjKLdajyiUC5awhBBWp770RNdKB3AJbsz6lN
         BMYCG33ggxjCA83y++ONGSN589hWNiijlte7NIODvsKcMaWXkT0foYWIDy+PsLMprEq2
         nTkbho5+jOD+ddNi9FlhfP6c2SsgZF2a6Hfl3vvqgp6NiiKiZkp9ToALMj0+fd+OJe8v
         8HNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EeiiZk029aDgyJMHooCPOqX+d9TplBH+7i69WXM5i/M=;
        b=UyOpSX/vFjXklW0rpulRf0lHyhQ7/lX52yhcSLEbpN9Ao5EZcszzog7KHLtrUiiMnd
         nAlUEEA9TO62fawk3TpSFAyK+Cv4KuxaZQ46cg93A0pL4IdEx6rkqKa7gBOR2Epiu+vM
         ezoHNEjW5+havRjD+/rFp5cwp9nqcCjXNBz437ou7REhjCQNQpGRq6LPpIqXqz1Pg2nP
         svAatzy/YLtH0RQ5kXhQ2IPqbcv6kma5XE4TYVpXM/nNtujDeQ0bM5tIz8KqGqrHdiCi
         q3tUZLlOnGvNZ2mjYkXrM0mDVGM/a1YOEem4ZuAXX98KlQw+FSySnN2oy/0cIZlb2lC6
         RsnA==
X-Gm-Message-State: AOAM530KU559kE+LASH2f3+oS5LhkzXv0nC3eEC428K+Vr+jfFc+uaq4
        u8lXvjtogbWnlfMYUhDXZnzVzasNwVKILw==
X-Google-Smtp-Source: ABdhPJyRMcJGAqIuulTTWK0Gt0FXBytUTB/g1mrb7FUWLqKqzfNb97tg0pJ+VvPscSmLHPlElB7FYA==
X-Received: by 2002:a17:90a:7349:: with SMTP id j9mr2148641pjs.234.1623380863978;
        Thu, 10 Jun 2021 20:07:43 -0700 (PDT)
Received: from kir-rhat.redhat.com (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id q2sm3774319pje.50.2021.06.10.20.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 20:07:43 -0700 (PDT)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, tj@kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, cgroups@vger.kernel.org,
        Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH 3/3] docs/cgroup-v1/blkio: update for 5.x kernels
Date:   Thu, 10 Jun 2021 20:07:37 -0700
Message-Id: <20210611030737.1984343-4-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611030737.1984343-1-kolyshkin@gmail.com>
References: <20210611030737.1984343-1-kolyshkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Commit bf382fb0bcef4 ("block: remove legacy IO schedulers", Oct 12 2018)
removes the CFQ scheduler, together with blkio.weight and
blkio.weight_device described in cgroup v1 documentation. Users are
supposed to use the BFQ scheduler, which cgroup file for setting weight
is blkio.bfq.weight, but there is no way to set per-device weight.

Later, commit 795fe54c2a8 per-device weights for BFQ, meaning that
blkio.bfq.weight and blkio.bfq.weight_device can be used in a way
similar to the old CFQ cgroup interface.

Yet, the cgroup v1 docs were never updated. Fix this:
 - use the new file names;
 - fix the range for weight (used to be 10..1000, now 1..1000);
 - link to BFQ scheduler docs.

Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 .../cgroup-v1/blkio-controller.rst            | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/blkio-controller.rst b/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
index 8101dcba381d..16253eda192e 100644
--- a/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
+++ b/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
@@ -97,40 +97,41 @@ Details of cgroup files
 Proportional weight policy files
 --------------------------------
 
-  blkio.weight
+  blkio.bfq.weight
 	  Specifies per cgroup weight. This is default weight of the group
-	  on all the devices until and unless overridden by per device rule.
-	  (See blkio.weight_device).
-	  Currently allowed range of weights is from 10 to 1000.
+	  on all the devices until and unless overridden by per device rule
+	  (see `blkio.bfq.weight_device` below).
 
-  blkio.weight_device
-	  One can specify per cgroup per device rules using this interface.
-	  These rules override the default value of group weight as specified
-	  by blkio.weight.
+	  Currently allowed range of weights is from 1 to 1000. For more details,
+          see Documentation/block/bfq-iosched.rst.
+
+  blkio.bfq.weight_device
+          Specifes per cgroup per device weights, overriding the default group
+          weight. For more details, see Documentation/block/bfq-iosched.rst.
 
 	  Following is the format::
 
-	    # echo dev_maj:dev_minor weight > blkio.weight_device
+	    # echo dev_maj:dev_minor weight > blkio.bfq.weight_device
 
 	  Configure weight=300 on /dev/sdb (8:16) in this cgroup::
 
-	    # echo 8:16 300 > blkio.weight_device
-	    # cat blkio.weight_device
+	    # echo 8:16 300 > blkio.bfq.weight_device
+	    # cat blkio.bfq.weight_device
 	    dev     weight
 	    8:16    300
 
 	  Configure weight=500 on /dev/sda (8:0) in this cgroup::
 
-	    # echo 8:0 500 > blkio.weight_device
-	    # cat blkio.weight_device
+	    # echo 8:0 500 > blkio.bfq.weight_device
+	    # cat blkio.bfq.weight_device
 	    dev     weight
 	    8:0     500
 	    8:16    300
 
 	  Remove specific weight for /dev/sda in this cgroup::
 
-	    # echo 8:0 0 > blkio.weight_device
-	    # cat blkio.weight_device
+	    # echo 8:0 0 > blkio.bfq.weight_device
+	    # cat blkio.bfq.weight_device
 	    dev     weight
 	    8:16    300
 
-- 
2.31.1

