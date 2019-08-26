Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E11869D3B7
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2019 18:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbfHZQHF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Aug 2019 12:07:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39096 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbfHZQHF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Aug 2019 12:07:05 -0400
Received: by mail-qk1-f194.google.com with SMTP id 125so14451903qkl.6;
        Mon, 26 Aug 2019 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=80iUPmrcBk2+ug2egAEGLlkODFGV0leLCrkusgfj0dU=;
        b=LSTEt2dsSUlYWtlWtHYVxk6WiPYZB0AVIJmO+3gPCRgTrqkCUrWZefc5qQ5apUgEkp
         vADQarLeBvm+BaIOAf8KITRCj1TAbo8LcAdF+bxTRJQQsho4D/mT/sksa81oE8flmju5
         xH4lTv1fevqqW765jk941rjheBDMCuOsgBhRZ7zY1pBAV3YfRl2dEIH78cF7dgA71U4q
         2iu6W5IQT7d2UO+E6DlYXJj0J1KYxYW1eppgkG9Yme6A1t7lcmddNA0kfe/KSxrYwoEk
         OyRzDy2r1SrUyqYhr9pNvTkbsS4xl40SmuLHdraqT6RbdiUvQDtEC5a+31Vw1JuuTesp
         C8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=80iUPmrcBk2+ug2egAEGLlkODFGV0leLCrkusgfj0dU=;
        b=M1ZGfXqsLie+zBqBgBCRWzBdcEWCBJKuFyzk2KUuQyw1PyrE9uQhvz9nu2BFTDSTFK
         WAaxR9D9jekjTJfM7dA3aIKXdQXaNJ86ktiYCmQKZDEaTKKZ+oTaKsqkTlrwZXt7ACjt
         e8fxnBfwgc/OkSf0nSJPTQmX6prjbQ8SCQ0DGA4EktIw+p5x0LPGwMW6Ncjdt7lG/G9O
         OCViQpe7TJgiGpRUwsKkAca3OUSYTqfA6vn5Y/Swzf/HnoCiWiMzyuBVn9g/65KpImON
         MUQXUdm+fuytY9qFiqXTsIoufbu+/EwKo1XY0+hHmIazGtdfEF11H6NyR+mIqIFJt9nU
         3D3Q==
X-Gm-Message-State: APjAAAW177DXTo2Ef9s+Clm9/UZ4PPDf/yOLl9bKDFqbrLz6KzwrL0Op
        CQE9cGzpf5VNA4Kyf/hU3og=
X-Google-Smtp-Source: APXvYqyJYSpyqwcn0d/MgjayTJ75Ym21bRNWYcLg1zdLL8TKqRLxUjPZ3mnh4+Ch6vIyIqg+t+OpXg==
X-Received: by 2002:a37:512:: with SMTP id 18mr15913097qkf.220.1566835623903;
        Mon, 26 Aug 2019 09:07:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::d081])
        by smtp.gmail.com with ESMTPSA id h1sm9711613qtc.92.2019.08.26.09.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 09:07:03 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, guro@fb.com, akpm@linux-foundation.org
Subject: [PATCHSET v3] writeback, memcg: Implement foreign inode flushing
Date:   Mon, 26 Aug 2019 09:06:51 -0700
Message-Id: <20190826160656.870307-1-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

Changes from v1[1]:

* More comments explaining the parameters.

* 0003-writeback-Separate-out-wb_get_lookup-from-wb_get_create.patch
  added and avoid spuriously creating missing wbs for foreign
  flushing.

Changes from v2[2]:

* Added livelock avoidance and applied other smaller changes suggested
  by Jan.

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
 0003-writeback-Separate-out-wb_get_lookup-from-wb_get_create.patch
 0004-writeback-memcg-Implement-cgroup_writeback_by_id.patch
 0005-writeback-memcg-Implement-foreign-dirty-flushing.patch

0001-0004 are prep patches which expose wb_completion and implement
bdi->id and flushing by bdi and memcg IDs.

0005 implements foreign inode flushing.

Thanks.  diffstat follows.

 fs/fs-writeback.c                |  130 ++++++++++++++++++++++++++++---------
 include/linux/backing-dev-defs.h |   23 ++++++
 include/linux/backing-dev.h      |    5 +
 include/linux/memcontrol.h       |   39 +++++++++++
 include/linux/writeback.h        |    2 
 mm/backing-dev.c                 |  120 +++++++++++++++++++++++++++++-----
 mm/memcontrol.c                  |  134 +++++++++++++++++++++++++++++++++++++++
 mm/page-writeback.c              |    4 +
 8 files changed, 404 insertions(+), 53 deletions(-)

--
tejun

[1] http://lkml.kernel.org/r/20190803140155.181190-1-tj@kernel.org
[2] http://lkml.kenrel.org/r/20190815195619.GA2263813@devbig004.ftw2.facebook.com

