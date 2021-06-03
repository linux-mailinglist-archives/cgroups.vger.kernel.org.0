Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882B739A29A
	for <lists+cgroups@lfdr.de>; Thu,  3 Jun 2021 15:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhFCN6x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Jun 2021 09:58:53 -0400
Received: from mail-qv1-f53.google.com ([209.85.219.53]:35750 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhFCN6x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Jun 2021 09:58:53 -0400
Received: by mail-qv1-f53.google.com with SMTP id q6so3207020qvb.2
        for <cgroups@vger.kernel.org>; Thu, 03 Jun 2021 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fFoCEkJHlYaCqbo7kftj3nQYJl4JAya0mNURfk0G9Fo=;
        b=iOGRGKMMJ7mjrGAdEcby7lsIBWbsY9FmTD/4P6CUXobrP5vRdX5NYZlmK1uLe9dvLm
         z1YBOrXjyC64sc+6mGqhkgxtKmepkCsmdBv5T1o8rkEUgNLLB3G1th843k76n+w7wHd+
         wBxBLE9mapL58Sm8CD8BxlTz4dg7g3OzYg5zu1jJpMfAT1rIWGWNmJ6u55SGUEFkKclh
         HSKpx6Dyn20lsWeyWlv8dS05FWBs9MzSCS2jCUsGC3/IyBZrQVetFMVgDLEFwVPdDCmt
         VEFQd4XCnOAdznbWTJ7tKlTjnPFWvqvNoJk32txKZ4ZL09ETySALU4AfVW13V++mNOlH
         oRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fFoCEkJHlYaCqbo7kftj3nQYJl4JAya0mNURfk0G9Fo=;
        b=IBLbMGGDHbMAXmbBmFi8uB0QZ4/xjhl5xEvXT8Ot4SQ3+h8m5G5Z03dSd3HU/fhMmD
         iO3ZCxbBTRXaZgJMGaFYoYf3+nqDkIjJhHg87Rdyh8cifUwD1X5KQ6GUviFZCZehvPOu
         OYVpNJ9Zr/HGY97MLcWDkgwIN/09X0dU0zdc8flcqzUiOLPayiw7OffSinvw2TPA54BO
         Z/pqf+TWuydiHdn8alJNXlQoB7kwbbdcBdZhE1Hrl6Kyl3WpI6vpraRdJC0lnb5u8rWX
         L38B+5E6V2UQLcaE6JxOm2fGUY7TvbIdbabQFYgaMED1dSoJ+7DKMbUy72M6JbFAuut5
         qzag==
X-Gm-Message-State: AOAM531H2obrbEgYF1KQ2pXWU/aL/751YtvMzE78pSkY8snUQ7SjFwkq
        0MuWo8BzGG55os6CHtWqbSeCD0vOczwFuRk8A7hUxw==
X-Google-Smtp-Source: ABdhPJzgYoxPqkgvsYk9l6uq26oBNtV19sZUxDEha83osjjivigH/jyWaB4Pso/7pgj/Enw04BwYsAaKsWyd7xEPUvE=
X-Received: by 2002:a0c:fa4a:: with SMTP id k10mr12353155qvo.18.1622728568553;
 Thu, 03 Jun 2021 06:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210603113847.163512-1-odin@uged.al> <CAKfTPtAK3gEqChUmoUXo7KLqPAFo=shH4Yi=QLjrwpuu6Ow6-Q@mail.gmail.com>
 <CAFpoUr2HBexs5784nU7hyDSs0eNiEut=-4wWcnpMtSVtFeaLLA@mail.gmail.com> <CAKfTPtDLiN2GXxPG9AhxAihx++jV+W6VeBRdYgVwNmb8RiTkhQ@mail.gmail.com>
In-Reply-To: <CAKfTPtDLiN2GXxPG9AhxAihx++jV+W6VeBRdYgVwNmb8RiTkhQ@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Thu, 3 Jun 2021 15:55:29 +0200
Message-ID: <CAFpoUr3=v9L-0QqKJeR=P_PvPnSAxrKObwj3ZS+ypMyMd17jsA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Correctly insert cfs_rq's to list on unthrottle
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> If it's only a matter of waiting other PELT patches to be merged, we
> should use cfs_rq_is_decayed().

ACK. will post a v3.

> if load_avg!=0, we will update it periodically and sync
> tg_load_avg_contrib with the former. So it's not a problem.
>
> The other way was a problem because we stop updating load_avg and
> tg_load_avg_contrib when load_avg/load_sum is null so the
> tg_load_avg_contrib is stalled with a possibly very old value

Yeah, that makes sense.

Thanks
Odin
