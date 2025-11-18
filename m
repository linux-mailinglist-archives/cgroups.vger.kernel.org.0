Return-Path: <cgroups+bounces-12052-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E89C67BC1
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 07:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF9FD361495
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 06:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D032E7180;
	Tue, 18 Nov 2025 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flBp46r9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pkNnkeDR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789911E9B1A
	for <cgroups@vger.kernel.org>; Tue, 18 Nov 2025 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763447460; cv=none; b=ZCeOlyu7wR5FZqVzGpH32JDR0/Yx++3gPNaddhPhdlPybYRu6Z+XYat4iSlF2Pno9Q5IW77bqH9mCh/BL2/uBuEVrRL4fe9iNFwroxedmOjbtnJSXg6MExgu3+EKdQt/jr/giE1HJdjxu8KAZITA7t1uGcgSfy976prGsxMimCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763447460; c=relaxed/simple;
	bh=pgiz/sV7bgeD0OwI5WljJoXC4EvKfNYlOwARIcPyhSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYPjN1xl3TdPAEqMRXr096og9qhM0zmzS+mfhKOsfMcmYnnpUZ+R90RT17AfE2BojKm75zZak7x+r/M86VUAS7+TgJmomeyTzI1N7NHmgI8SuLYQP19SX6g04WcJFB0mWOomZANdTClNAap/W+lyaTUcgVoTUyyhCmLufogXknY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=flBp46r9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pkNnkeDR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763447457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QY44smSdvK1wQ3q05guYHRyux7pWoGLOc2MYPa7y6M4=;
	b=flBp46r9/I5f2mp78FILIO3QYSKkg/qKb3SGOXpvkB6qVf2AtGu8zQj8Y0UF1tA0csyHhn
	bJwCFHEk2wdsrQgzz4CIhnUgW7Z178EEPPHxzPOJtsyD72UhWJatYydCCF7cNLKk+BOJjC
	9qgem2XtNUjmu8+565WgUNa8v7Ng4bw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-CdT2oqCENbaaDaF1tzAI1Q-1; Tue, 18 Nov 2025 01:30:55 -0500
X-MC-Unique: CdT2oqCENbaaDaF1tzAI1Q-1
X-Mimecast-MFC-AGG-ID: CdT2oqCENbaaDaF1tzAI1Q_1763447454
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-bcecfea0e8aso2129646a12.0
        for <cgroups@vger.kernel.org>; Mon, 17 Nov 2025 22:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763447454; x=1764052254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QY44smSdvK1wQ3q05guYHRyux7pWoGLOc2MYPa7y6M4=;
        b=pkNnkeDRUL8oX6fY75LHAs+tFfb1zTv5ovXtq4gwCzMbcik5EHY6mNgGZOoAVxNcip
         doe6S5yrKmTCvN/MuMPWa2l0xFQjEMub7jc12s0c9BHAyNohXKqe2oC+i7H5OYHXy8kG
         Z/uPU45vmhouQ/1D+h1OU708Lfg69q9US20S4IrOTZCJ/koNChKh1hrZWrxDeVf/R6Wy
         DILn3a3UzZ9ND3tKZBIgC2eDlW9kH4KidUyBjsqpG8rIkabfpdFUW/uWIQbfzg4iYADj
         BFwj8qYjy+U/ZFu1GATdGL7plcWzrgVzxHTIsUdIsDsAzXRiO9/MOd9DOAm9VVVAkwBU
         7NXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763447454; x=1764052254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QY44smSdvK1wQ3q05guYHRyux7pWoGLOc2MYPa7y6M4=;
        b=c/OXK009ctq00xheZTy/d09g6BYRj1bV5Fv0BO/e+Dn2oVmCqIZn1DpVlwJpaZcd4X
         /tGLMHfAFS9zh513EM7oj1rgO+Ieg7MOoENqZkxRdO2iA+nc7r1JSPulFELQrTKcl2DI
         Z72ToGT5hICnr/OJmiGV8qFP7mWKKMC31f4W6jJCdXcQLk9LhsjcSu7XvQFi7X1nx8G1
         32LLjHNXTiOcrQEdkPfBVCqjc5BoYFFdcI+DI7TvSwjZ5CYTEm/kN7NXNCcvUVjZRiJ0
         JfIhdc/HXW7F/Gg7JraFFOtN5RUaj/fzYNkt75Whxp4+JRuN2joqnjaO+PQnsjZBedyZ
         QCpA==
