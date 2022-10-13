Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F485FD3BE
	for <lists+cgroups@lfdr.de>; Thu, 13 Oct 2022 06:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJMESk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Oct 2022 00:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJMESh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Oct 2022 00:18:37 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8C2122BC7
        for <cgroups@vger.kernel.org>; Wed, 12 Oct 2022 21:18:35 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id w15-20020a17090a8a0f00b0020afece09efso2578923pjn.5
        for <cgroups@vger.kernel.org>; Wed, 12 Oct 2022 21:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zRvbOdnLFkkO1H+l0YKZdetTiBnUb46NxgSTP+dtmWw=;
        b=UHRwCHPfL9O7ChsvIKIHzncJ2N3Fjdrq0hlgsp1EwwDR2LNEVm5/FrMmvck2ZjQqDc
         QO7XNuUb3Or1ixE3y5dL1xON/UZnZE+I0yt1y9b7QFGB/Q6kVb9aREbKxAgtbYMlIheL
         kgEqGxFSMKdRWmm7zjRn6D+Wmlau2q8wiHgY8X0e555V4tJ72xR+jX4AlRGYaJkyU7ke
         HXibMWsW8IrgyjHqsw+sZr9M9aVnLuSyFalJWPSuS0HSNLOj1NnAcsQayv7AxTPd1rms
         rmVtNoHsurRukqtMwk2UDi9TkLaL7sbTXklc/w3CDAk+P4aTlw1M9d1g3TEfT0McpP56
         aagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRvbOdnLFkkO1H+l0YKZdetTiBnUb46NxgSTP+dtmWw=;
        b=iz+9wiTDEvivWtJAZcokKsN0llLiDYHCarIl1PHzdr/i87Mbn+K+BAV+s/w9h66To0
         SzRbYeWbacjr0GOQU+3nGqtUvKIX7aaD6J30vKQFxlenVcZTQtD4C8EfbCyWK9gFumce
         GxE+jKtT+zzgIKkA2LVrU4DowfnNc2TJks83tm7M9CuHyQzN4dwiW4VrG+XcQeKG+PIR
         8cSc/OUw9EMEb3YJXOX+l6k9ZZ0zfkGyFUncUGy+JVVkkrewLmeNOqxX7DZ+cHLMTLW0
         Zgf4qOxgGRErFmbKyMUJso2Y5J6M5M+yUiXMEMi9eMGIVYv2zCCV4S5JWbng5PJ9k+Kn
         CRew==
X-Gm-Message-State: ACrzQf0GbxRdVgPOiMouqeWRcjRXM2/4z2N2jQKGxggwCk2S9Q9trvtZ
        bZOATo+NnP8B/Y+ye4kReowl8nsZ1+Fa6Q==
X-Google-Smtp-Source: AMsMyM6DXcyFsUJiVLXKV0d1YWYVYDoajBGEzNpfPGTooN0zpPbM5rFjzXpN02Uf/C4PaKrSUw/WwCyfDEGs6Q==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:902:ecc2:b0:17f:9022:e00b with SMTP
 id a2-20020a170902ecc200b0017f9022e00bmr33674660plh.87.1665634715170; Wed, 12
 Oct 2022 21:18:35 -0700 (PDT)
Date:   Thu, 13 Oct 2022 04:18:33 +0000
In-Reply-To: <CAEA6p_BUUzhHVAyaD3semV84M+TeZzmrkyjpwb-gs8e6sQRCWw@mail.gmail.com>
Mime-Version: 1.0
References: <20210817194003.2102381-1-weiwan@google.com> <20221012163300.795e7b86@kernel.org>
 <CALvZod5pKzcxWsLnjUwE9fUb=1S9MDLOHF950miF8x8CWtK5Bw@mail.gmail.com>
 <20221012173825.45d6fbf2@kernel.org> <20221013005431.wzjurocrdoozykl7@google.com>
 <20221012184050.5a7f3bde@kernel.org> <20221012201650.3e55331d@kernel.org>
 <CAEA6p_CqqPtnWjr_yYr1oVF3UKe=6RqFLrg1OoANs2eg5_by0A@mail.gmail.com>
 <20221012204941.3223d205@kernel.org> <CAEA6p_BUUzhHVAyaD3semV84M+TeZzmrkyjpwb-gs8e6sQRCWw@mail.gmail.com>
Message-ID: <20221013041833.rhifxw4gqwk4ofi2@google.com>
Subject: Re: [PATCH net-next] net-memcg: pass in gfp_t mask to mem_cgroup_charge_skmem()
From:   Shakeel Butt <shakeelb@google.com>
To:     Wei Wang <weiwan@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 12, 2022 at 09:04:59PM -0700, Wei Wang wrote:
> On Wed, Oct 12, 2022 at 8:49 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Wed, 12 Oct 2022 20:34:00 -0700 Wei Wang wrote:
> > > > I pushed this little nugget to one affected machine via KLP:
> > > >
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index 03ffbb255e60..c1ca369a1b77 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -7121,6 +7121,10 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
> > > >                 return true;
> > > >         }
> > > >
> > > > +       if (gfp_mask == GFP_NOWAIT) {
> > > > +               try_charge(memcg, gfp_mask|__GFP_NOFAIL, nr_pages);
> > > > +               refill_stock(memcg, nr_pages);
> > > > +       }
> > > >         return false;
> > > >  }
> > > >
> > > AFAICT, if you force charge by passing __GFP_NOFAIL to try_charge(),
> > > you should return true to tell the caller that the nr_pages is
> > > actually being charged.
> >
> > Ack - not sure what the best thing to do is, tho. Always pass NOFAIL
> > in softirq?
> >
> > It's not clear to me yet why doing the charge/uncharge actually helps,
> > perhaps try_to_free_mem_cgroup_pages() does more when NOFAIL is passed?
> >
> I am curious to know as well.
> 
> > I'll do more digging tomorrow.
> >
> > > Although I am not very sure what refill_stock() does. Does that
> > > "uncharge" those pages?
> >
> > I think so, I copied it from mem_cgroup_uncharge_skmem().

I think I understand why this issue start happening after this patch.
The memcg charging happens in batches of 32 (64 nowadays) pages even
if the charge request is less. The remaining pre-charge is cached in
the per-cpu cache (or stock).

With (GFP_NOWAIT | __GFP_NOFAIL), you let the memcg go over the limit
without triggering oom-kill and then refill_stock just put the
pre-charge in the per-cpu cache. So, the later allocation/charge succeed
from the per-cpu cache even though memcg is over the limit.

So, with this patch we no longer force charge and then uncharge on
failure, so the later allocation/charge fail similarly.

Regarding what is the right thing to do, IMHO, is to use GFP_ATOMIC
instead of GFP_NOWAIT. If you see the following comment in
try_charge_memcg(), we added this exception particularly for these kind
of situations.

...
	/*
	 * Memcg doesn't have a dedicated reserve for atomic
	 * allocations. But like the global atomic pool, we need to
	 * put the burden of reclaim on regular allocation requests
	 * and let these go through as privileged allocations.
	 */
	if (!(gfp_mask & (__GFP_NOFAIL | __GFP_HIGH)))
		return -ENOMEM;
...

Shakeel
