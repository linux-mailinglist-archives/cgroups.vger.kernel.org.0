Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C907B7206
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 21:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbjJCTsL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 15:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbjJCTsK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 15:48:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A329E
        for <cgroups@vger.kernel.org>; Tue,  3 Oct 2023 12:48:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b275afb6abso35962966b.1
        for <cgroups@vger.kernel.org>; Tue, 03 Oct 2023 12:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696362485; x=1696967285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOpsGqr/1X6QNuekTXnkVYBCRlCRIHiN3DAE7IpST8U=;
        b=1az0PmajPzwto0rq2esc/k2S0Pnt43yHIQBu+ZPzvsEvpmDuzg7+5E2lIhiNF95U8+
         ikswyKwMXhcedryNsdBLpJY4VSVOVtZqAxzYmxCw5idI0fduTmbT3VZG0CecqN0cF6Ac
         M6SGUCd/eAWDt4phYDvR7z606PpiarVSgRfD0SBkYU1KoOUubBUQCGBvAspUsak1em2Z
         EKyByed5xjUlcQ4gb+H1FsIkWPuAZ8gFrLO7D6MLfdwpeWCRIt6BYD7P7nPsZOoUxjsh
         B794W5ket9DQggloVDWi0fi9GkLUI7E6Tj1Z2gN7aNPXUgxPPSUns/q7X1rBBwV2cWAR
         VkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696362485; x=1696967285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOpsGqr/1X6QNuekTXnkVYBCRlCRIHiN3DAE7IpST8U=;
        b=f9YVmddbowiaoO/SIMSS83U5YXigTLkW8HNnMk7jjYU1Ihj4mN7xn4Y6UjATy7beU8
         kGsrKbqiXgZu/JPaTwbY2UAHP3TzbHcKxw5zQ+bKXrX4+dJtxjwZIMI1crilDYKnVHuT
         68gyv0VAabBOW0bvWPuCp+lcKE6+bWSh/LCsnsiuj3iRsW1VnAYJ7MzTNfeg72HbdQZB
         jOuj5A42ryOEjwcmWPrPLsbqBZf2TAil4sMqqq3eMdS3g28Y7bJHQzRFYMAe8sGq//qM
         tHkpWzUVCx/kybeERcBWKaJumNEkmZvis15X3Bj80NzS7lPBa6hN1pWk4x9LVRiFBONX
         /dXw==
X-Gm-Message-State: AOJu0YzJcBPLyVXZCtjtC6Y7MKRKjkS6OJ2bMYlCqrx/IReCY6iOQfR5
        lAjDf/4zEMvM2twdVbY4bzsbW/GzSJPjIyAzYw7W2A==
X-Google-Smtp-Source: AGHT+IEduj8Ue23tVtZwd5CtZZj5Q4zwMVYXYYDO6HK5+K42BJDPJ0e73p0G3lOHo3Nav0AoLLfFBkaPQhiBGYvWD34=
X-Received: by 2002:a17:906:846a:b0:9ad:e41c:e9c9 with SMTP id
 hx10-20020a170906846a00b009ade41ce9c9mr203402ejc.3.1696362484670; Tue, 03 Oct
 2023 12:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175741.635002-1-yosryahmed@google.com>
 <20230922175741.635002-2-yosryahmed@google.com> <lflzirgjvnodndnuncbulipka6qcif5yijtbqpvbcr3zp3532u@6b37ks523gnt>
In-Reply-To: <lflzirgjvnodndnuncbulipka6qcif5yijtbqpvbcr3zp3532u@6b37ks523gnt>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 3 Oct 2023 12:47:25 -0700
Message-ID: <CAJD7tkbfq8P514-8Y1uZG9E0fMN2HwEaBmxEutBhjVtbtyEdCQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: memcg: refactor page state unit helpers
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 3, 2023 at 11:11=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Fri, Sep 22, 2023 at 05:57:39PM +0000, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > memcg_page_state_unit() is currently used to identify the unit of a
> > memcg state item so that all stats in memory.stat are in bytes. However=
,
> > it lies about the units of WORKINGSET_* stats. These stats actually
> > represent pages, but we present them to userspace as a scalar number of
> > events. In retrospect, maybe those stats should have been memcg "events=
"
> > rather than memcg "state".
>
> Why isn't it possible to move WORKINGSET_* stats under the events now?
> (Instead of using internal and external units.)

Those constants are shared with code outside of memcg, namely enum
node_stat_item and enum vm_event_item, and IIUC they are used
differently outside of memcg. Did I miss something?

>
> Thanks,
> Michal
