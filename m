Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743E926C14C
	for <lists+cgroups@lfdr.de>; Wed, 16 Sep 2020 12:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIPKAv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Sep 2020 06:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgIPKAq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Sep 2020 06:00:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF786C06178A
        for <cgroups@vger.kernel.org>; Wed, 16 Sep 2020 03:00:42 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j34so3601249pgi.7
        for <cgroups@vger.kernel.org>; Wed, 16 Sep 2020 03:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTKM9QuKkaPGqtUV+sgdxsS+sauamtAwYDBe99O9veY=;
        b=W/CybB0aDEi03zEZMzNc5Gk8+FAroM0TOHUoMJTbHAXDeTLVq/CI+pzbtFPz8oiyIb
         +uKwz1uh8sYbDTiD17dINRgdWBvTEbFWLEksIXBysH3TCI5gGklRYR8FiG1kyfjMUEk7
         t/PHvkBeBLulci1WpfRg/+By3Cuqwaxsd6dfPXu5XtbgfeJF68mqeisCPybocTZqioFX
         oRryMf3CdmJh8mKB3HiyjsFwzicPfmYQSwXPq7AEmeEtpQNs8VLDPoWVfNRsfdwwt0X2
         mhCsaHCJoDQloVCPYW7Cv+nzSq9lejGiPtLV/qw1pNMxiOVRMAdLJxdoqNHNwuUBuJxz
         tAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTKM9QuKkaPGqtUV+sgdxsS+sauamtAwYDBe99O9veY=;
        b=iDLVlMXsQMr+rzqPoKSj28LoaL77IDuWY/xkLfRy/xBi6801xlkU0Nf74teCUusfW2
         9MyjXTLqeOPgS2E/zoV24paFPmqZpYKZNWusKMJsKSyOp9qpfkjU+a6xENds7TX5QPUi
         4RjBqxWFNUu0JUImmcFHQIjh2pgF1yMDravbum0KvERBgJRG6n7y7LdLnRdjFVsVJsqJ
         xBikXfURt4nbbJnZqYTth0o5bABbh0MVbReJxR5S8/cFUAVbXeReevjaEFzOsTGTCTFW
         hUd/kZ1qvv1qonXBlVcgksKH2eUoNC6unYgRRHftBTImGuK614qdgb5xXV5huBNDrYqq
         EtMA==
X-Gm-Message-State: AOAM532K/QKGUnnPs/Rvn0q8BCuU+IMZmxvjWsdHbAmnwF2OzKkWQQBA
        pi5J6NqobzrbOTCyb3VEQoDweg==
X-Google-Smtp-Source: ABdhPJxhAwoiQyjmcC9wFN2dsD+S/qSBFzxov9l4tp7W0GvhuYI8p6+kJbO6Yk51V7MMg091MQYaog==
X-Received: by 2002:a62:301:0:b029:13c:1611:6528 with SMTP id 1-20020a6203010000b029013c16116528mr21670404pfd.8.1600250441876;
        Wed, 16 Sep 2020 03:00:41 -0700 (PDT)
Received: from bogon.bytedance.net ([103.136.220.68])
        by smtp.gmail.com with ESMTPSA id y3sm17205748pfb.18.2020.09.16.03.00.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 03:00:41 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        rdunlap@infradead.org
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 1/2] mm: memcontrol: Fix missing suffix of workingset_restore
Date:   Wed, 16 Sep 2020 18:00:29 +0800
Message-Id: <20200916100030.71698-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We forget to add the suffix to the workingset_restore string, so
fix it. And also update the documentation of cgroup-v2.rst.

Fixes: 170b04b7ae49 ("mm/workingset: prepare the workingset detection infrastructure for anon LRU")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 changelog in v6:
 1. There is no version of v1-v5.

 Documentation/admin-guide/cgroup-v2.rst | 25 ++++++++++++++++++-------
 mm/memcontrol.c                         |  4 ++--
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6be43781ec7f..baa07b30845e 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1324,15 +1324,26 @@ PAGE_SIZE multiple when read back.
 	  pgmajfault
 		Number of major page faults incurred
 
-	  workingset_refault
-		Number of refaults of previously evicted pages
+	  workingset_refault_anon
+		Number of refaults of previously evicted anonymous pages.
 
-	  workingset_activate
-		Number of refaulted pages that were immediately activated
+	  workingset_refault_file
+		Number of refaults of previously evicted file pages.
 
-	  workingset_restore
-		Number of restored pages which have been detected as an active
-		workingset before they got reclaimed.
+	  workingset_activate_anon
+		Number of refaulted anonymous pages that were immediately
+		activated.
+
+	  workingset_activate_file
+		Number of refaulted file pages that were immediately activated.
+
+	  workingset_restore_anon
+		Number of restored anonymous pages which have been detected as
+		an active workingset before they got reclaimed.
+
+	  workingset_restore_file
+		Number of restored file pages which have been detected as an
+		active workingset before they got reclaimed.
 
 	  workingset_nodereclaim
 		Number of times a shadow node has been reclaimed
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 75cd1a1e66c8..0e85a054017f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1574,9 +1574,9 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 		       memcg_page_state(memcg, WORKINGSET_ACTIVATE_ANON));
 	seq_buf_printf(&s, "workingset_activate_file %lu\n",
 		       memcg_page_state(memcg, WORKINGSET_ACTIVATE_FILE));
-	seq_buf_printf(&s, "workingset_restore %lu\n",
+	seq_buf_printf(&s, "workingset_restore_anon %lu\n",
 		       memcg_page_state(memcg, WORKINGSET_RESTORE_ANON));
-	seq_buf_printf(&s, "workingset_restore %lu\n",
+	seq_buf_printf(&s, "workingset_restore_file %lu\n",
 		       memcg_page_state(memcg, WORKINGSET_RESTORE_FILE));
 	seq_buf_printf(&s, "workingset_nodereclaim %lu\n",
 		       memcg_page_state(memcg, WORKINGSET_NODERECLAIM));
-- 
2.20.1

