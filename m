Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9AF63DA05
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 16:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiK3PzZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 10:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiK3PzT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 10:55:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2412984DDD;
        Wed, 30 Nov 2022 07:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=33yVl81nf/HYwbFyHP95flgen3w7k+7heZeCstu2Zt8=; b=1JXfUuCkqNVgQ9pH2hx3JGBJa1
        xGiCfys6fwNZUG6n/MUJVc83nSq085NlVLhdf5uUF8wSWS83HRjoBdnjR0f8pvmWEUMzJUlUUralz
        /Mq8A3ixnlv5DbHvj5ESqNZ5E+8/IzFurjAWffK8dQvzlxR1D5Equrh3itxNAd7ePbNiJNcS/qeu7
        HrSLXwHiOPcz+jb94A+bycyePIavkHCJqRnL7hJ1cSCtaMa5Q3P+aGyIiCh+MDagen1YVKdR6rJOq
        LMbCRWF2ZTNYYERjWEv3O6lP7ZDehAGMls52ZBXAbtV2CB3eJHC1zpFG1duRiOh+RRuOE4bhcxg/O
        Fva1+w3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p0PQJ-0009qC-N1; Wed, 30 Nov 2022 15:54:59 +0000
Date:   Wed, 30 Nov 2022 07:54:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Li Nan <linan122@huawei.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v2 1/9] blk-iocost: cleanup ioc_qos_write() and
 ioc_cost_model_write()
Message-ID: <Y4d801NjwwT0voKA@infradead.org>
References: <20221130132156.2836184-1-linan122@huawei.com>
 <20221130132156.2836184-2-linan122@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130132156.2836184-2-linan122@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> +	ret = nbytes;

ret is an int which bytes is a size_t.  So we at least need a ssize_t
instead for ret, and even that assumes nbytes never overflows a ssize_t.
