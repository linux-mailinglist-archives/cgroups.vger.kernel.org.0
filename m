Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992C640CB61
	for <lists+cgroups@lfdr.de>; Wed, 15 Sep 2021 19:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhIORGP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Sep 2021 13:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhIORGP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Sep 2021 13:06:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B1CC061574
        for <cgroups@vger.kernel.org>; Wed, 15 Sep 2021 10:04:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c8so7432040lfi.3
        for <cgroups@vger.kernel.org>; Wed, 15 Sep 2021 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiL7YfwCSR7LokE5J56usk6i2TFHnfpVhu2pbczR/rY=;
        b=YjgBRMW6BxNZ9RQ3OrB64PcgAbpzCvURuVzS2ChPGQ9FOfcjAuiJ7nOYupy9eB316J
         1NZt9Ps0lkvdwH0tDss0B+Lg5rtk1l4NTDZwUiJsDF4T3zxmRk1zqgBcgsBqAFfdu7/5
         6l9Ztk6P9WF+a8hA1jgJj9VOxjhHhOx9y4kPo54MY7fqix74AHRoTUQ1EDWkE0j4G377
         2uJ8qxBYEA1cW8jAd8iVorR13sx3cItzUFzoj07UXEzzHRNn6hyAlkBex7PDCLU8gQSA
         vhVIZn+mQpAee7wuK8C4+KrKqs7KOrVZN55UAlWSX2/Z/zzfWt1i78uNilaLmN6eLC4B
         yUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiL7YfwCSR7LokE5J56usk6i2TFHnfpVhu2pbczR/rY=;
        b=51SwfPJPiJZFRftI49tjTIalbrqC0EFOy+vKs0qG2BkJiaX7HIk7ru3acg7vrepkCy
         QG/Lgdc2LRL5ipHu6RrpHnk0/aTSsqAfuSzclvfUZT2CukMrnf42EeOyXC80uw14f6pS
         Kz66LLuqSwp2GRVmYSwcQdMY99exMXt2B9kPX9fFZqhd7Rq5dm1m+RZ1VBTT6lHbkNFm
         oqKKBa45OPYWZLl77goX2kSxKSQovD2BMKDZbxeF4eXck1QeueqcgFadBrT3j5hJ8FKb
         SNG4LzNjvUqkY2HEWKNG+A1W+Fv76Qp4sWyLqTb2K4kNlFFI55bEu8j2SBrNbeDMuSxj
         PWhQ==
X-Gm-Message-State: AOAM532C/HGtZ91lb7E+jo6/WWzR/6TsFmClXsoNFXeKiLitkYLPnMwE
        SOCFu+lzicA53lzADuwMBNyiUir22jsjSdrpdiw80Q==
X-Google-Smtp-Source: ABdhPJyPOjV0ZpbMt3W6lj6EoQRoL7MRqeIFJLX3H5JfFbprdhI8dXfa7UQ0YFUHuvKQmtzNEFB6m5Zf2bMrT45EqbM=
X-Received: by 2002:ac2:5fb2:: with SMTP id s18mr730787lfe.580.1631725493981;
 Wed, 15 Sep 2021 10:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
In-Reply-To: <3834f917d50a6f19402e179e917ef6a9dde5f64a.1631671936.git.brookxu@tencent.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Wed, 15 Sep 2021 10:04:18 -0700
Message-ID: <CAHVum0d657HeoSyXS9RGW8YHkwJFmvLQ6ebwYy_wVnR0gM8uPQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] misc_cgroup: introduce misc.events to count failures
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mkoutny@suse.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 14, 2021 at 7:18 PM brookxu <brookxu.cn@gmail.com> wrote:
>
> From: Chunguang Xu <brookxu@tencent.com>
>
> Introduce misc.events to make it easier for us to understand
> the pressure of resources. Currently only the 'max' event is
> implemented, which indicates the times the resource is about
> to exceeds the max limit.
>
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
>
> v3: remove misc.events.local.
> v2: remove cgroup v1 files.
>
>  include/linux/misc_cgroup.h |  5 +++++
>  kernel/cgroup/misc.c        | 24 ++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
> index da2367e..091f2d2 100644
> --- a/include/linux/misc_cgroup.h
> +++ b/include/linux/misc_cgroup.h
> @@ -36,6 +36,7 @@ enum misc_res_type {
>  struct misc_res {
>         unsigned long max;
>         atomic_long_t usage;
> +       atomic_long_t events;
>         bool failed;
>  };
>
> @@ -46,6 +47,10 @@ struct misc_res {
>   */
>  struct misc_cg {
>         struct cgroup_subsys_state css;
> +
> +       /* misc.events */
> +       struct cgroup_file events_file;
> +
>         struct misc_res res[MISC_CG_RES_TYPES];
>  };
>
> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
> index ec02d96..4b2b492 100644
> --- a/kernel/cgroup/misc.c
> +++ b/kernel/cgroup/misc.c
> @@ -171,6 +171,11 @@ int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg,
>         return 0;
>
>  err_charge:
> +       for (j = i; j; j = parent_misc(j)) {
> +               atomic_long_inc(&j->res[type].events);
> +               cgroup_file_notify(&j->events_file);
> +       }
> +
>         for (j = cg; j != i; j = parent_misc(j))
>                 misc_cg_cancel_charge(type, j, amount);
>         misc_cg_cancel_charge(type, i, amount);
> @@ -335,6 +340,19 @@ static int misc_cg_capacity_show(struct seq_file *sf, void *v)
>         return 0;
>  }
>
> +static int misc_events_show(struct seq_file *sf, void *v)
> +{
> +       struct misc_cg *cg = css_misc(seq_css(sf));
> +       unsigned long events, i;
> +
> +       for (i = 0; i < MISC_CG_RES_TYPES; i++) {
> +               events = atomic_long_read(&cg->res[i].events);
> +               if (READ_ONCE(misc_res_capacity[i]) || events)
> +                       seq_printf(sf, "%s.max %lu\n", misc_res_name[i], events);
> +       }
> +       return 0;
> +}
> +
>  /* Misc cgroup interface files */
>  static struct cftype misc_cg_files[] = {
>         {
> @@ -353,6 +371,12 @@ static int misc_cg_capacity_show(struct seq_file *sf, void *v)
>                 .seq_show = misc_cg_capacity_show,
>                 .flags = CFTYPE_ONLY_ON_ROOT,
>         },
> +       {
> +               .name = "events",
> +               .flags = CFTYPE_NOT_ON_ROOT,
> +               .file_offset = offsetof(struct misc_cg, events_file),
> +               .seq_show = misc_events_show,
> +       },
>         {}
>  };
>
> --
> 1.8.3.1
>

Reviewed-by: Vipin Sharma <vipinsh@google.com>
