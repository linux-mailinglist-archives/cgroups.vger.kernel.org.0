Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60322652FA0
	for <lists+cgroups@lfdr.de>; Wed, 21 Dec 2022 11:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiLUKgB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Dec 2022 05:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbiLUKeq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Dec 2022 05:34:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114BF7676;
        Wed, 21 Dec 2022 02:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=EZOx6hZJqFrvGMRUreIdO6L7sB
        Hk7plpe8asFJ7bT6cZIYNpUsKwJr7Yvla9zFjv11M8bfxfghtK3F6NbipUw0hzsh0ZQIZe3ea7R2M
        HislXoZzdx7cTfrplRaMvGMlg1v/uaUIvqtD/p0UuO83dsmzo2k8mJ+gUOBQQICTLI0bwyv8f2MGA
        Wpwpe4vQBPvjXKC/g24BnzxJ/T4OVk9K0Pq4DejZ6IB5/2wvMVRqQpOAG4savvYV/EUWtwGBYt47l
        nrqUtQyhO4fI+NSoCXi0lMX82PIMAIE1X9u+X6Sxnk5SX0f0hBos6+zOTT21bi2Nb9DMZt+67reVA
        gtcsuXjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7wQp-00DUmQ-UC; Wed, 21 Dec 2022 10:34:39 +0000
Date:   Wed, 21 Dec 2022 02:34:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, hch@infradead.org, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next 1/4] block/rq_qos: protect 'q->rq_qos' with
 queue_lock in rq_qos_exit()
Message-ID: <Y6LhPwnAns/R5NS7@infradead.org>
References: <20221217030908.1261787-1-yukuai1@huaweicloud.com>
 <20221217030908.1261787-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217030908.1261787-2-yukuai1@huaweicloud.com>
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
