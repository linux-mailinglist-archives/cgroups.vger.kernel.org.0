Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBD96CF81F
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 02:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjC3AQF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 20:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjC3AQF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 20:16:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5E75587;
        Wed, 29 Mar 2023 17:15:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7440368D07; Thu, 30 Mar 2023 02:15:52 +0200 (CEST)
Date:   Thu, 30 Mar 2023 02:15:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@meta.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: move bio cgroup punting into btrfs
Message-ID: <20230330001552.GA2381@lst.de>
References: <20230327004954.728797-1-hch@lst.de> <512eaacf-3ff6-f4f9-c856-a0e03c027501@meta.com> <20230328233448.GA5486@lst.de> <ZCSOgoe84BhiUZcn@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCSOgoe84BhiUZcn@slm.duckdns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 29, 2023 at 09:16:18AM -1000, Tejun Heo wrote:
> We didn't really look deep into adding the support but Chris mentioned that
> raid5/6 are likely to need something similar. Maybe this is because my grasp
> of filesytsems is pretty weak but the pattern doesn't seem unreasonable to
> me. There's some work to be done by a shread kthread and that sometimes can
> fork out IOs which belong to specific cgroups.

Well, in a cgroup aware writeback path we'd always be off much better
to just do the work from a cgroup specific thread instead of bouncing
it around.

> At least in the IO control and direct issue path, punting to just one thread
> hasn't been a practical problem given that when the issuing thread needs to
> be blocked, either the whole device or the cgroup needs to be throttled
> anyway.

I don't think it is a problem per see.  But it is: a) inefficient and
b) complex in terms of code.  So why bounce around between 2, or in case
of writeback 3 threads for a single I/O, instead of making sure your
offload threads are simplify cgroup specific to start with?
