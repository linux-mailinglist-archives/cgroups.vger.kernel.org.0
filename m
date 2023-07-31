Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9693776A4FC
	for <lists+cgroups@lfdr.de>; Tue,  1 Aug 2023 01:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjGaXri (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jul 2023 19:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGaXrg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jul 2023 19:47:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E58E7C;
        Mon, 31 Jul 2023 16:47:35 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686ed1d2594so4855649b3a.2;
        Mon, 31 Jul 2023 16:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690847255; x=1691452055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnW9AbWFmFt7g04hnCtQK/3q2HPpz4D58kd8qqlWGy8=;
        b=nHSUa38jLtoF754EZqXsmmeP3G802kC8NnsHwbOdi2rEqezUHvql9kuR+I6CLk7twK
         bQtsCWDngqUVkGbc+0oXF1lSSA+iYeIQFgfINagZahTQTXLQM7dCRTQgVYrRKc5acVK5
         8BPpIAGo7i7qLc+xPzAkWPz5plZcymfXE124fxLIB9zWXp1Xj6QK625x0h/uSt/pQcNv
         SZmeLEfafvDO0F7DNo5mIqqXtM+7Q4cbbIUlrxWaSspBs8a0hH3FgM8pPwTAna0yggSZ
         yhWF9YmBx/y6WZO+eXTcb11yFbLlt6zrf+fdxQiHUwVCNBFNOrPwy/CnbZkQJ05q0kNx
         rvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690847255; x=1691452055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnW9AbWFmFt7g04hnCtQK/3q2HPpz4D58kd8qqlWGy8=;
        b=X5N0pd4UK6cKuaHRof7euYxKkieyiPxzrQMKzZ6oHFToj0nRIAMw8KEUW2nMpYMMCG
         lYxrvkC9vtKKRNV4apHWpBfY8s071vP7jDoNA2SFd5hTlMd42TchM3eatR2lp0vsWdVE
         19D5OmEi8x1+No9mtyAIMkAXlquvRZTkn17Z9/urBc37Eu6JwnLosuTTi3mpzBhdIS84
         ztKNfaNVWXSuBH3yq7hlm1ODPGTCITFpgngMDVgCrDQkZTsjhNHCqSf2aRRe3WQQmP1K
         XPErMZJnZ/es3Ad0ba6R5q9LnxoroQ+JU3HqinRNraGD9a6Kqc5ZBYaT7Z+sglQlIncz
         Uy/A==
X-Gm-Message-State: ABy/qLbrFuef0eVK6OLgoDz/DksPMCTZeIuyDwnCF68EIkQSMdazKdPZ
        1X/Yd8MdrSMRT5OextYOw88=
X-Google-Smtp-Source: APBJJlEwkiP3BPocGj0HBh1pDj0T5aYaE16aqVzfW2ybZOkWzWRIQoBtC0/N8n+477giWa6bfKQZtg==
X-Received: by 2002:a05:6a00:c86:b0:682:4c9f:aa0 with SMTP id a6-20020a056a000c8600b006824c9f0aa0mr13843961pfv.29.1690847255023;
        Mon, 31 Jul 2023 16:47:35 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:4a3a])
        by smtp.gmail.com with ESMTPSA id e3-20020aa78c43000000b00682562bf477sm8090347pfd.82.2023.07.31.16.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 16:47:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Jul 2023 13:47:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: minor cleanup for cgroup_local_stat_show()
Message-ID: <ZMhIFUsxEtA_B781@slm.duckdns.org>
References: <20230723031932.3152951-1-linmiaohe@huawei.com>
 <ZMBERCXR27X_gRAt@slm.duckdns.org>
 <ec3df402-7681-3d0c-b9ce-d50eb7383b1e@huawei.com>
 <719a19c4-3be5-2260-7349-b3f1bb774f4f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <719a19c4-3be5-2260-7349-b3f1bb774f4f@huawei.com>
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

On Thu, Jul 27, 2023 at 07:50:11PM +0800, Miaohe Lin wrote:
> On 2023/7/26 9:06, Miaohe Lin wrote:
> > On 2023/7/26 5:53, Tejun Heo wrote:
> >> On Sun, Jul 23, 2023 at 11:19:32AM +0800, Miaohe Lin wrote:
> >>> Make it under CONFIG_CGROUP_SCHED to rid of __maybe_unused annotation.
> >>> Also put cgroup_tryget_css() inside CONFIG_CGROUP_SCHED as it's only
> >>> called when CONFIG_CGROUP_SCHED. No functional change intended.
> >>>
> >>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >>
> >> Patch doesn't apply to cgroup/for-6.6. Can you please respin?
> > 
> > Sure. Will resend the patch based on cgroup/for-6.6.
> 
> The commit "sched: add throttled time stat for throttled children" is still in the linux-next tree. So I think I have
> to wait for it to be merged into cgroup tree first.

You can just send the patch against cgroup/for-6.6 branch. We can sort out
the merge conflicts later.

Thanks.

-- 
tejun
