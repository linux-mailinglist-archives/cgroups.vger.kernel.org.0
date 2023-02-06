Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC0C68C8F8
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 22:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBFVuD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 16:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjBFVt7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 16:49:59 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F2C303CC;
        Mon,  6 Feb 2023 13:49:26 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id mi9so12956042pjb.4;
        Mon, 06 Feb 2023 13:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ8nBL9fnm50KWgUG103EnYdV8ecPmtZB51kTE6QsSA=;
        b=DQQkID5hUpP033/mOHpgBQZWTHKCSByRDkLaZoT/cPufR557J/8Q0jWWOO5KDPuirY
         zzyyIGeUz7UGnoPyzkwVPfjyRPt/Vt/bepBP4vLh9cM5B/VXeadsX75tAGKuTR1WWyVI
         7gVjiEnnptVUCLs+uXMNODpZulbQtCyxtsFSYzIARHsaqpoOIQnMBv0iENEc2iF9tdPZ
         zy9lDvznqeVkWe6tFhx93C6wil2jSimcRah/5T1Em3FfQ/mzRa+A25LeYIxQ0MPCLx/W
         54NkKo1sCBPU5GwWhjWnaSXsdDOX1AzvJKj8MfNh5zCyCK5j4gyc/YNkf+8p6qYtoTqR
         IwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZ8nBL9fnm50KWgUG103EnYdV8ecPmtZB51kTE6QsSA=;
        b=T2GrF/msxA+NkoKw1sVXP+zJyY9uza44d0r/zDNoSZER1DopdkM3O6GBQFHI0+em9r
         XR34aDP5ao4R0ADzvGZg1qaK7FBKpMlS1rRnCqg6jHgjfUKBp2hJfkFd7fyCMHe+3MvB
         zIiPpgA4ZYyFZrexCS4BzdhzLCuA8p0CR1Xu4NKfiO2sp784tPBkxFxPFWcEMDD8x6KN
         WKs4udhJEsUpkj1a6+TzEhjEDjrldZJHwdx5OkOaECZUL0astb87jdLFNbgUr+n1cKHJ
         8eQdndxjPF7YpiNfYL/BLzWl4o/kwJA27eQQD2VAO9umRsD2RRoDjIBls6eKUta53qpV
         bTsg==
X-Gm-Message-State: AO0yUKUoVWaKRoCL7x1w7DjlHp0rsADwsNV8Ad/ckzwA5h7CpYin8y4b
        CUgOxDBZI6/kJ9pfp0QJgI0=
X-Google-Smtp-Source: AK7set+8T3nsc6X6z3oUR56tzCU54cjPawlognigxqcUu5NuW5PrzRhOBzEwNtjOt1ClbDM0d54eig==
X-Received: by 2002:a17:903:111:b0:199:1faa:1b72 with SMTP id y17-20020a170903011100b001991faa1b72mr298907plc.45.1675720165300;
        Mon, 06 Feb 2023 13:49:25 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902ee9100b00198fcb1b2c2sm4481500pld.218.2023.02.06.13.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:49:24 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 6 Feb 2023 11:49:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [GIT PULL] cgroup fixes for v6.2-rc7
Message-ID: <Y+F149pNVNcMJQIn@slm.duckdns.org>
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

The following changes since commit d2d11f342b179f1894a901f143ec7c008caba43e:

  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2023-02-05 17:17:10 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.2-rc7-fixes

for you to fetch changes up to 7a2127e66a00e073db8d90f9aac308f4a8a64226:

  cpuset: Call set_cpus_allowed_ptr() with appropriate mask for task (2023-02-06 10:18:36 -1000)

----------------------------------------------------------------
cgroup fixes for v6.2-rc7

During v6.2 cycle, there were a series of changes to task cpu affinity
handling which fixed cpuset inadvertently clobbering user-configured
affinity masks. Unfortunately, they broke the affinity handling on hybrid
heterogeneous CPUs which have cores that can execute both 64 and 32bit along
with cores that can only execute 32bit code.

This late pull request contains two fix patches for the above issue. While
reverting the changes that caused the regression is definitely an option,
the origial patches do improve how cpuset behave signficantly in some cases
and the fixes seem fairly safe, so I think it'd be better to try to fix them
first.

----------------------------------------------------------------
Waiman Long (1):
      cgroup/cpuset: Don't filter offline CPUs in cpuset_cpus_allowed() for top cpuset tasks

Will Deacon (1):
      cpuset: Call set_cpus_allowed_ptr() with appropriate mask for task

 kernel/cgroup/cpuset.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)
