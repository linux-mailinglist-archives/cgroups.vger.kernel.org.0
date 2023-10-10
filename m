Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B51E7C0405
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 21:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjJJTC1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjJJTC1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 15:02:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF8594
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 12:02:25 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5346b64f17aso10706811a12.2
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 12:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696964544; x=1697569344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5woyaOlfb5FRD/2ky2o7l2Lh0ZKAp5sQQeLB5eexnx0=;
        b=SwerxqFMedxMTwU4dVCzvaZ8ITJu2hKAQSNz96hao7tkfxBq25l+PD4WkKFj960acV
         QrLWjpAhPk4wjwufAaiO8JxCGiZbe3eLdZ/te+fTgjR6CpNr67PZ6SmPh9UOTzqOmy4D
         g2Nwu/BCBd961xfwZWPmP95QoU6+EyIGuncZOnyiBtCJhCj3BpVmXvFfv985gwPQxTxL
         aG3I3OM4UeFUGH3F0OPuPdoWDGT6eOtrKooLw86aLxLd+BKcAl3hY7MsG9SICKovV2Bg
         49Rwf0zKV2nvDjjQ9+dNcaEFtUgHtu46V567eyK1/jwbXaxRp13y/nURh4un+1LZ/mJX
         qNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696964544; x=1697569344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5woyaOlfb5FRD/2ky2o7l2Lh0ZKAp5sQQeLB5eexnx0=;
        b=a9Lbh1e26C7gVbnnlRDmyyN22XrDLbZE/hkgQwyiR+AgXGbhV/Ke0c9nlQ7SAOTmxS
         5CZBmV5ESz85iDG9Go/XnZoG7ygRqPbgCEoGW3E9U/132xoYPTdrWtwqqsB9/HcqBwSC
         tBu/VGIerxbopJUsaNzoE0+3HOyWL/fbwoTLG9a9tOAoDa+lti1rKNjktWRzMvELFsyv
         RkacDSoQRpoa7hTKWA61LU/GNWIreinwzmBzRKGoTQIhndmqeiwQ7yKiXK19cssYwck8
         k3Xhs2hohChSkKQzIcB/SPTlKZd95k9+JUs5dpfm8ZFcVOZGDUUEbWbNwNuWbuUr22LN
         Rs3A==
X-Gm-Message-State: AOJu0YyU2aBzL7CwYwqSSDChje9hQvjiGgFN+sNmpPTahgwqDGBNMv/J
        mfbQqLz8HHPdoqpvEPyR90ay4ZKwmjriPmktZUvYPQ==
X-Google-Smtp-Source: AGHT+IH9bKUffChQjllZKWXnZLqMPjRf0Bp9CGpOP4CvCWQxNB07IIGTrxdZrDu0oiPVMWwbVLPWJ/cU73YSpZmjB7o=
X-Received: by 2002:a17:907:2cef:b0:9ae:6355:5ef4 with SMTP id
 hz15-20020a1709072cef00b009ae63555ef4mr16422145ejc.3.1696964543989; Tue, 10
 Oct 2023 12:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com> <CAFYChMv_kv_KXOMRkrmTN-7MrfgBHMcK3YXv0dPYEL7nK77e2A@mail.gmail.com>
In-Reply-To: <CAFYChMv_kv_KXOMRkrmTN-7MrfgBHMcK3YXv0dPYEL7nK77e2A@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 10 Oct 2023 12:01:44 -0700
Message-ID: <CAJD7tkamU-rnmw=N+W8Uom1AuK4ADrmW5OxxL8FrFZTxMMP5ag@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: memcg: subtree stats flushing and thresholds
To:     domenico cerasuolo <cerasuolodomenico@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 10, 2023 at 9:48=E2=80=AFAM domenico cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> Il giorno mar 10 ott 2023 alle ore 05:21 Yosry Ahmed
> <yosryahmed@google.com> ha scritto:
> >
> > This series attempts to address shortages in today's approach for memcg
> > stats flushing, namely occasionally stale or expensive stat reads. The
> > series does so by changing the threshold that we use to decide whether
> > to trigger a flush to be per memcg instead of global (patch 3), and the=
n
> > changing flushing to be per memcg (i.e. subtree flushes) instead of
> > global (patch 5).
> >
> > Patch 3 & 5 are the core of the series, and they include more details
> > and testing results. The rest are either cleanups or prep work.
> >
> > This series replaces the "memcg: more sophisticated stats flushing"
> > series [1], which also replaces another series, in a long list of
> > attempts to improve memcg stats flushing. It is not a new version of
> > the same patchset as it is a completely different approach. This is
> > based on collected feedback from discussions on lkml in all previous
> > attempts. Hopefully, this is the final attempt.
> >
> > [1]https://lore.kernel.org/lkml/20230913073846.1528938-1-yosryahmed@goo=
gle.com/
> >
> > v1 -> v2:
> > - Fixed compilation error reported by the kernel robot in patch 4, also
> >   added a missing rcu_read_unlock().
> > - More testing results in the commit message of patch 3.
> >
> > Yosry Ahmed (5):
> >   mm: memcg: change flush_next_time to flush_last_time
> >   mm: memcg: move vmstats structs definition above flushing code
> >   mm: memcg: make stats flushing threshold per-memcg
> >   mm: workingset: move the stats flush into workingset_test_recent()
> >   mm: memcg: restore subtree stats flushing
> >
> >  include/linux/memcontrol.h |   8 +-
> >  mm/memcontrol.c            | 269 +++++++++++++++++++++----------------
> >  mm/vmscan.c                |   2 +-
> >  mm/workingset.c            |  42 ++++--
> >  4 files changed, 185 insertions(+), 136 deletions(-)
> >
> > --
> > 2.42.0.609.gbb76f46606-goog
> >
> >
>
> Hi Yosry,
>
> thanks for this series! We backported it on a 5.19-based kernel and ran i=
t on a
> machine for almost a week now. The goal was to fix a CPU utilization regr=
ession
> caused by memory stats readings, it seems that this series was the last b=
it
> needed to completely fix it and bring CPU utilization to 5.12 levels.
>
> FWIW,
>
> Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

That's awesome. Thanks for the testing!
