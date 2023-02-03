Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3C6689C86
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 16:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjBCPEI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 10:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjBCPEH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 10:04:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB2517CD8;
        Fri,  3 Feb 2023 07:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=mminnm7Nr11b4VHn58XXKI5xl/BZGhF2dEh0O7fu8M8=; b=PGfJKCNhB+nwOyGYxmlamKykAz
        J19TyRZWzX70L9sJLrDXeNOLjS/9ZtE67Dy6IpuY8HPZGV1kk+GgYaxAwfnqyrw9SKM4VIIrKe4Wz
        Z0q9T99VaJrl6C3yromHYYh6IrCgdM8NZygVODQ0UyhITtV1jWjId1VZZPjIfPBV9cvL8uTlBC80K
        AhWCXfpcZAZ9F0qdzAdcInkjhZslyFdTJWg2fsBxLKBrLJV/AtdlgXVSCh8mOiLYq2GUgsP3GG/9S
        dYyGi/vLSvoafHrXSU0Udqbd8kuuAHpymElu/4/8ySls0IwQx8asen7B1MYPqjtiP/oDaJVb0WQym
        OHcsrCPA==;
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNxbe-002Zy1-AF; Fri, 03 Feb 2023 15:04:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: switch blk-cgroup to work on gendisk v4
Date:   Fri,  3 Feb 2023 16:03:41 +0100
Message-Id: <20230203150400.3199230-1-hch@lst.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

blk-cgroup works on only on live disks and "file system" I/O from bios.
This all the information should be in the gendisk, and not the
request_queue that also exists for pure passthrough request based
devices.

Changes since v3:
 - improve a commit log
 - drop a change to not acquire a pointless disk reference

Changes since v2:
 - drop the patch to revert the async blkg freeing
 - simplify error unwinding when failing to allocate a blkg
 - add back the dead queue/disk check in blkg_alloc
 - split two patches to better document the changes
 - add another blk-wbt cleanup patch
 - rewrite a commit log
 - another typo fix

Changes since v1:
 - use the local disk variable in wbt_init instead of q->disk
 - various spelling fixes

Diffstat:
 block/bfq-cgroup.c        |   18 +--
 block/bfq-iosched.c       |    6 -
 block/blk-cgroup-rwstat.c |    2 
 block/blk-cgroup.c        |  226 +++++++++++++++++++++-------------------------
 block/blk-cgroup.h        |   38 +++----
 block/blk-iocost.c        |   40 +++-----
 block/blk-iolatency.c     |   41 +++-----
 block/blk-ioprio.c        |    6 -
 block/blk-mq-debugfs.c    |   10 --
 block/blk-rq-qos.c        |   67 +++++++++++++
 block/blk-rq-qos.h        |   66 +------------
 block/blk-settings.c      |    1 
 block/blk-stat.c          |    3 
 block/blk-sysfs.c         |    5 -
 block/blk-throttle.c      |   31 +++---
 block/blk-wbt.c           |  116 +++++++++++++++++++----
 block/blk-wbt.h           |   98 +------------------
 block/genhd.c             |   17 +--
 include/linux/blkdev.h    |   12 +-
 include/linux/sched.h     |    2 
 kernel/fork.c             |    2 
 mm/swapfile.c             |    2 
 22 files changed, 391 insertions(+), 418 deletions(-)
