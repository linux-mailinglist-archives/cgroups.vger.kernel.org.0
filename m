Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CB23A717C
	for <lists+cgroups@lfdr.de>; Mon, 14 Jun 2021 23:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhFNVnR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Jun 2021 17:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhFNVnQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Jun 2021 17:43:16 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21A7C061574;
        Mon, 14 Jun 2021 14:41:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q25so11628729pfh.7;
        Mon, 14 Jun 2021 14:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8uYjRxtO7dpbOnz1w0p+p8tt+5BlKO/GjM8j1UYITWU=;
        b=rxyYh4BVOhTXfNAeJAnxJHtfIZSR+IFpzZ5ve/j41adnEnMSOoIlFcHv0nHL+aFMK0
         Uh/eJeE/NZFp6DwHFLs8h+LIVAsj8YPWY7HOg9l52EqSuheS/r9oIEoruUI2/2tKorcV
         4JRKjkiaW/50XSn3rqVc6jB/RevZ3C4cXq8BVf364EHV304Q3hNeyEa0KzpyhX9YI6FR
         q+Hq/GS/bmTlyI0uVPOtRteKrhGuBlMI/0DYMZy87X8/2pdmQW1vgo7FsNmBw0qtpRyA
         gRzwrtwvFfZJadtUqZe8M4806BhwfQ08JIK0qOq2DP+hmi3AlCU4TJAAvjYltf9aXM9p
         Psgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8uYjRxtO7dpbOnz1w0p+p8tt+5BlKO/GjM8j1UYITWU=;
        b=Xqu34AOTwws/AN58C35653Vhprp3GNeDygqfl6mzePmAaBUUglFpUIx2kzQ/jWTP7f
         ieZ9PdG1/J71VJnyRjRxudeh9D1Ob/NALeji12rphZbS8jk1xOVumBDFawZMoDzXp+pv
         4ws7O3FPmJ2hpGurpvaUyZA9OpPMy5swZgypzyfTkA0LIPdNgoOMI4ecZq4J5ozUb0h5
         nQEkjI5pnRaj3KBI2b7yMksQLMCgGkyBoQfZI5vHAXsQqWrv+NT+CAdsVkztT+Ce6s2P
         sEU626UqZmW3BtbP8I21tJNVOS9yIqY3z6heifB2hL7lvhfhPSLKqCWLRz10wBCmdR0S
         gwkg==
X-Gm-Message-State: AOAM530G2IuzuJmw0bwU56qhWkTeNurA194m36C2g/j60+3CRX6yk1DY
        NNtg63erZs2znZQV1eD203ria7be6KemVg==
X-Google-Smtp-Source: ABdhPJzxRJbkGB4i9GQuKgaxsMaXCnlbiAs2TIL+OLDqaewubC6gW0ib2Gi+kPP6luKV6yY2xeHPoA==
X-Received: by 2002:aa7:8bd6:0:b029:2ec:7dc9:77e3 with SMTP id s22-20020aa78bd60000b02902ec7dc977e3mr980739pfd.62.1623706873100;
        Mon, 14 Jun 2021 14:41:13 -0700 (PDT)
Received: from kir-rhat.lan (c-76-104-243-248.hsd1.wa.comcast.net. [76.104.243.248])
        by smtp.gmail.com with ESMTPSA id q16sm4821221pfk.209.2021.06.14.14.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 14:41:12 -0700 (PDT)
From:   Kir Kolyshkin <kolyshkin@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     tj@kernel.org, axboe@kernel.dk, paolo.valente@linaro.org,
        cgroups@vger.kernel.org, Kir Kolyshkin <kolyshkin@gmail.com>
Subject: [PATCH v2] docs: block/bfq: describe per-device weight
Date:   Mon, 14 Jun 2021 14:41:09 -0700
Message-Id: <20210614214109.207430-1-kolyshkin@gmail.com>
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
index 66c5a4e54130..df3a8a47f58c 100644
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
+For each group, the following parameters can be set:
 
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

