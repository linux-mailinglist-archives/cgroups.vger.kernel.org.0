Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6A720BFB8
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2020 09:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgF0Hce (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Jun 2020 03:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgF0Hce (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Jun 2020 03:32:34 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A561C03E97A;
        Sat, 27 Jun 2020 00:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=N+m/TXktm7C+5rnFX+JYBp/qnm40iMw/fl+XJO+IQXQ=; b=WcBaL3YXkyCLpW49SEw94Y7D7m
        KWLLqqIf2P69pD8tAY359N3kZtCw5LoPgZKsURUZH2Qukvx25sNRUgk3v9T0orAQ9etd19GFMwoZD
        c66gs10ktq3G6v+WWjcxpSciiwaHav362XO47NiGVoZznIG6j+FMh0/uCdPcv1byY7QzaVqFkemJg
        72Ax6ywHK0a62Dppe7UEOgY5E/005452+fFhjLyJMUzfmV2q/dqgt2BbvlSECDuNPLLri1gjSGV1Z
        hzQfPe/jU7lascGNtDABHjfzAFsOG0k2ysNNSLa631LuB2fCkJTrm1eWVsvfISjbt9X9BGVbCAjfN
        OitVpYQA==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5Jg-0006lM-6A; Sat, 27 Jun 2020 07:32:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: drive-by blk-cgroup cleanups
Date:   Sat, 27 Jun 2020 09:31:45 +0200
Message-Id: <20200627073159.2447325-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

while looking into another "project" I ended up wading through the
blkcq code for research and found a bunch of lose ends.  So here is
a bunch of drive-by cleanups for the code.

Diffstat:
 block/bio.c                |  143 +----------------------------------
 block/blk-cgroup.c         |  182 +++++++++++++++++++++++++++++++++++++--------
 block/blk-core.c           |    7 +
 block/blk-throttle.c       |   10 +-
 block/blk.h                |    2 
 drivers/md/dm.c            |    5 -
 include/linux/bio.h        |    9 --
 include/linux/blk-cgroup.h |  101 ------------------------
 kernel/cgroup/rstat.c      |    1 
 mm/page_io.c               |   17 ++++
 10 files changed, 192 insertions(+), 285 deletions(-)
