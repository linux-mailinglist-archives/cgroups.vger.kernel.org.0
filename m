Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5778183966
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2020 20:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCLTZk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Mar 2020 15:25:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45491 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgCLTZk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Mar 2020 15:25:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id c145so8230743qke.12;
        Thu, 12 Mar 2020 12:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kSRZhT64+sxW9xDyUZ3l/rkvlLGuZc8V6ZIjw4qfv1c=;
        b=c8JNPsVOXsaM4NWGf5pmxx6t2jZJ9I/3H+dCm28qDP91leSkivH4V1ku7Ah5fTzuIr
         mDDxhTl0Z+3F/VqMr32cZhGDAVLTkEfnUpc4To6HefgYByEn9GROeiJp9SWAP5U2KjIi
         CgELBvkumf8LAQpOk8GAtfQaKbCH5SfoCD4YVX05pYHi9SyL8qi5Sne/gvQh3mZNZ1e3
         V6UH2z3SAj3jKoS9kgVFWJKTYWcdHeXVYMBOlkdd2PNfDpqkYnBLFKZiZhOJp4y63QOy
         IASsb0FnjvJnnpl47Dr6siPjMTSjxO7SWShEsI7guYWLZSwqRuwQg61K7PiPPhbEeYrQ
         JhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kSRZhT64+sxW9xDyUZ3l/rkvlLGuZc8V6ZIjw4qfv1c=;
        b=FeiDaT562XjHc8BEfWJT6tv8kqP16g0f4hIyxIHQgwyN4xqhiJd/Zbu0jbJ05ejo10
         Gra9YZuVAo/ExEZlpUGdEXckV3b5/9pLDWHE+Tkv5rIGqcF6bSh/CW7qT3UI3qS3nQIC
         u1uTjqHjg2HolD6oPVKXHLmbcT3i0O8n02gRPRhr9s7MSj+lMAdJZAXELgZ4KtMWgdF6
         agYo4U4/kCduVsO/LOkSNw5NkaAwxmDyBARtkJOt3u+mtKMhmFzH7ADQDq1yPH7PGMPt
         qGwRWwJ+VmnGHhfpCWEE9Hphphk3HT2bXLzty+hhjxg/18LyGnyXGfu3otk55U/QSXvc
         FVAA==
X-Gm-Message-State: ANhLgQ3wwHUHliLo9SpK3s2lrQ6FRvGMiFXSYHcmUVjSB6fNW7elR1IP
        BPiXpMuI5Lh9F74kYyFhVL0=
X-Google-Smtp-Source: ADFU+vsS5KiJCU3u790VoKYOUkboPasr6G6il/55PNJnytScZCIzv4iI8x7Dyh/tFk12qggdPkw9hw==
X-Received: by 2002:a37:b903:: with SMTP id j3mr9406595qkf.62.1584041138942;
        Thu, 12 Mar 2020 12:25:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::fec8])
        by smtp.gmail.com with ESMTPSA id f16sm1124454qtk.61.2020.03.12.12.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 12:25:38 -0700 (PDT)
Date:   Thu, 12 Mar 2020 15:25:34 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [GIT PULL] cgroup fixes for v5.6-rc5
Message-ID: <20200312192534.GI79873@mtj.duckdns.org>
References: <20200310144107.GC79873@mtj.duckdns.org>
 <CAHk-=wi=5p6s_BmPAg5EF8Joe5d-6iAjQq6-Le7+xf5Gq-ZTfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=5p6s_BmPAg5EF8Joe5d-6iAjQq6-Le7+xf5Gq-ZTfw@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

On Tue, Mar 10, 2020 at 03:14:13PM -0700, Linus Torvalds wrote:
> On Tue, Mar 10, 2020 at 7:41 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > * Empty release_agent handling fix.
> 
> Pulled. However, I gagged a bit when I saw the code:
> 
>         if (!pathbuf || !agentbuf || !strlen(agentbuf))

Hahaha, yeah, I can see that. I think it might have been copied from
the commit it refers to - 64e90a8acb85 which contains the following
snippet.

       /*
        * If there is no binary for us to call, then just return and get out of
        * here.  This allows us to set STATIC_USERMODEHELPER_PATH to "" and
        * disable all call_usermodehelper() calls.
        */
       if (strlen(sub_info->path) == 0)
               goto out;

> Also, wouldn't it be nice to test for the empty string before you even
> bother to kstrdup() it? Even before you

Let me restructure the code a bit.

> Finally, shouldn't we technically hold the release_agent_path_lock
> while looking at it?

The release_agent_path is protected by both locks - cgroup_mutex and
release_agent_path_lock, so readers can hold either cgroup_mutex or
the path_lock. Here, it's holding the mutex, so it should be fine.
IIRC, it used to be protected by cgroup_mutex (or whatever was
equivalent) and the extra lock was added to break some cyclic
dependency. Hmm... might as well drop the cgroup_mutex protection and
always use the spinlock.

> Small details, and I've taken the pull, but the lack of locking does
> seem to be an actual (if perhaps fairly theoretical) bug, no?

Will queue cleanup patches for the next window.

Thanks.

-- 
tejun
