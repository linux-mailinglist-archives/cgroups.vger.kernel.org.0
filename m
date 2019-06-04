Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E0433CEF
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2019 03:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfFDB6N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Jun 2019 21:58:13 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:56651 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbfFDB6N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Jun 2019 21:58:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TTN906a_1559613491;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TTN906a_1559613491)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Jun 2019 09:58:11 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
        Tejun Heo <tj@kernel.org>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Caspar Zhang <caspar@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [RFC PATCH 0/3] psi: support cgroup v1
Date:   Tue,  4 Jun 2019 09:57:42 +0800
Message-Id: <20190604015745.78972-1-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently psi supports system-wide as well as cgroup2. Since most use
cases are still on cgroup v1, this patchset is trying to do such
support.

Joseph Qi (3):
  psi: make cgroup psi helpers public
  psi: cgroup v1 support
  psi: add cgroup v1 interfaces

 block/blk-throttle.c   | 10 +++++++
 include/linux/cgroup.h | 21 ++++++++++++++
 kernel/cgroup/cgroup.c | 33 +++++++++++----------
 kernel/sched/cpuacct.c | 10 +++++++
 kernel/sched/psi.c     | 65 ++++++++++++++++++++++++++++++++++++------
 mm/memcontrol.c        | 10 +++++++
 6 files changed, 125 insertions(+), 24 deletions(-)

-- 
2.19.1.856.g8858448bb

