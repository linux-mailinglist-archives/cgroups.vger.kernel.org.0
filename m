Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC50047BF27
	for <lists+cgroups@lfdr.de>; Tue, 21 Dec 2021 12:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbhLULwv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Dec 2021 06:52:51 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43658 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbhLULwt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Dec 2021 06:52:49 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 429C321114;
        Tue, 21 Dec 2021 11:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640087568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCgxXcO/BZlBAUPu/jU/ISxCVbf1DpLofk5IlL3lQL0=;
        b=AwOnU2FEPfu6mm17FwEKXn7vFLAM4F0SfFny4EAt8FaQO4BICBQwT3fhV37/GN7dVPiSHq
        4l17UTn1xFdJBTXlqotg5IFAtFQp97PxtSFKmxnO9CymhXd0WFXxdkDxFPQqpYMGghUsmi
        gXHZ7VcxkNW1SQbhPtA4js+l2DyTMZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640087568;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCgxXcO/BZlBAUPu/jU/ISxCVbf1DpLofk5IlL3lQL0=;
        b=n8cmMnrBkFYeFhPOzJnGCilZY/ecndMZhBa8W0rTV9rJ+ESd8Xpgiigt4GB7GieARcNpDw
        IRXWG93OA8y8V5Bg==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 21234A3B8F;
        Tue, 21 Dec 2021 11:52:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BD2A01F2CEA; Tue, 21 Dec 2021 12:52:47 +0100 (CET)
Date:   Tue, 21 Dec 2021 12:52:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tj@kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, fchecconi@gmail.com,
        avanzini.arianna@gmail.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH 2/4] block, bfq: avoid moving bfqq to it's parent bfqg
Message-ID: <20211221115247.GE24748@quack2.suse.cz>
References: <20211221032135.878550-1-yukuai3@huawei.com>
 <20211221032135.878550-3-yukuai3@huawei.com>
 <20211221101659.GB24748@quack2.suse.cz>
 <d1c91a5f-33f3-ffad-e1ad-fb91482eb864@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1c91a5f-33f3-ffad-e1ad-fb91482eb864@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 21-12-21 19:08:44, yukuai (C) wrote:
> 在 2021/12/21 18:16, Jan Kara 写道:
> > On Tue 21-12-21 11:21:33, Yu Kuai wrote:
> > > Moving bfqq to it's parent bfqg is pointless.
> > > 
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > 
> > Did you notice that this is happening often enough that the check is worth
> > it? Where do we do this?
> > 
> 
> I noticed that this will happend when root group is offlined:
> 
> bfq_pd_offline
>  bfq_put_async_queues
>   __bfq_put_async_bfqq
>    bfq_bfqq_move
> 
> I'm not sure if there are other situations. I think bfq_bfqq_move()
> is not happening often itself, thus the checking won't affect
> performance.

Yeah, OK, I was just wondering. I guess there's no harm in doing this
check. Maybe add a comment that this can sometimes happen when dealing with
the root cgroup. And then feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
