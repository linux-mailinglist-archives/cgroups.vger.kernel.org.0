Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA3829B21
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2019 17:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389517AbfEXPeN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Fri, 24 May 2019 11:34:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45070 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389288AbfEXPeM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 May 2019 11:34:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id t24so9043325otl.12
        for <cgroups@vger.kernel.org>; Fri, 24 May 2019 08:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XmUFDj9D/eofBnJzPdCvp5T1ZMAct2TpjK59uIWjaGI=;
        b=awNI/7N+hL/5j2AEakSqAMc8rGHAbYt6TAdhQnG3gYDmBcKtYIaHDfPX9E+teJByUa
         Ll2AxN1D3tajSKRjAFwQHxz/MjFn4moo3xhx8S9sb30WFDKNKuDIMPj+5Vn0JExary5u
         yjCT6SLsTDFY3v8CTrw2dKT+26Ln57HMD3obNi/mnyGOhOiWTHSSewOSgf/zsnmqPM+1
         XW7Bo6x3m+M+jujg1eAjc/xBmQT6Z1YYLdpIpqry5Ri5WNyTuiJKvahmKKyntmzBGMeC
         5M/9I43wTL53Snlsi54GG5HkPDiKXM1pkSUtU3/QgrzzhNf2jwz2uDIxCUvwNkCb80z8
         QzOQ==
X-Gm-Message-State: APjAAAUJwSECzDKAgGeEHlKFCBvcvVvkNIoqyNGaxgPlzg9GsusuBw53
        zdFVOjsktnZGnGBO3vT+P5X/JAeAU8rpYX2hGRBWITZHQzI=
X-Google-Smtp-Source: APXvYqxsrFVzXtT9Acfrz6QjWXchCDlZpb53Ha0Iwr8PLUs05rv6qoQCFOXdqtNTzA0Ek/izdns14Zvmvnm+oyKNNNs=
X-Received: by 2002:a9d:30d6:: with SMTP id r22mr62722773otg.33.1558712052313;
 Fri, 24 May 2019 08:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190409204003.6428-1-jsavitz@redhat.com> <20190521143414.GJ5307@blackbody.suse.cz>
In-Reply-To: <20190521143414.GJ5307@blackbody.suse.cz>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Fri, 24 May 2019 11:33:55 -0400
Message-ID: <CAL1p7m6nfPkWoEEAjO+Gxq-ZiRY7+1jU_7dVcw2-hjC22xz-4A@mail.gmail.com>
Subject: Re: [PATCH v2] cpuset: restore sanity to cpuset_cpus_allowed_fallback()
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
        Phil Auld <pauld@redhat.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 21, 2019 at 10:35 AM Michal Koutný <mkoutny@suse.com> wrote:
> >       $ grep Cpus /proc/$$/status
> >       Cpus_allowed:   ff
> >       Cpus_allowed_list:      0-7
>
> (a)
>
> >       $ taskset -p 4 $$
> >       pid 19202's current affinity mask: f

> I'm confused where this value comes from, I must be missing something.
>
> Joel, is the task in question put into a cpuset with 0xf CPUs only (at
> point (a))? Or are the CPUs 4-7 offlined as well?

Good point.

It is a bit ambiguous, but I performed no action on the task's cpuset
nor did I offline any cpus at point (a).

After a bit of research, I am fairly certain that the observed
discrepancy is due to differing mechanisms used to acquire the cpuset
mask value.

The first mechanism, via `grep Cpus /proc/$$/status`, has it's value
populated by the expression (task->cpus_allowed) in
fs/proc/array.c:sched_getaffinity(), whereas the taskset utility
(https://github.com/karelzak/util-linux/blob/master/schedutils/taskset.c)
uses sched_getaffinity(2) to determine the "current affinity mask"
value from the expression (task->cpus_allowed & cpu_active_mask) in
kernel/sched/core.c:sched_getaffinty(),

I do not know if there is an explicit reason for this discrepancy or
whether the two mechanisms were simply built independently, perhaps
for different purposes.

I think the /proc/$$/status value is intended to simply reflect the
user-specified policy stating which cpus the task is allowed to run on
without consideration for hardware state, whereas the taskset value is
representative of the cpus that the task can actually be run on given
the restriction policy specified by the user via the cpuset mechanism.

By the way, I posted a v2 of this patch that correctly handles cgroup
v2 behavior.
