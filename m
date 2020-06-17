Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203351FCF22
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2020 16:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgFQOMB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Jun 2020 10:12:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36874 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgFQOMA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Jun 2020 10:12:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so2068282edq.4;
        Wed, 17 Jun 2020 07:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FnLVx3mpNTRNn979KEIujDpuBEHdqJ/b/LKxqUKjo5U=;
        b=R1VwMYEBBKcjm0+0e/VVQ6zthOJ9S/V7pWUvq8piWXdull4CjVyFS3wIHZyAx9ktTp
         3qXgTYQZK3KS/Yp3eAY87y4OaCVI3QLMQBjTwdBwvyhNQuJgdLMV9cXOu/G6waPtd7QM
         +6xuSQ7EHERKPcphHO8zudCohvDq7QEdI3J66W0sDsgre7xuDAeAUA9JiAzuRSNDP2m9
         RIGiUMwHSv3lTliPg/jWsHR+ya7zvpVRs9ZHnt8x+gmGxKY5U6ToQiVaxqwYKfjcxIBd
         PpLOs9ScVvFe+AhBB2Zs5L2HdhznT3D9s0Uu4wFapfGf4vpmNVZUjNR3q3soYBkQJxnh
         ZAIQ==
X-Gm-Message-State: AOAM530hzvjJjL5hbl/tc1l2ZDqwbcd280/86/8hIdcRRF9r/3auBwFC
        ia6i23OeDyhu+wlNx22AMj4=
X-Google-Smtp-Source: ABdhPJznS9MRNi7kFBPyQ0SPfnXV06mWSgLUfdEwyE6fs7gLQFQsvZDC9Kqw5DW5z+Zxjo6sXkZecQ==
X-Received: by 2002:a05:6402:6cc:: with SMTP id n12mr7166151edy.266.1592403118087;
        Wed, 17 Jun 2020 07:11:58 -0700 (PDT)
Received: from localhost (ip-37-188-158-19.eurotel.cz. [37.188.158.19])
        by smtp.gmail.com with ESMTPSA id z20sm34596ejb.68.2020.06.17.07.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 07:11:57 -0700 (PDT)
Date:   Wed, 17 Jun 2020 16:11:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
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
Message-ID: <20200617141155.GQ9499@dhcp22.suse.cz>
References: <20200519075213.GF32497@dhcp22.suse.cz>
 <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
 <20200617135758.GA548179@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617135758.GA548179@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[Our emails have crossed]

On Wed 17-06-20 14:57:58, Chris Down wrote:
> Naresh Kamboju writes:
> > mkfs -t ext4 /dev/disk/by-id/ata-TOSHIBA_MG04ACA100N_Y8RQK14KF6XF
> > mke2fs 1.43.8 (1-Jan-2018)
> > Creating filesystem with 244190646 4k blocks and 61054976 inodes
> > Filesystem UUID: 7c380766-0ed8-41ba-a0de-3c08e78f1891
> > Superblock backups stored on blocks:
> > 32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
> > 4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968,
> > 102400000, 214990848
> > Allocating group tables:    0/7453 done
> > Writing inode tables:    0/7453 done
> > Creating journal (262144 blocks): [   51.544525] under min:0 emin:0
> > [   51.845304] under min:0 emin:0
> > [   51.848738] under min:0 emin:0
> > [   51.858147] under min:0 emin:0
> > [   51.861333] under min:0 emin:0
> > [   51.862034] under min:0 emin:0
> > [   51.862442] under min:0 emin:0
> > [   51.862763] under min:0 emin:0
> 
> Thanks, this helps a lot. Somehow we're entering mem_cgroup_below_min even
> when min/emin is 0 (which should indeed be the case if you haven't set them
> in the hierarchy).
> 
> My guess is that page_counter_read(&memcg->memory) is 0, which means
> mem_cgroup_below_min will return 1.

Yes this is the case because this is likely the root memcg which skips
all charges.

> However, I don't know for sure why that should then result in the OOM killer
> coming along. My guess is that since this memcg has 0 pages to scan anyway,
> we enter premature OOM under some conditions. I don't know why we wouldn't
> have hit that with the old version of mem_cgroup_protected that returned
> MEMCG_PROT_* members, though.

Not really. There is likely no other memcg to reclaim from and assuming
min limit protection will result in no reclaimable memory and thus the
OOM killer.

> Can you please try the patch with the `>=` checks in mem_cgroup_below_min
> and mem_cgroup_below_low changed to `>`? If that fixes it, then that gives a
> strong hint about what's going on here.

This would work but I believe an explicit check for the root memcg would
be easier to spot the reasoning.

-- 
Michal Hocko
SUSE Labs
