Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074914615C0
	for <lists+cgroups@lfdr.de>; Mon, 29 Nov 2021 14:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344228AbhK2NH3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 08:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346202AbhK2NF2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 08:05:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD8AC08EB4B;
        Mon, 29 Nov 2021 03:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sS1UF3+KLoSiOG3o2982PPolKEnQICmz9dBEx8rZQgw=; b=3ozHs8KOkUIsJOlFd0kIUXHuQE
        8W7ozvGgn/gfccir/W0Zdzs1P+oLIVQmqy9uvTxeViJ0XUHe4og1HjqPJH5PAP0TvoPcAZGeQuUZm
        NgsUmcU4MvqxyRSRCq1g5+3cW23OYcK1wTmLTNP/C1db3o0/2X0bQKnC1wpR6LIx1DMoQRISHv8ry
        sFpVFPeTskMa2fNZ70RJ022TbWhKFn5e4aWGVq61F5oB19iSA2jzatZMFLhCCsafrq9lAVNAtkPTC
        tJVcPI085lNsnv+aZHS8m/VOVjKqYXIkYqJ5scgGik1GzjEJ03K6I18UpmAI9lZsFRPzbvXxcrt99
        ImFKw4IQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrf7n-000ZHY-Gy; Mon, 29 Nov 2021 11:47:11 +0000
Date:   Mon, 29 Nov 2021 03:47:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     hch@infradead.org, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH 3/4] blk-throtl: introduce blk_throtl_cancel_bios()
Message-ID: <YaS9v+x2ofp+9jQn@infradead.org>
References: <20211127101059.477405-1-yukuai3@huawei.com>
 <20211127101059.477405-4-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211127101059.477405-4-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Nov 27, 2021 at 06:10:58PM +0800, Yu Kuai wrote:
> This function is used to cancel all throttled bios. Noted this
> modification is mainly from revertion of commit b77412372b68
> ("blk-throttle: remove blk_throtl_drain").

This should also go into the last patch.
