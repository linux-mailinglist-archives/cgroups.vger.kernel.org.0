Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A7C73755E
	for <lists+cgroups@lfdr.de>; Tue, 20 Jun 2023 21:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjFTTvI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Jun 2023 15:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjFTTvG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Jun 2023 15:51:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0331D1710
        for <cgroups@vger.kernel.org>; Tue, 20 Jun 2023 12:51:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666683eb028so2940636b3a.0
        for <cgroups@vger.kernel.org>; Tue, 20 Jun 2023 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687290665; x=1689882665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fEQfxADvgSzjQCfBomhgDaEgGtqyU75um/V6Dxu05cc=;
        b=bYg+oupnLPHq6deMXlRsxgjqDTrfbi7ADGIUtbQfBQXgJObZaO/KjayEbPgKT45RRz
         icYzOrlCbPuoaZu8Xl+6oXqqOBi/yyNQJ8SwgCBgJUredayRBaNxkcYKZygJDu16iCwy
         OMnbMkyBU6X4YOPCSK3RdowMxqqtNjyQ0QM8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290665; x=1689882665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEQfxADvgSzjQCfBomhgDaEgGtqyU75um/V6Dxu05cc=;
        b=TWjiwQR3C7D14phh+vUbfdla+OHXJIcytyrdRa7S/Cv+ToyUFxhMPQomvMR0CzFqh4
         tckvP1N85yae2bbWq7fQl2/0t/hH2nTXNqwJke70rStJcZAGASv+OLiM/LwtvgF+mu+p
         OKNCIJImVfNGHn9ODQiueYUMHgR8gc+w+Leg4Y0Jp3WtKedxe+eF79uTrY0PgLiQHrDW
         ZJ18jbgVjtokYorhxe3+GfLyulBykwRECB8ZkdeyxQ9yFFMaWphD2IYHNkD8VdhD/EFb
         wu3JaGxw6HKW26yWkLXgheMU1ifLtuNGtCMaTk8fFe4oM6WBzaifLDg11TJBU3QcLZN7
         ewgw==
X-Gm-Message-State: AC+VfDytlqOFhYxkFFKUeP/9tRUbJCajyB0wUnJuvZTyludrd+/6vtcY
        Pf+axE9YIW2oOrDSmDfFQapdLA==
X-Google-Smtp-Source: ACHHUZ4TimNUxg4QuYmqqw/d7bpUNnlZ+a7/HOjhOBUmPcWtRzW9sHMHAQboQezXlCCQItZp438xZg==
X-Received: by 2002:a05:6a00:1913:b0:668:7292:b2c2 with SMTP id y19-20020a056a00191300b006687292b2c2mr5636126pfi.2.1687290665523;
        Tue, 20 Jun 2023 12:51:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fe10-20020a056a002f0a00b0064f95bc04d3sm1655296pfb.20.2023.06.20.12.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:51:04 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:51:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] cgroup: Avoid -Wstringop-overflow warnings
Message-ID: <202306201250.6FA10ADF4@keescook>
References: <ZIpm3pcs3iCP9UaR@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIpm3pcs3iCP9UaR@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 14, 2023 at 07:18:22PM -0600, Gustavo A. R. Silva wrote:
> Address the following -Wstringop-overflow warnings seen when
> built with ARM architecture and aspeed_g4_defconfig configuration
> (notice that under this configuration CGROUP_SUBSYS_COUNT == 0):
> kernel/cgroup/cgroup.c:1208:16: warning: 'find_existing_css_set' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:1258:15: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:6089:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:6153:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> 
> These changes are based on commit d20d30ebb199 ("cgroup: Avoid compiler
> warnings with no subsystems").
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Ah nice, this should reduce code size for the "0" case too.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
