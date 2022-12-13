Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A589464BC43
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 19:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbiLMSpq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 13:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbiLMSpn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 13:45:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8252F24F19
        for <cgroups@vger.kernel.org>; Tue, 13 Dec 2022 10:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670957103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gC79KdPgX8meWkHV6kEH9PpY7k/sykKi+3gQfcC9IOQ=;
        b=GrJhw/afHh5tSPXb6noS6xJNUuigebxVQEAiDXu4KcNNJZymo6gX8c1enDPBIsKihc8USf
        U9VaPCpAvVG+FmgUGLPwaoJFnB6382DUvgqte0UECpJmjH1yo5AXsDfl/9HBKuFQB8llft
        Hv6Wh9VJYpccItP2pH18LUzQ7MavRiU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-BvYR3lxsNKWZAZOxPDL65Q-1; Tue, 13 Dec 2022 13:44:58 -0500
X-MC-Unique: BvYR3lxsNKWZAZOxPDL65Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6381185A78F;
        Tue, 13 Dec 2022 18:44:57 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E9CCC15BA0;
        Tue, 13 Dec 2022 18:44:57 +0000 (UTC)
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
Subject: [PATCH-block v3 0/2] blk-cgroup: Fix potential UAF & flush rstat at blkgs destruction path
Date:   Tue, 13 Dec 2022 13:44:44 -0500
Message-Id: <20221213184446.50181-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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
be fixed. The second patch flushes rstat when blkcg_destroy_blkgs().

Waiman Long (2):
  bdi, blk-cgroup: Fix potential UAF of blkcg
  blk-cgroup: Flush stats at blkgs destruction path

 block/blk-cgroup.c     | 22 ++++++++++++++++++++++
 include/linux/cgroup.h |  1 +
 kernel/cgroup/rstat.c  | 18 ++++++++++++++++++
 mm/backing-dev.c       |  8 ++++++--
 4 files changed, 47 insertions(+), 2 deletions(-)

-- 
2.31.1

