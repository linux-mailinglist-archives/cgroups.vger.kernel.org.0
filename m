Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0866D5A30D3
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 23:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiHZVLa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Aug 2022 17:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHZVL3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Aug 2022 17:11:29 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EF1E3C35
        for <cgroups@vger.kernel.org>; Fri, 26 Aug 2022 14:11:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q63so2419765pga.9
        for <cgroups@vger.kernel.org>; Fri, 26 Aug 2022 14:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=NpDbARr9FROHsdpoRBEwA2TKj43VTAHXK/2AaJuQG0g=;
        b=HtOUvCv9/08/l1KV+VqsvseEILn8PnCzF6Cal0b/r8xNG9a2TVjbY2M5FQT1M1dj7L
         /jdcLjrPz29B+T5L6C8sUgz2u12B6VgF8kxHJUL62iZLT6RnELhDi3l42qNG0thuOjm1
         DWXhHMo6+xTL07u4I36LWvWWypm2iq68AwT7tgkeB7tul8WfiG9aGIyG25Jr2BMSkFUT
         lamFyfd1/E+dge2NllS8Z2dqXSygCGJYbYb3jvyGLJb5TFHwwnjOeJ8mgda7zXoqQ373
         9UOBVfKceRN2tYMyCaXMDka/hCBrwt3frnchZ1wLASopQ5lOxutylvRy9z04zmJj0h0R
         DXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=NpDbARr9FROHsdpoRBEwA2TKj43VTAHXK/2AaJuQG0g=;
        b=aNocvpJ+eUgoiQQaA2dkDLqIvXfQLQXRTWghh2suZbTKUULDqBE02/yWYXI8htZSzw
         8Ltvg5Tc6Q5hKSkjIidlEmKi6AeR8jTDYL+eEAzIwjDarh/rSrSg7MnKE6rI5pMyHvsG
         b9Fu2W84rdPRQf6E1HHpJeRILw1BpBgqGwggGOdnX7v5xKCTGDCwbr/5cF2leTnOut/0
         2kSJbczHR5lF4/BEOtjzuy9VK9ZPZAL3fE5KB/T9PteNamPfk8u80rDJh9R2g7sduu85
         jbrKezgrJiJBGg9Ox5WSngfbs8RFMO79LaiqDQnHKh6PHYvMnKUUMLfYpSETNUGiZ6oE
         IMPA==
X-Gm-Message-State: ACgBeo1iK62bMutNk9At8H4ACax2mhaHiPiwJ2yg59FSVXgiWH29L/+t
        rGKqHVWiwai7Eqe2sqi41M0=
X-Google-Smtp-Source: AA6agR6h1w3Shd+Ipkwit6iD+imcSIoiMSoFMWLLMCZvCmlewfOArAXM37bjtQ6InOy5ZTihKfmyCQ==
X-Received: by 2002:a63:2a95:0:b0:41a:27e5:1996 with SMTP id q143-20020a632a95000000b0041a27e51996mr4644167pgq.447.1661548284728;
        Fri, 26 Aug 2022 14:11:24 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79d03000000b00537d4a3aec9sm1472411pfp.104.2022.08.26.14.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 14:11:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 26 Aug 2022 11:11:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chris Murphy <chris@colorremedies.com>
Cc:     Chris Murphy <lists@colorremedies.com>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: oomd with 6.0-rc1 has ridiculously high memory pressure stats wit
Message-ID: <Ywk2+wKGu9NS/EbE@slm.duckdns.org>
References: <d0df567c-1f6a-418d-8db7-3f777bd109c8@www.fastmail.com>
 <YwUcGvE/rhHEZ+KO@slm.duckdns.org>
 <9412f39b-9ec1-4542-944c-19577a358b97@www.fastmail.com>
 <0a6105f9-012a-4b75-b741-6549d7e169d8@www.fastmail.com>
 <YwU0mLBMuxpZ7Zwq@slm.duckdns.org>
 <f354bbb3-6619-4ab0-b0fb-a0098ffb0205@www.fastmail.com>
 <a7a96563-fd07-4970-8c25-f0784c83c915@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a96563-fd07-4970-8c25-f0784c83c915@www.fastmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 26, 2022 at 08:06:15AM -0400, Chris Murphy wrote:
> Patch has been in Rawhide without any failures, consider it fixed. Thanks!

Upstream fix is 2b97cf76289a ("Hao Jia <jiahao.os@bytedance.com>") which was
already sitting in my queue by the time you reported the problem. -rc3
should have it fixed. I should have pushed that out earlier. Sorry about
that.

Thanks.

-- 
tejun
