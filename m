Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2953E1E655B
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 17:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404155AbgE1PDS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 11:03:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35115 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403912AbgE1PDQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 11:03:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id n5so3561883wmd.0;
        Thu, 28 May 2020 08:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=evz1lutsdd2Eqt9o4+KgC57g/gR26qB8cQ2KV6NODWs=;
        b=VJx/HwbXl5o/d18rL9jXFWIru48CRcbu6zMa/nbL8uHL5RkpLFzluxqMPSHkiUACnq
         8fpdo/KWej952ZGVeM52GUKte5NExvG3LpYfxGglSAuy0TBPmQxlIIK82X7RgOLgJmXB
         +pjpUIOL/bVQorU96JoWT/ysuQZBRxRchyXcPh4B01yzJEnbYuNZSzg4Di2PgdvnQw22
         ksF9CdT4clBfpm1g7Phqf34d9bI09L/NOjel519iuryPdW9UVpqHeITg1pNWQgwAcNU0
         V4UJuQwu9Zb4g6+2NLS3L5y+wF758rtkI/+FjSh/df4TUBaKBHx9YBdCX2ufGjpBOo78
         eMbg==
X-Gm-Message-State: AOAM5335KeIBGypNdrt0JATwyrPXP/uVxG66RygJwBLuKrIswRUKlp8s
        U+85bywfUrHGjRi+1zXV9K4=
X-Google-Smtp-Source: ABdhPJzniI6Aw1b/FqGaEPNB/a6M/vRt8hKQ5Zx5UYlLdgljMoGjhh+KSxCloB6yCJzH8NHlfHrceg==
X-Received: by 2002:a1c:b0c8:: with SMTP id z191mr3947280wme.165.1590678193035;
        Thu, 28 May 2020 08:03:13 -0700 (PDT)
Received: from localhost (ip-37-188-185-40.eurotel.cz. [37.188.185.40])
        by smtp.gmail.com with ESMTPSA id k14sm6163539wrq.97.2020.05.28.08.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:03:11 -0700 (PDT)
Date:   Thu, 28 May 2020 17:03:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
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
Message-ID: <20200528150310.GG27484@dhcp22.suse.cz>
References: <20200519075213.GF32497@dhcp22.suse.cz>
 <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com>
 <CA+G9fYs2jg-j_5fdb0OW0G-JzDjN7b8d9qnX7uuk9p4c7mVSig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs2jg-j_5fdb0OW0G-JzDjN7b8d9qnX7uuk9p4c7mVSig@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 22-05-20 02:23:09, Naresh Kamboju wrote:
> My apology !
> As per the test results history this problem started happening from
> Bad : next-20200430 (still reproducible on next-20200519)
> Good : next-20200429
> 
> The git tree / tag used for testing is from linux next-20200430 tag and reverted
> following three patches and oom-killer problem fixed.
> 
> Revert "mm, memcg: avoid stale protection values when cgroup is above
> protection"
> Revert "mm, memcg: decouple e{low,min} state mutations from protectinn checks"
> Revert "mm-memcg-decouple-elowmin-state-mutations-from-protection-checks-fix"

The discussion has fragmented and I got lost TBH.
In http://lkml.kernel.org/r/CA+G9fYuDWGZx50UpD+WcsDeHX9vi3hpksvBAWbMgRZadb0Pkww@mail.gmail.com
you have said that none of the added tracing output has triggered. Does
this still hold? Because I still have a hard time to understand how
those three patches could have the observed effects.
-- 
Michal Hocko
SUSE Labs
