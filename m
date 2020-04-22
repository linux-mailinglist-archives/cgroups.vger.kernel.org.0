Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148881B4C6E
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 20:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgDVSCi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 14:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726924AbgDVSCh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 14:02:37 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF305C03C1AA
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2020 11:02:35 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so3322920ljn.7
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2020 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OxPQfRGdb/9tZKOeYvx9nsO533AAnUsM72YkEAHTBCI=;
        b=MtBnqEYdd89iXzsWZUzdrGnwyjo111BKIiu7L3ZHWXsQEJMUCoEyKDRbJIyIbEZ0UL
         DV3+yaBUmM6gMxXui+ZOIe6OyD7VtRJ23975UXk+/Wj0COST+PbV9MJTROveWW0bw2T7
         GtXFKn4EezlfKVlwrZaFUmoy/J+Vyg0tVlz69s+eov79IvvYBC6QTV2+OAVc8P/TxcAB
         A8+D4KWyIqFJwYB36BbmoTeDFQv2oa4PzTVNJUV6suxSZPhHbZMiB3N4XCK8SMiAZedT
         H6oGGCppXSeyYI9Pa+3Rc/6Drhivl0uuWfd0hsHATauPrPn70QbuvXx3LUDAOw5klFM8
         xeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OxPQfRGdb/9tZKOeYvx9nsO533AAnUsM72YkEAHTBCI=;
        b=K/c24gQxEXMjkS7ZWrwsRvRj8K4SRW/oJcNojLGmWmoH016Jg0/oW5I/znDIQvuMy7
         ZdwW+/3rfQTkVuoMB7dU4p1EYuPsStDf9gNhb7qsGV+YWq5fAlE6D2t3ppNwAejse6Sx
         haB4wuQvr1xQ7T/3qbBXL7ba546vl1ADnuJIE5DMP5oBApkGoWPRG6V0tgcyZ41QCq+/
         43L5q8amUhbV7+tB0TCXyaYw/QyXYnQoL8y39jH9DBjDzHcq4yN21TsEJ5TJl+67leYU
         q6u3wsTIXf8KOaeOPMGQz9VF/BUtij5mLrWQeKLhiopo31AawF13Ryl40D6csdex68rc
         EBYw==
X-Gm-Message-State: AGi0PuZYK0Koj3gR36Iwoeg5Ox+n/8q2K8QMRMf2zyP6vtso1IQqGo/H
        aU/9qpAaDbekJmCy0iP7ari7vDZlXHAvMXyfjl9ZIQ==
X-Google-Smtp-Source: APiQypKntPoBdVTS/8WRMaXpnY/jdYe0MPd3EYScD5Cm/9aT/zP0pcWdgKz8DqlIB8lwr7cYH+N/ASnro4D3GssV3l8=
X-Received: by 2002:a05:651c:1209:: with SMTP id i9mr21615lja.250.1587578553958;
 Wed, 22 Apr 2020 11:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200420221126.341272-1-hannes@cmpxchg.org> <20200420221126.341272-3-hannes@cmpxchg.org>
In-Reply-To: <20200420221126.341272-3-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 22 Apr 2020 11:02:22 -0700
Message-ID: <CALvZod5XC+v_ThY=QyiXu9uWgkuc6x63jwUjW9mdWueoPh3LBw@mail.gmail.com>
Subject: Re: [PATCH 02/18] mm: memcontrol: fix theoretical race in charge moving
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 3:11 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
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

Reviewed-by: Shakeel Butt <shakeelb@google.com>
