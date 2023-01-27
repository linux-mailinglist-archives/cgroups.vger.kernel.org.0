Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3B167DD29
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 06:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjA0FlU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 00:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjA0FlT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 00:41:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6856570D43
        for <cgroups@vger.kernel.org>; Thu, 26 Jan 2023 21:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674798037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1/nlRzFE8uEH2KN6NvFa3jRsSiNKHTj9vX5XMb/Z35s=;
        b=ILXIu9UM7b2eDQzZS7j2WgAidEvgP1FAecA2fF7pSG/gA4M3lesvYdgeaUt+6qmbJPB98H
        m9zgrpr4cqg/OkN/3tGKVO6jtQ6PLnmENCP7laJMUyRcTkAvVzxwpGKDYLxoN3PG4Bfx+w
        AdUU8CtQ2y53+I/1jX/VW2G6Ld/+J+A=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-345-6djaRJoxOkydld8-LffL4A-1; Fri, 27 Jan 2023 00:40:36 -0500
X-MC-Unique: 6djaRJoxOkydld8-LffL4A-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1631f1eb91aso1356282fac.18
        for <cgroups@vger.kernel.org>; Thu, 26 Jan 2023 21:40:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/nlRzFE8uEH2KN6NvFa3jRsSiNKHTj9vX5XMb/Z35s=;
        b=iR6tX6PKotRUe4qbxVPkKJICuE+9+TqNEfd91ZbeqGO4dYq0h73cJRbhd5ZuLqWSe0
         GuGKAk5kblY4hN8du6B7SS6feiJa321tL4VQlq/mQ40CS0Owsqz5z97lOgZ9bYd9/4/a
         jVFf1M8RPTrJvJO6CW5KewJDIDxT5xAx8R4HG71afYHnFKSZytPYLo4WFksjDYhp8E5b
         e+l4iz3xtlbxN2aplFMx5PKPuwNZs8gi5i4hdToPnUZCoG4i264Qjg2PJ9JWFEtSydSi
         QpQp9QdqcEfOJibYzQRRRi3MnHUmhRFxSHgp+PgeJxnOg1tPS2IvZTtxnc7f/YLymWx5
         Seyw==
X-Gm-Message-State: AO0yUKWG/AzAgL1GmAdJm5XXvDtvPopazAmWWh3lE/5n/d12NlhWOMnl
        WdUw5ADDPn+GJbnKqo0x/dgDqAX472nd9sgCbqYrLZ2vKoXkRJj+duxiavpTiHqp6M1Z9/BtDCE
        N/2HULYDA2v6rkoL60Q==
X-Received: by 2002:a05:6871:824:b0:163:6dfc:755b with SMTP id q36-20020a056871082400b001636dfc755bmr747751oap.24.1674798035414;
        Thu, 26 Jan 2023 21:40:35 -0800 (PST)
X-Google-Smtp-Source: AK7set+gOU/E4LLHCIEREuBaAclxcItR+R67IH4Yta6AaWQrnjayQqogFXCB61xcxPBZzjam4UVDAw==
X-Received: by 2002:a05:6871:824:b0:163:6dfc:755b with SMTP id q36-20020a056871082400b001636dfc755bmr747738oap.24.1674798035177;
        Thu, 26 Jan 2023 21:40:35 -0800 (PST)
Received: from ?IPv6:2804:1b3:a800:6912:c477:c73a:cf7c:3a27? ([2804:1b3:a800:6912:c477:c73a:cf7c:3a27])
        by smtp.gmail.com with ESMTPSA id lg6-20020a0568700b8600b00150835847c2sm1403175oab.16.2023.01.26.21.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 21:40:34 -0800 (PST)
Message-ID: <9ec001ba093e21a5ac2cafa1c61810b035daf13d.camel@redhat.com>
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Jan 2023 02:40:28 -0300
In-Reply-To: <Y9LEQfX5dkEyBOkT@tpad>
References: <20230125073502.743446-1-leobras@redhat.com>
         <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
         <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
         <Y9FzSBw10MGXm2TK@tpad> <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
         <Y9LEQfX5dkEyBOkT@tpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 2023-01-26 at 15:19 -0300, Marcelo Tosatti wrote:
