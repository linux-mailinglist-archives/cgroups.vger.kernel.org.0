Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52587614FC2
	for <lists+cgroups@lfdr.de>; Tue,  1 Nov 2022 17:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiKAQyl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Nov 2022 12:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiKAQyi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Nov 2022 12:54:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AB51D0CC
        for <cgroups@vger.kernel.org>; Tue,  1 Nov 2022 09:54:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so13395807pjd.4
        for <cgroups@vger.kernel.org>; Tue, 01 Nov 2022 09:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spsZndBT7leVOWuziIPS4xU0aN+hFOZ8iUUTPETtklA=;
        b=AvcaKX3jDJlPbj+XUFXCw/eNC1XntbhLZOVPgZ+tAFa/w5ylcYNV6PCYWT0S5QF1/o
         8Yyos9IKlZ+YvbCz5y9hBe31IIvFXdv0zsQrC+ECFrZFwYbxp80vbv9p+FZwokqriof5
         pAhCJp7S75lfrFvVwv5RIRYfgAgbuREIePNpRiloRNBcNsUycaU7RbPybIb8VszXADKI
         uVi7nJB1U8sQf6EUJsxS7AkP6G6UIGgQXIWqsz8oNI1xa9/xrPbbG7MbvXlSFcCM5e7e
         DD8+rDC1bisp9MQJqmk4MNMEZ7tWXFVGl1rtq/8XaonFT/SX3Nn6YivWUVdc7s6ocLF3
         g0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spsZndBT7leVOWuziIPS4xU0aN+hFOZ8iUUTPETtklA=;
        b=GwDqmB8BE9cVAsYiDpv/+mfgZNOXrRQfnX1c10TALOrRKovhXwYJtWgJGmHKVAI4+X
         3Xyi+PUPWrCeJYeUJoOgKJ35P5Kp+rkALOktJ79rSnAiF4GLvKNuTpK1PsOgJsl2XFFi
         6fYwhFLY8z3hFu9VXavTK7n3t8GC1kocGbQ067O70mCeYutookMW3gxF5+ZpH9qucMt3
         8ys0ZxJFqhPcrvWiKoS5a3QuCQHYPK8F01S5ACQa8vApOW6QegfCDVooeOpyqdf5qF37
         po9a0z8DpXPD7zYKH4VGCkag1uo/oT1WNiU+zl49CJEFhFPvM3DWcoQ4GuXaysSnb8CY
         ON+w==
X-Gm-Message-State: ACrzQf2S349s+/V42NFejQvXiUawQMHN5aoOpiatHbnhqejiZHnGSvHu
        dw2OzizbGMlIO2J8EO+uZhMCpG8fm0y4wA==
X-Google-Smtp-Source: AMsMyM6N6Yk3Xf7v6MnN6c4CX+aivv/CvZblaV5x1T2mYeLG2/OvRUioP2me5rpdbYgBZOGzJvrPpQ==
X-Received: by 2002:a17:903:1d1:b0:187:3f0b:af76 with SMTP id e17-20020a17090301d100b001873f0baf76mr1835310plh.145.1667321677459;
        Tue, 01 Nov 2022 09:54:37 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902e74100b001784a45511asm6612904plf.79.2022.11.01.09.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 09:54:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 1 Nov 2022 06:54:34 -1000
From:   "tj@kernel.org" <tj@kernel.org>
To:     "Accardi, Kristen C" <kristen.c.accardi@intel.com>
Cc:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: clarification about misc controller and capacity vs. max
Message-ID: <Y2FPSqOaQGnISvXu@slm.duckdns.org>
References: <2f7b7d6b10bdcbc9a73ea449d3636575124afa25.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f7b7d6b10bdcbc9a73ea449d3636575124afa25.camel@intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Nov 01, 2022 at 04:40:22PM +0000, Accardi, Kristen C wrote:
> I notice in the comments for the misc controller it is stated that the
> max limit can be more than actual total capacity, meaning that we can
> overcommit with the resource controlled by the misc controller.
> However, in the misc_cg_try_charge() code, the function will return -
> EBUSY if max limit will be crossed or total usage will be more than the
> capacity, which would seem to enforce total capacity as an upper limit
> in addition to max and not allow for overcommit. Can you provide some
> clarity on whether the resource consumption model for the misc
> controller should allow for overcommit?

I think what it's trying to say is that the sum of first level .max's can be
higher than the total capacity. e.g. Let's say you have 5 of this resource
and a hierarchy like the following.

        R - A - A'
          + B - B'
          \ C

It's valid to have A, B, C's max set to 4, 3, 2 respectively even if they
sum up to 9 which is larger than what's available in the system, 5 - ie. the
max limits are overcommitted for the resource.

Thanks.

-- 
tejun
