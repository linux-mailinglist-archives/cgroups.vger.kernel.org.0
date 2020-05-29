Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CC51E79C3
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2020 11:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgE2JtX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 May 2020 05:49:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38563 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2JtW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 May 2020 05:49:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id e1so2804030wrt.5;
        Fri, 29 May 2020 02:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4SLMrx0MWc8j4vJRn7Kgzb3DUyQWlx2ZLRbxHmKbcbE=;
        b=Ffo8IQE++6k+frzciH7ED5GMNv607o7tgzOMgs1l+TpeHRJXG3eXOUNr7/LwzY4RkD
         PgADuitQPfprFo2OdNyXJKZpRT0a+5rWOowb5oFllzkM757hs7ia+jBnhaOgxMG/KBic
         3IjxMv+NTvlerppX3wn2Tb8gHduqqxxgkxGmneN97HRbv36JwL4iHDni6NgAfMcM3E+0
         dgEeUqtNbuEvWOyuPIZijNvyIAfUnbeGUXBDdq9ayEpy9QgTzb543MXJe27gGYAbb73B
         3ULgH6nrR4qTuM56Sa4MCsBHMetJ5uGsloJgkk42ZrJhoWvL/mapbyzSOdJ/evRKTne2
         WAWQ==
X-Gm-Message-State: AOAM532Olg01nDQb4vFu/oik4+0BT/DJXCM6MLCo6rsp16qubFQ0VlAh
        OX3qc5dyHJtdbLvO8dUDZ68=
X-Google-Smtp-Source: ABdhPJynJWn/appsj5zHjc6kja0kVDlwDRUmuKllOuUorUMxNbkdmaKubkMD/idzdl3klO6z62m4Rg==
X-Received: by 2002:adf:f58b:: with SMTP id f11mr7947420wro.155.1590745760055;
        Fri, 29 May 2020 02:49:20 -0700 (PDT)
Received: from localhost (ip-37-188-150-59.eurotel.cz. [37.188.150.59])
        by smtp.gmail.com with ESMTPSA id 5sm9907553wmd.19.2020.05.29.02.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 02:49:18 -0700 (PDT)
Date:   Fri, 29 May 2020 11:49:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
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
Message-ID: <20200529094910.GH4406@dhcp22.suse.cz>
References: <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com>
 <CA+G9fYs2jg-j_5fdb0OW0G-JzDjN7b8d9qnX7uuk9p4c7mVSig@mail.gmail.com>
 <20200528150310.GG27484@dhcp22.suse.cz>
 <CA+G9fYvDXiZ9E9EfU6h0gsJ+xaXY77mRu9Jg+J7C=X4gJ3qvLg@mail.gmail.com>
 <20200528164121.GA839178@chrisdown.name>
 <CALOAHbAHGOsAUUM7qn=9L1u8kAf6Gztqt=SyHSmZ9XuYZWcKmg@mail.gmail.com>
 <20200529015644.GA84588@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529015644.GA84588@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 29-05-20 02:56:44, Chris Down wrote:
> Yafang Shao writes:
> > Look at this patch[1] carefully you will find that it introduces the
> > same issue that I tried to fix in another patch [2]. Even more sad is
> > these two patches are in the same patchset. Although this issue isn't
> > related with the issue found by Naresh, we have to ask ourselves why
> > we always make the same mistake ?
> > One possible answer is that we always forget the lifecyle of
> > memory.emin before we read it. memory.emin doesn't have the same
> > lifecycle with the memcg, while it really has the same lifecyle with
> > the reclaimer. IOW, once a reclaimer begins the protetion value should
> > be set to 0, and after we traversal the memcg tree we calculate a
> > protection value for this reclaimer, finnaly it disapears after the
> > reclaimer stops. That is why I highly suggest to add an new protection
> > member in scan_control before.
> 
> I agree with you that the e{min,low} lifecycle is confusing for everyone --
> the only thing I've not seen confirmation of is any confirmed correlation
> with the i386 oom killer issue. If you've validated that, I'd like to see
> the data :-)

Agreed. Even if e{low,min} might still have some rough edges I am
completely puzzled how we could end up oom if none of the protection
path triggers which the additional debugging should confirm. Maybe my
debugging patch is incomplete or used incorrectly (maybe it would be
esier to use printk rather than trace_printk?).
-- 
Michal Hocko
SUSE Labs
