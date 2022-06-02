Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F199D53B9E0
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 15:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiFBNgB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jun 2022 09:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbiFBNf7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jun 2022 09:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A1BA6FD3F
        for <cgroups@vger.kernel.org>; Thu,  2 Jun 2022 06:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654176957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RM/VM/BkJCFXBDQbLQtl/dczfhsVjGbr9q7yL7pUo/s=;
        b=gGG0StbbnAMlRDEvekijcTVrPsG81RLlk3N8xZ972Srta2Q2UCbe4gfGKfwclJepivdf6b
        qnvLkBdCLn6bDMLat7+U6dUtKjrMn72tXxcUvkU9VG9vsvVODrAt6YtTbntXt18owFvvSi
        fmWLqJPzjugM8S9XYtg0OfBV49Npv90=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-QpfwInDINwOXB57FDsZcwA-1; Thu, 02 Jun 2022 09:35:52 -0400
X-MC-Unique: QpfwInDINwOXB57FDsZcwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D160B811E81;
        Thu,  2 Jun 2022 13:35:51 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AF3C2166B2C;
        Thu,  2 Jun 2022 13:35:51 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 0/3] blk-cgroup: Optimize blkcg_rstat_flush()
Date:   Thu,  2 Jun 2022 09:35:40 -0400
Message-Id: <20220602133543.128088-1-longman@redhat.com>
In-Reply-To: <20220601211824.89626-1-longman@redhat.com>
References: <20220601211824.89626-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

 v5:
  - Add a new patch 2 to eliminate the use of intermediate "ret"
    variable in blkcg_css_alloc() to fix compilation warning reported
    by kernel test robot.

 v4:
  - Update comment and eliminate "inline" keywords as suggested by TJ.

 v3:
  - Update comments in patch 2.
  - Put rcu_read_lock/unlock() in blkcg_rstat_flush().
  - Use READ_ONCE/WRITE_ONCE() to access lnode->next to reduce data
    races.
  - Get a blkg reference when putting into the lockless list and put it
    back when removed.
 
This patch series improves blkcg_rstat_flush() performance by eliminating
unnecessary blkg enumeration and flush operations for those blkg's and
blkg_iostat_set's that haven't been updated since the last flush.

Waiman Long (3):
  blk-cgroup: Correctly free percpu iostat_cpu in blkg on error exit
  blk-cgroup: Return -ENOMEM directly in blkcg_css_alloc() error path
  blk-cgroup: Optimize blkcg_rstat_flush()

 block/blk-cgroup.c | 103 ++++++++++++++++++++++++++++++++++++++-------
 block/blk-cgroup.h |   9 ++++
 2 files changed, 96 insertions(+), 16 deletions(-)

-- 
2.31.1

