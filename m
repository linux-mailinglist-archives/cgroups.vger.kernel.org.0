Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C65F1B3791
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 08:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgDVGgX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 02:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgDVGgW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 02:36:22 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8DBC03C1A6;
        Tue, 21 Apr 2020 23:36:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o185so608467pgo.3;
        Tue, 21 Apr 2020 23:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CZSSzJnZ1MHzcmsWtWuWxkow51PnPw2IWZgspST+uVI=;
        b=ls5QfuFXXFiilf45USH7v+eQmuTJ3PHmJP7NplN6QLta76WP1KbKLw2xFzg1bKPU2w
         1uNvOi2bCmYUCIcqBXXs/uWK+5EQ5ffvG23l1PRQixBaa8YoNuph7ZYC0E2pKibWqQT+
         Kx1AJtKpffeBMLcBkSxf1Y5sqLCxT6289uSxh3vwNepMkHKeN/ufWMIOyFlm+fgvW/ue
         zuCTlvXNPDYcKZVY2CRsXxlhwYiCZyuPHEPGVdAlkToo0nRZpJcrUXWw/1SSm/oQLrWg
         OIQ61v4WXvivJqWuxywhk+BZasO3yh5ILcO+0jnXerym2Ch9CAjEZfsfE9PKDZSNOpNY
         2Qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CZSSzJnZ1MHzcmsWtWuWxkow51PnPw2IWZgspST+uVI=;
        b=k9wK3UtTBGp8zzkysM4mytECpCVI7QxsulksFot7jU4SfUWg4OjquP4aUxEC+lD/ZB
         0oZlHa7lZjUxFQ3Log8xvjZ+p7NDDNSDC2sgIip9g3d4emJLxgnJrFJySoJz91dzWyl8
         8QFzMgYthlEtCoGK9oNOk/EnOpHPAHnd7PuJBvVuKWtmEZTa5Lu2LJHWUQkmQBkQw38E
         +22heCXvMuC3LUy+HALgKxMN7/qUia5bThXj2c7D/lqpDEl0swhRQWKO6dapz5tL4oYP
         3aHlp4AxGzFGDK6l8VlYBzfIBmJtgnqCPRZxEPFZp4zMp43vJuH5ox98CroAoLtopjAk
         eq/A==
X-Gm-Message-State: AGi0PubQJfIDfdbaZjNSAypuddxkOuXR8waKeEDW+8tBYwOSBL2q80va
        f4cl08FaSGgfYZck/b97oec=
X-Google-Smtp-Source: APiQypKEUqPym2scqaXV1ZTWDTZ7tY6vl18nJKrpRtktlWWZ8saMfddCMHfSDtWe5c65ArLEBRnZXQ==
X-Received: by 2002:a63:6cc5:: with SMTP id h188mr24276969pgc.337.1587537382250;
        Tue, 21 Apr 2020 23:36:22 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id e4sm4197953pjv.30.2020.04.21.23.36.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2020 23:36:21 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:36:16 +0900
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
Subject: Re: [PATCH 02/18] mm: memcontrol: fix theoretical race in charge
 moving
Message-ID: <20200422063615.GB6780@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-3-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-3-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:10PM -0400, Johannes Weiner wrote:
> The move_lock is a per-memcg lock, but the VM accounting code that
> needs to acquire it comes from the page and follows page->mem_cgroup
> under RCU protection. That means that the page becomes unlocked not
> when we drop the move_lock, but when we update page->mem_cgroup. And
> that assignment doesn't imply any memory ordering. If that pointer
> write gets reordered against the reads of the page state -
> page_mapped, PageDirty etc. the state may change while we rely on it
> being stable and we can end up corrupting the counters.
> 
> Place an SMP memory barrier to make sure we're done with all page
> state by the time the new page->mem_cgroup becomes visible.
> 
> Also replace the open-coded move_lock with a lock_page_memcg() to make
> it more obvious what we're serializing against.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Thanks.
