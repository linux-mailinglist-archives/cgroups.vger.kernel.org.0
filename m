Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234D168C854
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 22:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjBFVMo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 16:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFVMo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 16:12:44 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D098022788
        for <cgroups@vger.kernel.org>; Mon,  6 Feb 2023 13:12:42 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id dr8so37965607ejc.12
        for <cgroups@vger.kernel.org>; Mon, 06 Feb 2023 13:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8VkzU+WzES+4hWs1tpdeJJZNbSILfAlysdpX/rlmqHE=;
        b=ZUeEFMpmBT/SzJvHqj8fRBYau8YeTEyGGmfBc8wwYprLc5Z0bo2KZ7GT8ZIxYJmsSy
         ZOXfkGS4p2PcoX+1z+FjOSAv3Q22woi5YGgqPVEN4/IXkVXhPSsoFCHNZknNCB6hq8/z
         HQTWLK//Sab3YYSk02xGSfiqUdbIgoo5kaqgxTfYwfSnVw4T3m9wTCXA30ZrNjfS4Lni
         K89czUvausOC1LF6vfPuw8GUljxvcFRFaxg0tLAGtQsHiFK+2kw1zk8twK9D2msu3XVG
         wSPYVb4gPnTRQjAgMi6q8q8GfU2iZO8XYPs4B9f/+cLN6SC1e8b6ESG/sxcw6CUw7IAT
         lgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VkzU+WzES+4hWs1tpdeJJZNbSILfAlysdpX/rlmqHE=;
        b=FgD241SKqdzdEENEWqai85jgEHTKkm8H1Vz6sletMBsQt1zzYMbGU1EMNvyGhdK19R
         MEJLo86HYbebAlt9RXK2O7mZskar0Bytz3wpx6umQVXK/+Z+2tUnwT/D1jE8eV/gd73h
         niTT2A8jC1GAC1Wo1SIG6CL6wnftn5TOuqec+CpsitvaAPRnH7jw8/Rj+zxGWH+oVB7F
         EWvd8jRaQC2zH6UoBoNNw5zfWj83UXH1CoFigSzCNHuqAHMYzWHvnPAiF3XJk+AswcJQ
         upCDi3BRRBTRGXrdcDRDosEL3eWzoyC7bubtr2qapYBoh8mZCQZdTrpRwqx97N6tWxhN
         jBQw==
X-Gm-Message-State: AO0yUKWyJW8VppqV2zwWlNv6WF690N7NY/SyhIH5ALAAzleBwRwArmU5
        kOb12kJgTRT3voFf3Bdp0o1vYjxkTWyiloMzHT2gMw==
X-Google-Smtp-Source: AK7set9NoDxrIurfKvhVlGit1dbMVEEzx52XRqNie2zqLuizKlhQTHK90bJH6p0dSyWSTDJssWI3FW4XE//n3e1qTpc=
X-Received: by 2002:a17:906:37c2:b0:878:7bc7:958a with SMTP id
 o2-20020a17090637c200b008787bc7958amr224927ejc.220.1675717961212; Mon, 06 Feb
 2023 13:12:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <fa58b745a597a32b434b0d92d55cf0b97317cfec.1675669136.git-series.apopple@nvidia.com>
In-Reply-To: <fa58b745a597a32b434b0d92d55cf0b97317cfec.1675669136.git-series.apopple@nvidia.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 6 Feb 2023 13:12:04 -0800
Message-ID: <CAJD7tkYxiOZF2F1RxEPTX4nYvAtvHn469JP63KDnifsxR_sQhQ@mail.gmail.com>
Subject: Re: [PATCH 18/19] mm/mmap: Charge locked memory to pins cgroup
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Feb 5, 2023 at 11:50 PM Alistair Popple <apopple@nvidia.com> wrote:
>
> account_locked_vm() is used to account memory to mm->locked_vm. This
> adds accounting to the pins cgorup as it behaves similarly and should
> be accounted against the same global limit if set.
>
> This means memory must now be unaccounted for correctly, as the cgroup
> typically outlives both the mm and the task. It is assumed that
> callers of account_locked_vm() only do accounting against the current
> task. Callers that need to do accounting against remote tasks should
> use account_pinned_vm() and associated struct vm_account to hold
> references to the cgroup.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/util.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/mm/util.c b/mm/util.c
> index 1ca0dfe..755bada 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -589,15 +589,21 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages,
>                         struct task_struct *task, bool bypass_rlim)
>  {
>         unsigned long locked_vm, limit;
> +       struct pins_cgroup *pins_cg = get_pins_cg(task);

Here we get one ref one the pins cgroup for the entire locked region
that may contain multiple pages, right? During unlock, we drop the
ref. Is it possible that we lock a region (acquiring one ref), and
then unlock it in chunks (dropping multiple refs)?

If this is possible, we may have a problem here. We may need to
acquire one ref per pinned page (not sure if this can overflow). We
may also want to defer the refcount handling to the pins cgroup
controller code, similar to charge_memcg(), a function that tries to
charge and acquires any necessary refs, same for uncharging.

WDYT?

>         int ret = 0;
>
>         mmap_assert_write_locked(mm);
>
> +       if (pins_cg && !pins_try_charge(pins_cg, pages))
> +               return -ENOMEM;
> +
>         locked_vm = mm->locked_vm;
>         if (!bypass_rlim) {
>                 limit = task_rlimit(task, RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> -               if (locked_vm + pages > limit)
> +               if (locked_vm + pages > limit) {
> +                       pins_uncharge(pins_cg, pages);
>                         ret = -ENOMEM;
> +               }
>         }
>
>         if (!ret)
> @@ -607,6 +613,12 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages,
>                  (void *)_RET_IP_, pages << PAGE_SHIFT, locked_vm << PAGE_SHIFT,
>                 task_rlimit(task, RLIMIT_MEMLOCK), ret ? " - exceeded" : "");
>
> +       pr_debug("%s: [%d] caller %ps %lu %lu/%lu%s\n", __func__, task->pid,
> +                (void *)_RET_IP_, pages << PAGE_SHIFT, locked_vm << PAGE_SHIFT,
> +               task_rlimit(task, RLIMIT_MEMLOCK), ret ? " - exceeded" : "");
> +
> +       if (pins_cg)
> +               put_pins_cg(pins_cg);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(__account_locked_vm);
> @@ -622,8 +634,18 @@ void __unaccount_locked_vm(struct mm_struct *mm, unsigned long pages)
>  {
>         unsigned long locked_vm = mm->locked_vm;
>
> +       /*
> +        * TODO: Convert book3s vio to use pinned vm to ensure
> +        * unaccounting happens to the correct cgroup.
> +        */
> +       struct pins_cgroup *pins_cg = get_pins_cg(current);
> +
>         mmap_assert_write_locked(mm);
>         WARN_ON_ONCE(pages > locked_vm);
> +       if (pins_cg) {
> +               pins_uncharge(pins_cg, pages);
> +               put_pins_cg(pins_cg);
> +       }
>         mm->locked_vm = locked_vm - pages;
>  }
>  EXPORT_SYMBOL_GPL(__unaccount_locked_vm);
> --
> git-series 0.9.1
>
