Return-Path: <cgroups+bounces-16034-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OXzEmsWC2o5/wQAu9opvQ
	(envelope-from <cgroups+bounces-16034-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 15:38:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E6D56DC64
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 15:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE2EA303D31B
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 13:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F8F36D9FA;
	Mon, 18 May 2026 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b5HQwOJx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF642E414
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111306; cv=pass; b=jUZFB7PFOs65WuO6UJCoi7PEWWHDtPZIaXOBRb+0YA2WnHuNsC5aj/HpkuvkkQi5mMIJQAixovj60M5RFBgLcQ80VobDMwsbVu9sLq43eBlrioJeqS2B3sveVxQEK5TmgiIzQjnRePWWHYjU8sPX7hCIZy/v+aBXtp5NSkSDkOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111306; c=relaxed/simple;
	bh=vqDcuvJnyLCFUeKqWAAraJIv+bNx9RR+sTJV1me6NkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pc5JZ3kgsTAr/8cpZu6EVEuhgpdrWB2ETHUivS7cy1WxGq+gmnJ9Vd4N/f+kcwkKuOHO8801ZetQnCMVjH4UtTYunxemnK1wXp3FsJ2sBp+Ksj7hnDfMwakSxf6gEKdd9cx37TPdEOerWsss0zlxBGEG9heUioSCN//aD5vo24U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b5HQwOJx; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67bb5ad91bfso5527276a12.0
        for <cgroups@vger.kernel.org>; Mon, 18 May 2026 06:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779111303; cv=none;
        d=google.com; s=arc-20240605;
        b=gXYhRDbZh74zXUMYT9Gbc0soaKDPuPdSLyIqOLJ5ySDN3ytPXwyhvNT+6IgiiB/yZS
         SEV8kDtTy4f6Zd6Pn+ukDWAmOZt8xLoRkfuosPnQ9NVWSBSayxEoTE7IKH86l7OX1ugz
         Uy9C6mMxDXyiQ6v+pmwl3geijp48ViV7dyxnBGedqF9H33Vm4w8wxtGV4FXpGJNyufPJ
         V0srt8oYhR/1v27TW7gmzgn3RyTjJQygC4mavf7uKwCsKv8M1frIjXujphDQmQH+zEu1
         WRSs5qdlGLVqHyk/AT4Er5BY/oFZzTj/zQxm1t+i9JgKOwi+Hn2zYd+kp5on4zJLYla2
         jnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xaUCvif8hvq+wr5uXGFODLAPSlZgOj+Z5tK8AeOieUY=;
        fh=VoSQL8SFzKFI8g/FGIXosa1Sk6U2vSqBce9h8ly+QmM=;
        b=iHcrCdrUj70rcNKVi9uhWhxuiST29bbUPIzhfGnBuy3StN7gOBKRwkzdMhBsuImZUB
         KWGCNmrcQ6IMCf2FKJiwhT80DdtYrXG1CpW4s5cXATMz0xv47LBrWzmYyLvYfYxGZr+9
         h9EhLjRyF+tPoAeBSf7zyYxbQbH5KpEGY9O4zwHHNuz0tiU5GzntOwbOyGG6zxqk065Z
         pzBDCNafNZ3YZSY5rONkmjMNS5qNOM+vIkkkLThGSmKn2A7uGWZZsuN8ByXt836QTjJ/
         T45gPqzBrCYFZC/HtUmBKzkaa7Wn497U24OxxBwrZoGmcsq2pGsLJfQNq83iyYm3nVsh
         TnWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779111303; x=1779716103; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xaUCvif8hvq+wr5uXGFODLAPSlZgOj+Z5tK8AeOieUY=;
        b=b5HQwOJx5uIx7ePpXHCwBfpDWwg7TS3RBRQTZj8umyiTFK1sBViouSZqXuX8neUB+M
         +UxLDcFB4+ob3PapOEeBg0BbzruLaglI1g/+hYGtTwq95oOgCnrNttN2FkG2pMxdb+85
         Pdst4uxb6Ldl/XDFObnBfR1A1NqqsnxdUL+5m9nk6doHIBqnQN871SwaWKA3WF0tKM5T
         i9BZDupOlkLC7HJX5LBZ5ecmHoeR6SzSoyI8lmEPP+T2oAykj2wd/Nz3wWUQ0awuyn1U
         1osyeUYLCaPUeBB54VRlmrX/bRj88IXOSbaA3NPBLyUbq1VAtasovVVs2cKlsewHZau6
         aPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111303; x=1779716103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaUCvif8hvq+wr5uXGFODLAPSlZgOj+Z5tK8AeOieUY=;
        b=s2FgxZNwUaHxFYd0lYxIqOFYtNQGgkRqC/gjdDOkEFmwcsoGptrjf6cSFyNnW9DHUi
         JZZLeV8Z194i3hXaagq2I9DrhYptHrrXhrc+a5fHD/DZqa1skgDemj2WdGJE88mU35JZ
         4AyVYKJKK8Ci/MuRQgegy9Cs9f/+sLXUrtIoIPAnIxL5yF7SL40OetsAe8udx7Jw5kZO
         38EFZj8Mmp8FASOzdiPcZLsk3e3BQRismgs4Opd+t1LS5oAJ6wuA6DJyf2Tc+K1RbQG2
         SkTxh2yvOaaQbyUF8BAZPEtKchVBOr41RgB02C2WHEq5/Lr1OHDkMqyiVEP9aXnwiaS8
         4g9A==
X-Forwarded-Encrypted: i=1; AFNElJ8r8ET05OsU0LxSbMcJXeh9Wp/JTNdXH5cvgO3M7A5mT3BONLBwTUoT8HBOCCfQL5nLjlq/mA5z@vger.kernel.org
X-Gm-Message-State: AOJu0YyeIMAUL1ABYyvzY5OhtjffRXsQlxwQRGhSubOIVDUBzp5WmutO
	0/ZhURgOuh1ZOIr4POAPDpxyIFCr68lNavuGvUu3JbOge2oe6G6jAF1vbi1AIvh2D1BWlsCyzPP
	rKIbzDuOKovZq4NTwubL1ZayKL6sqiuAXADOU6goZow==
X-Gm-Gg: Acq92OHWwuEsY/QeVnSk3L8u5BDP+FGj5XJSF+mzW9rEbCbksqC1Z+ckAeNdeZI+XuT
	LJFddLH1/PsYqszP092WPp7mFVMAKuGeb1WuCg460UNmbBNADWzWq/IkXHHj7JsjiD+sXdxw5lx
	C0bOeiQ8OUkIC99SgJfHSmyDL8SLSeXuh42/5CsPOWtdatQAdSiCVZJso2XADGWT6FoBSEIyrSS
	0xHorqnAhuh7GhvBbEt9VlkaX4b7Uf3Redt2u++ia25zMsCtGmJOixjAIsOY4ZeHNrzXTdszw91
	LVaeNRe02NLaBnt+SCbt5yKZxgQu65PAu8A=
X-Received: by 2002:a05:6402:370d:b0:683:a318:a3fd with SMTP id
 4fb4d7f45d1cf-683bc9ab74cmr7754485a12.1.1779111303169; Mon, 18 May 2026
 06:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113104.563854162@infradead.org> <CAKfTPtA2aBtuBffVV02VgsRRi5mRK0G5ununzuvJ7h7buygNxg@mail.gmail.com>
 <20260513113510.GK1889694@noisy.programming.kicks-ass.net>
In-Reply-To: <20260513113510.GK1889694@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 18 May 2026 15:34:51 +0200
X-Gm-Features: AVHnY4J4TselX1EJm1X42arFmvCYeSTZeyprWB6VDtQy-EtRwBZw2ub3KG0UjOM
Message-ID: <CAKfTPtCXOnjtVV1gKLnbS8Lo6W4r8hbdUDYVYLMd2Qc1ZqBq4w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] sched: Flatten the pick
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, 
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jstultz@google.com, kprateek.nayak@amd.com, 
	qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16034-lists,cgroups=lfdr.de];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Queue-Id: C0E6D56DC64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 13 May 2026 at 13:35, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, May 12, 2026 at 10:42:33AM +0200, Vincent Guittot wrote:
