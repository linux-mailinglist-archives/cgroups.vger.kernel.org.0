Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6472657BD55
	for <lists+cgroups@lfdr.de>; Wed, 20 Jul 2022 20:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbiGTSDg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Jul 2022 14:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbiGTSDf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Jul 2022 14:03:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885C95D5AD
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 11:03:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bu1so27219014wrb.9
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2YSXf98rTw+aM6nqedJXsMdekQD67mGphdqXFvr1fbM=;
        b=dnV0YHWvnhuMUuSd57347+DOzR3AxQcrR7zzAGoWSmv8OwPuA4SNbmOO5Dz88dFjqy
         kls9OTarVd8bmE/zaV7DVW5OrVc2W6xDg9rvm85GE0fVrn+2S8m/4yEbf3pPxfB1qZKb
         v3sjYgyUFN3/vHk3+826GcexfrrE6GCpCZu4Q6Bn1efuiZU9eBg1uXRDZTJRXJx3UKbN
         2zfN3FZLP1hZvN7KZrO1h+8oAIhvt5/VumAis5ShZIb7OCuHVOo5kkDLK+zwYpcXRfgC
         lQX0lzUNZpJW6zkqJ6iPyGtc7lQuGW3RZ6Ssly/XvZ0alzMjN4C6DqQBTB3InJ3Gmly1
         XlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2YSXf98rTw+aM6nqedJXsMdekQD67mGphdqXFvr1fbM=;
        b=s6CFxlnGh7AwHShcSKTlO1q//9NACmjnqmJNHbCXunumy7nmRHRuZCumoItB0rQhDu
         i4QW2I1koLqwsuVfVBV2UnqVvRNwcaGwJTJFWnK+0mKoXVE5gCZXugysIkiuo57cuTp+
         KCNcbBRAfg+3c328yNq3+TauR7l7dALDYO/Z9TGVcfkdQWaxTJ0Zp0AoioFPYloKnY5T
         a4PrYTmFgIb0cDUjj3NdJVsQi92OyljTA1PykNtwFkPNgLFXrk0B1xrWWMoyF4uLj2dv
         89Ueym+7w9N+L+SXWzXVtM4+ykaq4tM5CohbgTPHxVJEkB/8pOMpIKSTsudbggct1cJm
         4SSw==
X-Gm-Message-State: AJIora8+X4JxE4sSMJFw8pjmjSRhel4fADDMINakBjeyFMG9oAd/avPt
        hTpgzKUBoDM186DqFbmWZsW7wawe8C3iki4Z6msxgQ==
X-Google-Smtp-Source: AGRyM1uFir/eG19aQ9wS4vWbQl35bcqmiCabGhXOvV9aIJvJ6VfH+DygWDgwwsRIhPPMb59vxOQgcxQvjcRrm1wgk54=
X-Received: by 2002:a5d:5a82:0:b0:21e:2899:60bd with SMTP id
 bp2-20020a5d5a82000000b0021e289960bdmr9534113wrb.80.1658340212940; Wed, 20
 Jul 2022 11:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220714064918.2576464-1-yosryahmed@google.com>
 <YtfJug77XJ9BPA8L@dhcp22.suse.cz> <CALvZod7X3PsM2+ZrWXwb75FNBBjaBGJpjd+WVmzr5hStROvW+g@mail.gmail.com>
In-Reply-To: <CALvZod7X3PsM2+ZrWXwb75FNBBjaBGJpjd+WVmzr5hStROvW+g@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 20 Jul 2022 11:02:56 -0700
Message-ID: <CAJD7tkYBm+L_-GTLDux0ZsJ6=kw-zzHjs6vgKUtmeZhcxLwqiw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: vmpressure: don't count proactive reclaim in vmpressure
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 20, 2022 at 10:50 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Jul 20, 2022 at 2:24 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> [...]
> >
> > I think what we are missing here is
> > - explain that this doesn't have any effect on existing users of
> >   vmpressure user interface because that is cgroup v1 and memory.reclaim
> >   is v2 feature. This is a trivial statement but quite useful for future
> >   readers of this commit
> > - explain the effect on the networking layer and typical usecases
> >   memory.reclaim is used for currently and ideally document that.
>
> I agree with the above two points (Yosry, please address those) but
> the following third point is orthogonal and we don't really need to
> have an answer for this patch to be accepted.
>

That's great feedback, thanks Michal and Shakeel!

How do you feel about the following commit message instead? Does it
address your concerns?:

memory.reclaim is a cgroup v2 interface that allows users to
proactively reclaim memory from a memcg, without real memory pressure.
Reclaim operations invoke vmpressure, which is used in cgroup v1 to
notify userspace of reclaim efficiency, and used in both v1 and v2 as
a signal for a memcg being under memory pressure for networking (see
mem_cgroup_under_socket_pressure()). For the former, vmpressure
notifications in v1 are not affected by this change since
memory.reclaim is a v2 feature.

For the latter, the effects of the vmpressure signal (according to
Shakeel [1]) are as follows:
1. Reducing send and receive buffers of the current socket.
2. May drop packets on the rx path.
3. May throttle current thread on the tx path.

Since proactive reclaim is invoked directly by userspace, not by
memory pressure, it makes sense not to throttle networking. Hence,
this change makes sure that proactive reclaim caused by memory.reclaim
does not trigger vmpressure.

[1] https://lore.kernel.org/lkml/CALvZod68WdrXEmBpOkadhB5GPYmCXaDZzXH=yyGOCAjFRn4NDQ@mail.gmail.com/

> > - how are we going to deal with users who would really want to use
> >   memory.reclaim interface as a replacement for existing hard/high
> >   memory reclaim? Is that even something that the interface is intended
> >   for?
>
> I do agree that this question is important. Nowadays I am looking at
> this from a different perspective and use-case. More concretely how
> (and why) to replace vmpressure based network throttling for cgroup
> v2. I will start a separate thread for that discussion.
