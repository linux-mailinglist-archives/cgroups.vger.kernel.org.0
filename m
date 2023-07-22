Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4F575D88B
	for <lists+cgroups@lfdr.de>; Sat, 22 Jul 2023 03:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGVBON (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jul 2023 21:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjGVBOM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jul 2023 21:14:12 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8CD35B1;
        Fri, 21 Jul 2023 18:14:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68336d06620so2203311b3a.1;
        Fri, 21 Jul 2023 18:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689988451; x=1690593251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ge0BDodPbbi0t2/fQVg7nNuXVsJ2KKE3irKK+lnKz00=;
        b=Q/quBlo055unQKj9s1TErQXtrc0CsCScbBVDQvoDxQ3boCFwjCQle9lI5ltwM2t3AQ
         euLwJmBg9f7hX/2Fq6r9W1zuhtOCZ1T6VYG/A1DGFtI2aLdi0ljIEMnqnGql59s16QpQ
         +/yC+ZO+b1Ffy6CeVNYUOU9ETshZjRvrgAAfK5ZEE/5mRrAJNlju+D1wO8ZlvhuJdnHO
         K+SKwqBbD3/Yh1mXpb1XKP7/4uLzvH7IUydyHMN5F3kObCsKD4bcY7mzNWDSzwsqKcIX
         cRUr27q41tc7EkvoZkGCEqX4nYOGRlbeHp82Ca9apeJzF8KgnClpDa3obP+WYJVHI0ll
         7GhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689988451; x=1690593251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ge0BDodPbbi0t2/fQVg7nNuXVsJ2KKE3irKK+lnKz00=;
        b=kNg+4s6+dPDRy3MvFuqrx6SDQKbGkPOvRqcTfjHLSNKpDsL2IF6Vd3ZPZC/6yX1JD5
         +3W55n72MMimJRn6eBRYXR3j4aiaBMF4ElJa2KGADUQh27TvyKRpIEJRD4wxmkOvkQ6/
         V8BBiv0zW4psfxCalcGPijngNbzaUdDGFip/pBGEEc1gwRJulQaZauul1TcnqpDtDeR1
         EpunVZ5Sv0OjkO0KODIyiYSou45xE8Yl+n+W0aMT/eF5uv8kOtN21y9WxQNzvvwIppMz
         KYhnoGPeKbILcXXXrOGMnyWf8XZuTfV+/IfX6O6xGMxvda9MHh72Q8yHju6U0dEoN3dn
         v2Ow==
X-Gm-Message-State: ABy/qLbN+DIbSTNc/BdVxorpyH6QlI3gXq0OLSdGmXw7u7Hjzn4YYvha
        CMuM3KXqL68nM/sR1QaDKkQ=
X-Google-Smtp-Source: APBJJlEM8VtmMPfrX0tLIxqyOlH1EDvEeJqR/ZAAsVsb5C+p+sVSO05LSklBbfMOmb18iUsXox3gKg==
X-Received: by 2002:a05:6a00:2ea9:b0:666:d78c:33ab with SMTP id fd41-20020a056a002ea900b00666d78c33abmr2512688pfb.21.1689988451333;
        Fri, 21 Jul 2023 18:14:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id c25-20020aa78e19000000b00682c864f35bsm3649807pfr.140.2023.07.21.18.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 18:14:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 21 Jul 2023 15:14:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        amd <amd@localhost.localdomain>
Subject: Re: [PATCH] blk-iocost: fix seq_printf compile type mismatch error
Message-ID: <ZLstYbAzqkqwIRzy@slm.duckdns.org>
References: <20230717141852.153965-1-carlos.bilbao@amd.com>
 <93557f79-c12c-3c3f-2c25-9ba50a618daa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93557f79-c12c-3c3f-2c25-9ba50a618daa@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 21, 2023 at 05:32:04PM -0500, Carlos Bilbao wrote:
> On 7/17/23 9:18 AM, Carlos Bilbao wrote:
> > From: amd <amd@localhost.localdomain>
> > 
> > Fix two type mismatch errors encountered while compiling blk-iocost.c with
> > GCC version 13.1.1 that involved constant operator WEIGHT_ONE. Cast the
> > result of the division operation to (unsigned int) to match the expected
> > format specifier %u in two seq_printf invocations.
> > 
> > Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
> This should have been:
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>

Carlos, can you please retest the current linus#master?

Thanks.

-- 
tejun
