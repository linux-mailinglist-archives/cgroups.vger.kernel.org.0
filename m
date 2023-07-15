Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D497D75459A
	for <lists+cgroups@lfdr.de>; Sat, 15 Jul 2023 02:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjGOAOe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jul 2023 20:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjGOAOd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jul 2023 20:14:33 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB8E3A95
        for <cgroups@vger.kernel.org>; Fri, 14 Jul 2023 17:14:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-314417861b9so2473978f8f.0
        for <cgroups@vger.kernel.org>; Fri, 14 Jul 2023 17:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689380070; x=1691972070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHB6MmDpW6mOW/AgkDp+ObJjFMKRQPqgz5eDHwER+yU=;
        b=W6GGyrjngXNyfkKbzBP757uoR9/rxEagoiMv4f1IGMSJeGCDSjINCa5zj4OukJxmlx
         v8tWhz33W130IhEua5jQxOvZvUXYTWOPem8PhPVPjpiqqQoGCgraF3LsNYGKV4SQ/+Xn
         SbbRovXFK1Nzj4i3EBYMzf5xIjum6gRDURoHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689380070; x=1691972070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHB6MmDpW6mOW/AgkDp+ObJjFMKRQPqgz5eDHwER+yU=;
        b=dZ0Yhp8gFWLyjrNuYcfhlMAbLzI1HkxStv2WrYcLVWf2VJtCmE5+u66bWfvrCWTDUH
         Ls9Bnz55r31dDpC3rZM/kk/8D28kKf8UxIAjUsNYSzSnqt9/d+Jz2p36ZkmYld8Nwtek
         VdK+y7bw9AK/rC4HFUI4M3N2Fvp7gH84OUoYK/jfRtLkGWsOmPZhi3HL2fJjH6t64gKI
         bZI6ucxqfUJpwk3kftbh4+Hv4Yk6zqfiq949ieemB5bTcrS5ALeHInMcYKEHH808FRsc
         ogDCIHALLpyzAYGjFmO5Z46qxSfbSY9YLLiEZfJW6H+XoIL6OpyVy8Be7/cw+5dt3uJJ
         YUuA==
X-Gm-Message-State: ABy/qLbGCet1kFa6eJvQXPt4sRPkFQoizeR924df+adimBEDo/JZuSph
        fE2StLOP5CdXbC410DMxUDWP2Jiu/VPeOoNslicRhg==
X-Google-Smtp-Source: APBJJlElw7WGo7L2Nkp8lIMM55qTMGczq+eOnpcSfNh0ZomFN+VdPKiCMfC1jCJnc1H+zHib3xVakiXNH9CD0E0N8Dw=
X-Received: by 2002:a5d:5485:0:b0:313:ee69:fb21 with SMTP id
 h5-20020a5d5485000000b00313ee69fb21mr5399250wrv.62.1689380070674; Fri, 14 Jul
 2023 17:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
 <20230706062045.xwmwns7cm4fxd7iu@google.com> <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
In-Reply-To: <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 14 Jul 2023 17:14:19 -0700
Message-ID: <CABWYdi2L_qp8SmZ_w3pSSracYHEVku3TaBoXL7E0Nzn7CN3neg@mail.gmail.com>
Subject: Re: Expensive memory.stat + cpu.stat reads
To:     Shakeel Butt <shakeelb@google.com>
Cc:     cgroups@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 10, 2023 at 4:21=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
> The fast one is v6.1.37 and the slow one is v6.1.25. I'm not sure if
> the kernel version makes a difference or if it's a matter of uptime /
> traffic profile. The data is from two different locations. The fast
> location has gone through an expansion, which meant a full reboot with
> a kernel upgrade, so maybe that affected things:
>
> * https://i.imgur.com/x8uyMaF.png
>
> Let me try to reboot the slow location and see if there's any lasting
> improvement.

There is no correlation with the kernel version, v6.1.38 is slow too:

completed: 23.09s [manual / cpu-stat + mem-stat]
completed:  0.30s [manual / mem-stat]
completed:  0.64s [manual / cpu-stat]