>
> > I haven't reviewed the patches yet but I ran some tests with it while
> > testing sched latency related changes for short slice wakeup
> > preemption. I have some large hackbench regressions with this series
> > on HMP system with and without EAS. those figures are unexpected
> > because the benchs run on root cfs
> >
> > One example with hackbench 8 groups thread pipe
> > tip/sched/core  tip/sched/core          +this patchset          +this patchset
> > slice 2.8ms     16ms                    2.8ms                   16ms
> > dragonboard rb5 with EAS
> > 0,748(+/-4,6%)  0,621(+/-3.6%) +17%     1,915(+/-7.9%) -156%
> > 0,689(+/- 9.1%) +8%
> >
> > radxa orion6 HMP without EAS
> > 0,588(+/-5.8%)  0,677(+/-5.9%) -15%     1,505(+/-10%) -156%
> > 1,071(+/-5.9%) -82%
> >
> > Increasing the slice partly removes regressions but tis is surprising
> > because the bench runs at root cfs and I thought that results will not
> > change in such a case
>
> D'oh :/
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e54da4c6c945..77d0e1937f2c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9071,7 +9071,7 @@ static void wakeup_preempt_fair(struct rq *rq, struct task_struct *p, int wake_f
>         enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_PICK;
>         struct task_struct *donor = rq->donor;
>         struct sched_entity *nse, *se = &donor->se, *pse = &p->se;
> -       struct cfs_rq *cfs_rq = task_cfs_rq(donor);
> +       struct cfs_rq *cfs_rq = &rq->cfs;

I tested this patch on top of the series but it doesn't fix the perf
regression on rb5

hackbench 8 groups thread pipe is still at 1.907(+/-7.6%) with default
slice duration

>         int cse_is_idle, pse_is_idle;
>
>         /*

