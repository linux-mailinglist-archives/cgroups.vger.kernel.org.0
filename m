Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54980618FEB
	for <lists+cgroups@lfdr.de>; Fri,  4 Nov 2022 06:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiKDFRL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Nov 2022 01:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKDFRK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Nov 2022 01:17:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FFD126;
        Thu,  3 Nov 2022 22:17:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4658768AA6; Fri,  4 Nov 2022 06:17:06 +0100 (CET)
Date:   Fri, 4 Nov 2022 06:17:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v2 4/5] blk-iocost: fix sleeping in atomic context
 warnning
Message-ID: <20221104051705.GB15721@lst.de>
References: <20221104023938.2346986-1-yukuai1@huaweicloud.com> <20221104023938.2346986-5-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104023938.2346986-5-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 04, 2022 at 10:39:37AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> match_u64() is called inside ioc->lock, which causes smatch static
> checker warnings:
> 
> block/blk-iocost.c:3211 ioc_qos_write() warn: sleeping in atomic context
> block/blk-iocost.c:3240 ioc_qos_write() warn: sleeping in atomic context
> block/blk-iocost.c:3407 ioc_cost_model_write() warn: sleeping in atomic
> context
> 
> Fix the problem by introducing a mutex and using it while prasing input
> params.

s/prasing/parsing/

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
