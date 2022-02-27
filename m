Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B169A4C5DAA
	for <lists+cgroups@lfdr.de>; Sun, 27 Feb 2022 18:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiB0RRq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 27 Feb 2022 12:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiB0RRq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 27 Feb 2022 12:17:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6484265481;
        Sun, 27 Feb 2022 09:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1+1W3bcZcWwdxZGt68XLVQsJDzEEa3DPMfJ+40hI5ZE=; b=Qmk+ArWtToMpl/lfeapZnRuA+i
        PrpP0ngA7XYmy9Gc6kV2P9n12jrrsV7XUBTZPhKniH/NRJt3xiLUsoQSQ+Ft50Cdcl6W0AOwA+Md5
        dC1WO3nZbABs3yFH5hL2CshbLWPfMlFmLXZqG78tLsnQ2fxKSF/2Ox84afzZCXbdfWT4VW8xUIkQI
        t/m/r7ViW2IaqOCXCC7ZY6Y7CUGw6J831FxUykxsBiYnBFwNAr0OzK+kqsTxY69VgvQ0hwZHWdsW7
        W6qFUCswdr+I2WSzWlPThBAJ9S1pEht19lBh0nZGUPujtoVBKBtTMr6mBKnDLxkby0ZjFP7t8BMmz
        IxzPFXzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nONAE-009roj-8J; Sun, 27 Feb 2022 17:16:54 +0000
Date:   Sun, 27 Feb 2022 09:16:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     ming.lei@redhat.com, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v9] block: cancel all throttled bios in del_gendisk()
Message-ID: <YhuyBgZSS6m/Mwu6@infradead.org>
References: <20220210115637.1074927-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210115637.1074927-1-yukuai3@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 10, 2022 at 07:56:37PM +0800, Yu Kuai wrote:
> Throttled bios can't be issued after del_gendisk() is done, thus
> it's better to cancel them immediately rather than waiting for
> throttle is done.
> 
> For example, if user thread is throttled with low bps while it's
> issuing large io, and the device is deleted. The user thread will
> wait for a long time for io to return.

FYI, this crashed left rigt and center when running xfstests with
traces pointing to throtl_pending_timer_fn.
