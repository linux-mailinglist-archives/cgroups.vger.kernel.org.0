Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBF351C4EF
	for <lists+cgroups@lfdr.de>; Thu,  5 May 2022 18:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbiEEQQT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 May 2022 12:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiEEQQS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 May 2022 12:16:18 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4509B80
        for <cgroups@vger.kernel.org>; Thu,  5 May 2022 09:12:38 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c14so4015501pfn.2
        for <cgroups@vger.kernel.org>; Thu, 05 May 2022 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOg3JkIywRLzrPPGawgi8+ppo6ekCB8fiVEKfUdHYi8=;
        b=bQoc6U3SxwP0PLDXxVdqqhePzPc76Rf9CAYeT6a95TuwCPscQdatdnavfs9+sEDFuA
         p3rZyeAuQqJiMBN6peF93vd05yCGPXNj4V78HmPSInyZV2H91C+CpOJYjHq5n9ogs4Wq
         1QVsNX3yw+iEWNAClXf5MVN3ViDAULifqYmqmyZJpC4K3jC0w7+UvEQ4hfYrYVyPC642
         7Nwru5zmvGzc97KPaDQQ3DX+5WICrsIp/3jHcKn/sOem690fn62qi74MMmhCn5Mrz0Sf
         pocEv78vyZ7zQzsi0xJ5L5GbPAFPRTIHB6zPsGPTDuNDJY83edQsULVTvzQRv1FyJ0xa
         ZjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOg3JkIywRLzrPPGawgi8+ppo6ekCB8fiVEKfUdHYi8=;
        b=WffFH94pnzB+6pzVp/+Wy/PkYn8AF9nnV12jiqIAxdrYKPLfRrko/GS5hJNqJGME+X
         NPTfiXr74NIiDCwGmw2UAK1/A42OkrYF2rtcUvqW3HlT9VMT8KFZe+5j7AxysnZXls5y
         g4CpHEO0BHVtDinFOZVRaaejGzYpSCr0aw6WsLrhe9klPUBRKL5zX8uGg9DDlasC+w04
         zMU0ZXpfooPRFKM1DoL8mcD6hoRgX+guTdrDhOpL35O7UNHDD73u9iXoABBfe6UJBIC2
         r8UvPGGMqjdGC54DA5VwVsYsZoLkDs62APlZCAzDagSrMLMlNSQUCGFPQKz6hdAwiU0n
         UKdQ==
X-Gm-Message-State: AOAM531ZRiHWBXqGHcO98SSIctyf02VcoWia4CbM8rGvzNz3Wj62zT/t
        tvU5TDZ8aDDMX3jqm8MyfQWaHMY15zYZyem5ziE0+g==
X-Google-Smtp-Source: ABdhPJwt8R0qqFEdfPp4xjRQYlx7+/QzN23NSOyJAtP1ucd4x7SKkS02w0EVQ9tWN674m9awAGDz5ZtA7fxuoG+LdZs=
X-Received: by 2002:a05:6a00:2382:b0:50d:fa40:1077 with SMTP id
 f2-20020a056a00238200b0050dfa401077mr17326483pfc.8.1651767157870; Thu, 05 May
 2022 09:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220505121329.GA32827@us192.sjc.aristanetworks.com>
In-Reply-To: <20220505121329.GA32827@us192.sjc.aristanetworks.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 5 May 2022 09:12:26 -0700
Message-ID: <CALvZod5xiSuJaDjGb+NM18puejwhnPWweSj+N=0RGQrjpjfxbw@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: Export memcg->watermark via sysfs for v2 memcg
To:     Ganesan Rajagopal <rganesan@arista.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 5, 2022 at 5:13 AM Ganesan Rajagopal <rganesan@arista.com> wrote:
>
> v1 memcg exports memcg->watermark as "memory.mem_usage_in_bytes" in

*max_usage_in_bytes

> sysfs. This is missing for v2 memcg though "memory.current" is exported.
> There is no other easy way of getting this information in Linux.
> getrsuage() returns ru_maxrss but that's the max RSS of a single process
> instead of the aggregated max RSS of all the processes. Hence, expose
> memcg->watermark as "memory.watermark" for v2 memcg.
>
> Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>

Can you please explain the use-case for which you need this metric?
Also note that this is not really an aggregated RSS of all the
processes in the cgroup. So, do you want max RSS or max charge and for
what use-case?
