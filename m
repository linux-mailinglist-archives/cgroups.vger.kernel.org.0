Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D269567C0E
	for <lists+cgroups@lfdr.de>; Wed,  6 Jul 2022 04:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiGFCl1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jul 2022 22:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiGFCl1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jul 2022 22:41:27 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1EE19036;
        Tue,  5 Jul 2022 19:41:26 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id j15so727203vkn.7;
        Tue, 05 Jul 2022 19:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MlZR8uPETmlGuwXZgUVOik+H9LRiX+UHdzorFOkInsI=;
        b=Z5PXWmnGlzUEIH57fT5kT06fxp4S2kHBR0FcR1vhjDY/b8jBSwpUxSitj+VNjxGiQM
         yrlv9mAvDoIQ0pSB38Vq/T4EqqasWVzb1Ra8npLC1uF/tyy5d+GOq0EsucwhZsUueAYE
         +DiDHRiqkl+CJS2YFipFg7uo1i63XZ2/3cWXYcfPoTV0vdpwWjS0aKAmN+iqzLrTO7NJ
         d0AhrXLjYsZ4Hwniqc8vJVsR/UBPsk+ogUMx/APjOWdzTp02dKS0C/5or4Y4C/la4XS6
         PeuNYoYF/VTJu9W47CUmkEhjyn4XSIqxS4gGza3/RiAxYD8XvlmOwpLwKlzu65KgnF1B
         6QmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MlZR8uPETmlGuwXZgUVOik+H9LRiX+UHdzorFOkInsI=;
        b=viYic1ETEipWSKonkqKpaYJReHABvhAe8ArnGjly+lSJ36ngoPVidbOnThFP11SoRi
         yFL2svvxFLwN5Rq/VN9sor/6LIZObBcBlk24YXM34lmmoiaeu3UfU7nnALYSyBGtDzH0
         SoJWRoo0dJiFxyy0ndc9qnI/yy9dLNS5+1u2TIW5sXlaZvH3xCeiw8eC75ztcPKFqPx5
         FFTzrbL0qGAmp4QQmDAHtXhmDxQwRQzxP6Zz63ev9ibO4mNXS02daTjtTvKDDOtzKJDM
         NTrGkVz3QR7wgDP8mnmc2ptM9FvDEKLkE1t5aOFcf3ov0ukGSoHuW8YTD0ktrC+E1EaQ
         qIrw==
X-Gm-Message-State: AJIora+lKIzG7LxNWMw07YV7lRB6uUtFmnaqeCNjdBJ0RujaZ7UhGJlx
        4mo/7BvNbGIC7Q4UskujMMST6YqABJ7Zn+ItGPE=
X-Google-Smtp-Source: AGRyM1vFrYsD8dxIlyMDKCDvUqc32NKEJvwJUfUdGYbkZf9GNPkNqxN4lONGSboyog1ULbP2etk+CzOoa7ynMI88K/8=
X-Received: by 2002:ac5:cb6f:0:b0:36c:424b:6d79 with SMTP id
 l15-20020ac5cb6f000000b0036c424b6d79mr21724327vkn.14.1657075285164; Tue, 05
 Jul 2022 19:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220702033521.64630-1-roman.gushchin@linux.dev>
 <CALvZod7TGhWtcRD6HeEx90T2+Rod-yamq9i+WbEQUKwNFTi-1A@mail.gmail.com>
 <YsBmoqEBCa7ra7w2@castle> <YsMCMveSdiYX/2eH@dhcp22.suse.cz>
 <YsMHkXJ0vAPG0lyM@dhcp22.suse.cz> <YsSkaiL00Jk45zNd@castle>
In-Reply-To: <YsSkaiL00Jk45zNd@castle>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 6 Jul 2022 10:40:48 +0800
Message-ID: <CALOAHbBrctf_wOiAxUvXD0JSjgEV46YdDQh9QnUK0XZ+Jsapnw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: do not miss MEMCG_MAX events for enforced allocations
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 6, 2022 at 4:52 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Mon, Jul 04, 2022 at 05:30:25PM +0200, Michal Hocko wrote:
> > On Mon 04-07-22 17:07:32, Michal Hocko wrote:
> > > On Sat 02-07-22 08:39:14, Roman Gushchin wrote:
> > > > On Fri, Jul 01, 2022 at 10:50:40PM -0700, Shakeel Butt wrote:
> > > > > On Fri, Jul 1, 2022 at 8:35 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > > > >
> > > > > > Yafang Shao reported an issue related to the accounting of bpf
> > > > > > memory: if a bpf map is charged indirectly for memory consumed
> > > > > > from an interrupt context and allocations are enforced, MEMCG_MAX
> > > > > > events are not raised.
> > > > > >
> > > > > > It's not/less of an issue in a generic case because consequent
> > > > > > allocations from a process context will trigger the reclaim and
> > > > > > MEMCG_MAX events. However a bpf map can belong to a dying/abandoned
> > > > > > memory cgroup, so it might never happen.
> > > > >
> > > > > The patch looks good but the above sentence is confusing. What might
> > > > > never happen? Reclaim or MAX event on dying memcg?
> > > >
> > > > Direct reclaim and MAX events. I agree it might be not clear without
> > > > looking into the code. How about something like this?
> > > >
> > > > "It's not/less of an issue in a generic case because consequent
> > > > allocations from a process context will trigger the direct reclaim
> > > > and MEMCG_MAX events will be raised. However a bpf map can belong
> > > > to a dying/abandoned memory cgroup, so there will be no allocations
> > > > from a process context and no MEMCG_MAX events will be triggered."
> > >
> > > Could you expand little bit more on the situation? Can those charges to
> > > offline memcg happen indefinetely? How can it ever go away then? Also is
> > > this something that we actually want to encourage?
> >
> > One more question. Mostly out of curiosity. How is userspace actually
> > acting on those events? Are watchers still active on those dead memcgs?
>
> Idk, the whole problem was reported by Yafang, so he probably has a better
> answer. But in general events are recursive and the cgroup doesn't have
> to be dying, it can be simple abandoned.
>

Regarding the pinned bpf programs, it can run without a user agent.
That means the cgroup may not be dead, but just not populated.
(But in our case, the cgroup will be deleted after the user agent exits.)

-- 
Regards
Yafang
