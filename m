Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2149D31ADE2
	for <lists+cgroups@lfdr.de>; Sat, 13 Feb 2021 21:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhBMUFQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 13 Feb 2021 15:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhBMUFK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 13 Feb 2021 15:05:10 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97585C061574;
        Sat, 13 Feb 2021 12:04:30 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id h8so3008606qkk.6;
        Sat, 13 Feb 2021 12:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=azyACAaeZShtsPZdyQW2VyvY2tG9ZntNC6GHA++ns2w=;
        b=OyomVyPvZfw5zGvSFus9OI5F6tzFKAtlT5VWC7UweDSxLTakygbtbFgB8nCZwaYh07
         DdITPm83zYamYoYM63myil3QkKBcMQDlClpGzDGGFDeVjxL4sH9RS8vWn9McdgTlRMDS
         Wjg3/LjCtowT/PoowJCqaUq7Ys4mtwvFaOlayHEkg4gxeolCnTdtGMISgWpgtPkqHdlb
         Je5qb7sACQXd9otY2qcpM1Y/EH0+N4A8kkFEC2s0WbEjdhyyYWqDPu9Al2CCkuH3qTxb
         l+0frEutZpH98vUNuZxFj8sJaXDaKw8JLn+5wc+2KIlkqB6/DgCsrXv2GY/D+/KT+sTZ
         S7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=azyACAaeZShtsPZdyQW2VyvY2tG9ZntNC6GHA++ns2w=;
        b=dx97jXnV/LitWEdhsCkbZZx1Y5odsWa3mMLhFBz6Sg0YgTWbpj+Rqior2OEftd2eZg
         1IwlJbBXQ9ZnkU91BGmaz4s0a2Ld1A1fMm4VVCah2c/KpDk6EDZRrCmdhqWdGnmSthM8
         i2wNXX/EniBJ2VmDV0Qb4vZg+3ozqD1H9tq2pHtrdApTMUHayYShC1M1INQ+aRdatK0d
         ptercNcwlLNYkc7dZILm4IKmOJ9meU6VSgau+9iTdVqqkih846h3sKFaGMCLIWUbdzoP
         uX0b538f7SvT/fO2CLitSxvTwnqqqC8n+8p1qarCQLXi6SqMzt6HmqPYTP+bUoynkfre
         3a9g==
X-Gm-Message-State: AOAM531NrHupxicLZ9Sma1QJXblc6sSjprhbVdxipdEc7bxFm1ytmS2p
        iP/EtsMoypje3q5cWz1aY08YdQnYGr0=
X-Google-Smtp-Source: ABdhPJz5bcVcYxYyJeObTKfkmXJZJ9mVxCe+TIqlra3+I4z8f+Bq/0wA4tstAGIVMCY4n7VqJR0OOw==
X-Received: by 2002:a37:7b02:: with SMTP id w2mr8360045qkc.291.1613246669625;
        Sat, 13 Feb 2021 12:04:29 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:8a63])
        by smtp.gmail.com with ESMTPSA id n67sm8844617qkb.35.2021.02.13.12.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 12:04:29 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 13 Feb 2021 15:03:31 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v5.11-rc7
Message-ID: <YCgwkyRWS5fM0Xtj@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

Two cgroup fixes: 1. Fix the NULL deref when trying to poll PSI in the root
cgroup and 2. fix confusing controller parsing corner case when mounting
cgroup v1 hierarchies. And doc / maintainer file updates.

Thanks.

The following changes since commit f4e087c666f54559cb4e530af1fbfc9967e14a15:

  Merge tag 'acpi-5.11-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2021-01-15 10:55:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.11-fixes

for you to fetch changes up to 74bdd45c85d02f695a1cd1c3dccf8b3960a86d8f:

  cgroup: update PSI file description in docs (2021-01-19 12:03:07 -0500)

----------------------------------------------------------------
Chen Zhou (1):
      cgroup-v1: add disabled controller check in cgroup1_parse_param()

Odin Ugedal (2):
      cgroup: fix psi monitor for root cgroup
      cgroup: update PSI file description in docs

Zefan Li (2):
      MAINTAINERS: Remove stale URLs for cpuset
      MAINTAINERS: Update my email address

 Documentation/admin-guide/cgroup-v2.rst | 6 +++---
 MAINTAINERS                             | 6 ++----
 kernel/cgroup/cgroup-v1.c               | 3 +++
 kernel/cgroup/cgroup.c                  | 4 +++-
 4 files changed, 11 insertions(+), 8 deletions(-)

-- 
tejun
