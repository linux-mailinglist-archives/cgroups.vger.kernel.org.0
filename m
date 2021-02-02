Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388CB30CED8
	for <lists+cgroups@lfdr.de>; Tue,  2 Feb 2021 23:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhBBW20 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 17:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbhBBW0Z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 17:26:25 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDEFC06178B
        for <cgroups@vger.kernel.org>; Tue,  2 Feb 2021 14:24:54 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u25so30374824lfc.2
        for <cgroups@vger.kernel.org>; Tue, 02 Feb 2021 14:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXK8oq2DlbA7lyIsSaGTbwXFgGanxEu82dZ8lLRpgRw=;
        b=ABwNqw1tZfnQ+pjITPrqd6B5h0qyKE2MxWTXL9GsCi2M91XYgvXwF7Yl98c8LCnnhV
         /zXHZNkSQZbH8iPevzHgFl0+/BWPbH+9+aUkc2dL4Oc+W8jHh4vFJ6WvIMcapMqmaLIT
         Rbkd/ekRkrGWHJ9hMDQv5pG4d0jF7pdXi2DZhpZk8RUUSipEjBk0eJDul3rKfgl1bOrL
         W8pqkiA+BJJHTf1rYvImkuwiCJbpqq5EXP2UsyQvGjQp6zsDIUnSRqHvPu79JZHrdomV
         hjUVD8PLX9jOyTqvLZv0w29ni00p6EvVp6iQLrkqgrk7cEDz4ucCdkzm/Ly29omQXrZQ
         1GBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXK8oq2DlbA7lyIsSaGTbwXFgGanxEu82dZ8lLRpgRw=;
        b=GChFeCweT9pvUQkR8X4kd6aS9pWNo1CmEanu2mDMLmrfZmI2O9wsOluMkGmZVJK4kK
         Yv0FJfbDEoneK6WLP/ajMOO0MQvAvy8QXJdUD3aQ+5K6H9H1ftEESZgv5unQkKwIQDzX
         nlMt3CbuVyNhymU0PZ61bMXenu5NsYQHpuJWljyPCQNYfxK4GyiUMIUVbS8n2FpWBi/H
         wBif80VS3MlWEFMEp0vHqzh9Y6IYgNfJl7neJST/nKlSJMawqjTYxV479iwiehssjM6d
         Xo/0f5AbYcdIiZ9QmWg3wm7M8RYooLMrTdLEjZ4asJZDJljeD+uwh/stMkJ0Rr0Mo7Dd
         xLmg==
X-Gm-Message-State: AOAM533RwolWa68qohZgVUOxZtofRlvRZ7HfzDWJZO+zrNim14XQkTJk
        xQrVTBirQEt7Hm8Wz/+y+pyeGjKQD4FhuhXMtHgGVQ==
X-Google-Smtp-Source: ABdhPJzkI5c5KALserDCZjBWsZ+/3TOtL3G+pLbT+3aDT9MQkjoZGJqFjhW3meTCkwe2stg+3e9IILm9J90dTadxS1Q=
X-Received: by 2002:a19:4cc2:: with SMTP id z185mr54417lfa.83.1612304692735;
 Tue, 02 Feb 2021 14:24:52 -0800 (PST)
MIME-Version: 1.0
References: <20210202184746.119084-1-hannes@cmpxchg.org> <20210202184746.119084-3-hannes@cmpxchg.org>
In-Reply-To: <20210202184746.119084-3-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 2 Feb 2021 14:24:41 -0800
Message-ID: <CALvZod5LRn=c0RUQqTgSbnRS6NbV+9XNZi14MHxKSmYSXOnDSg@mail.gmail.com>
Subject: Re: [PATCH 2/7] mm: memcontrol: kill mem_cgroup_nodeinfo()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 2, 2021 at 12:51 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> No need to encapsulate a simple struct member access.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
