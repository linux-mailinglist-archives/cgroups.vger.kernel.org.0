Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6F242C9F8
	for <lists+cgroups@lfdr.de>; Wed, 13 Oct 2021 21:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbhJMT0t (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Oct 2021 15:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhJMT0s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Oct 2021 15:26:48 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6986C061570
        for <cgroups@vger.kernel.org>; Wed, 13 Oct 2021 12:24:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so16579197lfu.5
        for <cgroups@vger.kernel.org>; Wed, 13 Oct 2021 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OcVw8ovBCZVOoCHV49LU9UJr7n1pv24bvXfSbF9CliM=;
        b=spTehBDgwgxtAT5s4zEyEzdavxm/I/DtmCIdVIVhZeouKvynu2a3SSRGv2kSQLqT1K
         I39IIC9a59bpOtvUMiPw5D8FnlNU8xvsp+JppFy07dv5mRlOnsqU87Al5n8LybTZHcDD
         vSFYTHwK5kNMRUcSvts5fuPzG2AUMWSuCMG52e8mGTwyYBDx1rAJi+kZhIu0AS20m4mW
         EHLfDzWt2InVuusPhroF1IGYYVVqy1VJrL4walMelIL/ih2NPNGT9u5/BNXIJFWDYwiH
         V6z0GrBuZYx+hHxo+7M84CzO9P9HEU79eMisNKW6ORHFm9Biu8v/RlbVgm+ODvHFINk+
         rN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OcVw8ovBCZVOoCHV49LU9UJr7n1pv24bvXfSbF9CliM=;
        b=aAvywU1Px4xmJZE314//KI2DYxGDCABxJrBQ4SG88CmwRJ78M34meRw4pa6pYZwlkM
         E1BbJhiLp/bUN91X8YHuDwuWqDmt/CdqWOJ3wrjpyUjh47JRHNZynEi+2rrgKb+HuOZ7
         iW8WP2LrlWkzVuXU6iDGQeRsdP4xgADpFxHOU4eSlvtlTXShMo7p7A9Srqi8NBSGJjjy
         ulGCk0m4jV19mgxXCiQJYqHvhSie1EuyUxEUAwghKakLA9rHiDtntpgy2TRYTwtG3k/N
         VFhDeDCNAUh5zPBZjTfkn+T+HndU/sMu5PO+i9UQGQBYylzmvN2uye5uep88qBGL0hEY
         NHtA==
X-Gm-Message-State: AOAM532b1WD1Zk9VHRFF5gwI+JqdynnFQj4gAzgttkxEA9r+ZgT/QBft
        K4J403pomx78KLzsSQCDIgDjmBs0rprsmBXvBS1PNA==
X-Google-Smtp-Source: ABdhPJxHS51cV0uhO42k3Hh0LtZ1R7GCobDDAlublLaFoZOcD9wkHJnk8ZUeFVAgfhmgNRh0GzhaEgTs2Qw7kDxahQk=
X-Received: by 2002:a05:6512:131b:: with SMTP id x27mr807634lfu.210.1634153082922;
 Wed, 13 Oct 2021 12:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211001190040.48086-1-shakeelb@google.com> <20211001190040.48086-2-shakeelb@google.com>
 <20211013180122.GA1007@blackbody.suse.cz>
In-Reply-To: <20211013180122.GA1007@blackbody.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 13 Oct 2021 12:24:31 -0700
Message-ID: <CALvZod6dN5Ub-r9+evXYCaeNuzrDs1byPLY1DAyn=R7rqHoqKg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] memcg: unify memcg stat flushing
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 13, 2021 at 11:01 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrot=
e:
>
> Hello Shakeel.
>
> (Sorry for taking so long getting down to this.)
>
> On Fri, Oct 01, 2021 at 12:00:40PM -0700, Shakeel Butt <shakeelb@google.c=
om> wrote:
> > There is no need for that.  We just need one flusher and everyone else
> > can benefit.
>
> I imagine a cgroup with an intricate deep hiearchy with many updates and
> a separate (simpler) sibling/independent cgroup that would need to pay
> the costs of the first hierarchy updates [1] when it asks just for its
> own stats (bound by the amount that's leftover from the periodic
> updates).
>
> The stats files (or wb stats) are likely not that time sensitive and the
> reclaim (that can be local only but is slow path anyway) already uses
> the global flushing.
>
> I wonder whether the bigger benefit would be to retain the global
> stats_flush_threshold counter but flush only local subtree.

I did contemplate on this (i.e. a stat read paying the flushing price
for everyone else) but decided to keep as is based on:

1) The periodic async flush will keep the update tree small and will
keep infrequent readers cheap.
2) Keep things simple for now and come back if someone complains for
very frequent stats readers.

Shakeel
