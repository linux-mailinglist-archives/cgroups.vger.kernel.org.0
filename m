Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A107126C0
	for <lists+cgroups@lfdr.de>; Fri, 26 May 2023 14:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjEZMfV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 May 2023 08:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjEZMfU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 May 2023 08:35:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE5FE7F;
        Fri, 26 May 2023 05:34:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 29F416732A; Fri, 26 May 2023 14:34:09 +0200 (CEST)
Date:   Fri, 26 May 2023 14:34:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        lukas.bulwahn@gmail.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH -next v2 6/6] blk-sysfs: add a new attr_group for blk_mq
Message-ID: <20230526123408.GA4569@lst.de>
References: <20230512093554.911753-1-yukuai1@huaweicloud.com> <20230512093554.911753-7-yukuai1@huaweicloud.com> <8cafbd02-182a-4071-7e04-cc6f96045852@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cafbd02-182a-4071-7e04-cc6f96045852@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
