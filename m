Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D7F54C1B7
	for <lists+cgroups@lfdr.de>; Wed, 15 Jun 2022 08:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbiFOGVS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Jun 2022 02:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiFOGVR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Jun 2022 02:21:17 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F6B220C5;
        Tue, 14 Jun 2022 23:21:16 -0700 (PDT)
Subject: Re: [PATCH] block: update comment for blkcg_init_queue
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655274074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+BrZJXhMDum/6TJS5sDJvhBvlhj3O3wcmdCRorhGJw=;
        b=q+doxS9i9J+cKS1j+UR1+qnyyCNL/d67EeHR9UaA1PWBpc9S4MAzN5aYWECzG66h0Se49T
        XVxKr98PGSU0mgQp2isWfh4MDdMeCg1yaFAG0bN1aSp8d9Uo/Gbm28C5qH5jMw9xYfN1vD
        /Le4qjIl1j17nYUAoVUpk1aIsD12u2g=
To:     Christoph Hellwig <hch@infradead.org>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20220614100556.20899-1-guoqing.jiang@linux.dev>
 <Yql5wrthJvZDwWjq@infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <01f643e5-fb5e-66fd-7bf9-937738bf306d@linux.dev>
Date:   Wed, 15 Jun 2022 14:21:09 +0800
MIME-Version: 1.0
In-Reply-To: <Yql5wrthJvZDwWjq@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 6/15/22 2:18 PM, Christoph Hellwig wrote:
> On Tue, Jun 14, 2022 at 06:05:56PM +0800, Guoqing Jiang wrote:
>> It was called from __alloc_disk_node since commit 1059699f87eb ("block:
>> move blkcg initialization/destroy into disk allocation/release handler).
>> Let's change the comment accordingly.
> Well, the right things is to simply drop this comment.  I do have
> a large series toucing it and removing it, so maybe we can wait
> until that?

Sure, I am fine with it.

Thanks,
Guoqing
