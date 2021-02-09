Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5235B3158DA
	for <lists+cgroups@lfdr.de>; Tue,  9 Feb 2021 22:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhBIVny (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 16:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhBIVMp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Feb 2021 16:12:45 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14102C061797
        for <cgroups@vger.kernel.org>; Tue,  9 Feb 2021 11:12:32 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id a17so23885292ljq.2
        for <cgroups@vger.kernel.org>; Tue, 09 Feb 2021 11:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4FXGsIN5T7fPPrN05ehbZdpVJVDuk872+BL495X4FDE=;
        b=YvBxOcvDEJCqlebLaBfz/mFH6WfvwNvw+jQhAqduaI6hWBxU9A7ZskYOCf8zcRNuUL
         LNbWWsUWHTLKYRhFQE7ZkmHbXyvJranSr8hnyxgHcM87KHuoJ9eUsuztqw3ewH1h8/DU
         9YcegKtpf6/jTxL35RfgKtx9Rd1OBpJeO/ouB0m3udBtiglWVl7Lp6l3JA8RS47w9/J0
         2dhI4ZOMi9bgsIRYK+d8DIvW4DTc2kMjCcTmIbo41C8RoVDL5ru3Dpa/g6a8Gvbc9xNu
         PW6i+H6yvplDmsMMShk7HQ2tWFn96BXZ/4i4IcP8Nqc4o2ryZiRU0xfEw8EQ6+VEYUY0
         L6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FXGsIN5T7fPPrN05ehbZdpVJVDuk872+BL495X4FDE=;
        b=imOAVZM3XnCmbAkzkaPu1qWFdQ4KlgOvkppTuHQ0PlEq9J5DDETaB37X4cY5uFjDTl
         cS5aTO0zgBn4piz9q7maKsG2foO2x8HFlxzuRLDvWWw1Y+oqrdnLhnfNyTZv5+UgJvq6
         kx2VNlMbvAqQYD46VnFYI0xUAGbn/8KkIJy/3kFkKv4Mga0wP/FpqEAZoQGkEtkEXlKm
         n7m6gpQ1fsoZYwbfZefcrg88cRO7WeDrkXGEDIMNXnST7Y6sOEePc/j9R69vYaljha/b
         +15LWI089ogYBQFUJFB5l3kYWh27uX70ctjckzxVnKc2EY+azOjqu8EtUnWF/LxVlXWO
         SWJw==
X-Gm-Message-State: AOAM531uKwS9DUt84reamfqZ+4KMeVvvyniI8yvlzdCkGRr13r6g0go1
        5M9BEJVSc8/EKJUtp3raLG8izXCEsZpqf7r5Oa9FSQ==
X-Google-Smtp-Source: ABdhPJwRFIwCydh144unLEXq/89Cii4bpddgSvF/jg/HdpgT2MwCFjxuenRx4CQBFhn3OdU+YiCwBnjOx79WfCp2jHY=
X-Received: by 2002:a2e:9801:: with SMTP id a1mr16081470ljj.122.1612897950233;
 Tue, 09 Feb 2021 11:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20210209190126.97842-1-hannes@cmpxchg.org>
In-Reply-To: <20210209190126.97842-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 9 Feb 2021 11:12:18 -0800
Message-ID: <CALvZod6jd5+H0jr8wyB_ivPcJzSYH-rCCQL64Hgg+D_wuAZZFg@mail.gmail.com>
Subject: Re: [PATCH] fs: buffer: use raw page_memcg() on locked page
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 9, 2021 at 11:01 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> alloc_page_buffers() currently uses get_mem_cgroup_from_page() for
> charging the buffers to the page owner, which does an rcu-protected
> page->memcg lookup and acquires a reference. But buffer allocation has
> the page lock held throughout, which pins the page to the memcg and
> thereby the memcg - neither rcu nor holding an extra reference during
> the allocation are necessary. Use a raw page_memcg() instead.
>
> This was the last user of get_mem_cgroup_from_page(), delete it.
>
> Reported-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
