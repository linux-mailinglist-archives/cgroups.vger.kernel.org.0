Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54809673F1A
	for <lists+cgroups@lfdr.de>; Thu, 19 Jan 2023 17:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjASQlm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Jan 2023 11:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjASQlk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Jan 2023 11:41:40 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BA95B5B2;
        Thu, 19 Jan 2023 08:41:34 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 951C868D0D; Thu, 19 Jan 2023 17:41:30 +0100 (CET)
Date:   Thu, 19 Jan 2023 17:41:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     tj@kernel.org, hch@lst.de, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next v3 1/3] blk-cgroup: dropping parent refcount
 after pd_free_fn() is done
Message-ID: <20230119164130.GA3332@lst.de>
References: <20230119110350.2287325-1-yukuai1@huaweicloud.com> <20230119110350.2287325-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119110350.2287325-2-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
