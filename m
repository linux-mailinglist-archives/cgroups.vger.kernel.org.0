Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9806873B8
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 04:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjBBDTM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 22:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBBDTL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 22:19:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD20823DA6
        for <cgroups@vger.kernel.org>; Wed,  1 Feb 2023 19:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675307903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TnLYuETykZ3l9f+iMHZlyv3/ZWGHek1M/oMz9w9vUAU=;
        b=YhJIYZEhl26hfGZbnwwScqHnrmxPa1OA4vimfBineB7VltzgVwVYCDwkbGRensiCFI9Fzt
        uZ8/ojcTml7AXF/MTKoogZv5wF17sewNKcnnbUVO1uDbURATE8BCixaYqKHxRN0AdfdMUW
        vJlsGM26mHf/5lRxNGnBcnEo7bQggGY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-w2-jySeQPwqs4FzipE0c8w-1; Wed, 01 Feb 2023 22:18:20 -0500
X-MC-Unique: w2-jySeQPwqs4FzipE0c8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CAD538149AC;
        Thu,  2 Feb 2023 03:18:20 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AC252026D4B;
        Thu,  2 Feb 2023 03:18:19 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@android.com, Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] cgroup/cpuset: Make hotplug code more efficient
Date:   Wed,  1 Feb 2023 22:17:47 -0500
Message-Id: <20230202031749.118146-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This small patch series makes the cpuset hotplug a bit more efficient
by eliminating unnecessary task iteration and cpu/node masks update
when an hotplug event (online/offline) happens.

These patches can also avoid the known problem of missing a previously
gone offline cpu in v1 cpuset after a single cpu offline and online
sequence.

Waiman Long (2):
  cgroup/cpuset: Skip task update if hotplug doesn't affect current
    cpuset
  cgroup/cpuset: Don't update tasks' cpumasks for cpu offline events

 kernel/cgroup/cpuset.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

-- 
2.31.1

