Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0035E87C2
	for <lists+cgroups@lfdr.de>; Sat, 24 Sep 2022 04:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiIXCxJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 22:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiIXCwu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 22:52:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CEA1401B6;
        Fri, 23 Sep 2022 19:52:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d10so637292pfh.6;
        Fri, 23 Sep 2022 19:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=P8vaI21b92NWGEjpnCZy/ODfb54d6FrqhksNG5cepIM=;
        b=caLduk/X8w4TnrVwSePAZCEH+FzRhkWjC4M0DPcbbDsa5BILOuhtNcXGd8A3oh66UR
         lriiKxLvcTpSIy3D7eh0T2sQzbH3DgktH3gfWckNZn+hkFuNO2zPI6iqQlh0P/h5R0yU
         R7Ahpl/xjHazmSLed2t/OvNlLchNTmnymyQuuy5N3EMhG0dJ7tbCkosPH5/jrMuAVSbU
         doGSVQjEm/Pe1RlEFPg2mZYTAwosPvOW3KPWLP7JY66NdTuGuAQPjap4ie2VbxhmW+N1
         EX9y7Ha/HGTltUUoM6yrSCxi8vNKpcT84nl6N/oVoMSIVhdYdB9VupgIZ5F6W2ZX5dby
         IW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=P8vaI21b92NWGEjpnCZy/ODfb54d6FrqhksNG5cepIM=;
        b=K9JlRblKtfF0Ot0R3ck8bEnNR23nyk6JfGohTv+cQ29z+puOE8VU9dpqQHvxp7ycWZ
         srN07R35wUbdmr3y2M9Jl+ioU8KSr0COOJv2/2IP0xalCdEdeZSC/IXXmy9iZB67VG7f
         OwHceBOa80MHu07GP/8cCO+4fd/fsfazevmCHAAwpq0cJL/NWBplDSaQpyBM9u2sA6WL
         ghcKBcEMCI/0B2Vn9+BQmYdB7ZJweJHARp0S3GYLsxuhloaaW4G6rsJ68lYfcmnfV8DY
         1YBgay/VoZSDVSFmWcj9ftLFZwSgTwnLbMfn6ZLegb0IHYmwBJE3MzDYLw3acCwxZS3k
         moAg==
X-Gm-Message-State: ACrzQf0Hj3sw5N/IJLi7qr4DWEFbZfQnptWrDdf1Z647VABoYbRPTnAE
        KMfOc9NR0oFevwggb6NszOo=
X-Google-Smtp-Source: AMsMyM73X9SwgU7Ji9ZeLmVqmwAFGfH3m2Y91JsApW2XQ9bXHlKHeDOdWU7GNItQJbygDa5tjePLHg==
X-Received: by 2002:a63:4918:0:b0:439:1802:dda3 with SMTP id w24-20020a634918000000b004391802dda3mr10015022pga.467.1663987958803;
        Fri, 23 Sep 2022 19:52:38 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z11-20020a170903018b00b0016bf5557690sm6627633plg.4.2022.09.23.19.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 19:52:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 23 Sep 2022 16:52:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     williamsukatube@163.com
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup: simplify code in cgroup_apply_control
Message-ID: <Yy5w9YFfmZX+9Vq+@slm.duckdns.org>
References: <20220917084039.3177-1-williamsukatube@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917084039.3177-1-williamsukatube@163.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Sep 17, 2022 at 04:40:39PM +0800, williamsukatube@163.com wrote:
> From: William Dean <williamsukatube@163.com>
> 
> It could directly return 'cgroup_update_dfl_csses' to simplify code.
> 
> Signed-off-by: William Dean <williamsukatube@163.com>

Applied to cgroup/for-6.1.

Thanks.

-- 
tejun
