Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4275261A67C
	for <lists+cgroups@lfdr.de>; Sat,  5 Nov 2022 02:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiKEBAT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Nov 2022 21:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKEBAS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Nov 2022 21:00:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8506BC0E
        for <cgroups@vger.kernel.org>; Fri,  4 Nov 2022 17:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667609962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CCZSaJ900ZMJsX6FSPePp5c1TELOc3F+zYif5LY5DHo=;
        b=LF37+PDRahhtp45i5BA7CUMXmRhU6woyHTHwrAyeMBlGz+CGafvY4TyG9Gfhtx47n821a0
        f7V/jLMhzAIk2PL280dqMgvkXpmnlvvI+eSyEWo64X55D28Y35Ij7KHo9Vii3CKsU0tys5
        oEupb9TdwMEfUoex5b3GjLvnkBaYLR0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-zcCzqGJ5MpiGxNbhuAOwRA-1; Fri, 04 Nov 2022 20:59:21 -0400
X-MC-Unique: zcCzqGJ5MpiGxNbhuAOwRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F78985A583;
        Sat,  5 Nov 2022 00:59:21 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A2242166B26;
        Sat,  5 Nov 2022 00:59:20 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v10 0/3] blk-cgroup: Optimize blkcg_rstat_flush()
Date:   Fri,  4 Nov 2022 20:58:59 -0400
Message-Id: <20221105005902.407297-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

 v10:
  - Update patch 3 to rename the rstat function to
    cgroup_rstat_css_cpu_flush().

 v9:
  - Remove patch "llist: Allow optional sentinel node terminated lockless
    list" for now. This will be done as a follow-up patch.
  - Add a new lqueued field to blkg_iostat_set to store the status of
    whether lnode is in a lockless list.
  - Add a new patch 3 to speed up the freeing of blkcg by flushing out
    the rstat lockless lists at blkcg offline time.

 v8:
  - Update the llist patch to make existing llist functions and macros
    work for both NULL and sentinel terminated lockless list as much
    as possible and leave only the initialization and removal functions
    to have a sentinel terminated llist variants.

This patch series improves blkcg_rstat_flush() performance by eliminating
unnecessary blkg enumeration and flush operations for those blkg's and
blkg_iostat_set's that haven't been updated since the last flush.

Waiman Long (3):
  blk-cgroup: Return -ENOMEM directly in blkcg_css_alloc() error path
  blk-cgroup: Optimize blkcg_rstat_flush()
  blk-cgroup: Flush stats at blkgs destruction path

 block/blk-cgroup.c     | 103 +++++++++++++++++++++++++++++++++++------
 block/blk-cgroup.h     |  10 ++++
 include/linux/cgroup.h |   1 +
 kernel/cgroup/rstat.c  |  20 ++++++++
 4 files changed, 119 insertions(+), 15 deletions(-)

-- 
2.31.1

