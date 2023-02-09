Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A62690CFD
	for <lists+cgroups@lfdr.de>; Thu,  9 Feb 2023 16:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjBIPbX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Feb 2023 10:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjBIPbS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Feb 2023 10:31:18 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D4F611DE;
        Thu,  9 Feb 2023 07:31:17 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u27so2437937ljo.12;
        Thu, 09 Feb 2023 07:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEWeZKg/Hf192mvRWbg97mTukvlnybaYyRe3tKZfeeo=;
        b=DCoQZ6yFdzTNXWtXD1+O5ROyMvIuQO54tjjNhalWJMnw8ZuJAGBdQEiZu08ampMLix
         oOx9upeX6NxT2bMwAfNc+cMB/+oUPRCc0d+49Htlgcd2q+gmyIBh/ds28GhsRBIV6bg7
         p6UAC330wJM7XOAmGpYo5x4vMGYoR5eo52ipbEtkFJ8zrCJO+4g8+xG1cvxXvOYzX2VG
         eBP+unM4Zyso8zXjynu27I/D9lm7r/HAcW+frImd60C3OJFKlAUK55rb9XI6d/VYH/Dk
         o+Mp0uB2MB/5561XZUNQJvuWEUq9wlNHiGHK1SpOhEWw3ai17YUCPeaa4g/1UpyxpYhr
         oQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEWeZKg/Hf192mvRWbg97mTukvlnybaYyRe3tKZfeeo=;
        b=mf0epMmwCrjvmV8F4oMIbsgoHgANGeBQrFVhAMe/MHCdkyDWROui03j5bJhBbw1qRK
         4fWLY071CeGlVC526jH9OoUMd0OHu6OH3yFViwmteITPAQTg9x6cUM3NCkA6Ekk+9lr7
         ucJNT4wob3KxSlsWY3VzCh9FzfoH1daoqL+pcMmUoB78R/sRnZAPQ3q9AIUZBehGpG1N
         VgefsBcNF4hYRun0OD0o92rZzkvtzCFGzcTj5Pm/9uKj6jqIpYzFRFNL4k/ztVjbGfXM
         +xAuevlb8u7QFtHo8BS6dg9kMQGVkwT4bP0tCV+zjxeseWV1MxwWw3mV2MMEf7Y6Vcdd
         ylBA==
X-Gm-Message-State: AO0yUKUj1ebUrkysEGyV1PSoVdnem5AZkVnqKRK85ToDy2ekf5FtxScB
        ahOs5O/xoBkZp2LwwgWfjLUivCV4YBES3A1Bpuw=
X-Google-Smtp-Source: AK7set89qGf5s7nb61Sirj2AJdauT1KC8/wu+eoITk/YjLi73+fHaZ2EBtrTGyBrMytuS9lfD85WLhGLzvWpfCqAhxM=
X-Received: by 2002:a2e:b683:0:b0:28d:756a:5ade with SMTP id
 l3-20020a2eb683000000b0028d756a5ademr1750759ljo.85.1675956675670; Thu, 09 Feb
 2023 07:31:15 -0800 (PST)
MIME-Version: 1.0
References: <20230208161654.99556-1-ryncsn@gmail.com> <20230208161654.99556-3-ryncsn@gmail.com>
 <Y+P0wLTdZcOPiKPZ@cmpxchg.org> <Y+QcJ2OvTmJzrObn@blackbook>
In-Reply-To: <Y+QcJ2OvTmJzrObn@blackbook>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Thu, 9 Feb 2023 23:30:58 +0800
Message-ID: <CAMgjq7BQ4qAwQ3Obb=7Ytm5tOvWjA0kbfLrwkE=u0PpU2gM+GA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/psi: iterate through cgroups directly
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Koutn=C3=BD <mkoutny@suse.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=889=E6=
=97=A5=E5=91=A8=E5=9B=9B 06:03=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, Feb 08, 2023 at 02:15:12PM -0500, Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > Please name these psi_groups_first() and psi_groups_next().
>
> One more suggestion: s/next/parent/ to avoid impression of (sub)tree
> iteration and consistence with cg-related iters.
>
> Thanks,
> Michal
>

Thanks for the review, I'll update the patch with using this new name.
