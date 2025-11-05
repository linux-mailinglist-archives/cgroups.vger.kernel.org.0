Return-Path: <cgroups+bounces-11584-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F5FC342C2
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 08:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC2BC34A332
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 07:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F122D0C98;
	Wed,  5 Nov 2025 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4fBQDXj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiEcQFFy"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0D2D23BF
	for <cgroups@vger.kernel.org>; Wed,  5 Nov 2025 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326725; cv=none; b=U00vY732pVhTxziwwdVK2itDIIB0XDM6FeCpsZZHtmYsD7c3JUt0qMIBSCcRYVz0e5EvxGZ6bxX8zuIUB3GZ+pI7oE90daQSQApdf4dYXtvwT6PhuGu3YaRBwWjH7WEwUriemQElZndFSgeQa9/HIs2ChVenqOFO9S2TyJwQcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326725; c=relaxed/simple;
	bh=9YVR2xg15jieWFBv7AAqGNPRtvxnHox4sbmbvg2DSuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWxTi3HexxOfSZIWyB90OFgTEd+u33ed7b3w1yc61HuZWe/dKVv+j1XIAJNHfELW+GebFy+uc6Rwl8jRni6bTeyqvs2YjKYOwdf4YyyYDXils6MMfdwefqKd0KR6HpokW/+yXqOGOYjrGXM3D4S3uHkmV/wmNVoL54zfe2491iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4fBQDXj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiEcQFFy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762326721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqWY44d/tVtHF8a9wKXOXU6HsIiX0a4zma7xC+DjpJs=;
	b=L4fBQDXjcPLyOvd2VT/7IGTTSACD+Ga6r6LVc6mDKmnVQCnG5p9CpMujfZGXyvkX3ZHiTM
	7Ief6u025I1AH/UOTMFPyfvx9PAe5TSVb1rqsyeOjqkG/xNCloGdkAX8Bfn3Zg1R01vW4h
	HTDzXxWFesBgLFpYfaj7lEgGbPbioY0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-jBL0cbIiO-q4jrqXuss-Kw-1; Wed, 05 Nov 2025 02:11:59 -0500
X-MC-Unique: jBL0cbIiO-q4jrqXuss-Kw-1
X-Mimecast-MFC-AGG-ID: jBL0cbIiO-q4jrqXuss-Kw_1762326719
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6ceeea4addso6452012a12.1
        for <cgroups@vger.kernel.org>; Tue, 04 Nov 2025 23:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762326718; x=1762931518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqWY44d/tVtHF8a9wKXOXU6HsIiX0a4zma7xC+DjpJs=;
        b=OiEcQFFyqhE5zdC3BYbeiRvPf7Gmsi4bjj3sbSqnbjlP28biy/tmDTGfxwfsktIdsy
         gmIEKL5ycsGUbSDdqvgo8J6Pssup1KXZJ7TFmxniOqyHXHKguxw8J5Xis3ZDnFM3eCT1
         5Zh2MUJWoKaPG6SwFjCYI2xz0g8EL7hg5Po+5uc/yoWCAKCElNi+VvAlVx3TtVibWKAi
         8vEn00nwCXE4PeBRzB4dg1zFcRyeM9ws+ndo/1sG5dC3btlUX/Oz4jspoJro5xPFYy9Q
         Wlm13SZSMiZe/CdMoef78i9VHFEn/YpuiSWM7r5aGAt++y8ysx+p0dETHM+oHb9NwY9f
         yyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762326718; x=1762931518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqWY44d/tVtHF8a9wKXOXU6HsIiX0a4zma7xC+DjpJs=;
        b=Q/6nAXB9wZp5+BgWhAuHSw1BM3EghxwGvFvtiE0Xux9ev7x8OsmsKXhKXouKkanb0P
         Vwe49155h4dZb4l5ELiAqcrDr90UGRlPyuSPjrHKMtqutmYXW8Kpj40F8hvN65cePBpQ
         s6zLSguqteoSYF8GPOcV/EZF99Fg8Yqf9J6PuuwilH9HM7Uqjq8OY0HMXywJM1olQ+zN
         BGdw5rX8cYu1PPZU/B+DKbAEyg0Hb24UMs3qlN9e3UvGvhr3ZRwpjerBSu0hlBZKSGWR
         eAGjG4Ri2KBY/0EIikybAJ9sA+oxrovGl8W7L/2bmSGYdaVTJdh1NR41RsHkhA5i2E5Z
         L6jw==
