Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1737D619FA8
	for <lists+cgroups@lfdr.de>; Fri,  4 Nov 2022 19:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiKDSV7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Nov 2022 14:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiKDSV6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Nov 2022 14:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244C94AF28
        for <cgroups@vger.kernel.org>; Fri,  4 Nov 2022 11:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667586060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mwGJiTiSAfN6PRbmiMouEvgWpKw4XbL4CZuerrQ/8Q0=;
        b=H/3sOjE1AyWZmzrBEzNhNyflt7Xx9bAFXtCUpOqSxloXxZi+yEND94A0swj4ioxy2Y0uws
        rkR0Qmm8aVhYs8t1DzcECD3VqB9Ri0jraiZtJWUda0lmS0BV/ouN+60TpkFQdRNuq8m6we
        7kpHucxHn6oXBkCOG+9suU2mZ6v9X2Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-cI6xdKNwNXayL6aN7p5wlQ-1; Fri, 04 Nov 2022 14:20:57 -0400
X-MC-Unique: cI6xdKNwNXayL6aN7p5wlQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 867B61C05196;
        Fri,  4 Nov 2022 18:20:56 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB927C15BA5;
        Fri,  4 Nov 2022 18:20:55 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v9 0/3] blk-cgroup: Optimize blkcg_rstat_flush()
Date:   Fri,  4 Nov 2022 14:20:47 -0400
Message-Id: <20221104182050.342908-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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

 v7:
  - Drop patch 1 ("blk-cgroup: Correctly free percpu iostat_cpu in blkg
    on error exit") as it is found to be unnecessary.
  - Add a new llist patch to provide a lockless list variant terminated
    by a sentinel node.
  - Modified patch 3 to use the new sllist API and move percpu_ref_put()
    later in the blkcg_rstat_flush() loop to prevent potential
    use-after-free problem.


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

