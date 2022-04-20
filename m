Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9806C508000
	for <lists+cgroups@lfdr.de>; Wed, 20 Apr 2022 06:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiDTEaW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Apr 2022 00:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbiDTEaT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Apr 2022 00:30:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80C52DE0;
        Tue, 19 Apr 2022 21:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Be3+26XptxIgmQQhBiL/mWzc+JWO9oS3P5KTSt/Lrqk=; b=hMv3QDFCmWfi2+JDhtKD7KhE/3
        wULxYat5Sc9vH8PgIDI6QRjrF5fBoxMYfPtpMILb9xkSlX/X7RmhSoRdRv/rb5ht3QrKXo9deJo63
        yYa8sQo0B9qXe/aTORpycq/9vh2IW3bYNGEWgEtDCu4OBzKonnQUwFebUnP/GGsjOOP/f1C0b+W5a
        w7bPbOrwGfiC3CrEiyQsNFtiS/EZEbth6mnT1NZPRrx4q2s765BKAxwDpkyflpDPYYQg7RexFpSev
        QjUPQyCbWsVjgR1jQGybXjLsFzJnkR2vXAB/v0wbEpBCBOBDERK9AZPa2RSnC2Sia+a6Araprwjzo
        z+2sCbsw==;
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh1w8-007FBI-1C; Wed, 20 Apr 2022 04:27:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: make the blkcg and blkcg structures private
Date:   Wed, 20 Apr 2022 06:27:08 +0200
Message-Id: <20220420042723.1010598-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

this series cleans up various lose end in the blk-cgroup code to make it
easier to follow in preparation of reworking the blkcg assignment for
bios.  The biggest change is that most of <linux/blk-cgroup.h> is now
taken private into block/.

Diffstat:
 block/Makefile                |    1 
 block/bfq-iosched.h           |    4 
 block/blk-cgroup-fc-appid.c   |   57 +++++++++
 block/blk-cgroup.c            |  154 ++++++++++++++++++++-----
 block/blk-cgroup.h            |  138 +++++++++++++++-------
 block/blk-throttle.c          |    2 
 drivers/block/loop.c          |   12 +
 drivers/nvme/host/fc.c        |   26 +---
 drivers/scsi/lpfc/lpfc_scsi.c |    4 
 include/linux/backing-dev.h   |    6 
 include/linux/blk-cgroup.h    |  258 ++----------------------------------------
 include/linux/blktrace_api.h  |   10 -
 include/linux/kthread.h       |    4 
 kernel/kthread.c              |    1 
 kernel/trace/blktrace.c       |   26 ++--
 mm/backing-dev.c              |   19 +--
 mm/readahead.c                |    1 
 mm/swapfile.c                 |    1 
 18 files changed, 343 insertions(+), 381 deletions(-)
