Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF77826E006
	for <lists+cgroups@lfdr.de>; Thu, 17 Sep 2020 17:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgIQPuQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 11:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgIQPth (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 11:49:37 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86662C061352;
        Thu, 17 Sep 2020 08:39:46 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id q4so2715320ils.4;
        Thu, 17 Sep 2020 08:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+9HU43KroNK5/x6wnhb2ZPEi6bPpfMElvU5+soOALQc=;
        b=WILyDFJqy/kKppDyOXiv0T0ZJeoRPbsBrW+7oCxHCSzypdd0t9S2MeYT/bSdApP/pK
         yDT3toE44n1//aXcVJqtiZALsGX6gYub0Lj2RthM0Eb8YPYutIppe3s+iJasQDNFdWxN
         x6vc4gQ0VnYI2VMMVKYHpBdbIxHQ8TleU96wpk4sjSOPC2SaPiBy1w5ccYTRNg6mu9kQ
         T5PtHr2DR/bv9S2bjQRnrQEYZOwsx+DOYWNC5wlf+K4A5m066MyWwa/eN58LHhXtnutz
         Mqx3V0JDt8c7JMIIap0P8HISCbbafv2ol/KoD4rSnLph5PIdCTR7M7/pGif4EaBTDFUX
         WwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+9HU43KroNK5/x6wnhb2ZPEi6bPpfMElvU5+soOALQc=;
        b=QfEmB2lKunzC2ZhFoQks6EAfB4caVFNOFZLnCREED+eH0S42xQjd0AxN5Offi0ZK/9
         IJ3VcKZm/RobNEWRrklc4R8X1y+BVWFrL19XWXMRLLAtLsH9WI1Vb8Cw5w8I64r2rY+y
         Fn9rL7fTnsPM5MUtuQ8atXHLjTyX4U5OXwntomc/uhGld0yja4qu4b1XUBi3bAP3+pdQ
         pUP+NJoMMCgX7GJ4J830TXlH6GyFqcNjVeoZ/jVl9+7qy7kE8VGA3zIB87HL35q6K2m3
         GJbKc7b+S+82WjOnF1/nC4xujCKCRheAbA105wd9+5OHGuj1GDWvso4e9A0jZ2ESzHY3
         ly1Q==
X-Gm-Message-State: AOAM531+BMpjgF+PMzyJrQ77Hl2S7M4UVVENQLgpR6FJE7fNqwDwVUjg
        f++N2CPhhpN+md9hpLxn5i+DrpkVNQjpEq7obag=
X-Google-Smtp-Source: ABdhPJxV3kTtMKU9Fb9Mz10pXxYSNq4oOPvCHIapWzAoUpP3YpZs9DQZTZltRrEQ3HLZWIgSINsZ2+tPMe1gQqVmhpU=
X-Received: by 2002:a92:b74c:: with SMTP id c12mr26223986ilm.237.1600357185698;
 Thu, 17 Sep 2020 08:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008262301240.4405@eggly.anvils>
 <alpine.LSU.2.11.2009081640070.7256@eggly.anvils> <61a42a87-eec9-e300-f710-992756f70de6@linux.alibaba.com>
 <alpine.LSU.2.11.2009091524260.10087@eggly.anvils> <855ad6ee-dba4-9729-78bd-23e392905cf6@linux.alibaba.com>
 <alpine.LSU.2.11.2009111634020.22739@eggly.anvils> <5cfc6142-752d-26e6-0108-38d13009268b@linux.alibaba.com>
 <alpine.LSU.2.11.2009150112130.1550@eggly.anvils> <20200915165807.kpp7uhiw7l3loofu@ca-dmjordan1.us.oracle.com>
 <c3362c0a-3707-3a3d-9955-960d95f3ad8c@linux.alibaba.com> <20200917143519.lhdfnoc47qrmbhaz@ca-dmjordan1.us.oracle.com>
In-Reply-To: <20200917143519.lhdfnoc47qrmbhaz@ca-dmjordan1.us.oracle.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 17 Sep 2020 08:39:34 -0700
Message-ID: <CAKgT0Ud8sYidvxtyrN3AFLs+-DiW7cuPGrKknaRicQsC8PLRtg@mail.gmail.com>
Subject: Re: [PATCH v18 00/32] per memcg lru_lock: reviews
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, shy828301@gmail.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 17, 2020 at 7:26 AM Daniel Jordan
<daniel.m.jordan@oracle.com> wrote:
>
> On Thu, Sep 17, 2020 at 10:37:45AM +0800, Alex Shi wrote:
> > =E5=9C=A8 2020/9/16 =E4=B8=8A=E5=8D=8812:58, Daniel Jordan =E5=86=99=E9=
=81=93:
> > > On Tue, Sep 15, 2020 at 01:21:56AM -0700, Hugh Dickins wrote:
> > >> On Sun, 13 Sep 2020, Alex Shi wrote:
> > >>> Uh, I updated the testing with some new results here:
> > >>> https://lkml.org/lkml/2020/8/26/212
> > >> Right, I missed that, that's better, thanks.  Any other test results=
?
> > > Alex, you were doing some will-it-scale runs earlier.  Are you planni=
ng to do
> > > more of those?  Otherwise I can add them in.
> >
> > Hi Daniel,
> >
> > Does compaction perf scalable, like thpscale, I except they could get s=
ome benefit.
>
> Yep, I plan to stress compaction.  Reclaim as well.
>
> I should have said which Alex I meant.  I was asking Alex Duyck since he'=
d done
> some will-it-scale runs.

I probably won't be able to do any will-it-scale runs any time soon.
If I recall I ran them for this latest v18 patch set and didn't see
any regressions like I did with the previous set. However the system I
was using is tied up for other purposes and it may be awhile before I
can free it up to look into this again.

Thanks.

- Alex
