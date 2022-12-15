Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593F764D5A0
	for <lists+cgroups@lfdr.de>; Thu, 15 Dec 2022 04:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiLODcq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Dec 2022 22:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLODcp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Dec 2022 22:32:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C815437B
        for <cgroups@vger.kernel.org>; Wed, 14 Dec 2022 19:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671075117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=veCyvm43EvJLg9G9hhu4AmM7THRxqVqHEQtr8ufuCSo=;
        b=iJoJqwZ+7thbe+rwo3QNBWbueHh9VCFIGkejROPzRkVSbsPAojqqecLxoH6F6mSEZzjqXr
        TxeFq9SpJQnlbIYxgBQczKUi9MpqTKxuLiLK4Hab5L4Egukt+WXlLHkq8m4n9XuB4vAhK2
        wgm9OY5q3R2ztYNeHN1nLVTdSQKjk1c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-tg69kkZDM-O1mkTEYK98qg-1; Wed, 14 Dec 2022 22:31:45 -0500
X-MC-Unique: tg69kkZDM-O1mkTEYK98qg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99C9F185A78B;
        Thu, 15 Dec 2022 03:31:44 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA9B240ED76E;
        Thu, 15 Dec 2022 03:31:43 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/2] blk-cgroup: Fix potential UAF & flush rstat at blkgs destruction path
Date:   Wed, 14 Dec 2022 22:31:30 -0500
Message-Id: <20221215033132.230023-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

 v4:
  - Update comment and commit logs for both patches.

 v3:
  - Drop v2 patch 2 as it may not be needed.
  - Replace css_tryget() with percpu_ref_is_zero() in patch 1 as
    suggested by Tejun.
  - Expand comment on patch 2 to elaborate the reason for this patch.

 v2:
  - Remove unnecessary rcu_read_{lock|unlock} from
    cgroup_rstat_css_cpu_flush() in patch 3.

It was found that blkcg_destroy_blkgs() may be called with all blkcg
references gone. This may potentially cause user-after-free and so should
be fixed. The second patch flushes rstat when calling blkcg_destroy_blkgs().

Waiman Long (2):
  bdi, blk-cgroup: Fix potential UAF of blkcg
  blk-cgroup: Flush stats at blkgs destruction path

 block/blk-cgroup.c     | 23 +++++++++++++++++++++++
 include/linux/cgroup.h |  1 +
 kernel/cgroup/rstat.c  | 18 ++++++++++++++++++
 mm/backing-dev.c       |  8 ++++++--
 4 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.31.1

