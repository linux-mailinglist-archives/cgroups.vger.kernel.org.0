Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1659A6F18C8
	for <lists+cgroups@lfdr.de>; Fri, 28 Apr 2023 15:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjD1NFy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Apr 2023 09:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjD1NFx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Apr 2023 09:05:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA84E3
        for <cgroups@vger.kernel.org>; Fri, 28 Apr 2023 06:05:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-94f6c285d92so1883731066b.3
        for <cgroups@vger.kernel.org>; Fri, 28 Apr 2023 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682687151; x=1685279151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQwjJ+xoYNglHrNfrRoLJyEfjXE+BHOsMRCb4QaEt/g=;
        b=EBoAejzwbTBADNp4pMEUIYW1v6E60NZGOyGiIHIIH7vNiwcU0E7lyoZfCG6RImKtmC
         j6fL6h5wjwiZ9e0OL2cB8QRZ6rXObXCtLg44xFci+vz4TpqyvvTeApbKgE+spgGCeXXe
         PGYqgRzsQ2B4DN+Xfr9MAvKm4PaTJk6FWKLJDSHBRjJmvoaOSm7BijKvp56/DpJHhAm/
         LhGWTCmWWzMDMRSkoZhB0AMKWOqvDgQkNSdttAvx+QEanXzXoFcWZ/8iylKiNS/LuI9G
         mdoG+F329veZDK2/AHXVUEqTjRyr2moo9MvG2Rn3oOe2sh6y38Vx+SHqHCLkkE4Eutuu
         7ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682687151; x=1685279151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQwjJ+xoYNglHrNfrRoLJyEfjXE+BHOsMRCb4QaEt/g=;
        b=daZebmynTCsr2FSW6ucqK82OfBDYqRtFhQc1bG7j+TXRUad9g/uvvc1miFOGQ5UQKi
         4RKRmjxOCDJ6IR0s8h0ROaRN9XvrAF5BlUJokCotewFajjQXp9l8i8ykJ5LgdH8LJJcq
         s+vbr5gQwuq3sxzEiyciLWdvuKPkAUve+mqiLnxhw9E5wR/7qKS+6n1wRziQlMedHwa0
         uckNncjgieYpole279AMZjUr5ZHBflI5aGls3Lm17LiwSvGm9o6b1OPFTh9sQNm2GccB
         K1vnXjpXRLq8y7ffYg2FeEEicQkYaa/OKZPum0vPw0MArBIqFG6LKiPL2m5uAEYYkebF
         kcGg==
X-Gm-Message-State: AC+VfDxvbV+EWJFnBeYeJS1tWfZYm4wrFW89OmnSN827kogJSXZ/lKfx
        1UP8rvawhv3fS1iSfgp0L7PoGgAxAJ14eSPy2B8wJA==
X-Google-Smtp-Source: ACHHUZ4r5TWSqC3HWv9cq3pAKjRH8mGLSn4q32vcFG75oMkzb37AVhcCttrizjvzVWMZc8n8LhWpr9DTBmrz7YuxSvU=
X-Received: by 2002:a17:907:629b:b0:95e:e0fa:f724 with SMTP id
 nd27-20020a170907629b00b0095ee0faf724mr5579644ejc.39.1682687151086; Fri, 28
 Apr 2023 06:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230426133919.1342942-1-yosryahmed@google.com>
 <20230426133919.1342942-3-yosryahmed@google.com> <ZElC127xlU2NtlqF@dhcp22.suse.cz>
 <CAJD7tkZ1cODXRuVQ3fWL0s=VsyKZqDPPNqFZec_COAXm0XfXWA@mail.gmail.com>
 <ZEqBesAJFfLZI65/@dhcp22.suse.cz> <CAJD7tkac7VKV6Ob8qQWzhm8Ayyk3xB0YCY6edL-TxpXV3aCzXA@mail.gmail.com>
 <ZEuVaxSUo7WxLn3K@dhcp22.suse.cz>
In-Reply-To: <ZEuVaxSUo7WxLn3K@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 28 Apr 2023 06:05:12 -0700
Message-ID: <CAJD7tkZJK7yYueixaYh4J1vpMf+WYkDj-sm7fsfbv-irXQ_9Wg@mail.gmail.com>
Subject: Re: [PATCH 2/2] memcg: dump memory.stat during cgroup OOM for v1
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 28, 2023 at 2:44=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 27-04-23 15:12:46, Yosry Ahmed wrote:
> [...]
> > However, I still think this change is valuable. Like you mentioned,
> > the OOM log is not set in stone, but we shouldn't just change it for
> > no reason. In this case, for cgroup v1 users, the OOM log changed for
> > no reason beyond a side effect of another patch. Upon upgrading our
> > kernel we noticed the behavior change. This patch restores the old
> > behavior without any cost really, and it makes the code a tiny bit
> > more consistent.
>
> Fair enough. Just make sure you go into more details about why this is
> causing problems/inconveniences. I am slightly worried this might cause
> problems to other people who would like to have the same report for both
> v1 and v2 so we should at least have some solid argumetns to revert
> rather than "it used has changed and we liked it more that way".
>
> I personally do not care all that much. It kinda sucks to dump counters
> that are not tracked or fully tracked in v1 because that can mislead
> people and that would be a bigger problem from my POV.

Great point, let me send a v2 rephrasing the commit log of this patch
and adding the Ack's on the first one.

Thanks Michal!

> --
> Michal Hocko
> SUSE Labs
