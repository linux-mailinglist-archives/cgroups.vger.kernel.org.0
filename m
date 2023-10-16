Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8616F7CB2C5
	for <lists+cgroups@lfdr.de>; Mon, 16 Oct 2023 20:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjJPSnU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Oct 2023 14:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJPSnT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Oct 2023 14:43:19 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2DE95
        for <cgroups@vger.kernel.org>; Mon, 16 Oct 2023 11:43:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so8564674a12.0
        for <cgroups@vger.kernel.org>; Mon, 16 Oct 2023 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697481796; x=1698086596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZ0ZrYffOwIERykWVa6KRaarkUZ2JSWpphezZN2YtPM=;
        b=kAaakvXUQbABtmokJ/RUkRQDfv+r0whhspu9BQUxYskXYPfYGQoq2Ry0Mp/e5Onzpz
         PMM3PcXJyp0/NkuUM7HT/9z44E9Ca3XPqVbSZBB2UTdpZNifIPl5LjgG6wBQ8AG2x+yO
         9xqJOn5qKsuyr3o57SuvwPx9kmBKodku464a5DMGVhE6tjWpCB7WQKrNwhgEHGWYUex5
         6l2PxX2u8VV03N4le/kQ9tTnD4FfAzRXqoBq041NzMVnHadxpAVsJP58R9bVIA+K2TFV
         m+djX74TlQfCy0C5A0EA0IhN6+lOl86s5fHmeSlRj7q9xPzF8/6tYQIifXmAlN3iaqJe
         fBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697481796; x=1698086596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZ0ZrYffOwIERykWVa6KRaarkUZ2JSWpphezZN2YtPM=;
        b=Zrt7wX2NoxlJkjCZwfxEfqZJ2l6iVHnohRJkjgl/nBEkMowbYv5uiywlcjBLZj6fHj
         eztPhvmILXLNP64BqcOPNg8qSuMHF9dIA/pnVX3dH2Nx0G3Q4F04rINTUkRza4i2wUDO
         1FzzVkYVwUVQhicrKmcL3jqepAMO4fmot2ZrBtPDUeJc0ggozpjGpwUrta24GXBo8vaO
         2253Pj7lYp/YGnjIKZEO6wqsb1FYlchSQoW2gBrQWhKXgRBUCN/C0tjHSL6Qdxw1xMMf
         7fuR7TjGvHiGcNWWzYB0jMKF466KjKlUkveWYEN9qLh0gMs03U8tzhh5Y/apSWz7LuVz
         57Kw==
X-Gm-Message-State: AOJu0YzWFeLJZKLyZnqDTMF1K6k33RCUh0EmCrwsjqKayF+SjpP94/mC
        6NF58tCdWewcQRtXLp0SLQc2q6ESpiswKBhufGnpTg==
X-Google-Smtp-Source: AGHT+IHcJAnmkcuBDL7y5ZpP65UFgSMdET49K6xGRe4fwTypGO5gVyfv4ceeGWM+Ifjo5ROYf+94PVO8qSP4TGucYTY=
X-Received: by 2002:a17:906:ef07:b0:9bd:e99b:82d2 with SMTP id
 f7-20020a170906ef0700b009bde99b82d2mr7535901ejs.9.1697481795750; Mon, 16 Oct
 2023 11:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
 <CAJD7tkZSanKOynQmVcDi_y4+J2yh+n7=oP97SDm2hq1kfY=ohw@mail.gmail.com>
 <20231011003646.dt5rlqmnq6ybrlnd@google.com> <CAJD7tkaZzBbvSYbCdvCigcum9Dddk8b6MR2hbCBG4Q2h4ciNtw@mail.gmail.com>
 <CALvZod7NN-9Vvy=KRtFZfV7SUzD+Bn8Z8QSEdAyo48pkOAHtTg@mail.gmail.com>
 <CAJD7tkbHWW139-=3HQM1cNzJGje9OYSCsDtNKKVmiNzRjE4tjQ@mail.gmail.com>
 <CAJD7tkbSBtNJv__uZT+uh9ie=-WeqPe9oBinGOH2wuZzJMvCAw@mail.gmail.com>
 <CALvZod6zssp88j6e6EKTbu_oHS7iW5ocdTWH7f27Hg0byzut6g@mail.gmail.com>
 <CAJD7tkZbUrs_6r9QcouHNnDbLKiZHdSA=2zyi3A41aqOW6kTNA@mail.gmail.com>
 <CAJD7tkbSwNOZu1r8VfUAD5v-g_NK3oASfO51FJDX4pdMYh9mjw@mail.gmail.com>
 <CALvZod5fWDWZDa=WoyOyckvx5ptjmFBMO9sOG0Sk0MgiDX4DSQ@mail.gmail.com>
 <CAJD7tkY9LrWHX3rjYwNnVK9sjtYPJyx6j_Y3DexTXfS9wwr+xA@mail.gmail.com>
 <CALvZod6cu6verk=vHVFrOUoA-gj_yBVzU9_vv7eUfcjhzfvtcA@mail.gmail.com>
 <CAJD7tkavJDMSZdwtfxUc67mNBSkrz7XCa_z8FGH0FGg6m4RuAA@mail.gmail.com> <20231014160831.73785b15e9b34eb6146d5497@linux-foundation.org>
In-Reply-To: <20231014160831.73785b15e9b34eb6146d5497@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 16 Oct 2023 11:42:35 -0700
Message-ID: <CAJD7tkbSJL4sk8yG9H_kHhqAwZDZAS=6DzUUVHURDK3Ug9nCog@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>, michael@phoronix.com,
        Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Oct 14, 2023 at 4:08=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 12 Oct 2023 15:23:06 -0700 Yosry Ahmed <yosryahmed@google.com> wr=
ote:
>
> > Meanwhile, Andrew, could you please replace the commit log of this
> > patch as follows for more updated testing info:
>
> Done.

Thanks!
