Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28AD700AE6
	for <lists+cgroups@lfdr.de>; Fri, 12 May 2023 16:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241650AbjELO7W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 May 2023 10:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241664AbjELO7S (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 May 2023 10:59:18 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A033C03;
        Fri, 12 May 2023 07:58:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6392A68AFE; Fri, 12 May 2023 16:58:33 +0200 (CEST)
Date:   Fri, 12 May 2023 16:58:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, lukas.bulwahn@gmail.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH -next v2 5/6] blk-iocost: move
 wbt_enable/disable_default() out of spinlock
Message-ID: <20230512145832.GD5546@lst.de>
References: <20230512093554.911753-1-yukuai1@huaweicloud.com> <20230512093554.911753-6-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512093554.911753-6-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
