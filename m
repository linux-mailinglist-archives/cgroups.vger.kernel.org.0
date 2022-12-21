Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EBF652FA8
	for <lists+cgroups@lfdr.de>; Wed, 21 Dec 2022 11:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiLUKiF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Dec 2022 05:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbiLUKh6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Dec 2022 05:37:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CF9B19;
        Wed, 21 Dec 2022 02:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=480wSk2F3WgREEBIZRNwD5lYM7sivLG3o11mUqwzDvI=; b=m0SBhYvd9cTYyXMTpMPxu7KP/Q
        ybgCtTxPldeWTL0jTbF3Qy4gm38p6ljJZfRF9u7ER31xc+oUAd4cVku/1xncKwzBrhJJuXOddjoxk
        DUvVpzRB/CviI/GVmB/G4EDURIo86jFr1zUNWWl34LW5Ob1nauduPx9+/NzO/wzhJ9W/YPccyZ2N0
        /HUN0PUpNvHnGGPVFBdRRtM93orhlPQDy88yl8+0Ry6P7z2Dml97qv5JZjSoo8iueG+tm3j+A5YpQ
        5yh94gARx920+ReZLH6j6Y05S7vDtu43Yz/GfY48rjC+n3Gfe52hTZXFs/fob5+P4H5/fH7Y32WDw
        Y3TY/bRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7wTy-00DX19-Nz; Wed, 21 Dec 2022 10:37:54 +0000
Date:   Wed, 21 Dec 2022 02:37:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Tejun Heo <tj@kernel.org>, hch@infradead.org, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next 0/4] blk-cgroup: synchronize del_gendisk() with
 configuring cgroup policy
Message-ID: <Y6LiAg4u/jkrosVe@infradead.org>
References: <20221217030908.1261787-1-yukuai1@huaweicloud.com>
 <Y6DP3aOSad8+D1yY@slm.duckdns.org>
 <e01daffe-a3e3-8bf2-40ee-192a9e70d911@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e01daffe-a3e3-8bf2-40ee-192a9e70d911@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 20, 2022 at 05:19:12PM +0800, Yu Kuai wrote:
> If we are using a mutex to protect rq_qos ops, it seems the right thing
> to do do also using the mutex to protect blkcg_policy ops, and this
> problem can be fixed because mutex can be held to alloc memroy with
> GFP_KERNEL. What do you think?

Getting rid of the atomic allocations would be awesome.

FYI, I'm also in favor of everything that moves things out of
queue_lock into more dedicated locks.  queue_lock is such an undocument
mess of untargeted things that don't realted to each other right now
that splitting and removing it is becoming more and more important.
