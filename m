Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3E91FDFD1
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2020 03:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbgFRBno (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Jun 2020 21:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgFRBnm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Jun 2020 21:43:42 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92D2C06174E;
        Wed, 17 Jun 2020 18:43:41 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id j19so4243037ilk.9;
        Wed, 17 Jun 2020 18:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/NV0zNhM4fAGBEvR6pS4jubz62WIXqxLs8Qbcn4M8G8=;
        b=dDcozoF3gjERlnIYD/aopfiDz8+Xk7wB85tQ+JG+fS/wcxWZRWOO9ndR3j6DlLjase
         pakWhsVPQ1s1RE4tdxVgckkmbgQQmy7KzyUVIgo8XiewLQf5iDAQQHzmV55SqyA3ni0l
         UhO1lJ4tnxN9yr+l1R5SlEBFs6N7bGO1IezGVFxCOKnzKhYGlAd0C60gF1lzq5zPgtZ5
         9JgAPTH5CwMDcYYdYBRFRY59OOo2Ufb2xXI6CZ33SNJk34h80UPpZg/jdNoIWaOmSADF
         HprtPmsk/lgc7E5A+WM5WfU02YavO+ic/3qkx+0n65e7+GL5yWyxbhFZWUcj97Z490uK
         AJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/NV0zNhM4fAGBEvR6pS4jubz62WIXqxLs8Qbcn4M8G8=;
        b=rIZaeZTMyB+E9IELLbPTjBPoCCaBgD3xQt1ws8BU4h9XstxN3oZN8RRILpTQ4uXQmv
         cXVnyuNmNjOsK9YJzEz/33jmCbeqZXOHypH4Zqr6izzZXuj0AtnuKmdNXfuxHbYRF2H6
         j3eoZTp+6Rsa/iTM6VuJPmhM7cbez1oFBZ4FsG0xI2WpGUSKFKpMt26GsmJ8YRhiRgd1
         JF7A9z+tUxOQaJ3YJusjuZmowsqkbr8kNn6dsC8UdxUiCTTeFRnXDw3bL3VRTJNzZAJz
         Qd2ngfmMwYX6ZcerUAuNG5bGYZn83XSt4PEPFvemdEu48FNflsj37H2WGLfe+nnZT5Mk
         QtOg==
X-Gm-Message-State: AOAM532Bac1QzSwCth3YFWtbUrdp2SmwUmrp6GQ3dBHgcArhsOSGaf50
        lIOM/P6Ix+OA6HFX3w6m06pzkFXlG1Jfpy7sikM=
X-Google-Smtp-Source: ABdhPJy/FeQxzQszfiH33uOWaccj4JEo3pvq0ekiMOC1+TiGVdTADnFmscwMk0igU9qcjJHn9X3GpIIhMlgC28sEOaI=
X-Received: by 2002:a05:6e02:542:: with SMTP id i2mr1867971ils.203.1592444621188;
 Wed, 17 Jun 2020 18:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name> <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz> <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
 <20200617135758.GA548179@chrisdown.name> <20200617141155.GQ9499@dhcp22.suse.cz>
 <CA+G9fYu+FB1PE0AMmE-9MrHpayE9kChwTyc3zfM6V83uQ0zcQA@mail.gmail.com>
 <20200617160624.GS9499@dhcp22.suse.cz> <CA+G9fYtCXrVGVtRTwxiqgfFNDDf_H4aNH=VpWLhsV4n_mCTLGg@mail.gmail.com>
 <20200617210935.GA578452@chrisdown.name>
In-Reply-To: <20200617210935.GA578452@chrisdown.name>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 18 Jun 2020 09:43:05 +0800
Message-ID: <CALOAHbBp7Ytd-Hta9NH-_HJtVTAsR5Pw2RYrVScp7PPezCEv2w@mail.gmail.com>
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

On Thu, Jun 18, 2020 at 5:09 AM Chris Down <chris@chrisdown.name> wrote:
>
> Naresh Kamboju writes:
> >After this patch applied the reported issue got fixed.
>
> Great! Thank you Naresh and Michal for helping to get to the bottom of this :-)
>
> I'll send out a new version tomorrow with the fixes applied and both of you
> credited in the changelog for the detection and fix.

As we have already found that the usage around memory.{emin, elow} has
many limitations, I think memory.{emin, elow} should be used for
memcg-tree internally only, that means they can only be used to
calculate the protection of a memcg in a specified memcg-tree but
should not be exposed to other MM parts.

-- 
Thanks
Yafang
