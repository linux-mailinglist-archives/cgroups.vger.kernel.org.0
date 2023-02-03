Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842416891A4
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 09:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjBCIJ1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 03:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjBCIIz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 03:08:55 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F2295D33;
        Fri,  3 Feb 2023 00:06:50 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB00C67373; Fri,  3 Feb 2023 09:06:46 +0100 (CET)
Date:   Fri, 3 Feb 2023 09:06:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 07/19] blk-cgroup: store a gendisk to throttle in
 struct task_struct
Message-ID: <20230203080646.GB28639@lst.de>
References: <20230201134123.2656505-1-hch@lst.de> <20230201134123.2656505-8-hch@lst.de> <Y9xSs0Gf8Qcr9R7w@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9xSs0Gf8Qcr9R7w@slm.duckdns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 02, 2023 at 02:17:55PM -1000, Tejun Heo wrote:
> The change looks fine to me but can you please separate out the dead disk
> test change to its own patch and explain why?

I'll just drop it.  All these dead checks got added only accidentally
due to how blk_get_queues worked, and I'm really not interested enough
to discuss the fine details of it.
