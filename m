Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E0480678
	for <lists+cgroups@lfdr.de>; Sat,  3 Aug 2019 16:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391003AbfHCOCD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 3 Aug 2019 10:02:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33357 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbfHCOCD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 3 Aug 2019 10:02:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id r6so72621246qtt.0;
        Sat, 03 Aug 2019 07:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=AiTM5WxUhwBn/0+fPLrU4NXRLZPLKnlQS1xIhWaJzpg=;
        b=tfT01MLuJKUwtU61ZxhKrZL6uuTYcpg4nXhf60oe0IrgWdG+XWg7SytG8ERsq3bvX8
         A+e4WnbVDrMQxtUgmUCHknAGfXaYg+2CxcWZ2ZbT6n7dMSHoxs5u/cz8JXmfAqH/cBPt
         aXnpRRuUe2fQtDlx3L2JHIJwPUaNpVX5L6s+NZ/q9HjqbhhbPhoSd680vE+8vvxS8y8K
         /IjAIxVBjB2wm3P06AH/7CgQgSjnsSyc9euHSKr9iuS17mANP+9NnfW22gTMHIt/RGwY
         PQ2chv1aMEKUWdBpJywMQP3q7/mQrd3UQdDY+QtZLHmq3nSvFRpZdaBN1SmpQ5Ar2/IC
         tE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=AiTM5WxUhwBn/0+fPLrU4NXRLZPLKnlQS1xIhWaJzpg=;
        b=n9qmL+8+6TjRWT6xnDyCX7u/fAEMMGULz23j33EFN/3/NrbOxMmfLaMY+wyVpZKDmT
         nEFlDMK7DgDy4M5N1lK6/suloTeuVAq8QqaauKxd0odRpWyZu9t5tByZwZMcYbSz4HcG
         Kph75OqiIlIcEG9FH/IVgmd9FQPg/hGASYWuUBD1rAG9SP7/KAMurZ/blBPLN0cu7GAC
         aJEhUMItrWMldqPNYEXWmodVp0gcUnk6IFJ18CRexkB83YMk1UntrG7g4lJnmqt8oc92
         gP3T0p1sWSnFdnTBDjvfsVb8yfn6Fvr1ouBIXAmQIDTwOXse1/Bg3Iu/l6mOhM6PqCE+
         gG6w==
X-Gm-Message-State: APjAAAUxmHIIgOVPVWoGm4gEnvfLzlxo3qARUN0nTdDOU3zHrqerZdXZ
        nmydQ0chT2PtWJIEUCWz8vs=
X-Google-Smtp-Source: APXvYqzzgCoVrYOzV3Sh22dKmWqWg/eQVur3HjvBhsdIJFMLo/Q8sCxblPPzca1gNgyMp+0/Sw1UCw==
X-Received: by 2002:a05:6214:1c3:: with SMTP id c3mr94720009qvt.144.1564840921783;
        Sat, 03 Aug 2019 07:02:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::efce])
        by smtp.gmail.com with ESMTPSA id i62sm35045931qke.52.2019.08.03.07.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:02:01 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, guro@fb.com, akpm@linux-foundation.org
Subject: [PATCHSET] writeback, memcg: Implement foreign inode flushing
Date:   Sat,  3 Aug 2019 07:01:51 -0700
Message-Id: <20190803140155.181190-1-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

There's an inherent mismatch between memcg and writeback.  The former
trackes ownership per-page while the latter per-inode.  This was a
deliberate design decision because honoring per-page ownership in the
writeback path is complicated, may lead to higher CPU and IO overheads
and deemed unnecessary given that write-sharing an inode across
different cgroups isn't a common use-case.

Combined with inode majority-writer ownership switching, this works
well enough in most cases but there are some pathological cases.  For
example, let's say there are two cgroups A and B which keep writing to
different but confined parts of the same inode.  B owns the inode and
A's memory is limited far below B's.  A's dirty ratio can rise enough
to trigger balance_dirty_pages() sleeps but B's can be low enough to
avoid triggering background writeback.  A will be slowed down without
a way to make writeback of the dirty pages happen.

This patchset implements foreign dirty recording and foreign mechanism
so that when a memcg encounters a condition as above it can trigger
flushes on bdi_writebacks which can clean its pages.  Please see the
last patch for more details.

This patchset contains the following four patches.

 0001-writeback-Generalize-and-expose-wb_completion.patch
 0002-bdi-Add-bdi-id.patch
 0003-writeback-memcg-Implement-cgroup_writeback_by_id.patch
 0004-writeback-memcg-Implement-foreign-dirty-flushing.patch

0001-0003 are prep patches which expose wb_completion and implement
bdi->id and flushing by bdi and memcg IDs.

0004 implement foreign inode flushing.

Thanks.  diffstat follows.

 fs/fs-writeback.c                |  111 ++++++++++++++++++++++++----------
 include/linux/backing-dev-defs.h |   23 +++++++
 include/linux/backing-dev.h      |    3 
 include/linux/memcontrol.h       |   35 ++++++++++
 include/linux/writeback.h        |    4 +
 mm/backing-dev.c                 |   65 +++++++++++++++++++-
 mm/memcontrol.c                  |  125 +++++++++++++++++++++++++++++++++++++++
 mm/page-writeback.c              |    4 +
 8 files changed, 335 insertions(+), 35 deletions(-)

--
tejun

