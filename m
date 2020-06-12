Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A560E1F77B1
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2020 14:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgFLMJM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Jun 2020 08:09:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36922 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgFLMJM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Jun 2020 08:09:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id x13so9494574wrv.4;
        Fri, 12 Jun 2020 05:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0z8NpPBTC8fx2bnuG8Z/NmM1px6+WjPFa2BhCesn7bM=;
        b=dwnmoXthax/50cYKAd2YDKOcoUZGZ40vfZxg8MCacIHv1HWxewXKYMVXB6iepuaAD1
         DUoRH8fH6vP6uZePzk2ZbBA35FsWL9StD0xCH3yuU5Kfylnp1F2OQY/YOxznxRN0ta53
         5NNXNtWr3a9ZFnER1wWXh12ZTJx2mKUa/ax28gJnxUDfTaDY0VVsBS9U6vkkVJOkfYy3
         WrLnQLQx3PinJv9PsOWt5O6SvJGoQGRmbV8KYKKCMqtTu+FrLMzn2MV3JdA1rYv6imWK
         P5OnZpf0A/Tq/XDBVA2LF3wKX3f5ZNqPlRplNEhPpkmDEQ+yyQYC5rQkFjj+gNCHEF5w
         rhuA==
X-Gm-Message-State: AOAM531xfznxpy8lXvdt7BeWSnJgiUnkLe5E3nbDJryK8/aP8D/Ze7lg
        gCAVB9vF2Fkict2wXAM65rM=
X-Google-Smtp-Source: ABdhPJz1sL62XzpDAGQuQcumUUzvpkSfg7su7rAnvTQ7e/vCPEMTYoz1QoY8w+Uh8QVrBnRvZKmM4A==
X-Received: by 2002:a05:6000:1104:: with SMTP id z4mr14545075wrw.272.1591963748046;
        Fri, 12 Jun 2020 05:09:08 -0700 (PDT)
Received: from localhost (ip-37-188-174-201.eurotel.cz. [37.188.174.201])
        by smtp.gmail.com with ESMTPSA id a3sm9652169wrp.91.2020.06.12.05.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 05:09:06 -0700 (PDT)
Date:   Fri, 12 Jun 2020 14:09:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
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
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200612120904.GA8641@dhcp22.suse.cz>
References: <CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com>
 <CA+G9fYs2jg-j_5fdb0OW0G-JzDjN7b8d9qnX7uuk9p4c7mVSig@mail.gmail.com>
 <20200528150310.GG27484@dhcp22.suse.cz>
 <CA+G9fYvDXiZ9E9EfU6h0gsJ+xaXY77mRu9Jg+J7C=X4gJ3qvLg@mail.gmail.com>
 <20200528164121.GA839178@chrisdown.name>
 <CALOAHbAHGOsAUUM7qn=9L1u8kAf6Gztqt=SyHSmZ9XuYZWcKmg@mail.gmail.com>
 <20200529015644.GA84588@chrisdown.name>
 <20200529094910.GH4406@dhcp22.suse.cz>
 <20200611095514.GD20450@dhcp22.suse.cz>
 <CA+G9fYsjH8vOTkSKGa5vgC=0fEXuC5UnGsZOirHxH9nOJSHPdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsjH8vOTkSKGa5vgC=0fEXuC5UnGsZOirHxH9nOJSHPdA@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 12-06-20 15:13:22, Naresh Kamboju wrote:
> On Thu, 11 Jun 2020 at 15:25, Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 29-05-20 11:49:20, Michal Hocko wrote:
> > > On Fri 29-05-20 02:56:44, Chris Down wrote:
> > > > Yafang Shao writes:
> > > Agreed. Even if e{low,min} might still have some rough edges I am
> > > completely puzzled how we could end up oom if none of the protection
> > > path triggers which the additional debugging should confirm. Maybe my
> > > debugging patch is incomplete or used incorrectly (maybe it would be
> > > esier to use printk rather than trace_printk?).
> >
> > It would be really great if we could move forward. While the fix (which
> > has been dropped from mmotm) is not super urgent I would really like to
> > understand how it could hit the observed behavior. Can we double check
> > that the debugging patch really doesn't trigger (e.g.
> > s@trace_printk@printk in the first step)?
> 
> Please suggest to me the way to get more debug information
> by providing kernel debug patches and extra kernel configs.
> 
> I have applied your debug patch and tested on top on linux next 20200612
> but did not find any printk output while running mkfs -t ext4 /drive test case.

Have you tried s@trace_printk@printk@ in the patch? AFAIK trace_printk
doesn't dump anything into the printk ring buffer. You would have to
look into trace ring buffer.
-- 
Michal Hocko
SUSE Labs
