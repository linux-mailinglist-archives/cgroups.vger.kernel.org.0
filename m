Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A2679C196
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 03:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjILBWr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 21:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbjILBWb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 21:22:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71069D95B
        for <cgroups@vger.kernel.org>; Mon, 11 Sep 2023 15:39:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-502934c88b7so7911187e87.2
        for <cgroups@vger.kernel.org>; Mon, 11 Sep 2023 15:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694471897; x=1695076697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEy15wwFS0JVFa3fWkOLjP4htEcsy3rcKHhw++IpAZ4=;
        b=X5hWE/FcCAozwAMoRpXRAi5ohnTAkFY12viGMekAxWizMH8YHyNTdzBxVI19sCcFQz
         Q5eblAa358HK1QckYVbRE8AtIN3t08UELW08joIAxZXI0KffGjVXVmU2XqBw5MCAobnX
         Uo9T6t9FRyFgifPpMDif81pxwlRQVHBE53KFFjHFwNWiz89NX+xHJkKdlONs/okMbdDU
         3jRNN+pQWRZK1y50jm/BSxTgxh4Z63O/shSMXE5FpU5o5doIeCd88V7hiItgaY9YwzJd
         wFGUpKv/Uz5nfHwIf2BptS5UYMkutIwuJx6qg5BuE9WtnWTxuy2J0pjXOfsJN4afpL+E
         dwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694471897; x=1695076697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEy15wwFS0JVFa3fWkOLjP4htEcsy3rcKHhw++IpAZ4=;
        b=co3zlrWtiNs6G+bzDQ2FuLY6G6H3Td+UKhNrgIGvavu1Me5wyr8Br+/tqitZvjv1PC
         6e2QZQhv5SqY8twbKR9i7fjSbSHO5qVcarScbe4p31ciuvrDvciuyTpDS0xKpLAeR7nC
         jhHD7y7bpZnG78oXG86SuJFV+jVDhrVsRsdhII1V/pDqY/jdixiT299e0OZDqpaENyr9
         TH9HAvk2pUsjjkBS65pGT4BLYN+pCMtRsDzDJxEQJhvB0+lFzcksuPXVEf973Bztn7gY
         xdvPF2RXYr9knyg5tAuE1LM9JoEsNXunidE9cCl5wchFX008KhcqW9SMk+IsnwqgJBtw
         5nyw==
X-Gm-Message-State: AOJu0YxzX8nr0K8lq7lbvP6QvG3dZ6Ztl4YEMx8CaxRavcMHlNoQwUUf
        sCKqGmMNGZz5qChw59E3V3A3CWKweimJ5wEyBCTeki7+NhCaHyS6QbIEW155
X-Google-Smtp-Source: AGHT+IEEhJ2Oc9vOdd9yQHK2XjvJLQAIQ5mVHzAHMG71Zg+fdF4XuEjhFW8bg7PI+LY13J/6L+07IuGYjk1H1eIh+eI=
X-Received: by 2002:a05:6512:1094:b0:500:7c51:4684 with SMTP id
 j20-20020a056512109400b005007c514684mr11645309lfg.56.1694470627685; Mon, 11
 Sep 2023 15:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230911075437.74027-1-zeil@nebius.com> <20230911075437.74027-2-zeil@nebius.com>
