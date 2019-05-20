Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC01C22A25
	for <lists+cgroups@lfdr.de>; Mon, 20 May 2019 05:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfETDB5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 May 2019 23:01:57 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:55275 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbfETDB5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 19 May 2019 23:01:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0TSB-E6N_1558321315;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TSB-E6N_1558321315)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 May 2019 11:01:56 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org
Subject: [PATCH v2 0/3] fix 3 testing failure on kselftest/cgroup
Date:   Mon, 20 May 2019 11:01:37 +0800
Message-Id: <20190520030140.203605-1-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi All,

This patchset fixed 3 uncepected testing failure on kselftest/cgroup
This v2 version added Roman Gushchin's reviewed-by and fixed a typo.
Thanks Roman!

Alex


[PATCH v2 1/3] kselftest/cgroup: fix unexpected testing failure on
[PATCH v2 2/3] kselftest/cgroup: fix unexpected testing failure on
[PATCH v2 3/3] kselftest/cgroup: fix incorrect test_core skip

