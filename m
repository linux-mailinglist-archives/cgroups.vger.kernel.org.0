Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFF95A1816
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 19:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiHYRnd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 13:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiHYRnc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 13:43:32 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2A2B6D2A;
        Thu, 25 Aug 2022 10:43:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id m2so19155700pls.4;
        Thu, 25 Aug 2022 10:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc;
        bh=2Q9sxu1HRBMxvkcK86QE22Ms07BjEIEOP4ZDQ3uVSzc=;
        b=FCXHKofw5D2STaFKgE47setXTxKBRs80FRNxxPkumH4L1qjSM5ciq8KO4NAysGvJuD
         wr80KVTFsGVBIOgkAQqhEf8h4/r2Scasna7nu5ebGaoteIadBcXH9IJaAK0/262G0/LD
         dFd0+Rtvb+tXtPz9XcAmqH/2Xr6NacQC9VJJuJ5Y0scTs5HbQ5EMrwTZIZgbyK508Jpy
         2BIdgqsFs5pFwkCgbpFWmXsmo+RQ6CZR5yTLqRiAzcdsq65OfeFKrf4xjDyrAjPzTtFK
         s7+0vfpVVdMUMc0aCVA10L/ZtXWrC6HSvXJE9eKqNgqvnpn0Rmu+lZ2Qp6S5yLnbroYg
         NGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc;
        bh=2Q9sxu1HRBMxvkcK86QE22Ms07BjEIEOP4ZDQ3uVSzc=;
        b=m2Ct9a+BqMKi+428omUrC+carQzGPyP8fmcPlnIPm6c+yEYuNrjKO/iirCV4r23XSw
         dNOnzirtgR3PENUaoM0jkxwZ1/qTYk+TwwOBNd3z3D15Vp470i7mFn6oybV1B9O+II7l
         OymcOQEIqSZtjHSFdTkz9Ej1Y026GJ1r4CqpcN/oSAbl7QcupZO1j2i4d0tsNCoAyjL1
         ZvL+6y/hHxkXRg9+umnPXqB1lJMeVO0AGklW8U8C52tdt6Y+p3UI/PT1t7yXJb0qnea6
         h1uFrEZl1Q5UD6C6jaEFIEZvzpnTiMXMjLW3lnou0Hcbs+1jVIFllpNKh0rRX0X0/lML
         KCnw==
X-Gm-Message-State: ACgBeo2LWSBoZPjGH0JQ383xe7ZeR4ld8RAdCly4P+piVXCttYEEBTHm
        iL5otGXpwTm2qMimwcxHEj8=
X-Google-Smtp-Source: AA6agR5TyjlWqCz/7+W7Bd1f+2e+LclerB3KYBGfN9ot+qYG8JspDm7ZIXSscqU99KN19Qh1kx/8Jg==
X-Received: by 2002:a17:90b:17ce:b0:1fb:3b43:f6f8 with SMTP id me14-20020a17090b17ce00b001fb3b43f6f8mr269193pjb.76.1661449410138;
        Thu, 25 Aug 2022 10:43:30 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b0016f975be2e7sm15054336plr.139.2022.08.25.10.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 10:43:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 25 Aug 2022 07:43:27 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [GIT PULL] cgroup fixes #2 for v6.0-rc2
Message-ID: <Ywe0v0YWJSVAs5FT@slm.duckdns.org>
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

The following changes since commit 763f4fb76e24959c370cdaa889b2492ba6175580:

  cgroup: Fix race condition at rebind_subsystems() (2022-08-23 08:11:06 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.0-rc2-fixes-2

for you to fetch changes up to 43626dade36fa74d3329046f4ae2d7fdefe401c6:

  cgroup: Add missing cpus_read_lock() to cgroup_attach_task_all() (2022-08-25 07:36:30 -1000)

----------------------------------------------------------------
4f7e7236435ca0ab ("cgroup: Fix threadgroup_rwsem <-> cpus_read_lock()
deadlock") in the previous fix pull required cgroup core to grab
cpus_read_lock() before invoking ->attach(). Unfortunately, it missed adding
cpus_read_lock() in cgroup_attach_task_all(). Fix it.

----------------------------------------------------------------
Tetsuo Handa (1):
      cgroup: Add missing cpus_read_lock() to cgroup_attach_task_all()

 kernel/cgroup/cgroup-v1.c | 2 ++
 1 file changed, 2 insertions(+)
