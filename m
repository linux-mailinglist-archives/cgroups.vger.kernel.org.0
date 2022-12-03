Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50AF6412DC
	for <lists+cgroups@lfdr.de>; Sat,  3 Dec 2022 01:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiLCA5P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 19:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiLCA5O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 19:57:14 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62E3164B0
        for <cgroups@vger.kernel.org>; Fri,  2 Dec 2022 16:57:13 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id d13so4531410qvj.8
        for <cgroups@vger.kernel.org>; Fri, 02 Dec 2022 16:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DPjZ7mvL7nYnQckkbN4QRAK9DHc9/tMCEO18HbgrivA=;
        b=TLQIPa6gXHX7UTknaOw9/ETbs+uVF1fmEX74fdi9pMYVGiGbTNTYzeRZWh3UVan/A5
         pgdygh7OpAFfNfU10yhfPrHmD1RPbAHkH571Ih/cObNYEwvWz4MfiIzl3RIhPhuVNRWn
         Akv7MU3BSaPnJoowJnA5vNdzOyYKKugnxnxmH++c0xFDIis6hURGi68K3zljnG2ylZS2
         FpBG1mEk6kbCq1bqwDv1XZDHvseqr0RdUee1wWlmpFiSR0CfuZ1k9HkOB/9rHqQmY9Lc
         RKtzIiGlEPW68kLDLYfyiP0IcEdtwHWB7Ge9weEkCT2wr5yOO/MMZCSk+P+6nhIz7DzI
         vA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPjZ7mvL7nYnQckkbN4QRAK9DHc9/tMCEO18HbgrivA=;
        b=QksbdcV5GzlVW9JdoEti2Abz0l7lTmtxPz5Sj8jbmzc5bAZJA39UW62Vzk+STllIFi
         FBR2pZJw+2gKnofrHBiQGEVTf87DbfJ0FTlCkss+XC0IWgpX0eGZlBbuqhlXRd+Pfk5y
         vZf0ePkybbz4fqGCw5Y8mrYQvWzC86cl1nRDscNIWMJU0aUY/LLGnbsLR38SZbpBKwO7
         GiDEvZ88R0mRZQhbUXlucoTMHMCkFpsr6kwFcuAyfoAQNOzn/yKhH+bzMVkwlPHuyQuj
         uy3jnKSnpkT1wFPinDX6heYo6Bybmc7A0T13i5jKyzxv7bihWQ0qhsZKXyzctJ1ymh2i
         X/aw==
X-Gm-Message-State: ANoB5pnydEP99zNkxjhRW7NDD8mGhPvLb0RXqlK00ecawhJkWJOjO64O
        7kVFy3Ya1fhsW+++Z4AuNrJEb06XvujrLWfFosod6w==
X-Google-Smtp-Source: AA0mqf6uJI6YE7HdaDtFCa10eglITVg/eCmiSOHcJInJThU2rKq0k3g6nuhC6zn7h9TQ+B2i+wMscC7SVNDwWkFOTU8=
X-Received: by 2002:a05:6214:3506:b0:4c6:b483:dbae with SMTP id
 nk6-20020a056214350600b004c6b483dbaemr50825011qvb.79.1670029032734; Fri, 02
 Dec 2022 16:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20221202031512.1365483-1-yosryahmed@google.com>
 <20221202031512.1365483-2-yosryahmed@google.com> <CAJD7tkZouk+r=Qk554AOk1-3eYy-gTC8KC+OJQY13ZkNZ9Qe+Q@mail.gmail.com>
 <20221202163527.a72646c9d42f3678b20dac7b@linux-foundation.org>
 <CAJD7tkapGALWoqrs+cbE8i1w4eDcdj=naHxqybPu6NLAnCZ0iQ@mail.gmail.com> <20221202165027.8d0761724f30f6701a9a5da0@linux-foundation.org>
In-Reply-To: <20221202165027.8d0761724f30f6701a9a5da0@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 2 Dec 2022 16:56:36 -0800
Message-ID: <CAJD7tkZdq2n29P+nbiONzDrvZy0eRpCQfvVVX1A2SMYdV6TVZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm: memcg: fix stale protection of reclaim target memcg
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 2, 2022 at 4:50 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 2 Dec 2022 16:38:12 -0800 Yosry Ahmed <yosryahmed@google.com> wrote:
>
> > On Fri, Dec 2, 2022 at 4:35 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri, 2 Dec 2022 16:26:05 -0800 Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > > Andrew, does this need to be picked up by stable branches?
> > >
> > > Does it?  The changelog doesn't have a clear description of the
> > > user-visible effects of the flaw, which is the guiding light for a
> > > backport?
> > >
> > >
> >
> > There are 2 example scenarios in the changelog that misbehave without
> > this fix, cases where the protection of a memcg that is the target of
> > reclaim is not ignored as it should be.
>
> Yes.  I found them quite unclear.  How would someone who is
> experiencing a particualr runtime issue be able to recognize whether
> this patch might address that issue?
>

When we are doing memcg reclaim, the intended behavior is that we
ignore any protection (memory.min, memory.low) of the target memcg
(but not its children). Ever since the patch pointed to by the "Fixes"
tag, we actually read a stale value for the target memcg protection
when deciding whether to skip the memcg or not because it is
protected. If the stale value happens to be high enough, we don't
reclaim from the target memcg.

Essentially, in some cases we may falsely skip reclaiming from the
target memcg of reclaim because we read a stale protection value from
last time we reclaimed from it.