X-Gm-Message-State: AOJu0Yx6zGqt4AOzU1ar4muh809ZAIlBVv9P9jhCaYSC4Od96/V4h/23
	mrCu/Cq1nc0/nW1EzU5P+JqZ4cBG5PyNJk6yQ09jk/QVqUYGFYUUmYQTHDDQNahtCttWAIjt8BF
	htUg92huyGPZuP2HySbAIYGkCV82mPtJG/e+W1BPI9H08bUJiWCBzCRJrxmsINx1HtroP88LXUU
	ASSZhY36E3a29AHu4tHKlK79MABGf1g2NjDg==
X-Gm-Gg: ASbGnctsWemZy05FZ+FdKxgLDTLpHths8VSzFbDoW59Loy+niJywkyHhxnjGZyY6b0E
	CR3UTcF8YHYF0ysbGra1oagtB+QiqnEsIh0CN69jv+BhfagblkqzUv6MInL0BEwqgyqsKmZ+FI6
	eSbHOa4vavyjq+bl2T2cYyf1IPYBWAnN3UcgWOGoB8Ly/Qz89dStAvpR85
X-Received: by 2002:a05:693c:8099:b0:2a4:7dbd:1d7a with SMTP id 5a478bee46e88-2a6c71ad5eemr682234eec.11.1763447453647;
        Mon, 17 Nov 2025 22:30:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLFqXegjR61fkYUX0VGeOPkrPyUrQxHkD8/vOectHuDaomlIInTH99lAZh8M+sdAvkeZ/R/vbiqH42732uSDg=
X-Received: by 2002:a05:693c:8099:b0:2a4:7dbd:1d7a with SMTP id
 5a478bee46e88-2a6c71ad5eemr682219eec.11.1763447453197; Mon, 17 Nov 2025
 22:30:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117092732.16419-1-piliu@redhat.com> <20251117092732.16419-2-piliu@redhat.com>
 <97ec2e86-cb4f-4467-8930-d390519f12a6@redhat.com>
In-Reply-To: <97ec2e86-cb4f-4467-8930-d390519f12a6@redhat.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 18 Nov 2025 14:30:42 +0800
X-Gm-Features: AWmQ_bn2bVCLXzrG7aYHJDTqzt5yhS1hHhzvPZ2G4gZebpVApzcygrm_RETfCug
Message-ID: <CAF+s44SAPA+PgKBGHd_5853JOHyFxLasKXYegJSWyrkKsDYg1w@mail.gmail.com>
Subject: Re: [PATCHv6 1/2] cgroup/cpuset: Introduce cpuset_cpus_allowed_locked()
To: Waiman Long <llong@redhat.com>
Cc: cgroups@vger.kernel.org, Chen Ridong <chenridong@huaweicloud.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 4:37=E2=80=AFAM Waiman Long <llong@redhat.com> wrot=
e:
>
> On 11/17/25 4:27 AM, Pingfan Liu wrote:
> > cpuset_cpus_allowed() uses a reader lock that is sleepable under RT,
> > which means it cannot be called inside raw_spin_lock_t context.
> >
> > Introduce a new cpuset_cpus_allowed_locked() helper that performs the
> > same function as cpuset_cpus_allowed() except that the caller must have
> > acquired the cpuset_mutex so that no further locking will be needed.
> >
> > Suggested-by: Waiman Long <longman@redhat.com>
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: "Michal Koutn=C3=BD" <mkoutny@suse.com>
> > Cc: linux-kernel@vger.kernel.org
> > To: cgroups@vger.kernel.org
> > ---
> >   include/linux/cpuset.h |  1 +
> >   kernel/cgroup/cpuset.c | 51 +++++++++++++++++++++++++++++------------=
-
> >   2 files changed, 37 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> > index 2ddb256187b51..e057a3123791e 100644
> > --- a/include/linux/cpuset.h
> > +++ b/include/linux/cpuset.h
> > @@ -75,6 +75,7 @@ extern void dec_dl_tasks_cs(struct task_struct *task)=
;
> >   extern void cpuset_lock(void);
> >   extern void cpuset_unlock(void);
> >   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask=
 *mask);
> > +extern void cpuset_cpus_allowed_locked(struct task_struct *p, struct c=
pumask *mask);
> >   extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
> >   extern bool cpuset_cpu_is_isolated(int cpu);
> >   extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
>
> Ah, the following code should be added to to !CONFIG_CPUSETS section
> after cpuset_cpus_allowed().
>
> #define cpuset_cpus_allowed_locked(p, m)  cpuset_cpus_allowed(p, m)
>
> Or you can add another inline function that just calls
> cpuset_cpus_allowed().
>

It may be better to make cpuset_cpus_allowed() call
cpuset_cpus_allowed_locked(), following the call chain used under
CONFIG_CPUSETS case.

Thanks,

Pingfan


