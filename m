Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF20167DE3A
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 08:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjA0HH7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 02:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjA0HH6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 02:07:58 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8EC16AC5;
        Thu, 26 Jan 2023 23:07:57 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 09E1A68D0A; Fri, 27 Jan 2023 08:07:55 +0100 (CET)
Date:   Fri, 27 Jan 2023 08:07:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 01/15] blk-cgroup: don't defer blkg_free to a workqueue
Message-ID: <20230127070754.GB4180@lst.de>
References: <20230117081257.3089859-1-hch@lst.de> <20230117081257.3089859-2-hch@lst.de> <b4622942-67e7-969b-4439-0aea7c5bd165@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4622942-67e7-969b-4439-0aea7c5bd165@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 27, 2023 at 07:59:23AM +0100, Hannes Reinecke wrote:
> On 1/17/23 09:12, Christoph Hellwig wrote:
>> Now that blk_put_queue can be called from process context, ther is no
>> need for the asynchronous execution.
>>
> Can you clarify 'now'?
> IE point to the commit introducing the change?

49e4d04f0486117ac57a97890eb1db6d52bf82b3
Author: Tejun Heo <tj@kernel.org>
Date:   Fri Jan 6 10:34:10 2023 -1000

    block: Drop spurious might_sleep() from blk_put_queue()

