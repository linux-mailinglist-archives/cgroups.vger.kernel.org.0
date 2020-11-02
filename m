Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1722A22F7
	for <lists+cgroups@lfdr.de>; Mon,  2 Nov 2020 03:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgKBCRq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 1 Nov 2020 21:17:46 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47371 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727659AbgKBCRq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 1 Nov 2020 21:17:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UDrT9AM_1604283462;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UDrT9AM_1604283462)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Nov 2020 10:17:43 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH 0/2] bail out early for memcg disable
Date:   Mon,  2 Nov 2020 10:17:14 +0800
Message-Id: <1604283436-18880-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

These 2 patches are indepenedent from per memcg lru lock, and may
encounter unexpected warning, so let's move out them from per memcg
lru locking patchset.

Alex Shi (2):
  mm/memcg: bail early from swap accounting if memcg disabled
  mm/memcg: warning on !memcg after readahead page charged

 include/linux/mmdebug.h | 13 +++++++++++++
 mm/memcontrol.c         | 17 ++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

-- 
1.8.3.1

