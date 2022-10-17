Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3919B600802
	for <lists+cgroups@lfdr.de>; Mon, 17 Oct 2022 09:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJQHr0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Oct 2022 03:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiJQHrY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Oct 2022 03:47:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF55193ED;
        Mon, 17 Oct 2022 00:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N3DhelgxeJD6609Ma0kcmpLW0VW7ci1zuKd0emkDasI=; b=4fQDVYDXyHEvBhehq1JK9VdDW0
        R3tMd/QDPEtKsjFGyFUg5svkVWeas3otDLcoY5ADt9NTdCDdXhQyvOSW0DiE+Ha40wEVm/WfkzT/P
        2ch6qZHi1dMjetjJmmIpImeTfa6H8ZZIkQJ5A7xdpLLo5NXFdAN8dqifLlAyZKASYGEEnlfL06jmG
        yElmdEt09/1MHOslxcYuYYBVYM/zyj4Cb8W/6WUxoR+nYxhbg+dlVS3nz2/T4FBe6Pb/3hYyNRHvI
        3YHeorVPSs9m3r3Mfq/GgQdazSE7bATFMgq6NUCBUwMIZHJOLAuHVUoWLH3zLEoaYTfJ2ti5bhaI7
        9m8SZYMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okKqE-008bBK-57; Mon, 17 Oct 2022 07:47:18 +0000
Date:   Mon, 17 Oct 2022 00:47:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     axboe@kernel.dk, tj@kernel.org, paolo.valente@linaro.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: Add helper for queue_flags bit test
Message-ID: <Y00IhghhGgVQBknL@infradead.org>
References: <20221011145246.8656-1-set_pte_at@outlook.com>
 <TYCP286MB232392B1D23662DE81B0D2D5CA239@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB232392B1D23662DE81B0D2D5CA239@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

>  	if (op_is_flush(bio->bi_opf) &&
> -	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
> +		!blk_queue_wb_cached(q)) {

The formatting is wrong here.  And I really think these helpers do
nothing but obsfucating the code.  Now instead of a grep telling
me exactly what is going on I now need to walk through the macro
first.  (nevermind that this particular one is also horribly misnamed).

