Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4338F527
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2019 21:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbfHOT41 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Aug 2019 15:56:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40011 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731379AbfHOT41 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Aug 2019 15:56:27 -0400
Received: by mail-qk1-f196.google.com with SMTP id s145so2817686qke.7;
        Thu, 15 Aug 2019 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8z1El4joEJPfZv/LOFE6htKfEd+io5Oqo8kE5bpDZI8=;
        b=IV591KQoCqfTve5OPjwQ47qHrWwJRQf3xrEvs5BOJAkNcxSizdrKC6TUcjcAaz9PoQ
         px/g/rn3BTUn77UIp7bkv6L/1d9qTjvMhw/OQX8nroblfWcmVo93BMhaqjBRFoBlA1RI
         10S1uDqFaHcg1R8CS7xKdqNFnQrkMfSNbLm4P9cBlbgE6j91TZWgHEUnVYF9rHSpnhuW
         tpDQZcemdcad6WXNjgVDo9e+re3W/IsVX5KPyDXUnuJvt8FOYQOOy8yprthlx9FQfKP2
         WjO9IZw+8e0pI6aAhBHhlJ2AmcWyozZKtW9efPWWbwtSQ+6Ecj79f0juQPYo17z08IuK
         FaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=8z1El4joEJPfZv/LOFE6htKfEd+io5Oqo8kE5bpDZI8=;
        b=dSmrRTlNcO8rSow0cIqMZnh3XKC8/ki2yrGpE6AfJsOuunEt+UbTJ+uH9NN6idYTY1
         oiWaOX95uBPKO2onrq/V3e6umFbol4tvD6i7zbI10cYWEOFRsKgyEe5KwiJGYXJl2LG5
         O+NtX68aTqbiRsWY5DtaUZzL96WUZ6eO8a0cV6a2wJtDq/pFHlZ0tYr0+voipgMSKxOH
         oE82OLPSil3rnpf65I9y0zZmNmaT4YuELTL+g42n4/lryhrvN1L8ZzxYXkfXmHgkBdiL
         qrIIcOgSfzeEfvNfAlTltPKcWuIRYuzQhUz9P2NI+zdxIh69vCA8NVDkDUeia4TnFJbv
         fjSg==
X-Gm-Message-State: APjAAAUvFy3YAZ6QNrKIMDHGmRxW4y3oLY4UHYKIIuJVkyT9XMJ+ePt8
        YLzqnaBb/3/CoXNoj3ztCyk=
X-Google-Smtp-Source: APXvYqyFEhAOKMzIeJih4yO72MRxGcpcdDYyJTV1V8osLQRoZK31+m6+Tv7/N0fkfX3fOJV0l5MUVQ==
X-Received: by 2002:a37:4791:: with SMTP id u139mr5430488qka.386.1565898981989;
        Thu, 15 Aug 2019 12:56:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:25cd])
        by smtp.gmail.com with ESMTPSA id c13sm1817004qtn.77.2019.08.15.12.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 12:56:21 -0700 (PDT)
Date:   Thu, 15 Aug 2019 12:56:19 -0700
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, guro@fb.com, akpm@linux-foundation.org
Subject: [PATCHSET v2] writeback, memcg: Implement foreign inode flushing
Message-ID: <20190815195619.GA2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
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

 fs/fs-writeback.c                |  114 +++++++++++++++++++++++----------
 include/linux/backing-dev-defs.h |   23 ++++++
 include/linux/backing-dev.h      |    5 +
 include/linux/memcontrol.h       |   39 +++++++++++
 include/linux/writeback.h        |    2 
 mm/backing-dev.c                 |  120 +++++++++++++++++++++++++++++------
 mm/memcontrol.c                  |  132 +++++++++++++++++++++++++++++++++++++++
 mm/page-writeback.c              |    4 +
 8 files changed, 386 insertions(+), 53 deletions(-)

--
tejun

[1] http://lkml.kernel.org/r/20190803140155.181190-1-tj@kernel.org
