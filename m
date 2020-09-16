Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2C926CC17
	for <lists+cgroups@lfdr.de>; Wed, 16 Sep 2020 22:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgIPUjF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Sep 2020 16:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgIPRHy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Sep 2020 13:07:54 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E73C0073E9
        for <cgroups@vger.kernel.org>; Wed, 16 Sep 2020 07:01:24 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a22so5970854ljp.13
        for <cgroups@vger.kernel.org>; Wed, 16 Sep 2020 07:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FRVhtc4HDJxT3tTI+nfU2Ow8g0YNTmg1aLTrLZ5GLkM=;
        b=IW54L6C4ApDTRtMrNEJ761WHUDzNh6f0cykv+LQNw3a0CjeHsQ5WSlC5Rdd1ExMO1N
         9cCPBei85IFqoJiNivM/NsFjjRh0jMmXkZvXl8+m0RgCRmfbb0TDaCnnF+l+ISliosij
         42xhIIF5dTIWSliQDXT+pkI5fyEf/ayHu3Oe+m5BM/34X2OuEb+ump86QIYqpwjOVL0Q
         utbl8fBVgonNijf4+Ewdp5i0r8yGAwtjnqQrqxGFjRKnjSlI1VxDbO2bQgpDvt96hDmy
         9e+2V7Ns6VSmkb05MGw2jc+JMVAoe/cs/p230z+fFQn8RLdvy+31kVUd7E1C0vbywnX1
         A1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FRVhtc4HDJxT3tTI+nfU2Ow8g0YNTmg1aLTrLZ5GLkM=;
        b=JaSumJQPxGVy59EFM8uo/ZgXzplWFXvu9JdgCx0S3yZxewwmuqO8ZvKl0CtR3Jsnj6
         v60ABLk3QAKlryOb9v0B4CoxxqQpbjezJUYu4ZvwRNHwA7zTeDdzBcda7AN5Gv4fcivj
         Sii/nUvn0O43No9fF9a4pT4fBdhoQAfOIQfkzuwTZKdt8P85L9hCiOvxjVgdhFn611Zs
         03ib9ab+8m4cwZZA5EY/FW/dJ5+/SSXhGsLgCmhPtppZh+2+6iE/qBhIsgAZ2aF25/0+
         JkHIDab/v+M3j0xQzS/dmJSk1ZT3GtSslX6gAD67yPiGFUf1m5tEbFuf+u8pmECDK95+
         5r+A==
X-Gm-Message-State: AOAM530hG5yaRKZxinkS6DZJQEzX7MlUJCfgoUysl0CnyAsRNtNEI2cu
        SLe34iD7RrNEgJ46BWGb5EOeh93qO2baxY9H+Q1/gw==
X-Google-Smtp-Source: ABdhPJy/DTVcQ+MZ5ulLyFNlm25DBhllwomvUrKSO5bS287if90RTyimJrDNB1ExublVr5ZgN3rtY0o/m8FHLOOU8Ks=
X-Received: by 2002:a2e:b4f5:: with SMTP id s21mr8927547ljm.270.1600264883043;
 Wed, 16 Sep 2020 07:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200916100030.71698-1-songmuchun@bytedance.com>
In-Reply-To: <20200916100030.71698-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 16 Sep 2020 07:01:11 -0700
Message-ID: <CALvZod63j475FM1p_DLOEtKmjFZ=-RbGG0eL1zTH+j4VqCrAeg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mm: memcontrol: Fix missing suffix of workingset_restore
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 16, 2020 at 3:00 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> We forget to add the suffix to the workingset_restore string, so
> fix it. And also update the documentation of cgroup-v2.rst.
>
> Fixes: 170b04b7ae49 ("mm/workingset: prepare the workingset detection infrastructure for anon LRU")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
