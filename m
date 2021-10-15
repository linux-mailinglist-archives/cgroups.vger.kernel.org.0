Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3664742F45C
	for <lists+cgroups@lfdr.de>; Fri, 15 Oct 2021 15:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbhJON4F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Oct 2021 09:56:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48024 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240083AbhJON4E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Oct 2021 09:56:04 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 08ADC21972;
        Fri, 15 Oct 2021 13:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634306037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XLIhjbHS5OiUN2tPtH3NIRpzLe/6U1/ST92qVeetz/4=;
        b=rOkY2K6gg6owgwal/7TXs6RGXwq1PYGkmAjpkaD9iETBaLrvfuru3wXmMKFqf+p6mQSdkF
        ctkhYybZn4cqr/jB4QaV7b+NEc4+Bg8DPlaTyHg8ELXZoveeJ8ado41WGYVCpFrVGSI0BY
        wEmmc5S6eQx70C8jbFDjs8UZFsuJgD0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF531133A7;
        Fri, 15 Oct 2021 13:53:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MMfQMfSHaWG2PAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 15 Oct 2021 13:53:56 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] block, bfq: Accept symmetric weight adjustments
Date:   Fri, 15 Oct 2021 15:53:52 +0200
Message-Id: <20211015135352.57245-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The allowed range for BFQ weights is currently 1..1000 with 100 being
the default. There is no apparent reason to not accept weight
adjustments of same ratio on both sides of the default. This change
makes the attribute domain consistent with other cgroup (v2) knobs with
the weight semantics.

This extension of the range does not restrict existing configurations
(quite the opposite). This may affect setups where weights >1000 were
attempted to be set but failed with the default 100. Such cgroups would
attain their intended weight now. This is a changed behavior but it
rectifies the situation (similar intention to the
commit 69d7fde5909b ("blkcg: use CGROUP_WEIGHT_* scale for io.weight on
the unified hierarchy") for CFQ formerly (and v2 only)).

Additionally, the changed range does not imply all IO workloads can be
really controlled to achieve the widest possible ratio 1:10^4.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Paolo Valente <paolo.valente@linaro.org>
---
 Documentation/admin-guide/cgroup-v1/blkio-controller.rst | 2 +-
 Documentation/block/bfq-iosched.rst                      | 2 +-
 block/bfq-iosched.h                                      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


Changes since v1 https://lore.kernel.org/r/20210826131212.GE4520@blackbody.suse.cz/
- collect acks, reformat commit message
- effectively a resend

Given the length of addressee list from get_maintainers.pl, I'd break
possible tie (if there are no objections) by asking this being routed
via Jens's/linux-block tree.

Thanks,
Michal


diff --git a/Documentation/admin-guide/cgroup-v1/blkio-controller.rst b/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
index 16253eda192e..48559541c9d8 100644
--- a/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
+++ b/Documentation/admin-guide/cgroup-v1/blkio-controller.rst
@@ -102,7 +102,7 @@ Proportional weight policy files
 	  on all the devices until and unless overridden by per device rule
 	  (see `blkio.bfq.weight_device` below).
 
-	  Currently allowed range of weights is from 1 to 1000. For more details,
+	  Currently allowed range of weights is from 1 to 10000. For more details,
           see Documentation/block/bfq-iosched.rst.
 
   blkio.bfq.weight_device
diff --git a/Documentation/block/bfq-iosched.rst b/Documentation/block/bfq-iosched.rst
index df3a8a47f58c..88b5251734ce 100644
--- a/Documentation/block/bfq-iosched.rst
+++ b/Documentation/block/bfq-iosched.rst
@@ -560,7 +560,7 @@ For each group, the following parameters can be set:
 
   weight
         This specifies the default weight for the cgroup inside its parent.
-        Available values: 1..1000 (default: 100).
+        Available values: 1..10000 (default: 100).
 
         For cgroup v1, it is set by writing the value to `blkio.bfq.weight`.
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index a73488eec8a4..f1abb8b90091 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -16,7 +16,7 @@
 #define BFQ_CL_IDLE_TIMEOUT	(HZ/5)
 
 #define BFQ_MIN_WEIGHT			1
-#define BFQ_MAX_WEIGHT			1000
+#define BFQ_MAX_WEIGHT			10000
 #define BFQ_WEIGHT_CONVERSION_COEFF	10
 
 #define BFQ_DEFAULT_QUEUE_IOPRIO	4
-- 
2.33.0

