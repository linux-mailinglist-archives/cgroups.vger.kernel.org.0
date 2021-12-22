Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCE547D371
	for <lists+cgroups@lfdr.de>; Wed, 22 Dec 2021 15:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245613AbhLVORa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Dec 2021 09:17:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50460 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245622AbhLVOR3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Dec 2021 09:17:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 82D76212B7;
        Wed, 22 Dec 2021 14:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640182648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=idiSby8trVHShWK13Y0N9hJM/pCoT2M/uIPXzb4ZYSA=;
        b=XDsNO3+6DoHh9p+11+8PK6Gn9zpjZeUbct6b6ph3OmJRYuyc9lSQprir/4vmItc06j8BtB
        XOEVxllFEWsgILJ8W7Nr+s/AAWK/QhZCWFoz7vYeG3K0SuXxsuHodfbKv1NpYkQ55dlK48
        CrCYotIwo+k+loQFNJJz2LZNfYBOBWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640182648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=idiSby8trVHShWK13Y0N9hJM/pCoT2M/uIPXzb4ZYSA=;
        b=gqT1jGNfT+HgU3YyxXQ1XixhKQerBZcrY72CDNrrn+PaBGBW7lhNdsvIge7o/1p7kZMKkL
        1Q1dAFAsOMJg56Aw==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id E3334A3B85;
        Wed, 22 Dec 2021 14:17:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5787C1F2CEF; Wed, 22 Dec 2021 15:17:22 +0100 (CET)
Date:   Wed, 22 Dec 2021 15:17:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tj@kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, fchecconi@gmail.com,
        avanzini.arianna@gmail.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH 4/4] block, bfq: update pos_root for idle bfq_queue in
 bfq_bfqq_move()
Message-ID: <20211222141722.GC685@quack2.suse.cz>
References: <20211221032135.878550-1-yukuai3@huawei.com>
 <20211221032135.878550-5-yukuai3@huawei.com>
 <20211221115001.GD24748@quack2.suse.cz>
 <6ca1e924-47fa-b94e-598c-69a9549eb68e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ca1e924-47fa-b94e-598c-69a9549eb68e@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 22-12-21 11:12:45, yukuai (C) wrote:
> 在 2021/12/21 19:50, Jan Kara 写道:
> > On Tue 21-12-21 11:21:35, Yu Kuai wrote:
> > > During code review, we found that if bfqq is not busy in
> > > bfq_bfqq_move(), bfq_pos_tree_add_move() won't be called for the bfqq,
> > > thus bfqq->pos_root still points to the old bfqg. However, the ref
> > > that bfqq hold for the old bfqg will be released, so it's possible
> > > that the old bfqg can be freed. This is problematic because the freed
> > > bfqg can still be accessed by bfqq->pos_root.
> > > 
> > > Fix the problem by calling bfq_pos_tree_add_move() for idle bfqq
> > > as well.
> > > 
> > > Fixes: e21b7a0b9887 ("block, bfq: add full hierarchical scheduling and cgroups support")
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > 
> > I'm just wondering, how can it happen that !bfq_bfqq_busy() queue is in
> > pos_tree? Because bfq_remove_request() takes care to remove bfqq from the
> > pos_tree...
> 
> Hi,
> 
> It's right this is not a problem in common case. The problem seems to
> relate to queue merging and task migration. Because I once reporduced
> it with the same reporducer for the problem that offlined bfqg can be
> inserted into service tree. The uaf is exactly in
> bfq_remove_request->rb_rease(). However I didn't save the stack...
> 
> I guess this is because bfq_del_bfqq_busy() is called from
> bfq_release_process_ref(), and queue merging prevert sunch bfqq to be
> freed, thus such bfqq is not in service tree, and it's pos_root can
> point to the old bfqg after bfq_bic_update_cgroup->bfq_bfqq_move.
> 
> I haven't confirmed this, however, this patch itself only cleared
> bfqq->pos_root for idle bfqq, there should be no harm.

Well, I agree this patch does no harm but in my opinion it is just papering
over the real problem which is that we leave bfqq without any request in
the pos_tree which can have also other unexpected consequences. I don't
think your scenario with bfq_release_process_ref() calling
bfq_del_bfqq_busy() really answers my question because we call
bfq_del_bfqq_busy() only if RB_EMPTY_ROOT(&bfqq->sort_list) (i.e., bfqq has
no requests) and when sort_list was becoming empty, bfq_remove_request()
should have removed bfqq from the pos_tree. So I think proper fix lies
elsewhere and I would not merge this patch until we better understand what
is happening in this case.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
