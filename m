Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F61A5F32CF
	for <lists+cgroups@lfdr.de>; Mon,  3 Oct 2022 17:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJCPpg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Oct 2022 11:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJCPpe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Oct 2022 11:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ADEE69
        for <cgroups@vger.kernel.org>; Mon,  3 Oct 2022 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664811932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xusHdmDukwYHMbUJFh7S0rrQ2RjmbWo7AAZhEr8dtGk=;
        b=PE/xP0G96LHSjfXtDyAR0gM+Ke4E8BmkXwBI06lt4nNcZINZsf3wHyFvXSVRPZQK2rI9WE
        HCSHarwyVFmp3mpLL8vxXVZ8HN5yh6/QJezE9AM7j2Jef/AdF/CCcR/dbt0uJuIV7ETq8T
        5uP/8PHv6926jOtQuhzf8nvcm7jLLIE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-9uDLktXuNka7DDbBSkZcVQ-1; Mon, 03 Oct 2022 11:45:31 -0400
X-MC-Unique: 9uDLktXuNka7DDbBSkZcVQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1893729ABA0E;
        Mon,  3 Oct 2022 15:45:31 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A14B2027061;
        Mon,  3 Oct 2022 15:45:30 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v7 0/3] blk-cgroup: Optimize blkcg_rstat_flush()
Date:   Mon,  3 Oct 2022 11:44:56 -0400
Message-Id: <20221003154459.207538-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

 v7:
  - Drop patch 1 ("blk-cgroup: Correctly free percpu iostat_cpu in blkg
    on error exit") as it is found to be unnecessary.
  - Add a new llist patch to provide a lockless list variant terminated
    by a sentinel node.
  - Modified patch 3 to use the new sllist API and move percpu_ref_put()
    later in the blkcg_rstat_flush() loop to prevent potential
    use-after-free problem.

 v6:
  - Add a missing free_percpu() into blkcg_css_free() in patch 3.
  - Integrating the documentation patch 4 back into patch 3.

 v5:
  - Add a new patch 2 to eliminate the use of intermediate "ret"
    variable in blkcg_css_alloc() to fix compilation warning reported
    by kernel test robot.

This patch series improves blkcg_rstat_flush() performance by eliminating
unnecessary blkg enumeration and flush operations for those blkg's and
blkg_iostat_set's that haven't been updated since the last flush.

Waiman Long (3):
  llist: Add a lock-less list variant terminated by a sentinel node
  blk-cgroup: Return -ENOMEM directly in blkcg_css_alloc() error path
  blk-cgroup: Optimize blkcg_rstat_flush()

 block/blk-cgroup.c    |  85 ++++++++++++++++++++++-----
 block/blk-cgroup.h    |   9 +++
 include/linux/llist.h | 132 +++++++++++++++++++++++++++++++++++++++++-
 lib/llist.c           |  79 ++++++++++++++++++++++++-
 4 files changed, 289 insertions(+), 16 deletions(-)

-- 
2.31.1

