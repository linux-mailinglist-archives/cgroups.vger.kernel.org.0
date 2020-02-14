Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF8215CF67
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2020 02:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgBNBRs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Feb 2020 20:17:48 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:45845 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgBNBRr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Feb 2020 20:17:47 -0500
Received: by mail-il1-f195.google.com with SMTP id p8so6668108iln.12;
        Thu, 13 Feb 2020 17:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X1rUbbk5eSi/RPUfUTIVpYH2GwBV8H1jUAjzu+pVHyM=;
        b=gbZ6FcplDBHiAEulkuso5ll5gdmYYNALxEiNfJPbgUQJzqp5Hr73oBkRdE8+jbq8Hr
         rYTgJ9Zd5ZGkMLSr3gGEbKqllTFSCHBTo0JsdLa1MjrztRe38LWfLxBltiEBfcllz6qF
         xx1PzIeoOoIZhzR5DVoYmZp5qiW+Nh0bS8XB1BN3BDLkcJk3utWVtkrcQt3eC5GAOlm+
         pGCYWW6e0BBV1rGBknKtohqKld6cGV+9CZ13olsdim8mYe5/zay51ZNAE0cig9IXQTuM
         y9xYCUNMj9FNuopMkInsN/7fCmhkvj5DhKpJ6m/nq30JcU6CIRvrSV0NIWQEw8qVipKK
         69Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X1rUbbk5eSi/RPUfUTIVpYH2GwBV8H1jUAjzu+pVHyM=;
        b=VhyGrbv8QkfS+PljojJGsNCHmKKy/mzq2945YSACInu69AlVzbMgaNSsMiZY3exbR/
         kH1RWaD8zdy7KHxM8eJu1x+FFvTQokN3wCXNmeSZeDZoYfO27QRuzl5Lc5w7CrFD5GXQ
         nsonwy65o7luL3geXSdK3LcocHk2TQtcFaZhlBNvewPFZO58SdMjKt3t4+yALQlff7Zg
         8d4pBvVQP853lZ6NCirCOu4tcoxR3jrKYZA7jESCgXXWhpeBmUYxodrLRHNuw4Iyb1c1
         ifFN2VJjFpKVFsWEdjpFduq07XwekYT47KyVxexDoKrGLs1Bbsea+xpHk6a790A7jI+j
         Juaw==
X-Gm-Message-State: APjAAAV+ILiJOjlBinqweml9AwYTsD+hmxj4dSxmQrYDNO9WtZ4zY+9Z
        uxhN5PkdjQvxSTC+3iU1geWQgbta6sFMHdKv2h0=
X-Google-Smtp-Source: APXvYqxwxFCj6n+1QMs138xtb6xzqoB8/piWann9YVdb28UDFyW/hYLkv9lslL+PtIqjR89Z0iCaBeUCRIev8K5CFCg=
X-Received: by 2002:a92:8656:: with SMTP id g83mr750858ild.9.1581643066684;
 Thu, 13 Feb 2020 17:17:46 -0800 (PST)
MIME-Version: 1.0
References: <20191107205334.158354-1-hannes@cmpxchg.org> <20191107205334.158354-3-hannes@cmpxchg.org>
 <20200212102817.GA18107@js1304-desktop> <20200212181834.GD180867@cmpxchg.org>
In-Reply-To: <20200212181834.GD180867@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 14 Feb 2020 10:17:35 +0900
Message-ID: <CAAmzW4OSgYYZQuxkiL4UjCp97SnL+Ott7FB9__txQjGjO8UFmw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: vmscan: detect file thrashing at the reclaim root
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

