Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DABFF2130
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2019 22:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfKFV6o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Nov 2019 16:58:44 -0500
Received: from mail-qv1-f50.google.com ([209.85.219.50]:40828 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfKFV6o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Nov 2019 16:58:44 -0500
Received: by mail-qv1-f50.google.com with SMTP id r8so2107258qvq.7;
        Wed, 06 Nov 2019 13:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=F/vADG/hnX91+J7ThLwtAYWMOuLxbrgnZjiawQ6+D0Y=;
        b=q2VSHe3BIF6UMDNGvfoCyruwPT+QTt7bIiqj/Y/OpXbDSN0H/U6rXx/s4A9GuWg6nf
         px5rMM7KojYnyD9UkV5rleMeAiTaArnzKPjm55t/uKy9bToVgsHZukBqS1WD72CIFBFZ
         zit7QP2NUwWuasFdJ09cPZjAYFv58s3yI9g6800mPgTIYB9BMUv0zz3EIuXlxFjoc0wL
         kqierf07zxhTkBXeUfX/pV0sD84YyyNrlB5QceyrGZGEa/pCMeYEySW/g9XZ3skC5+Rc
         Bs+2hGyrGuzAVsC82EL3/TMXo27JW6qboUrG9R/FURdupwEbwBrM3F1Rk/5tOvZ6SBPo
         iO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=F/vADG/hnX91+J7ThLwtAYWMOuLxbrgnZjiawQ6+D0Y=;
        b=s0aAT/rW1rmjo8nBnROZh+vmsXdq7HI3d/DCa/uiO6AQwRij45dwUV04B+AvtIfFGg
         bTqfkv+fYEqYd+hBYkuoJlOwy9RUUaelBhNZTdyx/P49vrmcGcg9t0qTjoHbObs1sc41
         4WKBaR8U9W0GOM7oeQ9m6a9UVtJGQr8RXJFW96qGjDnIeE0AI0psTtpQU0HMfK/FtqFs
         xjsI22suzO4BckUWv1sQADaShWhXGnnChBDKbOj73MwQjtkuazOEepL6EzFQ5VuV3n4m
         3Iap2DOulWuqaMOjFdmdCA31I0owX+ex4lgE5qOTs7CXn6vlHyoFxsOZ80bK9gRCt8Zw
         wnaA==
X-Gm-Message-State: APjAAAXQrFT0r6gmf9JYFqRR7jD1ZtxgFiOsKTQOxHuILun4ZPlTPkGy
        pqFF+u0Lm+sviJHCe6RGf7M=
X-Google-Smtp-Source: APXvYqxrMPg4Z1ID2aAtKRJ/2VO6lSXUOrIfr4+JG1hAyxaDQXKT9M/OwslLW6ju5e1jnz+6lYZV7A==
X-Received: by 2002:ad4:42a8:: with SMTP id e8mr54771qvr.217.1573077523072;
        Wed, 06 Nov 2019 13:58:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::5bd1])
        by smtp.gmail.com with ESMTPSA id w69sm86741qkb.26.2019.11.06.13.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 13:58:42 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, kernel-team@fb.com
Subject: [PATCHSET block/for-next] blk-cgroup: use cgroup rstat for IO stats
Date:   Wed,  6 Nov 2019 13:58:33 -0800
Message-Id: <20191106215838.3973497-1-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

blk-cgroup IO stats currently use blkg_rwstat which unforutnately
requires walking all descendants recursively on read.  On systems with
a large number of cgroups (dead or alive), this can make each stat
read a substantially expensive operation.

This patch updates blk-cgroup to use cgroup rstat which makes stat
reading O(# descendants which have been active since last reading)
instead of O(# descendants).

 0001-bfq-iosched-stop-using-blkg-stat_bytes-and-stat_ios.patch
 0002-blk-throtl-stop-using-blkg-stat_bytes-and-stat_ios.patch
 0003-blk-cgroup-remove-now-unused-blkg_print_stat_-bytes-.patch
 0004-blk-cgroup-reimplement-basic-IO-stats-using-cgroup-r.patch
 0005-blk-cgroup-separate-out-blkg_rwstat-under-CONFIG_BLK.patch

0001-0002 make bfq-iosched and blk-throtl use their own blkg_rwstat to
track basic IO stats on cgroup1 instead of sharing blk-cgroup core's.
0003 is a follow-up cleanup.

0004 switches blk-cgroup to cgroup rstat.

0005 moves blkg_rwstat to its own files and gate it under a config
option as it's now only used by blk-throtl and bfq-iosched.

The patchset is on top of

  for-next/block 257855f86aa2 ("Merge branch 'for-5.4/block' into for-next")
+ [1] blkcg: make blkcg_print_stat() print stats only for online blkgs

and also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git review-blkcg-rstat

Thanks.

 block/Kconfig              |    4 
 block/Kconfig.iosched      |    1 
 block/Makefile             |    1 
 block/bfq-cgroup.c         |   37 +++--
 block/bfq-iosched.c        |    4 
 block/bfq-iosched.h        |    6 
 block/blk-cgroup-rwstat.c  |  129 +++++++++++++++++++
 block/blk-cgroup-rwstat.h  |  149 ++++++++++++++++++++++
 block/blk-cgroup.c         |  304 ++++++++++++++-------------------------------
 block/blk-throttle.c       |   71 +++++++++-
 include/linux/blk-cgroup.h |  198 +++++------------------------
 11 files changed, 517 insertions(+), 387 deletions(-)

--
tejun

[1] http://lkml.kernel.org/r/20191105160951.GS3622521@devbig004.ftw2.facebook.com

