Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1EA688029
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 15:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjBBOc7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 09:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjBBOc7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 09:32:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB39712F0
        for <cgroups@vger.kernel.org>; Thu,  2 Feb 2023 06:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675348337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rb40jJZP+p+46lzXWGfp2d9j5iJL9Oz8USeC7Urj69w=;
        b=Vm9cLRazNKGQMQfq1ZEAQokeeLYVmA/ICs8BoVvba1e+WF4HZLs/xSq/Pl/+GpoKSFRcdq
        sdNrvQf1NE6JIgt6t0ieTFJAP9CrZjA1KyKZsKvKfwRFcFHm1Dzy8wfdE6khVbCcM3HY04
        eSRxjZ7eNgXZSILNcpBWwUw3gMsQSdg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-48-epyUifJSMGma_Yeffp4yeQ-1; Thu, 02 Feb 2023 09:32:15 -0500
X-MC-Unique: epyUifJSMGma_Yeffp4yeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BF9085CBE3;
        Thu,  2 Feb 2023 14:32:10 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B05FD51E5;
        Thu,  2 Feb 2023 14:32:09 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@android.com, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/2] cgroup/cpuset: Make hotplug code more efficient
Date:   Thu,  2 Feb 2023 09:31:58 -0500
Message-Id: <20230202143200.128753-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
  - It turns out it works around the v1 cpuset missing offline cpu
    problem better than I originally thought. So the patch description
    is updated accordingly.

This small patch series makes the cpuset hotplug a bit more efficient
by eliminating unnecessary task iteration and cpu/node masks update
when a cpu hotplug event (online/offline) happens.

It can also largely work around the known problem of missing previously
offlined cpus in v1 cpuset with some exceptions.

Waiman Long (2):
  cgroup/cpuset: Skip task update if hotplug doesn't affect current
    cpuset
  cgroup/cpuset: Don't update tasks' cpumasks for cpu offline events

 kernel/cgroup/cpuset.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

-- 
2.31.1

