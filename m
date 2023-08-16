Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4F777E995
	for <lists+cgroups@lfdr.de>; Wed, 16 Aug 2023 21:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345783AbjHPTWs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Aug 2023 15:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345806AbjHPTWX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Aug 2023 15:22:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47404271F;
        Wed, 16 Aug 2023 12:22:22 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-688142a392eso5573852b3a.3;
        Wed, 16 Aug 2023 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692213742; x=1692818542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yZbEgk5hOBil+6p82DAQcLxcHtlq0Gk/Obtt+1CIrw=;
        b=qKSP52F+/sORslglDOq8VwHya86yPq+jVHh3l/OsdYKeo4vmi0NSnR95HGEjuWXqLJ
         vr+8+ubITXS7B53tEYaJfBvd88MJ3ox9vuhn7NMOkuEVQBdDyBn9xLXZ1xWX/IsurP0V
         sz+nsf2GvYQT8vpOSaKmeNmET5kBzjDty1W2qJ75ob3XR94whTAdJyUzFRL1KbsIr2mS
         zaS+ywl5LBZhindR24QiUrLFEkNzAvUzrI/ezLNYnazWqfs12Q+wSQRHrLikf97SdHp7
         N1pnzml45IvN6LMVOM44PScABbAiPp+zdHCY6iF4KiGmbSmyTmOuMHGdhY/XIJbg4i+e
         q57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692213742; x=1692818542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6yZbEgk5hOBil+6p82DAQcLxcHtlq0Gk/Obtt+1CIrw=;
        b=EdwAWJyD32FB9lOTSs00ickU1CnpubleTvogfZcNXvxDmzXWGKDYqIIt783JdfQfhw
         h1qc7OVkmB26O8VMmxRjbOEx3Q9iZALtIaS69STr1ADJqOUbP1hUW2Os7M46i7k2H0XB
         KdgMQATeqOFLs0vEPTuifD9TGAPIGiweJQNHOmzHdbgITNjH7fxB0Z/8w6osFMLAtkIC
         MT63RbXxwQD8uFNUhKWZOaux6xBmjaCdD3TgClM5QRVcNYWuhj1q90BC3tNvsKe25ehY
         ke1Zi8TeqXL2/5IdKyqxwf21hIBYTHm8nvJh17CMglEL15aMGj0nslE9wdA5QLtnmrKn
         H8EA==
X-Gm-Message-State: AOJu0YwB0XKkpLVU12jkJNjxj5q28FZmXIZVk8QZkcOoPvqkZCg3OOpq
        zTBdgBu45YxaWTF2St+tMTY=
X-Google-Smtp-Source: AGHT+IGYsKXAf+mXo898/kcV1a692ldkmT7Wsj6wlxzGZYBnwBEB140UGbXomi0XKYNNFiiyf7jBDw==
X-Received: by 2002:a05:6a00:180d:b0:67e:45ab:b86b with SMTP id y13-20020a056a00180d00b0067e45abb86bmr3618148pfa.28.1692213741578;
        Wed, 16 Aug 2023 12:22:21 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:93bd])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7808b000000b0065da94fe917sm11382280pff.36.2023.08.16.12.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 12:22:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Aug 2023 09:22:19 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] cgroup: Avoid -Wstringop-overflow warnings
Message-ID: <ZN0h69grtuh2Iv8e@slm.duckdns.org>
References: <ZIpm3pcs3iCP9UaR@work>
 <e1c07dd0-e6bf-ca9c-107a-97c5043b1bc7@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c07dd0-e6bf-ca9c-107a-97c5043b1bc7@embeddedor.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 15, 2023 at 01:04:32PM -0600, Gustavo A. R. Silva wrote:
> Hi all,
> 
> I wonder if you have any suggestions on how to address this issue. As it seems that
> my last attempt caused some boot failures[1][2].
> 
> At first, I thought that the right way to fix this was through a similar fix as this
> one[3]. But it seems I'm missing something else that I cannot determine yet.
> 
> These -Wstringop-overflow warnings are mostly the last ones remaining before we can
> finally enable this compiler option, globally.
> 
> Any help or advice on how to properly address this is greatly appreciated. :)

It looks like there are only two functions which misbehave when there are no
controllers configured. Maybe just fix them so that they don't access empty
array?

Thanks.

-- 
tejun
