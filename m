Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797B71FF224
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2020 14:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgFRMlh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Jun 2020 08:41:37 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:40645 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgFRMlg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Jun 2020 08:41:36 -0400
Received: by mail-ej1-f65.google.com with SMTP id q19so6243055eja.7;
        Thu, 18 Jun 2020 05:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GwWWgp6poedvgja7RNEoGmK1y3wNcNo/q/dYBmBGoA8=;
        b=o8iKAGvPelZ799l0MgRR7gBeWope4OBEX/NDyfdtQx5l0XVPqxEXTLkzyAN8zAqTka
         pCTFcf4Mq3hXNkb73wjBquHHGOlZ0TV4DtXn7IsriCM5ZU2uu5gnd5ys4MEfFtVYASqe
         aovR3jFsdDdD5WpKqeR7mT+EoiB1BCO7Gm6c7Xu1Txjj6mXz4j5TMGt+yhHzYdOShA4W
         ZKjJBG6kCVog1crDs4rjS/+VuE7MVtYo9JyKTIikWISY5ySFs+N0d1ojPvHmzSjbQSKN
         RYHKamwenkP+F3qVryByBY1PJHDyCH0oFqkjWQbINQrlF/R+eeiPujCrBGsRDnglaOcs
         6oYw==
X-Gm-Message-State: AOAM533EKMj4LcuBj/8vMS6Z0z+u1pZd4xAn5TE1HUrnLeHZqgUxJiMH
        lyrhO7HzZyvFURM84sH880Y=
X-Google-Smtp-Source: ABdhPJxMkauDVQefVPuJ2qpFGMV+90HykPa5BpTmZw4DM3T8iphGnLowIDqJy/XvxbHN8BtR+7Sktg==
X-Received: by 2002:a17:907:20e5:: with SMTP id rh5mr3971654ejb.80.1592484092440;
        Thu, 18 Jun 2020 05:41:32 -0700 (PDT)
Received: from localhost (ip-37-188-189-34.eurotel.cz. [37.188.189.34])
        by smtp.gmail.com with ESMTPSA id dn15sm2375487ejc.26.2020.06.18.05.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 05:41:31 -0700 (PDT)
Date:   Thu, 18 Jun 2020 14:41:29 +0200
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
Message-ID: <20200618124129.GC15447@dhcp22.suse.cz>
References: <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
 <20200617135758.GA548179@chrisdown.name>
 <20200617141155.GQ9499@dhcp22.suse.cz>
 <CA+G9fYu+FB1PE0AMmE-9MrHpayE9kChwTyc3zfM6V83uQ0zcQA@mail.gmail.com>
 <20200617160624.GS9499@dhcp22.suse.cz>
 <CA+G9fYtCXrVGVtRTwxiqgfFNDDf_H4aNH=VpWLhsV4n_mCTLGg@mail.gmail.com>
 <20200617210935.GA578452@chrisdown.name>
 <CALOAHbBp7Ytd-Hta9NH-_HJtVTAsR5Pw2RYrVScp7PPezCEv2w@mail.gmail.com>
 <20200618123743.GA694719@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618123743.GA694719@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 18-06-20 13:37:43, Chris Down wrote:
> Yafang Shao writes:
> > On Thu, Jun 18, 2020 at 5:09 AM Chris Down <chris@chrisdown.name> wrote:
> > > 
> > > Naresh Kamboju writes:
> > > >After this patch applied the reported issue got fixed.
> > > 
> > > Great! Thank you Naresh and Michal for helping to get to the bottom of this :-)
> > > 
> > > I'll send out a new version tomorrow with the fixes applied and both of you
> > > credited in the changelog for the detection and fix.
> > 
> > As we have already found that the usage around memory.{emin, elow} has
> > many limitations, I think memory.{emin, elow} should be used for
> > memcg-tree internally only, that means they can only be used to
> > calculate the protection of a memcg in a specified memcg-tree but
> > should not be exposed to other MM parts.
> 
> I agree that the current semantics are mentally taxing and we should
> generally avoid exposing the implementation details outside of memcg where
> possible. Do you have a suggested rework? :-)

I would really prefer to do that work on top of the fixes we (used to)
have in mmotm (with the fixup).
-- 
Michal Hocko
SUSE Labs
