Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B76371327D
	for <lists+cgroups@lfdr.de>; Sat, 27 May 2023 06:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjE0ENp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 May 2023 00:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjE0ENo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 May 2023 00:13:44 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFC4DF
        for <cgroups@vger.kernel.org>; Fri, 26 May 2023 21:13:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96fb1642b09so211772566b.0
        for <cgroups@vger.kernel.org>; Fri, 26 May 2023 21:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685160822; x=1687752822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CLI5dDlGRzvV0LMDARHxx4pfVRGX/zlI8ZJMCOjbQM=;
        b=00i267X+Zy5eHdWjx6icwa/P4rEW82q+O0IlAkQOt+vbOOfMFcbzvHAqzdv5/FL6Tn
         NGyG8n911S2yL4hThaPoslwa2Yp0aWDGMz1hzLFHXKZNQaQomJqFbN/bS3kmfm5rIZEH
         E/kTKAFGZMSFyjfPuX0trHV8y4SyOcNW4XxXMuPtsqKb75/O/An4NBcrABlt0E7wYMco
         +6FcgBKaPsFKWh5JEpm8ONiFvKFQDl0Z6axXQIodaarTWfRB4M4czFFJCh4bzCIgMf9j
         bD4/klzy5Hx1YNAZL/T64uaDacPyph4Z2wiGMe9lX4Xx5acRCtSdJ+H+JROb8oV2xle7
         wg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685160822; x=1687752822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CLI5dDlGRzvV0LMDARHxx4pfVRGX/zlI8ZJMCOjbQM=;
        b=kIKG6e37+YQqdM3FDgFWDmYy5ECIYDYDmN9MUSQI4uQW8yDG5svqVjlUcClMiRxq77
         KEFAvfHRGKswp+TD+0vx1V0JRJ2nn6Rms9CbgfEBc+3dTSCApTByMbtPshliIG1KoHsf
         hAFAcEaCQ9YblEbpeYrbkzA4o2adinlUa3EPOF3+B044E5b7dF6Eb43ylfOGQVDV/ktP
         dkXs5V6neiCJFrb6jiQ8jF2QAiRQ4A8LqHSvf3LpB10wiMgRnsYEcscAR1U3o37SFn96
         m8d6I+JhJXvRXAib9lfOj6OhUubeXRUvk2u7bZdo+i9v9z0DJkKhrdDG3ej5BQy4PT1S
         0b9Q==
X-Gm-Message-State: AC+VfDxv5Ju1PYd3UUV55coG8ZWuCEc0vBZZJ+u2/pULCS9NkJb/ArgB
        Yt9d0P8vrd/hqeEWO7YX+eNciNDU6J5b4GiaJb9yGAUja7nTOhtbe/X8vg==
X-Google-Smtp-Source: ACHHUZ6NV8cibR1lUGRmOTw2ml/5B4EWeeDGTjdt7m1ithRgYmnoCh2Bgdmd4mPLrekMgqAkfMPufDzec3S5lJkJ1Ok=
X-Received: by 2002:a17:906:9b87:b0:966:484a:335e with SMTP id
 dd7-20020a1709069b8700b00966484a335emr4048945ejc.43.1685160821581; Fri, 26
 May 2023 21:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230527103126.398267-1-linmiaohe@huawei.com> <ZHGAcaqOx/e8lqwV@casper.infradead.org>
In-Reply-To: <ZHGAcaqOx/e8lqwV@casper.infradead.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 26 May 2023 21:13:05 -0700
Message-ID: <CAJD7tkYSrVkAONXko0eE6LWS__kK_Xeto9MVGwTxuqT5j6N8RQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: remove unused mem_cgroup_from_obj()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Vasily Averin <vasily.averin@linux.dev>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, May 26, 2023 at 9:01=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sat, May 27, 2023 at 06:31:26PM +0800, Miaohe Lin wrote:
> > The function mem_cgroup_from_obj() is not used anymore. Remove it and
> > clean up relevant comments.
>
> You should have looked at the git history to see why it was created
> and who used it.
>
> Shakeel, Vasily, are you going to retry adding commit 1d0403d20f6c?

That commit did not introduce the function though, no? It was
introduced before it and replaced by other variants over time (like
mem_cgroup_from_slab_obj()). It looks like that commit was reverted ~9
months ago. We can always bring it back if/when needed.

It also looks to me that 1d0403d20f6c was using mem_cgroup_from_obj()
on a struct net object, which is allocated in net_alloc() from a slab
cache, so mem_cgroup_from_slab_obj() should be sufficient, no?

>
>
