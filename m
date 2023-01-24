Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2A4679157
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 07:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjAXG5X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 01:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjAXG5W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 01:57:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB13C3D937;
        Mon, 23 Jan 2023 22:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VmYGANj5EWw8Lo4TLS15TVfS0hjnPfIXbECc6g3JZec=; b=cFatyu2CSvkHizkSFbuyleHtBb
        LKYY2w1tKlWZ+BbxR6ZL26qnFDlAAH8L5jxJuAZhSbVqrGHQhFzRfII0g0uCo67pZBYa5azgqsD07
        NTmLTs0ctgryv5x47YoyMMnbNSNQGhReS/ofPuPK15kBY84vcmuRjJtRVCDQABhTL6wJuf+tWLZrL
        4upq31PcJ1eLUXeyurgvIMS5bCj+3iS4iCFEedpi6As62PNJmu2+4RgCuS+ToKByb0QgKjCxjEUz0
        FRX5eU4qOsjmMyt21MrFfF18RVfejlLOLwy2NpHzMpyhc/52L1f+QaQbinrHP9Rud6i2uTbBsmPOk
        GxIcU5KA==;
Received: from [2001:4bb8:19a:27af:ea4c:1aa8:8f64:2866] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKDF8-002aQJ-7V; Tue, 24 Jan 2023 06:57:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: switch blk-cgroup to work on gendisk v2
Date:   Tue, 24 Jan 2023 07:57:00 +0100
Message-Id: <20230124065716.152286-1-hch@lst.de>
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

Changes since v1:
 - use the local disk variable in wbt_init instead of q->disk
 - various spelling fixes

Diffstat:
 block/bfq-cgroup.c        |   18 ++--
 block/bfq-iosched.c       |    6 -
 block/blk-cgroup-rwstat.c |    2 
 block/blk-cgroup.c        |  185 +++++++++++++++++++++-------------------------
 block/blk-cgroup.h        |   41 ++++------
 block/blk-iocost.c        |   40 ++++-----
 block/blk-iolatency.c     |   41 ++++------
 block/blk-ioprio.c        |    6 -
 block/blk-mq-debugfs.c    |   10 --
 block/blk-rq-qos.c        |   67 ++++++++++++++++
 block/blk-rq-qos.h        |   66 +---------------
 block/blk-stat.c          |    3 
 block/blk-sysfs.c         |    4 
 block/blk-throttle.c      |   31 ++++---
 block/blk-wbt.c           |   39 ++++-----
 block/blk-wbt.h           |   12 +-
 block/genhd.c             |   17 ++--
 include/linux/blkdev.h    |   10 +-
 include/linux/sched.h     |    2 
 kernel/fork.c             |    2 
 mm/swapfile.c             |    2 
 21 files changed, 292 insertions(+), 312 deletions(-)