> On Wed, Jan 25, 2023 at 03:14:48PM -0800, Roman Gushchin wrote:
> > On Wed, Jan 25, 2023 at 03:22:00PM -0300, Marcelo Tosatti wrote:
> > > On Wed, Jan 25, 2023 at 08:06:46AM -0300, Leonardo Br=C3=A1s wrote:
> > > > On Wed, 2023-01-25 at 09:33 +0100, Michal Hocko wrote:
> > > > > On Wed 25-01-23 04:34:57, Leonardo Bras wrote:
> > > > > > Disclaimer:
> > > > > > a - The cover letter got bigger than expected, so I had to spli=
t it in
> > > > > >     sections to better organize myself. I am not very confortab=
le with it.
> > > > > > b - Performance numbers below did not include patch 5/5 (Remove=
 flags
> > > > > >     from memcg_stock_pcp), which could further improve performa=
nce for
> > > > > >     drain_all_stock(), but I could only notice the optimization=
 at the
> > > > > >     last minute.
> > > > > >=20
> > > > > >=20
> > > > > > 0 - Motivation:
> > > > > > On current codebase, when drain_all_stock() is ran, it will sch=
edule a
> > > > > > drain_local_stock() for each cpu that has a percpu stock associ=
ated with a
> > > > > > descendant of a given root_memcg.
> >=20
> > Do you know what caused those drain_all_stock() calls? I wonder if we s=
hould look
> > into why we have many of them and whether we really need them?
> >=20
> > It's either some user's actions (e.g. reducing memory.max), either some=
 memcg
> > is entering pre-oom conditions. In the latter case a lot of drain calls=
 can be
> > scheduled without a good reason (assuming the cgroup contain multiple t=
asks running
> > on multiple cpus). Essentially each cpu will try to grab the remains of=
 the memory quota
> > and move it locally. I wonder in such circumstances if we need to disab=
le the pcp-caching
> > on per-cgroup basis.
> >=20
> > Generally speaking, draining of pcpu stocks is useful only if an idle c=
pu is holding some
> > charges/memcg references (it might be not completely idle, but running =
some very special
> > workload which is not doing any kernel allocations or a process belongi=
ng to the root memcg).
> > In all other cases pcpu stock will be either drained naturally by an al=
location from another
> > memcg or an allocation from the same memcg will "restore" it, making dr=
aining useless.
> >=20
> > We also can into drain_all_pages() opportunistically, without waiting f=
or the result.
> > On a busy system it's most likely useless, we might oom before schedule=
d works will be executed.
> >=20
> > I admit I planned to do some work around and even started, but then nev=
er had enough time to
> > finish it.
> >=20
> > Overall I'm somewhat resistant to an idea of making generic allocation =
& free paths slower
> > for an improvement of stock draining. It's not a strong objection, but =
IMO we should avoid
> > doing this without a really strong reason.
>=20
> The expectation would be that cache locking should not cause slowdown of
> the allocation and free paths:
>=20
> https://manualsbrain.com/en/manuals/1246877/?page=3D313
>=20
> For the P6 and more recent processor families, if the area of memory bein=
g locked=20
> during a LOCK operation is cached in the processor that is performing the=
 LOCK oper-
> ation as write-back memory and is completely contained in a cache line, t=
he=20
> processor may not assert the LOCK# signal on the bus. Instead, it will mo=
dify the=20
> memory location internally and allow it=E2=80=99s cache coherency mechani=
sm to insure that=20
> the operation is carried out atomically. This operation is called =E2=80=
=9Ccache locking.=E2=80=9D The=20
> cache coherency mechanism automatically prevents two or more processors t=
hat ...
>=20
>=20

Just to keep the info easily available: the protected structure (struct
memcg_stock_pcp) fits in 48 Bytes, which is less than the usual 64B cacheli=
ne.=20

struct memcg_stock_pcp {
	spinlock_t                 stock_lock;           /*     0     4 */
	unsigned int               nr_pages;             /*     4     4 */
	struct mem_cgroup *        cached;               /*     8     8 */
	struct obj_cgroup *        cached_objcg;         /*    16     8 */
	struct pglist_data *       cached_pgdat;         /*    24     8 */
	unsigned int               nr_bytes;             /*    32     4 */
	int                        nr_slab_reclaimable_b; /*    36     4 */
	int                        nr_slab_unreclaimable_b; /*    40     4 */

	/* size: 48, cachelines: 1, members: 8 */
	/* padding: 4 */
	/* last cacheline: 48 bytes */
};

(It got smaller after patches 3/5, 4/5 and 5/5, which remove holes, work_st=
ruct
and flags respectively.)

On top of that, patch 1/5 makes sure the percpu allocation is aligned to
cacheline size.

