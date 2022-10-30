Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EED61298B
	for <lists+cgroups@lfdr.de>; Sun, 30 Oct 2022 10:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJ3Jk6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Oct 2022 05:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJ3Jkq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Oct 2022 05:40:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5D5D102;
        Sun, 30 Oct 2022 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2ykxlIqvDiS9rzx3CBCb1mMm3H
        pBONfqkpi2dveLHayK367OaXJsEtqaOioxkQcMtbN280RX2e/zvvjbJ4c0E6PpNPROqtqRS+vkKDz
        WYq1nrJ+h3phloAbPxPUNPN7bcG24dh9yiAbOlatOaQPK9nUtTKRUbOLyg3JkEia4MAgWD9ErtL0l
        jEGLJwGLEmLjHeIxN/S+e9Cb6eVpqvsGi0gsua4zMGR3Ro4K2q+Kt82x7xdb5bS22Vcr0a+GvmhTM
        KhPabtAig+NnVOiD6JIXFSlGiavITqtokgfmo7/v6ZeI1yonGHKeNjbT9/4wjWe1ujhHhd2So6fZQ
        ejridjYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op4o6-00Ev13-77; Sun, 30 Oct 2022 09:40:42 +0000
Date:   Sun, 30 Oct 2022 02:40:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 2/5] blk-iocost: improve hanlder of match_u64()
Message-ID: <Y15Gmj3an8htu61s@infradead.org>
References: <20221028101056.1971715-1-yukuai1@huaweicloud.com>
 <20221028101056.1971715-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028101056.1971715-3-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
