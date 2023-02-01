Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F8686140
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 09:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjBAIGl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 03:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjBAIGk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 03:06:40 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986EE1350E;
        Wed,  1 Feb 2023 00:06:39 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B87C067373; Wed,  1 Feb 2023 09:06:35 +0100 (CET)
Date:   Wed, 1 Feb 2023 09:06:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: Re: [PATCH 05/15] blk-cgroup: store a gendisk to throttle in
 struct task_struct
Message-ID: <20230201080635.GA8112@lst.de>
References: <20230124065716.152286-1-hch@lst.de> <20230124065716.152286-6-hch@lst.de> <Y9Rg0GuNAmJPlDri@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9Rg0GuNAmJPlDri@slm.duckdns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 27, 2023 at 01:40:00PM -1000, Tejun Heo wrote:
> So, we're shifting the dead test from schedule to the actual throttle path,
> which makes sense but I think this should at least be mentioned in the
> description if not put in its own patch.

That's what I tried to say with:

"Move the check for the dead disk to the latest place now that is is
 unbundled from the reference grab."

what else would you want me to write?
