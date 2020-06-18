Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C871FF5F9
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2020 17:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgFRPAJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Jun 2020 11:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgFRPAI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Jun 2020 11:00:08 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3CFC06174E;
        Thu, 18 Jun 2020 08:00:07 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m81so7406487ioa.1;
        Thu, 18 Jun 2020 08:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NtwtfirPIaj3hQKqt5NnTqLzfoXadlYH6xaXhH3mB+s=;
        b=kYwPKZdp0pHLg9nzSkXLUjXIWhhGSDK+lUsX3kvZKhpx/abFTtNYjkojW4sVVt7bHm
         qZGTxARuFd3WI6EfU1eBN6+4gj/yCc7G3VU2n21gea6aS3fkUz/uMmbZ6zjhs6dF/ctG
         mtQLDzrh6EKtHb9OSOEmMjo3N7fWi8hwmYyXXXcwlEWheXzJEY46FsRDyYJ/YXapbZEL
         GAjWeoKd6sh4vm2KkDp99cfVll6l6Xz1jcMVSif5RsT91SxuUdRKKCZShkXiMxJfDPO2
         mEQ03gbiIGbBmN1vxaEfCsHPJle351uahP3BtuY+Amj/uplhgSOrlPpU1WHGNLMkS4iC
         lVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NtwtfirPIaj3hQKqt5NnTqLzfoXadlYH6xaXhH3mB+s=;
        b=E9oYBpHSZYmC7FLuwZtM18HBTCZPtsRMxCzP0mIHBegoGebObr7eH9A7y4vuzcy66h
         Kd3F62IdMGfD/Q8vLsxuqYRk5AhEPIBg55HPyVBb0PGzoXl0igvA0SIPhQLYundiIMx+
         tcgJqFJOaqh9yEL5uSqY55GT+USlIRYZVF/VfS9kNr13eJ53fAIBYIBO47RDw9NCtDJx
         yhJfYZTsJH7BAFHsYN1ySSDYNAWrsh5qRnguXjI7Nx5PypdyoEyfXovnVqwprgoFdeZx
         0vHgfWRD82wxHZsrQ8boAvZ7JBHCLsK2Y/qXb1qZH4ZkXPcZs3sXiK4s9cDt8Jl3NJdC
         Apdw==
X-Gm-Message-State: AOAM531PZUpGh13VrmFL1AJBCGva+2B1zX1VYE6NkKS9TH70KddBrTFW
        sDtIVOtYHe2ZjdVKqjAWQ1PnUYsWmMEG/bDDECQ=
X-Google-Smtp-Source: ABdhPJyxduBF4FPnbsePTb+IJMrnaO574t87lgH7MXGDrxKnm7Fm0uPL20a9JpNnhO5AEW9mefqTwucGCC8avIECgKo=
X-Received: by 2002:a05:6602:2dd4:: with SMTP id l20mr5412675iow.13.1592492407237;
 Thu, 18 Jun 2020 08:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200521095515.GK6462@dhcp22.suse.cz> <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
 <20200617135758.GA548179@chrisdown.name> <20200617141155.GQ9499@dhcp22.suse.cz>
 <CA+G9fYu+FB1PE0AMmE-9MrHpayE9kChwTyc3zfM6V83uQ0zcQA@mail.gmail.com>
 <20200617160624.GS9499@dhcp22.suse.cz> <CA+G9fYtCXrVGVtRTwxiqgfFNDDf_H4aNH=VpWLhsV4n_mCTLGg@mail.gmail.com>
 <20200617210935.GA578452@chrisdown.name> <CALOAHbBp7Ytd-Hta9NH-_HJtVTAsR5Pw2RYrVScp7PPezCEv2w@mail.gmail.com>
 <20200618123743.GA694719@chrisdown.name>
In-Reply-To: <20200618123743.GA694719@chrisdown.name>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 18 Jun 2020 22:59:28 +0800
Message-ID: <CALOAHbCPd407z45e809VE5c8vP6ewqwkDkY9nrMP5TyP5cjG+A@mail.gmail.com>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
To:     Chris Down <chris@chrisdown.name>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Michal Hocko <mhocko@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 18, 2020 at 8:37 PM Chris Down <chris@chrisdown.name> wrote:
>
> Yafang Shao writes:
> >On Thu, Jun 18, 2020 at 5:09 AM Chris Down <chris@chrisdown.name> wrote:
> >>
> >> Naresh Kamboju writes:
> >> >After this patch applied the reported issue got fixed.
> >>
> >> Great! Thank you Naresh and Michal for helping to get to the bottom of this :-)
> >>
> >> I'll send out a new version tomorrow with the fixes applied and both of you
> >> credited in the changelog for the detection and fix.
> >
> >As we have already found that the usage around memory.{emin, elow} has
> >many limitations, I think memory.{emin, elow} should be used for
> >memcg-tree internally only, that means they can only be used to
> >calculate the protection of a memcg in a specified memcg-tree but
> >should not be exposed to other MM parts.
>
> I agree that the current semantics are mentally taxing and we should generally
> avoid exposing the implementation details outside of memcg where possible. Do
> you have a suggested rework? :-)

Keeping the mem_cgroup_protected() as-is is my suggestion. Anyway I
think it is bad to put memory.{emin, elow} here and there.
If we don't have any better idea by now, just putting all the
references of memory.{emin, elow}  into one
wrapper(mem_cgroup_protected()) is the reasonable solution.

-- 
Thanks
Yafang
