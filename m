Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63D335D0F6
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 21:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245215AbhDLTXH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 15:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbhDLTXG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 15:23:06 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EF0C061574
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 12:22:48 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id v140so23250599lfa.4
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 12:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gd0dxflCaTKXdqbWxXEfT6HOfWboYzChFATjj4IIxDU=;
        b=KwSeQQinUU7zyo5Fv1JGk2xgxPkBqPeRGTDM5KlhEpSwkX/XmivjIkm0LJEPxZGVHO
         joO7arIl3VlPnxUWo8T2MkV9me/LsH/H2Z6sLalkVByWBszJ4jkA5pLzF8FjA5Andgiv
         wkmj7PcKXxQh2CnzxWgubF//q5lAaW/Zo4ebzkt3I4G3UaSLWfv+gGeURTDeuRncPMcn
         3O7ViH/4/EWgaF0jz37FDL3lPDL5xQoguc1AfxXdRdHrUTgFccWzvfnWPfVu0lcPhkFo
         31sxVTQkxdGuRuoQXfXncTjoCebtKW24RXa5qGmyOvST1FPonNKJA5Im+CL2FTRcImrM
         GZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gd0dxflCaTKXdqbWxXEfT6HOfWboYzChFATjj4IIxDU=;
        b=iaTXQ8q3MjKbRpiahc6+RE6X2HxgmfB55uxY9AmVdy3YTCDXBtzC4ajzIvGO7zCuQA
         DEw8qFQz7qHA2TjwxNDQ6U6zrv8l1QGJZE/1fIg6mPNb5OKhS9e7weEKzV5T+pMonYZK
         y9rDKeTWKeAAqrI/jFwcQOTxLeyQOA/bN3/GLfPFHpOjYdmEGx905AcvTRpue7kgOAJd
         AEMncdrQxoPBvu11OgQNdAkfNsUtfcMPI67Up2GiDWCQXKNyDc0ZW9anYdyQwTII4MKW
         0zqv4jVLmRjIZn5FZPPGQ420eMxL282aLchaMfu95pEI1O9Pq9wcB7PU8Jp+9TPg3HIJ
         8w+w==
X-Gm-Message-State: AOAM532cncYw7TiEDIdJA+avM/sEpbDBrJ1+wdnsKE5TDvf/KaLJGsWJ
        oJiVXzynRW5Yi5TvsMeriTwjYll0nZJGhYr/uD+blw==
X-Google-Smtp-Source: ABdhPJyroaK2RiYclmz6pzbGm8fFY4sD5rXEsikqbQYegIq/wuxdQyXAuN6/b1qwvpMONbNLZwNchnmwL6/Vg/OeeBY=
X-Received: by 2002:a05:6512:3703:: with SMTP id z3mr19675008lfr.358.1618255366497;
 Mon, 12 Apr 2021 12:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210409231842.8840-1-longman@redhat.com> <20210409231842.8840-2-longman@redhat.com>
In-Reply-To: <20210409231842.8840-2-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 12 Apr 2021 12:22:35 -0700
Message-ID: <CALvZod4MSrvSBJv3Kd2VC42BxQFNRhPaeM8AbCXXbkGOTfjRig@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/memcg: Pass both memcg and lruvec to mod_memcg_lruvec_state()
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 9, 2021 at 4:19 PM Waiman Long <longman@redhat.com> wrote:
>
> The caller of mod_memcg_lruvec_state() has both memcg and lruvec readily
> available. So both of them are now passed to mod_memcg_lruvec_state()
> and __mod_memcg_lruvec_state(). The __mod_memcg_lruvec_state() is
> updated to allow either of the two parameters to be set to null. This
> makes mod_memcg_lruvec_state() equivalent to mod_memcg_state() if lruvec
> is null.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Similar to Roman's suggestion: instead of what this patch is doing the
'why' would be better in the changelog.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
