Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6695468A848
	for <lists+cgroups@lfdr.de>; Sat,  4 Feb 2023 05:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjBDE4I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 23:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBDE4H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 23:56:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C3E222DB
        for <cgroups@vger.kernel.org>; Fri,  3 Feb 2023 20:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675486520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQ4uha3PJgX8OHjyXh+WN0eX5F0h2aTsXeAPONLwqFE=;
        b=doVlUpZKxsaV8oJSqURQbXInQRusPJXHV5MdJ9RUPe2jpLq9ukRm2Js+c1twoyLsjNcVdW
        WMgfFggZbgnj5/bWy26wTbpj1wGdytuGWPRGb4SiSe70fBnYR7DrH75R3RRkBc8WYkr5D/
        T5jZFA87Mx+A9dKudVsxbzZwuEfqFk8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-302-jJk9hONzP5uaLQDysielNg-1; Fri, 03 Feb 2023 23:55:17 -0500
X-MC-Unique: jJk9hONzP5uaLQDysielNg-1
Received: by mail-ot1-f70.google.com with SMTP id l2-20020a9d6a82000000b0068bc95856f2so3331946otq.15
        for <cgroups@vger.kernel.org>; Fri, 03 Feb 2023 20:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQ4uha3PJgX8OHjyXh+WN0eX5F0h2aTsXeAPONLwqFE=;
        b=tbO53HRXbBE3U+gR0uD/chTMlEHti3TKkGTR+8P1dTINeyYPa/Ix2K6lREv49arwzv
         10A5aqRCnOj/LK5kziT4FVMQPJ/rkLuLNQLsJvGhN3azChOXykk/hWamFm0AO0WSYHEi
         ENkWA0F0f1GKPVasq42l2t9swA/amPZWfuRM8gGtqeXQzCtSlp+8LE3ryuHdjj5OLYML
         sNshlshumTEreEkjApPj6QRZj9x3CYS18/t5OL3wAuMz8dajzl1qCK1d2i6nOBcL/yTT
         +/xcM4wPDcToM4EyOtDHl6t6tJWDzqn4Q/Rj5XK7xIRGST9F4tnbqNOpyVovGyB6EXiS
         Up5A==
X-Gm-Message-State: AO0yUKX7e3HlwMiyrHlxaMuTADx+Gfbc/jmG61Dt0ZFPUui1ULhb3/oB
        FLTtdJDiDJfFIBGIKT1vgMWTf7o7AWaUsphLr7l1tdpP79VsKnrWrTqDijuftn3zmfZ65flP8vA
        eJrNI6F1mP7durwfWlw==
X-Received: by 2002:a05:6808:4084:b0:36e:a91d:b7ed with SMTP id db4-20020a056808408400b0036ea91db7edmr5197302oib.9.1675486516688;
        Fri, 03 Feb 2023 20:55:16 -0800 (PST)
X-Google-Smtp-Source: AK7set8dIZaX4QNjaxFTxht/y8nO4ZEqyQ+5DOY49AHbU+2VqduudxsJntRFaN2pQ/J1EAmmtdjcSA==
X-Received: by 2002:a05:6808:4084:b0:36e:a91d:b7ed with SMTP id db4-20020a056808408400b0036ea91db7edmr5197296oib.9.1675486516360;
        Fri, 03 Feb 2023 20:55:16 -0800 (PST)
Received: from ?IPv6:2804:1b3:a800:9aa9:fdcb:7dec:9680:8417? ([2804:1b3:a800:9aa9:fdcb:7dec:9680:8417])
        by smtp.gmail.com with ESMTPSA id bg12-20020a056808178c00b0035c21f1a570sm1578624oib.6.2023.02.03.20.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 20:55:15 -0800 (PST)
Message-ID: <28e08669302ad1e7a41bdf8b9988de6a352b5fe1.camel@redhat.com>
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 04 Feb 2023 01:55:10 -0300
In-Reply-To: <Y9pd7AxAILUSHrpe@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
         <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
         <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
         <Y9FzSBw10MGXm2TK@tpad> <Y9IvoDJbLbFcitTc@dhcp22.suse.cz>
         <Y9LDAZmApLeffrT8@tpad> <Y9LQ615H13RmG7wL@dhcp22.suse.cz>
         <0122005439ffb7895efda7a1a67992cbe41392fe.camel@redhat.com>
         <Y9j9BnMwfm4TJks7@tpad> <Y9pd7AxAILUSHrpe@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
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

Michal, Roman,

I understand you have far more experience in this codebase than myself, so
please help me understand what am I missing in my argument for the spinlock
approach.=C2=A0

I honestly want to improve, and your help is really appreciated.

On Wed, 2023-02-01 at 13:41 +0100, Michal Hocko wrote:
> On Tue 31-01-23 08:35:34, Marcelo Tosatti wrote:
> [...]
> > So it would be good to point out a specific problematic=20
> > testcase/scenario with using the spinlock in this particular case?
>=20
> Please think about it some more. The sole purpose of the pcp charge
> caching is to avoid atomics because the normal fast path (i.e. no limit
> hit) is a page counter which is an atomic counter. If you go with a spin
> lock for the pcp cache you are just losing some of the advantage of the
> caching. Sure that would be a smaller atomics use than a deeper memcg
> hierarchy but still.

