Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6693B5A5C94
	for <lists+cgroups@lfdr.de>; Tue, 30 Aug 2022 09:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiH3HIn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 30 Aug 2022 03:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiH3HHf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 30 Aug 2022 03:07:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767B4C59EF;
        Tue, 30 Aug 2022 00:07:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id q15so5097520pfn.11;
        Tue, 30 Aug 2022 00:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=I6h+p+HXVP3mSqfdvkmPovmRewn0b+siAgR4AO+P2BE=;
        b=Y3eReunSE2Y54gGd+4yIdZ0icTwQ5EJ/3dWQgm/g6JFNU/y72JrhdvOTk32zvNxcFd
         YqToO/fmRoRruDY85/WP3/6GEu6ZpU2qXYmfCRhJ6P0l/AXwXBzZMibHdBySun+aifOz
         aGGehvk94R59ZeGRUPSTvaIo/lDczky3Ea3QpAGWmTR4/MZ8OUVBlt8DkqecYft03QyL
         /HmLgCE5weDZbiSxff706yg9YZD5GnG4RKMF/aJ7Cs29cmE1xOPJqF9zPtOPNi4mS2e2
         9cN7/wjPKiXLFdIclE3ZEFWNp8kYcQjof69Pir0esfprnaTn5AATb0v5m5OKafI8+XhS
         8f9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=I6h+p+HXVP3mSqfdvkmPovmRewn0b+siAgR4AO+P2BE=;
        b=BgDcy5DtyHinmTnzoMAf3Wmz37vyG/dO9QbPEgsjDtb4+jW9i15YDOVlTL9jTQtseT
         CMGftWnv1ILbULm/lORRHTYomAN4XTraXINEpxQ8y2MoWM0J5uM2VPkHezk30Bbdueab
         p6znkeIbZwdoBDdSTL2MkESqE9f8z+6ohpV7icdxE9KmL7PNmKMZH/vbnJEEFPUvoz8N
         kBl7XUCxJSlehzkPuccwhL1A/4xY3AKvWvU4HXWOQq+bazUHpaqrjFyMlNkWR75kHcfd
         YWU+LHvhKQk2Jld8uVNjhPEpT40+GsUuS2xAQyuE28wXiqwx5RoU0Phul5o5WehVqtf8
         Qtqg==
X-Gm-Message-State: ACgBeo3Z4OjzOEwVYCs/ahTHmgmYXRY8x3sQKtGNpgzM98uYR7ss6c0Y
        SJPROpyc3qNaLkkRf6XnA9fUDW6t4vtEE/3kJ6U=
X-Google-Smtp-Source: AA6agR58zClFWgeDJ0kAO0l5oaczNFAetdbjSu3zeENeI/vImtl4fx37vRtls8nsHMSAEjMRc8IZTGBuH26A/8CRR4k=
X-Received: by 2002:a63:4a4b:0:b0:427:d453:78b6 with SMTP id
 j11-20020a634a4b000000b00427d45378b6mr17212423pgl.318.1661843230041; Tue, 30
 Aug 2022 00:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220830055949.12640-1-ryncsn@gmail.com> <20220830055949.12640-2-ryncsn@gmail.com>
 <Yw2x6T3xchjpzX7j@dhcp22.suse.cz>
In-Reply-To: <Yw2x6T3xchjpzX7j@dhcp22.suse.cz>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Tue, 30 Aug 2022 15:06:57 +0800
Message-ID: <CAMgjq7A+Ju247rC7+fo9jcZpK8rkd0Ou6e=7qzgL4rV3JWBX5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: memcontrol: remove mem_cgroup_kmem_disabled
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko <mhocko@suse.com> =E4=BA=8E2022=E5=B9=B48=E6=9C=8830=E6=97=A5=
=E5=91=A8=E4=BA=8C 14:45=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue 30-08-22 13:59:48, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > There are currently two helpers for checking if cgroup kmem
> > accounting is enabled:
> >
> > - mem_cgroup_kmem_disabled
> > - memcg_kmem_enabled
>
> Yes, this is a bit confusing indeed!
>
> > mem_cgroup_kmem_disabled is a simple helper that returns true if
> > cgroup.memory=3Dnokmem is specified, otherwise returns false.
> >
> > memcg_kmem_enabled is a bit different, it returns true if
> > cgroup.memory=3Dnokmem is not specified and there is at least one
> > non-root cgroup ever created. And once there is any non-root memcg
> > created, it won't go back to return false again.
> >
> > This may help improve performance for some corner use cases where
> > the user enables memory cgroup and kmem accounting globally but never
> > create any cgroup.
> >
> > Considering that corner case is rare, especially nowadays cgroup is
> > widely used as a standard way to organize services.
>
> Is it really that rare? Most configurations would use a default setup, so
> both MEMCG enabled and without nokmem on cmd line yet the memory
> controller is not enabled in their setups.

Actually I don't have too much confidence saying that as well... but
AFAIK, almost all distros will create a few sub cgroup on boot by the
init (eg. openrc, finit, systemd).
Maybe it's not that rare indeed.

>
> > And the "once
> > enabled never disable" behavior is kind of strange. This commit simplif=
ies
> > the behavior of memcg_kmem_enabled, making it simply the opposite of
> > mem_cgroup_kmem_disabled, always true if cgroup.memory=3Dnokmem is
> > not specified. So mem_cgroup_kmem_disabled can be dropped.
> >
> > This simplifies the code, and besides, memcg_kmem_enabled makes use
> > of static key so it has a lower overhead.
>
> I agree that this is slightly confusing and undocumented. The first step
> would be finding out why we need both outside of the memcg proper.
>
> E.g. it doesn't make much sense to me that count_objcg_event uses the
> command line variant when it should be using the dynamic (and more
> optimized no branch) variant.
>
> On the other hand pcpu_alloc_chunk seems to be different because it can
> be called before the controller is enabled but maybe we do not need to
> waste memory before that? Similarly new_kmalloc_cache. I suspect these
> are mostly to simplify the code and reduce special casing.

Yes, that's very insightful, let me tidy up the code and logic behind
and send a V2 later.
