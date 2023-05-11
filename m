Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C1F6FF5BF
	for <lists+cgroups@lfdr.de>; Thu, 11 May 2023 17:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbjEKPV3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 May 2023 11:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbjEKPV0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 May 2023 11:21:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0A51992;
        Thu, 11 May 2023 08:21:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6205868D08; Thu, 11 May 2023 17:21:23 +0200 (CEST)
Date:   Thu, 11 May 2023 17:21:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next 3/6] blk-wbt: don't enable wbt for bio based
 device
Message-ID: <20230511152123.GC7880@lst.de>
References: <20230511014509.679482-1-yukuai1@huaweicloud.com> <20230511014509.679482-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511014509.679482-4-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 11, 2023 at 09:45:06AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Because rq_qos only make sense for rq based device. Instead of fail
> from sysfs configuration, make wbt sysfs dentry invisible directly.

This looks ok, bt I would be better to just have a separate attr
group just for blk-mq based devices?

