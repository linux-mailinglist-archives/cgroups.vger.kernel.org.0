Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6C570AC03
	for <lists+cgroups@lfdr.de>; Sun, 21 May 2023 04:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjEUC2M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 20 May 2023 22:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjEUCYk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 20 May 2023 22:24:40 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C911121;
        Sat, 20 May 2023 19:22:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4220915a12.1;
        Sat, 20 May 2023 19:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684635746; x=1687227746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxsO1jnQeNMQfCVBdM+fj9bC1LT6bB0z3BxgK7/4va8=;
        b=fUhUfYRZGUyoGyQnt3YjFerhU+FzVoMUvPBA2IELHYeDNc9kfNactpJzG1rHO9aKQG
         TUNhFbs0WhWSJelvzbooKt+Sg/CpuhUp40KFYTmTse67veeSuzpRTmGqZFa1XZ83wEKD
         hxtIWMYZRk6yVhnvhO107uiawOwM8BONcF0UrpdI+3MpZmhAJ8BqIVtxhlew/QV40NZD
         jSy53c5iYG/Q6V8PHGXG1OQPk7t6ZicYKEQ7vrKEA39sonplqQoyFY9QnbtGLotzACVo
         Yg5179/0v1ti9Ghzdbg2WKjGkZVAdZUI2XloYFAoMvV07sI3bVeHeK6Rii1N3h+ZdlP2
         sABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684635746; x=1687227746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxsO1jnQeNMQfCVBdM+fj9bC1LT6bB0z3BxgK7/4va8=;
        b=EqgeLKsvkxNeMDrJro8Nqs6Uzbhzq2r17mCl1OkOhiKTtao5SyNPdzL1IabEWEAVah
         kj2q27+hNrhp5NHz+/FhrwpNlSumqsY1VkkkcVyEG6TNdwiI7ilPKKmZBHDSythHTey+
         ZBWa2J9dXmSN10++QNMAA9fZ7+nYBkPgAA1R2+JQSoaXHQtHqHLl61Ug6wPlsrJesb75
         W438K8Nka31QssvJM3xcjckIFtomfjZzFMkt/MyRXF+ZOuek/tPiQJBh97IqFDtBPmJ/
         XdQB7wPZh8bdAMbOgmDC5qNfZPMWmxOSqYgBdm7PYW+TLgEQxrvwdO5Xmiz612IX688e
         LdSg==
X-Gm-Message-State: AC+VfDyUdB08xS6xeGSFV60YJnEnifUfwbG0v2FedAeCbCFDehP0Bp6y
        bMlhzZ9AAHgz38rhWGRdzF4=
X-Google-Smtp-Source: ACHHUZ7hB6D+lRoIUKcMZdsiFBRqZ9Kwio4SVk/AzFZxiPNyjK/cHxGCprA5OKACVouVKiXMrkqhmw==
X-Received: by 2002:a17:902:ee53:b0:1a6:d2af:5a3f with SMTP id 19-20020a170902ee5300b001a6d2af5a3fmr6848382plo.3.1684635745587;
        Sat, 20 May 2023 19:22:25 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001a2104d706fsm2137053plx.225.2023.05.20.19.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 19:22:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 20 May 2023 16:22:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     longman@redhat.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: remove unneeded header files
Message-ID: <ZGmAX4SAuIFSMb0E@slm.duckdns.org>
References: <20230520160634.3015106-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230520160634.3015106-1-linmiaohe@huawei.com>
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

On Sun, May 21, 2023 at 12:06:34AM +0800, Miaohe Lin wrote:
> Remove some unnecessary header files. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.5.

Thanks.

-- 
tejun