2020=EB=85=84 2=EC=9B=94 13=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 3:18, J=
ohannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Feb 12, 2020 at 07:28:19PM +0900, Joonsoo Kim wrote:
> > Hello, Johannes.
> >
> > When I tested my patchset on v5.5, I found that my patchset doesn't
> > work as intended. I tracked down the issue and this patch would be the
> > reason of unintended work. I don't fully understand the patchset so I
> > could be wrong. Please let me ask some questions.
> >
> > On Thu, Nov 07, 2019 at 12:53:33PM -0800, Johannes Weiner wrote:
> > ...snip...
> > > -static void snapshot_refaults(struct mem_cgroup *root_memcg, pg_data=
_t *pgdat)
> > > +static void snapshot_refaults(struct mem_cgroup *target_memcg, pg_da=
ta_t *pgdat)
> > >  {
> > > -   struct mem_cgroup *memcg;
> > > -
> > > -   memcg =3D mem_cgroup_iter(root_memcg, NULL, NULL);
> > > -   do {
> > > -           unsigned long refaults;
> > > -           struct lruvec *lruvec;
> > > +   struct lruvec *target_lruvec;
> > > +   unsigned long refaults;
> > >
> > > -           lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
> > > -           refaults =3D lruvec_page_state_local(lruvec, WORKINGSET_A=
CTIVATE);
> > > -           lruvec->refaults =3D refaults;
> > > -   } while ((memcg =3D mem_cgroup_iter(root_memcg, memcg, NULL)));
> > > +   target_lruvec =3D mem_cgroup_lruvec(target_memcg, pgdat);
> > > +   refaults =3D lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE=
);
> > > +   target_lruvec->refaults =3D refaults;
> >
> > Is it correct to just snapshot the refault for the target memcg? I
> > think that we need to snapshot the refault for all the child memcgs
> > since we have traversed all the child memcgs with the refault count
> > that is aggregration of all the child memcgs. If next reclaim happens
> > from the child memcg, workingset transition that is already considered
> > could be considered again.
>
> Good catch, you're right! We have to update all cgroups in the tree,
> like we used to. However, we need to use lruvec_page_state() instead
> of _local, because we do recursive comparisons in shrink_node()! So
> it's not a clean revert of that hunk.
>
> Does this patch here fix the problem you are seeing?

I found that my problem comes from my mistake.
Sorry for bothering you!

Anyway, following hunk looks correct to me.

Acked-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c82e9831003f..e7431518db13 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2993,12 +2993,17 @@ static void shrink_zones(struct zonelist *zonelis=
t, struct scan_control *sc)
>
>  static void snapshot_refaults(struct mem_cgroup *target_memcg, pg_data_t=
 *pgdat)
>  {
> -       struct lruvec *target_lruvec;
> -       unsigned long refaults;
> +       struct mem_cgroup *memcg;
>
> -       target_lruvec =3D mem_cgroup_lruvec(target_memcg, pgdat);
> -       refaults =3D lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE=
);
> -       target_lruvec->refaults =3D refaults;
> +       memcg =3D mem_cgroup_iter(target_memcg, NULL, NULL);
> +       do {
> +               unsigned long refaults;
> +               struct lruvec *lruvec;
> +
> +               lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
> +               refaults =3D lruvec_page_state(lruvec, WORKINGSET_ACTIVAT=
E);
> +               lruvec->refaults =3D refaults;
> +       } while ((memcg =3D mem_cgroup_iter(target_memcg, memcg, NULL)));
>  }
>
>  /*
>
> > > @@ -277,12 +305,12 @@ void workingset_refault(struct page *page, void=
 *shadow)
> > >      * would be better if the root_mem_cgroup existed in all
> > >      * configurations instead.
> > >      */
> > > -   memcg =3D mem_cgroup_from_id(memcgid);
> > > -   if (!mem_cgroup_disabled() && !memcg)
> > > +   eviction_memcg =3D mem_cgroup_from_id(memcgid);
> > > +   if (!mem_cgroup_disabled() && !eviction_memcg)
> > >             goto out;
> > > -   lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
> > > -   refault =3D atomic_long_read(&lruvec->inactive_age);
> > > -   active_file =3D lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_Z=
ONES);
> > > +   eviction_lruvec =3D mem_cgroup_lruvec(eviction_memcg, pgdat);
> > > +   refault =3D atomic_long_read(&eviction_lruvec->inactive_age);
> > > +   active_file =3D lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE=
);
> >
> > Do we need to use the aggregation LRU count of all the child memcgs?
> > AFAIU, refault here is the aggregation counter of all the related
> > memcgs. Without using the aggregation count for LRU, active_file could
> > be so small than the refault distance and refault cannot happen
> > correctly.
>
> lruvec_page_state() *is* aggregated for all child memcgs (as opposed
> to lruvec_page_state_local()), so that comparison looks correct to me.

Thanks for informing this.
I have checked lruvec_page_state() but not mod_lruvec_state() so cannot
find that counter is the aggregated value.

Thanks.
