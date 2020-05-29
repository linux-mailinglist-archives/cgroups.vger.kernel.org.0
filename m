Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6376F1E724B
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2020 03:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404586AbgE2B4x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 21:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390957AbgE2B4v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 21:56:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C44C08C5C7
        for <cgroups@vger.kernel.org>; Thu, 28 May 2020 18:56:47 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d128so1451632wmc.1
        for <cgroups@vger.kernel.org>; Thu, 28 May 2020 18:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GN9DgkPdwejhyEVH1kmP5gS0KBOAcxSeuTuQOx2XI9o=;
        b=lkBaXTV2ZUB6ZO5yX3Ng0K/CASCbc9oNlaDIc8KLZ8e4v2cb+z5+AxOSC0HUqdLw42
         pPHQXKJiXMf7fSmverIul8xSND7c0ygaABLVaG0hqIXTL8OJ4e0fS8l8+kZ0LHaXgNsT
         f3Y+1qQWXh34SIawtNNfPuqOwbkRTPMzu6he4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GN9DgkPdwejhyEVH1kmP5gS0KBOAcxSeuTuQOx2XI9o=;
        b=lVrmNAwqfuojXIUXdoYmJzTf/ApUOIiPxt+YWdJKwW0GV7xg9ykbIIPbiHuM7Dju1k
         YepT7c8FGkITBJB3TMkI7BHyLBqbjpTrMTWZO+NHLGUAXDGhV+1CTb63l3GjMTidfmEN
         bKSNy5E4j1B+9xbsqvioCdQzkJIky0048UeD1ScxWfFE/MC581ZIHQSw9gvbnryIt5i4
         VrQLpHALchNU0LWPwaLlO+y+FYdS2orLjypJOquEPb5pj9lx4J5SSZI+6EUM7za8MtgP
         QBjZRkHolrCKCyk9M3ZlEGmA6IX5lNxP+dRWUIXA2pLovKyCPo790VuTXzfQ51CvbZS8
         GX4g==
X-Gm-Message-State: AOAM530vTtRm03qptYj0e1saaf3OxQJ/KheHK4f1surXG0w8REggkj8S
        ksAB6piRMxN1N/Rvt4KXxPF9RA==
X-Google-Smtp-Source: ABdhPJx1kaceNrBzDvGLjsUvi/4uBliHtVGdHPjh2oD497Ebo468RL7eFjpFK3j2MrZfogR+PRA4Bg==
X-Received: by 2002:a7b:c096:: with SMTP id r22mr6033969wmh.92.1590717405871;
        Thu, 28 May 2020 18:56:45 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id q11sm1858042wrv.67.2020.05.28.18.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 18:56:45 -0700 (PDT)
Date:   Fri, 29 May 2020 02:56:44 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Yafang Shao <laoar.shao@gmail.com>
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
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200529015644.GA84588@chrisdown.name>
References: <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com>
 <CA+G9fYs2jg-j_5fdb0OW0G-JzDjN7b8d9qnX7uuk9p4c7mVSig@mail.gmail.com>
 <20200528150310.GG27484@dhcp22.suse.cz>
 <CA+G9fYvDXiZ9E9EfU6h0gsJ+xaXY77mRu9Jg+J7C=X4gJ3qvLg@mail.gmail.com>
 <20200528164121.GA839178@chrisdown.name>
 <CALOAHbAHGOsAUUM7qn=9L1u8kAf6Gztqt=SyHSmZ9XuYZWcKmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CALOAHbAHGOsAUUM7qn=9L1u8kAf6Gztqt=SyHSmZ9XuYZWcKmg@mail.gmail.com>
User-Agent: Mutt/1.14.2 (2020-05-25)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Yafang Shao writes:
>Look at this patch[1] carefully you will find that it introduces the
>same issue that I tried to fix in another patch [2]. Even more sad is
>these two patches are in the same patchset. Although this issue isn't
>related with the issue found by Naresh, we have to ask ourselves why
>we always make the same mistake ?
>One possible answer is that we always forget the lifecyle of
>memory.emin before we read it. memory.emin doesn't have the same
>lifecycle with the memcg, while it really has the same lifecyle with
>the reclaimer. IOW, once a reclaimer begins the protetion value should
>be set to 0, and after we traversal the memcg tree we calculate a
>protection value for this reclaimer, finnaly it disapears after the
>reclaimer stops. That is why I highly suggest to add an new protection
>member in scan_control before.

I agree with you that the e{min,low} lifecycle is confusing for everyone -- the 
only thing I've not seen confirmation of is any confirmed correlation with the 
i386 oom killer issue. If you've validated that, I'd like to see the data :-)
