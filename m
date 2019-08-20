Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7DED966BD
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2019 18:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfHTQsx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Aug 2019 12:48:53 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33016 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTQsw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Aug 2019 12:48:52 -0400
Received: by mail-yb1-f196.google.com with SMTP id b16so2305837ybq.0
        for <cgroups@vger.kernel.org>; Tue, 20 Aug 2019 09:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfS/3YweTIcGGO2RRMlCPJRIxqMja+WwkZZpwCr9I0U=;
        b=K+mam5zvf/E3cU2LIDxXZWug/rqk3N2IZZ43MXOq44SNotDZn+byvLHrUFInHkDO7K
         krZMi68j2Wv9KleBJmISlXyAtf+AWs9TyWORM/Is9r/JWDOIisvRoaxJKLMa9X2+DkSD
         X8/9HsIrCN6cY1UKIUVTesBhBp4i3524bVcclEQ++s0bi/yh5/iX8yzTgk/KVOUmV0on
         7IlLZhBsYqtAIBE6vQRbijMnbR9VYedqBUFYnNM8Rbdx/bhjrOR+OtiJMEX84yYFHCtT
         KdyACLP9WpPoCaDmJFCRZjVP1xzZkn+G18umMyHY3eO4qR19pRTmM/TC8TB1C0CiILyZ
         TXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfS/3YweTIcGGO2RRMlCPJRIxqMja+WwkZZpwCr9I0U=;
        b=Tb1HKbbw1wcNrVSlSPqrOD0b/1LuQpaP+lg3hN+mSGNRPoyPEuEBiD/pPBZ2kPBhi0
         Lyg3bgXla4FlkXjIE7N+WYvPEK/CsVlpWCBc/IOZaUZOG/gKFInSuEi9nk766W1DH1zg
         mD21UNhoz6Trr/fINlP1o2I7UudB8srElJpQPc1CROId4bijXb5RTLgvl0b/5iZY6WGT
         /pxFPFPf2Ay5pgC8bHuI4hN5TCEI1UMjcvrnLOrA2fWrFIa+P1H3L8Uqe/6V6ih5h1Zo
         apCmtuQt8IZ8X7B2YaCoAWWsCuLMLR43zrjefoHqhWCH02sm7Gmc3vygcq5JfumfM+Zb
         5fzA==
X-Gm-Message-State: APjAAAUuigxPQi3H5KAZTvaPApnM1XOgPs7ZLTq839yjlXrr4mWEV/cY
        SjyXd33bOKNc3BEOAbC4En+g09UqI/zvSWRESozsMA==
X-Google-Smtp-Source: APXvYqxnanSSbRg2czlqAz97bkbZhcKO5rytay9XH6axiOD/F2S2TPwc7saIWI++F16Xc8DLHrIgnPN0HuxOeH9Q56U=
X-Received: by 2002:a25:f503:: with SMTP id a3mr21166644ybe.358.1566319731656;
 Tue, 20 Aug 2019 09:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com> <20190820104532.GP3111@dhcp22.suse.cz>
In-Reply-To: <20190820104532.GP3111@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 20 Aug 2019 09:48:40 -0700
Message-ID: <CALvZod7-dL90jwd2pywpaD8NfUByVU9Y809+RfvJABGdRASYUg@mail.gmail.com>
Subject: Re: [PATCH 00/14] per memcg lru_lock
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 20, 2019 at 3:45 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 20-08-19 17:48:23, Alex Shi wrote:
> > This patchset move lru_lock into lruvec, give a lru_lock for each of
> > lruvec, thus bring a lru_lock for each of memcg.
> >
> > Per memcg lru_lock would ease the lru_lock contention a lot in
> > this patch series.
> >
> > In some data center, containers are used widely to deploy different kind
> > of services, then multiple memcgs share per node pgdat->lru_lock which
> > cause heavy lock contentions when doing lru operation.
>
> Having some real world workloads numbers would be more than useful
> for a non trivial change like this. I believe googlers have tried
> something like this in the past but then didn't have really a good
> example of workloads that benefit. I might misremember though. Cc Hugh.
>

We, at Google, have been using per-memcg lru locks for more than 7
years. Per-memcg lru locks are really beneficial for providing
performance isolation if there are multiple distinct jobs/memcgs
running on large machines. We are planning to upstream our internal
implementation. I will let Hugh comment on that.

thanks,
Shakeel
