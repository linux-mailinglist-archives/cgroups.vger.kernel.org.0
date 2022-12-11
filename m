Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5BC6496BB
	for <lists+cgroups@lfdr.de>; Sun, 11 Dec 2022 23:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiLKWXJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 11 Dec 2022 17:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiLKWXG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 11 Dec 2022 17:23:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96700F22
        for <cgroups@vger.kernel.org>; Sun, 11 Dec 2022 14:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670797272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pSMLLAxVMXnoWPwPea+ElcFQc/uDEfReQyP/onbm6ts=;
        b=EXx5rQ0Jf0KcWOE9VRbBDB24U6BVHU80NiPax2Ubfqlbg2OpfhrXQXXlrmTKKKVBN/iOrS
        eAJe8b/0QxGGRoQYbd5n3wnHt4qHMqQeCYx9QcDbtqLzvKViWTz+U1lpl4lnbWZPEmd1h5
        WPE8P/w+qdDx90zbH4YF6Cgg+e1PZYA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-cZw5i59hMJqVW7MRZaco6g-1; Sun, 11 Dec 2022 17:21:07 -0500
X-MC-Unique: cZw5i59hMJqVW7MRZaco6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED062101A52A;
        Sun, 11 Dec 2022 22:21:06 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F8101121331;
        Sun, 11 Dec 2022 22:21:06 +0000 (UTC)
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
Subject: [PATCH-block v2 0/3] blk-cgroup: Fix potential UAF & miscellaneous cleanup
Date:   Sun, 11 Dec 2022 17:20:55 -0500
Message-Id: <20221211222058.2946830-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

 v2:
  - Remove unnecessary rcu_read_{lock|unlock} from
    cgroup_rstat_css_cpu_flush() in patch 3.

It was found that blkcg_destroy_blkgs() may be called with all blkcg
references gone. This may potentially cause user-after-free and so
should be fixed. The last 2 patches are miscellaneous cleanups of
commit 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()").

Waiman Long (3):
  bdi, blk-cgroup: Fix potential UAF of blkcg
  blk-cgroup: Don't flush a blkg if destroyed
  blk-cgroup: Flush stats at blkgs destruction path

 block/blk-cgroup.c     | 26 ++++++++++++++++++++++++++
 include/linux/cgroup.h |  1 +
 kernel/cgroup/rstat.c  | 18 ++++++++++++++++++
 mm/backing-dev.c       |  8 ++++++--
 4 files changed, 51 insertions(+), 2 deletions(-)

-- 
2.31.1

