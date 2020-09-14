Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00B2268306
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 05:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgINDLM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 13 Sep 2020 23:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgINDLD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 13 Sep 2020 23:11:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A3BC061787
        for <cgroups@vger.kernel.org>; Sun, 13 Sep 2020 20:11:01 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so11373644pfd.5
        for <cgroups@vger.kernel.org>; Sun, 13 Sep 2020 20:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOjlPnEGfverOe/NjTfHJ965zGyyw9hgsDwthm8fBO8=;
        b=uWCczg2zelk3J2BSLQ0zws70nqO2Qrj0gvnO2vtQuHmsmUewjkzP6BOyKhWOf7bsi8
         UxCD19k7Z758PpS4M50tNgLTQwxa9bOY8iPkIfDyrjLrEFk4nSL8nUc3ffp6wzJc6nsb
         E03dGwR/aCB100q8leNRNfS4ITrdZTJe/8y1gqWskcEYHWYUhYK8GHzuPEWBD7TsiZyg
         kt40GXGfTlyabPEXkpvLvGwXQ3qPFXMzZ/uipyK3nqbnpikV+i+cl3SF6sBhLbbMLdyH
         7wQVgvUgWfQqg7oH4zJ5tY3mT6tIDnAqP4SAPXwI1/t1YyF1qL/qRE9vxh1J8fzllJG9
         vmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOjlPnEGfverOe/NjTfHJ965zGyyw9hgsDwthm8fBO8=;
        b=shkoT2q70r6PMFuhEyJg91Wvhxzqaoyn61E3DBXMluIMIdy8UHW+sygFfcHlDX1bHU
         HtUwMOb4xL4AtTx2PxSz1AuSxXKyDGBd4+xg7i2YIrN91x+FO5GLV84/VomBFnNPuKAQ
         MgF8+yRv9WAadKJh4TMrBB150YKQ3TfkxsJyu5k4BPFVRSgt+3pkJAlvhkpBFLUugMhc
         5EilTcnW30PwXBMdhYC8rabasUrNYrtWSycPjRz7adxlZPqopb4s0IjIm74bCY8VkGGL
         0XsGhr0K1Vo/rqiukj4pClsK9uRxyzkxId4FM89So0m4PjIW0lTnwGiLDw6DQVoqogpS
         R9Mw==
X-Gm-Message-State: AOAM530K9kmxlX2ScssCjJ9FPOLoJ8HaNEtp+IkrQmUCz6lNRyc8cvTF
        Ltfwt2ERO1T/x93QgaiUfpwNRkd7b38HW8o2bEdn8w==
X-Google-Smtp-Source: ABdhPJx4FxwJQZgfVBSb1/npUEzqRxM2ff4oVtXhlJsuhFTOCVKCUma7soUXDoNfMVUVcCe0LgqVZ4ylVmc3fCaZL+0=
X-Received: by 2002:a17:902:a605:b029:d0:cbe1:e714 with SMTP id
 u5-20020a170902a605b02900d0cbe1e714mr12582624plq.34.1600053060539; Sun, 13
 Sep 2020 20:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200913070010.44053-1-songmuchun@bytedance.com> <20200913170913.GB2239582@chrisdown.name>
In-Reply-To: <20200913170913.GB2239582@chrisdown.name>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 14 Sep 2020 11:10:24 +0800
Message-ID: <CAMZfGtVBFCodKuNKzG8TxKjeuC1_hF_YKdqMTmX5ENE_FfDmzw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] mm: memcontrol: Add the missing
 numa_stat interface for cgroup v2
To:     Chris Down <chris@chrisdown.name>
Cc:     tj@kernel.org, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>, corbet@lwn.net,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 14, 2020 at 1:09 AM Chris Down <chris@chrisdown.name> wrote:
>
> Muchun Song writes:
> >In the cgroup v1, we have a numa_stat interface. This is useful for
> >providing visibility into the numa locality information within an
> >memcg since the pages are allowed to be allocated from any physical
> >node. One of the use cases is evaluating application performance by
> >combining this information with the application's CPU allocation.
> >But the cgroup v2 does not. So this patch adds the missing information.
> >
> >Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >Suggested-by: Shakeel Butt <shakeelb@google.com>
> >Reported-by: kernel test robot <lkp@intel.com>
>
> This is a feature patch, why does this have LKP's Reported-by?

In the v2 version, the kernel test robot reported a compiler error
on the powerpc architecture. So I added that. Thanks.

-- 
Yours,
Muchun
