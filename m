Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29C03A70F4
	for <lists+cgroups@lfdr.de>; Mon, 14 Jun 2021 23:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhFNVFJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Jun 2021 17:05:09 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:42500 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhFNVFI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Jun 2021 17:05:08 -0400
Received: by mail-pl1-f172.google.com with SMTP id v13so7295559ple.9;
        Mon, 14 Jun 2021 14:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Rtw5MlcGm2N9I0P0R9oyIB7YsHFMJaGufsNXGeoAHQ=;
        b=RayZuXENOAZnm24AQT0DNbpM6rBhKla7akSUfMcirF4R7gibXGuEBq42JYYqFNRp0W
         2/FqT+A1bG+PM4Z8A7M8Tm+NfzZtarGac17BqpelaVOAGYA0jhEb0wJzgEXDrcQyTpaH
         H89WH1mXOvrH/t0OSv/LwChGa1eYFM94Ni8qWSPDwHYvvLhEJJqvC4kKV/IrClTnjOf8
         Kua/6RtnEeTxG52d+yL+jiyjsOURY1HmkpxhSZJDeArstjPrYDF9p6icm764G+ixFBSt
         31IyOSnzFZJuRbHRPsaYoFI0qQbrVtZM3iZiNoz39qS7Tjd8V4j438kku+Jw5iZ2MKmr
         wmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Rtw5MlcGm2N9I0P0R9oyIB7YsHFMJaGufsNXGeoAHQ=;
        b=eBcJyrkbRn6//Ftakjh92HK2fuHFbxXAVnT+ozgqXfhW1wb0RFdEKEm6tP3XkwApov
         AG/3fDPZ3LmNLFJKSxJ5bxQYmf5fbYvoc0F59wKPbu7EoPkgdtg0voy7dmw8G9P13pN4
         5doO5vp/B4roP4VzRwIlmJJ4eGtR//kWVA5lVqgCn5FJwhUbSdZqRLC9OevL4U8n4Dl2
         LhWZH+45+afM3IsV9q1l2BoNA2OQD1XcfBtX0AX5hzyIUOih9K8FjigFVbhgh0xol6xu
         fze900j8pX33IPG6tjskksV7IfUslNnHnKtzZgowULdX9FQqqQTQTiiIU3v67eet6qnW
         jkOw==
X-Gm-Message-State: AOAM530p5XeRRkkpzl/cKRl/fZAjst6R0zNN2FWUPIUUW7S1Gg+a9Idj
        ny2ZYhe5obJ/hO1LOUmPbPQ=
X-Google-Smtp-Source: ABdhPJzthotHcUr8YGs4bW3mZXC/yRGELx9flD1RiRwJM9uR7LeyC+5CP6llSExZGmqrgZU/d9p5eQ==
X-Received: by 2002:a17:90a:fa4f:: with SMTP id dt15mr1141161pjb.30.1623704525152;
        Mon, 14 Jun 2021 14:02:05 -0700 (PDT)
Received: from kir-rhat.lan (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id x20sm13401068pfu.205.2021.06.14.14.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 14:02:04 -0700 (PDT)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     tj@kernel.org, axboe@kernel.dk, paolo.valente@linaro.org,
        cgroups@vger.kernel.org, Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH v2] docs: block/bfq: describe per-device weight
Date:   Mon, 14 Jun 2021 14:01:38 -0700
Message-Id: <20210614210137.204155-1-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <8735tlbbml.fsf@meer.lwn.net>
References: <8735tlbbml.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The functionality of setting per-device weight for BFQ was added
in v5.4 (commit 795fe54c2a828099), but the documentation was never
updated.

While at it, improve formatting a bit.

Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 Documentation/block/bfq-iosched.rst | 38 ++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/Documentation/block/bfq-iosched.rst b/Documentation/block/bfq-iosched.rst
index 66c5a4e54130..7200152c461e 100644
--- a/Documentation/block/bfq-iosched.rst
+++ b/Documentation/block/bfq-iosched.rst
@@ -553,20 +553,36 @@ throughput sustainable with bfq, because updating the blkio.bfq.*
 stats is rather costly, especially for some of the stats enabled by
 CONFIG_BFQ_CGROUP_DEBUG.
 
-Parameters to set
------------------
+Parameters
+----------
 
-For each group, there is only the following parameter to set.
+For each group, the following parameters cat be set:
 
-weight (namely blkio.bfq.weight or io.bfq-weight): the weight of the
-group inside its parent. Available values: 1..1000 (default 100). The
-linear mapping between ioprio and weights, described at the beginning
-of the tunable section, is still valid, but all weights higher than
-IOPRIO_BE_NR*10 are mapped to ioprio 0.
+  weight
+        This specifies the default weight for the cgroup inside its parent.
+        Available values: 1..1000 (default: 100).
 
-Recall that, if low-latency is set, then BFQ automatically raises the
-weight of the queues associated with interactive and soft real-time
-applications. Unset this tunable if you need/want to control weights.
+        For cgroup v1, it is set by writing the value to `blkio.bfq.weight`.
+
+        For cgroup v2, it is set by writing the value to `io.bfq.weight`.
+        (with an optional prefix of `default` and a space).
+
+        The linear mapping between ioprio and weights, described at the beginning
+        of the tunable section, is still valid, but all weights higher than
+        IOPRIO_BE_NR*10 are mapped to ioprio 0.
+
+        Recall that, if low-latency is set, then BFQ automatically raises the
+        weight of the queues associated with interactive and soft real-time
+        applications. Unset this tunable if you need/want to control weights.
+
+  weight_device
+        This specifies a per-device weight for the cgroup. The syntax is
+        `minor:major weight`. A weight of `0` may be used to reset to the default
+        weight.
+
+        For cgroup v1, it is set by writing the value to `blkio.bfq.weight_device`.
+
+        For cgroup v2, the file name is `io.bfq.weight`.
 
 
 [1]
-- 
2.31.1

