Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707CF50A403
	for <lists+cgroups@lfdr.de>; Thu, 21 Apr 2022 17:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390049AbiDUP2M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Apr 2022 11:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390035AbiDUP2L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Apr 2022 11:28:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB05D1A3BD
        for <cgroups@vger.kernel.org>; Thu, 21 Apr 2022 08:25:21 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id z6-20020a17090a398600b001cb9fca3210so5494133pjb.1
        for <cgroups@vger.kernel.org>; Thu, 21 Apr 2022 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rALYp+if0darmPSdMoPhbeuPNfcV/0b9+KgF06gqnp4=;
        b=h7SF1jQML2/ahIwe/O5GKTiG1aB/cO1z10lLaoo8KEftSnI4VQ5FBhy94oUwIjTBW2
         BcCgTJQ/jNiDqPMzA6h2bCtOz3M0I8FX/lohbyxUhjZ9Y6pYJCEAr7YcGJbgqoacaaXC
         LeGWRXBd3JsWl6IGB5NdMuj7HumqzA7fJHF6u65mtphSD/g2NdC+stP76m7SKbA06EVX
         RCeMhwroBR+SHz9WBoSR83dwz6cpJ3nCeNzC77W6WRvBPIJdgGCjJtLo2Ks01HHBAVEL
         n1ekSleAKYEk0PI3CKgKCdaMSLiKQ+B5P5VuDIAOBWugNxiv5r9Ts6BQweYZjVp7TmYa
         Xiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rALYp+if0darmPSdMoPhbeuPNfcV/0b9+KgF06gqnp4=;
        b=VlfmizVSgrqwBqb8XDo8rpyVbchaUId/1/W1UPMvjHJFjMau6xXv3NyfH9qlqepXdT
         hgPAmwiE+HCpqaQVCkRvTaEyZY/NMHOC/uagwpud2xZkdkMquKhOZQuQIT4gQ8ixw6Y5
         3Qkbz0QC7qEXAp3IOvBgZd9w1b9BKXV/eeRDVSZCvFTMXyaQAQq6etfWFhCil+dlGrL5
         zSXMym6Bykq0FStuPBhHLLRU0PaljN5K8GFVD3nLQ2ixHgXGL+grRN7PF8MAj9I2uE68
         KzQGw09zQTUOQ7oPZl2qjukM0XeOWEfojJvxkgCXoztDJyJF9aolAmQmFHIiWJkJMXdH
         MjJQ==
X-Gm-Message-State: AOAM532lsyK/q3k2X5FyQ1NK5mKZNt+LP6MqzW6C/e4u3XxqgPIBiotq
        T16ZK0RrhkXBluNjuYj1L6hQH/2hDDtcG6mcA7S3nw==
X-Google-Smtp-Source: ABdhPJzei8RMyizdgrA2/zDKiToND2LY5mvmrdcY+8zXFXr02sd9BtT9jUzObvgwn7YeB0MY8ghxMe9uTGY/DiiJMoM=
X-Received: by 2002:a17:90a:558a:b0:1ca:a819:d2d1 with SMTP id
 c10-20020a17090a558a00b001caa819d2d1mr11058959pji.126.1650554721083; Thu, 21
 Apr 2022 08:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220421122755.40899-1-lujialin4@huawei.com>
In-Reply-To: <20220421122755.40899-1-lujialin4@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 21 Apr 2022 08:25:09 -0700
Message-ID: <CALvZod7pHY590zt8Dq14Fn+VB+p7bfHdpFf39M9dSn8mtzU_+A@mail.gmail.com>
Subject: Re: [PATCH -next] mm/memcontrol.c: remove unused private flag of memory.oom_control
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 21, 2022 at 5:29 AM Lu Jialin <lujialin4@huawei.com> wrote:
>
> There is no use for the private value, __OOM_TYPE and OOM notifier
> OOM_CONTROL. Therefore remove them to make the code clean.
>
> Signed-off-by: Lu Jialin <lujialin4@huawei.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
