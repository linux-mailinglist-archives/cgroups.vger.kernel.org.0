Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021AE24C458
	for <lists+cgroups@lfdr.de>; Thu, 20 Aug 2020 19:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgHTRQR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Aug 2020 13:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730489AbgHTRPh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Aug 2020 13:15:37 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0020C061387;
        Thu, 20 Aug 2020 10:15:29 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z3so2297990ilh.3;
        Thu, 20 Aug 2020 10:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MOQmfZn9DA4QXnKxyQeBWYBG/mA3vxQqGH4PKhYLc5o=;
        b=OfBzuLHZ2eSHGCtzyhVtTLqGYyG1Up4rJEWA0nr8ye40oTw8lvfrlQJXFRysqMYoDt
         eOGvCWmxBFoWGMLHQXoBHqnzSy4h2NC9VOv3VeXXQu1kI/PhBB+F+2MKDFp1BIXr78HS
         Vk33HZ2ECIEDzTQu95hzffvCTm5bzMONFui3vlVPtr7YAlnSkn55SMJ1RCht2TTIMMOh
         zEeiOHkWMWGWHZdpzhItd55aQryuPukj72Ij6RXsM2UGmfaFWCtz7UAePAj3B/nHqWRt
         7Dat4Z8Yb74jW1xR4XiSMT9Ho29VZs0MO7r5ePNd999lahMd89om26IvTh5fLLk0Dctf
         AWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MOQmfZn9DA4QXnKxyQeBWYBG/mA3vxQqGH4PKhYLc5o=;
        b=fWFOSedBaHUyYLUvaYMV4ITGy3Mx7oz+oPsrHo8QXkNEANOh/XujZfKMxI40Tu0fzb
         VCnrKL8ZzUcfg6rDLnNhpyadMwIBe4lrfeDrRwa6fgX1krQRFqRWwJGdpz6yfmLRV2aM
         CiSw4xEaQYlBrRhIAJeGVdzKlFoILjcGvSiNXC0cZVdDxNHs2MN0I6i8r8dM2VwH6Zij
         l+SHhVRDEj4me772D/9eec831+AIdE2ifUXlhbWhIDUdBiT2ejU+4nPtJHSIY2jeuE8d
         EsyRtO2trpBk242DWuBcJXntXflSTzJFMyNSyC9Q9hVpQJsgIciE9IcSEJ8HHNQp2Kqi
         CSGQ==
X-Gm-Message-State: AOAM530jhAz6tn/xFjf9lRUrVDOrOLLDzFI4dber0LElMnKdEV849dfw
        ptBOhcqgoVRO9JSbS8+tvVgjPko9/vtQTdQznY4=
X-Google-Smtp-Source: ABdhPJzhT90NxQEDROP7MsMMwa4plorb/IpX1WdMHQHJMHCNn3LrLx1qXWTMcLhjtdyEkwkUV8Fqvrkh7A6b529fmDI=
X-Received: by 2002:a92:ae06:: with SMTP id s6mr3311682ilh.64.1597943728468;
 Thu, 20 Aug 2020 10:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200819041852.23414.95939.stgit@localhost.localdomain>
 <20200819042738.23414.60815.stgit@localhost.localdomain> <084c58a7-7aac-820c-9606-19391c35b9b5@linux.alibaba.com>
 <CAKgT0Ud3CZ8KHLXCrWNGJAX85x23-EWLnAV63-NMmJ+5vD1JAA@mail.gmail.com> <87ded438-e908-117d-ecfb-1af7224d46da@linux.alibaba.com>
In-Reply-To: <87ded438-e908-117d-ecfb-1af7224d46da@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 20 Aug 2020 10:15:17 -0700
Message-ID: <CAKgT0Ueibb_MBvq4CeOO2ZkQfigv5SOC4=13Bfdzdj_9zt4O7Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] mm: Split move_pages_to_lru into 3 separate passes
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        kbuild test robot <lkp@intel.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 20, 2020 at 2:58 AM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
>
>
> =E5=9C=A8 2020/8/19 =E4=B8=8B=E5=8D=8810:42, Alexander Duyck =E5=86=99=E9=
=81=93:
> >> It's actually changed the meaning from current func. which I had seen =
a bug if no relock.
> >> but after move to 5.9 kernel, I can not reprodce the bug any more. I a=
m not sure if 5.9 fixed
> >> the problem, and we don't need relock here.
> > So I am not sure what you mean here about "changed the meaning from
> > the current func". Which function are you referring to and what
> > changed?
> >
> > From what I can tell the pages cannot change memcg because they were
> > isolated and had the LRU flag stripped. They shouldn't be able to
> > change destination LRU vector as a result. Assuming that, then they
> > can all be processed under same LRU lock and we can avoid having to
> > release it until we are forced to do so to call putback_lru_page or
> > destroy the compound pages that were freed while we were shrinking the
> > LRU lists.
> >
>
> I had sent a bug which base on 5.8 kernel.
> https://lkml.org/lkml/2020/7/28/465
>
> I am not sure it was fixed in new kernel. The original line was introduce=
d by Hugh Dickins
> I believe it would be great if you can get comments from him.

When I brought this up before you had pointed to the relocking being
due to the fact that the function was reacquiring the lruvec for some
reason. I wonder if the fact that the LRU bit stripping serializing
things made it so that the check for the lruvec after releasing the
lock became redundant.

- Alex
