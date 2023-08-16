Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2936E77EB08
	for <lists+cgroups@lfdr.de>; Wed, 16 Aug 2023 22:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346268AbjHPUvj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Aug 2023 16:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346272AbjHPUvQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Aug 2023 16:51:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7E01BE6;
        Wed, 16 Aug 2023 13:51:15 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26b4cf4f7b9so2376817a91.1;
        Wed, 16 Aug 2023 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692219075; x=1692823875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/36aw1xmDrnWgBaeP2BLSKHpeS0jtx76RKcl679jDEk=;
        b=mlDFmkAWIAw706A5Q/2UucACgJXVkzTw8eFJOQn88+CxlaPt4SaCnnTRx27vUUv7cB
         Zze96Ru+A+82vcL4rlMlApTPMi+tbSLnFJIFH+vPsFy1dVKvGjbBn0Phe+M+9RX1fnvK
         uddcN27TPeQWvy1yrDfLBjAMooFbkrYoIW8RNE5HvigZhpXIVsFLiclGGN6w2s/qtpVu
         bAMiDg9eO/YNn1twwpJs+i9ieBOkRI2PBc4vyJSaw2jmNcUSDWXmPBi6UliFZ69NSjLe
         /Wu324aj48ZsND83y52LwIU42qOiUNlYAngPwqS/fkFFAnrMsqbDCf3BFIWFensD2oi5
         VN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692219075; x=1692823875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/36aw1xmDrnWgBaeP2BLSKHpeS0jtx76RKcl679jDEk=;
        b=UO6Nbc/oYYcpyiyCQkFIqJxU9zaxy39n2QATK7EbTBsAWgcYFglcumCQQNOzhQbcXx
         wn0TU/MajWgktPm16yBiqa26PCNcfyN5bH9yIA8MtdGDKKxEuRzqHCPppqx7hxtgANYn
         +yOJR1kLp9gafsWhfURsXOhF7ejbo7LUbQW57rMhr7KJyWGhoCyLB9c+TZjj2FjkamC8
         7mAUnX+9hDbGpg66nL/OqwVB5QpeFpc2z4BPX+85CyJTTtzYRTqqB62ZN8vimYSi4LwY
         l5V3+GHgSISC54OA6CO9yoLk8CWStJXsGBkhKyfJ1mVsres+EbW52SG8wtWixu3/cRif
         glXA==
X-Gm-Message-State: AOJu0Yw2dxKQIQ/+zU4tLXbpQzk0/uiAzZoXFb/Zedjkr6u+7s4fHqfc
        FB2utLAuE2PmYsbL/LNcpH8=
X-Google-Smtp-Source: AGHT+IH6RRSnxIiIpBLIFNY2G3iT+tDaGfu5cKJmIyOKRP68LL2kjCEw3UMmAp1y9w1z/eTcBHh3kg==
X-Received: by 2002:a17:90a:4a88:b0:267:f8a2:300a with SMTP id f8-20020a17090a4a8800b00267f8a2300amr2351459pjh.7.1692219074627;
        Wed, 16 Aug 2023 13:51:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:93bd])
        by smtp.gmail.com with ESMTPSA id bo24-20020a17090b091800b00262d6ac0140sm154473pjb.9.2023.08.16.13.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:51:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Aug 2023 10:51:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] cgroup: Avoid -Wstringop-overflow warnings
Message-ID: <ZN02wFqzvwP2JI-K@slm.duckdns.org>
References: <ZN02iLcZYgxHFrEN@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN02iLcZYgxHFrEN@work>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Aug 16, 2023 at 02:50:16PM -0600, Gustavo A. R. Silva wrote:
> Change the notation from pointer-to-array to pointer-to-pointer.
> With this, we avoid the compiler complaining about trying
> to access a region of size zero as an argument during function
> calls.

Haha, I thought the functions were actually accessing the memory. This can't
be an intended behavior on the compiler's side, right?

Thanks.

-- 
tejun
