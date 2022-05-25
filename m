Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0C7533C24
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 13:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiEYL7Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 07:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiEYL7P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 07:59:15 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D926554
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 04:59:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gk22so1065349pjb.1
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bBzKMMaiGL+EGEsjuc4MBX5f/qXIyEgcNNQtA6G0IvA=;
        b=W7qA8nhtY4E/Qs4zv/J+F2PtRVpVlxLTKZVl2y60rx5UXgTH2ir4JJQ4cbSwj/ka4Z
         rO3CyrijViPOhV/36HeqmSVxnym2O37IK10d0zhVBpBzZHKacaXQx1+fndmIU+betlvC
         iw6iu8+QfLGop+S1pacmy1CzRbKaSavv6qIFG+iLzCi0XSIRqXbUP+gXyGp+lVF+z14F
         36mEXTSjCD48u0oeV8RJ8CZcOVFWI6ZF3GLUHy9XoSh8gGflwQ04Uzb8TH2aqfQtcVHZ
         VpUMdEQbdzBoZSc/35me/V6E0Lm1H1LFQFBqhXSgfPRuNT5CutAP7Z35vIBGkL+FLptM
         UD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bBzKMMaiGL+EGEsjuc4MBX5f/qXIyEgcNNQtA6G0IvA=;
        b=Uxr1NvPLtqIVcTLlB2H2d0Bc4wknI/r4REE07UamkUSDYndbCKMW/GKDjl7AJcnGQo
         jXsNKd8bp7aKlHb+Ob+jiPMScGetozGwQIlL2lZ/3gYC+AveFoQ5Tc1Y59gTpTxFdDn/
         jLCgcObYP7xiV0m4elACP0q2uHMjvDYzhKVkdQJ4s4dAuKqsDURjNaX5E9jAmxWbnQDr
         gsP2WApJiF5baXXU73kv2HqN639u5zAT6KrLFYR7pw32S1ttt4/rv0Y1ZVYULDqaNojO
         6VHD3mqnM1gWDFdnfIkkTiKBCR1mLGppl83iVBcAKf3F02CuUZAQTUzW8/yDtt8Nclw4
         //ZA==
X-Gm-Message-State: AOAM530uIwRAuqWnJyk7aLVA8QD4cfHq+GoSwPMZlimYuWB9oOusDt9U
        ZakqM5WhrnRQCS0wWdoTwXerjg==
X-Google-Smtp-Source: ABdhPJxeRiRhJV7jRC/kDWa0f137Mc2dpQgBTgEXJ4ruDmxrqVeRSF0WsLz70rU8W/p4GmkxSZaWfw==
X-Received: by 2002:a17:90a:1b4a:b0:1e0:a104:b730 with SMTP id q68-20020a17090a1b4a00b001e0a104b730mr4353940pjq.160.1653479954347;
        Wed, 25 May 2022 04:59:14 -0700 (PDT)
Received: from localhost ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090a4a0f00b001cd4989fed3sm1424770pjh.31.2022.05.25.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:59:13 -0700 (PDT)
Date:   Wed, 25 May 2022 19:59:09 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 10/11] mm: lru: add VM_BUG_ON_FOLIO to lru maintenance
 function
Message-ID: <Yo4aDaiADXqFnbk8@FVFYT0MHHV2J.usts.net>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-11-songmuchun@bytedance.com>
 <Yo01ghDEu4KcYKpH@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo01ghDEu4KcYKpH@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 03:44:02PM -0400, Johannes Weiner wrote:
> On Tue, May 24, 2022 at 02:05:50PM +0800, Muchun Song wrote:
> > We need to make sure that the page is deleted from or added to the
> > correct lruvec list. So add a VM_BUG_ON_FOLIO() to catch invalid
> > users.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Makes sense, but please use VM_WARN_ON_ONCE_FOLIO() so the machine can
> continue limping along for extracting debug information.
>

Make sense. Will do.

Thanks. 
