Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998831B37B0
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 08:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgDVGmk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 02:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgDVGmk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 02:42:40 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2075BC03C1A6;
        Tue, 21 Apr 2020 23:42:40 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w20so557984pll.4;
        Tue, 21 Apr 2020 23:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S4cmeJAIuJsYF1bOsD5QwAHBqMKC5f7P2yKTwX1eing=;
        b=GR52RWOyldaSx357kZpZdrxC4uXtpKfxWUcbhWtyoaAp4JIHvfVF5VJQGQwTjuY4GJ
         u+8Qyb9dA5RWz+ubh4UOpwTgoATfhFJmsw5LqmO+ImgXEYmEHFrJMQyuVC9iJ0/ubdq2
         fO0XZ6N/s1AnByjQyF33SGwwJPI7z96k4FpKJAHW9ZVME99CzXeXftQkDnzmzmmAHbbY
         iPVZrYtO1srOpH4Xn/Kqn4S1TfKxuCQIT/dKY0BDFM9jy4aAW8C2y0/Eqo5uhVVQ9VPE
         9cPEQKyDpRNvgzu3oGG5oJ7l0/KXEOdFpyoTC+hvoKVdiLiZxAcZVA2T0DLEeRljdTHk
         okPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S4cmeJAIuJsYF1bOsD5QwAHBqMKC5f7P2yKTwX1eing=;
        b=VKTwkAAAg2/Bze/lpkcI34IssBgimLzVTinRNzdBD637XGDIq3YyO4Y+5ftdNp2rt5
         lP0gSzZK/XWvky/5odjEhNfqou/fczBNYXo89nXEcXrQtsib/TPEBiyUIkWPrTO5jZgL
         uGUVuI/mraztKGp3zOSPMyX0LF6qo2RKidQlYJvnbVJWS1If5uSBNjWI5xDr+vl9INJg
         FZ+vmuPP1sUHaXM7cUUK6Uf11Xt/km8wjOGj1ltq6n3qam1IPljboB+46Rf+GXFAdO5A
         fWMYQ7YJSeZAtiMXBKfmVSLHfPHV+5Fam0AZm/g0iv5Gvovjw62fuyliQsbjhCyFHPTZ
         kvig==
X-Gm-Message-State: AGi0PubUsb1h2pdwZcJV+fzzkadAOR/HFtpWsipQRCDuW5XJXpvJvFTP
        n6obXfvMxkP5vFYNZrh3Dmc=
X-Google-Smtp-Source: APiQypJv/sDcb8i798JjJTM4g48OpHyrU1KCVVws9P1AhaEYCMG4dLSkTwe4v887cgshTzrpTowVcQ==
X-Received: by 2002:a17:90a:a78f:: with SMTP id f15mr10323985pjq.120.1587537759679;
        Tue, 21 Apr 2020 23:42:39 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id j13sm4378632pje.1.2020.04.21.23.42.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2020 23:42:39 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:42:34 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 09/18] mm: memcontrol: switch to native NR_FILE_PAGES and
 NR_SHMEM counters
Message-ID: <20200422064233.GI6780@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-10-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-10-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:17PM -0400, Johannes Weiner wrote:
> Memcg maintains private MEMCG_CACHE and NR_SHMEM counters. This
> divergence from the generic VM accounting means unnecessary code
> overhead, and creates a dependency for memcg that page->mapping is set
> up at the time of charging, so that page types can be told apart.
> 
> Convert the generic accounting sites to mod_lruvec_page_state and
> friends to maintain the per-cgroup vmstat counters of NR_FILE_PAGES
> and NR_SHMEM. The page is already locked in these places, so
> page->mem_cgroup is stable; we only need minimal tweaks of two
> mem_cgroup_migrate() calls to ensure it's set up in time.
> 
> Then replace MEMCG_CACHE with NR_FILE_PAGES and delete the private
> NR_SHMEM accounting sites.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