X-Forwarded-Encrypted: i=1; AJvYcCVk1LE8CPvERYJfYTd0wstrEkImVOIIv0ttHCwhFg8DqYRAkrCo9PVPFDVAbxaMvYypk9x2GEMc@vger.kernel.org
X-Gm-Message-State: AOJu0YwtM8/X3P+fvKjdK8uKHzaFleQ08xRi9gag+HzDlTjE7TX4fw+t
	98y6LTB+p/HgjChy2RBA8Fkcu4ZcvfTvqI9101JY0UKCf69S8Ley2WIebkjg2Lpo0PcmsjrXJxP
	UCA4BgDeaOHGxYWcFEv84CYILXFuIdhouTFo3Z23lExpYjnebZf0vHE0kyN9k2QQ50EHgycoCvM
	uir3wa4LrkhiQApO46WmtTU8KHtfeNoir9Pw==
X-Gm-Gg: ASbGnctHgZSsDjcRQq+GdhW7RMk96vwGj3djlkV2W7JS8ckc5UJpCww+Oqed7foQz3R
	C0I3wny8M/0AIEUfVjnpE5YAsQbZfsFAa+8N5yI/ZHWLfm8NiU+NHcxr6pwO9wbu8nZzs7k6yRm
	KA8EkeBGTOqpZNo4UPmp82Rhs65sggH4ImgsnqCN6bSkPBg+SjSKdm6Opw
X-Received: by 2002:a05:6300:6a0d:b0:34f:c83b:b3ea with SMTP id adf61e73a8af0-34fc83bbb44mr1329621637.18.1762326718564;
        Tue, 04 Nov 2025 23:11:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF++biCJTOk6UG9a+n/zjnVMPbzdi/vZ0rWWtLLDLagx3HGwaYaeAqOPx45pqAJew1Uc67DsPx4RM9059DYF0Y=
X-Received: by 2002:a05:6300:6a0d:b0:34f:c83b:b3ea with SMTP id
 adf61e73a8af0-34fc83bbb44mr1329591637.18.1762326718188; Tue, 04 Nov 2025
 23:11:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028034357.11055-1-piliu@redhat.com> <20251028034357.11055-2-piliu@redhat.com>
 <f50cd9b8-684c-4f62-a67e-3cde74d1d324@huaweicloud.com>
