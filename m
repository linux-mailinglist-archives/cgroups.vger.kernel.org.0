Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2793B311914
	for <lists+cgroups@lfdr.de>; Sat,  6 Feb 2021 03:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhBFCya (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 21:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhBFCk4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 21:40:56 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B680C061D7D
        for <cgroups@vger.kernel.org>; Fri,  5 Feb 2021 14:11:26 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id c18so9553720ljd.9
        for <cgroups@vger.kernel.org>; Fri, 05 Feb 2021 14:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/4qEkNOrLEa6lxN/95STT61avrFjfvYnDY/MmP9s+0o=;
        b=SFMRg/15SplEen1Sye0qlnbdi+BfK5VijvW5vUJ3y4Bmd4WNJhz6tl0srP2+1DuSsw
         C3lWkUPurWOVp2t0RFiov09RInfN7R/g5i+K4WwL4uTDcMOdhpN9CeSp801NpEtNOBEC
         SUdZb4605uhwR5bxZZ2IVZ3+ObmydPjYJuSCzxaXilJ1YgjkzpbLxmNch2OjtoJfI10g
         USfaUm4N8916uETHmf91lTR6yn2JpFCCrQuufBqk+FfCam5Z/XPbN5uKx99d7R/QHtcn
         sP15nQFOITOtaQ/eAIvwbrPPeGrV1BcVQa5PrUgUWKGhSDaW5yOE5xD6ccRkRVR1ZMNi
         ue2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4qEkNOrLEa6lxN/95STT61avrFjfvYnDY/MmP9s+0o=;
        b=TwLYFDc7jI3IG9EE9+KtHepF2L7Lcmhe3YFIFqN1L4VeoZX1GCTODBToNKkpDo3Tv/
         tjUJYfgDXTWuUQkYukz/B2b4eZviQexNZjX2mAZT+HNl7qT616Bm1dnkogNs6pEnSAY3
         i9ZtJGK1HDzulrt2VG3vy0/m6+X6gJ9S6IVM2tHTAt2vUGk4s+QCG8f55va41ramSOZc
         4HO45HmBvh3Kt5DHxKLR4YXa7msPRzv6FKMTlX0iPFToTne4pAK0gmoCQGRR/o0FATiI
         2VqaebM6pD1RlslWimW0pIA3yc3UIdjpQL8/5u4AZiHDIbWiE6PVE7UG4l3zbdd3poUh
         TtUw==
X-Gm-Message-State: AOAM532EBJL6P+gRsZd2uQAcsAL4rH+JzE67G6fU9DRgbAmYuUqYi+2E
        rkIv0THwgzskrSXmxlt0VdvLeQdaX2SOMb8MAH8nJA==
X-Google-Smtp-Source: ABdhPJwFONDOLDANaesx5u6Fdzy4/2gaSfHlVUX6IQVv6mnSIErvIy9Bpy5BdfJbA4zstHKJUlrtR5M0E1dH2R0PW0I=
X-Received: by 2002:a2e:9ed1:: with SMTP id h17mr3702229ljk.160.1612563084463;
 Fri, 05 Feb 2021 14:11:24 -0800 (PST)
MIME-Version: 1.0
References: <20210205182806.17220-1-hannes@cmpxchg.org> <20210205182806.17220-5-hannes@cmpxchg.org>
In-Reply-To: <20210205182806.17220-5-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 5 Feb 2021 14:11:13 -0800
Message-ID: <CALvZod6R7Qbx2JgTHM-uLeRHZLhaMZiCkbevQBTN=jVizrt-Lw@mail.gmail.com>
Subject: Re: [PATCH 4/8] cgroup: rstat: support cgroup1
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 5, 2021 at 10:28 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Rstat currently only supports the default hierarchy in cgroup2. In
> order to replace memcg's private stats infrastructure - used in both
> cgroup1 and cgroup2 - with rstat, the latter needs to support cgroup1.
>
> The initialization and destruction callbacks for regular cgroups are
> already in place. Remove the cgroup_on_dfl() guards to handle cgroup1.
>
> The initialization of the root cgroup is currently hardcoded to only
> handle cgrp_dfl_root.cgrp. Move those callbacks to cgroup_setup_root()
> and cgroup_destroy_root() to handle the default root as well as the
> various cgroup1 roots we may set up during mounting.
>
> The linking of css to cgroups happens in code shared between cgroup1
> and cgroup2 as well. Simply remove the cgroup_on_dfl() guard.
>
> Linkage of the root css to the root cgroup is a bit trickier: per
> default, the root css of a subsystem controller belongs to the default
> hierarchy (i.e. the cgroup2 root). When a controller is mounted in its
> cgroup1 version, the root css is stolen and moved to the cgroup1 root;
> on unmount, the css moves back to the default hierarchy. Annotate
> rebind_subsystems() to move the root css linkage along between roots.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