In-Reply-To: <20230911075437.74027-2-zeil@nebius.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 11 Sep 2023 15:16:28 -0700
Message-ID: <CAJD7tkYM0JBukPMWCWtx-nrzGgPw4Y6m1p2_Ynb9fzSgsS0igg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] cgroup: list all subsystem states in debugfs files
To:     "Yakunin, Dmitry (Nebius)" <zeil@nebius.com>
Cc:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        NB-Core Team <NB-CoreTeam@nebius.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andrey Ryabinin <arbn@yandex-team.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 11, 2023 at 12:55=E2=80=AFAM Yakunin, Dmitry (Nebius)
<zeil@nebius.com> wrote:
>
> After removing cgroup subsystem state could leak or live in background
> forever because it is pinned by some reference. For example memory cgroup
> could be pinned by pages in cache or tmpfs.
>
> This patch adds common debugfs interface for listing basic state for each
> controller. Controller could define callback for dumping own attributes.
>
> In file /sys/kernel/debug/cgroup/<controller> each line shows state in
> format: <common_attr>=3D<value>... [-- <controller_attr>=3D<value>... ]
>
> Common attributes:
>
> css - css pointer
> cgroup - cgroup pointer
> id - css id
> ino - cgroup inode
> flags - css flags
> refcnt - css atomic refcount, for online shows huge bias
> path - cgroup path
>
> This patch adds memcg attributes:
>
> mem_id - 16-bit memory cgroup id
> memory - charged pages
> memsw - charged memory+swap for v1 and swap for v2
> kmem - charged kernel pages
> tcpmem - charged tcp pages
> shmem - shmem/tmpfs pages
>
> Link: https://lore.kernel.org/lkml/153414348591.737150.142299609139532765=
15.stgit@buzz
> Suggested-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Reviewed-by: Andrey Ryabinin <arbn@yandex-team.com>
> Signed-off-by: Dmitry Yakunin <zeil@nebius.com>

FWIW, I was just recently working on a debugfs directly that exposes a
list of all zombie memcgs as well as the "memory.stat" output for all
of them.

This entails a file at /sys/kernel/debug/zombie_memcgs/all that
contains a list of zombie memcgs (with indentation to reflect the
hierarchy) and an id for each of them.

This id can be used to index per-memcg directories at
/sys/kernel/debug/zombie_memcgs/<id>/, which include debug files. The
only one we have so far is
/sys/kernel/debug/zombie_memcgs/<id>/memory.stat.

If there is interest in this, I can share more information.

