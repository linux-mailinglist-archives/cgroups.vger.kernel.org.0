Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55867694305
	for <lists+cgroups@lfdr.de>; Mon, 13 Feb 2023 11:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBMKlt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Feb 2023 05:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBMKls (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Feb 2023 05:41:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1268F126C3;
        Mon, 13 Feb 2023 02:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=QFZ+a29GeVUTeCrKA7f2ruTlAoD7iMuLbB/uIVPnxW0=; b=rMSPJdjGCN8rptqoedEr8hCkvc
        VjM2QSg+CneSLRfeKsGg6vl/T4GO5mQ/PUlb5AjqRH61rdqLpjL4l94ToR+lK5OytBh2g20AMNnl7
        RRP5mfvMPEhufK2vYM2L2GM9TAoj9eTTEca6p8a8YzHmB1gQYubUbhTyCpwgiB362SFH99d8cFf3n
        tGZ/+y+qgbAOzDxjygjZ6a05xuOrKxYeNho7mtp1Z7EF8d1NS8irPDQ/90MTPMfBp2sSLgWtBNOlu
        SWA1qChSFjh9My1Xf+gWOD/TH0zSc7DARAEPuo1mMURewDrq0harT5Dl4m5v3kRg1lHnTbFCSE1+S
        dIld38bw==;
Received: from [2001:4bb8:181:6771:cbc2:a0cd:a935:7961] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRWHF-00E99A-Er; Mon, 13 Feb 2023 10:41:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Ming Lei <ming.lei@redhat.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: fix circular disk reference in blk-cgroup
Date:   Mon, 13 Feb 2023 11:41:31 +0100
Message-Id: <20230213104134.475204-1-hch@lst.de>
X-Mailer: git-send-email 2.39.1
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

the third patch fixes a problem in haivng a circular disk reference
for blkgs.  The first two patches clean up blk-throttle to avoid
queue->disk refernece that get torn down in disk_release but could
in theory be used in the pd_free handler.

Diffstat:
 block/blk-cgroup.c     |   12 +++++++++---
 block/blk-throttle.c   |   39 ++++++++++++++++-----------------------
 include/linux/blkdev.h |    8 +++-----
 3 files changed, 28 insertions(+), 31 deletions(-)
