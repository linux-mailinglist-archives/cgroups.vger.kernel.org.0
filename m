Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FCA41B9FA
	for <lists+cgroups@lfdr.de>; Wed, 29 Sep 2021 00:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242958AbhI1WQL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Sep 2021 18:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242622AbhI1WQK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Sep 2021 18:16:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D424BC06161C
        for <cgroups@vger.kernel.org>; Tue, 28 Sep 2021 15:14:30 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dn26so696027edb.13
        for <cgroups@vger.kernel.org>; Tue, 28 Sep 2021 15:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x9zDwJRWIm139eLhv6Qo7TZGdOTE27JLM+druYyg5ZI=;
        b=qYa6jC0CPO7v3mfxhwIs9R3Pwvt+6UQsr/69yWr3RX8Q0Qy1yfDrgSUOJ6L0aCi5AH
         AWgvQKSfEkR9/nBtB3gJhn82TWy84/sbaRg2a0UIo9UHrpZf4jGRaGcZXf/fr4BKwigU
         XCciR7+dbBgdzzNvOxm2Oi4LXlbcYAgvEYSqyHxXSbUe184l4EFPk01aWIAWUFknnFJW
         cFgir3Hbv8hMcOLsfcDKgpuqNjyvvpCb63jHiZ7vw4MlX1av11n+wLVuVe+ZT1pOZ4g3
         /OJIQWe5OyFjz2vauklQqXnSN1DM9OZuVtTrO+1vWWam1kkYvWtY9ovmbPB13155558R
         7qBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x9zDwJRWIm139eLhv6Qo7TZGdOTE27JLM+druYyg5ZI=;
        b=ApL3STcjcFGPEFNgc2ggEOyVWGOiB9m0EJYI7oleowR2lVe6+FAMxCUZ9X+oqj+S7U
         sk9KMQ4TkXuCK3/iZICtmDUdqsljSyYGo0WraAp1GbPBTN+RmVA8LjZhqdPxYpIUpgZE
         6fcU8P9jbkB6X/jztPdmUk3TGi8lSg+ex9Ejla5Np4HqLSImgf0uS5oUE8NzFXDtwzaF
         wB4qNXLfS/+N/WxT8O+bdibOkuL9Rd1SgvNsX5MkmFzAFGw2Q9SLlcm2my06nmndPEGJ
         uPeorGfwBsAKrWEQMVlVkEKFjHDb3drqWuMKWY1p7ZYRrerX34y5gvgLODg4TiYt/gZy
         NJvQ==
X-Gm-Message-State: AOAM530g7D7P6LYTHPQEOot0zwZHjKf4xSuiSD04Tpd+WYd1MKRCp+HQ
        Rdfb/62boJlt3WSYdV394GBypqdy+sLWNj0SFnUI6T1W
X-Google-Smtp-Source: ABdhPJxeEO9O5JCyltmbwDuJH0dZza+zpUnIZ/I0Jy1+CdC9cqDxCKq0g+oPsfHKrMj138CvyRCNMq5qlx1HIMBxqGQ=
X-Received: by 2002:a50:e044:: with SMTP id g4mr10497027edl.46.1632867269412;
 Tue, 28 Sep 2021 15:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHKqYaa7H=M4E-=ObO0ecj+NE2KwZN5d7QSz4_b6tXz2vOo+VA@mail.gmail.com>
 <CAHbLzkpBCQp7UGK_WPJ-akdQ7HqkOEMtE6+9qX5ciu3DU-ZVrg@mail.gmail.com> <CAHKqYaZAnz4wiHksKSZMLNEbk9eUUQ1z8iQCLwFgNW40ejByYQ@mail.gmail.com>
In-Reply-To: <CAHKqYaZAnz4wiHksKSZMLNEbk9eUUQ1z8iQCLwFgNW40ejByYQ@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 28 Sep 2021 15:14:17 -0700
Message-ID: <CAHbLzkpjRV_32V3AGCsDku8JckeFKvEWd=w2-ZkQ2hbcOAChAA@mail.gmail.com>
Subject: Re: [BUG] The usage of memory cgroup is not consistent with processes
 when using THP
To:     =?UTF-8?B?5Y+w6L+Q5pa5?= <yunfangtai09@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Tejun Heo <tj@kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 28, 2021 at 12:15 AM =E5=8F=B0=E8=BF=90=E6=96=B9 <yunfangtai09@=
gmail.com> wrote:
>
> Yang Shi <shy828301@gmail.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:28=E5=86=99=E9=81=93=EF=BC=9A
> > IMHO I don't think this is a bug. The disparity reflects the
> > difference in how the page life cycle is viewed between process and
> > cgroup. The usage of process comes from the rss_counter of mm. It
> > tracks the per-process mapped memory usage. So it is updated once the
> > page is zapped.
> >
> > But from the point of cgroup, the page is charged when it is allocated
> > and uncharged when it is freed. The page may be zapped by one process,
> > but there might be other users pin the page to prevent it from being
> > freed. The pin may be very transient or may be indefinite. THP is one
> > of the pins. It is gone when the THP is split, but the split may
> > happen a long time after the page is zapped due to deferred split.
> Thank you for reply. I agree that it reflects the difference between
> process and cgroup. The memory usage of cgroup is usually used to
> indicate the memory usage of the container. It can be used to avoid
> the OOM and etc. The disparity will cause that the memory usage of
> containers with the same processes are randomly different (we found
> more than 30GB different). It is hard to manage them. Of course,
> disable THP is a way to solve it. Can it have another way to solve it
> ?

I don't quite get what exactly you want to manage. If you want to get
rid of the disparity, I don't have good idea other than splitting THP
in place instead of using deferred split. But AFAIK it is not quite
feasible due to some locking problems.
