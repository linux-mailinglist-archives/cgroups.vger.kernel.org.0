Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42121722FB2
	for <lists+cgroups@lfdr.de>; Mon,  5 Jun 2023 21:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbjFETVR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jun 2023 15:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbjFETVE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Jun 2023 15:21:04 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698D5E72;
        Mon,  5 Jun 2023 12:20:59 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-65292f79456so2350641b3a.2;
        Mon, 05 Jun 2023 12:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685992859; x=1688584859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkYFVdwirk/CiSbxka53j0MJonMcdF+VrPWbomHwsf0=;
        b=RK7/RNQleMDrPiCfrmVZurlIU9JePH+Mhf/Rzp7SPRwBezlKh1ohmTLzfjPTQq4/4o
         h0ON8jvMUvg8SuKqth9Cc252vwHoUyXbDZinaUcVIryadUsSDYcGDRpQk0AQbJU/4sMu
         npGFPEjVaxwqKeFRZC8iXEumGUjFftp+PJ3MVDUIGMWImM62/g4UZqWzsi74Eo5d54mr
         sC1wVHj4mn/8gk0dCuq6NEoW0YE3Of3cJ137rTian6GOfFoX53H76f7NfL+V6ZjnETC2
         /3ZzPHtEnUK3iux6R9YadkPTtuLijwWgBStBof+7ocGFf5Pwa2SEnyN6tA/immYIoHe+
         TVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685992859; x=1688584859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkYFVdwirk/CiSbxka53j0MJonMcdF+VrPWbomHwsf0=;
        b=Gyn1oFQ5VuIUIE+NdUX0u9/M09ghqg+eKMlztv0WCKjH0+18T3pDPNAWYpUdVOfUJX
         8zY7JkfuPoPPsaB5mVb4coti9FNzDiBUFNw9Ng6gGKmVUVW7pRWnVKRE85Qm+LjNAdAJ
         iLCiqIscu6BU7f8DEtewDUBkpbzkg6aiD9E5oy7Bdg9CSd+6AIxaAXeZ8pWLICXvhYlJ
         AxgUVbymwnXHLtXrO0cJgfBxPafRPWmuj0S1rOCT3Dxi1V3Sr8gPWKuxmdx91MnRLmzq
         +RzfZdFPEiPp+EERG7FZRVGC/kr3JCvxHtyu7fOIK0Du9P9aPE+NesK0CBKa98F8azHS
         pDbQ==
X-Gm-Message-State: AC+VfDx8XiDvhmSmullJtfkjAFb023IRvgoKoh7U2vB/UJ/XVum1SJz6
        zXi4UfXK5uBm/teYB/BVeX2EUtEmRcc=
X-Google-Smtp-Source: ACHHUZ7TUzecvJAki61fnDDtXcqj0uv9QSFvmFuD+/JbQ1kYsp20mc2bTrgbpP6maHHKKiFWYhkRCA==
X-Received: by 2002:a05:6a00:14c5:b0:65c:8195:e6a2 with SMTP id w5-20020a056a0014c500b0065c8195e6a2mr725447pfu.1.1685992858653;
        Mon, 05 Jun 2023 12:20:58 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id r3-20020a62e403000000b0064ff643f954sm5541432pfh.88.2023.06.05.12.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 12:20:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 5 Jun 2023 09:20:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: remove unused macro for_each_e_css()
Message-ID: <ZH41mW1D7TiY2Q0f@slm.duckdns.org>
References: <20230527093353.153078-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527093353.153078-1-linmiaohe@huawei.com>
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

On Sat, May 27, 2023 at 05:33:53PM +0800, Miaohe Lin wrote:
> for_each_e_css() is unused now. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.5.

Thanks.

-- 
tejun
