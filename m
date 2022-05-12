Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8585253A8
	for <lists+cgroups@lfdr.de>; Thu, 12 May 2022 19:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350599AbiELRaD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 May 2022 13:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347552AbiELRaC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 May 2022 13:30:02 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6224326ADBA;
        Thu, 12 May 2022 10:30:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q18so5542002pln.12;
        Thu, 12 May 2022 10:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AyYwNHrrFSveH2j8M/8x/XkyABlhchvxowKUFBK5pvg=;
        b=NlFGVJUc203qX2UEbtIf5QdXTzhQ97zk2FRQ6bfBDGBWadHki9DCSwoXnNuLGJKFhd
         75jmHjdopWJ/sBMRqPeCqc5UQlGOYEDi/Ky2Wcp55+lnwrkwcnmV633o1dPRWBJzLbos
         UePpWrykeOT5OvB4JfTD6upm2VTxF7Bu8Us4AAchm+8Trj9N9USQAFC+2uyFMZdrnU6r
         kRg5JaR17Sgw3H0zaPeAG4Mm9BthlWJppfjADw5AvWu7U3dT4Da3X//88AEOVZix7reF
         L4waIWDyg9FbmRhO7zsK48FcovRP8CDdNjAFEyLfyI7x3UiXzY1l9augkfkTvh1Ez7ng
         fxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=AyYwNHrrFSveH2j8M/8x/XkyABlhchvxowKUFBK5pvg=;
        b=cwgeND2CXfDOE7iO/P7YZR6DEJYUmAxL97UMm7K+jMeyWf5KdEXP9VNW6O1+ULSfNJ
         wnH+v7f1fCKvMq3SN1KhB8GrYbXPvnGIvZ98/GuUwJ2ioz/mm1z0vgf2hVXuD7pUaEFV
         nqGjNGrcxB4q89dDwlfrgfrN0XMtqGj+ao2nV2i7R4azH12ZrLZnYhWKH2bkOxu0jJ1j
         Qii2R8FOvBQg5GxDue4o2GIlSUOSJWOyRfAreA+0KhJoi403dSoYwj8aGlopafkp9X0J
         oEmgPf+sL7BM8ei49QXPJe3LwxgMi8JHPEVhBPDhLL8sdAMOUhRzE/xwFZQqeh4EYJXP
         kFZw==
X-Gm-Message-State: AOAM531mKj0E5m74dPk1DJ0cj5VnPmKobjVLYF1okNXxFaOH67npMagL
        wtqzXIKg0odwSJLgybYNhRSu0N33LW0=
X-Google-Smtp-Source: ABdhPJw44++sm/6Wx4gGd8uQ313i8NjndTe9ryXTpcBWRUuulIMzlHVn2aAKIE9W9xGzU/SAOjKKJg==
X-Received: by 2002:a17:902:e842:b0:15e:d449:fd03 with SMTP id t2-20020a170902e84200b0015ed449fd03mr983853plg.60.1652376600520;
        Thu, 12 May 2022 10:30:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:6c64])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902f79200b0015e8d4eb1f9sm190729pln.67.2022.05.12.10.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 10:29:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 May 2022 07:29:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v5.18-rc6
Message-ID: <Yn1EFgZdbSSjTatf@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

This pull contains one commit - Waiman's fix for cgroup2 cpuset bug where it
could miss nodes which were hot-added.

Thanks.

The following changes since commit a7391ad3572431a354c927cf8896e86e50d7d0bf:

  Merge tag 'iomm-fixes-v5.18-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu (2022-05-04 11:04:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.18-fixes

for you to fetch changes up to 2685027fca387b602ae565bff17895188b803988:

  cgroup/cpuset: Remove cpus_allowed/mems_allowed setup in cpuset_init_smp() (2022-05-05 08:57:00 -1000)

----------------------------------------------------------------
Waiman Long (1):
      cgroup/cpuset: Remove cpus_allowed/mems_allowed setup in cpuset_init_smp()

 kernel/cgroup/cpuset.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9390bfd9f1cd..71a418858a5e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3390,8 +3390,11 @@ static struct notifier_block cpuset_track_online_nodes_nb = {
  */
 void __init cpuset_init_smp(void)
 {
-	cpumask_copy(top_cpuset.cpus_allowed, cpu_active_mask);
-	top_cpuset.mems_allowed = node_states[N_MEMORY];
+	/*
+	 * cpus_allowd/mems_allowed set to v2 values in the initial
+	 * cpuset_bind() call will be reset to v1 values in another
+	 * cpuset_bind() call when v1 cpuset is mounted.
+	 */
 	top_cpuset.old_mems_allowed = top_cpuset.mems_allowed;
 
 	cpumask_copy(top_cpuset.effective_cpus, cpu_active_mask);
