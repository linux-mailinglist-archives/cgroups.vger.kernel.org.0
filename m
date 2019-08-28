Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69060A0918
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2019 19:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfH1R6N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Aug 2019 13:58:13 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37779 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfH1R6N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Aug 2019 13:58:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id b25so410314oib.4
        for <cgroups@vger.kernel.org>; Wed, 28 Aug 2019 10:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tK5THlH7NqfDItCUjzopiqfECSLNe3u1Nqtw0AYmMVQ=;
        b=IBueXC/olKJzB5vkgN7R06mcGGzgzCsySyIoqFzMQQeswkJAHKqFm+qVQ5Q/mM2Viu
         zMz1KIwbGEYS6VOP2ibBFyCNrAXohuSwim7uGYeBOM127IrM3XRf1yt9rJ+GHWQq+xby
         Qc9uu+kA2eAXXs7BwohGVmINAWOvSq+nfdDJ7Y8/cZH7Zjv7WKps8+dAr7a87Jg8U7go
         y6wsL5nd8ng2CHv6pSTiVZcRNiB8QywcWIY3rsDRn9ebc9S69ai7ItW57QzlHO290kDA
         /eZVRciXkxX0EBDYL1nGG9xnDi802eQ8QjILYMSICbvd2i1N6UMg++8x6WAxh9mniN+W
         DZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tK5THlH7NqfDItCUjzopiqfECSLNe3u1Nqtw0AYmMVQ=;
        b=ZWzmxHgRiI4TQj3XbMk2ZhYxFoUTKz4ftpKAjjCOjIsrFctxvAYONncOdJZy1K1p/Y
         g8ieRpDRuHdZxLdBnoJbgzlxqYdkcAjgFMITBKl7LB6P5TffixMhXcdtm6yeRfqTt4Lw
         MPBV2eRBgD6dgT3y7q41Kp3A5n84FFohRkwuHugOdjbfJdqT15IqLaBsCq6JacLOUlvL
         /QXoMsksPuaPNU7dxgGa2XHHlKncRSMh6h/0rdWmHfIgKyRtkEuOJ64JPTHMaVAp5A+Y
         qUYiMky1J2/b999m58YBVD1zKsJPp5QIcWlqWNiSZnGI41g2L8e06tmTMp3COXU8Os1d
         x0sQ==
X-Gm-Message-State: APjAAAUcUOGdui2LM6oZVEr0cAuyX3Zt07OPtRjZX596Sur2Jlk+v7yy
        xH6MvpqbqVBspZGsLQSP6kpPN5i4XTezORwl5YwlDA==
X-Google-Smtp-Source: APXvYqz0MlmHPcbvq/+RV6BUWyxran0z3juZutp6BvdDm8/FPvPCOgrtXXF42MKgXKq3VxKiHhatdFzdm45AKBpnZPA=
X-Received: by 2002:a05:6808:b3a:: with SMTP id t26mr3719696oij.67.1567015091735;
 Wed, 28 Aug 2019 10:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190826233240.11524-1-almasrymina@google.com> <20190828112340.GB7466@dhcp22.suse.cz>
In-Reply-To: <20190828112340.GB7466@dhcp22.suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 28 Aug 2019 10:58:00 -0700
Message-ID: <CAHS8izPPhPoqh-J9LJ40NJUCbgTFS60oZNuDSHmgtMQiYw72RA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] hugetlb_cgroup: Add hugetlb_cgroup reservation limits
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 28, 2019 at 4:23 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 26-08-19 16:32:34, Mina Almasry wrote:
> >  mm/hugetlb.c                                  | 493 ++++++++++++------
> >  mm/hugetlb_cgroup.c                           | 187 +++++--
>
> This is a lot of changes to an already subtle code which hugetlb
> reservations undoubly are.

For what it's worth, I think this patch series is a net decrease in
the complexity of the reservation code, especially the region_*
functions, which is where a lot of the complexity lies. I removed the
race between region_del and region_{add|chg}, refactored the main
logic into smaller code, moved common code to helpers and deleted the
duplicates, and finally added lots of comments to the hard to
understand pieces. I hope that when folks review the changes they will
see that! :)

> Moreover cgroupv1 is feature frozen and I am
> not aware of any plans to port the controller to v2.

Also for what it's worth, if porting the controller to v2 is a
requisite to take this, I'm happy to do that. As far as I understand
there is no reason hugetlb_cgroups shouldn't be in cgroups v2, and we
see value in them.

> That all doesn't
> sound in favor of this change. Mike is the maintainer of the hugetlb
> code so I will defer to him to make a decision but I wouldn't recommend
> that.
> --
> Michal Hocko
> SUSE Labs
