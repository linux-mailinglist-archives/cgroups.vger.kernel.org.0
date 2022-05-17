Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1840529882
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 06:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbiEQELr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 00:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiEQELq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 00:11:46 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74034248E
        for <cgroups@vger.kernel.org>; Mon, 16 May 2022 21:11:44 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2f83983782fso174620027b3.6
        for <cgroups@vger.kernel.org>; Mon, 16 May 2022 21:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NO/qVr25gl9DWObhrjxNHN1PGGWIrTbPudg44b/JLeI=;
        b=6KEbpLl+WAWuaT8l95JqbSOJgxSfJpLNEobjxxcKridU4U1e87XUTvnUWU6odxyltG
         sXCcYvAJY+6YB1DpztmiFEnawZUnjEhrpZdrVqDMMN1cGgA1leE+uGdC2eL9FIQFSPdB
         xEO8+E2C/VI8ufjhzynb2Z+cjaYGHRHv3EiZaE0UgmgXsHBuI952bSfrr9GwiudXZovw
         CVqHc0o16YBvjIQ9aiw2/bi+cIfUuynJXbTcERUtjLZy+1Zd8Een7qt0NcebDbVycA6i
         4xth0GFVrEk/CoU07cQjxYG1M9u2NZERL1P5PXhcCQ6ywkbKUWXRQHnHLustaralGwoS
         2tXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NO/qVr25gl9DWObhrjxNHN1PGGWIrTbPudg44b/JLeI=;
        b=xxM3ix6oITZTaEUfZA79estOZqSO4CRzHVIPARNoO/zjTWkv0r8oK0d60mpurWHg7C
         NtQLatk/pU/VosHOCSl/BAmrcUCnY2ivN/m11Sdbesy+IaYSrUGBQtOOa8cROFDVjMH/
         RB33xkuOjKqR+aEJHUcO7WjTUDGAlV20gFQYe3cZfXTmP/gTovGctOIFl+LIeJwDP0JF
         WnjsXdkF38mKIExVXnqXNQEY/RqFy4C3HURANs5rGdWuC9JxhgK5GAmL3Ojz/CJXFfq/
         K5yvVqCahITslIyvrm13H2cWwkINWZAgM/B9c/XH6JwMZmdXKgv5eLA2/ala5+ZRKThp
         +gbA==
X-Gm-Message-State: AOAM531o0fC0LKq6weGK0pjteDl+817sKfH2PrFsvuLzGr9VFCdTGIgE
        DMFfi+J1SMX47+llcSd84hsEEmaCBc1IKgGAW+Ryqqz/zW3tDw==
X-Google-Smtp-Source: ABdhPJw94mquCu2tzO4e+v+R3EKZQm+TzZ6hT1GPqsmlWqCmuAgQDMm/rqRAJ7UuVR8eO1d1Omo9W844ZRuDq2Cs1+Q=
X-Received: by 2002:a81:7b05:0:b0:2f4:e45a:b06e with SMTP id
 w5-20020a817b05000000b002f4e45ab06emr23607287ywc.458.1652760704159; Mon, 16
 May 2022 21:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220516173930.159535-1-bh1scw@gmail.com>
In-Reply-To: <20220516173930.159535-1-bh1scw@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 17 May 2022 12:11:08 +0800
Message-ID: <CAMZfGtU8GYN6aLepHr3z=AvJ4XivmWpPdnvUBgaJUnmf37-28Q@mail.gmail.com>
Subject: Re: [PATCH] blk-cgroup: Remove unnecessary rcu_read_lock/unlock()
To:     bh1scw@gmail.com
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Cgroups <cgroups@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 17, 2022 at 1:39 AM <bh1scw@gmail.com> wrote:
>
> From: Fanjun Kong <bh1scw@gmail.com>
>
> spin_lock_irq/spin_unlock_irq contains preempt_disable/enable().
> Which can serve as RCU read-side critical region, so remove
> rcu_read_lock/unlock().
>
> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
