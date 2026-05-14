Return-Path: <cgroups+bounces-15926-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLpfIic+BWqmTgIAu9opvQ
	(envelope-from <cgroups+bounces-15926-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 05:14:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 430B453D455
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 05:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A733E301DF71
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 03:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430AA31280C;
	Thu, 14 May 2026 03:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChYxBNmC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DFB3F4112
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 03:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778728486; cv=pass; b=ZIurQPGxgbPh6hENm/EFJy8tDtVe3PhnhMmNItXJK5J6N0GzFzvpJfxdDSU7sdroKqv0X7sfl57AXoc0U6x4uGXm+S19mgNjOd8fi+hrTjg821TDsKuX2WB889Ld8A6nBtkSnQiMqJUPUHx5SUsE9QAQqc8eqOIE5A26PuxxbjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778728486; c=relaxed/simple;
	bh=kFdz4pwAGneFOTBk0JtQ3jZYb4tUxWLiIAS8K6JEYfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuLdoaMod3v0PDwCb136/zkGIRltSABK4bmiEQYgmIAV9Ko3pA0ggsvd/0AvNSrD1UHmJ0+ZR0FlgOaauOLR25afJ37OMSi0H+gX8szc+HYqtOKkTLRSjyjfFqpONoAKQWpj+pIPdwsG5yjBT7EpViRWg4eS1dv+CFr+TymbgFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ChYxBNmC; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12ddbe104ccso6927312c88.0
        for <cgroups@vger.kernel.org>; Wed, 13 May 2026 20:14:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778728484; cv=none;
        d=google.com; s=arc-20240605;
        b=Q34T8NGn0dnunDMFIi1mTOquO0wIfc9T8ylLUuIDL090a+Gxak4FjlkN2fCUFv/xoF
         7Zav6quWZvTvs0Rs0sZppPsdS6smxVymFv5tgDb7i4E5Fc6Xr1WFY2xmPBQvIStrbtfJ
         vaX2HfD8X58+IpBMgaWHVscS2jKppa1hD1rT2rq7TBhCQWAB/f0gzppLNAATnXcncrjq
         aagBc5P9o8NDxwtq6psrLWpn9u9WiFFzUmvCAdOuiiukYKA0lp7jUk5RDpHYkv1RnGfk
         HckCkeTViUXE1Ll8dtxbUY4mHyoja+FUtDk3QhUg5xcFAKAfsSBJB+7a0GK/mVLp3TtO
         WtQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gPH2Irk/dQaA5aCQK+O3cixxofljf+cys+H5CFVrFpk=;
        fh=chEEp4ZwvO44fWxOSQqYzL+wV+tjsJxVfAkclf/+5dQ=;
        b=bE3WPhM8JvYpb7RdhpxC/2pc0o+hh4T8ItwVgW93o9D+jcgxhaaTguV9av15h+7n01
         A4e6ChIdtxszIqvepPs62KYTIoEWgQieT0F/U8+AuxiAj4dPq0FrrcQDminmSvjTZwnM
         I3wdTPoZeLDXlGChpH+faqcO8kbFWjYZbE0Ry7axoWB4hCnz8ZDnd8ldeVSq84X2onh+
         x4edS1cEd6XeZBPcLJABIbifXLZGTK0/NNEV4Aekc+QDCDXg+kZ91JAsWwklh63NRwwN
         UFcYd46g99tcFF977mdnjCqAX22dunGsi/Y4s++0OYgzvFdGQzilMKiXa9g7uVR+u2nH
         yKgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778728484; x=1779333284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPH2Irk/dQaA5aCQK+O3cixxofljf+cys+H5CFVrFpk=;
        b=ChYxBNmCMY6VDL4hSRQfAR4DkZO6U6SmPw5LnRGpVRMCvICaW09ofMIfzmeuntDB2i
         f0F7qdAf5Zb+LYj6z6IUESIdze+uAQ5On1X15IwH92kJ73ht29APWPrNOQtC2ohI+YsP
         Go7PczAUB/FDFZXkZ5OX2fZ435gu0SuJmB3ZUOauulBnc2jZUIWSzMcOITy7mUJCFCvy
         ZWJoSYqJhFxA0X8WwFAdhdt00VxmiLmdGbOd6GmYIA0JD4SCXDXX0Csj4qugzrmBeTkD
         FVJkiMfd0ei/oIYA3njPg7Ra/MyjXBlGOglRf5u/n77D9ItkZrss1r9zG9kyD7hxqtDi
         UswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778728484; x=1779333284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gPH2Irk/dQaA5aCQK+O3cixxofljf+cys+H5CFVrFpk=;
        b=as6sN6gYzsqy4uUQZXjxZyfaE7wzF/xESRXkow6b3y9rzUl8d8hkzn2nS7xT1LaDwh
         f9jo4A/hvcZC4W95AVN8rXgLHlQWLdv84ViF9QMQVjqtKTB1t0O8VcsjpWR5mNcGWAG6
         hAYAv0CEryjv3vp5XTWkOy03vEvMphsA/mG0aQNVLP95U6zp5DmuOblEO9eSWEYTykX/
         J1ffQfoOB9zL4PsWGzeVwhfLRQ25aUtdQFb4QMEAF4sQ9jr0ev3yc54qvYPen9rTZza5
         CrGq03O4hoyosqy4Fbz3IXRETJPCnFTI1OeWjfG0mVltviu9Z0dIh/kErZRnYLuy+W1s
         SlcA==
X-Forwarded-Encrypted: i=1; AFNElJ907HROGu4vtwiGkFXtIisaZeqVXZn42rhdCH4iCtVlnmQ71t1aap9lo4VCcYdbQ5mf7tSHFIa3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2UbJ0sy0Nf99Job/py/s/mvDXbizFWhMBrJ/jkAMidBpe0nVT
	Im3TUAWZAQJtLIP5o9LuWg4WweyXr8eQ4/lwrJHMxlMFYRTfdk/EfKbPq73glI5Hc0qL0eBIG+B
	bGkedozwyTkuIYezu0iD4/DuLAqxj6rKdht9WQt4=
X-Gm-Gg: Acq92OE2DRneGeZzLggIr35UE/c45gl8beGzFb/OwraMgsa1DX5V2qxKVD7ZAiNAPpP
	nqIsMgDGv5qho0gpM5TibmN1eZ+O43+BYupPU9NedBuRrYwxHiEvBKLXLw8QjIpkKpxM1p7mrrx
	NZlk+bylEfMFuQbLubsX1iTZuPFtkPGLI9rVsb3As0yO956mXQaa8S8LCopPbtum1nwIbuGjY3Y
	tk7lhYCWKnMC3AagJYKf1i2uFOgP6f1m266nU91zSEhCHuxGRMTyMc0OdCe5TUDhBla5sSetS+o
	IzZ2x4nK22Nb6Bt2F/sljZKZ09CdGiikYcI5tm3G5a4Q2PdUy+hu8m2e6EUZ9115DXDMXB+EULN
	9uZuW/BQ2W56hUduk9usPTZxMmbqK9ivpMCDu121ljiFX2Q==
X-Received: by 2002:a05:7022:1a85:b0:133:679b:8f96 with SMTP id
 a92af1059eb24-1344054eafemr3872568c88.42.1778728481976; Wed, 13 May 2026
 20:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511113104.563854162@infradead.org> <20260511120628.206700041@infradead.org>
 <CANDhNCp1rcNYg29Fe66G6cuqHhDyXQ0oqccheSwfMuiNV-7Bgw@mail.gmail.com>
 <CANDhNCqWJ=Q3LxazK_ioo_39aFfR+yVbPEV+MQHC8_QvadhuTg@mail.gmail.com>
 <CANDhNCqsZVsWygBA7m2F_w2r3DnQkFDXfd95Lc4ny-zjQQE7Qg@mail.gmail.com> <f28220a8-955f-4bf2-9981-855816519ea6@amd.com>
In-Reply-To: <f28220a8-955f-4bf2-9981-855816519ea6@amd.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 13 May 2026 20:14:30 -0700
X-Gm-Features: AVHnY4IL_jIZJpWKU6SFeGKIJzc2XV_Vslsf6POZfj2TFrp-QKAcy4CaDdp471g
Message-ID: <CANDhNCoZgWLXmaQnu1dkBeuhXQbkzPu6zeRhU1ZQBeGUo8vHmw@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org, longman@redhat.com, 
	chenridong@huaweicloud.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 430B453D455
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15926-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jstultz@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 7:53=E2=80=AFPM K Prateek Nayak <kprateek.nayak@amd=
.com> wrote:
>
> On 5/14/2026 7:06 AM, John Stultz wrote:
> > So looking at the callstack when I see the failure:
> > proxy_find_task()
> >   proxy_force_return()
> >     proxy_resched_idle()  <- sets rq->donor to idle
> >     attach_one_task()
> >       wakeup_preempt()
> >         wakeup_preempt_fair()
>
> After this point, I would have expected we called idle class's
> wakeup_preempt() since that is the donor context ...

Ah, that's a good point! (I was getting muddied by the rq->idle having
SCHED_NORMAL policy value and assuming that was why we were in the
fair code).

> >           update_protect_slice() <- called with the donor's se
> >             calc_delta_fair()
> >               __calc_delta() <- div by zero
> >
> > Basically we end up in wakeup_preempt_fair() with rq->donor =3D=3D
> > rq->idle because we earlier called proxy_resched_idle().
>
> Could you check if following makes things better:
>
>   (Only build tested)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3ae5f19c1b7e..77f4ebe8f5c7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6653,6 +6653,7 @@ static inline void proxy_set_task_cpu(struct task_s=
truct *p, int cpu)
>  static inline struct task_struct *proxy_resched_idle(struct rq *rq)
>  {
>         put_prev_set_next_task(rq, rq->donor, rq->idle);
> +       rq->next_class =3D &idle_sched_class;
>         rq_set_donor(rq, rq->idle);
>         set_tsk_need_resched(rq->idle);
>         return rq->idle;

Yeah, that looks to avoid the problem and is a fair bit cleaner. I
missed the introduction of the rq->next_class detail!
Thanks for pointing this out!

I'll do some testing against the full series and get a patch sent out here =
soon.
-john

