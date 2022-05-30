Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEA953855C
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 17:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbiE3PtU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 11:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239498AbiE3PtF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 11:49:05 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4564D242
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 08:06:46 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-30c1b401711so49339297b3.2
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 08:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Af0PSK5bhyw9+f+5DkDwRAOmIX0S8zU96NIHBAioFvc=;
        b=IIUreoS7YFV8tvzCexC8C65TTMCRXB26Hzfj1WudjM4xZIb+eJy1GTgJE7v5pBwaLi
         BfFwoQfmw0ItOSvZ+sEnt3bkqNXDBUPKLLBxZYnVZ7CVifzBnCPIaIWhGOdfabqXH6w6
         clYvnNL18cS0xSDtPHaLcVdPriA/r2wd9ac0t2vHh49MxZH9oyXzW4AAhyUp01E1GQgC
         xk4YuwgEOBgnf70nSpzqvHu6gYJEaiAdXTCaZJPXM+hB3/Y3r70sL6YmOueUYYT3nasr
         DxASAvBlFVVTn5rcZ73N1fwxFgdkwVWpRVMEJ0L8Fakf/zrEUGEGZmaeHUFX/49dPEyp
         yung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Af0PSK5bhyw9+f+5DkDwRAOmIX0S8zU96NIHBAioFvc=;
        b=nDXWOaTQkVyDBCVtEF/JyOGTJjOpCgMYj+LDLs6ZOpQaoblf7NqWKOJ/owHasuiqFr
         IU+7uVQuponFFzA0ftomwE+JYsJW0OUh+bhTQrevX84nTDdkezxLkdQpj59bnIRZPhFQ
         MwYY+FGaHfryyyGIXdliXTLrXgMUVA4nHm53bQZY1egCAJqix41ezDMFnbGFW4wciiHO
         FhUMX28SF3RHrfnU8shU9iVwkV1Iie5VY3QHkW8GPCeIiEJ3XDlroE8h1MFHMAY7eFxD
         gjslrlWWpL0WrkQyqSU1Zh4ASwuCWFSqGlzEAz0fc7SIKdDDbdUl4VGlyYTc/ycxzawa
         flwg==
X-Gm-Message-State: AOAM530NjlyNZyF4aXxmbBrhgL7/tJTBhoxKnUkVbOr+nV7yFvOfex5K
        ODNpi9b7GvE65qM6A2sULu9R8EbL06gsWgS5ZgXyWQ==
X-Google-Smtp-Source: ABdhPJyJAZSC9ENEzIbG/yOmn6yYK1ICiFZC4ZHfMlFBMNg/VcShoecGpOOZej8r8Sx7xI8MjtkdpYAMhJxG9ks/ORo=
X-Received: by 2002:a81:1f84:0:b0:2f8:6138:de59 with SMTP id
 f126-20020a811f84000000b002f86138de59mr58340971ywf.31.1653923205877; Mon, 30
 May 2022 08:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <06505918-3b8a-0ad5-5951-89ecb510138e@openvz.org>
 <cover.1653899364.git.vvs@openvz.org> <a1fcdab2-a208-0fad-3f4e-233317ab828f@openvz.org>
In-Reply-To: <a1fcdab2-a208-0fad-3f4e-233317ab828f@openvz.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 30 May 2022 23:06:09 +0800
Message-ID: <CAMZfGtVv93QUmLfjzth1pxxFij8h8z3rH31a59Zov-7B-nxC3g@mail.gmail.com>
Subject: Re: [PATCH mm v3 9/9] memcg: enable accounting for perpu allocation
 of struct rt_rq
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 30, 2022 at 7:27 PM Vasily Averin <vvs@openvz.org> wrote:
>
> If enabled in config, alloc_rt_sched_group() is called for each new
> cpu cgroup and allocates a huge (~1700 bytes) percpu struct rt_rq.
> This significantly exceeds the size of the percpu allocation in the
> common part of cgroup creation.
>
> Memory allocated during new cpu cgroup creation
> (with enabled RT_GROUP_SCHED):
> common part:    ~11Kb   +   318 bytes percpu
> cpu cgroup:     ~2.5Kb  + ~2800 bytes percpu
>
> Accounting for this memory helps to avoid misuse inside memcg-limited
> containers.
>
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
