Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27F9414C1F
	for <lists+cgroups@lfdr.de>; Wed, 22 Sep 2021 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhIVOha (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Sep 2021 10:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhIVOh3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Sep 2021 10:37:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA257C061574;
        Wed, 22 Sep 2021 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nHng5tIdS7Xn6BCJwl7sOAs/mlZQxYRxlcr0Xa3zcFk=; b=d5KDb4Prr992RAw/GFY1RWSeTa
        llNVgLQCmWqwpJ9JEciqBa+ARq9gF0XftN3ZJUTsyloNNDdiDQI3OmdDaH+X9My+XzMSAKGAn93uA
        yFwR2zypqoMgSNIuQT/mQrimgrfO+u3iCfWnLdFQxvlHHlnQKZSYK32iUAJMj2m4FEE1e8U70pKY/
        rhMKWOcvE8gsvY7MNVodijz20hqinhSIkM7wcTm1eD/wiaBmLJynw1nrkhh26aASYrmzVQZKPoVUq
        zNxjjF5SNzpo5xTycszrPX3VUMZ+LBz1KIFNs43+aG+Wr8V/nH6cVbBEmfgpJeJDm66+oIVlqXenI
        Drzp+MJw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT3Kj-004rzB-Gj; Wed, 22 Sep 2021 14:35:00 +0000
Date:   Wed, 22 Sep 2021 15:34:49 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH 4/4] block: cancel all throttled bios in
 blk_cleanup_queue()
Message-ID: <YUs/CcSKqNoIIXoW@infradead.org>
References: <20210922125115.381752-1-yukuai3@huawei.com>
 <20210922125115.381752-5-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922125115.381752-5-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 22, 2021 at 08:51:15PM +0800, Yu Kuai wrote:
> Throttled bios can't be issued after queue is dying in
> blk_cleanup_queue(), thus it's better to cancel them immediately
> rather than waiting for throttle is done.
> 
> For example, if user thread is throttled with low bps while is
> issuing large io, and the device is deleted. The user thread will
> wait for a long time for io to return.

blk_cleanup_queue is too late, this will need to go into del_gendisk
and on top of my "tear down file system I/O in del_gendisk" series.
