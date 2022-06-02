Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7278953BC4D
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 18:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbiFBQQk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jun 2022 12:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbiFBQQi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jun 2022 12:16:38 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48AA2B07CB;
        Thu,  2 Jun 2022 09:16:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so6694744pjm.2;
        Thu, 02 Jun 2022 09:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uGG9vxabvHTNIKzZz4iCB8IKnMzQr1VCGtUnhFb1+UY=;
        b=RCEMSbNiZBiU/AiNlb77dfvjT/7kyqYVv2/vI278NdBW4V5QnJkaMZOOSnD0B82vh7
         RBtEmAQrWCym5AO3j+nOEPyxoI487W4vGEIC+qUbl5IX3Los948Cskn1r93l52PPl9tC
         LajBg3fsnB01Fw8f1nsVonEumyh6ZNngCUphOzXcf7z0uzABuA+Hab2If8PPLGrMGog7
         +h3fzv84WGstiX+3v9E2xyaDrSuQjkUOHb7O4vA4PB1A2ex+3S9IKDUDb5Gfx/9jgzP8
         5bmLeLFeUN5LYOb39BohI1QwFmn6iJiGDo5MLVDe0Zx/N6d2edYybL1a/jT7taLcqoMg
         wY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uGG9vxabvHTNIKzZz4iCB8IKnMzQr1VCGtUnhFb1+UY=;
        b=OeTgnHWpi3pcy8mfpbAOateMuXmKRxxzY/YgwphFajf6/B0iiZ9GeyrkNmY5XPDrKC
         5VUbpvRLi9PJsoaiUCaNrxDqMH2D71UZHs+x3trT9n02QytU8aofIPEY2uLG52cmc2cE
         gteKOxthlomvZn1EUQM4MazJmweqJvUV1ouRZlUkvVAsE7LSt0By1/05pxlHr1wIwk5t
         I1jVuC7T4DHVDrB/91OClSZ80FwbdkD+lo+hdI0AcAfBJCKjeG9neRnBW2oGiGK5Sbkx
         yaxKX2MY9JSLGU3r4F9xoxmlHTsddZzARS4WgeTw85R3fyFaRhL55X/SrMPYye6PcAsN
         qvAQ==
X-Gm-Message-State: AOAM533oxR3sjy9nW3qdua60Y+KR5jUAz2CqSUU4OMxqEwAoF5LML0bd
        e+TOC+K0I2rVT16K4tZJQMtBWs3WleQ=
X-Google-Smtp-Source: ABdhPJwe+BAMVekPCGH9YxD/TUes8RrDiWdKSp9Pkxa+1/0Cvx2O+bqqvPGnnsO6Vng+/N0Xc1To3Q==
X-Received: by 2002:a17:902:a507:b0:162:2a77:7363 with SMTP id s7-20020a170902a50700b001622a777363mr5753307plq.115.1654186594215;
        Thu, 02 Jun 2022 09:16:34 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k1-20020a17090a590100b001e33e264fd6sm3473781pji.40.2022.06.02.09.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 09:16:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 2 Jun 2022 06:16:32 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v5 2/3] blk-cgroup: Return -ENOMEM directly in
 blkcg_css_alloc() error path
Message-ID: <YpjiYPscJst5iuyv@slm.duckdns.org>
References: <20220601211824.89626-1-longman@redhat.com>
 <20220602133543.128088-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602133543.128088-3-longman@redhat.com>
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

On Thu, Jun 02, 2022 at 09:35:42AM -0400, Waiman Long wrote:
> For blkcg_css_alloc(), the only error that will be returned is -ENOMEM.
> Simplify error handling code by returning this error directly instead
> of setting an intermediate "ret" variable.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

But I don't understand why this would trigger warning. Can you please
elaborate why this is needed.

Thanks.

-- 
tejun
