Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EC4286D5F
	for <lists+cgroups@lfdr.de>; Thu,  8 Oct 2020 05:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgJHDwl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Oct 2020 23:52:41 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:59380 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbgJHDwl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Oct 2020 23:52:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UBGOQ8o_1602129157;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UBGOQ8o_1602129157)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Oct 2020 11:52:37 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Some improvements for blk throttle
Date:   Thu,  8 Oct 2020 11:52:21 +0800
Message-Id: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

This patch set did some improvements for blk throttle, please
help to review. Thanks.

Changes from v1:
 - Add another 4 new patches in this patch set.

Baolin Wang (8):
  blk-throttle: Remove a meaningless parameter for
    throtl_downgrade_state()
  blk-throttle: Avoid getting the current time if tg->last_finish_time
    is 0
  blk-throttle: Avoid tracking latency if low limit is invalid
  blk-throttle: Fix IO hang for a corner case
  blk-throttle: Move the list operation after list validation
  blk-throttle: Move service tree validation out of the
    throtl_rb_first()
  blk-throttle: Open code __throtl_de/enqueue_tg()
  blk-throttle: Re-use the throtl_set_slice_end()

 block/blk-throttle.c | 69 ++++++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

-- 
1.8.3.1

