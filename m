Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C788A6DE1C2
	for <lists+cgroups@lfdr.de>; Tue, 11 Apr 2023 19:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjDKRAq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Apr 2023 13:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDKRAm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Apr 2023 13:00:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBB119A6
        for <cgroups@vger.kernel.org>; Tue, 11 Apr 2023 10:00:15 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gb34so22280643ejc.12
        for <cgroups@vger.kernel.org>; Tue, 11 Apr 2023 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681232412; x=1683824412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3nf45VfTna2qtmHbcyQx3azMJIZK67P9z9b6hMPmWY=;
        b=ygamK3A3NM1JD2kKgXRiue98TQPKvYM28SIh/wf7BXymkX7onuXLJL3zdwCTUe/eVe
         SIrwlFECWwZJJri9YnaDb7qj+p3Fx8mztu1CVpQMc/XKpJLJlWPcEMyzHAaCZxvxJUip
         7FrcmhZzUhSkqU/9ce+HuOqM+20Y6naugqTmb3UDLmOMbosxkWeNqwmpF/mr+icSJFEA
         DkfsjBlrrbGUYgnxglGGrWrB3iI0El6Hk8tD6oRP64tYwrP2NsbfZPf5khW44kuDdufB
         HB1CpOLX1xMCVefNbt6lQkTWz8mUP82sqHSntwR7puMl5Pt+e551R9IduCfw125lUGRr
         smYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232412; x=1683824412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3nf45VfTna2qtmHbcyQx3azMJIZK67P9z9b6hMPmWY=;
        b=R/+ZzZYBVrkXxcO7N2pZaka2R5KoUD6fDb8aVGRMJUeZ/qtrbcKGRnjnDhS0BAWm4F
         6J1R/zBp4wsANJsMbACvJ/qNTvwW0aguwEA7f9/cSudehc9hK/d2hxLYsjpuhadcz3+M
         QGUjHYmFZqHDjCstrRKqSkWi5LBlfi7xao2gFB67GQdCYdKbVh+vq13yof4irH6Q+pbN
         a6UIlVDl6cgR74+BcyEDw/T0thaPlIE3l86YYh130xdT4RKlzh/Kh4jH2+EJF0jR5/4f
         ymKDPqTa+LEzoewpAWzVGoqLaRQmPJZX2ujCwbvc0QXNAX2PXDRGiVxpAzIKq/dnHYwA
         pmuw==
X-Gm-Message-State: AAQBX9egXmfPFFBCOjKNjeBMeCS3oJCvICLUQYwXL6HaX/3QRSNeKt/f
        zfyNXnyvrMLEejKRd6cvuBtLUQ55423d8wHFwnJXog==
X-Google-Smtp-Source: AKy350ZW8S84YwpJunppz3ww3yhitaeClTtiiyiJjfqra0sZdbCcVIjRXcLCOKK5B5VWEIh0bCIqB8Wu+sY8Gfrx4pU=
X-Received: by 2002:a17:906:2556:b0:94b:d619:e773 with SMTP id
 j22-20020a170906255600b0094bd619e773mr1626314ejb.15.1681232411678; Tue, 11
 Apr 2023 10:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com>
 <20230403220337.443510-4-yosryahmed@google.com> <rdjvbr5zuwic27s27xcmguce2wfbqiyeu4bjr5pfxhprlxecui@4wsoogvb4ivp>
In-Reply-To: <rdjvbr5zuwic27s27xcmguce2wfbqiyeu4bjr5pfxhprlxecui@4wsoogvb4ivp>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 11 Apr 2023 09:59:35 -0700
Message-ID: <CAJD7tkZvRek3hJ1AyC7rPjTJTkKCM0DNLaTu1XXLGKmc3gdztA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable RFC 3/5] memcg: calculate root usage from
 global state
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 11, 2023 at 5:53=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Mon, Apr 03, 2023 at 10:03:35PM +0000, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > Instead, approximate the root usage from global state. This is not 100%
> > accurate, but the root usage has always been ill-defined anyway.
>
> Technically, this approximation should be closer to truth because global
> counters aren't subject to flushing "delay".

It is a tiny bit different when some pages are in swap, probably
because of swap slot caching and other swap specifics. At least in
cgroup v1, the swap uncharging and freeing of the underlying swap
entry may happen at different times. I think it practically doesn't
really matter though.

>
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  mm/memcontrol.c | 24 +++++-------------------
> >  1 file changed, 5 insertions(+), 19 deletions(-)
>
> But feel free to add
> Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>

Thanks!
>
