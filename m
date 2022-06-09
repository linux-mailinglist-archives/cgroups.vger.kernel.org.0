Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00EB5441C8
	for <lists+cgroups@lfdr.de>; Thu,  9 Jun 2022 05:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbiFIDKa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Jun 2022 23:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiFIDK3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Jun 2022 23:10:29 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D44138B4
        for <cgroups@vger.kernel.org>; Wed,  8 Jun 2022 20:10:27 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-30c2f288f13so227995867b3.7
        for <cgroups@vger.kernel.org>; Wed, 08 Jun 2022 20:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=prJZ/uo7UIALihmdPzzIspieUD/287bdX03VvGNkEtE=;
        b=REUWSS+ZiecOI0jFJ+1hDHJWaaNE+Uma0xvvhpPRCKbT3/8Wub2DzjO90JbYnUOBky
         qiNoFUI0Acou00j/JzbGRebEl06K0lRV5oG+kaZIAqOBG3INGWR28oj1ifMGH8DS4ZOv
         s/1cp4XxA1i5QEJvF0dnO+CRR1q20nsbIkzczmGdunl5zMxzGxzZzIOMzC2enKeEP7SO
         knvk8yK3HJJwDj+bW7FsUoFaveNOZrg3LxaFHDSZlx2A4rV/rmSjblb8OLVVQ6/+WOUO
         x04hz9I92bnFYhEsJTQb2RtL8mO2io8GYmtHw31ieV++wckU1ZDCLM9RX3QsCOtgsP3J
         /2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=prJZ/uo7UIALihmdPzzIspieUD/287bdX03VvGNkEtE=;
        b=Os2DX350Rkp6CbPlZe2pbAy7nubi4+5YFvyw7lihjw35pAQV2Puamyjo4bOUBzqlZg
         QShundSi/jlayh9qEORnBbFQtodKMZqcCf3Pp+EoBSo9FUfnYM1PFrPshI+mqnWtLDpl
         24IxpMJvFOfaa+IoaFsBaNsVZPvkUYilyNkgA+WrC3GjZ96LxfZn2FKqR7N+hTLSGlw3
         WKWBsZFjuufiJTJczdwVKUtnP5il1i5ERKUUlqI/Pln31kt45QjhbQo6lF+xzwAGJFZG
         AkK9zdzFcm7PtY3xy3e+wMefTE6sJLxOgJb9o3uKKDtVPGmqdq/KtGSBdQd7c8U1vpxi
         uJ0A==
X-Gm-Message-State: AOAM530sYDV91w/XLs8/9sUWEwtx8gOQDfda7hHAiBUmaWkb0TEn65os
        Rikk3wYizlEbyWEqKSR7jhOG9spdcD6GvS/beVeSjQ==
X-Google-Smtp-Source: ABdhPJz1gszpgyB1Lrnk5GNipCI7kIHAMtNtVS/6o6rhzmoPC6DfXgdv7hwTzhnWzjzkpewQkKAT3ERpIEq4hbMw6Jg=
X-Received: by 2002:a81:a1d3:0:b0:30f:c7f0:7b62 with SMTP id
 y202-20020a81a1d3000000b0030fc7f07b62mr38887831ywg.458.1654744226573; Wed, 08
 Jun 2022 20:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <CAMZfGtX4hseDnJA9JrsXDG=nu28h+9UMMpKFnBZCL47Re1OvUg@mail.gmail.com> <YqFgt6nZn78euEb/@carbon>
In-Reply-To: <YqFgt6nZn78euEb/@carbon>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 9 Jun 2022 11:09:50 +0800
Message-ID: <CAMZfGtUqMfhSLLDLO6Dnj9+1HNM1jNTqDZN5higNoR1gRYnbbQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] Use obj_cgroup APIs to charge the LRU pages
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Waiman Long <longman@redhat.com>
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

On Thu, Jun 9, 2022 at 10:53 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Thu, Jun 09, 2022 at 10:43:24AM +0800, Muchun Song wrote:
> > Hi,
> >
> > Friendly ping. Any comments or objections?
>
> I'm sorry, I was recently busy with some other stuff, but it's on my todo list.
> I'll try to find some time by the end of the week.

Got it. Thanks Roman. Looking forward to your reviews.

>
> Thanks!
>
> >
> > Thanks.
> >
> > On Mon, May 30, 2022 at 3:50 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > This version is rebased on v5.18.
> > >
> > > Since the following patchsets applied. All the kernel memory are charged
> > > with the new APIs of obj_cgroup.
> > >
> > >         [v17,00/19] The new cgroup slab memory controller [1]
> > >         [v5,0/7] Use obj_cgroup APIs to charge kmem pages [2]
>
> Btw, both these patchsets were merged a long time ago, so you can refer
> to upstream commits instead.

Will do.

Thanks.