> ---
>  include/linux/cgroup-defs.h |   1 +
>  kernel/cgroup/cgroup.c      | 101 ++++++++++++++++++++++++++++++++++++
>  mm/memcontrol.c             |  14 +++++
>  3 files changed, 116 insertions(+)
>
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 8a0d5466c7be..810bd300cbee 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -673,6 +673,7 @@ struct cgroup_subsys {
>         void (*exit)(struct task_struct *task);
>         void (*release)(struct task_struct *task);
>         void (*bind)(struct cgroup_subsys_state *root_css);
> +       void (*css_dump)(struct cgroup_subsys_state *css, struct seq_file=
 *m);
>
>         bool early_init:1;
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 625d7483951c..fb9931ff7570 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -40,6 +40,7 @@
>  #include <linux/mount.h>
>  #include <linux/pagemap.h>
>  #include <linux/proc_fs.h>
> +#include <linux/debugfs.h>
>  #include <linux/rcupdate.h>
>  #include <linux/sched.h>
>  #include <linux/sched/task.h>
> @@ -7068,3 +7069,103 @@ static int __init cgroup_sysfs_init(void)
>  subsys_initcall(cgroup_sysfs_init);
>
>  #endif /* CONFIG_SYSFS */
> +
> +#ifdef CONFIG_DEBUG_FS
> +void *css_debugfs_seqfile_start(struct seq_file *m, loff_t *pos)
> +{
> +       struct cgroup_subsys *ss =3D m->private;
> +       struct cgroup_subsys_state *css;
> +       int id =3D *pos;
> +
> +       rcu_read_lock();
> +       css =3D idr_get_next(&ss->css_idr, &id);
> +       *pos =3D id;
> +       return css;
> +}
> +
> +void *css_debugfs_seqfile_next(struct seq_file *m, void *v, loff_t *pos)
> +{
> +       struct cgroup_subsys *ss =3D m->private;
> +       struct cgroup_subsys_state *css;
> +       int id =3D *pos + 1;
> +
> +       css =3D idr_get_next(&ss->css_idr, &id);
> +       *pos =3D id;
> +       return css;
> +}
> +
> +void css_debugfs_seqfile_stop(struct seq_file *m, void *v)
> +{
> +       rcu_read_unlock();
> +}
> +
> +int css_debugfs_seqfile_show(struct seq_file *m, void *v)
> +{
> +       struct cgroup_subsys *ss =3D m->private;
> +       struct cgroup_subsys_state *css =3D v;
> +       /* data is NULL for root cgroup_subsys_state */
> +       struct percpu_ref_data *data =3D css->refcnt.data;
> +       size_t buflen;
> +       char *buf;
> +       int len;
> +
> +       seq_printf(m, "css=3D%pK cgroup=3D%pK id=3D%d ino=3D%lu flags=3D%=
#x refcnt=3D%lu path=3D",
> +                  css, css->cgroup, css->id, cgroup_ino(css->cgroup),
> +                  css->flags, data ? atomic_long_read(&data->count) : 0)=
;
> +
> +       buflen =3D seq_get_buf(m, &buf);
> +       if (buf) {
> +               len =3D cgroup_path(css->cgroup, buf, buflen);
> +               seq_commit(m, len < buflen ? len : -1);
> +       }
> +
> +       if (ss->css_dump) {
> +               seq_puts(m, " -- ");
> +               ss->css_dump(css, m);
> +       }
> +
> +       seq_putc(m, '\n');
> +       return 0;
> +}
> +
> +static const struct seq_operations css_debug_seq_ops =3D {
> +       .start =3D css_debugfs_seqfile_start,
> +       .next =3D css_debugfs_seqfile_next,
> +       .stop =3D css_debugfs_seqfile_stop,
> +       .show =3D css_debugfs_seqfile_show,
> +};
> +
> +static int css_debugfs_open(struct inode *inode, struct file *file)
> +{
> +       int ret =3D seq_open(file, &css_debug_seq_ops);
> +       struct seq_file *m =3D file->private_data;
> +
> +       if (!ret)
> +               m->private =3D inode->i_private;
> +       return ret;
> +}
> +
> +static const struct file_operations css_debugfs_fops =3D {
> +       .open =3D css_debugfs_open,
> +       .read =3D seq_read,
> +       .llseek =3D seq_lseek,
> +       .release =3D seq_release,
> +};
> +
> +static int __init css_debugfs_init(void)
> +{
> +       struct cgroup_subsys *ss;
> +       struct dentry *dir;
> +       int ssid;
> +
> +       dir =3D debugfs_create_dir("cgroup", NULL);
> +       if (dir) {
> +               for_each_subsys(ss, ssid)
> +                       debugfs_create_file(ss->name, 0644, dir, ss,
> +                                           &css_debugfs_fops);
> +       }
> +
> +       return 0;
> +}
> +late_initcall(css_debugfs_init);
> +#endif /* CONFIG_DEBUG_FS */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4b27e245a055..7b3d4a10ac63 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5654,6 +5654,20 @@ static void mem_cgroup_css_rstat_flush(struct cgro=
up_subsys_state *css, int cpu)
>         }
>  }
>
> +static void mem_cgroup_css_dump(struct cgroup_subsys_state *css,
> +                               struct seq_file *m)
> +{
> +       struct mem_cgroup *memcg =3D mem_cgroup_from_css(css);
> +
> +       seq_printf(m, "mem_id=3D%u memory=3D%lu memsw=3D%lu kmem=3D%lu tc=
pmem=3D%lu shmem=3D%lu",
> +                  mem_cgroup_id(memcg),
> +                  page_counter_read(&memcg->memory),
> +                  page_counter_read(&memcg->memsw),
> +                  page_counter_read(&memcg->kmem),
> +                  page_counter_read(&memcg->tcpmem),
> +                  memcg_page_state(memcg, NR_SHMEM));
> +}
> +
>  #ifdef CONFIG_MMU
>  /* Handlers for move charge at task migration. */
>  static int mem_cgroup_do_precharge(unsigned long count)
> --
> 2.25.1
>
>
