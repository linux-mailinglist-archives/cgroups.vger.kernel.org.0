Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782EB64558F
	for <lists+cgroups@lfdr.de>; Wed,  7 Dec 2022 09:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiLGIlF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Dec 2022 03:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiLGIk7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Dec 2022 03:40:59 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A5B5581
        for <cgroups@vger.kernel.org>; Wed,  7 Dec 2022 00:40:57 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z92so23944946ede.1
        for <cgroups@vger.kernel.org>; Wed, 07 Dec 2022 00:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=34x8LhKwP612H1FJN6oNMCWpQO3JP3IEEksN2msghRE=;
        b=U5Hmca3j3AA8CcH/P8E44nnzhv5v96G87rRQqTJ9gCAq3J1xsOxIuw8z/cI8JEFs8B
         FFlh+Az7SvRtuVkiqF+GWMQNSMdPK3+lVCn1HwrHbV1uURO4i96Gu6WtRRSKTKFTjVbs
         dwcIYWizZu+PL0BrwV8qUfQUSMb8QMclIO9kgiPefwZxlL5B0STQ+oFpbSZJC3tHcUCw
         P14uE6NmEagF6Cye9ntZ2zuqTJDW7GsRXjK/In/NJrz0Lgf1xEmSSY109lDT6z7VpqIq
         Pm0qV2XeJUssPkw2eQutDxSzFEmT8p28vd6cUjjU144JyCVQxA+6AUuk4nEfsKv+3kkL
         8nfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34x8LhKwP612H1FJN6oNMCWpQO3JP3IEEksN2msghRE=;
        b=sZQaE700metcLv/yNlCS2TkvIMW9MXs1h6QeWbueAafszt2DxppDv3u4q/kdlbvdEx
         taIcv/4Z0LPWRIroqLMAA1viGbdlKGE/Qx1iq4AsmKbVbKUSvjTsFYHVQtt7KVSmymwL
         ksHZqDfevPpwCknG1ieMtxBDv2io40Apwqwv2nOpEs5sBi7o1BaKGmGlO+OrFd/EMJyR
         0vMxTYj0Qviyypze4/HkFoC7Y8Z7NI+wdR+qp/84F/atrCkTjpXCnjmTym5zg1PfGUSj
         bvOmmXZd2roDgXnN3C0XZpMJtfzf7lNvRKsNeGirQHz4wP28wD6GYAhAgY1m1hSfm9nV
         NeCQ==
X-Gm-Message-State: ANoB5pnGuLZgPMm7npnUR8yuhq+IuXPxqsElUxuowj6UIAvx0bp2yjT1
        UvcgR86YR+2kl+D6ELCxjjlP59llWp/WgrjqXKe73w==
X-Google-Smtp-Source: AA0mqf4CnEzjSg6q7C66DF5kGqnPmmnNIw5ddw/mZLjbEOhKqUOboEI19Qm2mVUC+gknZ8Sma67yzNEklVRQdrIQIeg=
X-Received: by 2002:a05:6402:19a:b0:460:7413:5d46 with SMTP id
 r26-20020a056402019a00b0046074135d46mr81001152edv.47.1670402455487; Wed, 07
 Dec 2022 00:40:55 -0800 (PST)
MIME-Version: 1.0
References: <1670401989-8208-1-git-send-email-wangyufen@huawei.com>
In-Reply-To: <1670401989-8208-1-git-send-email-wangyufen@huawei.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 7 Dec 2022 00:40:18 -0800
Message-ID: <CAJD7tkbkNc671xP-s7KSzOzP6B_aKupTc_h-izWpTDiPh53xxA@mail.gmail.com>
Subject: Re: [PATCH] selftests: cgroup: Fix the invalid check in proc_read_text()
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        shuah@kernel.org, brauner@kernel.org, cgroups@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
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

On Wed, Dec 7, 2022 at 12:33 AM Wang Yufen <wangyufen@huawei.com> wrote:
>
> Unsigned variable cannot be lesser than zero, So the return check of read_text() is invalid.
> To fix, add a new ssize_t variable read for read_text() return value check.
>
> Fixes: 6c26df84e1f2 ("selftests: cgroup: return -errno from cg_read()/cg_write() on failure")

Thanks for sending this, but a fix was already sent recently (by YueHaibing):
https://lore.kernel.org/lkml/20221105110611.28920-1-yuehaibing@huawei.com/

, and it currently lives in the mm-nomm-stable branch in Andrew's tree
AFAICT as commit e410f7aa641d ("selftests: cgroup: fix unsigned
comparison with less than zero").

> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---
>  tools/testing/selftests/cgroup/cgroup_util.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index 4c52cc6..19137c0 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -555,6 +555,7 @@ int proc_mount_contains(const char *option)
>  ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size)
>  {
>         char path[PATH_MAX];
> +       ssize_t read;
>
>         if (!pid)
>                 snprintf(path, sizeof(path), "/proc/%s/%s",
> @@ -562,8 +563,8 @@ ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t
>         else
>                 snprintf(path, sizeof(path), "/proc/%d/%s", pid, item);
>
> -       size = read_text(path, buf, size);
> -       return size < 0 ? -1 : size;
> +       read = read_text(path, buf, size);
> +       return read < 0 ? -1 : read;
>  }
>
>  int proc_read_strstr(int pid, bool thread, const char *item, const char *needle)
> --
> 1.8.3.1
>
