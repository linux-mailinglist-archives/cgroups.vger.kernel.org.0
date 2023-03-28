Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C1C6CCE16
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 01:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjC1Xe5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 19:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC1Xe4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 19:34:56 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EFF3592;
        Tue, 28 Mar 2023 16:34:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 707D268BEB; Wed, 29 Mar 2023 01:34:48 +0200 (CEST)
Date:   Wed, 29 Mar 2023 01:34:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@meta.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: move bio cgroup punting into btrfs
Message-ID: <20230328233448.GA5486@lst.de>
References: <20230327004954.728797-1-hch@lst.de> <512eaacf-3ff6-f4f9-c856-a0e03c027501@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <512eaacf-3ff6-f4f9-c856-a0e03c027501@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 28, 2023 at 05:18:43PM -0400, Chris Mason wrote:
> Is btrfs really the only place using worker threads to submit IO, or are
> we just the only ones looking for the priority inversions w/resource
> control in place?

btrfs is the only place offloading writes from the per-cgroup writeback
to it's own not cgroup aware workqueues.

Offloading from one writeback thread to another threadpool to just
offload back to another thread to not deadlock is obviously not
an actual smart thing to do, and fortunately no one else is doing
this.

For btrfs it is on it's way out by not doing the offload just for
checksumming in a little bit, and even for compression the right fix
is just to allow more than one thread per device and cgroup.  I plan
to look into that, but there's plenty higher priority work right now.
