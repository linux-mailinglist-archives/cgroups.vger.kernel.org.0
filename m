Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8B26A168
	for <lists+cgroups@lfdr.de>; Tue, 15 Sep 2020 10:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIOI7e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Sep 2020 04:59:34 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:34685 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbgIOI7c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Sep 2020 04:59:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U90bzfv_1600160366;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U90bzfv_1600160366)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Sep 2020 16:59:26 +0800
Date:   Tue, 15 Sep 2020 16:59:26 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     tj@kernel.org, baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Some improvements for blk-throttle
Message-ID: <20200915085926.GA122937@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
 <822998a7-4cc7-88ee-8b3f-e8e7660a5b0a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <822998a7-4cc7-88ee-8b3f-e8e7660a5b0a@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jens,

On Mon, Sep 14, 2020 at 07:37:53PM -0600, Jens Axboe wrote:
> On 9/7/20 2:10 AM, Baolin Wang wrote:
> > Hi All,
> > 
> > This patch set did some clean-ups, as well as removing some unnecessary
> > bps/iops limitation calculation when checking if can dispatch a bio or
> > not for a tg. Please help to review. Thanks.
> > 
> > Baolin Wang (5):
> >   blk-throttle: Fix some comments' typos
> >   blk-throttle: Use readable READ/WRITE macros
> >   blk-throttle: Define readable macros instead of static variables
> >   blk-throttle: Avoid calculating bps/iops limitation repeatedly
> >   blk-throttle: Avoid checking bps/iops limitation if bps or iops is    
> >     unlimited
> > 
> >  block/blk-throttle.c | 59 ++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 36 insertions(+), 23 deletions(-)
> 
> Looks reasonable to me, I've applied it.

Thanks.

> 
> Out of curiosity, are you using blk-throttle in production, or are these
> just fixes/cleanups that you came across?

Yes, we're using it in some old products, and I am trying to do some
cleanups and optimizaiton when testing it.