I could read the code that calls consume_stock(), and noticed that you are
probably referencing the atomic operations on memcg->memory->usage (and oth=
ers)
used in page_counter_try_charge(). It is a single atomic variable per memcg=
 that
is potentially accessed by every cpu. Is that correct?

I understand the cost of an atomic operation such as this is high because o=
f the
inherent high cost of bouncing the variable's cacheline between those cpus.

The difference between 'usage' atomic variable and the spinlock we are prop=
osing
is the scope of the variable: spinlock is defined on a per-cpu structure,=
=C2=A0and
most of the accesses will come from the local cpu.=C2=A0

According to=C2=A0Intel=C2=AE 64 and IA-32 Architectures Software Developer=
=E2=80=99s Manual, at
Vol. 3A page 9-5:

###
9.1.4 Effects of a LOCK Operation on Internal Processor Caches
[...]
For the P6 and more recent processor families, if the area of memory being
locked during a LOCK operation is cached in the processor that is performin=
g the
LOCK operation as write-back memory and is completely contained in a cache =
line,
the processor may not assert the LOCK# signal on the bus. Instead, it will
modify the memory location internally and allow it=E2=80=99s cache coherenc=
y mechanism
to ensure that the operation is carried out atomically. This operation is c=
alled
=E2=80=9Ccache locking.=E2=80=9D The cache coherency mechanism automaticall=
y prevents two or
more processors that have cached the same area of memory from simultaneousl=
y
modifying data in that area.
###

So locking on a percpu spinlock which is cached in the current cpu (happens=
 most
of time) is as cheap as modifying the local cacheline. Since the cachelines=
 are
already modified in the local cpu functions, so the write to memory is batc=
hed.

For reference, this is the pahole output for memcg_stock_pcp after my patch=
. The
spinlock fits in the same cacheline as the changed variables.

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

The only accesses that will come from a remote cpu, and thus cause the cach=
eline
to bounce and the lock to be more expensive, are the ones from
drain_all_stock(). OTOH, on upstream, those accesses already modify the rem=
ote
cacheline with an atomic variable (memcg_stock_pcp.flags), so we are only
dealing with potential contention costs.

>=20
> Not to mention a potential contention which is hard to predict and it
> will depend on the specific runtime very much. So not something that
> would be easy to test for other than artificial testcases. Full cpu
> pcp draining is not a very common operation and one could argue that
> the problem will be limited=C2=A0
>=20

Yes, but we are exchanging an "always schedule_work_on()", which is a kind =
of
contention, for a "sometimes we hit spinlock contention".

For the spinlock proposal, on the local cpu side, the *worst case* contenti=
on
is:
1 - wait the spin_unlock() for a complete <percpu cache drain process>,
2 - wait a cache hit for local per-cpu cacheline=C2=A0

What is current implemented (schedule_work_on() approach), for the local
cpu=C2=A0side there is *always* this contention:
1 - wait for a context switch,
2 - wait a cache hit from it's local per-cpu cacheline,
3 - wait a complete <percpu cache drain process>,=C2=A0
4 - then for a new context switch to the current thread.

So moving from schedule_work_on() to spinlocks will save 2 context switches=
 per
cpu every time drain_all_stock() is called.

On the remote cpu side, my tests point that doing the remote draining is fa=
ster
than scheduling a local draining, so it's also a gain.

Also, IIUC the possible contention in the spinlock approach happens only on
page-faulting and syscalls, versus the schedule_work_on() approach that can
interrupt user workload at any time.=C2=A0

In fact, not interrupting the user workload in isolated cpus is just a bonu=
s of
using spinlocks.

> but so far I haven't really heard any strong
> arguments against the proposal to avoid scheduling the work on isolated
> cpus which is a much more simpler solution and achieves the same
> effect.

I understand the 'not scheduling work on isolated cpus' appeal: it's a much
simpler change, and will only affect cases with isolated cpus, so it is saf=
er
than changing the whole locking structure.=C2=A0

I am not against it. I already have a patch implementing it for testing, an=
d I
could gladly send it if you see fit.

But if nothing else, it introduces another specific case, and now it have t=
o
deal differently with local cpu, remote cpus, and isolated cpus.

With spinlocks, there is a much simpler solution:
- All cpus are dealt with the same way, which is faster in the local cpu (a=
s=C2=A0
  in upstream implementation).
- We don't have to avoid draining on isolated cpus.
- We get rid of the "work_struct", and scheduling costs
- We get rid of "flag", as we don't need to take care of multi-scheduling l=
ocal=C2=A0
  draining.
- When drain_all_stock() returns, all stock have already been drained, so=
=C2=A0
  retrying=C2=A0consume_stock() may have immediate results on pre-OOM cases=
.

On Wed, 2023-02-01 at 13:52 +0100, Michal Hocko wrote:
[...]
> Let me be clear here. Unless there are some real concerns about not
> flushing remotely on isolated cpus then the spin lock approach is just
> much less preferable. So I would much rather focus on the trivial patch
> and investigates whether there are no new corner cases to be created by
> that.

I understand 'not scheduling work on isolated cpus' approach should work wi=
th
low impact on current behavior, and I also understand that as Maintainers y=
ou
have to consider many more factors than a regular developer like me, and al=
so
that the spinlock approach is a big change on how pcp memcg caches work.=
=20

On that topic, if there is any comparison test you find important running, =
or
any topic you think could be better discussed, please let me know.

Thank you for reviewing,
Leo


