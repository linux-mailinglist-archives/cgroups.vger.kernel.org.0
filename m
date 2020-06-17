Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C568F1FCF1B
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2020 16:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgFQOJG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Jun 2020 10:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQOJF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Jun 2020 10:09:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0661FC06174E
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2020 07:09:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so2473496wrs.11
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2020 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q/YL4Tzx4ADMiyqvj4Ve2wziFTGT/p0DVcYFG6HXk08=;
        b=d+J+aw6Zm5XRvlxRf1UGsdkDdw/4mdWlAseuLVRmjuRl77imTs8xnEwfCx3+/GfmIn
         bikdBwRjyQV2FhPxZDoxaryjSxXvxqhpXbUEuGGRJ6XKTOw9aHhfZNDGhlxVfd4s8+dB
         zPJBHP+Y5JfMrXFtfl1BiiRwc2CLhSP1/aSVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q/YL4Tzx4ADMiyqvj4Ve2wziFTGT/p0DVcYFG6HXk08=;
        b=kANlrAdva6kTcsREAztMro2gr7SbKSOdRmyuPc4Q1SpvxtS4ZWhmqQMx6CK10EUMMp
         5Me9MbX/dG/8OhDh7Ql1DxipPjAVQNvtsGD4QpirR239S9xVSt/XYdBG9ItMwPE/bs52
         jKuIZyzGQ71pwY2Wcy1XV6yhxiuHNh6j9rOti9n5wfJ66kCqBgXx6lGXQWkGdsrH7nvY
         ozJqwlQwhcfPh74DC4CPjVv+170RC8T3/eRwp8XIcB82uTZr0NGXQ6UbgxRvqeZoF9AA
         WLuU6Ut61IYNtgJWjdGsHyEq75SKmDKkp3Kt54ttgEMUX+0dbxx5zz7lW8d2dfi/RFrB
         6Z9Q==
X-Gm-Message-State: AOAM531HeL6CSR+lKaX3y/bvNwTJ0h+XJciVRK323imMFuaUBxWvKXfJ
        bitPyhtfX4b7P5TXBZMXRN4Kpg==
X-Google-Smtp-Source: ABdhPJzL0eIzzTI+SzZBoqt3/b7Xundx14ukkyOPthT2L2+/VFT7bPwecalJL/jau7TXAMBO1wA5IA==
X-Received: by 2002:adf:fd48:: with SMTP id h8mr9338191wrs.226.1592402940724;
        Wed, 17 Jun 2020 07:09:00 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id o6sm33035118wrp.3.2020.06.17.07.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 07:08:59 -0700 (PDT)
Date:   Wed, 17 Jun 2020 15:08:59 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
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
Message-ID: <20200617140859.GB548179@chrisdown.name>
References: <20200519075213.GF32497@dhcp22.suse.cz>
 <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
 <20200617135951.GP9499@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200617135951.GP9499@dhcp22.suse.cz>
User-Agent: Mutt/1.14.3 (2020-06-14)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko writes:
>and it makes some sense. Except for the root memcg where we do not
>account any memory. Adding if (mem_cgroup_is_root(memcg)) return false;
>should do the trick. The same is the case for mem_cgroup_below_low.
>Could you give it a try please just to confirm?

Oh, of course :-) This seems more likely than what I proposed, and would be 
great to test.
