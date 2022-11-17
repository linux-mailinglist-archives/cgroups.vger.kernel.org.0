Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2973E62DEFD
	for <lists+cgroups@lfdr.de>; Thu, 17 Nov 2022 16:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbiKQPFY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Nov 2022 10:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiKQPFU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Nov 2022 10:05:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674D959876
        for <cgroups@vger.kernel.org>; Thu, 17 Nov 2022 07:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668697456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3/pZzLYRJIJU5BHs9Uc1Vomcy9mjzdUIDjXX/Oi2kCE=;
        b=V1b5vNY3ymMyGsy/T0n8wpJ3WhhZ6DRb1r5NmlSh+uk00cb0yNRKAzo13UYq0azKojwqEc
        fmzS8XX+D3KEQ8mSxiweo/e8tIy+N44JiIxKSQl6gZXClWFetinOq+f+vIj5z0LkQT4DHJ
        jJkqOxqpwMXc3u8oAwv0bUQxyzTI7rg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-501-zdytaWCWMxqkHMwBxuSObg-1; Thu, 17 Nov 2022 10:04:13 -0500
X-MC-Unique: zdytaWCWMxqkHMwBxuSObg-1
Received: by mail-qv1-f72.google.com with SMTP id ng1-20020a0562143bc100b004bb706b3a27so1776033qvb.20
        for <cgroups@vger.kernel.org>; Thu, 17 Nov 2022 07:04:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3/pZzLYRJIJU5BHs9Uc1Vomcy9mjzdUIDjXX/Oi2kCE=;
        b=A8C3j0lCqV37pV6QqRskH+ZTZsZiDkZIh1wM/v8GyTpTimQBonGD02AFIVcMEcO1tz
         M7fPWq85X6UusfI2FtUZxCL5dwXwe2rfKI3Uc8FMtaAgWViWEGOa/5UnuDYridfwt3lv
         Z3IYUKIu9y+2/TGDv1s/xgHFDjdgR4RPDCNxBgl5uSADbxGJ1aR2dvCzYjxEMrvLiZsW
         LuDsieVKGAnenP8lrtAhxJ/sFL080/Ev816/HzVWRckdElqNQZLJcVivp18HqUM12C0W
         i/ZosOXMIDvc8WYJHVv8S8OiHZHSpnirHaIo0YYRptDg5G+aBjk2pj4k4yIjybkqabuT
         jKow==
X-Gm-Message-State: ANoB5pnpEAsDnRCvNdJHz3WAUBxEfEZeQKfJe6ZhRK3+GDyM5YLcMOpX
        zZiLCXiSQqO7n5y2RY5TEeXw2+IBShQqKmfnCg5Eu0FVUt7QEpl5phq6bKKUDpOWY41GQYKkIU0
        oWWI6nYw9gjBu8edZOoGWAomP/2236JhT6g==
X-Received: by 2002:ac8:124a:0:b0:3a5:e9fc:aa81 with SMTP id g10-20020ac8124a000000b003a5e9fcaa81mr2479617qtj.538.1668697453044;
        Thu, 17 Nov 2022 07:04:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf78K7K9QQ/LEvml9I/mWSQVn+B0fyexIMzg8OX/iKi7kiwkPii8zpQjSqYYBFiNTGcK/7rWDOQ6MILAFdcpRCs=
X-Received: by 2002:ac8:124a:0:b0:3a5:e9fc:aa81 with SMTP id
 g10-20020ac8124a000000b003a5e9fcaa81mr2479601qtj.538.1668697452805; Thu, 17
 Nov 2022 07:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20221117071557.165742-1-kamalesh.babulal@oracle.com>
In-Reply-To: <20221117071557.165742-1-kamalesh.babulal@oracle.com>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Thu, 17 Nov 2022 11:03:56 -0400
Message-ID: <CAL1p7m4MeYbccde1rPKuxcbtj6Tm+sa4Ro_REAMBmWszyWJ3_w@mail.gmail.com>
Subject: Re: [PATCH v2] cgroup/cpuset: Improve cpuset_css_alloc() description
To:     Kamalesh Babulal <kamalesh.babulal@oracle.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Hromatka <tom.hromatka@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 17, 2022 at 3:18 AM Kamalesh Babulal
<kamalesh.babulal@oracle.com> wrote:
>
> Change the function argument in the description of cpuset_css_alloc()
> from 'struct cgroup' -> 'struct cgroup_subsys_state'.  The change to the
> argument type was introduced by commit eb95419b023a ("cgroup: pass
> around cgroup_subsys_state instead of cgroup in subsystem methods").
> Also, add more information to its description.
>
> Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
> ---
> v2: Reworded the description to be more accurate, as suggested
>     by Waiman Long
>
>  kernel/cgroup/cpuset.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index b474289c15b8..ce789e1b2a2f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3046,11 +3046,15 @@ static struct cftype dfl_files[] = {
>  };
>
>
> -/*
> - *     cpuset_css_alloc - allocate a cpuset css
> - *     cgrp:   control group that the new cpuset will be part of
> +/**
> + * cpuset_css_alloc - Allocate a cpuset css
> + * @parent_css: Parent css of the control group that the new cpuset will be
> + *              part of
> + * Return: cpuset css on success, -ENOMEM on failure.
> + *
> + * Allocate and initialize a new cpuset css, for non-NULL @parent_css, return
> + * top cpuset css otherwise.
>   */
> -
>  static struct cgroup_subsys_state *
>  cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
>  {
> --
> 2.34.3
>

Acked-by: Joel Savitz <jsavitz@redhat.com>

