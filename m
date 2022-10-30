Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4B6612984
	for <lists+cgroups@lfdr.de>; Sun, 30 Oct 2022 10:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJ3Jkd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Oct 2022 05:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3Jkc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Oct 2022 05:40:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B09BE6;
        Sun, 30 Oct 2022 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=dw8Bcab+STkBnrLeOp10Rwn1tH
        v89M0oZzyJgeAXhvmw+L6/WbN/cxniF6Q9NeCi2/aiqwFlbZBjScEMTx4a+1hlf+pgKGuWRCer8CD
        0vYnNUWkbfLp2v9s3wMzEf8IFWTwysJHE/qcffWZB8s0CPFSwj3E/s/Ca2+T5RxCLNUKsiiQXu3zW
        kpKCNfW87R4tcajAOUbd1VCsoZeDxI6K/ADOf0L434OpxYrOMjT+xxeeFIfyOgaxmTWfzfxneqnbF
        2Y+hDf/dOGn4ACgBka7QHbLrz+pO1u5mL6PTPorlf+uRG+Pqi/rZYJAzj9WPouiIoqGrjBx+w4FYF
        Ssl4Uzyw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op4ne-00EuiV-Em; Sun, 30 Oct 2022 09:40:14 +0000
Date:   Sun, 30 Oct 2022 02:40:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 1/5] blk-iocost: cleanup ioc_qos_write() and
 ioc_cost_model_write()
Message-ID: <Y15GfkfPNF7koVIa@infradead.org>
References: <20221028101056.1971715-1-yukuai1@huaweicloud.com>
 <20221028101056.1971715-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028101056.1971715-2-yukuai1@huaweicloud.com>
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
