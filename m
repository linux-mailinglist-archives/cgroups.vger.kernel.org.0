Return-Path: <cgroups+bounces-16074-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PbjE085DGq2aAUAu9opvQ
	(envelope-from <cgroups+bounces-16074-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 12:19:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9D557C12D
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 12:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBE343081788
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 10:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E05E4A139A;
	Tue, 19 May 2026 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oasfIcAH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155B448095F
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185650; cv=pass; b=coxWVMY33LDU62dcJjIpkdP+LpOmqFkfTOIFb5PqgP89rDC3EiVWa3qRbK8nzBOYKAO2GaBctf66ZR0wtsECQvduNP72xHIia/U+7CxVdAKbuswK73IFMBaGg0BFT6/vBW3bic+t74k4NKsa4c4wA2zZ4HGPw6GLarKnxY9RWAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185650; c=relaxed/simple;
	bh=BiUhQiqTNsAnmF7cBeR3CtnZ47mP0VUOZjjnzjoIyLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggdWFPtWdY59HBQoN4f1SSU2YF7vXtG23Lb/01VaHRTjN3JQ+wuifHwBzFycSNMJKASPXGptnBZwyNAvIJq7vLkT4buQ9i0w1h5o4/esOdyicXAWUbqwG2JvrZKZMRNUfDj5rkBldMxuXaO3iV8OhgVEDBCzqmxeXVhAqZvhk0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oasfIcAH; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-678a16429c6so6161763a12.1
        for <cgroups@vger.kernel.org>; Tue, 19 May 2026 03:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779185642; cv=none;
        d=google.com; s=arc-20240605;
        b=YoaARLWX2+sCkwzUZTJx9wVjsHcsDeCRTIM6cjw3afPu/JmfuFLMXTBRwuBurectSZ
         /mN+3leF652UnWvJyI4IYSt07YjersaKzAVHkm+Wev1DkQTPtIxR1xzrgnKq3jJW2L86
         ubX+fkz3MeDYatgHnCVkh08rAzVcGZIIyorCgdu/F2Thmx72C6EHfs4qUFK068Md5fBy
         p0u5yX6c/dOHCcW2j4TNgWd6sSKmqA3l0PefuGNQhLqTNc1JzTp1nb13ImOaQWfo1D2t
         3o/YxSRnCxgQ1vkvDNJHmqKahx4XBx8ZQeJWTRqgkm8BrC3UjEVp6hjdEUmOR5XyoqWy
         /IYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sImMZCHVs04cO/e2h5ZkxUyKDqpFuDvkqqgOv1WIdB0=;
        fh=9Z5ZylgPxbeTF5TX56APfIZ+9tdIdP3dvKP2TS+zbBQ=;
        b=XpUvrj6YN4pWOM8twKX87hYaO8CmaHpsewO4+/qhHjAQds7hR9p5aI6Z1VTo9XbMbx
         zJb2qflg1MBBZaluQPwK3vlU5KEiqtQ0LhOEFt/IP3I/yxUub7m6X1eJ2GuXzy3SKPN4
         Oyd3Ixkr2LeD2Ic1GF7EJzPSjS6w78J0ss5ld9H5ixyHAVWrFApOVKuZgzlil0EQmlz5
         VaBRURtOk7VJ1HN8uloN16J90zTrXKNcZFSxiUTrXavLyJ1Vpw7dm9I2gPncNNy8ewl/
         SAfjQzBH9YQZly+pv5ZAtu6zONH1Exr4ByQ42KEgBHvO3Bo+skaQXtzr9DAt+dJi74JU
         MZjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779185642; x=1779790442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sImMZCHVs04cO/e2h5ZkxUyKDqpFuDvkqqgOv1WIdB0=;
        b=oasfIcAHRAHWKFOYlUsNFdGRpssoE8D1FqHscjtn3j3znrnR8Ltbqmy8JJDFvr0Rt/
         GpMutDj/J4v/t64qbdZNUfgKZs3O9e1mE2odvMaipNcRzsOq3ZHyvog349JprH1RSijA
         CEmBYwtXn3V+dbhBs6xrW9xD7BiF2fioigtuxbXRYdXsOnqarYLu0Ud7ZUe9X2SBV7gH
         /rszax6SztkzxCOYxd1HZ+9nq+ncq/v5CBbsofuzz6CNVMjazxcNaSP79JfdNEwgaRE9
         jAR+ycbZxOoZtQQMlP7qy5TfKbeFUCGZ8oT9UZFcGgqOSBchdUk9oVZdZzHol0xVYg6Z
         NN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779185642; x=1779790442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sImMZCHVs04cO/e2h5ZkxUyKDqpFuDvkqqgOv1WIdB0=;
        b=rh23618NjbmrnfQqUlHyM7I7ih4zHvhS/W+1CG6yt3ZTzf1lmWYlNiAyXT1MaG9/sJ
         fZrHZpsooHLtRtv53lR5G6n76nVhfKAd9gVK732gscbCQTa3DRoh5fqdAk5maYrOd4rV
         rVf+mP0blEtJK34IyEItEn09Zfou6j0IcxhKrDVt0umCDwSn/xMAd28xFkKH9HHTlR58
         fIPx+XM9n9F75RRq1lCz887aaxcvaC0gwMyoIhL1ZNwUPPZeKg94qlnXYpQnUltTCGP3
         +03nkhIan7vktjBa7PxnDFlcofVrHkHl3MEfZhVgAzrG1G3+6/2JPmp5NQbaO8d88yDu
         Kqtw==
X-Forwarded-Encrypted: i=1; AFNElJ/BgkyjXXcnoCP3ysvx9Q9cv/pnL/XqAcgHiqsvpbWtmKPIIq9hYu5m3nJAlZ7iHt5kKA4ndZIa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4x8/6iE6KSEVDrZj0xCbAf4FXDIpU4udGl9N5ijsU4iMkCy1H
	mbZw34h7++eihO4TXC9BbgdVLxcKgUXckjnAHedF+SCieK8BQwtqvUayh1cjSHvkmX+N19Ny6YA
	DauCaCJ1shsJmVwvBpyyyuh+2J41aoE85+623ZuwNAw==
X-Gm-Gg: Acq92OEZKY0PP59JB4TSYHtJx8oZgij+au9NaLPRdY9QX8P2iCe+dZGs58OWokByRiG
	KXonRf9jbUux3/MPf0bLIw3oWL6Gktf+5SNgLoOupFL1XBoN0ns30yZjvfloRCG27byVkBqCMfS
	3FvueEcla0w0HIWpjpRpiM9566pjp3h9U7COjDbDzt9OBcetF5+pRVF/yNATnsMQ5aQDQnKYf8D
	K1vBpRu/yKQH8PsXDWDCJQ6mPh08/3mVnNHNxun6+b10s5g/hfUi837tmboK6N8hd2UyfJmj1EU
	h2le4kzBsUpaZ9Ng7igNQLPAjyYM/xgDOZoP
X-Received: by 2002:a05:6402:5155:b0:67d:98bd:e44e with SMTP id
 4fb4d7f45d1cf-6830b5162bfmr8321860a12.17.1779185642155; Tue, 19 May 2026
 03:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113104.563854162@infradead.org> <CAKfTPtA2aBtuBffVV02VgsRRi5mRK0G5ununzuvJ7h7buygNxg@mail.gmail.com>
 <20260513113510.GK1889694@noisy.programming.kicks-ass.net>
 <CAKfTPtCXOnjtVV1gKLnbS8Lo6W4r8hbdUDYVYLMd2Qc1ZqBq4w@mail.gmail.com> <20260518211239.GY3102624@noisy.programming.kicks-ass.net>
In-Reply-To: <20260518211239.GY3102624@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 19 May 2026 12:13:50 +0200
X-Gm-Features: AVHnY4Ikqhu9U8MnlHhp-dsSQU3TkizQ37Bast-gbvk6lCBFRpPLUspzaJbpph4
Message-ID: <CAKfTPtBF5UX_0_zvOpBwz9ZDZWcgGzAZC+ansyA8LVP58v6SAQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16074-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,infradead.org:email,linaro.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Queue-Id: BA9D557C12D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 at 23:12, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 18, 2026 at 03:34:51PM +0200, Vincent Guittot wrote:
> > On Wed, 13 May 2026 at 13:35, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, May 12, 2026 at 10:42:33AM +0200, Vincent Guittot wrote:
> > >
> > > > I haven't reviewed the patches yet but I ran some tests with it while
> > > > testing sched latency related changes for short slice wakeup
> > > > preemption. I have some large hackbench regressions with this series
> > > > on HMP system with and without EAS. those figures are unexpected
> > > > because the benchs run on root cfs
> > > >
> > > > One example with hackbench 8 groups thread pipe
> > > > tip/sched/core  tip/sched/core          +this patchset          +this patchset
> > > > slice 2.8ms     16ms                    2.8ms                   16ms
> > > > dragonboard rb5 with EAS
> > > > 0,748(+/-4,6%)  0,621(+/-3.6%) +17%     1,915(+/-7.9%) -156%
> > > > 0,689(+/- 9.1%) +8%
> > > >
> > > > radxa orion6 HMP without EAS
> > > > 0,588(+/-5.8%)  0,677(+/-5.9%) -15%     1,505(+/-10%) -156%
> > > > 1,071(+/-5.9%) -82%
> > > >
> > > > Increasing the slice partly removes regressions but tis is surprising
> > > > because the bench runs at root cfs and I thought that results will not
> > > > change in such a case
> > >
> > > D'oh :/
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index e54da4c6c945..77d0e1937f2c 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -9071,7 +9071,7 @@ static void wakeup_preempt_fair(struct rq *rq, struct task_struct *p, int wake_f
> > >         enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_PICK;
> > >         struct task_struct *donor = rq->donor;
> > >         struct sched_entity *nse, *se = &donor->se, *pse = &p->se;
> > > -       struct cfs_rq *cfs_rq = task_cfs_rq(donor);
> > > +       struct cfs_rq *cfs_rq = &rq->cfs;
> >
> > I tested this patch on top of the series but it doesn't fix the perf
> > regression on rb5
> >
> > hackbench 8 groups thread pipe is still at 1.907(+/-7.6%) with default
> > slice duration
>
> Weird, I can't reproduce anymore with this fixed :/
>
> I'll try more hackbench variants tomorrow I suppose.

I tried several conf :
- HMP with EAS enabled
- HMP without EAS enabled (perf cpufreq gov)
- SMP (only the 4 little cores)

All of them show large regressions with hackbench which are almost
recovered when increasing the slice from 2.8 to 16ms

