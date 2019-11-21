Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA171105CB5
	for <lists+cgroups@lfdr.de>; Thu, 21 Nov 2019 23:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfKUWgZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Nov 2019 17:36:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46695 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUWgZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Nov 2019 17:36:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id n23so4440606otr.13
        for <cgroups@vger.kernel.org>; Thu, 21 Nov 2019 14:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=frNQQ0E3tbDhl+W2cb9+R2Bpor2lIjhJe2UTYI9IXOs=;
        b=jvY4sTafPujsSvsWE7u9Sf/832gUcujKDz20+su9Sfv0LnRXveEZJaRDWpB0GHULPo
         U0fwJ/8sbTL/CD4+U+LTNof5QdpjG6NDyvTbugO3ZdsGpJ1suGg2PX5GJX5KzkLrkd56
         nJ37JPbQHZSMKyNS4cSbJKoeEPyVwSurX4hvXCkCGTvLT8hpHCiR7ZJwpmXFtjm+1bIn
         6kIEAwm7zvXSl4Vg7G1YUTIECAFVUCYqwG9FoVE3hDS8aDmECvGu1ugJ5LpOeDfXPmxU
         p093tvVb1/2xIbv01WObPtFrX1T+58OnCThaAFt721BLYjI3ZWwnNMvGg7sq4WZ+fB4/
         xSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=frNQQ0E3tbDhl+W2cb9+R2Bpor2lIjhJe2UTYI9IXOs=;
        b=LbQm8gqjaxbVpr9pJXWNPqEbHwBK48tqF30joTZv3pS7RBPJ83qd1u7VDOa/3P5Dzc
         6ulmD+02qSsc6NeQeNQr+Fp8xZ98P3tHnilBkwqRDQFFe33OfO3Pi2ZFwnjwsJ32JxnX
         718qV2s8jDWcgJtcwLStbAYykHQpTVkTAyphikHJwyB+yShBwq0a+kIxaynFbU5TcUH5
         wfFNqesGrzY6//7TL9+Z1nTqW/93ctX2QLzO7vWWwtvT49nrEa004cSgeIpB17a2MBSM
         DF5r8BpbDBjfFnocNaIPT17blC6d0tpUkLQGG7Xvp5PhIbPC9J+B3xOOvlo3QuWecu2e
         g7iA==
X-Gm-Message-State: APjAAAXr93SzNn8moQUJMJQTuRNa5GturvRvtWcJS1Ly9Yp3Z9abeElL
        zjR2IdFg6SZyi9UWTwaGpRk/EKDBGo4cSEHWRh0U/Q==
X-Google-Smtp-Source: APXvYqzQ3GkyRyDxmaoRBFt3pftlze45o3xfb/wrjSdMbYRHPsyGZO+I98XWnG/qSnSa1mwjhF8gtpz53l9Y2eraqo4=
X-Received: by 2002:a9d:3b26:: with SMTP id z35mr8654576otb.355.1574375783578;
 Thu, 21 Nov 2019 14:36:23 -0800 (PST)
MIME-Version: 1.0
References: <20191121211424.263622-1-gscrivan@redhat.com>
In-Reply-To: <20191121211424.263622-1-gscrivan@redhat.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 21 Nov 2019 14:36:12 -0800
Message-ID: <CAHS8izPwEFbdtNrDT-xfPs9Zc1YoAY5hmDH0j3fbRZE-OjneuQ@mail.gmail.com>
Subject: Re: [PATCH] mm: hugetlb controller for cgroups v2
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     cgroups@vger.kernel.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 21, 2019 at 1:14 PM Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>
> In the effort of supporting cgroups v2 into Kubernetes, I stumped on
> the lack of the hugetlb controller.
>
> When the controller is enabled, it exposes three new files for each
> hugetlb size on non-root cgroups:
>
> - hugetlb.<hugepagesize>.current
> - hugetlb.<hugepagesize>.max
> - hugetlb.<hugepagesize>.stat
>
> The differences with the legacy hierarchy are in the file names and
> using the value "max" instead of "-1" to disable a limit.
>
> The file .limit_in_bytes is renamed to .max.
>
> The file .usage_in_bytes is renamed to .usage.
>

