Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4E04C7DAF
	for <lists+cgroups@lfdr.de>; Mon, 28 Feb 2022 23:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiB1Wrg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Feb 2022 17:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiB1Wrf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Feb 2022 17:47:35 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AD51405E5
        for <cgroups@vger.kernel.org>; Mon, 28 Feb 2022 14:46:55 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id i1so11958120plr.2
        for <cgroups@vger.kernel.org>; Mon, 28 Feb 2022 14:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LglAJFBfW0192A+zdtC6aPQEwQomXk3iQX8CrMvwboE=;
        b=Q1mmID59L3r+ZQjhjmMSnqIrxTddfLL+dg5Yncv+WGGQrW3mSeBNuaKUkiOgbD16ON
         Y0LTiD+wKPqFjsANDBpDGbLewVglEMBb+vPQ7iNIWROAxQKLDwNXCF+WYl02BWzhGLrM
         RHRxrBI1VRXCO9gQotZhnjXQoYxNZA/2S1cnEpTKfFZzBzDcEjjcpQ4O2PnBazcDncIs
         +nVGzkVgPfD0o3Bbl0Qfx8P6RFMUgV/vo7Bq5I8obRVLwbq2yKktjX+2sOG0qerdAjJ8
         I9L84JOIAHkzoTTOeBLgd7XNiy6mErmdRwXno8BokmhWTsT2XfcKd6xPZPwgfGwfXHJW
         UKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LglAJFBfW0192A+zdtC6aPQEwQomXk3iQX8CrMvwboE=;
        b=MqVwiJNEDk1Bg9jR0MsXkdG8HYF3q3NyLvKihX6ICVSqMYcfAjCseyFKNubJe0VIOS
         OThgiokHFwhxEqwwt2PVi+2R9RqpXCtnUfpyVm1GNw5uszxc5Dfmd/273xY0/Ic0eLPK
         NIMhw3xKog8u1YoNXxLHDC5NRyBavbGjTP7BhYKW8xjB+UgqBYoEOfUbgcuTgoE1b5w8
         A3+ZS6nMgTlm/Adg7MvreUBi2/cwtHJt8KZwB3fEwGklo+h8fcTuylv/hrMQqzAoq/jm
         UggNprzt1/cGmeeYM5TXs8seyVrn9bGPR1uoCK4wK5T/pjrMISqWT/ADKf0tBH0M+3Je
         JLkQ==
X-Gm-Message-State: AOAM531dw3YSqoPU7F62067ihPLevHG64l2gzXDF5M8pjMBK2CvPTpeq
        oQS4g4plZ6RlnRmaKJ15V7DpetKgg4+ULadMccPjzQ==
X-Google-Smtp-Source: ABdhPJzsghlkq6BU0I6LPAO56Tv+4suMMu6V1k1d4Uy6Z43D+GNTocRNhUW9x/uRixnOWsMjqGp30B9Php1ZVuXO+Kg=
X-Received: by 2002:a17:90a:db15:b0:1bd:71f:8123 with SMTP id
 g21-20020a17090adb1500b001bd071f8123mr15955979pjv.126.1646088415342; Mon, 28
 Feb 2022 14:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20220226002412.113819-1-shakeelb@google.com> <20220225165842.561d3a475310aeab86a2d653@linux-foundation.org>
 <CALvZod7SA17vounKnq1KX23172rztNN_Oo0K1XaeEuS4JVEhMw@mail.gmail.com> <20220228184653.GA1812@blackbody.suse.cz>
In-Reply-To: <20220228184653.GA1812@blackbody.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 28 Feb 2022 14:46:44 -0800
Message-ID: <CALvZod61XyMJzrvU0Wvp8iWV878rZQYsa407RhoZYeiJV5j5SQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: async flush memcg stats from perf sensitive codepaths
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Dao <dqminh@cloudflare.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 28, 2022 at 10:46 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrot=
e:
>
> On Fri, Feb 25, 2022 at 05:42:57PM -0800, Shakeel Butt <shakeelb@google.c=
om> wrote:
> > Yes, the right fix would be to optimize the flushing code (but that
> > would require more work/time). However I still think letting
> > performance critical code paths to skip the sync flush would be good
> > in general. So, if the current patch is not to your liking we can
> > remove mem_cgroup_flush_stats() from workingset_refault().
>
> What about flushing just the subtree of the memcg where the refault
> happens?
> It doesn't reduce the overall work and there's still full-tree
> cgroup_rstat_lock but it should make the chunks of work smaller
> durations more regular.
>

We can try that and I will send a patch to Ivan and Daniel to try on
their workload to see the real impact of targeted memcg flushing.
However I am not very optimistic about it.
