Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AFC67DE57
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 08:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjA0HPQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Jan 2023 02:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjA0HPP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Jan 2023 02:15:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F9A2A992
        for <cgroups@vger.kernel.org>; Thu, 26 Jan 2023 23:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674803667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R3zXC7BLShJSQz17R47PyiKfOUcoTGd7uBIuLuInT94=;
        b=Exdep1Wa2Ck3OmA0XXSGuwxFkYTUEcpptbmHLDUSxhaaL/ZNTggQ6vcjBGnJ0M44++kgV6
        mbiwdl8r45B057Y6fUESCUAB6DieF6r0OBoHCsoozsJQ1C9m9WPmjpMTtRAFOsOHLz+Z8l
        7YcjpyUVr8Fh8OAk7xtIXC9EaMWqAT4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-320-9ls07CdNPdemNfQjo2hJdg-1; Fri, 27 Jan 2023 02:14:25 -0500
X-MC-Unique: 9ls07CdNPdemNfQjo2hJdg-1
Received: by mail-oi1-f197.google.com with SMTP id fe12-20020a0568082b0c00b0036eb985c232so1639568oib.21
        for <cgroups@vger.kernel.org>; Thu, 26 Jan 2023 23:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3zXC7BLShJSQz17R47PyiKfOUcoTGd7uBIuLuInT94=;
        b=yvqoMXs/TEHCBiPhUN6o0lU3kAFlFviOapNfPVp7dPAXFKcOksMP0AC6V/0oJaN6mU
         Ngz+eXd52ks0s2AkUmAl3Kymra33KZyLRNw+QY1f3pCJna8s5g1UbT8tceNc6+nmMcx+
         axzpFHEGYmdmKyXV3KtwADH/l47TR8C+fCDWcZMGJUk/MDPAMIr/MuZ4y0m0VyXoBlyh
         c4EH2U+mf0sS64JA1oTBeRYB2zQq/Z70ER+ivwYGP5OFO2daeD+LWIMNh566rKEzO8cW
         GO8dzWbkFRuY3lJl4G/Su6mHFNwdDyY5DEU9K/77wSJQYvVtZGCwvp09pHoKf7cwaNwy
         cb/A==
X-Gm-Message-State: AO0yUKXPaEe58Upvhywp8e7Vhq0HkrgLA35FxB94ZLRGj9E+C4SYz1aB
        7/5MN34dKvnbn8wLHxg5vmmsF1LJcG+IS8mWcCQSrqRi/wOcSA+fQQaOtd4fXI0cH7iXrlsM3rU
        f+3RdEBFg83a1zJzdcg==
X-Received: by 2002:a05:6808:1441:b0:36e:3082:aafc with SMTP id x1-20020a056808144100b0036e3082aafcmr2821023oiv.22.1674803664332;
        Thu, 26 Jan 2023 23:14:24 -0800 (PST)
X-Google-Smtp-Source: AK7set8hH/PpOhYyPAlSefknqZ+k4fTdURkpfjMtwxczwFjxH1dSexKDNpHTFpfR3/ewOGvdvqq3Dg==
X-Received: by 2002:a05:6808:1441:b0:36e:3082:aafc with SMTP id x1-20020a056808144100b0036e3082aafcmr2821017oiv.22.1674803664080;
        Thu, 26 Jan 2023 23:14:24 -0800 (PST)
Received: from ?IPv6:2804:1b3:a800:6912:c477:c73a:cf7c:3a27? ([2804:1b3:a800:6912:c477:c73a:cf7c:3a27])
        by smtp.gmail.com with ESMTPSA id q125-20020aca5c83000000b0036f02656fa5sm1295386oib.34.2023.01.26.23.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 23:14:23 -0800 (PST)
Message-ID: <55ac6e3cbb97c7d13c49c3125c1455d8a2c785c3.camel@redhat.com>
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Jan 2023 04:14:19 -0300
In-Reply-To: <Y9MI42NSLooyVZNu@P9FQF9L96D.corp.robot.car>
References: <20230125073502.743446-1-leobras@redhat.com>
         <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
         <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
         <Y9FzSBw10MGXm2TK@tpad> <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
         <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
         <Y9MI42NSLooyVZNu@P9FQF9L96D.corp.robot.car>
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

