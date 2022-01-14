Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3B148E7FA
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 11:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbiANKAD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 05:00:03 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58050 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240103AbiANJ7y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 04:59:54 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BFEC51F3D3;
        Fri, 14 Jan 2022 09:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642154391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qmwbDXCD1IYxhc8Rn4/92BZfIPK0fFdxSVgthJ5taA4=;
        b=J4BVfOXcoK+w1RCl2Zw4sZxvBV7m3oaac6fwGpQXId2pL+KIV+ughVxTxQ2zeit4y/cv0k
        6RGNq6gHnAVqsCAHjqgmOfRRuSumWxuEWMrajJ5Rh7hvcmCILmaG2n+qCTD+0gJruobjkP
        Jje0H/AIsgcT22TnebB7nLPWxCJtEaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642154391;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qmwbDXCD1IYxhc8Rn4/92BZfIPK0fFdxSVgthJ5taA4=;
        b=puAmxENJ+nE7lagW0XsW5t1PTGbkxEpFb9sBE4MLPvZEWOdNSvddqAQV1h7jvkwy1BGs0C
        6k5WF/eEsv6GEkBQ==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 73AF0A3B8F;
        Fri, 14 Jan 2022 09:59:51 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EA7A8A05D7; Fri, 14 Jan 2022 10:59:50 +0100 (CET)
Date:   Fri, 14 Jan 2022 10:59:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     jack@suse.cz, tj@kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v2 0/3] block, bfq: minor cleanup and fix
Message-ID: <20220114095950.fa3gofecmryztivs@quack3.lan>
References: <20211231032354.793092-1-yukuai3@huawei.com>
 <5696c767-8248-09a4-f04e-ac93138d30ef@huawei.com>
 <1cdb99ba-ed52-c755-fec4-86ee5f9bc61d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cdb99ba-ed52-c755-fec4-86ee5f9bc61d@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 14-01-22 16:23:36, yukuai (C) wrote:
> 在 2022/01/11 9:40, yukuai (C) 写道:
> > 在 2021/12/31 11:23, Yu Kuai 写道:
> > > Chagnes in v2:
> > >   - add comment in patch 2
> > >   - remove patch 4, since the problem do not exist.
> > > 
> > friendly ping ...
> 
> Hi, Jens
> 
> Can this patchset be applied?

Maybe Jens is waiting for Paolo's ack as a BFQ maintainer. Paolo, what do
you think about the cleanups? They seem mostly obvious to me...

								Honza

> 
> Thanks
> > > Yu Kuai (3):
> > >    block, bfq: cleanup bfq_bfqq_to_bfqg()
> > >    block, bfq: avoid moving bfqq to it's parent bfqg
> > >    block, bfq: don't move oom_bfqq
> > > 
> > >   block/bfq-cgroup.c  | 16 +++++++++++++++-
> > >   block/bfq-iosched.c |  4 ++--
> > >   block/bfq-iosched.h |  1 -
> > >   block/bfq-wf2q.c    | 15 ---------------
> > >   4 files changed, 17 insertions(+), 19 deletions(-)
> > > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
