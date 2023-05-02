Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652FA6F491D
	for <lists+cgroups@lfdr.de>; Tue,  2 May 2023 19:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjEBRZC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 May 2023 13:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjEBRYr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 May 2023 13:24:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1C4E61;
        Tue,  2 May 2023 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hrcCJlzTEWTjYDj+PsLFsdbovv7vXKPWKk6sNRy/lTs=; b=qHun9WZXPvt4wdHJ6P0pkB1o/5
        E/ri8TDaZGkBh0zusE18HSRSMDEwT0FEz+LpLM3rUN86dbm7KPkxy6/RUQ8Ur4lh2mA5I2yp9Y+rO
        VJiZz9HytEWqnZ79cpEpij8B4bbKSaN/Bn5y+u0/bd/1ub9wKIX7Dfh8KwfjVEwUbCyEKF9hfmndm
        Pd1iqy5s+flkn2iVMeoxFgK9yUU04jnWWkGf2RvPZxQj/y2lSvPl22O6ivV7EPRDECuU+NayXGWk5
        GTflEOThiCrz1ZEVg/psUxh0iZsOJ1VEgQHS8Ba0GD7LzEGquQggZsjJTdOrT+TLKeDxm8mRn0XqB
        B5dR7HxA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pttjS-008YZ8-Ta; Tue, 02 May 2023 17:24:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72CC9300165;
        Tue,  2 May 2023 19:24:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FBF72122BC96; Tue,  2 May 2023 19:24:04 +0200 (CEST)
Date:   Tue, 2 May 2023 19:24:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        johunt@akamai.com, mhocko@suse.com, keescook@chromium.org,
        quic_sudaraja@quicinc.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] psi: remove 500ms min window size limitation for
 triggers
Message-ID: <20230502172404.GI1597538@hirez.programming.kicks-ass.net>
References: <20230303011346.3342233-1-surenb@google.com>
 <CAJuCfpHcgu5Cti0t+U=S1C5-0ZgebhxzrOnhDiSu5qCyuq5_Wg@mail.gmail.com>
 <CAJuCfpE_aB6KQZj6A0NTCcv09bJ26L1hECDho3M2OyiNoMfFEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpE_aB6KQZj6A0NTCcv09bJ26L1hECDho3M2OyiNoMfFEA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 02, 2023 at 10:20:34AM -0700, Suren Baghdasaryan wrote:
> On Thu, Mar 2, 2023 at 5:16 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Mar 2, 2023 at 5:13 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > Current 500ms min window size for psi triggers limits polling interval
> > > to 50ms to prevent polling threads from using too much cpu bandwidth by
> > > polling too frequently. However the number of cgroups with triggers is
> > > unlimited, so this protection can be defeated by creating multiple
> > > cgroups with psi triggers (triggers in each cgroup are served by a single
> > > "psimon" kernel thread).
> > > Instead of limiting min polling period, which also limits the latency of
> > > psi events, it's better to limit psi trigger creation to authorized users
> > > only, like we do for system-wide psi triggers (/proc/pressure/* files can
> > > be written only by processes with CAP_SYS_RESOURCE capability). This also
> > > makes access rules for cgroup psi files consistent with system-wide ones.
> > > Add a CAP_SYS_RESOURCE capability check for cgroup psi file writers and
> > > remove the psi window min size limitation.
> > >
> > > Suggested-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> > > Link: https://lore.kernel.org/all/cover.1676067791.git.quic_sudaraja@quicinc.com/
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > Forgot to change the --to field from Tejun to PeterZ.
> > Peter, just to clarify, this change is targeted for inclusion in your tree.
> 
> I think this patch slipped through the cracks. Peter, could you please
> take it into your tree?

Sorry, yes, got lost. I'll go queue it for post -rc1. No urgency with
this right?