On Thu, 2023-01-26 at 15:12 -0800, Roman Gushchin wrote:
> On Thu, Jan 26, 2023 at 08:41:34AM +0100, Michal Hocko wrote:
> > On Wed 25-01-23 15:14:48, Roman Gushchin wrote:
> > > On Wed, Jan 25, 2023 at 03:22:00PM -0300, Marcelo Tosatti wrote:
> > > > On Wed, Jan 25, 2023 at 08:06:46AM -0300, Leonardo Br=C3=A1s wrote:
> > > > > On Wed, 2023-01-25 at 09:33 +0100, Michal Hocko wrote:
> > > > > > On Wed 25-01-23 04:34:57, Leonardo Bras wrote:
> > > > > > > Disclaimer:
> > > > > > > a - The cover letter got bigger than expected, so I had to sp=
lit it in
> > > > > > >     sections to better organize myself. I am not very confort=
able with it.
> > > > > > > b - Performance numbers below did not include patch 5/5 (Remo=
ve flags
> > > > > > >     from memcg_stock_pcp), which could further improve perfor=
mance for
> > > > > > >     drain_all_stock(), but I could only notice the optimizati=
on at the
> > > > > > >     last minute.
> > > > > > >=20
> > > > > > >=20
> > > > > > > 0 - Motivation:
> > > > > > > On current codebase, when drain_all_stock() is ran, it will s=
chedule a
> > > > > > > drain_local_stock() for each cpu that has a percpu stock asso=
ciated with a
> > > > > > > descendant of a given root_memcg.
> > >=20
> > > Do you know what caused those drain_all_stock() calls? I wonder if we=
 should look
> > > into why we have many of them and whether we really need them?
> > >=20
> > > It's either some user's actions (e.g. reducing memory.max), either so=
me memcg
> > > is entering pre-oom conditions. In the latter case a lot of drain cal=
ls can be
> > > scheduled without a good reason (assuming the cgroup contain multiple=
 tasks running
> > > on multiple cpus).
> >=20
> > I believe I've never got a specific answer to that. We
> > have discussed that in the previous version submission
> > (20221102020243.522358-1-leobras@redhat.com and specifically
> > Y2TQLavnLVd4qHMT@dhcp22.suse.cz). Leonardo has mentioned a mix of RT an=
d
> > isolcpus. I was wondering about using memcgs in RT workloads because
> > that just sounds weird but let's say this is the case indeed. Then an R=
T
> > task or whatever task that is running on an isolated cpu can have pcp
> > charges.
> >=20
> > > Essentially each cpu will try to grab the remains of the memory quota
> > > and move it locally. I wonder in such circumstances if we need to dis=
able the pcp-caching
> > > on per-cgroup basis.
> >=20
> > I think it would be more than sufficient to disable pcp charging on an
> > isolated cpu.
>=20
> It might have significant performance consequences.
>=20
> I'd rather opt out of stock draining for isolated cpus: it might slightly=
 reduce
> the accuracy of memory limits and slightly increase the memory footprint =
(all
> those dying memcgs...), but the impact will be limited. Actually it is li=
mited
> by the number of cpus.

I was discussing this same idea with Marcelo yesterday morning.

The questions had in the topic were:
a - About how many pages the pcp cache will hold before draining them itsel=
f?=C2=A0
b - Would it cache any kind of bigger page, or huge page in this same aspec=
t?

Please let me know if I got anything wrong, but IIUC from a previous debug =
(a)'s
answer is 4 pages. Meaning even on bigger-page archs such as powerpc, with =
64k
pages, the max pcp cache 'wasted' on each processor would be 256k (very sma=
ll on
today's standard).

Please let me know if you have any info on (b), or any correcting on (a).

The thing is: having this drain_local_stock() waiver only for isolated cpus
would not bring the same benefits for non-isolated cpus in high memory pres=
sure
as I understand this patchset is bringing. =C2=A0

OTOH not running drain_local_stock() at all for every cpu may introduce
performance gains (no remote CPU access) but can be a problem if I got the
'wasted pages' could on (a) wrong. I mean, drain_local_stock() was introduc=
ed
for a reason.

>=20
> > This is not a per memcg property.
>=20
> Sure, my point was that in pre-oom condition several cpus might try to co=
nsolidate
> the remains of the memory quota, actually working against each other. Sep=
arate issue,
> which might be a reason why there are many flush attempts in the case we =
discuss.
>=20
> Thanks!
>=20

Thank you for reviewing!

Leo

