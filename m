Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6D779C9D
	for <lists+cgroups@lfdr.de>; Sat, 12 Aug 2023 04:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbjHLCeJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Aug 2023 22:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjHLCeI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Aug 2023 22:34:08 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C856A2683
        for <cgroups@vger.kernel.org>; Fri, 11 Aug 2023 19:34:06 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40a47e8e38dso83201cf.1
        for <cgroups@vger.kernel.org>; Fri, 11 Aug 2023 19:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691807646; x=1692412446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTLD/QdYHVpt+4scbNbRrg+8KO9/38zELxI1928BfJc=;
        b=UdPOJ9r4HII7NNEiN5YCqMDeu6BvUbS2vwkDURY9Vi5e0eAEJ7VRD1haOIydI+Ib+7
         ta1fdKZPPI1LTFwuiLyNY15TXJfATouhe8oZDdjIU1ZJs5/a6HUe1jv6A9NBzwO8Kez+
         2dU9q0qA6XuEdoQybkOjDZWLqRqBB1YV1JxL8ygLQ1tn17frZDK7VFkRcf+YmkbWHaJY
         HWs9tbWC3xenui2rP6kX0MFlB60LyMS5NfLN2AFTisRDNP9qM6Snpohl0mnKK57hQh1r
         HH1mpbjF0mqUoiZO3XlpiVHLkH1vlUIf9Galfiph8Pyhsz1aR38R7jOOLjp7gUKGAIu8
         oVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691807646; x=1692412446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTLD/QdYHVpt+4scbNbRrg+8KO9/38zELxI1928BfJc=;
        b=Ihx+YiIGdSq0J/lLIqwqGCYfGEwuk5tnK9WbrM02zu9R43PQvdUN+U2TMfmncDQcb/
         6179g6ff1PJsB3l0bvtlrKiP64Tjx3t1V7M/1tVT7rz6yO37VgcFbm+T/Yk6K7zvJ5OE
         0J7Xf5zh5LnrJ8oAOmYjJZTHPGx0CLISOfLZ0Xf992uzdNZIuOsPHBFjkd7egDbEGS7w
         NmyPkIDLPTiLrZB4IESor7odP0xHVAzP2MPap0XJaGl/mXe+pWG5xNKBAbekZYiZAmsW
         9w7GzOaznthgI/EyCY3P9iqyz+v8swa7B7tqi1LF66oxCdohUzfOcExo9KXVFMVnYKUd
         vOuQ==
X-Gm-Message-State: AOJu0YzgYp7Bq5qKV6Cbgcf0qVO+MivMNsX3hGI8FFCm9E9I4BBcAsyw
        Q42Z+Phs2oIzoglhM683TxSP3o5mjXn7gKXsmFzLSg==
X-Google-Smtp-Source: AGHT+IFzvKTREcAhH2+jX2sXMEF76gbO+jOHLFbMQ+tmhgXwxqHHARCI21qZWA2f+rP5y3xkgzylMECxeqsLZDtI3FY=
X-Received: by 2002:ac8:58c2:0:b0:403:a43d:bd7d with SMTP id
 u2-20020ac858c2000000b00403a43dbd7dmr408231qta.4.1691807645900; Fri, 11 Aug
 2023 19:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
 <20230706062045.xwmwns7cm4fxd7iu@google.com> <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
 <d3f3a7bc-b181-a408-af1d-dd401c172cbf@redhat.com> <CABWYdi2iWYT0sHpK74W6=Oz6HA_3bAqKQd4h+amK0n3T3nge6g@mail.gmail.com>
 <CABWYdi3YNwtPDwwJWmCO-ER50iP7CfbXkCep5TKb-9QzY-a40A@mail.gmail.com>
 <CABWYdi0+0gxr7PB4R8rh6hXO=H7ZaCzfk8bmOSeQMuZR7s7Pjg@mail.gmail.com>
 <a052dffe-ed5e-6d22-8af8-0861e618f327@redhat.com> <CABWYdi0CXy2GZax_s6O-Xc0gvH+TGJzKwv_v6QqMty9P-ATJug@mail.gmail.com>
In-Reply-To: <CABWYdi0CXy2GZax_s6O-Xc0gvH+TGJzKwv_v6QqMty9P-ATJug@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 11 Aug 2023 19:33:54 -0700
Message-ID: <CALvZod65Y-dSkH6a=ASTDTK2oGznTd7Yts1csttxoP0w9jaQUw@mail.gmail.com>
Subject: Re: Expensive memory.stat + cpu.stat reads
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

Hi Ivan,

(sorry for late response as I was away)

On Fri, Aug 11, 2023 at 3:35=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
[...]
> > > I spent some time looking into this and I think I landed on a fix:
> > >
> > > * https://github.com/bobrik/linux/commit/50b627811d54
> > >
> > > I'm not 100% sure if it's the right fix for the issue, but it reduces
> > > the runtime significantly.

In your patch, can you try to replace mem_cgroup_flush_stats() with
mem_cgroup_flush_stats_ratelimited() instead of cgroup_rstat_flush().
I wanted to see if you observe any stale stats issues.
