Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A489374815
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 20:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhEESfw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 14:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhEESfw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 14:35:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74827C061574
        for <cgroups@vger.kernel.org>; Wed,  5 May 2021 11:34:54 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b21so3734165ljf.11
        for <cgroups@vger.kernel.org>; Wed, 05 May 2021 11:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K5BbP+PQbZDrsW3Z0I2K54qvJu7T8OT3Rig60hvbO1U=;
        b=vsqKdvcVbJzePaO2Rdkii7+aVDG4GsKFVmMNGiJb3HJ/5dEyks73H4moEQib1EV6+A
         iHzoGwnjHsbOh0Fx60YpVgWrLdjLsXZozOLaCv2o9F+RvKD5gM3ENd+K7zwidkabXiQO
         ZcLZVb1qh9Q3myp39yWjYo34ivvZWA1CXzpBqsomjfPx0nAFVzPOLLTmomuP7FGIZu0y
         N+Uv01Eanyf2MW5nTNqzBKWf4wJKELwo/6qUM12Ffienqd/MdEtWZ6+/zXHCsHLOCVIv
         cqwGpNFnkJq588E3Wo9tvTByYl3d+DETyi/C3tG3NvDk8sXW0i0OrMA9Z+uPM14dhoL7
         ltPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K5BbP+PQbZDrsW3Z0I2K54qvJu7T8OT3Rig60hvbO1U=;
        b=oYvhRGU0nGMeujr1C/BCmRXhlU3o6AXlCcvW+JJldgAeFSZL/h/hiBxFCwcc5uLE9F
         NmYQOzOWGKuNUty38UDAskJdV4KVAdU/OQ881014WIUqp39RDWSRucqif3Is5HQ/NQlU
         ncFMvbVjMio2xIpd8xoCDJNdoyCd8NWswVwA+zXyCMhppZm+Nj3saTV+MoqREdHi+9Jz
         saJSZuxRQUJjkVFmrU6LWE/aC3uvlKl7L2Ii4m2IWGKat0k/Wulnep5agngQDxlcHffH
         0+HHeu1PuJD5Tz/lo2de0GKShvYjlYjORWjilyi36ogFnzteJ9gAp9q7raVjCDS5zbIR
         LfuQ==
X-Gm-Message-State: AOAM533A+uhKgtUsADLL1I/1+vmhmQcV7EokSv2ClUD1R3fUg68R9l0L
        GRWRHWHPiddmk64bWlsvjWkLBV9VluuQFa81JxNn9Q==
X-Google-Smtp-Source: ABdhPJz3lGLBPV/4oLmS+bGIyVdlZtU+Arlag7ythkobyL2FIaBIb3EWl0k3+KFXHEcIuYfSFDkRXBgjSKUIYV6Y8S4=
X-Received: by 2002:a2e:8295:: with SMTP id y21mr144786ljg.279.1620239692760;
 Wed, 05 May 2021 11:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210503143922.3093755-1-brauner@kernel.org> <20210503143922.3093755-5-brauner@kernel.org>
In-Reply-To: <20210503143922.3093755-5-brauner@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 5 May 2021 11:34:41 -0700
Message-ID: <CALvZod58WX-YpX_eSJzDyYknZiV5GzOe1wnKL8Pk4qMkq+oBQQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] tests/cgroup: test cgroup.kill
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>, containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 3, 2021 at 7:40 AM Christian Brauner <brauner@kernel.org> wrote:
>
[...]
> +
> +static int test_cgkill_simple(const char *root)
> +{
> +       pid_t pids[100];
> +       int ret = KSFT_FAIL;
> +       char *cgroup = NULL;
> +       int i;
> +
> +       cgroup = cg_name(root, "cg_test_simple");
> +       if (!cgroup)
> +               goto cleanup;
> +
> +       if (cg_create(cgroup))
> +               goto cleanup;
> +
> +       for (i = 0; i < 100; i++)
> +               pids[i] = cg_run_nowait(cgroup, child_fn, NULL);
> +
> +       if (cg_wait_for_proc_count(cgroup, 100))
> +               goto cleanup;
> +
> +        if (cg_write(cgroup, "cgroup.kill", "1"))
> +               goto cleanup;

I don't think the above write to cgroup.kill is correct.

> +
> +       if (cg_read_strcmp(cgroup, "cgroup.events", "populated 1\n"))
> +               goto cleanup;
> +
> +       if (cg_kill_wait(cgroup))
> +               goto cleanup;
> +
> +       if (cg_read_strcmp(cgroup, "cgroup.events", "populated 0\n"))
> +               goto cleanup;
> +
> +       ret = KSFT_PASS;
> +
> +cleanup:
> +       for (i = 0; i < 100; i++)
> +               wait_for_pid(pids[i]);
> +
> +       if (cgroup)
> +               cg_destroy(cgroup);
> +       free(cgroup);
> +       return ret;
> +}
