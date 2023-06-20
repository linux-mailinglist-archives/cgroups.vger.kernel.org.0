Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4567A737414
	for <lists+cgroups@lfdr.de>; Tue, 20 Jun 2023 20:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjFTS2h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Jun 2023 14:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFTS2g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Jun 2023 14:28:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C0710D0
        for <cgroups@vger.kernel.org>; Tue, 20 Jun 2023 11:28:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f9087fe166so271365e9.1
        for <cgroups@vger.kernel.org>; Tue, 20 Jun 2023 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687285713; x=1689877713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFbvkXsr4CwoXTBxubkyGQRrKVV7vjMo0YaS6cmSpvY=;
        b=s/c6tS2ooBamHjhW13lHYSQjuiL9w2u4j7wJkYXgvTp4qV2mzF6TcixK0rWzgIBnoW
         BstA/5FFTmUREVNKPxBC8p5k0unaa8BO4lbwg5+5HaWBTQ+EyIQcHvsqcdJke/3TcuH3
         q7pQHBT3Q6mhkyumpKUrcMMGdRlva7pmkR2tnUFFt+c7aCgwq0rR5RJIJ1pnPEIcE0Rk
         tDA3F7vlTCotGqsQJzU06iJwGm5oDGmLFEWRL4CuoogKHzHZzyaw5LBQ6XK8fmVFSBBj
         +MzONGmtCK3l/t2go7eX0LhtSbV+a6o9DZlaxEQEU4/qUt4wTv/xrw9OqtlbS0sxRtQ0
         bEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687285713; x=1689877713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFbvkXsr4CwoXTBxubkyGQRrKVV7vjMo0YaS6cmSpvY=;
        b=WYmOGIrC5NwYXE+qCglStAFoD9a2c+9whmepgd6Ca4k590Z2An0Qc4ZJL0rMsZ3q9M
         WC9lcG0S7sVhWhGbc+ktzKBffqrdRL/Sg8od68l1g8XK7xEsM3BSTAZkduCrtp50pMe+
         Re0IvMJSb9qFSDT9J15f44FeH+l8qtaxoXJFI9n6Qq/Bxvbwfoo2Da6rgShbngBMxD3W
         eUTyP8evFC2JhAFfkXW8JylYFt3ear5JVJo0uElmnHuLU6wPo3MDJIje37OkJyz5RjwS
         nPZuIAhRdZUJjyBD6gCDHQS+lhS1wAw6IW8JAy4yNmNqWf3ikhB6TwlQGGB7sMwynPGg
         BCsA==
X-Gm-Message-State: AC+VfDxolUXX04sPCejw/L1vJlRDGn30sE5kN4cmebae4/Ba8sT+AEwI
        MyNIiUm2adVkuhpVeA7CtZmO+R9aWbgAA6y1m64jPA==
X-Google-Smtp-Source: ACHHUZ6GL7DPoUGJGVN+BUEsCW9up0e3cM9XciBuL/j9mrZLRiMdBeJ/cAv2k6OCSLFtu9H6wllX3uE1ddA5/6MVyNk=
X-Received: by 2002:a05:600c:4f91:b0:3f7:e59f:2183 with SMTP id
 n17-20020a05600c4f9100b003f7e59f2183mr158615wmq.5.1687285712945; Tue, 20 Jun
 2023 11:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230612232748.3948659-1-joshdon@google.com> <20230612232748.3948659-2-joshdon@google.com>
 <rs46fzspb2w46zcbgdjysqd2rcfqs4yk55xyf5syvnf75rjhfe@ku6i5chn5qrq>
In-Reply-To: <rs46fzspb2w46zcbgdjysqd2rcfqs4yk55xyf5syvnf75rjhfe@ku6i5chn5qrq>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 20 Jun 2023 11:28:21 -0700
Message-ID: <CABk29NtvNzG3A8CUXwukpRx65Drqynhr+agCcQG23qZVD7FqPw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched: add throttled time stat for throttled children
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiangling Kong <xiangling@google.com>
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

Hi Michal,

On Mon, Jun 19, 2023 at 10:53=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
>
> On Mon, Jun 12, 2023 at 04:27:48PM -0700, Josh Don <joshdon@google.com> w=
rote:
> > We currently export the total throttled time for cgroups that are given
> > a bandwidth limit.
>
> I assume you refer to cpu.stat:throttled_usec (from struct
> cfs_bandwidth) -- notice that the value is not properly hierarchical
> despite v2 filename.
>
> > This patch extends this accounting to also account the total time that
> > each children cgroup has been throttled.
>
> IIUC, this is visible on inner-nodes cpu cgroups (i.e. with no tasks)?
>
> IOW, wouldn't you get the intended information if hierarchical summing
> was added/fixed for cpu.stat:throttled_usec?

It isn't currently hierarchical in the sense that the inner-nodes
don't themselves account their throttled time, but the summation at
the top is still correct. This patch is intended to close the gap. I
suppose your question here is why not simply make the existing
throttled_usec export properly hierarchical, and avoid the extra stat
export here. I think it might be useful to still expose a
non-hierarchical metric indicating the throttled time due to the
group's own configured limit; the accounting can look strange with
nested bandwidth limits. Not strongly opposed to the idea, but your
hierarchical accounting proposal is essentially what this patch adds.
