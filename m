Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2CD6CB6D5
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 08:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjC1GRM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 02:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjC1GRF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 02:17:05 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BDC30E3
        for <cgroups@vger.kernel.org>; Mon, 27 Mar 2023 23:16:49 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id z16-20020a170902d55000b001a06f9b5e31so7217922plf.21
        for <cgroups@vger.kernel.org>; Mon, 27 Mar 2023 23:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679984209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+vNiceMoZ2PdzrNG/xVeRzEo7O+ovCZNHcQMp7VClk4=;
        b=FtVms547YGVdf9XAqjguoo0WST2Bomcq4pMeCW3qlg0ksZV5swPoVz0GmrxFu8vfrh
         HBzgJptVGGKy7geKpBPvC2PsWo0HmjT2F27i9dbdVA6zCF4EYemeZRNrh89DbSPqLObX
         h82tbSvZ/WCeLjLtii1Meb+k3BLVneGl+TdsHqmfTXT/vAFZIC+/S3Aw9k3ElSrpUy7X
         9xgxQRUTlE19S9rQfATi59HRnf65TEpEpviTmJbLID2U9/qvSayVfcGFQGEl03zvUEu5
         uDhGnK3XWBy1kJngfOB04Odcd1UeEO5WA33WjKyVDhleLQy8k50zMQSY0RXklX82o1Jn
         CmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vNiceMoZ2PdzrNG/xVeRzEo7O+ovCZNHcQMp7VClk4=;
        b=hlKHjKG8ic+C4rTC/mEgkbH8DYyEnj8XQ52YyIr24cuaGvqcAdEHkvmwUxXcUhGoLg
         Iqo1OaZ0oGrrVT/BIMXGVsrqjUYwZPVrJU8ebgvBV4z5u+d2naMPvgN5zF54F/STCBxX
         nUIA6b9J531WmihqAE5pC6sySgJjY6p+ab5khCf9IaX0QNcVGitcccYmjLdTtuazTiSL
         z6pxX4ZnQo72/tkN5BSCKMSyauy+jt96Rsxl+DOr+yL4ZbjZsHgOs6plmGIxGiyQiohf
         BJL61BBqNW77R+IBBVxO1lPeyiqQkENETnZJlhJuNR9FrTtKbdAUVCVm7Wl1o8FNbRps
         KyzA==
X-Gm-Message-State: AAQBX9da5+6jDCW4QLP/PszxIhXLT99QmrNLd6lOkOf46g8J/nhraAFs
        gRfbPLe9sF8hnxIfva7l8c4b+zObw5+CY1FN
X-Google-Smtp-Source: AKy350az2ZQxKTBjGyFUiNza+YDGvWpTHjavWcHAugAuQk4rmOEm1wQoqfQkURL2u01jT9Cm3t+xr5muiADnxiOT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:1a46:b0:625:c7de:48c1 with
 SMTP id h6-20020a056a001a4600b00625c7de48c1mr7269994pfv.4.1679984209151; Mon,
 27 Mar 2023 23:16:49 -0700 (PDT)
Date:   Tue, 28 Mar 2023 06:16:33 +0000
In-Reply-To: <20230328061638.203420-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328061638.203420-5-yosryahmed@google.com>
Subject: [PATCH v1 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing outside
 task context
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>
Cc:     Vasily Averin <vasily.averin@linux.dev>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

rstat flushing is too expensive to perform in irq context.
The previous patch removed the only context that may invoke an rstat
flush from irq context, add a WARN_ON_ONCE() to detect future
violations, or those that we are not aware of.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/cgroup/rstat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d3252b0416b6..c2571939139f 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -176,6 +176,8 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 {
 	int cpu;
 
+	/* rstat flushing is too expensive for irq context */
+	WARN_ON_ONCE(!in_task());
 	lockdep_assert_held(&cgroup_rstat_lock);
 
 	for_each_possible_cpu(cpu) {
-- 
2.40.0.348.gf938b09366-goog

