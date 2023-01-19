Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A6E673F7A
	for <lists+cgroups@lfdr.de>; Thu, 19 Jan 2023 18:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjASRFc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Jan 2023 12:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjASRFa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Jan 2023 12:05:30 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D225A5CB;
        Thu, 19 Jan 2023 09:05:30 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B13F968D0D; Thu, 19 Jan 2023 18:05:26 +0100 (CET)
Date:   Thu, 19 Jan 2023 18:05:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: switch blk-cgroup to work on gendisk
Message-ID: <20230119170526.GA5050@lst.de>
References: <20230117081257.3089859-1-hch@lst.de> <Y8l34/qeHPLV4rKJ@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8l34/qeHPLV4rKJ@slm.duckdns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 19, 2023 at 07:03:31AM -1000, Tejun Heo wrote:
> On Tue, Jan 17, 2023 at 09:12:42AM +0100, Christoph Hellwig wrote:
> > blk-cgroup works on only on live disks and "file system" I/O from bios.
> > This all the information should be in the gendisk, and not the
> > request_queue that also exists for pure passthrough request based
> > devices.
> 
> Can't blk-throttle be used w/ bio based ones tho? I always thought that was
> the reason why we didn't move it into rq-qos framework.

Yes, it can.  Not sure if my sentence was unclear, but:

 - everything doing non-passthrough I/O only should be in the gendisk
 - everything related to blk-mq, including infrastruture for passthrough
   should remain in the request_queue

The idea that the request_queue will eventually become a blk-mq only
data structure and not exist (or just have a very leight weight stub)
for bio based drivers.
