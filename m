Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 217661669A8
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 22:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgBTVPS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 16:15:18 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:38906 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgBTVPS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 16:15:18 -0500
Received: by mail-vk1-f194.google.com with SMTP id w4so1617125vkd.5
        for <cgroups@vger.kernel.org>; Thu, 20 Feb 2020 13:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtH6MBxxbzar9OipIWWKPkk5V8ZZykX/4RLjsMCgSw0=;
        b=itJvvjLTjnAztaW3ELzLWWOItRSpx0VEbznSWQRD2w5LWICCqXBPNEHhDU5rFKFP6Q
         vuyEYtotOdCIFIz1XJec20kXLy25/JiQ6uw+0bgl/zEfBCQyL6qIxrsqZdnFBw+0pOa6
         dhuSeGnzbUKkl20/CUxAFyxo57oxShrr081lqlT55iOBkdQo+UkLgySNpVO0kGfAe3h5
         PMbTsKhsLUG0Oh3M0J9t4j+UdalOyoi/arcDlydpv0KIHUjajmBRd+IRjc3Ds7lsHaBK
         OQOIgksxwxaYbkPodvrysTB+g9laG5Peu7Mo06tw+vP91Kj31rabF/tyoXRamNVQmH2F
         8CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtH6MBxxbzar9OipIWWKPkk5V8ZZykX/4RLjsMCgSw0=;
        b=Nzxo2AN+D6pjpLDKW+kjgXE1yzRXTwUvHUaG8qJ5m+x6riRgJbqvkEu+s1GaTEexWC
         QlO6Z/4sdpucnsgh5Rc+r4ZlkMnb6l8Z0hz6ifaZ+6KezVJz2Z+xq1UZOYub5uBzsNVb
         OcESB1WDsXC2kwN/agNWvjm5sXF6o75xgQJ55G40UaqwUHQ5PTktZrPTP7yUY3ZKM5YO
         do9hIyQ1LDbhZO6aZguVr06U5LjcZXfZMrDPMjsTXtUtK0p8Ic00/CGhF6GJlGPw9W81
         rs9xPhchytjTQfmxkPISNlJRDWDcyYAP5Zp5ne7GKeoVxKhHZLazEyXzOhfbo7S3TLAf
         k78g==
X-Gm-Message-State: APjAAAU7MzwSpYmW2fzR2Q6f3kwhvSUm/v6uw0uTei0m9Bph5Cmyk5pT
        nt+9KYyHwoqPtcl8pJUlhbrTtUXm6kFUnB0yEP1XpQ==
X-Google-Smtp-Source: APXvYqyCkkbwdY7/IDGLKw691E2mNt/d2lLCEjoEG68m8sSXMR34k1Di0Rm7ufY66/tPsJ4DsT/vqWsRb+qu0brj+04=
X-Received: by 2002:a1f:ee45:: with SMTP id m66mr15468181vkh.75.1582233316395;
 Thu, 20 Feb 2020 13:15:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582216294.git.schatzberg.dan@gmail.com> <0a27b6fcbd1f7af104d7f4cf0adc6a31e0e7dd19.1582216294.git.schatzberg.dan@gmail.com>
In-Reply-To: <0a27b6fcbd1f7af104d7f4cf0adc6a31e0e7dd19.1582216294.git.schatzberg.dan@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Feb 2020 13:15:05 -0800
Message-ID: <CALvZod4OJhoLQxHeUKwN4FC-W0YnSpQCb5ZAwOef0rjAExtw5w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: Charge active memcg when no mm is set
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 20, 2020 at 8:52 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> memalloc_use_memcg() worked for kernel allocations but was silently
> ignored for user pages.
>
> This patch establishes a precedence order for who gets charged:
>
> 1. If there is a memcg associated with the page already, that memcg is
>    charged. This happens during swapin.
>
> 2. If an explicit mm is passed, mm->memcg is charged. This happens
>    during page faults, which can be triggered in remote VMs (eg gup).
>
> 3. Otherwise consult the current process context. If it has configured
>    a current->active_memcg, use that. Otherwise, current->mm->memcg.
>
> Previously, if a NULL mm was passed to mem_cgroup_try_charge (case 3) it
> would always charge the root cgroup. Now it looks up the current
> active_memcg first (falling back to charging the root cgroup if not
> set).
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
