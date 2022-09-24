Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0125E8811
	for <lists+cgroups@lfdr.de>; Sat, 24 Sep 2022 05:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiIXDxY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 23:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiIXDxY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 23:53:24 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C011514F5;
        Fri, 23 Sep 2022 20:53:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a29so1829609pfk.5;
        Fri, 23 Sep 2022 20:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date;
        bh=GMNz+KftYl/1qv6accKhoJLywxcAkp1GcqyaX1lVIew=;
        b=o0Zhm6dDb/qeEMXfT0OwKU1LAp+DgG9yxDdKvk0cR7JGneV6IS8BVRD93zzAOXvmvH
         QsRFkXnTVNbzGqUkMpzy/l9T0h2rls9tj4HO1IjxUcHH89LI8f9EwzXhr72zC5RJen8g
         N5UvLYhLNTT2nHjNWhTdh+11x9pmIfhMpg7sSFX2MPeoDXApLbXwQK5EzeNYcN18fsqH
         3lO7TfJkBnTSEQAC9fIqCnIpgf9gYd+rLJoJ4IBroo04bfLjm7YUqviHX0LwlC6dslmz
         qfLZYf968yqnh+oMF9n6FgQ/kucyn8vbTT8ykOmAWisGDEtBFKxvONeAdfYJI5r7CZaG
         AMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=GMNz+KftYl/1qv6accKhoJLywxcAkp1GcqyaX1lVIew=;
        b=qy0Pyr8T+cSOM598+qbHX70qWtU8sG7CQ1bWP5p8DpAoR8ISpcNdlEDxn65l2lR2wR
         JcuOPh1/rRV66jvIVsyqQl6R+pel4FxzB4ikp6ATQoRGh2PaxVEWRewW4Hoz9DZGBOoB
         /Rc4wpdNKw7FfRlYXusDtv0qZB8VF+Ct6S4HWnOFl6xa03QJMmUx1B19BhbDVTmdjsOX
         f5FeRbbEvShC57cp/bJ4KCIPG6gmdJkDZT1tAnxU+z/ZRKk/RfxfIaViBgMrezH9pDvb
         6fcYm24hP09/rWSNtPnXsu7TFR5UvSPngN85CHdFFgwe9/3aDMXPGThGuF3ejL/j0u8p
         Xsdg==
X-Gm-Message-State: ACrzQf3m07gZhdVEzhOG1rrpy17xrj3anHgp7TruHrmOB2J1FEqu2G2s
        PztAvCABWP2uZVhaL2zY4FaSRx94KmE3aQ==
X-Google-Smtp-Source: AMsMyM4bBj6fdErncEqkvHjFnFF42MQYcliulzCC2O+8KVQwnIgB1PBjQDFhF99SGxvMazgNB+Q94Q==
X-Received: by 2002:a63:b55d:0:b0:439:7a97:b89 with SMTP id u29-20020a63b55d000000b004397a970b89mr10555769pgo.70.1663991602896;
        Fri, 23 Sep 2022 20:53:22 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id b15-20020a1709027e0f00b0017854cee6ebsm6790619plm.72.2022.09.23.20.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 20:53:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 23 Sep 2022 17:53:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>
Subject: [GIT PULL] cgroup fixes for v6.0-rc6
Message-ID: <Yy5/MV8BvP+M5Fmi@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The following changes since commit 5995497296ade7716c8e70899e02235f2b6d9f5d:

  Merge tag 'powerpc-6.0-4' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2022-09-04 11:33:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.0-rc6-fixes

for you to fetch changes up to df02452f3df069a59bc9e69c84435bf115cb6e37:

  cgroup: cgroup_get_from_id() must check the looked-up kn is a directory (2022-09-23 07:18:45 -1000)

----------------------------------------------------------------
Cgroup fixes for v6.0-rc6

* Add Waiman Long as a cpuset maintainer.

* cgroup_get_from_id() could be fed a kernfs ID which doesn't point to a
  cgroup directory but a knob file and then crash. Error out if the lookup
  kernfs_node isn't a directory.

----------------------------------------------------------------
Ming Lei (1):
      cgroup: cgroup_get_from_id() must check the looked-up kn is a directory

Tejun Heo (1):
      cpuset: Add Waiman Long as a cpuset maintainer

 MAINTAINERS            | 1 +
 kernel/cgroup/cgroup.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
tejun
