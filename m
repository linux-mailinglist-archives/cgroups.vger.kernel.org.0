Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DF25F57D7
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 17:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiJEPwI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 11:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJEPvv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 11:51:51 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A56A2C669
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 08:51:33 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id i3so10425324qkl.3
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2AoFrEpz0B0RLbXAkzCCAczpNqzFmtnMjKTlufu6KsU=;
        b=WRGwEQZ1TNdFoAuwtXbuWLZNv41BDB32f4pY76uWbOKjuF0h37pCQt+Pwgr6xs+N2t
         D3Ce0vY+MNtiBU0bi16rH7EAwk2rwH6/Y9fr/aocmu4c85nzeYy8GCFbknxL3K4+qEzd
         40IHJJuCITJXg9IsZmrkfcNRrfq2hWvPKTqK1YMX7Gb+hQUx5Q+z0BrtPgGU0BY54P94
         gtlky2y6FXCCcmbRO3gE9nBlrZKwEMydG9XtAdUUXiytwyVJ7hjOOqF+itedleWm94fc
         6aO36P0obqVLPwdYQkOJWbILzVJApg/HncfimKv9PUP2TTW2yVhWp+7bArcfWYq5JqDG
         nJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2AoFrEpz0B0RLbXAkzCCAczpNqzFmtnMjKTlufu6KsU=;
        b=lH5EQfTTtWphrvGYOZESE2a2iiHA3ezs7GjrPdVnlay+9kKSYgJs0a/TUbnOFq/jp4
         Mq4chHj1lovfWe0BwSDcDPgCbPorzjStbZeIcX3vaIPwHbQZFxhKZt8F2VYkXHxZ0hhI
         ejrHVSy1nbCtHC52aStyabIo4fOqf82JN8CC4nDbNxwKbw+tm0I7vFu8hFmN+loC32PJ
         /DX/sBNuTBFx749syyRHH75M64j3obxDOj2xSFsw4TZZDCTErSbVudJ2I/OtYpl8qtdm
         WPQOz5aZ6ll4mf1u0yU6/weJvNtjCoWjobxkY6ysP36cUYtX3RZpfn8NNkYzxZairPr+
         El5g==
X-Gm-Message-State: ACrzQf1g6+ToKOm3N8VzkDnPH9vwp3jfTDziQiGd7NfTYS2RLDIP3DEs
        4STNnwvnj2EetgSwu0YsUjSusA==
X-Google-Smtp-Source: AMsMyM7kmrmQrnGNoUSK6tL7NkzT6Khbjks9LTKhC6g2EqFLqq5KoRDn+0j2GktmAwhMFEVPJPjy9w==
X-Received: by 2002:a05:620a:2005:b0:6ce:3f31:e02d with SMTP id c5-20020a05620a200500b006ce3f31e02dmr161084qka.678.1664985092121;
        Wed, 05 Oct 2022 08:51:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::8a16])
        by smtp.gmail.com with ESMTPSA id g12-20020a05620a40cc00b006ce3f1af120sm8869688qko.44.2022.10.05.08.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 08:51:31 -0700 (PDT)
Date:   Wed, 5 Oct 2022 11:51:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/vmscan: check references from all memcgs for
 swapbacked memory
Message-ID: <Yz2oAjIRZKKwe8tY@cmpxchg.org>
References: <20221004233446.787056-1-yosryahmed@google.com>
 <Yz2O1dGeBGBTh6SM@cmpxchg.org>
 <CAJD7tkbMtHEN_1zGP=V1X4YGFCxEXv_j2Fqe8TFdOTy-ykiVUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbMtHEN_1zGP=V1X4YGFCxEXv_j2Fqe8TFdOTy-ykiVUg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 05, 2022 at 07:54:25AM -0700, Yosry Ahmed wrote:
> On Wed, Oct 5, 2022 at 7:04 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > Would you mind moving this to folio_referenced() directly? There is
> > already a comment and branch in there that IMO would extend quite
> > naturally to cover the new exception:
> >
> >         /*
> >          * If we are reclaiming on behalf of a cgroup, skip
> >          * counting on behalf of references from different
> >          * cgroups
> >          */
> >         if (memcg) {
> >                 rwc.invalid_vma = invalid_folio_referenced_vma;
> >         }
> >
> > That would keep the decision-making and doc in one place.
> 
> Hi Johannes,
> 
> Thanks for taking a look!
> 
> I originally wanted to make the change in folio_referenced(). My only
> concern was that it wouldn't be clear for people looking at reclaim
> code in mm/vmscan.c. It would appear as if we are passing in the
> target memcg to folio_referenced(), and only if you look within you
> would realize that sometimes it ignores the passed memcg.
> 
> It seemed to me that deciding whether we want to check references from
> one memcg or all of them is a reclaim decision, while
> folio_referenced() is just an rmap API that does what it is told: "if
> I am passed a memcg, I only look at references coming from this
> memcg". On the other hand, it looks like the doc has always lived in
> folio_referenced()/page_referenced(), so I might be overthinking this
> (I have been known to do this).

I agree it would be nicer to have this policy in vmscan.c. OTOH it's a
policy that applies to all folio_referenced() callers, and it's
fragile to require them to opt into it individually.

Vmscan is the only user of the function, so it's not the worst thing
to treat it as an extension of the reclaim code.

If it helps convince you, there is another, actually quite similar
reclaim policy already encoded in folio_referenced():

			if (ptep_clear_flush_young_notify(vma, address,
						pvmw.pte)) {
				/*
				 * Don't treat a reference through
				 * a sequentially read mapping as such.
				 * If the folio has been used in another mapping,
				 * we will catch it; if this other mapping is
				 * already gone, the unmap path will have set
				 * the referenced flag or activated the folio.
				 */
				if (likely(!(vma->vm_flags & VM_SEQ_READ)))
					referenced++;
			}
