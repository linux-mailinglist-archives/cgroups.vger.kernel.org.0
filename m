Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8001675B99E
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 23:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjGTVe4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 17:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGTVez (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 17:34:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD0C2711
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 14:34:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9891c73e0fbso275670466b.1
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 14:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689888893; x=1690493693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8M/vsrDPgbcMRJ+Hz8ExsxXitAhWOIkWtKa6/Y/Z+4I=;
        b=FEFpmVz/KKb7wDCywJRnVOnCvgFqDWvuSDQWT41va4UtaSdnRtPeDDIcVMNGR0e29e
         rJg8Ax3YNYlSISDYQ7jzUG307edzjLS8LL/bfFzWh4KgLjwVvEs3kuIEY2KP94tb1FIa
         TNgD0z2sfZymCarasxwj5xXZiDpn0O8nTxxYnA7xx3Pn+93XaS8GnuC8MLgnxvViKia8
         EyzHAi3axJqTvk9MtT6m05861Akes4vvAFB2hyEmpckWFpyT6wFzCIBDIXKwo93ldJwO
         ZRZDtA7ptbLtMZz3GKphLmh7gcU4+Qe0DoASAzsDNGpCEfFrYbCa8wmCteJ03AHnh/aA
         UvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689888893; x=1690493693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8M/vsrDPgbcMRJ+Hz8ExsxXitAhWOIkWtKa6/Y/Z+4I=;
        b=P+D7oBpKoGrRscyL4o54/HuuLoTyv6zpe4zeXH7zVtg/qCv/h6gQpFkyd2Iw8nHOgf
         FcEEy0Qfow1p0ybfj89R6KE5Md3xaa50NiFlOj3YkQr98fKxRu2cx1EqaCPgqwSvvo6Y
         QDegMMnORK9xvOKcFoFV5JQUimrB1KPgw80cY9dWTvUYVN6cMzuItGsFLmx0XfQpJMD1
         kmYVMpiKk2ki12PLOxY6pWn7Z49o2aHxCqIAYHAaHppShvWXLulGQvOVGcZ+aCOQbWLK
         JSYPcrurZsuPGcRjyk3bMg/rDidLsohLHJDNLbkGMOEDiQIgXxNKmnV/9TBekJcd60Kv
         j/yw==
X-Gm-Message-State: ABy/qLaTDkeliIE5jSmMB657VzNA0uFEiRejLSP6ngUNJRth/4qDM0wv
        finstlxVqq7rN73eNI6Ngm4H8kir92d0GMWTvNO2wA==
X-Google-Smtp-Source: APBJJlEYnqPAFrjqf+ygbKxi+olMDpy9q0FfJC1zTRI0UEMg2hkOT8yQ1c5P+I3uDv3gPHYL3Pz26P6ByMGyrguE0Ic=
X-Received: by 2002:a17:907:1c93:b0:997:b8dc:30a2 with SMTP id
 nb19-20020a1709071c9300b00997b8dc30a2mr7745171ejc.33.1689888892875; Thu, 20
 Jul 2023 14:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com>
 <20230720153515.GA1003248@cmpxchg.org> <ZLmRlTej8Tm82kXG@slm.duckdns.org>
In-Reply-To: <ZLmRlTej8Tm82kXG@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 20 Jul 2023 14:34:16 -0700
Message-ID: <CAJD7tkYhu3g9u7HkUTFBtT3Q4edVZ2g1TWV1FDcyM9srrYCBLg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] memory recharging for offline memcgs
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 20, 2023 at 12:57=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Thu, Jul 20, 2023 at 11:35:15AM -0400, Johannes Weiner wrote:
> > It could also be argued that if you don't want to lose control over a
> > set of resources, then maybe don't delete their control domain while
> > they are still alive and in use. For example, when restarting a
> > workload, and the new instance is expected to have largely the same
> > workingset, consider reusing the cgroup instead of making a new one.
>
> Or just create a nesting layer so that there's a cgroup which represents =
the
> persistent resources and a nested cgroup instance inside representing the
> current instance.

In practice it is not easy to know exactly which resources are shared
and used by which cgroups, especially in a large dynamic environment.

>
> Thanks.
>
> --
> tejun
