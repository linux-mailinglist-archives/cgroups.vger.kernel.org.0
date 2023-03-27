Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7347B6C9917
	for <lists+cgroups@lfdr.de>; Mon, 27 Mar 2023 02:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjC0Atx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Mar 2023 20:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC0Atw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Mar 2023 20:49:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB83132;
        Sun, 26 Mar 2023 17:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=J34aMK6n+O5EOaIOD1zXvzTxUfNPfAeP9gPFHmYCaGA=; b=4M3uK7D06M5LGjDiFkWczeT12G
        Pr/zv02t1WWrUSI1ZtKKyr4dSQBLuK86287W6gGZfpKr49g/XufKv582wRFvV84PxJS/CZ2IbAL32
        5mCxz4UXT6WQArvCuCArUftBki8/SVAx/KAi3kaGC+GAh0lEOvyTEVaSraNm2S5zaV29s/9QlpU2J
        FzCW7xq/xIRFxXbxUvdR0YHhdVsF8MtMFdAEdQSEWYvt7tCvs5qrc5ZAueo2MJAM6D/9PWl8SsrdY
        mL9PnLJs3vWh7Hl/gIwdSoBVonA7tYt1FU1XPWkCVgBFjvkZ4vussqUzn/iKmd/lFGI26P8pzmsl7
        i13m7J7Q==;
Received: from i114-182-241-148.s41.a014.ap.plala.or.jp ([114.182.241.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pgb3S-009Qrq-0K;
        Mon, 27 Mar 2023 00:49:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: move bio cgroup punting into btrfs
Date:   Mon, 27 Mar 2023 09:49:46 +0900
Message-Id: <20230327004954.728797-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

the current code to offload bio submission into a cgroup-specific helper
thread when sent from the btrfs internal helper threads is a bit ugly.

This series moves it into btrfs with minimal interference in the core
code.

I also wonder if the better way to handle this in the long would be to
to allow multiple writeback threads per device and cgroup, which should
remove the need for both the btrfs submission helper workqueue and the
per-cgroup threads.

Diffstat:
 block/Kconfig             |    3 +
 block/blk-cgroup.c        |   78 +++++++++++++++++++++++++---------------------
 block/blk-cgroup.h        |   15 +-------
 block/blk-core.c          |    3 -
 fs/btrfs/Kconfig          |    1 
 fs/btrfs/bio.c            |   12 ++++---
 fs/btrfs/bio.h            |    3 +
 fs/btrfs/compression.c    |    8 ----
 fs/btrfs/compression.h    |    1 
 fs/btrfs/extent_io.c      |    6 +--
 fs/btrfs/inode.c          |   37 +++++++++++----------
 include/linux/bio.h       |    5 ++
 include/linux/blk_types.h |   18 ++--------
 include/linux/writeback.h |    5 --
 14 files changed, 94 insertions(+), 101 deletions(-)
