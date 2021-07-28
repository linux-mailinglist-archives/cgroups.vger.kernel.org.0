Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0563D96DC
	for <lists+cgroups@lfdr.de>; Wed, 28 Jul 2021 22:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhG1Uhr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Jul 2021 16:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhG1Uhq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Jul 2021 16:37:46 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C12C061757
        for <cgroups@vger.kernel.org>; Wed, 28 Jul 2021 13:37:44 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id a201so6073718ybg.12
        for <cgroups@vger.kernel.org>; Wed, 28 Jul 2021 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wx12YfrHsQsDKjajWfKvfKfUSFEaj6kJhNDgZWYmtmg=;
        b=QfaWHqJDwQHVJXicJ8h1hGeUi7F2r6xmPRzW3TM7SqTNre4aIPa6Oid+LKkUmQuoYa
         hTKe1i6Kl4llnheG7hQwB5FKG8Z7iuRdOHJSP1lv0JuVE48SfIWX3TrQ7CZB+qcY9euO
         0Am/d96xgQ5QGG5MqmHO0Ggigrsc8Jo4v1cbMYjQukQBEKrfoUFuOlqIKBcsZyy0jtHu
         V7C1SQlrm9QF0LsyHsUfSmw33Y0SFtDdetgdYK3NirXjWa4fugAUfJd1Ook09gFLezlr
         gEu8tGenY41P0LTNDUqaLyGdDpTmNV7ztpPkIPovOboJAotIRxcoKsf7Bc9CVfXL6RA1
         5LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wx12YfrHsQsDKjajWfKvfKfUSFEaj6kJhNDgZWYmtmg=;
        b=J8GsM9DkqGmolX6uGmw4HWnrBhXgqa9/iFX7zr3EuyxWvZpZ+r0H+V7oGY5IiH8u9B
         W6rW+ZwG80BUJMcUAeXhztqk7CenpEzIuBrc7+PVaZGjPQ6a5gKOqYaLlvDxTNfG38LL
         KAtTlA+qsejSfVPAHDn+tK7McadATvOo0cxxdXAjnZxBisDp9njCCE3fTxhRLufCB/mB
         zHhEMvwfIIIbisy7NZGsyN7SMFRr6WRnDQVge7p3mYV5eEJdT9D3kSYHW7Gju2ZSg7Ed
         rI188ODJfeWTNc5wDQ2eDozHrULnziM+xiU/8gUcGOLC4Rc3Q3Oc+WUdCC5bwUDYCZ1f
         mhTw==
X-Gm-Message-State: AOAM531Xcw6YZb76kCnZX9NW2VBhMHw9/tSrrLYM2Tj+pA1b4sUpDm1o
        WBF7TfSkNVjH4FIYgR8scdUshOUt4OrgE4J1VtsNtA==
X-Google-Smtp-Source: ABdhPJy/v9JTpm3aTY0ZFIyJlt6f/3MhsxjB6GwADapmOn411nOwrQOwiJdQvAhg3g7WjlscqM0DE/54cZRlaQua4f4=
X-Received: by 2002:a25:8746:: with SMTP id e6mr2067674ybn.76.1627504663934;
 Wed, 28 Jul 2021 13:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210728012243.3369123-1-shakeelb@google.com> <20210728124326.a3e6cc29f670062185fb57d7@linux-foundation.org>
In-Reply-To: <20210728124326.a3e6cc29f670062185fb57d7@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 28 Jul 2021 13:37:28 -0700
Message-ID: <CALvZod71oM0=B_u6-fSMFBqwP2tEOgxKxygHkcshmNF-BMCwzg@mail.gmail.com>
Subject: Re: [PATCH] memcg: cleanup racy sum avoidance code
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 28, 2021 at 12:43 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 27 Jul 2021 18:22:43 -0700 Shakeel Butt <shakeelb@google.com> wrote:
>
> > We used to have per-cpu memcg and lruvec stats and the readers have to
> > traverse and sum the stats from each cpu. This summing was racy and may
> > expose transient negative values. So, an explicit check was added to
> > avoid such scenarios. Now these stats are moved to rstat infrastructure
> > and are no more per-cpu, so we can remove the fixup for transient
> > negative values.
>
> We can't do anything about the same code in lruvec_page_state_local()?

lruvec_page_state_local() is used by cgroup v1's memory.numa_stat for
cgroup local stats (not hierarchical) and are still per-cpu. To make
it non-per-cpu, we have to add 'long
state_local[NR_VM_NODE_STAT_ITEMS]' in 'struct lruvec_stats' and do
aggregation in rstat flushing. So, paying the cpu traversal cost with
more memory usage. I am not sure if it is worth it.
