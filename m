Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F9537F065
	for <lists+cgroups@lfdr.de>; Thu, 13 May 2021 02:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhEMAhD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 May 2021 20:37:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhEMAd0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 12 May 2021 20:33:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E923613DF;
        Thu, 13 May 2021 00:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620865933;
        bh=NqerZcueDe5Vdup5YWaIr/cMiCRyTzm7WBaBKhWYa7o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L00Jcm0ErlbgR36ajW4jCZFAKDnlSvY9k0wYlsDluPw9zlduW/bOD6JVblaQcOt+q
         z46YCVZw8lws+725jTiNN7kC0DWof2X8vMlEDhc1T5+yyuhwo3cRh+uQaGIs4NQBX6
         VKcQn7lVOU3pR8dh+zEbvvU3oM6VTG9J4VaohlS4=
Date:   Wed, 12 May 2021 17:32:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <llong@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5 2/3] mm: memcg/slab: Create a new set of
 kmalloc-cg-<n> caches
Message-Id: <20210512173212.738f592c36bf0e4c205f628e@linux-foundation.org>
In-Reply-To: <0919aaab-cc08-f86d-1f9a-8ddfeed7bb31@redhat.com>
References: <20210505200610.13943-1-longman@redhat.com>
        <20210512145107.6208-1-longman@redhat.com>
        <0919aaab-cc08-f86d-1f9a-8ddfeed7bb31@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 12 May 2021 10:54:19 -0400 Waiman Long <llong@redhat.com> wrote:

> >   include/linux/slab.h | 42 +++++++++++++++++++++++++++++++++---------
> >   mm/slab_common.c     | 25 +++++++++++++++++--------
> >   2 files changed, 50 insertions(+), 17 deletions(-)
>=20
> The following are the diff's from previous version. It turns out that=20
> the previous patch doesn't work if CONFIG_ZONE_DMA isn't defined.
>=20
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index a51cad5f561c..aa7f6c222a60 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -312,16 +312,17 @@ static inline void __check_heap_object(const void=20
> *ptr, un
> signed long n,
>  =A0 */
>  =A0enum kmalloc_cache_type {
>  =A0=A0=A0=A0 KMALLOC_NORMAL =3D 0,
> -#ifdef CONFIG_MEMCG_KMEM
> -=A0=A0=A0 KMALLOC_CGROUP,
> -#else
> +#ifndef CONFIG_ZONE_DMA
> +=A0=A0=A0 KMALLOC_DMA =3D KMALLOC_NORMAL,
> +#endif
> +#ifndef CONFIG_MEMCG_KMEM
>  =A0=A0=A0=A0 KMALLOC_CGROUP =3D KMALLOC_NORMAL,
> +#else
> +=A0=A0=A0 KMALLOC_CGROUP,
>  =A0#endif
>  =A0=A0=A0=A0 KMALLOC_RECLAIM,
>  =A0#ifdef CONFIG_ZONE_DMA
>  =A0=A0=A0=A0 KMALLOC_DMA,
> -#else
> -=A0=A0=A0 KMALLOC_DMA =3D KMALLOC_NORMAL,
>  =A0#endif
>  =A0=A0=A0=A0 NR_KMALLOC_TYPES
>  =A0};

I assume this fixes
https://lkml.kernel.org/r/20210512152806.2492ca42@canb.auug.org.au?

