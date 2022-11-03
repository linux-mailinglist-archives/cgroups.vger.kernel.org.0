Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D83617436
	for <lists+cgroups@lfdr.de>; Thu,  3 Nov 2022 03:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKCCbh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Nov 2022 22:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKCCbg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Nov 2022 22:31:36 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79E1CCA;
        Wed,  2 Nov 2022 19:31:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso3939139pjc.0;
        Wed, 02 Nov 2022 19:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWur7HMVd8Ke8GikOufYnkHwwFXOwHuL2p1d2EaRZQ4=;
        b=LHg0QvuIyTZaP2L3VKH46Q9HpSocgocqW64wr5w9rN7A1/45tQRuzDepB3CuHT0ewX
         rf5d45xvbFIIurHHUmIN783brPGJl/6JAIj9Vqtmb+f/i+2TSwFnRwe6vvhdHvkdVDdg
         fsUyyhAM43SrXN5uTLLssApnXPbw+YhBQhSKdhD6faQG8mwhlJUNjvBjNXch7g0O3/yA
         W+EZ+Vu6dwPlKBhGkJDOidgUKpCnwNfuAp3Jgh35C6rCVO8NY4GW1PRi3dCgI39VP3DR
         OrFLnuaW1R2a24OoNBABG+uQqHtxZkBN6EwP0zq+SuvGQqgor/p446gJtzbBjOJCHVIs
         RdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWur7HMVd8Ke8GikOufYnkHwwFXOwHuL2p1d2EaRZQ4=;
        b=p3wJe+gE8sI0e7DWW/wiLeX2Txr8ob2EpIkgiGz2P/7vVYAyZshFU4YIdHr2btlPE4
         PfFQsDsrbu+M4nezGhWLKz/P8Hmq+VREeLkBB+FlGLxOkMKUMCiU3k81FKW4a5HQjO3U
         5D0OVYugO2hA74e8RcgYlcua1a11WLLPZ228fWnbLimC6NxRLh/yUN53RJuYX8LR7deE
         6Z/wcalE6+k520oBIFL2KE5ctYpmmQECCDjoyNgztBXCDobKVDuoKfEnmUJxuIzpjMYb
         J0SqQOC65aPowYomNXRXdkiPP8WuLb2eqdCSz+glIQZC6ZFDm7/OunXmS2xbuvgy9PRj
         Q5XQ==
X-Gm-Message-State: ACrzQf2Hlya0606dEcq0KHpIMIZqJcPz+jYPMCydS9kcTHnVa+Ty/pP8
        mNhSEWeNVPp5vLs9y9zU/00=
X-Google-Smtp-Source: AMsMyM5Bk7ipWNRGqH2CUxQVlGb+fIzltpqkUGvhDMvQRPiQtlVOJd8FJYSwMxSn+YOWZ5T85LZNIQ==
X-Received: by 2002:a17:90a:311:b0:214:143b:c7ab with SMTP id 17-20020a17090a031100b00214143bc7abmr10942799pje.21.1667442695034;
        Wed, 02 Nov 2022 19:31:35 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id v10-20020a17090abb8a00b002137030f652sm2147447pjr.12.2022.11.02.19.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 19:31:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 2 Nov 2022 16:31:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Simplify code in css_set_move_task
Message-ID: <Y2MoBeJGU1Exg6cX@slm.duckdns.org>
References: <20221020074701.84326-1-haifeng.xu@shopee.com>
 <20221027080558.GA23269@blackbody.suse.cz>
 <adb7418c-39a2-6202-970a-a039ad8201dd@shopee.com>
 <20221031131140.GC27841@blackbody.suse.cz>
 <25f6a188-4cc6-dace-1468-fd5645711515@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25f6a188-4cc6-dace-1468-fd5645711515@shopee.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 03, 2022 at 10:13:22AM +0800, Haifeng Xu wrote:
> I understand your worries. Can I just check the populated state of
> css_set in 'css_set_update_populated' and don't change the order any
> more? I think it can also streamline 'css_set_move_task' a bit.

FWIW, I don't see much value in the proposed change. The resulting code
isn't better in any noticeable way. Even if the change were straightforward,
the value of the patch would seem questionable. There's no point in creating
code churns like this. Nothing is improved in any material way while
creating completely unnecessary risk for subtle breakages.

Thanks.

-- 
tejun
