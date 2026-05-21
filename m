Return-Path: <cgroups+bounces-16163-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKmnDvUXD2o1FgYAu9opvQ
	(envelope-from <cgroups+bounces-16163-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 16:34:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAD05A75DE
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 16:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1897D33C3CC1
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C86F3D6CD9;
	Thu, 21 May 2026 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Im+X49ZT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34693D16EC
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371810; cv=pass; b=gVnVgZEM0/GzQ4qLcBR4siHFMVYzuqjdw5GhMsEnCdbbHyr7w44P+gA+sLJvmFbf7N1DI7WuFRMZE+nc8QJWbNQkxxBDlJQJhFib2sDSMk9g8NPII01gAOhEc16mMf96EoMxwNafVKvv1mH9/jHq0lHDFu7Kte1GmOdvfTOPc8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371810; c=relaxed/simple;
	bh=yufvGt6FtQFMtCbsNbp0LiUpTVY5RdY4WdLC4Pv1vT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byWTuAOdZ5YsxHOPxIhgBo69zgHT73mLne7WwAalNhljdEZtNyIii2RyGAksZc4eErfy9fXkcZYcfOT73t71BA5WlXDkC9/kGwEYpADVW6efRuVn+bkjKQFfh4KF+hero96R2lmmPi2+cTEngeZvXMtlzQFZe/UCNsGchQrFAjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Im+X49ZT; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67fd8befac7so14077930a12.2
        for <cgroups@vger.kernel.org>; Thu, 21 May 2026 06:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779371807; cv=none;
        d=google.com; s=arc-20240605;
        b=K686QoxX/ZKc388Vb/AyEJwYEzh+CTJKfZZFfzKaxg14yNvI/cvo/4CYZwgDltg7C3
         /JsG7OvWkPd2klZQEQ9dxQDxy3KVkSBniTMcyZO9UIm1BV+ENkHfVeBiWZppoxnswxKg
         weEvJgxDsFfKSHwbjW6lD5BqhRcQuuYH7U/hteX4APVPyWMOFcS6b5uqhyjvGPQOfo5A
         JIbp6ngNH6q0FtO8bzJ8E82QRMkyYRNPs8RIwCvxUWV4askPsyc2qCLB+0ooiGflStlw
         JQsygJMi9fhidC0bCy8MtvRMB9j/Z3P3+W7uXvKZ83uRyTQoKxzEaw4n3GyhcbMl0Ddb
         F9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yBFGpaIMGX31aRh6G2+QEoZOzbjDfNO1aBMie6wTtws=;
        fh=gHuiCf6k89j3FkmHOLd0viNprjCJ7O434Ymm8o8NUT8=;
        b=Mg9S2v3Eh4YvPZqpP7uwtoRN5+tzAvM1kO9uPr5qp70D1ZtV4tKPp4lB4oglYcWwJv
         FgcddiWMTbHp7FpPX/nalUurTPr70dW6opJmdJCfvHnVROfVweLqf8YUu75MvS1eLmSU
         6Spq6qzCR+Ra+U/ggQdT+o9/m5x5GUZYyx2IKHYhF94kOzPgMng9Z/6fcGj6pOqPM8KL
         VbdexzWUxbxCs2hTWMKNnnheaSwQvL65E0gO4bN8kIKSq7PCCVl8BbrPgsUrIGU4u++5
         q3dq+GMufkd95pJocauN01hgsmfLtDqvnVRSFtMmkdjDdhobBe7aks3mU7ENy1pdPJof
         ATpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779371807; x=1779976607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yBFGpaIMGX31aRh6G2+QEoZOzbjDfNO1aBMie6wTtws=;
        b=Im+X49ZTFfsswZGCzpzY7KJt5GQfg7mlBlEKpUZxTlUcm/YGhSamtEAB6QuNOg0wwr
         nho6Qrcj2iJPJs2HEiq12hYgbupZd1LZ/6vgSIptwougon0G5CPfYLH+/xpteYcRem1P
         zUiCCMK6XrUJongZJNSo0JwKxYaPUn0utcS4ROIUEKCoxu1vF28dBuDAOmimiolhiX7d
         FLtg08cQDEE+Xs/zjqAQHwXqFur0a3GbaveuYEZKjQC/TX+QpTK5utctMkoy6zi4gOhZ
         jDjHY93FvofWL8MDyixoRBDXBOe2yGqLih6bHfBlfoDjB6tq5w9RYN2xAqbKiFss/vEJ
         JoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371807; x=1779976607;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBFGpaIMGX31aRh6G2+QEoZOzbjDfNO1aBMie6wTtws=;
        b=OoZ2U3BkNeh6EceOu+OhlOS64J2C4FBo4rzouOE3XWx8whKqmQtxau9v3BkiXADXS+
         HtUcZxbrSYC54CkCvFA5Qn2B/Q1w9dZTZGUwdqMa5olDGdJNQSqJy8BfTkfiOVfLhtzw
         1bGkjJMaxAp5/DYoqkrbbI4YN9ndn7WlwEmiuy20dvr3EBkhXO7NdJFZs0OJCxZoVkvB
         GhlJf6n2jGR2I2ZZYBbfp8Os+zVh9p++/ZEWCSrOM9IyAcDD5oMVPDc4AhPqtAbiwGd5
         ROIWjH2bI/Xpl9weEVvnAKrgoPf3T2YDbHFRMUP5mjEwhHrQN4i/EDsRxvksq9K4cdzB
         /oUw==
X-Forwarded-Encrypted: i=1; AFNElJ/35TXDTtDjlBBQqTIkG7ZrrbuP3Zn4ghYmsjK7GYqs7pmA09Og4yO50cSurll1G+WMRCrzeU5q@vger.kernel.org
X-Gm-Message-State: AOJu0YyEXWV7NLHyqktWT1WH0dwoW7s6Oz/b9L3huDpunNBSwXm8ODH6
	ItSyzfsrklYnSS/puh4XlOjzHmuh17MPDax6vgmODVm89BoOtJ6Da4kHiKTuUg5vUPKPK4CjXYZ
	R8B5gZ7ItdPEh4ssi7lZucz9CQbrlXCySnUH8qOUuRw==
X-Gm-Gg: Acq92OEqmk4G7RvNEMtuM6vcAINcePaM1FCaZSkeCOYLZt9+/CcFuENlzK8mkyAYnf3
	yiF0tgSCLuqiMF3uANVqcnv5KrtbVUIJJ3PhgKvxFw5VssnuPLtkSU2EB7AJeXaQvWPwcaNGmhS
	KdF3OQqquLNY8jl0W4uP17J1snthvpDTG0UQdvtGpnngi3nSjxFiLpfUNceT9es3bx3PRPuuCO7
	DWTaMhogywbbx05wfIuSpjzVX0rjY6vmlZDoMYaWiz22+WVOObPWNlln/FzRN0ng49dNjJGeYxb
	OhWdqKt6qaTaD9Ase79covCE9S0sL9Tvxt3T
X-Received: by 2002:a05:6402:40d1:b0:66e:6ac4:2c01 with SMTP id
 4fb4d7f45d1cf-68835a01dbcmr1707109a12.2.1779371807322; Thu, 21 May 2026
 06:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113104.563854162@infradead.org> <20260511120628.206700041@infradead.org>
 <CAKfTPtCc=pBKe9eRbA5B0zhaXJKVjN4N74AT0BFyRK39cS4c5Q@mail.gmail.com>
 <ag3iC-jH6HPoWKGo@vingu-cube> <20260521103117.GC3102624@noisy.programming.kicks-ass.net>
 <20260521133904.GR3102924@noisy.programming.kicks-ass.net>
In-Reply-To: <20260521133904.GR3102924@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 21 May 2026 15:56:34 +0200
X-Gm-Features: AVHnY4Lw1B-XvOeo8sr7hGvXDuf52sh9kgxYHr8miWKSjp8HqAfjR6DvLmC4OJk
Message-ID: <CAKfTPtAJ=bqig3Zc=JCjN7D021F5PWPrVOfHUW3G1f5fZVKDtw@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
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
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16163-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:dkim,infradead.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AFAD05A75DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 at 15:39, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, May 21, 2026 at 12:31:17PM +0200, Peter Zijlstra wrote:
>
> > Would it not be simpler to just move the update_entity_lag() call up a
> > bit, like so?
> >
> > ---
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7999,6 +7999,9 @@ static bool __dequeue_task(struct rq *rq
> >
> >       clear_buddies(cfs_rq, se);
> >
> > +     update_curr(cfs_rq);
> > +     update_entity_lag(cfs_rq, se);
> > +
> >       if (flags & DEQUEUE_DELAYED) {
> >               WARN_ON_ONCE(!se->sched_delayed);
> >       } else {
> > @@ -8022,7 +8025,6 @@ static bool __dequeue_task(struct rq *rq
> >
> >       dequeue_hierarchy(p, flags);
> >
> > -     update_entity_lag(cfs_rq, se);
> >       if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
> >               se->deadline -= se->vruntime;
> >               se->rel_deadline = 1;
>
> FWIW, I pushed out a new queue:sched/flat with this on. I had to rebase
> because of: 6d2051403d6c ("sched/fair: Update util_est after updating
> util_avg during dequeue"), hopefully I didn't wreck that :/

This looks good to me

