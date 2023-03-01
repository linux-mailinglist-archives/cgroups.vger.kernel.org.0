Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCFC6A7291
	for <lists+cgroups@lfdr.de>; Wed,  1 Mar 2023 19:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCASFu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Mar 2023 13:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCASFu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Mar 2023 13:05:50 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A351E7D92
        for <cgroups@vger.kernel.org>; Wed,  1 Mar 2023 10:05:48 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-536cd8f6034so378902717b3.10
        for <cgroups@vger.kernel.org>; Wed, 01 Mar 2023 10:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677693948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uX8jmiHZcgYXj8u2P74s/De46LZgaxk18Jsejs4CDXw=;
        b=F4Tge1VkHhBLEu87APuX+c1FBFZuQ/236EIgqsa2CLAghV4MU4ktWNxdD4wbxYlLnG
         8Jz5OVtY0G4gUHBsHAUXgUuH3ztxqwsOiC8zJryAUnVUICBu/WSrngNVUHUKqqlFwKRo
         twWP+HY0so8JHoUhrK0FYhjLb3iJunbdtoZmQL+PZhLFN3CZWUPGY7tug8DPT0K0GRio
         2y69fGAW3CjaTSWmBcVf90tdB5iHUOvM8g6UdSZK38pahBHs1bkhZI4YgUC/DBfZFEuR
         6YZdJx6Ijq0D/SCoGQsB3SVT1Q2QZA67NO8fHXg9I5OE8119UaOTW6PvjnaS/XuMPdMa
         4kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677693948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uX8jmiHZcgYXj8u2P74s/De46LZgaxk18Jsejs4CDXw=;
        b=t58fM8n4VTP7EXjkW0O3Jccw8JoWED+WwVkOlor5tepVVmGZjXkb/B1pK5YzEvSrQU
         H9nv9cS1iK23ZXvr03J0DuEKw52AAXY0blaCP6zPTkbLE3+/CfVx5ymEDnIlCoRxGshA
         1SklB0xVgaZh+ruYe3bfPCgZn7qukGBIhqp3OYe+eZCOC8pdnOBQ08WD2aU8gUamzi2c
         2QsmN4t06/Z3Onf6bt4OrBXhN0FUHvOCrn4ELFLv/qpQpArQN9fpzgfBC5UrzuzIksb+
         X654vo7m4vsMwpCiBVdfe4pdBXs/bHjnqA/YOc4OAgkuaCPRnSNNUR1/q5+4i5m5Kpg+
         jEKQ==
X-Gm-Message-State: AO0yUKWowtNYbqY0NcZBg5//yvGXTTis4hSttvkPRdzIUhmgqBbzHNHJ
        /8ve+JgpCivaps5EIclBtGMis/lHatZPJ2Xtm8kb/g==
X-Google-Smtp-Source: AK7set/dkGy44D3lzDpt1OcAlZQDAmRQia2GQABeGUlYp/z+jLLEd0bIjWbxiVlVZhq3mS1FWuYcAJPaqDINSB9WsPo=
X-Received: by 2002:a81:ac51:0:b0:53c:6fda:b469 with SMTP id
 z17-20020a81ac51000000b0053c6fdab469mr1569992ywj.0.1677693947655; Wed, 01 Mar
 2023 10:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20230301014651.1370939-1-surenb@google.com> <Y/8fNrNm1B2h/MTb@dhcp22.suse.cz>
In-Reply-To: <Y/8fNrNm1B2h/MTb@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 1 Mar 2023 10:05:36 -0800
Message-ID: <CAJuCfpERczW1YhEW0fN3p2zrdDj-Ec_pCONH6SQVEwTj0BHYMw@mail.gmail.com>
Subject: Re: [PATCH 1/1] cgroup: limit cgroup psi file writes to processes
 with CAP_SYS_RESOURCE
To:     Michal Hocko <mhocko@suse.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        peterz@infradead.org, johunt@akamai.com, quic_sudaraja@quicinc.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 1, 2023 at 1:47=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Tue 28-02-23 17:46:51, Suren Baghdasaryan wrote:
> > Currently /proc/pressure/* files can be written only by processes with
> > CAP_SYS_RESOURCE capability to prevent any unauthorized user from
> > creating psi triggers. However no such limitation is required for
> > per-cgroup pressure files. Fix this inconsistency by requiring the same
> > capability for writing per-cgroup psi files.
> >
> > Fixes: 6db12ee0456d ("psi: allow unprivileged users with CAP_SYS_RESOUR=
CE to write psi files")
>
> Is this really a regression from this commit? 6db12ee0456d is changing
> permissions of those files to be world writeable with the
> CAP_SYS_RESOURCE requirement. Permissions of cgroup files is not changed
> and the default mode is 644 (with root as an owner) so only privileged
> processes are allowed without any delegation.

Agree, the Fixes line here is not valid. I will remove it.

>
> I think you should instead construct this slightly differently. The
> ultimate goal is to allow a reasonable delegation after all, no?

Yes.

>
> So keep your current patch and extend it by removing the min timeout
> constrain and justify the change by the necessity of the granularity
> tuning as reported by Sudarshan Rajagopala. If this causes any
> regression then a revert would also return the min timeout constrain
> back and we will have to think about a different approach.

I think adding CAP_SYS_RESOURCE check is needed even if we keep the
min timeout capped like today. Without it one could create multiple
cgroups and add a trigger into each one, therefore creating an
unlimited number of "psimon" kernel threads. At some point I expect
them to affect system performance because even at high polling
intervals they still consume some cpu resources. So, this change I
think is needed regardless of the change to min polling period and I
would suggest keeping them separate.

>
> The consistency with the global case is a valid point only partially
> because different cgroups might have different owners which is not
> usually the case for the global psi interface, right?

Correct.

>
> Makes sense?

Yes but hopefully my argument about keeping this and min period
patches separate is reasonable?
Thanks,
Suren.

> --
> Michal Hocko
> SUSE Labs
