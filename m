Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF1536BA28
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 21:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhDZTkj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 15:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbhDZTkj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Apr 2021 15:40:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55457C061756
        for <cgroups@vger.kernel.org>; Mon, 26 Apr 2021 12:39:57 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h36so35870323lfv.7
        for <cgroups@vger.kernel.org>; Mon, 26 Apr 2021 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uKTFMl2K/jBtlUdprMSpQyuu4jIlYrjBFVJg7lJPhEk=;
        b=QLHlSH2LL9uXh4sy9QtauiXaoF8OnWxtk9QCSh8791OUvFB4sYoW8jVjCMkGTrtcQL
         FrGfNwUH0L3V08sKOzFRiJBbxgvswr4ji3xy0XAO/ufgHwMRGO6lR3COBApdiOIM/wk5
         POZkZIlQVZuug1Bn5mrxSe11DlrX+WEBcb3+u5Ut7b/ygHXvPDZutuvyEZ7HLinkTewW
         ISOX6S3OTcWbJyAX2Us30EFYhEOiff5QHkx6fv3pKd5//JiqcTwxKiS1xZfFqNrVY4K4
         it/m5g7kX04xUv8RCDAMnDfVccezvq8wz9ORMKhwhg9p6SAxNBLtvy4KiSRqAZSu+wuD
         JM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uKTFMl2K/jBtlUdprMSpQyuu4jIlYrjBFVJg7lJPhEk=;
        b=Nhrs447ss4xmG+9VJG5pReTxalv7UgfpuJU9qykKc0F2Lm63W6f6w36UCWvKvcStr0
         t9gPlE7ltWTA9IgHrymP4qcG7js+Yh/4R/YaQc2SRSbzCsGOlfFCjL5tbzSCeN4l48Qc
         ZlpfJfz6kY63a90nzRmTODrSWfJCHulgH1GS4mVCFCgar+5fqgys9IzfxgUF2yJd7xjs
         CLzgTWYxaPNwMLcectvQb7PyKx2xyFpTDt+iioFOy5mJ2M43r/UqxOkh/GMm9h4Q0lLg
         hxm2zgC1xOwoCaPU4E9HYpXiiI6HbqGkrLi2h88P4lpgs9ZmDgPPwWkvz7MuxsfpTYIx
         Cznw==
X-Gm-Message-State: AOAM531/v4iDfhbMMDULDPTc3iK8kc20uK1VF9dHcM+8fdy0o220lWJA
        qhsubhaIr6NISno/8e2WGzLyBjaNBglp5HQc7i4+a8MNwko=
X-Google-Smtp-Source: ABdhPJxuQA1Y5wY99wy7C17n6eTxD1SMFnUX6rYc22m5KHJz1myuJrd/hnlyB35vGzrj9l9cBTvJ5Tb/WNk/8ky1sRs=
X-Received: by 2002:a19:ed11:: with SMTP id y17mr1253321lfy.117.1619465995569;
 Mon, 26 Apr 2021 12:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <7b777e22-5b0d-7444-343d-92cbfae5f8b4@virtuozzo.com> <8b6de616-fd1a-02c6-cbdb-976ecdcfa604@virtuozzo.com>
In-Reply-To: <8b6de616-fd1a-02c6-cbdb-976ecdcfa604@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 26 Apr 2021 12:39:44 -0700
Message-ID: <CALvZod5uw+f5dY=dUmHvdRq-4OfJBQ8zqjT5rZzpKtqQoy+28A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] memcg: enable accounting for pids in nested pid namespaces
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Michal Hocko <mhocko@suse.com>, Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Apr 24, 2021 at 4:54 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> Commit 5d097056c9a0 ("kmemcg: account certain kmem allocations to memcg")
> enabled memcg accounting for pids allocated from init_pid_ns.pid_cachep,
> but forgot to adjust the setting for nested pid namespaces.
> As a result, pid memory is not accounted exactly where it is really neede=
d,
> inside memcg-limited containers with their own pid namespaces.
>
> Pid was one the first kernel objects enabled for memcg accounting.
> init_pid_ns.pid_cachep marked by SLAB_ACCOUNT and we can expect that
> any new pids in the system are memcg-accounted.
>
> Though recently I've noticed that it is wrong. nested pid namespaces crea=
tes
> own slab caches for pid objects, nested pids have increased size because =
contain
> id both for all parent and for own pid namespaces. The problem is that th=
ese slab
> caches are _NOT_ marked by SLAB_ACCOUNT, as a result any pids allocated i=
n
> nested pid namespaces are not memcg-accounted.
>
> Pid struct in nested pid namespace consumes up to 500 bytes memory,
> 100000 such objects gives us up to ~50Mb unaccounted memory,
> this allow container to exceed assigned memcg limits.
>
> Fixes: 5d097056c9a0 ("kmemcg: account certain kmem allocations to memcg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
