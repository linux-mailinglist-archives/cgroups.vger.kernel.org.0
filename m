Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B651767DE75
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 08:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjA0HXS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 02:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjA0HXP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 02:23:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A338518E8
        for <cgroups@vger.kernel.org>; Thu, 26 Jan 2023 23:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674804149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78CU6PVXyI3TCut8pJAaTXp7IGKel4v7tbwx9feohu0=;
        b=HxuZErlGQyg1KsLdNsa3+oSrLtIY0wgC73nCHXYElHaFLltJLP2LazU8NhpFCXcCu7oImz
        8t0bU6PVgsojxRjIHrhBD5ZYArBsRRjQVV1NDhn8oXazAAfkVsWtKK5SlchUhTxcpIZ9aR
        MlXjQ4ywIUIScT0EsSywxcxKY2Bs5cw=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-KPLTgP2ROMCYonx7ujUBHQ-1; Fri, 27 Jan 2023 02:22:27 -0500
X-MC-Unique: KPLTgP2ROMCYonx7ujUBHQ-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-163583a26eeso1249614fac.5
        for <cgroups@vger.kernel.org>; Thu, 26 Jan 2023 23:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78CU6PVXyI3TCut8pJAaTXp7IGKel4v7tbwx9feohu0=;
        b=6g4EAXOJECB0TgLUi//UNbsF50P0CYgudJXysvuo6Ox/cbiOEsY9xob8LIKgCAwb+y
         RnSAQOv9eIv2L0I5k77joC13JcRRL+BYTjOQUaSW89JZD+nLMR0AL/iViBId1iRX8EsT
         7c1qZZduCrZWBE72T69+NQCxcgKzIFI50U0N4EYi/6ZYvU6sLdDMxyYLPZvxS7BsQj3/
         fyud6wkWlJYIh94DrU0AHUe/ffezoShLyOUiOvcO/uhKP67FvSJRIlKLBOJLnasRI+OL
         mXeari0jWbyPEJ0ZiTrdvZ6M2KAbZVcNdBjmKAy1Puj/A78EbCeK/v+ydvASQ5Midu2L
         eVkg==
X-Gm-Message-State: AO0yUKWUd2KjquLdJ+aB8ut6c6r65jtB5ZoUu8tpi6xJjf359aFCQLgE
        m+DQ7YP4E1+3vlM7+MqmPkLV/ReepcVF2lrpWcTzHWqZCr/OrspHbjq/Fd2c/5z7EjZjy6ownya
        4nIBycl8ZeD0/bDeqPg==
X-Received: by 2002:a05:6871:69f:b0:15b:9460:f1eb with SMTP id l31-20020a056871069f00b0015b9460f1ebmr2384231oao.37.1674804146922;
        Thu, 26 Jan 2023 23:22:26 -0800 (PST)
X-Google-Smtp-Source: AK7set+CW8pYdHDqWVhmo/6o6hIHH8WuQ4HIEriLSDTIZBz9++MR53gYL25QN5SatPjOVA/58gBFUA==
X-Received: by 2002:a05:6871:69f:b0:15b:9460:f1eb with SMTP id l31-20020a056871069f00b0015b9460f1ebmr2384220oao.37.1674804146676;
        Thu, 26 Jan 2023 23:22:26 -0800 (PST)
Received: from ?IPv6:2804:1b3:a800:6912:c477:c73a:cf7c:3a27? ([2804:1b3:a800:6912:c477:c73a:cf7c:3a27])
        by smtp.gmail.com with ESMTPSA id a21-20020a056870b15500b0011d02a3fa63sm1467675oal.14.2023.01.26.23.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 23:22:26 -0800 (PST)
Message-ID: <52a0f1e593b1ec0ca7e417ba37680d65df22de82.camel@redhat.com>
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
Date:   Fri, 27 Jan 2023 04:22:20 -0300
In-Reply-To: <Y9N5CI8PpsfiaY9c@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
         <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
         <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
         <Y9FzSBw10MGXm2TK@tpad> <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
         <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
         <Y9MI42NSLooyVZNu@P9FQF9L96D.corp.robot.car>
         <Y9N5CI8PpsfiaY9c@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 2023-01-27 at 08:11 +0100, Michal Hocko wrote:
> [Cc Frederic]
>=20
> On Thu 26-01-23 15:12:35, Roman Gushchin wrote:
> > On Thu, Jan 26, 2023 at 08:41:34AM +0100, Michal Hocko wrote:
> [...]
> > > > Essentially each cpu will try to grab the remains of the memory quo=
ta
> > > > and move it locally. I wonder in such circumstances if we need to d=
isable the pcp-caching
> > > > on per-cgroup basis.
> > >=20
> > > I think it would be more than sufficient to disable pcp charging on a=
n
> > > isolated cpu.
> >=20
> > It might have significant performance consequences.
>=20
> Is it really significant?
>=20
> > I'd rather opt out of stock draining for isolated cpus: it might slight=
ly reduce
> > the accuracy of memory limits and slightly increase the memory footprin=
t (all
> > those dying memcgs...), but the impact will be limited. Actually it is =
limited
> > by the number of cpus.
>=20
> Hmm, OK, I have misunderstood your proposal. Yes, the overal pcp charges
> potentially left behind should be small and that shouldn't really be a
> concern for memcg oom situations (unless the limit is very small and
> workloads on isolated cpus using small hard limits is way beyond my
> imagination).
>=20
> My first thought was that those charges could be left behind without any
> upper bound but in reality sooner or later something should be running
> on those cpus and if the memcg is gone the pcp cache would get refilled
> and old charges gone.
>=20
> So yes, this is actually a better and even simpler solution. All we need
> is something like this
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ab457f0394ab..13b84bbd70ba 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2344,6 +2344,9 @@ static void drain_all_stock(struct mem_cgroup *root=
_memcg)
>  		struct mem_cgroup *memcg;
>  		bool flush =3D false;
> =20
> +		if (cpu_is_isolated(cpu))
> +			continue;
> +
>  		rcu_read_lock();
>  		memcg =3D stock->cached;
>  		if (memcg && stock->nr_pages &&
>=20
> There is no such cpu_is_isolated() AFAICS so we would need a help from
> NOHZ and cpuisol people to create one for us. Frederic, would such an
> abstraction make any sense from your POV?


IIUC, 'if (cpu_is_isolated())' would be instead:

if (!housekeeping_cpu(smp_processor_id(), HK_TYPE_DOMAIN) ||
!housekeeping_cpu(smp_processor_id(), HK_TYPE_WQ)

