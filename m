Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB97946FD95
	for <lists+cgroups@lfdr.de>; Fri, 10 Dec 2021 10:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbhLJJYJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Dec 2021 04:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbhLJJYI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Dec 2021 04:24:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F7AC0617A2
        for <cgroups@vger.kernel.org>; Fri, 10 Dec 2021 01:20:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id t5so27514417edd.0
        for <cgroups@vger.kernel.org>; Fri, 10 Dec 2021 01:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SX+FfU5mZDxCoswRXg/krQoh/mf5XisDnoDBVGtWZvI=;
        b=fa2LOUoLxWv4XALz/wTI0VNk09ZivC+oOpTGEYFmFJQf65kvfkThGd8C0Tunk1nPCF
         zr+ehwd5gQ7hkPz7TvP32O9oNaZ+SWaichsnJbwlAjkrIZl3xbVi3hO/LIvr6BNuOQhx
         nA1e31nbAymHHtphxOYLlTzudumNyCS0SOyeG/x56jcrfxisLXkUiOJrnyh64fJ9L4lL
         5jzumWamcoK8rPC3Eerm1S0JuIyBmd9UbjhYBRBsEL5cEXN/AgzKnGbS3bvmF9qL46ZU
         Pb10cYUUzk+dKF+1vVfK3LRkPVbSs1/0A18UCloFMsfc3P4bczuLKEK32WPiNZq31EYw
         I3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SX+FfU5mZDxCoswRXg/krQoh/mf5XisDnoDBVGtWZvI=;
        b=7RffLQPQmIvB1dMh/XOBq44grq+1V/FlFRpWFItQTmpbp/llbYE51aS8eDPDnIpNMU
         3Skonv1+wPYrtFVaSz6TIhefQEHw1/iIAfU5No8byU8A93V3z32cgIGQk48sutqUztwr
         gXR+NQIOBDPfb0wriDfLU9hcVIylvNlHFvIerpZ5r4mC07PwJw9+e5VZww9iIMhWecbs
         WgBKP1ur714lT5rQhHafeCYhGDgjOjQbjqiilzzvDHgPSEZfIuiKORez76IBfooCdQGo
         d8QgtngANoHrPKDqmCANf3PTx9fMGB8iVPvun1wXtVXjYBhkWducw1IKYLvzyNWtLJfV
         HqDw==
X-Gm-Message-State: AOAM5314/FvfiywJmjFBEwThnlatz5mbgNtHfBKECxshx/nv7uCHX218
        4sv8xPHk7SDq5JzCJNu+kJCm8w==
X-Google-Smtp-Source: ABdhPJyjRZ85fHSpYIyUt66EHBM4ZpNNk7nXOnCt7DkA0r0LV+HPLXhCEHNQ8Ga6GAUR1sgAm7qHPQ==
X-Received: by 2002:aa7:cdd9:: with SMTP id h25mr36869911edw.130.1639128032409;
        Fri, 10 Dec 2021 01:20:32 -0800 (PST)
Received: from [192.168.1.8] (net-93-70-85-65.cust.vodafonedsl.it. [93.70.85.65])
        by smtp.gmail.com with ESMTPSA id h10sm1107199edr.95.2021.12.10.01.20.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 01:20:31 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFC 0/9] support concurrent sync io for bfq on a specail
 occasion
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20211127101132.486806-1-yukuai3@huawei.com>
Date:   Fri, 10 Dec 2021 10:20:29 +0100
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D3FF0820-6A51-46A1-A363-8FFA8CCD2851@linaro.org>
References: <20211127101132.486806-1-yukuai3@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> Il giorno 27 nov 2021, alle ore 11:11, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> Bfq can't handle sync io concurrently as long as the io are not issued
> from root group currently.
>=20
> Previous patch set:
> =
https://lore.kernel.org/lkml/20211014014556.3597008-2-yukuai3@huawei.com/t=
/
>=20
> During implemting the method mentioned by the above patch set, I found
> more problems that will block implemting concurrent sync io. The
> modifications of this patch set are as follows:
>=20
> 1) count root group into 'num_groups_with_pending_reqs';
> 2) don't idle if 'num_groups_with_pending_reqs' is 1;
> 3) If the group doesn't have pending requests while it's child groups
> have pending requests, don't count the group.

Why don't yo count the parent group? It seems to me that we should count =
it.

> 4) Once the group doesn't have pending requests, decrease
> 'num_groups_with_pending_reqs' immediately. Don't delay to when all
> it's child groups don't have pending requests.
>=20

I guess this action is related to 3).

Thanks,
Paolo

> Noted that I just tested basic functionality of this patchset, and I
> think it's better to see if anyone have suggestions or better
> solutions.
>=20
> Yu Kuai (9):
>  block, bfq: add new apis to iterate bfq entities
>  block, bfq: apply news apis where root group is not expected
>  block, bfq: handle the case when for_each_entity() access root group
>  block, bfq: count root group into 'num_groups_with_pending_reqs'
>  block, bfq: do not idle if only one cgroup is activated
>  block, bfq: only count group that the bfq_queue belongs to
>  block, bfq: record how many queues have pending requests in bfq_group
>  block, bfq: move forward __bfq_weights_tree_remove()
>  block, bfq: decrease 'num_groups_with_pending_reqs' earlier
>=20
> block/bfq-cgroup.c  |  3 +-
> block/bfq-iosched.c | 92 +++++++++++++++++++++++----------------------
> block/bfq-iosched.h | 41 +++++++++++++-------
> block/bfq-wf2q.c    | 44 +++++++++++++++-------
> 4 files changed, 106 insertions(+), 74 deletions(-)
>=20
> --=20
> 2.31.1
>=20

