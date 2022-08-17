Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C025974E6
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 19:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiHQRRH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Aug 2022 13:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiHQRRG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Aug 2022 13:17:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F5798CAC
        for <cgroups@vger.kernel.org>; Wed, 17 Aug 2022 10:17:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0772AB81E7D
        for <cgroups@vger.kernel.org>; Wed, 17 Aug 2022 17:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658CEC433C1;
        Wed, 17 Aug 2022 17:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660756622;
        bh=sW2vlMqA2/k4m+CqkD1Vg77XK6jsg6cOZAQ48jZAEO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZlumYuQX50WUifM8caT+mwnMVMdFTD+KKJBFBKSJ3IsTjf34CnZSzncE+xBuPGahC
         Tc1J2GaYoN2BbSDjpm3OC6uBY+V2aXmteyfjnUK/mhhNR5Qzfc+cji4C0GfYtdHdai
         rpTbb0iIH68t+kyo1aupJ8A3E6AvpNZRtfJRUVoc=
Date:   Wed, 17 Aug 2022 10:17:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     liliguang <liliguang@baidu.com>, cgroups@vger.kernel.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, linux-mm@kvack.org
Subject: Re: [PATCH] mm: correctly charge compressed memory to its memcg
Message-Id: <20220817101701.149fff9ef57f447dd8bb0dc9@linux-foundation.org>
In-Reply-To: <YvpkK8fwCEPGmif+@cmpxchg.org>
References: <20220811081913.102770-1-liliguang@baidu.com>
        <YvpkK8fwCEPGmif+@cmpxchg.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 15 Aug 2022 11:20:11 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> Great catch. I think this qualifies for stable.
> 
> Cc: stable@vger.kernel.org # 5.19
> Fixes: f4840ccfca25 ("zswap: memcg accounting")
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Andrew, can you please take this through the MM tree?

Sure, but I'm not subscribed to cgroups@ and it wasn't cc'ed to
linux-kernel so no patch for me.

I could reconstitute it from the quoted patch but that's a bit lame and
we don't get a usable Link: tag.

So please redo, refresh, retest and resend?
