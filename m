Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98907613620
	for <lists+cgroups@lfdr.de>; Mon, 31 Oct 2022 13:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiJaMYb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Oct 2022 08:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiJaMYa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Oct 2022 08:24:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6D01E3;
        Mon, 31 Oct 2022 05:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+WDg5qNBe76FnzbLrO8nDJQ46OMFpJ0zF+2XMGbgyVw=; b=G2KuZBTUsRRYlM25mWS2OzlfUW
        vRYmMylWTdj4cHrNo7JgTSQnawMwdiX2LlU1I4+ApxI+kAoZisrbAr8zzcpg/S005SSbFiLHHGUqG
        143M/86X3wEWKmpvLtPVqr1zYq5diK4PaOJAijthuaIugtmkywdHIz4FognofoOqYu2rhQ3DxCoGg
        gJY5lWQ8XPUvodlopUo4ayTh4utr4yFpoOaWGXsSjvzd/+CGTzGZZeH2nFk0GBA3O0x66is3Gp3AY
        JJvY2LLviOSEGgZex8koGgxEfC3gHovSwgpHYmzWnSl24pvHiWjugg9SIzCM8PdhCbDHnJ5NvKZSq
        X048//cQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opTq8-00BeDl-3K; Mon, 31 Oct 2022 12:24:28 +0000
Date:   Mon, 31 Oct 2022 05:24:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org,
        Martin Liska <mliska@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block/blk-iocost (gcc13): cast enum members to int in
 prints
Message-ID: <Y1++fLJXkeZgtXR2@infradead.org>
References: <20221031114520.10518-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031114520.10518-1-jirislaby@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 31, 2022 at 12:45:20PM +0100, Jiri Slaby (SUSE) wrote:
> Cast the enum members to int when printing them.
> 
> Alternatively, we can cast them to ulong (to silence gcc < 12) and use %lu.
> Alternatively, we can move VTIME_PER_SEC away from the enum.

Yes, either split the enum or just use a define.  But casts are a big
code smell and should be avoided if there is a reasonable alternative.
