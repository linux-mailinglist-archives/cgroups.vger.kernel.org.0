Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0837E66D7AC
	for <lists+cgroups@lfdr.de>; Tue, 17 Jan 2023 09:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbjAQINJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Jan 2023 03:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbjAQIND (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Jan 2023 03:13:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A9422011;
        Tue, 17 Jan 2023 00:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tBaVz7h6Ls5siSdNgvaB/QpLtiTcpj4YxidHypc3EsY=; b=TPAf0kJR2DrWHNeTZaF0cwyCha
        oXCkMJtO/yr5NEOzj5pVvHgaw3LPe8wIkVvXv4uZEG8Wyw1r2G4C3lHoqXC3gC6RHblhADFQq6qGy
        xlDTcUHbKrZnLaZUK/SgToLvXY2Kt7dw9EuUAkLJ7j8O1dcUs/sJNWE5d8/l7tpn1cbI2Tx124G/F
        ijXaaOaeRDQAIosHFZDvlzPWQWdmWsSzuTPwwRKKBfRxwLI4IBmhUhNNKdeVZtPDN8WpODx4zhPU8
        Qy6O20qOK19+q2Op0q38iZ0M4oDM3SddzvtQk/em5usPHPaBph6Pjep3WHSQ2N29gQ1u+hjUygNnZ
        +q8w6LmA==;
Received: from [2001:4bb8:19a:2039:eaa2:3b9e:be2e:bd2a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHh5Y-00DHgU-3V; Tue, 17 Jan 2023 08:13:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: switch blk-cgroup to work on gendisk
Date:   Tue, 17 Jan 2023 09:12:42 +0100
Message-Id: <20230117081257.3089859-1-hch@lst.de>
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
