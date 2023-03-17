Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765BE6BF4FB
	for <lists+cgroups@lfdr.de>; Fri, 17 Mar 2023 23:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCQWUi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Mar 2023 18:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCQWUh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Mar 2023 18:20:37 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C95051CAC;
        Fri, 17 Mar 2023 15:20:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so6741925pjz.1;
        Fri, 17 Mar 2023 15:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679091636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86HCB7S150EkF3xf7sNbiXNVW2Gd/6ux0I4CN70WrJw=;
        b=av/HdkRFs1UjV/iFhDAs7Ba1VDfC1Vt0wim9zm6HUxebjUmjjqT4gp+O8YpsvVUSkN
         iSXCT7rt/BiHxAIs3EKCk+cM741/H7ghJUwVcl8t3t9pZ8YA8nIQWS+wA4gXokp4hHrQ
         BKYp8sA+TCvvPqXE6+lbX4BaOULl914oS6zCmx0caJ5oDQmTl9lysUu4vEBb0Wwlgwbr
         huMjjx+8y8ZPIL9kFOtcBX2sa+k7YZFhQBuQsEhEuYHEL/7QC6Y8w5pURAXKIqPco5Tz
         UR7YpmofoMf9Hgy4vLsCQG5iJa6fQlNlE6M2Q0zbrsMxlglWw4roBJsokhH1GiFk5EWo
         SBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679091636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86HCB7S150EkF3xf7sNbiXNVW2Gd/6ux0I4CN70WrJw=;
        b=UEc1+lnhrBaSnizKLc4ftsiiUTB9gdo+CuVKSSa8h/n0m548L5SsZd+nuDdqWcntSB
         9coNSilNUzUS71IIpIk5FFU20EX1sQSiVUgMiNSHYM2Hk3sASQo8Nu+6U90W3r0Qs1Yf
         UVzK1QrMdUSze0JGoxYRp+VcyGCj2aur6fAHKLr/teAwt6CpjgU97Z9q4kWTdfCmVpBg
         JcTZ2DNOKAUhGHnaL/V3wyVFfd5BZ7qePrAc1q/sYg4MQ3XRc8da8XG7oa90LaA+N1nQ
         ElI6qCtUWQKczA59LMqHkAhSxqFrPWq6B2a0TadXKGHZ8HFuQvty8r6mnS91zMv+DcNI
         D3xQ==
X-Gm-Message-State: AO0yUKUTCEU2bL69qbYglaQNE+nhFOjQev1EoTclLZcnMBSLBeyAk/lL
        nSqWYvTZ4IJctYG3Cakyxs0=
X-Google-Smtp-Source: AK7set/DuRLqEmI9BFX0Y17p5gFwc85bl3rxEH9xeY2qW1W0f4TWc0elGXhhUXNZZkWb5ygLYWiHwg==
X-Received: by 2002:a17:903:32ce:b0:1a0:67b1:a777 with SMTP id i14-20020a17090332ce00b001a067b1a777mr9794678plr.61.1679091635719;
        Fri, 17 Mar 2023 15:20:35 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902c1cd00b0019aa8149cc9sm2014891plc.35.2023.03.17.15.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 15:20:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 17 Mar 2023 12:20:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: fix display of forceidle time at root
Message-ID: <ZBTnsp43Ntxl0Tns@slm.duckdns.org>
References: <20230315214029.899573-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315214029.899573-1-joshdon@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 15, 2023 at 02:40:29PM -0700, Josh Don wrote:
> We need to reset forceidle_sum to 0 when reading from root, since the
> bstat we accumulate into is stack allocated.
> 
> To make this more robust, just replace the existing cputime reset with a
> memset of the overall bstat.
> 
> Signed-off-by: Josh Don <joshdon@google.com>

Applied to cgroup/for-6.3-fixes w/ Fixes tag added and stable cc'd.

Thanks.

-- 
tejun
