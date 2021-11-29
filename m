Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A102346159E
	for <lists+cgroups@lfdr.de>; Mon, 29 Nov 2021 13:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhK2NCZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 08:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbhK2NAY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 08:00:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3A7C08EB3B;
        Mon, 29 Nov 2021 03:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zr4yGvG1oSJLft11tGwyOTizPULLeTWpauYnh23nKIU=; b=qRq17tcdjDfrmVPqdGTaujU82V
        USUu58An8ugaQWMaf2IWlA84cAcGSoO5C8pzpMMR6W3Fjv5V2CiX2jPdY4ge+zyXoBp74pw5MBxTu
        cShHoey1ReqanWov8SRIBO8VV/MshJl8YBdaV9zMx2Aqvv6dg2yPmndz9kH5Abjp1d228oKv6vZFM
        9TdC3buoDMJ2fktQVWjtbnhcYNkrHZJVjBB+a7K2EkneHHTHlkNTnd0GI6Atf5j2r14TEqX52nwsQ
        n8tY3nqzv76YXi42ZyFUEZyuf7I5CEwkIkLjZf+jXlGqwimfWtThOVw/HKXpS45Wt6TwiywrGZ+tS
        rQwLzKig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrf6G-000Z8S-Lp; Mon, 29 Nov 2021 11:45:36 +0000
Date:   Mon, 29 Nov 2021 03:45:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     hch@infradead.org, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH 1/4] Revert "blk-throttle: remove tg_drain_bios"
Message-ID: <YaS9YPSAZgkNgxTb@infradead.org>
References: <20211127101059.477405-1-yukuai3@huawei.com>
 <20211127101059.477405-2-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211127101059.477405-2-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Nov 27, 2021 at 06:10:56PM +0800, Yu Kuai wrote:
> This reverts commit 32e3374304c7c317c05a61f3ddc315dbd46424f2.

Please re-add the function together with the actual users in a commit
that has a proper commit log.
