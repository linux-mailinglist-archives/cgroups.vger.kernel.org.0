Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056FF6A85DF
	for <lists+cgroups@lfdr.de>; Thu,  2 Mar 2023 17:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjCBQJU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Mar 2023 11:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjCBQJS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Mar 2023 11:09:18 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B854D1A4B7
        for <cgroups@vger.kernel.org>; Thu,  2 Mar 2023 08:09:07 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-536c2a1cc07so436107907b3.5
        for <cgroups@vger.kernel.org>; Thu, 02 Mar 2023 08:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677773329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o4oQ31BBWd17/OrBmaIYzd49tP3Dix54xt4VYG6efag=;
        b=c68m6eik+53s5ghZ8Wk6fDeh16+MIGLL2unfAA/ShiTQX81DA+PrcE8XnLQGzZCvZQ
         vN2XPVLbn1wfC/8NCIubij0nUZJqxKcCmBxWTOn6qAUtuflqTF9mZvIdkS3e3c0vzbH4
         qsMNWAQtrEFDCDscPFpvLxjJdM4HlDeWrxdj8WSt1tlECtIHKD1+HqjwILLeSnLzHibu
         bAOXTvREbnpopYu1ry3LZ8SS4rFApGoN7zpEEmt/iN5oxzI/PXgiH5odoJEZJ656yeRH
         /8tViM5OehqWujUVRORIpO0V2vnIVAPeaDw2AhQ8WpgPomB5qvQZvmUB/kQ0Db9oEprd
         zqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677773329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4oQ31BBWd17/OrBmaIYzd49tP3Dix54xt4VYG6efag=;
        b=CwlnRBjk8SvC7s4CHSFsQhXr7pjw0PHP8YImqJMJmF9bsLZigZP+HECdJqSAo4sqFT
         bVmNRF5+mBZi/IEDE7uNB2WSSptzvTvkc55FZA3D/NjGUa8zns9qcEdmFIVXmMp2j5a+
         ySDoAQlow/blpGO75m5oU3TPMoPp3FnR+USQBRzHfsmp4NmQLUOPOljxWuKxvHvseXxM
         K3UzwNpkDGTM+MXvGeIqX1VWNUxE8MFrZV7LMIxmpcwGerehKpUBXHK6/ZshK7ajrKEX
         Ib6wicoki1ju9shVVRs5Ma2GIfyrg7q2UV43L0Ca4DaK54hIQK1w6TLn6pw4w+o38EtH
         ZoZA==
X-Gm-Message-State: AO0yUKW3FK3nMm8Cgb0hN49B8ZwvLXe/dddu81ep0ekfKueMQuVfvofh
        l36ogLDodbhW0WKeKoXpGzZMgN2UWlIIShPduu2row==
X-Google-Smtp-Source: AK7set8k2bnR4c69h4GFdeOlJ4iXt43r+FFbCpo8zSPi+823yfuAQIu8hrDp4KyWpc4vzcJgN/+M6QusrqrGoKPfgPI=
X-Received: by 2002:a81:ac16:0:b0:536:4194:e6eb with SMTP id
 k22-20020a81ac16000000b005364194e6ebmr6615295ywh.0.1677773329554; Thu, 02 Mar
 2023 08:08:49 -0800 (PST)
MIME-Version: 1.0
References: <20230301193403.1507484-1-surenb@google.com> <ZACrgV4f39P/2sZO@dhcp22.suse.cz>
In-Reply-To: <ZACrgV4f39P/2sZO@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 2 Mar 2023 08:08:38 -0800
Message-ID: <CAJuCfpH+yuynm+8LDbcOyh-q_PFTOz-FygxO9aSg8=RUR3LT+Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] psi: remove 500ms min window size limitation for triggers
To:     Michal Hocko <mhocko@suse.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        peterz@infradead.org, johunt@akamai.com, keescook@chromium.org,
        quic_sudaraja@quicinc.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Thu, Mar 2, 2023 at 5:58 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 01-03-23 11:34:03, Suren Baghdasaryan wrote:
> > Current 500ms min window size for psi triggers limits polling interval
> > to 50ms to prevent polling threads from using too much cpu bandwidth by
> > polling too frequently. However the number of cgroups with triggers is
> > unlimited, so this protection can be defeated by creating multiple
> > cgroups with psi triggers (triggers in each cgroup are served by a single
> > "psimon" kernel thread).
> > Instead of limiting min polling period, which also limits the latency of
> > psi events, it's better to limit psi trigger creation to authorized users
> > only, like we do for system-wide psi triggers (/proc/pressure/* files can
> > be written only by processes with CAP_SYS_RESOURCE capability). This also
> > makes access rules for cgroup psi files consistent with system-wide ones.
> > Add a CAP_SYS_RESOURCE capability check for cgroup psi file writers and
> > remove the psi window min size limitation.
> >
> > Suggested-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> > Link: https://lore.kernel.org/all/cover.1676067791.git.quic_sudaraja@quicinc.com/
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> with this to fix
> [...]
> > @@ -1278,8 +1277,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> >       if (state >= PSI_NONIDLE)
> >               return ERR_PTR(-EINVAL);
> >
> > -     if (window_us < WINDOW_MIN_US ||
> > -             window_us > WINDOW_MAX_US)
> > +     if (window_us <= 0 || window_us > WINDOW_MAX_US)
> >               return ERR_PTR(-EINVAL);
>
> window_us is u32 sp the check for <= 0 doesn't make any sense.

Completely missed that. Will change to == 0 and post the new version.
window_us is later multiplied by NSEC_PER_USEC and then divided by
UPDATES_PER_WINDOW(10), so even the smallest value of 1 still results
in a positive poll_min_period. I think we should be fine with that
check.
Thanks!

>
> >
> >       /* Check threshold */
> > --
> > 2.40.0.rc0.216.gc4246ad0f0-goog
>
> --
> Michal Hocko
> SUSE Labs
