Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8A41A2A20
	for <lists+cgroups@lfdr.de>; Wed,  8 Apr 2020 22:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgDHUO5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Apr 2020 16:14:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44280 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgDHUO5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Apr 2020 16:14:57 -0400
Received: by mail-qk1-f193.google.com with SMTP id j4so1632243qkc.11;
        Wed, 08 Apr 2020 13:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbOTLSdpKRSWoJg86rhLkNXWwpT6Ra+lmlyLxQcG74M=;
        b=EAQj6ooRELE1aSGdzl7xJCc1N1bQ2cVXEuUaSuPh+B65JXFnbaMPbHPnsYsojbTQTv
         J82pjh9KiPam7s6QYx7bnkyDaxRbQFxhX1VnRY/G1HkxOfJrvF2n+2L85QAxDdSaSoUr
         n6H9+zQQamAM0P5VBdHIMJ8vxacPTyhuUmZHyRXrm6NSAw00nu1Qn57W0euRSLugCmZi
         pWBk/lQmL0FXqZVjLH5BO+6+dLC5aQfBwRNkC0WBOV5HvTIF6/E50Hz2YII0b89d978J
         zf8uziZ991jIjlqmJERnMicGbdRW1Y1ZI6n2EK3YeC+aUPZAZ0O3HrbJm9/W+oR7Kr1N
         /l0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=sbOTLSdpKRSWoJg86rhLkNXWwpT6Ra+lmlyLxQcG74M=;
        b=Getm7iOBLiCrbZm0jNW/ZIV0Q0MGbb2sgJqSEMb5O42vcmIMFoUq6lFvHJq6RHJ9m6
         EmaluLxNwrCKp12u1B4uhYg4u5E2uXI2ZTsV2GXXce/NYJoFyN4z3UyDFQY1VHbA+y4I
         lKgLFvcL4fpstgxmpQKEJ96ZPXatLB0W7H7OMbwl9qJxYYV3CTC9nW8PwmMlQwNp1Ca+
         Y1RtWCyFkpXGxXg0aA7esj3bAVwAYQEAm2yGOS7IhewNjN/NHtoOK8AECd/qfWcNedxi
         5fPn5jpZJIZFh0PH0jTCdmnz2v9ABF3t+vwCMyzVBCYTPfgSgSJN876Ll9MMpA4rjiXa
         v3cA==
X-Gm-Message-State: AGi0PuZvKqXYmtfhxekBKhnKst4L3Ae1ur7YBz9ts/iaW3dIw5peQ0sk
        XRofoFawFi8uWWhlcEYpAT+PDg40KXM=
X-Google-Smtp-Source: APiQypIqYaz+eZ0Lnqw/OZK4i8K0k+TZAR8pMonm/QC8s87JkRsvyM0ekWeZTspZPo0IdhZPmV6zAQ==
X-Received: by 2002:a37:74d:: with SMTP id 74mr9442111qkh.376.1586376895466;
        Wed, 08 Apr 2020 13:14:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::36b2])
        by smtp.gmail.com with ESMTPSA id r128sm2506570qke.95.2020.04.08.13.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:14:54 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@vger.kernel.org, cgroups@vger.kernel.org,
        newella@fb.com, josef@toxicpanda.com
Subject: [PATCHSET block/for-5.8] iocost: improve use_delay and latency target handling
Date:   Wed,  8 Apr 2020 16:14:45 -0400
Message-Id: <20200408201450.3959560-1-tj@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Jens.

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
 0002-block-add-request-io_data_len.patch
 0003-blk-iocost-account-for-IO-size-when-testing-latencie.patch
 0004-iocost_monitor-exit-successfully-if-interval-is-zero.patch
 0005-iocost_monitor-drop-string-wrap-around-numbers-when-.patch

and is also available in the following git branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git iocost-delay-latency

diffstat follows. Thanks.

 block/Kconfig                  |    4 +++
 block/blk-cgroup.c             |    6 ++++
 block/blk-iocost.c             |   54 ++++++++++++++++++++++++++++-------------
 block/blk-mq.c                 |    6 ++++
 include/linux/blk-cgroup.h     |   43 +++++++++++++++++++++++++-------
 include/linux/blkdev.h         |    8 ++++++
 tools/cgroup/iocost_monitor.py |   48 +++++++++++++++++++-----------------
 7 files changed, 121 insertions(+), 48 deletions(-)

--
tejun

