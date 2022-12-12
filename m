Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7C6649A4C
	for <lists+cgroups@lfdr.de>; Mon, 12 Dec 2022 09:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiLLIsA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 03:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiLLIr7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 03:47:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3253B85;
        Mon, 12 Dec 2022 00:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pUS0fRVuVl28efMmBL1cfrJsUvoRpvkefUc506NhvMs=; b=C3JZ2MLMHV9lxb2dpe3XDzlN9m
        UtvdwvY9w6C7R1gTQTR87vhICvE8PlmEhX889b/IHQN4NVCbIFZgdov+9GfE2XOslvUcpBrusCrpQ
        M3mQdPNaiKDPoYeUD2Ye4ClUOPiNsemr6TmMNZeLq92zFE2zNulIjC49Wdnb25YQtKEjVraqfVnzz
        5mErGIlhBGmw6zoPts2sPGEAUGp4ynvM7h5MorgNEOILbbvcjuxVBd3/biQY6CnhkAPxewO6ohptw
        p0nnRdi6aegVspDWUwK67iBdYVm+D4SbSimbEDZ/wPoz6vEXiPFI/8hyMMDkCLOe6IasufH4uDb6j
        s6RWk0oQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4eTd-00AXPQ-Dx; Mon, 12 Dec 2022 08:47:57 +0000
Date:   Mon, 12 Dec 2022 00:47:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, darklight2357@icloud.com,
        Josef Bacik <josef@toxicpanda.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2 block/for-6.2] blk-iolatency: Fix memory leak on
 add_disk() failures
Message-ID: <Y5bqvWdDa5MW7w3v@infradead.org>
References: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5TQ5gm3O4HXrXR3@slm.duckdns.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Dec 10, 2022 at 08:33:10AM -1000, Tejun Heo wrote:
> When a gendisk is successfully initialized but add_disk() fails such as when
> a loop device has invalid number of minor device numbers specified,
> blkcg_init_disk() is called during init and then blkcg_exit_disk() during
> error handling. Unfortunately, iolatency gets initialized in the former but
> doesn't get cleaned up in the latter.
> 
> This is because, in non-error cases, the cleanup is performed by
> del_gendisk() calling rq_qos_exit(), the assumption being that rq_qos
> policies, iolatency being one of them, can only be activated once the disk
> is fully registered and visible. That assumption is true for wbt and iocost,
> but not so for iolatency as it gets initialized before add_disk() is called.
> 
> It is desirable to lazy-init rq_qos policies because they are optional
> features and add to hot path overhead once initialized - each IO has to walk
> all the registered rq_qos policies. So, we want to switch iolatency to lazy
> init too. However, that's a bigger change. As a fix for the immediate
> problem, let's just add an extra call to rq_qos_exit() in blkcg_exit_disk().
> This is safe because duplicate calls to rq_qos_exit() become noop's.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: darklight2357@icloud.com

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
