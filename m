Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7313C652F94
	for <lists+cgroups@lfdr.de>; Wed, 21 Dec 2022 11:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiLUKfV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Dec 2022 05:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbiLUKep (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Dec 2022 05:34:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840056592;
        Wed, 21 Dec 2022 02:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qo0/7oh20JB4vOMTtkVk74rFMV3lr/eFERwPDckaJ84=; b=CvfudaDgduzGkGO/tL8HCoG0cx
        Vc/Ed3d8vSiE7XbGKRh+aPrjOZK9rolmp/I9Vno85q9Wpgb9tIcV+ooTCk+Xt2ZwvR7x9tN3fepaG
        gtzJIt4P+lDSpucNMSjQtI4yAY0UKUMweQd09/TuwkZmfTzkVEA4P2vJIHz2vrjXm59VmfO/Bfj34
        ypTGRrN68fpcqATg/QgkQw3pIstO2GHIgsKOc/EAK+00mzVQ+SMX/1Tybvg5gv3sW/xMzfxsEBaus
        Lguks2sBH0yrSLIvW+onUv8D1bH/W4BjFIr39DPBJXCxQm4lKvdWg2xCmSM/i781J3eoDJgTEY1dr
        ifUFXrfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7wQ3-00DUKS-3S; Wed, 21 Dec 2022 10:33:51 +0000
Date:   Wed, 21 Dec 2022 02:33:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, hch@infradead.org, josef@toxicpanda.com,
        axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH -next 1/4] blk-iocost: track whether iocg is still online
Message-ID: <Y6LhD8CEkcgLUJoQ@infradead.org>
References: <20221217030527.1250083-1-yukuai1@huaweicloud.com>
 <20221217030527.1250083-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217030527.1250083-2-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Dec 17, 2022 at 11:05:24AM +0800, Yu Kuai wrote:
> @@ -459,6 +459,8 @@ struct ioc_gq {
>  	struct blkg_policy_data		pd;
>  	struct ioc			*ioc;
>  
> +	bool online;

Nit: maybe tab align this field like the fields above it.

> +static void ioc_pd_offline(struct blkg_policy_data *pd)
> +{
> +	struct ioc_gq *iocg = pd_to_iocg(pd);
> +	struct ioc *ioc = iocg->ioc;
> +	unsigned long flags;
> +
> +	if (ioc) {

How could ioc be NULL here?

