Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF8C8072D
	for <lists+cgroups@lfdr.de>; Sat,  3 Aug 2019 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387968AbfHCQRs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 3 Aug 2019 12:17:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33636 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387958AbfHCQRs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 3 Aug 2019 12:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/X3WDI0mWhLkrrAZYpOBF14jsWJC/LWwN2nM68m2FXE=; b=YTMLQb4x9LXJC64dxUjr6v4Xk
        GMXQsTaDR1vmYROgRuPGQmcgEYe76/aACMQQWCtkZimsYaMoot1ZvwPQDm2Ihc2qq7OidsOSLkgi5
        5h4VKxOmA9p2bsT/wyW0eiE02ATnGIGZFQZ1DcJKqPFLLhndN++tne2fJkGXmLxkZ5sdM7ADQfEHj
        ZUnzIYOL2jqDrOkrkXILUmtHBpDlM7HqH5QWkJ6gkEmQSJSg1PFxAP5KxYT78scR0A+zv9wLYi74s
        ucUhUJiJLtSFE9BZiIREAP1CItRqGkb5o5/6a4VXeKUPosSTon4rRzJYDNgxMmGjhEAcUMcDZEnKr
        HD/miYdsw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1htwj1-0007V1-Ge; Sat, 03 Aug 2019 16:17:43 +0000
Date:   Sat, 3 Aug 2019 09:17:43 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 2/4] bdi: Add bdi->id
Message-ID: <20190803161743.GB932@bombadil.infradead.org>
References: <20190803140155.181190-1-tj@kernel.org>
 <20190803140155.181190-3-tj@kernel.org>
 <20190803153908.GA932@bombadil.infradead.org>
 <20190803155349.GD136335@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803155349.GD136335@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Aug 03, 2019 at 08:53:49AM -0700, Tejun Heo wrote:
> Hey, Matthew.
> 
> On Sat, Aug 03, 2019 at 08:39:08AM -0700, Matthew Wilcox wrote:
> > On Sat, Aug 03, 2019 at 07:01:53AM -0700, Tejun Heo wrote:
> > > There currently is no way to universally identify and lookup a bdi
> > > without holding a reference and pointer to it.  This patch adds an
> > > non-recycling bdi->id and implements bdi_get_by_id() which looks up
> > > bdis by their ids.  This will be used by memcg foreign inode flushing.
> > > 
> > > I left bdi_list alone for simplicity and because while rb_tree does
> > > support rcu assignment it doesn't seem to guarantee lossless walk when
> > > walk is racing aginst tree rebalance operations.
> > 
> > This would seem like the perfect use for an allocating xarray.  That
> > does guarantee lossless walk under the RCU lock.  You could get rid of the
> > bdi_list too.
> 
> It definitely came to mind but there's a bunch of downsides to
> recycling IDs or using radix tree for non-compacting allocations.

Ah, I wasn't sure what would happen if you recycled an ID.  I agree, the
radix tree is pretty horrid for monotonically increasing IDs.  I'm still
working on the maple tree to replace it, but that's going slower than
I would like, so I can't in good conscience ask you to wait for it to
be ready.
