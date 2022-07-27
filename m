Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5F35832CF
	for <lists+cgroups@lfdr.de>; Wed, 27 Jul 2022 21:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiG0TFE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jul 2022 15:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiG0TE1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jul 2022 15:04:27 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39265FAC0;
        Wed, 27 Jul 2022 11:28:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y141so16789793pfb.7;
        Wed, 27 Jul 2022 11:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=Rr2DmdH/Yw7QfWPKMwga2AxXi65vqNRwg8R5+haMBnY=;
        b=RliP9yXWD5CA9bljnE2oiVxs9BJAxE9TKXJCXAXuaE6qP14dhUHkl97uK3BdsKC6Wu
         XY5b23DHu/JtYErCI6ZXaU/2hJCMlb0yNyib9sD417uZ3FtLx17W4FRkkUmT/FjLzfSP
         Ts8R0vQSQcJvBj0Wq11eQqdWGb3fHRbbMnGyninuRlUNg23k7gX49OPL/+O0/g1Iy8Rm
         yk+FhOE0II5xBWvTIdSNL4V5U8SLo+FmytbcpdiVSjF5NNWJd8Q2e/7n3f/U6BiF1dn3
         Msf+k/AiaqpGJHf/pBx4q5TxzXLg3TwiGnTfPMlUCua1RExTi0MI4CMUQXGU+lSbjylp
         aI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=Rr2DmdH/Yw7QfWPKMwga2AxXi65vqNRwg8R5+haMBnY=;
        b=evWJx1CFQZpz/H6kB3qzPoHRdYcpMqeBLwg9yYLeurGg30TywAR7AHsP7J03b8E9YR
         wCNSkXW+/nEy5+ZEgzUnc6o8M67mM5xR39AwSR9PL0WTBPY/OB7SCW6aQ2Snr8/HfFMD
         YsE+6mPeY0Qrc4Xq5ECnu8KMn5ka98tGf7fDV0fqz/j4VD3fOdj5qqr0iv6HXwfq7BXf
         yPpQ5yKynY5Uaeo+fzvseOFB3NAWtlu+HzXrZhxsoIUGgzsC6nUnG7BNfTtIzpZE4mbm
         S6vlxmAVEpWhMsOxco9u+myiqFC9nrBeknZ35rdfqdVvIh2Wwv7LOFNxl3yyfkbfmdnc
         8RRw==
X-Gm-Message-State: AJIora+VP8ZoA4YJycFoqEpREmYiQjeEgOPF5sw/EONvBkyW4xDvBBhf
        q9/6mD74ZH6rkYiotJ71dSo=
X-Google-Smtp-Source: AGRyM1tTr14FJaUQBQ8nWS67O2L/U66szXsIK5MhQcM1+eQAuv01bCGhWYtk4wY1i1lZAzhXSEssJA==
X-Received: by 2002:a63:fb52:0:b0:419:cb1e:6e2 with SMTP id w18-20020a63fb52000000b00419cb1e06e2mr20185224pgj.356.1658946521270;
        Wed, 27 Jul 2022 11:28:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:5a55])
        by smtp.gmail.com with ESMTPSA id l17-20020a170903245100b0016c454598b5sm1818636pls.167.2022.07.27.11.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 11:28:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Jul 2022 08:28:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mkoutny@suse.com, axboe@kernel.dk, ming.lei@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH RESEND v6 2/8] blk-throttle: prevent overflow while
 calculating wait time
Message-ID: <YuGD1s2TJ9euYpCv@slm.duckdns.org>
References: <20220701093441.885741-1-yukuai1@huaweicloud.com>
 <20220701093441.885741-3-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701093441.885741-3-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 01, 2022 at 05:34:35PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> In tg_with_in_bps_limit(), 'bps_limit * jiffy_elapsed_rnd' might
> overflow. FIx the problem by calling mul_u64_u64_div_u64() instead.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

BTW, have you observed this happening or is it from just reviewing the code?

Thanks.

-- 
tejun
