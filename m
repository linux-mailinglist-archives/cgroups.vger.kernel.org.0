Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F68C652772
	for <lists+cgroups@lfdr.de>; Tue, 20 Dec 2022 20:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiLTT4r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Dec 2022 14:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiLTT4V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Dec 2022 14:56:21 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD8A1AD8D
        for <cgroups@vger.kernel.org>; Tue, 20 Dec 2022 11:55:46 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id b16so14236619yba.0
        for <cgroups@vger.kernel.org>; Tue, 20 Dec 2022 11:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T6Ibv8lELNGtBRxXq2xqbZ6XNIWdISjKd5l36khEMAE=;
        b=KSZwcjFTFFO55WSmVmRgONnRwskWoYawCL4xr2GcTp5EfCyO5dWsx7AbSD6Ir/ybby
         C7hVXroJGbjMZ6JZecHbZizIkqMntO9LCfTQjh70KYV62x3n7GT3pigY+IdDXJ6+hW0U
         mEwxE2cJuzhZ473p3CRLSLMKt5y1k+WqODiXLaurmLprlQIu83KIRui/7aB62vVSerFG
         oJ6BbA0p2cayN9RAavaPE83CL3JFmwg8mr83/EY4R4NMFXcDSamu5fqDMXFsJi4+yNTL
         KYFBpfYMu9bW5ttoTGe9B6d7fqichfkqe1iiFZLjZZbtB+BAkuBEyxDREF+RcnvyviBH
         sPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6Ibv8lELNGtBRxXq2xqbZ6XNIWdISjKd5l36khEMAE=;
        b=iB5vMPu8Bv50DYazuwBZsD8oAuU1UJ2sVRa4G2ibW25t/PHlAu28CDbEPk5oqbHXzm
         lS+iNOPEFBKwzQaiZOUem6trhwgaHxUJFxFuWyMkN/p3Xa0TcMI0DkTr0ckJTkaM+aS+
         jbrc1pWhXRuJWkPk0Rc+ATkGOpxdHp43LN3anPjzwu0FXzYVUQyV+qDyN9OojzPv16xK
         pWWlKolNclqIfoplJ+SpUUNt4jcM4P2nfeui7JQRWkLpX38DxZAWPyMb7FEbtM0DYWE9
         2m5xE0YA6bAYsY5OY7BCSkBDY+vlmWQ/enp3LNcFiUWZBq5STGvE0OU/lONmFlp3DGP9
         CRHw==
X-Gm-Message-State: ANoB5pnBtNPmcnPPSqJHT05XquwfmKpi4O+QG/KsL5aBK2CkH6FQSKNE
        N9gCr4+r200HdNATtEgAiCIeOqM0HAlqoSHyuVt82Q==
X-Google-Smtp-Source: AA0mqf7NCtlgUgNd0Hd1SP3QL7km2fBfAOvVUDERTH4v4MYwU6+4xOVJ3IJ4IDEzTj4uQn7xjEc4O/4GfJxHa4RW258=
X-Received: by 2002:a25:5047:0:b0:70b:e651:d1e6 with SMTP id
 e68-20020a255047000000b0070be651d1e6mr6047265ybb.363.1671566145422; Tue, 20
 Dec 2022 11:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20221220182745.1903540-1-roman.gushchin@linux.dev> <20221220182745.1903540-2-roman.gushchin@linux.dev>
In-Reply-To: <20221220182745.1903540-2-roman.gushchin@linux.dev>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 20 Dec 2022 11:55:34 -0800
Message-ID: <CALvZod5q0koAckpTr4VBq-_KiQpsmC86bE4eP9gzX71PzRdicA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] mm: kmem: optimize get_obj_cgroup_from_current()
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 20, 2022 at 10:28 AM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> Manually inline memcg_kmem_bypass() and active_memcg() to speed up
> get_obj_cgroup_from_current() by avoiding duplicate in_task() checks
> and active_memcg() readings.
>
> Also add a likely() macro to __get_obj_cgroup_from_memcg():
> obj_cgroup_tryget() should succeed at almost all times except
> a very unlikely race with the memcg deletion path.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Can you please add your performance experiment setup and result of
this patch in the commit description of this patch as well?

Acked-by: Shakeel Butt <shakeelb@google.com>
