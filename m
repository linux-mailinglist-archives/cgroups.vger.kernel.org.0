Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8671D61298D
	for <lists+cgroups@lfdr.de>; Sun, 30 Oct 2022 10:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJ3Jly (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Oct 2022 05:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3Jlx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Oct 2022 05:41:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7DFBC84;
        Sun, 30 Oct 2022 02:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mGekaAOdIja1Coan0T/XXSeb3SnqS47JFAz2HGqAANA=; b=h7eeAKOst8GmseL3Ly3xX57sZP
        eYrLBzlbIi8+fy2qAhn4gfhf/B3MeoR5WVcg2HPvfckUYTT1MtpvRtk9G8yd3UnqQ/DqGIaWCaLg/
        i3za0UnvN9m4OCwq80+4TVSmEkE8WIwTID9x3i7UR6c1hnDFuflasw1gjffbkVwQw8D2RNg9ANEvT
        kTwQiwxgw3MTC3goiJLBZkSWrNXw8R4gy9U2nPRnCxBpZQkMoiXU+Fq0cvEtHciExojvLSmVHEy2m
        NP82jmZ0jT3u/oEkdCZTnjr4tH6sBdXmZ6Z4NwV4KxZyGa21iHKgGJ/AiT6zBM0ZJae+bi8cxvPMC
        wBNtQL8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op4p9-00EvfT-56; Sun, 30 Oct 2022 09:41:47 +0000
Date:   Sun, 30 Oct 2022 02:41:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 3/5] blk-iocost: don't allow to configure bio based
 device
Message-ID: <Y15G2zBpor5flDLy@infradead.org>
References: <20221028101056.1971715-1-yukuai1@huaweicloud.com>
 <20221028101056.1971715-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028101056.1971715-4-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good (I actually stubled over this a few days ago as well):

Reviewed-by: Christoph Hellwig <hch@lst.de>
