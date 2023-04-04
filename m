Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF926D69CB
	for <lists+cgroups@lfdr.de>; Tue,  4 Apr 2023 19:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbjDDRHM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Apr 2023 13:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjDDRHK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Apr 2023 13:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DC2D3
        for <cgroups@vger.kernel.org>; Tue,  4 Apr 2023 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680627985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cDBp1UWkXLcCy6UhLlPWhWDI0u/2pUwKDhHAxjWms3Y=;
        b=Bv0ypbZ21dmNjhjIE7aeNbi/it7+RT4jKa2C1Ci9+2BWBU5MJdg+pOCIUFh4+J93SpMj08
        fnY3aVYGmzVIsCxrHdfvZxSV/fVNwu704D6HAtufdK3hgASElEUSU9FERhrQGqkJMPv8WG
        uKf5VqnWUqzuaonG04Rr/nBT1qHdZsU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612--IiRDVs0PvmFeVU0KT0WkA-1; Tue, 04 Apr 2023 13:06:22 -0400
X-MC-Unique: -IiRDVs0PvmFeVU0KT0WkA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DA5B38601A9;
        Tue,  4 Apr 2023 17:06:16 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A728C440D6;
        Tue,  4 Apr 2023 17:06:15 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        gscrivan@redhat.com, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/4] cgroup/cpuset: Fix CLONE_INTO_CGROUP problem & other issues
Date:   Tue,  4 Apr 2023 13:05:42 -0400
Message-Id: <20230404170546.2585050-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

 v2:
  - Drop v1 patch 3
  - Add a new patch to fix an issue in cpuset_cancel_attach() and
    another patch to add cpuset_can_fork() and cpuset_cacnel_fork()
    methods.

The first patch in this series fixes a problem in
cpuset_cancel_attach(). Patches 2 and 3 fixes the CLONE_INTO_CGROUP
problem in cpuset. The last one is a minor fix.

Waiman Long (4):
  cgroup/cpuset: Wake up cpuset_attach_wq tasks in
    cpuset_cancel_attach()
  cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly
  cgroup/cpuset: Add cpuset_can_fork() and cpuset_cancel_fork() methods
  cgroup/cpuset: Make cpuset_attach_task() skip subpartitions CPUs for
    top_cpuset

 kernel/cgroup/cpuset.c | 150 ++++++++++++++++++++++++++++++++---------
 1 file changed, 118 insertions(+), 32 deletions(-)

-- 
2.31.1

