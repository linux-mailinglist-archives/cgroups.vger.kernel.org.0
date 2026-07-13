Return-Path: <cgroups+bounces-17723-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z2BIH9HzVGqVhwAAu9opvQ
	(envelope-from <cgroups+bounces-17723-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 16:18:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBAA74C47F
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 16:18:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=pS9y55re;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17723-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17723-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3C393032409
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 14:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1085439015;
	Mon, 13 Jul 2026 14:08:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326064279EE
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 14:08:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951689; cv=pass; b=LAxrZZMzb5StwMZlltNATHnP6odQqdb+/M8CBPcn81eTXR8cpVNui9wl5SncODosydgH1Z6XiQxrT3eh8ljD3HOuZhDX4aIm8z0+rbbOhtSA/Dlx5p2l/8PhDfgNZUOi4uWESNCWM/MNkq24L6z7U5D+SUmyzyX3JsM5V7KqxHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951689; c=relaxed/simple;
	bh=vqIlEswSbjH4NuGZq6lHoJhIaehD2d6A+4RCBsh341k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrLrXwPoQMvH+qHTttsGQiBYpwBFpADCfj2ylizK5XNNZJM3marENuPH22e5qfIFG3UckP72as99MO9TDNj8DjBT79+ktXYBFa2Zl1bvI5mhY9BBgTfHQa66KQXp4RTT0Gyhn0QcR0due9hrzWnZkwLINBIQXvdiaD37lERiotA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pS9y55re; arc=pass smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c01c79467so499401cf.0
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 07:08:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783951687; cv=none;
        d=google.com; s=arc-20260327;
        b=TLtHLo//jleF3TzbjY7/zRlfacGemAYKBo0KglsgFoGzPLIkubbjMZb9ZzIGeSZXRK
         zrlPFewZh2UXopcqoKnFmRWhAX23jwzIEcRSdn2DsmgiIgcWmcBfOzzs1a+TJgrMElfO
         d3a9OTvX/B9JRSx3N10B90IPEXPKLFyCCe4Xxi7ko/eHk6aDiXe7JDeVciEri2Pfc2IQ
         hi+uaLft0PuvguvjoC0QYb2SqUBdYveXSCSgGkP4oGRKXqkbFklt7ZfDl3yyKOoURkab
         XUJfXnxLDoqkKt+HnfMmfp9d2QYxEBfg1fHEhPejJwN98pDKKYIvELL6ZD8AfvaqAHTB
         cFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P/B4jzAbemKAfn1pqP8eoojQzyZ93X8qz1xTXY8DGb8=;
        fh=o+IQUuK5/xgyDIVYdOND1ZUo0LxCBcVuXNR/3a2wPUQ=;
        b=YgMIjQEJYjNv+G5CY6JAYCrze1yoKQx8MvYad+NseTl++PBqgSzv7/amPMmow/ZT/E
         P+hm4ReaKwA33LG4ZBCCyOeW1or597rIolNXcJi3fSp/nkf+D2R5v+7uZnpHX+9ukK/U
         awKaW/MyCkyyfqif5OdT6HAHoiK3QlFaKfRnKkfUNugZjx1MG7YH5kFh4oXdn5wbgSn/
         aXVSlHK0abmkYpRW3ar15D/q33j0Fe6S3eNcNJxYASWaNxLo+hnzA+KMR4g1P8beimpc
         d4giksSfDyPvmO6gQclxqZGWIjM9JHSMgEJ0CsCgiPkkBBTMSeWcNzozmAeUQ/KF4Rig
         sXmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783951687; x=1784556487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P/B4jzAbemKAfn1pqP8eoojQzyZ93X8qz1xTXY8DGb8=;
        b=pS9y55reWilK7flI1go7NlrWlU39RPZg9bFvJWoSZj0FMI+nLkhXrWIerGcrCMO40r
         DrwZa6m2vvOtaIacxmfFAt5Q4wmX/ZvOY9LtgOOuEaoEeb+LkG33TUoYXeGeYJgkOrOe
         DxL3XQi+Ax5MJP5RwXnYD5KpbOy1zHNEJf9h0/hnh5tAcB0PEkq/CEViW2L/zDgOLEbG
         Domgdv4gOVDIfX5TZ0chgk1Y09MQR919qtj8fxYbaKqhR1l58WHRoZncN49POGe/+FRV
         aEWKEtKEvHpEHdHl5Oo+vjAKkfxPOuRaOQ4lgCmuI2jmsrr4xMjAGvx3amWKUQOPY2mK
         9s3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951687; x=1784556487;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P/B4jzAbemKAfn1pqP8eoojQzyZ93X8qz1xTXY8DGb8=;
        b=hhTSvGgWcld4EpcoWeoJUqC/K/PweMoCovQnKsM4Y/ifahDID+qKPQXT95j9HOEb4/
         nOzMtLOYOmmmuBdiFySJiBS3ktlirenM1sS1TT5P+q21SJvkFeLg5sWxNIeqczz3geoO
         nO23QFi2ileiOzoQDDv001cXBI89Gy2Gs3VBoAa+rRnR6VKzT3Xvp2z97Ceq96GUz8Lw
         o9Tc/N3j81JGyG1vP4smz9Wekd0CR2g5EiRsMhNO4xm9cpln0cOenf9Xt8oThCBjUmQI
         PB6lNH6Sco907M4nWnfNbHNN2kjgjliufIkGdD4SOjiTCHwxnb7+bsyrVbtEJ2q8XqVg
         3x8Q==
X-Forwarded-Encrypted: i=1; AHgh+RqgwLqUxJfosESsJf8s6+ngawdCdDE3rn1AGsLUjTOSlwwhozfPfq9Y/AgvyOAU6BjRuhT9QD/E@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe1Z6FOYJxYHyFlrbRO1LmqUjQ5ghdGfw0BLHf892HwUYZGNR5
	/Pj8YxY69TExe6NuUcLjaljrvvpyp0QSvdVMSZZqn5Z+llg1xkkIre80JP/osNR+J3e9GVueFzZ
	nNWTypkdpsKdCBAtqcaNGlVBqE2NqcehczJdH7Z8T
X-Gm-Gg: AfdE7cn7NVvvPCrXvfX+oLoSmhcL+3nBLXplPRs0SPjt7i0TLCGJkkHdLADD4sbvaZ7
	6KjiE71JVT+gZBcGNJZ4jFALQFlzISUo3g3+e+ecLyJZC3eP0ZUk/Q4YRPrF2hewI90tyM545mN
	9KwfPsreHOKGTerOGL9TOlxH6drndWpCahmNGp00bN+MZnLESmu5W2YgE+dzQZ0+r+LA0AWecce
	iK4k3eNTi6ri8AAaSrA6a4BKGUOGuXSnCY4NXZmZVmsbYS4vECKepp1GJAK0cP7PJGI8mYSJzHd
	Dz4sUA==
X-Received: by 2002:ac8:7d03:0:b0:51c:104c:100c with SMTP id
 d75a77b69052e-51d71546a1cmr3059641cf.2.1783951686232; Mon, 13 Jul 2026
 07:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712174619.3553231-1-tj@kernel.org> <20260712174619.3553231-3-tj@kernel.org>
 <20260713105655.GC276793@cmpxchg.org>
In-Reply-To: <20260713105655.GC276793@cmpxchg.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 13 Jul 2026 07:07:55 -0700
X-Gm-Features: AUfX_mySUXx60Yrl5QJFzFOTYBVkvBAoiyE97eRZFZR4z-qTHxpoqiaNZ1I-MdA
Message-ID: <CAJuCfpEocgh+s_R_C6K25ESaSub=-vx6ZwqE-5HJddfBPMt7NA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/psi: Shut down rtpoll_timer in psi_cgroup_free()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>, Matt Fleming <matt@readmodwrite.com>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Peter Zijlstra <peterz@infradead.org>, 
	Edward Adam Davis <eadavis@qq.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>, "ziwei . dai" <ziwei.dai@unisoc.com>, 
	"ke . wang" <ke.wang@unisoc.com>, Matt Fleming <mfleming@cloudflare.com>, sched-ext@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@cloudflare.com, Sashiko AI <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:tj@kernel.org,m:matt@readmodwrite.com,m:void@manifault.com,m:arighi@nvidia.com,m:changwoo@igalia.com,m:peterz@infradead.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:zhaoyang.huang@unisoc.com,m:ziwei.dai@unisoc.com,m:ke.wang@unisoc.com,m:mfleming@cloudflare.com,m:sched-ext@lists.linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@cloudflare.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17723-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,readmodwrite.com,manifault.com,nvidia.com,igalia.com,infradead.org,qq.com,huaweicloud.com,unisoc.com,cloudflare.com,lists.linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DBAA74C47F

On Mon, Jul 13, 2026 at 3:56=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Sun, Jul 12, 2026 at 07:46:19AM -1000, Tejun Heo wrote:
> > psi_schedule_rtpoll_work() is called locklessly from the scheduler hotp=
ath
> > and can race psi_trigger_destroy() taking down the last rtpoll trigger =
under
> > rtpoll_trigger_lock:
> >
> >   psi_schedule_rtpoll_work()        psi_trigger_destroy()
> >
> >   rcu_read_lock();
> >   task =3D rcu_dereference(rtpoll_task);
> >                                     rcu_assign_pointer(rtpoll_task, NUL=
L);
> >                                     timer_delete(&rtpoll_timer);
> >   mod_timer(&rtpoll_timer, ...);
> >   rcu_read_unlock();
> >                                     synchronize_rcu();
> >                                     kthread_stop(task_to_destroy);
> >
> > The group can then be freed with the re-armed timer still pending, and
> > poll_timer_fn() runs on freed memory.
> >
> > 461daba06bdc ("psi: eliminate kthread_worker from psi trigger schedulin=
g
> > mechanism") deleted the timer synchronously after the synchronize_rcu()=
,
> > which prevented this but raced trigger creation instead: the deletion c=
ould
> > cancel the timer that a new trigger set armed during the grace period a=
nd,
> > as creation also reinitialized the timer at the time, corrupt it.
> > 8f91efd870ea ("psi: Fix race between psi_trigger_create/destroy") moved=
 the
> > initialization into group_init() and the deletion into the locked secti=
on,
> > trading the creation races for the window above.
> >
> > Neither placement in the destruction path works. A pending timer firing
> > while the group is alive is harmless though. poll_timer_fn() just wakes=
 the
> > rtpoll waitqueue and doesn't re-arm itself. Bind the timer to the group=
's
> > lifetime instead and shut it down in psi_cgroup_free(). Nothing can arm=
 it
> > by then. timer_shutdown_sync() because the timer is never armed again.
> >
> > Fixes: 8f91efd870ea ("psi: Fix race between psi_trigger_create/destroy"=
)
> > Cc: stable@vger.kernel.org # v5.10+
> > Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/20260711000434.36C4A1F000E9@smtp.ke=
rnel.org/
> > Signed-off-by: Tejun Heo <tj@kernel.org>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Both these patches look good to me, but Suren can you please also take
> a look?

Yes, I'm on it. Need some time to remind myself of all the details of
the implementation.

