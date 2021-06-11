Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0670E3A3A1A
	for <lists+cgroups@lfdr.de>; Fri, 11 Jun 2021 05:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhFKDJs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Jun 2021 23:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhFKDJs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Jun 2021 23:09:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1989FC061574;
        Thu, 10 Jun 2021 20:07:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z26so3274764pfj.5;
        Thu, 10 Jun 2021 20:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Rtw5MlcGm2N9I0P0R9oyIB7YsHFMJaGufsNXGeoAHQ=;
        b=sJ3o48UPXoftKS+gkeUdGnYNPt5HHaOCFwTZ4UBfqsWcDpCcvWV250sfJgZo3SFoKk
         kp/SpMgvMBuBMGHrOr+iMFpqBuitoTirL5XEKj/JPHrPW+OakTSKIuCLJ/uZbHOLlnyu
         Yu5zpe1koP5k1+fpRZphhdbNPIuHtJW6+b4YWX482ooxVkujwwGmMI/kJG2qRDWuyn3f
         OLl8WdwjSiQP1JbNFSOOeYX2AkiNJc9rWHilLTKxSZHMgKIGUUtezvEMa+JP3fHiUgHa
         Awz6U+0jU3voCd2nTVWYMT1L77taT85qlpDUF94+CiCzE9BYnpMzs+vQ+NvpqMIVNCIh
         acow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Rtw5MlcGm2N9I0P0R9oyIB7YsHFMJaGufsNXGeoAHQ=;
        b=DEe557PORUN6cnG76ty8wgRSHvY/7W69ddzpuB/hNTdj7DmH4H3SqDgW8CinViALvb
         zJe38XpdiFK2ceZqJHJF0a57q2leinXmM8fFB43OrD9X2m3kd3vXx7XEkLv3u2Zz4ZjD
         48bjFMeZJhHJQpJohPN030Fw5Sb/ydWmRm1Vu6/uvobIMzvrT2mxWR+6woQWE7lX8T13
         qsW0pwvyvcKtQNkFUkuf5Le51A9EVnA7i5NNWBgFWxuDgL72UAjnbjW3OZk1Sin2wLIX
         3oC0iGMXKvmUCFThI5gQAlgfBeUDuucvqi4vTYfdH4GqqlyRPBrpo0VFjrKepIhw6ENE
         L8hg==
X-Gm-Message-State: AOAM532kdtKy3cjZvG0MmRJiNA4hWWrgmmFYkWcS3Fc6YgWkcakzWDgX
        cIgVWhEABaSehBsGQ1sjPcAJA22RDnmx+g==
X-Google-Smtp-Source: ABdhPJyCnDn3zgGGdppZOHu3QDT04D/gHldJwZ3jX8d8Jb3onCkMdkxAV1m+SevrQSYuoHXv1hOBpQ==
X-Received: by 2002:a63:1011:: with SMTP id f17mr1461765pgl.274.1623380862276;
        Thu, 10 Jun 2021 20:07:42 -0700 (PDT)
Received: from kir-rhat.redhat.com (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id q2sm3774319pje.50.2021.06.10.20.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 20:07:41 -0700 (PDT)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, tj@kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, cgroups@vger.kernel.org,
        Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH 1/3] docs: block/bfq: describe per-device weight
Date:   Thu, 10 Jun 2021 20:07:35 -0700
Message-Id: <20210611030737.1984343-2-kolyshkin@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611030737.1984343-1-kolyshkin@gmail.com>
References: <20210611030737.1984343-1-kolyshkin@gmail.com>
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

