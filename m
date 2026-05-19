Return-Path: <cgroups+bounces-16089-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEpTLPmMDGr0iwUAu9opvQ
	(envelope-from <cgroups+bounces-16089-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 18:16:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C293F5821D3
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 18:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A87A9304555C
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C56B2E88BD;
	Tue, 19 May 2026 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H3YCPN8s"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD72E11B9
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206446; cv=pass; b=rmnj5MaahUS40lbIDup1975xZI45m+q8EX/Cz7WynVmUDIsldaBtILuJX8ssscVh7k6s7LYpRdbiXm0CC6SHQudr3aO1NRxevV6rAXcTcXMcFC8ZdpEI1X1GOTrznRmQD4NgwTw3JD1191istBI74rLPzHKxTBYcleOu8zODU2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206446; c=relaxed/simple;
	bh=cPZ1ZHAazdJKhRB4S2ZAvFvXwqTbAB9qru8H2rDgQbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/B/YuGtDBHvbUxG3boC9j8aUjzSf/yUL2e+u6VSQ0UUBZmOgIDobWOLXzhkFh8CneIiunUqq6w/QxLSnqU8tPVtmCYnK9rGOAwpLl8EuOyodJOm530z6R3BDLjHKJbTjaCmgdQzZ4AQxkH0tS5HdZKnuKWwPo9LuB5xe0K7ONs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H3YCPN8s; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd9a71b565aso164954066b.0
        for <cgroups@vger.kernel.org>; Tue, 19 May 2026 09:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779206443; cv=none;
        d=google.com; s=arc-20240605;
        b=iPfaXlF5hTaQQOE6Z3TN+EP/5ujzHo3empiCaJEC44ua6vqwMno1p2wzGy0GN3SphW
         AdunPiDVV5N/kh6dfk2GFQDre5L3dSSgzA1Fng7OjTP2109vjONuUBn4XFxFO/GUR+s3
         MDRaH6hRJ00MiWI4S5F5q4a2lixK4e32wALMAyU/u5ejv/9ifKmLWesd9jlhCHexl9wB
         cUKZbpXv8hDJkjaBUfLxpsXzmkbOqDfdx7pE1lOE8LMnb0djEeAhyyN7hNZDRWTeXmmM
         o9uK+bQ4lnrYdvj03r7DYnFcxtSwheUk40ls5ib4yLnXKkbeZq1wFq6fQ5g9JS5exHF0
         sqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pTRYOj3DIJtg/GKXucjBSs8QmOIt1ssEUuPjNuk0UCc=;
        fh=1SAvPDCmoMOdgMZ2EBf6ILn/dXBAx6ntSp09gQWlqUI=;
        b=TGxT5aUdn8NLKcdvPTxo31LE8vqX4XUVc9N4mgdp7HOAXHyR+ZqVCZOEPcb5VJw3va
         gwH2Kf0E61+fucUJ/GY5KMZ/6BNU8E4aOv6ogP2wS83ECWyp9xM7uRXLgpC/El7A7O4d
         asSJjBsp8OvpLnHtc05fhyrXp6C/Z1jdTo2IYEUGa1CJ6NfIjK7C5tFepe+PA339ovqK
         dCQ7G5g6aLY8RobNUkEp3L22D+l1OkEoUki+4Jw/ocFPKv3K4eVPJr5fjtwcZTyM+jGk
         4YwsK5E57fQmHPSQc/aYl8hxb0w8Vqp3j70uJQa+zmKhzwf4AS8ThH3QjM4F2f8W8L/1
         F7cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779206443; x=1779811243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pTRYOj3DIJtg/GKXucjBSs8QmOIt1ssEUuPjNuk0UCc=;
        b=H3YCPN8s0+Xo6oZcG4ZBXVyE17sqb3ztXwTxTIwATWoETMEpn2fgAG4X+MY0/REhDx
         rLTFqlS5wiXuwwzFyUhvo4GkZSYnHyjT9m0C93jm9ZCtFFG+AFZ+G9o1A/PYYeH5XWWn
         o49XbDMP6qFSFDga5xGdkBhTz+2LqXXObemA0/VpLQgOCwI3wlpdvxrihrDqzUNnIdXM
         8NLGV/lWcOWdzsYgq0A+jiAyKx0OjSz1OlLAUCg66JzuqT8VehHEY5kc2bXxM/NOBmYH
         ViRbbq+PichWYAVIczcN1d3FXqX7ZBoO7fCETZLEA/h7vL1YulRaQNNSB+DQNsoicibu
         zF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206443; x=1779811243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTRYOj3DIJtg/GKXucjBSs8QmOIt1ssEUuPjNuk0UCc=;
        b=g7JXusyHfDWiSGRefxsENfDsRd+XqEDy00suFpv42plQ4jRpz0UQogQRwLE4e4LLeO
         QQxOkuaReljTQsU0QxRmjZH31bvor3ndVvilwVrjqeBJTHUsS0teMmL9pOCi3mp1Umu8
         OOUJhnm2Tfsrd5rL1iVBm8JX1XjrUeYBsGfoSSwQycbigkXx/xWpq8NrmeQomRrvM1Pg
         87m70icA3jn85xgHh54LF5wJ+v/8wQI25ifCF8ee51hi1ph4ZBKDZbSqXhWmx7jttYUc
         +5f9oDGsRF0Lq7tAkhwpIs4GeX5Apt0YWOCbqRtKuTU5Oqysdptb1aFgQqnuw3kkKiPG
         xJbg==
X-Forwarded-Encrypted: i=1; AFNElJ9qlsn7hStMfpmupGGeFnnUrzkG5rvB65I/5RzkNuhJwiMgs8Jhh+l7VRhDggYoeGKGso+rH6UX@vger.kernel.org
X-Gm-Message-State: AOJu0YyMAW9RBiVN0wZeZAtaYUQIMQDwf5mbg0WEiVnnKA1r01Co+EqL
	0fMfqhKUIaYEnotKQsCQxTO9Uk3hksPUNWfgX/kXMlGtpQ+/fQD7zZWRTV7tC4wGu7br4BegQSr
	pz43Nok7kV9rH5STPL048e0eEzkwq37wzg5glyxw0WQ==
X-Gm-Gg: Acq92OEP74j5HqoUMeKc9JEdzixfgNgLsqv1LEzIuR/cn/FL2tA3PrQ/fKqaI7oSYb9
	3G2ChK2Cj3cILhEnIGU7zSirBhVjshArxxmcbTM7hwv5ZWqVevtVdizGJa3BuOv07lQqyX4G5Qc
	H1+mfJ9sKnqV8iRQRZ6oHPwFP+kjGd26Ih06dLugxWJfeAlc7dL3i/A4HwRndBO+5zFKWp+gGp1
	ZZw60Xc/eCurrVsaAT06hUhNMRCYytjMTAyf4r+nc/x0oJ35Il0WyLkjfWtZDtwOMWeRLxeCVdK
	/Q4jo6zJGfBdmQJvRKmd9Tj4mdiVnx+/bZcA
X-Received: by 2002:a17:907:874b:b0:bd3:5e5d:7ea3 with SMTP id
 a640c23a62f3a-bd517930d25mr1270422766b.33.1779206442935; Tue, 19 May 2026
 09:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113104.563854162@infradead.org> <CAKfTPtA2aBtuBffVV02VgsRRi5mRK0G5ununzuvJ7h7buygNxg@mail.gmail.com>
 <20260513113510.GK1889694@noisy.programming.kicks-ass.net>
 <CAKfTPtCXOnjtVV1gKLnbS8Lo6W4r8hbdUDYVYLMd2Qc1ZqBq4w@mail.gmail.com>
 <20260518211239.GY3102624@noisy.programming.kicks-ass.net> <CAKfTPtBF5UX_0_zvOpBwz9ZDZWcgGzAZC+ansyA8LVP58v6SAQ@mail.gmail.com>
In-Reply-To: <CAKfTPtBF5UX_0_zvOpBwz9ZDZWcgGzAZC+ansyA8LVP58v6SAQ@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 19 May 2026 18:00:31 +0200
X-Gm-Features: AVHnY4IkeljuipVEqTGHHhaIIHUeesM_mi9ctkg1bVKpapoPCwSZ7iIrtOhSZ1E
Message-ID: <CAKfTPtBXWrvniz1c1Tq4DUdWc+V625+FKfOao6H3Za+2ZZ1peA@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16089-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linaro.org:email,linaro.org:dkim,mail.gmail.com:mid,infradead.org:email];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Queue-Id: C293F5821D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 at 12:13, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 18 May 2026 at 23:12, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, May 18, 2026 at 03:34:51PM +0200, Vincent Guittot wrote:
> > > On Wed, 13 May 2026 at 13:35, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Tue, May 12, 2026 at 10:42:33AM +0200, Vincent Guittot wrote:
> > > >
> > > > > I haven't reviewed the patches yet but I ran some tests with it while
> > > > > testing sched latency related changes for short slice wakeup
> > > > > preemption. I have some large hackbench regressions with this series
> > > > > on HMP system with and without EAS. those figures are unexpected
> > > > > because the benchs run on root cfs
> > > > >
> > > > > One example with hackbench 8 groups thread pipe
> > > > > tip/sched/core  tip/sched/core          +this patchset          +this patchset
> > > > > slice 2.8ms     16ms                    2.8ms                   16ms
> > > > > dragonboard rb5 with EAS
> > > > > 0,748(+/-4,6%)  0,621(+/-3.6%) +17%     1,915(+/-7.9%) -156%
> > > > > 0,689(+/- 9.1%) +8%
> > > > >
> > > > > radxa orion6 HMP without EAS
> > > > > 0,588(+/-5.8%)  0,677(+/-5.9%) -15%     1,505(+/-10%) -156%
> > > > > 1,071(+/-5.9%) -82%
> > > > >
> > > > > Increasing the slice partly removes regressions but tis is surprising
> > > > > because the bench runs at root cfs and I thought that results will not
> > > > > change in such a case
> > > >
> > > > D'oh :/
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index e54da4c6c945..77d0e1937f2c 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -9071,7 +9071,7 @@ static void wakeup_preempt_fair(struct rq *rq, struct task_struct *p, int wake_f
> > > >         enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_PICK;
> > > >         struct task_struct *donor = rq->donor;
> > > >         struct sched_entity *nse, *se = &donor->se, *pse = &p->se;
> > > > -       struct cfs_rq *cfs_rq = task_cfs_rq(donor);
> > > > +       struct cfs_rq *cfs_rq = &rq->cfs;
> > >
> > > I tested this patch on top of the series but it doesn't fix the perf
> > > regression on rb5
> > >
> > > hackbench 8 groups thread pipe is still at 1.907(+/-7.6%) with default
> > > slice duration
> >
> > Weird, I can't reproduce anymore with this fixed :/
> >
> > I'll try more hackbench variants tomorrow I suppose.
>
> I tried several conf :
> - HMP with EAS enabled
> - HMP without EAS enabled (perf cpufreq gov)
> - SMP (only the 4 little cores)
>
> All of them show large regressions with hackbench which are almost
> recovered when increasing the slice from 2.8 to 16ms

With patch 10 the vlag value is very often set to the max 3.8ms (the
clamp value of 2.8ms slice + 1ms tick) whereas it is usually less than
a 1ms without patch 10

