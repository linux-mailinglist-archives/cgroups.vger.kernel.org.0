Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A65027D1DA
	for <lists+cgroups@lfdr.de>; Tue, 29 Sep 2020 16:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgI2Owk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Sep 2020 10:52:40 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:51481 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728627AbgI2Owk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Sep 2020 10:52:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UAUcfiw_1601391152;
Received: from 30.39.52.131(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UAUcfiw_1601391152)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 29 Sep 2020 22:52:33 +0800
Subject: Re: [PATCH 0/4] Some improvements for blk throttle
To:     tj@kernel.org, axboe@kernel.dk
Cc:     baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1600592693.git.baolin.wang@linux.alibaba.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <cd26d036-c827-e120-df37-1da81619180f@linux.alibaba.com>
Date:   Tue, 29 Sep 2020 22:52:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.0
MIME-Version: 1.0
In-Reply-To: <cover.1600592693.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Jens,

> Hi,
> 
> This patch set did some improvements for blk throttle, please
> help to review. Thanks.

Do you have any comments for this patch set? Thanks.

> 
> Baolin Wang (4):
>    blk-throttle: Remove a meaningless parameter for
>      throtl_downgrade_state()
>    blk-throttle: Avoid getting the current time if tg->last_finish_time
>      is 0
>    blk-throttle: Avoid tracking latency if low limit is invalid
>    blk-throttle: Fix IO hang for a corner case
> 
>   block/blk-throttle.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> 
