Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B9E524CFD
	for <lists+cgroups@lfdr.de>; Thu, 12 May 2022 14:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350573AbiELMfA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 May 2022 08:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353870AbiELMez (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 May 2022 08:34:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7242D165D44;
        Thu, 12 May 2022 05:34:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h186so1828123pgc.3;
        Thu, 12 May 2022 05:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=yQ5WC+qcQWn5/mQktyQ4optwmHzpiPFv8x+qVdD6+j8=;
        b=nEtYBtR0RP200nt2NTfIFNPaHyXnOsWGHzp9bm7b6ycK/2hhsrwxnHCX0QWasV/LPq
         QUbVu4Ylnd5FdLc4hkvamnC6zKkY1XFu21kltQv3rRySkga5epOVe5zRVSaiG349p1ok
         vDvii4rC9Sr8FMOnGiNJt4bvHQyqQAPSxQIJ4ua5i3vBm1JaeZdV4pVbfCp714ZOJAhA
         bge3VVDrkGabUdjqKhBlGsiLQwgjWBz7Z6rYlkAfNjKiYqRTqiStuF+8LJN9bwNlPRVb
         8esE+scWFh4J1fhe/y8wtZAUpFXnC1tvh+AFHA67DGl7UsVnWivZtgGM+Z347v9bNb/C
         OLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=yQ5WC+qcQWn5/mQktyQ4optwmHzpiPFv8x+qVdD6+j8=;
        b=fJn0bQTHzTqXjoXWEtw6uIR5jLyG3jkrL5SMuIjAy3jrmR//jjKd1OM8SuS2LDYE36
         1qnfusPvq9fG0gavoa1mmWKfG3xomnk/CkJgPlCa4UTJ0TGG6LIw67lLN3y2zeMdRdfc
         wyn+k2g1Uii/nzXCEBPunJX56D6Jo/J8a2IIPohH40LwoznvcdjgMCEBlhfv7IwrpYQh
         Ck8fI5uEuMse/5pGX+kq8QhZ5glTXsurnnHTPQ8WFCr+1dDT+FAiZ3LDAbotqCNfIgLV
         iVQYsGsQD4e9MjWItyYrnvtBXPlldVsv7mnJrQ86C90RPNs1unz+qVphZJnVGZJnbI4V
         z8WQ==
X-Gm-Message-State: AOAM5308o3YZ4JQnnWg4AUJgjCmRyWS9bn9NV4jcCVk/eg9+d1ZDGRAK
        isBVTvk9ZYsumyGjGWEJmV7TZWa3DAM=
X-Google-Smtp-Source: ABdhPJwLRrKmpLcRZdI+y9ESvkx5IO/3s59v/pkumtgamKiIN06JgAS4mXsn/09jTM05zY8VIRa4og==
X-Received: by 2002:a63:561c:0:b0:3c1:42fb:cd81 with SMTP id k28-20020a63561c000000b003c142fbcd81mr25803928pgb.104.1652358893907;
        Thu, 12 May 2022 05:34:53 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id 188-20020a6308c5000000b003c14af505f8sm1759534pgi.16.2022.05.12.05.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:34:53 -0700 (PDT)
Date:   Thu, 12 May 2022 20:34:28 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/mempolicy: fix uninit-value in mpol_rebind_policy()
Message-ID: <20220512123428.fq3wofedp6oiotd4@ppc.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

mpol_set_nodemask()(mm/mempolicy.c) does not set up nodemask when
pol->mode is MPOL_LOCAL. Check pol->mode before access
pol->w.cpuset_mems_allowed in mpol_rebind_policy()(mm/mempolicy.c).

BUG: KMSAN: uninit-value in mpol_rebind_policy mm/mempolicy.c:352 [inline]
BUG: KMSAN: uninit-value in mpol_rebind_task+0x2ac/0x2c0 mm/mempolicy.c:368
 mpol_rebind_policy mm/mempolicy.c:352 [inline]
 mpol_rebind_task+0x2ac/0x2c0 mm/mempolicy.c:368
 cpuset_change_task_nodemask kernel/cgroup/cpuset.c:1711 [inline]
 cpuset_attach+0x787/0x15e0 kernel/cgroup/cpuset.c:2278
 cgroup_migrate_execute+0x1023/0x1d20 kernel/cgroup/cgroup.c:2515
 cgroup_migrate kernel/cgroup/cgroup.c:2771 [inline]
 cgroup_attach_task+0x540/0x8b0 kernel/cgroup/cgroup.c:2804
 __cgroup1_procs_write+0x5cc/0x7a0 kernel/cgroup/cgroup-v1.c:520
 cgroup1_tasks_write+0x94/0xb0 kernel/cgroup/cgroup-v1.c:539
 cgroup_file_write+0x4c2/0x9e0 kernel/cgroup/cgroup.c:3852
 kernfs_fop_write_iter+0x66a/0x9f0 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:2162 [inline]
 new_sync_write fs/read_write.c:503 [inline]
 vfs_write+0x1318/0x2030 fs/read_write.c:590
 ksys_write+0x28b/0x510 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0xdb/0x120 fs/read_write.c:652
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:3251 [inline]
 slab_alloc mm/slub.c:3259 [inline]
 kmem_cache_alloc+0x902/0x11c0 mm/slub.c:3264
 mpol_new mm/mempolicy.c:293 [inline]
 do_set_mempolicy+0x421/0xb70 mm/mempolicy.c:853
 kernel_set_mempolicy mm/mempolicy.c:1504 [inline]
 __do_sys_set_mempolicy mm/mempolicy.c:1510 [inline]
 __se_sys_set_mempolicy+0x44c/0xb60 mm/mempolicy.c:1507
 __x64_sys_set_mempolicy+0xd8/0x110 mm/mempolicy.c:1507
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae

KMSAN: uninit-value in mpol_rebind_task (2)
https://syzkaller.appspot.com/bug?id=d6eb90f952c2a5de9ea718a1b873c55cb13b59dc

Reported-and-tested-by: syzbot+217f792c92599518a2ab@syzkaller.appspotmail.com
Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
---
The uninit-value is pol->w.cpuset_mems_allowed in
mpol_rebind_policy().

While syzkaller reproducer runs, I notice pol->mode is 4(MPOL_LOCAL) in
    mpol_set_nodemask()
  do_set_mempolicy()(mm/mempolicy.c)
that `nodemask` in `pol` is not initialized, which will be accessed in
mpol_rebind_policy().

 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10e9c87260ed..18b74f02da71 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -347,7 +347,7 @@ static void mpol_rebind_preferred(struct mempolicy *pol,
  */
 static void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
 {
-	if (!pol)
+	if (!pol || pol->mode == MPOL_LOCAL)
 		return;
 	if (!mpol_store_user_nodemask(pol) &&
 	    nodes_equal(pol->w.cpuset_mems_allowed, *newmask))
-- 
2.30.2

