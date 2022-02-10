Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC4D4B1812
	for <lists+cgroups@lfdr.de>; Thu, 10 Feb 2022 23:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344909AbiBJWXv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 17:23:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244171AbiBJWXu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 17:23:50 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15C9218E
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 14:23:50 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b9so13059488lfq.6
        for <cgroups@vger.kernel.org>; Thu, 10 Feb 2022 14:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hO66QIvus488NAq78feGEF3dBYxRKmF5DOdeN40y0E=;
        b=ifAyrepAz0/IittI3oOkEW3ly0MGafuEuH+Wv4mqyEk5J+wQSQK4XejFuQrRyABDxy
         cDqnh5/He67UFdvdqWpWkGAY/4DGX71VVGZtRxmYlXps/XzEIW0/YAK+lGR1Of8QoJhA
         dlcXq1Pjm6j94Eh2UzSeZtQSV1JIKru0Uq60Ossq66fC+6zhWOea8yR11tUdGHv33PQS
         QgWvXdGu9gDVM4ZDMwDCLedn7lb0suJH93kcg+bgyn+ulIlbOetxdtUDPDVAkqcwTwa4
         n4LLOEvLFf2EFgZfhIIv1t/7uc9WiFYkSNxY+AH74ofOtAAxydlupol0MB9qJiSbd0mY
         cn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hO66QIvus488NAq78feGEF3dBYxRKmF5DOdeN40y0E=;
        b=7URcdq17GF8TgwtfBmMHbIyXMbxOE6WKRzyVm7v2r0JUDfkwe4RLeGXRLWsX94wD8N
         0sAJ6BtAPLi9Kuz4C94+pPAl1PJYWGnntW4wmvxm8GnevcFOqaaH+mKgKLzenTbX4dNs
         0x4YOhsgqITxsI0g+Rdpal8yRC4btxhU2BUmILvNpcfqR4pS8H+1+7j/weXImMEtii57
         GOmEbJH1O+9b79lhcN4ZAXWstqQvSydvNaHFuIGDGJxcW1O5AoUuFDuqd0Lma85Uew0K
         h59dmc+KXTKp+zvIx9yg8ihT0PBfP0cp5jp+rxX9Q4k6003CEtDZ4fzH03fr/5XsmJQj
         P9AA==
X-Gm-Message-State: AOAM530PRAPx1p6w596z3axiWfSKauT44TmJ+IHYfhU2je+HLZGqtX1b
        zIDxNWYv5wP2osYj3havUvg2AQKz40UI1WPKcXvvgQ==
X-Google-Smtp-Source: ABdhPJwFiSrA1WyKAJ3QOZVAg4E0gV7YsjWEijBGwjO9wjm2Wyh1/Ocie0SCJqhwKTKi5U//VRSxTwUeqtXSwW1SiPE=
X-Received: by 2002:a05:6512:230b:: with SMTP id o11mr6432078lfu.40.1644531829105;
 Thu, 10 Feb 2022 14:23:49 -0800 (PST)
MIME-Version: 1.0
References: <20220210081437.1884008-1-shakeelb@google.com> <20220210081437.1884008-2-shakeelb@google.com>
 <YgVtGhvXqqVzTy7M@carbon.dhcp.thefacebook.com>
In-Reply-To: <YgVtGhvXqqVzTy7M@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 10 Feb 2022 14:23:37 -0800
Message-ID: <CALvZod4Ex+0q+4pDnR8q6bpV8Q5NKbt=5c6SDVUDVnKxTqUNRQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] memcg: refactor mem_cgroup_oom
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, Feb 10, 2022 at 11:53 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Feb 10, 2022 at 12:14:34AM -0800, Shakeel Butt wrote:
> > The function mem_cgroup_oom returns enum which has four possible values
> > but the caller does not care about such values and only care if the
> > return value is OOM_SUCCESS or not. So, remove the enum altogether and
> > make mem_cgroup_oom returns a simple bool.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> Nice!
>
> Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks.
>
[...]
>
> The only thing, I'd add a small comment on the return value here. E.g.
> "returns true if one or more tasks have been successfully killed" or something
> like this.
>

Will do in the next version.
