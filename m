Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA2B7847F7
	for <lists+cgroups@lfdr.de>; Tue, 22 Aug 2023 18:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbjHVQte (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Aug 2023 12:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHVQtd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Aug 2023 12:49:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D371B0
        for <cgroups@vger.kernel.org>; Tue, 22 Aug 2023 09:49:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so11818331a12.1
        for <cgroups@vger.kernel.org>; Tue, 22 Aug 2023 09:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692722971; x=1693327771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJmDDFJoMLmcyBm51AyWwKm0mGOPqtKf1wtM4HOCd6M=;
        b=rhr1id8cCV/kbx6sUBy4JuHXifHwSkFAIdKhBeasC31TcN98NESIu8KmdqnWiDvLNx
         XVCElQgwl+O+wZiYzPHPSCSCn05CEQlp3i5RqQb+lK1FlRhcDHhBVGdeCc99m+LTx4so
         4zuklsCgH8G/FHHkdSyD18vRYY4Z3DIPKlPrFye8uXb8CDnospBilvEczdx8lGW2wXxX
         k7TcpIodpSQNJnxgspTPGM7gBgd1w/lwzYn9EBLnMdhYMfCPzF4ucPffkpJRPhOpkMRP
         QQfw3YE3NCRa+26WnVXc5hE1sR0WiBM+gFH2GzLxGsziXWtDmMA0VU1Tzs7teeoZQ7ZZ
         IrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692722971; x=1693327771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJmDDFJoMLmcyBm51AyWwKm0mGOPqtKf1wtM4HOCd6M=;
        b=S3NNsEorpmBOrtJAwoCcjnxU7ByROtpCnJytHagDfBU8TNYDrtYS/4QGPL6JPuuPs8
         3UCNqYgSZIF4ecMe5phKISUJ15IeR26WRDuE8pZoFAzL+9fgIV3gd3/+1fs4YoiSNtve
         U+ztQLGQrtc7oRY+xwMVQvlvcaTanjVZ9+B8dUU5f/bV+0yhxBLGymEb7DRBvXgH9pAC
         2LG6u/+wNr1wl2HDATfqe26vv9aE0Fc4xYHcId6kROByQVmeuGq8qlh9C92ELngAYwF0
         aXn7fTmoSHSK9R7sYf2SdCesY/E2JOzVTH/4xy4r6qrjw/bdkPHRWEJxT7G0rrSMO7nZ
         ggow==
X-Gm-Message-State: AOJu0Ywth3vF0cIrQZm/7HbRXhEjD8OtGL+LH/xzvsPBx/G8NPQ+gs7J
        /I8ueK/ecxZ/tzk2pFgK+Xx36YF8poz+uxAJlHYCRQ==
X-Google-Smtp-Source: AGHT+IEmSWJOfsLrRWgrWtGOMYaI3rCgR+YAazW1HntaJGfgHHdcooCvLk9gPLi7fdnb4CMFIaHO9scel4q7H/1YxTI=
X-Received: by 2002:a17:906:478a:b0:98d:f2c9:a1eb with SMTP id
 cw10-20020a170906478a00b0098df2c9a1ebmr11700024ejc.24.1692722970543; Tue, 22
 Aug 2023 09:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230821205458.1764662-1-yosryahmed@google.com>
 <20230821205458.1764662-3-yosryahmed@google.com> <y7vvyndehadwy5ouounm5oyo52bqhsysiizuphzki2h3bwpdpc@3hvaq6sp6f4k>
 <CAJD7tkaVuiMU-ifJiyH5d_W1hi9DnAymYJxzBxEKCVX+tU=OCA@mail.gmail.com> <5y3e32ek6owren3q5e3gzonzxzdhs53ihywj3mtbhz56hnizfy@fctafygsnfaq>
In-Reply-To: <5y3e32ek6owren3q5e3gzonzxzdhs53ihywj3mtbhz56hnizfy@fctafygsnfaq>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 22 Aug 2023 09:48:54 -0700
Message-ID: <CAJD7tkagAie6otamEEVZb5ohp_QUGdTKUNJTTXYfVaaxhtNcAg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: memcg: add a helper for non-unified stats flushing
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

On Tue, Aug 22, 2023 at 9:35=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Tue, Aug 22, 2023 at 09:00:06AM -0700, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > We can probably also kick FLUSH_TIME forward as well.
>
> True, they guard same work.
>
> > Perhaps I can move both into do_stats_flush() then. If I understand
> > correctly this is what you mean?
>
> Yes.
>
> > What do you think?
>
> The latter is certainly better looking code.
>
> I wasn't sure at first about moving stats_flush_threshold reset before
> actual flush but on second thought it should not be a significant change
> - readers: may skip flushing, the values that they read should still be
>   below the error threshold,

Unified readers will skip anyway as there's an ongoing flush,
non-unified readers don't check the threshold anyway (with this patch
series). So for readers it should not be a change.

> - writers: may be slowed down a bit (because of conditional atomic write
>   optimization in memcg_rstat_updates), presumably not on average
>   though.

Yeah writers will start doing atomic writes once a flush starts
instead of once it ends. I don't think it will matter in practice
though. The optimization is only effective if we manage to surpass the
threshold before the periodic flusher (or any unified flusher) kicks
in and resets it. If we start doing atomic writes earlier, then we
will also stop earlier; the number of atomic writes should stay the
same.

I think the only difference will be the scenario where we start atomic
writes early but the periodic flush happens before we reach the
threshold, in which case we aren't doing a lot of updates anyway.

I hope this makes _any_ sense :)

>
> So the latter should work too.
>

I will include that in v2. I will wait for a bit of further review
comments on this version first.

Thanks for taking a look!

> Michal
