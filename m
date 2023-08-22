Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4667845F3
	for <lists+cgroups@lfdr.de>; Tue, 22 Aug 2023 17:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbjHVPny (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Aug 2023 11:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbjHVPnx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Aug 2023 11:43:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C6CCCB
        for <cgroups@vger.kernel.org>; Tue, 22 Aug 2023 08:43:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so617184266b.3
        for <cgroups@vger.kernel.org>; Tue, 22 Aug 2023 08:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692719030; x=1693323830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHPwQRfzvw0kSRyeNQxBzdbaew4IqY6cIfInQbasrDQ=;
        b=sEQshxKo1c53nQhGLbHCCdc+S2tBe70IsqZWr7uYwwq9MoMEMzlTYnO6hFGblId8HR
         DzzXIr0Ng5kZ8/r2nmhyqI70Cd91DmIvGtUBCxTGKWkDWaAHPTwgsIY9Q8aM7BIQoe1N
         AFJXDgT/DK9PdVByD6peAL9817rZ2/DecmzYDeKW4k8VYQFxiZvcB1tNj6kVv7l55IG/
         R2ZX4wdjG0RXpwDlzSlIiiT17KUinChOvJXjhixzKBGtmb4QrfWMjNdC8QhiwnuOOQ5t
         vhTR2MV2OtnpVDusGoen77jQIoKs6WbqROpZbkfQGnaroO2feltIB5XZ+bsfnT0OjlyD
         MueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692719030; x=1693323830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHPwQRfzvw0kSRyeNQxBzdbaew4IqY6cIfInQbasrDQ=;
        b=ebZryV7fKvQGkDLpTiHS65f8f+ntd7gClHArlBzRMDzME3Wjf6IwJq3waDWpoTujKz
         5inmYyhbFt52OOjeG/uEI7VWbpAZdt8N6JpzKcaRxMXuesjVfqtccq/mQdOpCHB1va9v
         +8QordrDJuHaoF8D+F1snJUoq50QtGq+d9s/UNrxSgtLdCR04MG2UHUE7x+gyhs5rkds
         46f8wn6bOsRd/Ne82DmgGzIgfGaE5TlvWa11JgZeZj2rFrRabQ+MPnCw+RbX1tkXBSF5
         SNgu1sO55GmJwh3iVj7X9SerInsZnIIzf88JP9TvwHRP26QhfOcQO6LI0PHTDMIETjaW
         nw6Q==
X-Gm-Message-State: AOJu0YzPsGjwwv9qUJB/DRfQzhN+HYS2DlAOH+2Ja33ikOmerLF06LbQ
        dzEKBBUezWquVRELEuInae80fSUEI57l3ZsAB/I4BA==
X-Google-Smtp-Source: AGHT+IHS97sSNWyiXgCNScdPoxBn0oRhZd31+T5kmk9JQHR1a3PFHWfxZOba5fcmlpUo/3o5Ke4/hjD+6EC5oavPmwY=
X-Received: by 2002:a17:907:2c57:b0:98e:419b:4cc6 with SMTP id
 hf23-20020a1709072c5700b0098e419b4cc6mr7061038ejc.70.1692719030006; Tue, 22
 Aug 2023 08:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230821205458.1764662-1-yosryahmed@google.com> <a4opjlmm5it3ujoypcgjfljfamjvr7gu34sc7lrjldfbqzz4lj@6w4lqdcfd3zu>
In-Reply-To: <a4opjlmm5it3ujoypcgjfljfamjvr7gu34sc7lrjldfbqzz4lj@6w4lqdcfd3zu>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 22 Aug 2023 08:43:13 -0700
Message-ID: <CAJD7tkYrbs8Eqb-AbTmb5JeQb+KeLZrU4C2kJk8pjva-6p6bHQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] memcg: non-unified flushing for userspace stats
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 22, 2023 at 6:01=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hello.
>
> On Mon, Aug 21, 2023 at 08:54:55PM +0000, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > For userspace reads, unified flushing leads to non-deterministic stats
> > staleness and reading cost.
>
> I only skimed previous threads but I don't remember if it was resolved:
> a) periodic flushing was too much spaced for user space readers (i.e. 2s
>    delay is too much [1]),
> b) periodic flushing didn't catch up (i.e. full tree flush can
>    occassionaly take more than 2s) leading to extra staleness?

The idea is that having stats anywhere between 0-2 seconds stale is
inconsistent, especially when compared to other values (such as
memory.usage_in_bytes), which can give an inconsistent and stale view
of the system. For some readers, 2s is too spaced (we have readers
that read every second). A time-only bound is scary because on large
systems a lot can happen in a second. There will always be a delay
anyway, but ideally we want to minimize it.

I think 2s is also not a strict bound (e.g. flushing is taking a lot
of time, a flush started but the cgroup you care about hasn't been
flushed yet, etc).

There is also the problem of variable cost of reading.

>
> [1] Assuming that nr_cpus*MEMCG_CHARGE_BATCH error bound is also too
>     much for userspace readers, correct?

I can't tell for sure to be honest, but given the continuously
increased number of cpus on modern systems, and the fact that
nr_cpus*MEMCG_CHARGE_BATCH can be localized in one cgroup or spread
across the hierarchy, I think it's better if we drop it for userspace
reads if possible.

>
> > The cost of userspace reads are now determinstic, and depend on the
> > size of the subtree being read. This should fix both the *sometimes*
> > expensive reads (due to flushing the entire tree) and occasional
> > staless (due to skipping flushing).
>
> This is nice, thanks to the atomic removal in the commit 0a2dc6ac3329
> ("cgroup: remove cgroup_rstat_flush_atomic()"). I think the smaller
> chunks with yielding could be universally better (last words :-).

I was hoping we can remove unified flushing completely, but stress
testing with hundreds of concurrent reclaimers shows a lot of
regression. Maybe it doesn't matter in practice, but I don't want to
pull that trigger :)

FWIW, with unified flushing we are getting great concurrency for
in-kernel flushers like reclaim or refault, but at the expense of
stats staleness. I really wonder what hidden cost we are paying due to
the stale stats. I would imagine any problems that manifest from this
would be difficult to tie back to the stale stats.

>
> Thanks,
> Michal
>
