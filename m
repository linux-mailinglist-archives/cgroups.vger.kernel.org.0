Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA52723421
	for <lists+cgroups@lfdr.de>; Tue,  6 Jun 2023 02:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjFFArh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jun 2023 20:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFFArh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Jun 2023 20:47:37 -0400
X-Greylist: delayed 513 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 17:47:36 PDT
Received: from out-10.mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6D4EA
        for <cgroups@vger.kernel.org>; Mon,  5 Jun 2023 17:47:36 -0700 (PDT)
Date:   Mon, 5 Jun 2023 17:38:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686011941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wiA42FcF9ikOR9ipiQl1i9SylwuyTjOy9LZNowrvTpM=;
        b=c2dnv750fpyzxYhsZ/yrFxW36Mu77iGdVzXfc59DqER1yh3PAam00+nKZEYOO+bB53KRHx
        +eLR5X5VjFziDARZI5AhkoruPoVGFGIb3YuBaMOaHazPQuQoNMUNsrJU7LtmRaA59d4NZz
        s0ich55Oa69wIAW53MSCXyLteIwCWZs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: use helper macro FLUSH_TIME
Message-ID: <ZH6AIdfebveDeeIL@P9FQF9L96D>
References: <20230603072116.1101690-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603072116.1101690-1-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jun 03, 2023 at 03:21:16PM +0800, Miaohe Lin wrote:
> Use helper macro FLUSH_TIME to indicate the flush time to improve the
> readability a bit. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
