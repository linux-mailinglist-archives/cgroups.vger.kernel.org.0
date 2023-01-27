Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BCD67DEE3
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 09:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjA0INF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 03:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjA0INE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 03:13:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AA47641F
        for <cgroups@vger.kernel.org>; Fri, 27 Jan 2023 00:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674807141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tfn6EbWtPNJebb879MWv3dOIAf3Kgq4dei2DnXcoD6U=;
        b=DXVnTFLZJfNCLJ4JUjjqt3odxigb9eCzLJVfkvtpcCLjtI5Sfttrz75yUEFmE15Vq8pxrc
        xuEvF0zayt2PwhZbBCRCVtc+YPBKKmidOJXmxeHG3hU7TzLgQ6moCszcDBkgZS90Z5PIh3
        As/8xPyJO12XIAICElM7vaVtRgrh26g=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-xgFgSY95OhmTag_cjASj-w-1; Fri, 27 Jan 2023 03:12:20 -0500
X-MC-Unique: xgFgSY95OhmTag_cjASj-w-1
Received: by mail-oi1-f197.google.com with SMTP id l1-20020aca1901000000b0036cd9d01876so1665027oii.19
        for <cgroups@vger.kernel.org>; Fri, 27 Jan 2023 00:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfn6EbWtPNJebb879MWv3dOIAf3Kgq4dei2DnXcoD6U=;
        b=T3v6JbXH1tGL71+qAyKAFZFM48GuV/5tA2nDD89NptO+1njOGlMVaMjkkZMPv+4QVs
         19WwbOjBIzyCTiOO+1Ipsvh0AeVxuLGzneCU0Cc2TtX6FZCrgJ2qeFt8V5lpm+YwZOyp
         UmNQNmPm1SpUoCpzloDq+07ZhoLuXaoY/z2ncdbpOFZtEUNtQZ328bcUQsPwezQ5cyJU
         7Z6yAsDzwDdzYSVjq9l+xHxS8MErd2/+O64SXudyrNDyIsWv6aVxeMjK/PDjbXX/aDwe
         n/wCIC/GqFRYFb1D8/1ErE8TGAqIHAxfHOzmroilto86UxoirG3ycVxAMwreU5cE3e0O
         Olkw==
X-Gm-Message-State: AO0yUKVqZsWGOfEcK7VowIwTUagOGn5TU+1xbSNo6DsX7fJvCyy9EdES
        WQ2ST4QcX+RRBXdNXChQdq68M0AhihIZzG/vZox52V0GMZ7k4eKKPumdEfaI2al0K3sx6qcdukv
        QT7gaJ/jJQL8W8WOOTQ==
X-Received: by 2002:a05:6808:10:b0:375:12e1:28c5 with SMTP id u16-20020a056808001000b0037512e128c5mr1907277oic.55.1674807139560;
        Fri, 27 Jan 2023 00:12:19 -0800 (PST)
X-Google-Smtp-Source: AK7set/Up483fYHxeZaymHaWpfU51pJD+d71I5SgB3hjGZAWv7PXqj9pJM37Mfqh56wsfN+i4lQDMg==
X-Received: by 2002:a05:6808:10:b0:375:12e1:28c5 with SMTP id u16-20020a056808001000b0037512e128c5mr1907268oic.55.1674807139388;
        Fri, 27 Jan 2023 00:12:19 -0800 (PST)
Received: from ?IPv6:2804:1b3:a800:6912:c477:c73a:cf7c:3a27? ([2804:1b3:a800:6912:c477:c73a:cf7c:3a27])
        by smtp.gmail.com with ESMTPSA id g20-20020a9d6b14000000b0068848d6b231sm1480090otp.30.2023.01.27.00.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 00:12:18 -0800 (PST)
Message-ID: <601fc35a8cc2167e53e45c636fccb2d899fd7c50.camel@redhat.com>
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbecker@suse.de>
Date:   Fri, 27 Jan 2023 05:12:13 -0300
In-Reply-To: <52a0f1e593b1ec0ca7e417ba37680d65df22de82.camel@redhat.com>
References: <20230125073502.743446-1-leobras@redhat.com>
         <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
         <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
         <Y9FzSBw10MGXm2TK@tpad> <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
         <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
         <Y9MI42NSLooyVZNu@P9FQF9L96D.corp.robot.car>
         <Y9N5CI8PpsfiaY9c@dhcp22.suse.cz>
         <52a0f1e593b1ec0ca7e417ba37680d65df22de82.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 2023-01-27 at 04:22 -0300, Leonardo Br=C3=A1s wrote:
> On Fri, 2023-01-27 at 08:11 +0100, Michal Hocko wrote:
> > [Cc Frederic]
> >=20
> > On Thu 26-01-23 15:12:35, Roman Gushchin wrote:
> > > On Thu, Jan 26, 2023 at 08:41:34AM +0100, Michal Hocko wrote:
> > [...]
> > > > > Essentially each cpu will try to grab the remains of the memory q=
uota
> > > > > and move it locally. I wonder in such circumstances if we need to=
 disable the pcp-caching
> > > > > on per-cgroup basis.
> > > >=20
> > > > I think it would be more than sufficient to disable pcp charging on=
 an
> > > > isolated cpu.
> > >=20
> > > It might have significant performance consequences.
> >=20
> > Is it really significant?
> >=20
> > > I'd rather opt out of stock draining for isolated cpus: it might slig=
htly reduce
> > > the accuracy of memory limits and slightly increase the memory footpr=
int (all
> > > those dying memcgs...), but the impact will be limited. Actually it i=
s limited
> > > by the number of cpus.
> >=20
> > Hmm, OK, I have misunderstood your proposal. Yes, the overal pcp charge=
s
> > potentially left behind should be small and that shouldn't really be a
> > concern for memcg oom situations (unless the limit is very small and
> > workloads on isolated cpus using small hard limits is way beyond my
> > imagination).
> >=20
> > My first thought was that those charges could be left behind without an=
y
> > upper bound but in reality sooner or later something should be running
> > on those cpus and if the memcg is gone the pcp cache would get refilled
> > and old charges gone.
> >=20
> > So yes, this is actually a better and even simpler solution. All we nee=
d
> > is something like this
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index ab457f0394ab..13b84bbd70ba 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2344,6 +2344,9 @@ static void drain_all_stock(struct mem_cgroup *ro=
ot_memcg)
> >  		struct mem_cgroup *memcg;
> >  		bool flush =3D false;
> > =20
> > +		if (cpu_is_isolated(cpu))
> > +			continue;
> > +
> >  		rcu_read_lock();
> >  		memcg =3D stock->cached;
> >  		if (memcg && stock->nr_pages &&
> >=20
> > There is no such cpu_is_isolated() AFAICS so we would need a help from
> > NOHZ and cpuisol people to create one for us. Frederic, would such an
> > abstraction make any sense from your POV?
>=20
>=20
> IIUC, 'if (cpu_is_isolated())' would be instead:
>=20
> if (!housekeeping_cpu(smp_processor_id(), HK_TYPE_DOMAIN) ||
> !housekeeping_cpu(smp_processor_id(), HK_TYPE_WQ)

oh, sorry 's/smp_processor_id()/cpu/' here:

if(!housekeeping_cpu(cpu, HK_TYPE_DOMAIN) || !housekeeping_cpu(cpu, HK_TYPE=
_WQ))


Not sure why I added smp_processor_id() instead of cpu. I think I need some
sleep. :)

