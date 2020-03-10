Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D10180068
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2020 15:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgCJOlJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Mar 2020 10:41:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38324 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgCJOlJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Mar 2020 10:41:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id h14so6951817qke.5;
        Tue, 10 Mar 2020 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=zPdEJtfsWlHG8dbwVXY1UpzdzNB128A7aRa0k6lQHIw=;
        b=sA6mq68sWeiOnv4cAOeCHl2yqaec100bLnaugDj+ojD5TqX1jGIVOlurFThAETQ2w6
         Art7sk0xX3cW9CyolyGK/VJ6temfhI9jJ3i/BskQ1Tq6M9rSRRiSCrCD8uqMWFPH4C84
         FbAuFKHRgJP12WOg99EuW8gKe7HZ9lCdC92x52GlyoB6lGL6lViNPOtWyPBYqfTZ8WxQ
         aY18b7C1UB/5CjhjNRY+TnFENEgIFYxlkISxDwTZcBuvghmqZDZDwyOKpHCY34M57qqR
         tVJESZ/bP2mNEoc2b/o+LU9EQi+kRrFPaWHHnWH0bNd4fssZSm3hCW/iUklOO/HHMPCf
         Os2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=zPdEJtfsWlHG8dbwVXY1UpzdzNB128A7aRa0k6lQHIw=;
        b=oThykHukXyktKLLZ8vPU2dykbz7zkZ1nHSC2460re8HTa7KSMmk7mMGYViL6AuMHCf
         Mn/zBCR3Bd7dMv4ERfCMfkCXWSGhcDGB+1uKwdOmd1z9O+7Sy95UlAKBDEcf2cNnGfCW
         avI3Dvkhlo5YI6C7dpgKna56h4udx6SQUnaRHx5qJ90qxEauenMdfupqhLVDtlyjOTBg
         tc6C9jIr63AqgkiAKrGP+t3g6R0K2EUxotydYV9bBSanUVEo1rLxzM/ao0Ccpq1z81Ju
         SiBjJGiKZ4zNpWkozFZYERKBT9C++ywRh/NFnh7Zh7/Xxax67BNPA1ArnhHny2ag1dC2
         V+lA==
X-Gm-Message-State: ANhLgQ0wEEvucT02uOaD9jvDvcRNj27vBdA2PbU1qV/cptO18UwvVGkU
        Q0vmOdJ8AdMTIaXkA7U6kLXjaMGEAKQ=
X-Google-Smtp-Source: ADFU+vtP8xv4TqEgo8dpqD+8qLRu/oZnw5vOntGPk7VKJxXKChqJJ3HJlBRJm06NPROi9olocOm6kw==
X-Received: by 2002:a37:7881:: with SMTP id t123mr19682115qkc.155.1583851268433;
        Tue, 10 Mar 2020 07:41:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e8d1])
        by smtp.gmail.com with ESMTPSA id t3sm22373459qkt.114.2020.03.10.07.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 07:41:07 -0700 (PDT)
Date:   Tue, 10 Mar 2020 10:41:07 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup fixes for v5.6-rc5
Message-ID: <20200310144107.GC79873@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

* cgroup.procs listing related fixes. It didn't interlock properly
  with exiting tasks leaving a short window where a cgroup has empty
  cgroup.procs but still can't be removed and misbehaved on short
  reads.

* psi_show() crash fix on 32bit ino archs.

* Empty release_agent handling fix.

Thanks.

The following changes since commit 0bf999f9c5e74c7ecf9dafb527146601e5c848b9:

  linux/pipe_fs_i.h: fix kernel-doc warnings after @wait was split (2020-02-12 11:54:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.6-fixes

for you to fetch changes up to 2e5383d7904e60529136727e49629a82058a5607:

  cgroup1: don't call release_agent when it is "" (2020-03-04 11:53:33 -0500)

----------------------------------------------------------------
Michal Koutný (1):
      cgroup: Iterate tasks that did not finish do_exit()

Qian Cai (1):
      cgroup: fix psi_show() crash on 32bit ino archs

Tycho Andersen (1):
      cgroup1: don't call release_agent when it is ""

Vasily Averin (2):
      cgroup-v1: cgroup_pidlist_next should update position index
      cgroup: cgroup_procs_next should increase position index

 include/linux/cgroup.h    |  1 +
 kernel/cgroup/cgroup-v1.c |  3 ++-
 kernel/cgroup/cgroup.c    | 39 ++++++++++++++++++++++++++-------------
 3 files changed, 29 insertions(+), 14 deletions(-)

-- 
tejun
