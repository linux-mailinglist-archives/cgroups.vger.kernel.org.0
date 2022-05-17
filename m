Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD95529956
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 08:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiEQGL7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 02:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiEQGL6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 02:11:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320D743AFA;
        Mon, 16 May 2022 23:11:57 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5145968AA6; Tue, 17 May 2022 08:11:52 +0200 (CEST)
Date:   Tue, 17 May 2022 08:11:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Khazhy Kumykov <khazhy@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        w.bumiller@proxmox.com, cgroups@vger.kernel.org
Subject: Re: Issue with 252c651a4c85 ("blk-cgroup: stop using seq_get_buf")
Message-ID: <20220517061152.GA4789@lst.de>
References: <CACGdZYK3iLc8u+YuyteaWqLRCHUJvR10Gem6MFyx36wP4Z2y2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGdZYK3iLc8u+YuyteaWqLRCHUJvR10Gem6MFyx36wP4Z2y2Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 12, 2022 at 03:42:54PM -0700, Khazhy Kumykov wrote:
> I can see in the latest tip, if we have devices with no statistics,
> we'll print the maj:min and then nothing else, which can end up
> looking weird, (e.g. like below.) I see that in older kernels, we
> avoided printing the device name at all if there were no stats, and it
> looks like this behavior was silently broken by 252c651a4c85
> ("blk-cgroup: stop using seq_get_buf"), where before we prepared the
> whole line then decided at the end whether to commit it or not.
> 
> I do see a patch "blk-cgroup: always terminate io.stat lines" that
> addresses this by just unconditionally printing the newline (though it
> looks like that patch never landed).

It should really go in, I just sent a ping for it.
