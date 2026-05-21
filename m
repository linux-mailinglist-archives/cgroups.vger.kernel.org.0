Return-Path: <cgroups+bounces-16162-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJTFIocTD2otFAYAu9opvQ
	(envelope-from <cgroups+bounces-16162-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 16:15:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DE45A7015
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 16:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E112D32074E8
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6598B3E173C;
	Thu, 21 May 2026 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvjCzUK/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A423DCDB7
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371092; cv=pass; b=cFYKU6VOCsfSz1YSMaaJN0eVTOYRxZE+YwJQ8sHO5kjYtv82b1k6w2bvX5yn7lb3pwIOyaXRblkCC4+dYe7o0jmKmeF7s5hsAdQxtV7TpD1NnHH5N2VAt/RjVLNHEXQqXJ4oPmB/WFylF7Bb5H0AbrbYihn2YSRvWh4AG+F6978=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371092; c=relaxed/simple;
	bh=m3C4Q3SbtwHIPU7bsI0lhitzmuISDRu6LZOa9faIQHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKXHNER3Jbi550Db3RHo4Mckkb9W68Untm5ZZERTuWNmtKXJq6WielI/97ydEo1+uWhTJmVJHnHyZZD1f/3cc+uohLFBFossGBRo6PIdhLe0K6QPzzKYQ9FkC80lIn8EczWCkJd4cCjeb2GCw1KMoUdv95tKE/jO+rFf3Hjaui0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KvjCzUK/; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-678a16429c6so10541209a12.1
        for <cgroups@vger.kernel.org>; Thu, 21 May 2026 06:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779371087; cv=none;
        d=google.com; s=arc-20240605;
        b=cYgzMut9xhyBCOhT80YmgN/k37MWNEFVPXdweqdz5VGq2KLPtZqAgt8TZJj9u2DbMQ
         gqZ7veIH8pkust7uSOz+FfCDDX4ll/x7grznVkw57m3pQoaOS8RVLnXPeWGzqkx4t83R
         ztR4x0RbyV0mfu0VFSi8p7WVlrB/sQhH6RO4HeKaX4MbN0GRIHHlGuHJkXFuvbn45/Am
         6BnVLWK+XqeJSFAuAIw7CRZH9eh2v0uxpfbVkGtaP1FRD9eGE1zhglTb6UcGIHtCr+uL
         mNtl9ExquRNgIwybZblZE6BXBXh8HcxpjP4ua0CQYbLjoLgQZUpn5y2jRwJCZCtiFWxp
         uqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qrniP6l2VtKFr5sGdANghaD7nZbdgcpov60/2/IMbTg=;
        fh=QD47SmhS5Unwy8wNeJX80kAx43HHb2PFunK/bH8Ejpk=;
        b=CeDrguWJnzSusgHF/i097EHsHZI1XmmddW8Wh1fGPBOwuY+rjqp+X1QpcFeQPLNT2I
         sreWE6inxlDSeeaszqo7SSsPtgNObi4qUq0tzMHnrWQU+nN8++SozXm3tf8igifERQYl
         hix0uTQ9ySLz/C3InA9TX8v7MdqPz5/x7uOvAid6iIK2wAHEs6FnZMSjSnccioLFjn8M
         n1NWw/POkHtfoWKtKJJdFk8KWHH5PtPfc3BEZs+VCbsUax2WkgLS0+GBxLBJRrcCIHG/
         atnJz3F6FtseufWOt+YP5z7s2NSuW9OfWg81cG9jiBWRd1GVbQr9iRbbERV7Bt/2T5dd
         Dsvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779371087; x=1779975887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qrniP6l2VtKFr5sGdANghaD7nZbdgcpov60/2/IMbTg=;
        b=KvjCzUK/lE2u+pegt1jtGQv5bk0g1hRXipE7yvlVJO2PcFHFlTyF//eh1moNIBNkf8
         hhtHYrYg7fyWK+LUbUprFVccPS/JXEix2MnAxT+TRmjSo27VV8VKDgGCEOW1SPId/3jQ
         5HGpXfdYsFRDAputAhsztiRzYmTyah4llsCkzYbmg8HzvtUC9GgNSoLfRq+T/x2FJvmz
         7Gd4c6nwEkCHDJnfADQ+WrtMU/33Vzsb0/1G0DbRhJrPYdKY8O/aL8hkJp79CnGwvQ/V
         x3Afo4jm1dPz1i37B/ZjQDxXE2Gw24i1TO9Sq4Mb1LLRWH/a5X1SyGoN+s3MDMXL+Vs5
         16jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371087; x=1779975887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrniP6l2VtKFr5sGdANghaD7nZbdgcpov60/2/IMbTg=;
        b=W+e6dDoQ2VrFaCaJ+Je7Qx0RCmCCDou92TIdz6E/4EYN3ngqiUEix992cCuM4sd4j3
         Qqlk9RsZz8H+k4SEs+QKN0SK4zKKyCAQoS5YeHGnwQZSv60rO/Jxfmfo5vPKLzNP63F9
         VvdC6Ex+LpzNj2HXEpqV37JkuhjeFohrGDv1kNDo1W2JNRGEv+zgmB7lGY+FTaU/tD13
         DZtPTQTJhFgS0K1oY7/uiMFX9sJUs6sZKGl1qPh00O+M6vhGX1yrODHsrfe5uhrMT3Ae
         izcamFMK1gCzqUs8NMw89NFRkclcr+8ItemI1PdZGvMvVy4+pbMshFL8ItMfpPaxsM4L
         ZHMQ==
X-Forwarded-Encrypted: i=1; AFNElJ8eTzLGSn/FzWw70q5P5hlquwwD+d0w35R5xD4CstjhvAeinZLJ1fPRzfnTOvnuWF5ttV9eEUrx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6vEx91bRg06VpQH/R7eWtD5CPY5n+2d0AmOuekG3xXhdMo3Ob
	0j/ZgAP1JzCa0auBU9vr7rnVTMeeGS2h1wfV5UL9eqyP1huXYNRKBGzFyzvcc9blJNfNl/fBAj5
	gTScW8KvqeTf5IiVWzHkHH/wmwi19tkey9QE4nvb2cw==
X-Gm-Gg: Acq92OFTEfwy0PUhJ6X23qEJjS45P8zNUIK60VTvDp3sMAGswBowkvy9uKA9KRELPO8
	1aGI8CH3GZCvrdxWrrNCxJ+ltbUzcyzc/94lpOeg65V9RYdhSpgUf5uyuu9CZkKbiU73wnIzmhX
	fK2MDvJws05LRw14i1sEu8LtatPk6nj8f5PvRAhglrZWEuNZkhbL7u13IkifeakCywYifQtMIBH
	8nPVpPsf2z1gwjUVtB30V5jIo9L4hOjCgd1efqHr2Hm1V3/i79ELoclrr89ojITVVuWYiQZzW+U
	MNxCkWbXdBRz8oQF8gsMlrYfjkChejMyxvTF
X-Received: by 2002:a05:6402:5210:b0:67c:fb8e:41c8 with SMTP id
 4fb4d7f45d1cf-68832b5749bmr1409459a12.12.1779371087082; Thu, 21 May 2026
 06:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113104.563854162@infradead.org> <20260511120628.206700041@infradead.org>
 <CAKfTPtCc=pBKe9eRbA5B0zhaXJKVjN4N74AT0BFyRK39cS4c5Q@mail.gmail.com>
 <ag3iC-jH6HPoWKGo@vingu-cube> <20260521103117.GC3102624@noisy.programming.kicks-ass.net>
 <CAKfTPtCpt7jYSPF5-wE8jjVPMBJrp_SGUV4brpbF9tASaJFp5g@mail.gmail.com> <20260521132901.GJ3126523@noisy.programming.kicks-ass.net>
In-Reply-To: <20260521132901.GJ3126523@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 21 May 2026 15:44:35 +0200
X-Gm-Features: AVHnY4JljB9_Qf0Elnd-zbev7ry_ywQ6tXJogU0g7Hm98HbKvVxmu9knb8v9k18
Message-ID: <CAKfTPtCs+07B_7iHByPdt9j3nMpimr95Rd64BstTFfVZw4wnuQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16162-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,linaro.org:dkim,infradead.org:email]
X-Rspamd-Queue-Id: E5DE45A7015
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 at 15:29, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, May 21, 2026 at 02:13:48PM +0200, Vincent Guittot wrote:
>
> > > Would it not be simpler to just move the update_entity_lag() call up a
> > > bit, like so?
> > >
> > > ---
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7999,6 +7999,9 @@ static bool __dequeue_task(struct rq *rq
> > >
> > >         clear_buddies(cfs_rq, se);
> > >
> > > +       update_curr(cfs_rq);
> >
> > I agree it's simpler although we will call update_curr twice for one
> > level, but the 2nd call should be nop because of delta_exec being null
> >
> > Prateek proposed update_curr(task_cfs_rq(p)). Using task_cfs_rq(p)
> > will ensure that we keep the same ordering as for_each_sched_entity
>
> Given:
>
>     R
>     |
>     G
>     |
>     t
>
> Then task_cfs_rq() will be G's cfs_rq, while cfs_rq is R's cfs_rq.

Yes but update_curr() moves to R's cfs anyway before updating
vruntime, deadline and dl_server

>
> Since all the actual running happens inside R, this is what is required
> by update_entity_lag().

In other places like task_tick_fair, we follow the G then R order and
vruntime and deadline are updated while updating G

>
> Doing update_curr(task_cfs_rq()) here doesn't make sense.
>
> I'm not sure I see a way in which running them out of order hurts
> anything.

I was thinking of use cases which involves throttling but I haven't
gone deeply in the analyses

>
> > > +       update_entity_lag(cfs_rq, se);
> > > +
> > >         if (flags & DEQUEUE_DELAYED) {
> > >                 WARN_ON_ONCE(!se->sched_delayed);
> > >         } else {
> > > @@ -8022,7 +8025,6 @@ static bool __dequeue_task(struct rq *rq
> > >
> > >         dequeue_hierarchy(p, flags);
> > >
> > > -       update_entity_lag(cfs_rq, se);
> > >         if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
> > >                 se->deadline -= se->vruntime;
> > >                 se->rel_deadline = 1;

