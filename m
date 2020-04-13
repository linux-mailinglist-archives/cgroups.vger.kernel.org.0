Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6C41A69E6
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2020 18:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbgDMQ2F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 12:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731412AbgDMQ2E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 12:28:04 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8034C0A3BDC;
        Mon, 13 Apr 2020 09:28:04 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id p19so4668693qve.0;
        Mon, 13 Apr 2020 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kgnSzHTYieIvS0nv69ZyDoepjTsOMDuCzo7OjVc7aYQ=;
        b=smPWj6uFcGxjikAWXyCjZk81xcoBdlfI1r09+XQvuTJU0NLeoa4fGgalgQF+RXTNVy
         y1njgc2Q/+NJQ0bP9d+A4RWbHFmyg87LdSZFCrMsQklZXF0qGm0o+DrodsL92rbOzmQt
         G++EEpyVSa7lrtjupMHe3jNU0DHa4m/9VLsmROB5eD7iH9264C7ozZdcegrzUOLyZdtf
         gxkJ2V7ipVx6uZHtM4rZhdRT0FWPvqy6KrzG2GaXP1Vshw+r7ngWejmoHgX4AmOkdfKW
         m0/9Rgj4TtgIZPy6zYwPOfcR2/iBwH+FsKwNnZSIhRaMQ1mw6mpDcjIGk14FL7TXXbHs
         zUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=kgnSzHTYieIvS0nv69ZyDoepjTsOMDuCzo7OjVc7aYQ=;
        b=nLbcj1HrAhZiktjRKQ031190SZRSrJrWNkv20w/1ZVpvWrQQ6FZLm38f4Q7fJX8ZaO
         2CeXVzYV4HdUfeuW289qKVp7irccVoKpwGVE0ByKAj5fNHstuE9qsO7vFaEjr2XtXGVr
         metNoPHNn+8QmfKzhLhnWpKyW5Qv9rRy8SA7daNklMq6c7V58v5RMBCm+zXYXTaator9
         bf3FTQt9GmV4R0EyQC8I2b4MkCCXc97W4qhpDaGd/uXz4enwNaJkKzDdgTJ4YBl/PzbT
         z4NwY1dQFfrPPuQvexjwed1dCCPvmgzQST7RiD2Hav8WeQypNxIxQzwEto4MJtia/Mwd
         ywHw==
X-Gm-Message-State: AGi0PuZ8is7N7n1fqRhon1cA2nL6hXWmHrd5zh+KIqqU434zH0aSpzRf
        YqLu0d+YOczEz00Taxl1WAN8v+p8OM4=
X-Google-Smtp-Source: APiQypK0bsdgehmkOlSLmilSS/dJhSxcisE/CExycgHt6ch98CJaB28q8OCjtYvK6J5fG7hZVvQSYw==
X-Received: by 2002:ad4:56a5:: with SMTP id bd5mr17410173qvb.37.1586795283771;
        Mon, 13 Apr 2020 09:28:03 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id g67sm8725917qkf.96.2020.04.13.09.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 09:28:02 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, newella@fb.com,
        josef@toxicpanda.com, asml.silence@gmail.com, ming.lei@redhat.com,
        bvanassche@acm.org
Subject: [PATCHSET v2 block/for-5.8] iocost: improve use_delay and latency target handling
Date:   Mon, 13 Apr 2020 12:27:54 -0400
Message-Id: <20200413162758.97252-1-tj@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Changes from v1[1]

* Dropped 0002-block-add-request-io_data_len.patch and updated to use
  rq->stats_sectors instead as suggested by Pavel Begunkov.

This patchset improves the following two iocost control behaviors.

* iocost was failing to punish heavy shared IO generators (file metadata, memory
  reclaim) through use_delay mechanism - use_delay automatically decays which
  works well for iolatency but doesn't match how iocost behaves. This led to
  e.g. memory bombs which generate a lot of swap IOs to use over their allotted
  amount. This is fixed by adding non-decaying use_delay mechanism.

* The same latency targets were being applied regardless of the IO sizes. While
  this works fine for loose targets, it gets in the way when trying to tigthen
  them - a latency target adequate for a 4k IO is too short for a 1 meg IO.
  iocost now discounts the size portion of cost when testing whether a given IO
  met or missed its latency target.

While at it, it also makes minor changse to iocost_monitor.py.

This patchset contains the following five patches.

 0001-blk-iocost-switch-to-fixed-non-auto-decaying-use_del.patch
 0002-blk-iocost-account-for-IO-size-when-testing-latencie.patch
 0003-iocost_monitor-exit-successfully-if-interval-is-zero.patch
 0004-iocost_monitor-drop-string-wrap-around-numbers-when-.patch

and is also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git iocost-delay-latency-v2

diffstat follows. Thanks.

 block/Kconfig                  |    1 
 block/blk-cgroup.c             |    6 ++++
 block/blk-iocost.c             |   56 +++++++++++++++++++++++++++++------------
 include/linux/blk-cgroup.h     |   43 ++++++++++++++++++++++++-------
 tools/cgroup/iocost_monitor.py |   48 +++++++++++++++++++----------------
 5 files changed, 106 insertions(+), 48 deletions(-)

--
tejun

[1] http://lkml.kernel.org/r/20200408201450.3959560-1-tj@kernel.org