In-Reply-To: <f50cd9b8-684c-4f62-a67e-3cde74d1d324@huaweicloud.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Wed, 5 Nov 2025 15:11:46 +0800
X-Gm-Features: AWmQ_bla7QzFIqgjKHbFmZnpT29S2vwo0B6GiXswMHGbUvJg3jglSBkiOYj4SDU
Message-ID: <CAF+s44QmUOUeJyuqZuYH_TmYoG9p_OLpm_wUHzyasBOuPnPatw@mail.gmail.com>
Subject: Re: [PATCHv4 2/2] sched/deadline: Walk up cpuset hierarchy to decide
 root domain when hot-unplug
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 10:24=E2=80=AFAM Chen Ridong <chenridong@huaweicloud=
.com> wrote:
>
>
>
> On 2025/10/28 11:43, Pingfan Liu wrote:
> > *** Bug description ***
> > When testing kexec-reboot on a 144 cpus machine with
> > isolcpus=3Dmanaged_irq,domain,1-71,73-143 in kernel command line, I
> > encounter the following bug:
> >
> > [   97.114759] psci: CPU142 killed (polled 0 ms)
> > [   97.333236] Failed to offline CPU143 - error=3D-16
> > [   97.333246] ------------[ cut here ]------------
> > [   97.342682] kernel BUG at kernel/cpu.c:1569!
> > [   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> > [...]
> >
> > In essence, the issue originates from the CPU hot-removal process, not
> > limited to kexec. It can be reproduced by writing a SCHED_DEADLINE
> > program that waits indefinitely on a semaphore, spawning multiple
> > instances to ensure some run on CPU 72, and then offlining CPUs 1=E2=80=
=93143
> > one by one. When attempting this, CPU 143 failed to go offline.
> >   bash -c 'taskset -cp 0 $$ && for i in {1..143}; do echo 0 > /sys/devi=
ces/system/cpu/cpu$i/online 2>/dev/null; done'
> >
> > `
> > *** Issue ***
> > Tracking down this issue, I found that dl_bw_deactivate() returned
> > -EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
> > But that is not the fact, and contributed by the following factors:
> > When a CPU is inactive, cpu_rq()->rd is set to def_root_domain. For an
> > blocked-state deadline task (in this case, "cppc_fie"), it was not
> > migrated to CPU0, and its task_rq() information is stale. So its rq->rd
> > points to def_root_domain instead of the one shared with CPU0.  As a
> > result, its bandwidth is wrongly accounted into a wrong root domain
> > during domain rebuild.
> >
> > The key point is that root_domain is only tracked through active rq->rd=
.
> > To avoid using a global data structure to track all root_domains in the
> > system, there should be a method to locate an active CPU within the
> > corresponding root_domain.
> >
> > *** Solution ***
> > To locate the active cpu, the following rules for deadline
> > sub-system is useful
> >   -1.any cpu belongs to a unique root domain at a given time
> >   -2.DL bandwidth checker ensures that the root domain has active cpus.
> >
> > Now, let's examine the blocked-state task P.
> > If P is attached to a cpuset that is a partition root, it is
> > straightforward to find an active CPU.
> > If P is attached to a cpuset that has changed from 'root' to 'member',
> > the active CPUs are grouped into the parent root domain. Naturally, the
> > CPUs' capacity and reserved DL bandwidth are taken into account in the
> > ancestor root domain. (In practice, it may be unsafe to attach P to an
> > arbitrary root domain, since that domain may lack sufficient DL
> > bandwidth for P.) Again, it is straightforward to find an active CPU in
> > the ancestor root domain.
> >
> > This patch groups CPUs into isolated and housekeeping sets. For the
> > housekeeping group, it walks up the cpuset hierarchy to find active CPU=
s
> > in P's root domain and retrieves the valid rd from cpu_rq(cpu)->rd.
> >
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: "Michal Koutn=C3=BD" <mkoutny@suse.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Pierre Gondois <pierre.gondois@arm.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > To: cgroups@vger.kernel.org
> > To: linux-kernel@vger.kernel.org
> > ---
> > v3 -> v4:
> > rename function with cpuset_ prefix
> > improve commit log
> >
> >  include/linux/cpuset.h  | 18 ++++++++++++++++++
> >  kernel/cgroup/cpuset.c  | 26 ++++++++++++++++++++++++++
> >  kernel/sched/deadline.c | 30 ++++++++++++++++++++++++------
> >  3 files changed, 68 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> > index 2ddb256187b51..d4da93e51b37b 100644
> > --- a/include/linux/cpuset.h
> > +++ b/include/linux/cpuset.h
> > @@ -12,6 +12,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/sched/topology.h>
> >  #include <linux/sched/task.h>
> > +#include <linux/sched/housekeeping.h>
> >  #include <linux/cpumask.h>
> >  #include <linux/nodemask.h>
> >  #include <linux/mm.h>
> > @@ -130,6 +131,7 @@ extern void rebuild_sched_domains(void);
> >
> >  extern void cpuset_print_current_mems_allowed(void);
> >  extern void cpuset_reset_sched_domains(void);
> > +extern void cpuset_get_task_effective_cpus(struct task_struct *p, stru=
ct cpumask *cpus);
> >
> >  /*
> >   * read_mems_allowed_begin is required when making decisions involving
> > @@ -276,6 +278,22 @@ static inline void cpuset_reset_sched_domains(void=
)
> >       partition_sched_domains(1, NULL, NULL);
> >  }
> >
> > +static inline void cpuset_get_task_effective_cpus(struct task_struct *=
p,
> > +             struct cpumask *cpus)
> > +{
> > +     const struct cpumask *hk_msk;
> > +
> > +     hk_msk =3D housekeeping_cpumask(HK_TYPE_DOMAIN);
> > +     if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> > +             if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
> > +                     /* isolated cpus belong to a root domain */
> > +                     cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> > +                     return;
> > +             }
> > +     }
> > +     cpumask_and(cpus, cpu_active_mask, hk_msk);
> > +}
> > +
> >  static inline void cpuset_print_current_mems_allowed(void)
> >  {
> >  }
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 27adb04df675d..6ad88018f1a4e 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -1102,6 +1102,32 @@ void cpuset_reset_sched_domains(void)
> >       mutex_unlock(&cpuset_mutex);
> >  }
> >
> > +/* caller hold RCU read lock */
> > +void cpuset_get_task_effective_cpus(struct task_struct *p, struct cpum=
ask *cpus)
> > +{
> > +     const struct cpumask *hk_msk;
> > +     struct cpuset *cs;
> > +
> > +     hk_msk =3D housekeeping_cpumask(HK_TYPE_DOMAIN);
> > +     if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> > +             if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
> > +                     /* isolated cpus belong to a root domain */
> > +                     cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> > +                     return;
> > +             }
> > +     }
> > +     /* In HK_TYPE_DOMAIN, cpuset can be applied */
> > +     cs =3D task_cs(p);
> > +     while (cs !=3D &top_cpuset) {
> > +             if (is_sched_load_balance(cs))
> > +                     break;
> > +             cs =3D parent_cs(cs);
> > +     }
> > +
> > +     /* For top_cpuset, its effective_cpus does not exclude isolated c=
pu */
> > +     cpumask_and(cpus, cs->effective_cpus, hk_msk);
> > +}
> > +
>
> It seems cpuset_cpus_allowed functions is enough for you, no new function=
s need to be introduced.
>

Ah! Yes, it is good enough.

Best Regards,

Pingfan


