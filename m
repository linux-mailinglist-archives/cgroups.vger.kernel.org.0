Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784EE58193B
	for <lists+cgroups@lfdr.de>; Tue, 26 Jul 2022 19:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbiGZRzZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jul 2022 13:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239732AbiGZRy6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Jul 2022 13:54:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC81B32D96;
        Tue, 26 Jul 2022 10:54:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id y1so5985375pja.4;
        Tue, 26 Jul 2022 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=DFgeZNTjRjBYgNmkhdouEdidU0qh0nBq3Cx2lZF1bjo=;
        b=CwrXMvt6/2k2vhgXq2Vb5DoxMilL8fBFiWso9p0CwMybnJwusgl9XqfCmfL15TCl/f
         YO5t7j9otoleOuTxlsKptSB13ABGonnW0GPUIS+uJYv/KPEJI3j4aJ/DtNBD8Pm0JAxr
         dBjWNczvJno4T49bQoez0qCGdPbHxMN/MSz3IvTKlsDq6A/StReJkCFryjZ9J/mjme06
         sXd0PRLlqo6DYc57xeeYIBSiV6psMdtqGem+lhK6UtyvHa1s2UFzW3Y2xnRvTScWajy1
         qVHrNKaL1jqhqbmuoEooMh2JbJgjKpWnzfD58J0gqQf58R3RPlcvmbjpNbpRi+zPEh/H
         29Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=DFgeZNTjRjBYgNmkhdouEdidU0qh0nBq3Cx2lZF1bjo=;
        b=Do7zoDzmKq3mTqykYOz/A7O2zRdIaGjqY/5rdMynZ0k4Y6Ek3/t9DSMELqWNOe0p1F
         38RzLamfPUctuMIrS3ycxW/30jM5XkgvaFg7rWTlu8Hfr0KgLdMZwabI7JmH9Ol0mD6v
         qXfekNJUkt+TyLWRlqwrlcPWY3noXmUtuuAPKAEp/qYO/ICC1qvLcP/kkWdLJpCC2d+y
         G9wTwbKvKOASWpGINDhQZFtOJV2/M0+OZ3GgQPv1GQXpexphNFxMdVEeYNIVLBhfq3bX
         Lkt4G26zGi+CFmqhFb+ArcLhONkl3mfq41CNY9Rqq3TOPakMwmiWakZ21cySoihf6Guu
         NIMg==
X-Gm-Message-State: AJIora/kXcbJOpAK5VTkEn6sKj1N000/RjZSRP60HCNXFv0S6owYndrJ
        ryPzltkLdhp7fiaGPzYSj/4=
X-Google-Smtp-Source: AGRyM1ud25FajCVCktAoc541/7Za4Wpo53h5rofIYfCdMuUyIOw0RhCVOBbsOD8yCzUyfX1E6liCSw==
X-Received: by 2002:a17:902:ec8c:b0:16d:4644:950d with SMTP id x12-20020a170902ec8c00b0016d4644950dmr17679208plg.141.1658858077176;
        Tue, 26 Jul 2022 10:54:37 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:370d])
        by smtp.gmail.com with ESMTPSA id v2-20020a1709029a0200b0016d2db82962sm11720422plp.16.2022.07.26.10.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:54:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 26 Jul 2022 07:54:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, surenb@google.com,
        mingo@redhat.com, peterz@infradead.org, corbet@lwn.net,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 8/9] sched/psi: add kernel cmdline parameter
 psi_inner_cgroup
Message-ID: <YuAqWprKd6NsWs7C@slm.duckdns.org>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-9-zhouchengming@bytedance.com>
 <Yt7KQc0nnOypB2b2@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt7KQc0nnOypB2b2@cmpxchg.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Jul 25, 2022 at 12:52:17PM -0400, Johannes Weiner wrote:
> On Thu, Jul 21, 2022 at 12:04:38PM +0800, Chengming Zhou wrote:
> > PSI accounts stalls for each cgroup separately and aggregates it
> > at each level of the hierarchy. This may case non-negligible overhead
> > for some workloads when under deep level of the hierarchy.
> > 
> > commit 3958e2d0c34e ("cgroup: make per-cgroup pressure stall tracking configurable")
> > make PSI to skip per-cgroup stall accounting, only account system-wide
> > to avoid this each level overhead.
> > 
> > For our use case, we also want leaf cgroup PSI accounted for userspace
> > adjustment on that cgroup, apart from only system-wide management.
> 
> I hear the overhead argument. But skipping accounting in intermediate
> levels is a bit odd and unprecedented in the cgroup interface. Once we
> do this, it's conceivable people would like to do the same thing for
> other stats and accounting, like for instance memory.stat.
> 
> Tejun, what are your thoughts on this?

Given that PSI requires on-the-spot recursive accumulation unlike other
stats, it can add quite a bit of overhead, so I'm sympathetic to the
argument because PSI can't be made cheaper by kernel being better (or at
least we don't know how to yet).

That said, "leaf-only" feels really hacky to me. My memory is hazy but
there's nothing preventing any cgroup from being skipped over when updating
PSI states, right? The state count propagation is recursive but it's each
task's state being propagated upwards not the child cgroup's, so we can skip
over any cgroup arbitrarily. ie. we can at least turn off PSI reporting on
any given cgroup without worrying about affecting others. Am I correct?

Assuming the above isn't wrong, if we can figure out how we can re-enable
it, which is more difficult as the counters need to be resynchronized with
the current state, that'd be ideal. Then, we can just allow each cgroup to
enable / disable PSI reporting dynamically as they see fit.

Thanks.

-- 
tejun
