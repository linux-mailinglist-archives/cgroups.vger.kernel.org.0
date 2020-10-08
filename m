Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE29286D3A
	for <lists+cgroups@lfdr.de>; Thu,  8 Oct 2020 05:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgJHDkv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Oct 2020 23:40:51 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:33720 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbgJHDku (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Oct 2020 23:40:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UBGOO3q_1602128447;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UBGOO3q_1602128447)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Oct 2020 11:40:48 +0800
Date:   Thu, 8 Oct 2020 11:40:47 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Remove redundant 'return' statement
Message-ID: <20201008034047.GA96391@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <633f73addfc154700b2f983bee6230f82de4c984.1601253090.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <633f73addfc154700b2f983bee6230f82de4c984.1601253090.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On Mon, Sep 28, 2020 at 08:42:26AM +0800, Baolin Wang wrote:
> Remove redundant 'return' statement for 'void' functions.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Gentle ping?

> ---
>  block/blk-iocost.c    | 2 +-
>  block/blk-iolatency.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index ef9476f..e38c406 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -3343,7 +3343,7 @@ static int __init ioc_init(void)
>  
>  static void __exit ioc_exit(void)
>  {
> -	return blkcg_policy_unregister(&blkcg_policy_iocost);
> +	blkcg_policy_unregister(&blkcg_policy_iocost);
>  }
>  
>  module_init(ioc_init);
> diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
> index f90429c..81be009 100644
> --- a/block/blk-iolatency.c
> +++ b/block/blk-iolatency.c
> @@ -1046,7 +1046,7 @@ static int __init iolatency_init(void)
>  
>  static void __exit iolatency_exit(void)
>  {
> -	return blkcg_policy_unregister(&blkcg_policy_iolatency);
> +	blkcg_policy_unregister(&blkcg_policy_iolatency);
>  }
>  
>  module_init(iolatency_init);
> -- 
> 1.8.3.1