I could be wrong here but I think the memcg files are not renamed, so
the same file names exist in v1 and v2. Can we follow that example?

> .failcnt and .max_usage_in_bytes are not provided as single files
> anymore, but their value can be read through the new flat-keyed file
> .stat, respectively through the max_usage and failcnt keys.
>
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  28 +++++
>  include/linux/hugetlb.h                 |   3 +-
>  mm/hugetlb_cgroup.c                     | 142 ++++++++++++++++++++++--
>  3 files changed, 162 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 5361ebec3361..662cb39abbf5 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -61,6 +61,8 @@ v1 is available under Documentation/admin-guide/cgroup-v1/.
>       5-6. Device
>       5-7. RDMA
>         5-7-1. RDMA Interface Files
> +     5-8. HugeTLB
> +       5.8-1. HugeTLB Interface Files
>       5-8. Misc
>         5-8-1. perf_event
>       5-N. Non-normative information
> @@ -2050,6 +2052,32 @@ RDMA Interface Files
>           mlx4_0 hca_handle=1 hca_object=20
>           ocrdma1 hca_handle=1 hca_object=23
>
> +HugeTLB
> +-------
> +
> +The HugeTLB controller allows to limit the HugeTLB usage per control group and
> +enforces the controller limit during page fault.
> +
> +HugeTLB Interface Files
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +  hugetlb.<hugepagesize>.current
> +       Show current usage for "hugepagesize" hugetlb.  The default
> +       value is "max".  It exists for all the cgroup except root.
> +
> +
> +  hugetlb.<hugepagesize>.max
> +       Set/show the hard limit of "hugepagesize" hugetlb usage.
> +       The default value is "max".  It exists for all the cgroup except root.
> +
> +  hugetlb.<hugepagesize>.stat
> +       A read-only flat-keyed file which exists on non-root cgroups.
> +
> +         max_usage
> +               Maximum HugeTLB usage recorded
> +
> +         failcnt
> +               The number of allocation failure due to HugeTLB limit
>
>  Misc
>  ----
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 53fc34f930d0..1c2bacbca044 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -340,7 +340,8 @@ struct hstate {
>         unsigned int surplus_huge_pages_node[MAX_NUMNODES];
>  #ifdef CONFIG_CGROUP_HUGETLB
>         /* cgroup control files */
> -       struct cftype cgroup_files[5];
> +       struct cftype cgroup_files_dfl[5];
> +       struct cftype cgroup_files_legacy[5];
>  #endif
>         char name[HSTATE_NAME_LEN];
>  };
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 2ac38bdc18a1..d4dbf5203324 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -283,10 +283,55 @@ static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
>         }
>  }
>
> +static int hugetlb_cgroup_read_u64_max(struct seq_file *seq, void *v)
> +{
> +       int idx;
> +       u64 val;
> +       bool write_raw = false;
> +       struct cftype *cft = seq_cft(seq);
> +       unsigned long limit;
> +       struct page_counter *counter;
> +       struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(seq_css(seq));
> +
> +       idx = MEMFILE_IDX(cft->private);
> +       counter = &h_cg->hugepage[idx];
> +
> +       switch (MEMFILE_ATTR(cft->private)) {
> +       case RES_USAGE:
> +               val = (u64)page_counter_read(counter);
> +               break;
> +       case RES_LIMIT:
> +               val = (u64)counter->max;
> +               break;
> +       case RES_MAX_USAGE:
> +               val = (u64)counter->watermark;
> +               break;
> +       case RES_FAILCNT:
> +               val = counter->failcnt;
> +               write_raw = true;
> +               break;
> +       default:
> +               BUG();
> +       }
> +
> +       limit = round_down(PAGE_COUNTER_MAX,
> +                          1 << huge_page_order(&hstates[idx]));
> +
> +       if (val == limit && !write_raw)
> +               seq_puts(seq, "max\n");
> +       else if (write_raw)
> +               seq_printf(seq, "%llu\n", val);
> +       else
> +               seq_printf(seq, "%llu\n", val * PAGE_SIZE);
> +
> +       return 0;
> +}
> +
>  static DEFINE_MUTEX(hugetlb_limit_mutex);
>
>  static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
> -                                   char *buf, size_t nbytes, loff_t off)
> +                                   char *buf, size_t nbytes, loff_t off,
> +                                   const char *max)
>  {
>         int ret, idx;
>         unsigned long nr_pages;
> @@ -296,7 +341,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
>                 return -EINVAL;
>
>         buf = strstrip(buf);
> -       ret = page_counter_memparse(buf, "-1", &nr_pages);
> +       ret = page_counter_memparse(buf, max, &nr_pages);
>         if (ret)
>                 return ret;
>
> @@ -316,6 +361,18 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
>         return ret ?: nbytes;
>  }
>
> +static ssize_t hugetlb_cgroup_write_legacy(struct kernfs_open_file *of,
> +                                          char *buf, size_t nbytes, loff_t off)
> +{
> +       return hugetlb_cgroup_write(of, buf, nbytes, off, "-1");
> +}
> +
> +static ssize_t hugetlb_cgroup_write_dfl(struct kernfs_open_file *of,
> +                                       char *buf, size_t nbytes, loff_t off)
> +{
> +       return hugetlb_cgroup_write(of, buf, nbytes, off, "max");
> +}
> +
>  static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
>                                     char *buf, size_t nbytes, loff_t off)
>  {
> @@ -350,7 +407,60 @@ static char *mem_fmt(char *buf, int size, unsigned long hsize)
>         return buf;
>  }
>
> -static void __init __hugetlb_cgroup_file_init(int idx)
> +static int hugetlb_stat_show(struct seq_file *seq, void *v)
> +{
> +       struct page_counter *counter;
> +       struct cftype *cft = seq_cft(seq);
> +       struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(seq_css(seq));
> +
> +       counter = &h_cg->hugepage[MEMFILE_IDX(cft->private)];
> +
> +       seq_printf(seq, "max_usage %llu\n",
> +                  (u64)counter->watermark * PAGE_SIZE);
> +       seq_printf(seq, "fail_cnt %lu\n", counter->failcnt);
> +
> +       return 0;
> +}
> +
> +static void __init __hugetlb_cgroup_file_dfl_init(int idx)
> +{
> +       char buf[32];
> +       struct cftype *cft;
> +       struct hstate *h = &hstates[idx];
> +
> +       /* format the size */
> +       mem_fmt(buf, 32, huge_page_size(h));
> +
> +       /* Add the limit file */
> +       cft = &h->cgroup_files_dfl[0];
> +       snprintf(cft->name, MAX_CFTYPE_NAME, "%s.max", buf);
> +       cft->private = MEMFILE_PRIVATE(idx, RES_LIMIT);
> +       cft->seq_show = hugetlb_cgroup_read_u64_max;
> +       cft->write = hugetlb_cgroup_write_dfl;
> +       cft->flags = CFTYPE_NOT_ON_ROOT;
> +
> +       /* Add the current usage file */
> +       cft = &h->cgroup_files_dfl[1];
> +       snprintf(cft->name, MAX_CFTYPE_NAME, "%s.current", buf);
> +       cft->private = MEMFILE_PRIVATE(idx, RES_USAGE);
> +       cft->seq_show = hugetlb_cgroup_read_u64_max;
> +       cft->flags = CFTYPE_NOT_ON_ROOT;
> +
> +       /* Add the stat file */
> +       cft = &h->cgroup_files_dfl[2];
> +       snprintf(cft->name, MAX_CFTYPE_NAME, "%s.stat", buf);
> +       cft->seq_show = hugetlb_stat_show;
> +       cft->flags = CFTYPE_NOT_ON_ROOT;
> +
> +       /* NULL terminate the last cft */
> +       cft = &h->cgroup_files_dfl[3];
> +       memset(cft, 0, sizeof(*cft));
> +
> +       WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
> +                                      h->cgroup_files_dfl));
> +}
> +
> +static void __init __hugetlb_cgroup_file_legacy_init(int idx)
>  {
>         char buf[32];
>         struct cftype *cft;
> @@ -360,38 +470,44 @@ static void __init __hugetlb_cgroup_file_init(int idx)
>         mem_fmt(buf, 32, huge_page_size(h));
>
>         /* Add the limit file */
> -       cft = &h->cgroup_files[0];
> +       cft = &h->cgroup_files_legacy[0];
>         snprintf(cft->name, MAX_CFTYPE_NAME, "%s.limit_in_bytes", buf);
>         cft->private = MEMFILE_PRIVATE(idx, RES_LIMIT);
>         cft->read_u64 = hugetlb_cgroup_read_u64;
> -       cft->write = hugetlb_cgroup_write;
> +       cft->write = hugetlb_cgroup_write_legacy;
>
>         /* Add the usage file */
> -       cft = &h->cgroup_files[1];
> +       cft = &h->cgroup_files_legacy[1];
>         snprintf(cft->name, MAX_CFTYPE_NAME, "%s.usage_in_bytes", buf);
>         cft->private = MEMFILE_PRIVATE(idx, RES_USAGE);
>         cft->read_u64 = hugetlb_cgroup_read_u64;
>
>         /* Add the MAX usage file */
> -       cft = &h->cgroup_files[2];
> +       cft = &h->cgroup_files_legacy[2];
>         snprintf(cft->name, MAX_CFTYPE_NAME, "%s.max_usage_in_bytes", buf);
>         cft->private = MEMFILE_PRIVATE(idx, RES_MAX_USAGE);
>         cft->write = hugetlb_cgroup_reset;
>         cft->read_u64 = hugetlb_cgroup_read_u64;
>
>         /* Add the failcntfile */
> -       cft = &h->cgroup_files[3];
> +       cft = &h->cgroup_files_legacy[3];
>         snprintf(cft->name, MAX_CFTYPE_NAME, "%s.failcnt", buf);
>         cft->private  = MEMFILE_PRIVATE(idx, RES_FAILCNT);
>         cft->write = hugetlb_cgroup_reset;
>         cft->read_u64 = hugetlb_cgroup_read_u64;
>
>         /* NULL terminate the last cft */
> -       cft = &h->cgroup_files[4];
> +       cft = &h->cgroup_files_legacy[4];
>         memset(cft, 0, sizeof(*cft));
>
>         WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
> -                                         h->cgroup_files));
> +                                         h->cgroup_files_legacy));
> +}
> +
> +static void __init __hugetlb_cgroup_file_init(int idx)
> +{
> +       __hugetlb_cgroup_file_dfl_init(idx);
> +       __hugetlb_cgroup_file_legacy_init(idx);
>  }
>
>  void __init hugetlb_cgroup_file_init(void)
> @@ -433,8 +549,14 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
>         return;
>  }
>
> +static struct cftype hugetlb_files[] = {
> +       {} /* terminate */
> +};
> +
>  struct cgroup_subsys hugetlb_cgrp_subsys = {
>         .css_alloc      = hugetlb_cgroup_css_alloc,
>         .css_offline    = hugetlb_cgroup_css_offline,
>         .css_free       = hugetlb_cgroup_css_free,
> +       .dfl_cftypes    = hugetlb_files,
> +       .legacy_cftypes = hugetlb_files,
>  };
> --
> 2.23.0
>
