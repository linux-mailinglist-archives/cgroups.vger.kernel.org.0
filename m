Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174D2626C28
	for <lists+cgroups@lfdr.de>; Sat, 12 Nov 2022 23:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiKLWVG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Nov 2022 17:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLWVF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Nov 2022 17:21:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57D9DF3F
        for <cgroups@vger.kernel.org>; Sat, 12 Nov 2022 14:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668291610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hPqQ7pS391n2tdE33js5OayByAWbyhFUU/9GmPjNmvs=;
        b=FxhmZURPYpYEqY7NdrWnQg4M0Yw5WeuI9c82qvCnqeFGdOnDgA/UTfI7xb67XFsEk1nwYp
        Vcfj7WRnTX9HoT6+4XUr+6xUEekfq73Fl72sdaVaAM4/+VY5OVyjc5iT7/LzDDP+xtCXQT
        6uPy1PcauVSj5jbtm5YxllZfvEtom6M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-h7gYLtUcNRy4cGvi6gEDzQ-1; Sat, 12 Nov 2022 17:20:09 -0500
X-MC-Unique: h7gYLtUcNRy4cGvi6gEDzQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9409085A583;
        Sat, 12 Nov 2022 22:20:08 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF75DC15BA4;
        Sat, 12 Nov 2022 22:20:07 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] cgroup/cpuset: v2 optimization
Date:   Sat, 12 Nov 2022 17:19:37 -0500
Message-Id: <20221112221939.1272764-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patchset contains 2 patches to optimize out unneeded works when
running on a cgroup v2 environment.

Waiman Long (2):
  cgroup/cpuset: Skip spread flags update on v2
  cgroup/cpuset: Optimize cpuset_attach() on v2

 kernel/cgroup/cpuset.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

-- 
2.31.1

