Return-Path: <cgroups+bounces-17727-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jdRaGAwEVWq/iwAAu9opvQ
	(envelope-from <cgroups+bounces-17727-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 17:28:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C829074D08F
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 17:28:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=kFt3PI1Q;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17727-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17727-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACED93052ABF
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0163D16E9;
	Mon, 13 Jul 2026 15:19:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F349388E59
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 15:19:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955972; cv=pass; b=SbjA8zlkEIOddwdIHfFKtVPAQ1K592n7f6TQU7f6HpBY+T3EzgQRAlqBgE4d8M0kGV4ZWkQvLOtrLuSdmyntckcxLA6jbh/YsiJ4o+rIuNns4Xj5T8X/YmFN150969KD0+knTTuq1VtdFBTgDw08w179OJIaw+3rpLavUsTgHgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955972; c=relaxed/simple;
	bh=sEE3FMqOqkgJ0LjaW8o88lS57GWwQKCfWUiiHh0s0hA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvYunOR1t9AfSlHoYJYdajvZxO0KvkmBTjWF9tDXV3S3ts/9rioTg9lN1aDLLU2LBhVrm9lfE33fL7LX1VW8q8Hbv4IXXECaac/QffdIeR8LHdxxm1n/0Rg/wgDqy7Z0dFBow/kkZZbJuKchdtOFsAuOdUUwnOazdcKKcTkX5Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kFt3PI1Q; arc=pass smtp.client-ip=209.85.208.50
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so5895a12.1
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 08:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783955969; cv=none;
        d=google.com; s=arc-20260327;
        b=rvBoNfWb/aBOQcb4Q0ZjhM5U/EaRM4P0T7dFoUaCF9yphGmLXQJbqUFbg8OOACDADv
         aDfKE9DzHFPQA7i4H8bJSiPlBA0MMMMwbvt5N+4si6c/O/ZMKbL5vDES/yD+XCfRv1Kq
         3QZufNHoaYFMYZllXbHagp8MeOtXif0jAYllG+aKmtmoHvotDFKZzkpUGLWKCq39ah5E
         W/RlKqeC5Fo503PTNFqAQUkGrrP55HHn8EAIo6m3wP3X0MxRooyTXD/yr2Tfe1P5Xc3w
         toh/uJknFsfV0KSlF5GF4VCrJD9WtzEt6ifFo10GrtAOt0kZdSlcyuJCPEvI+LDoejCc
         6biA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FG71CBoheueQ+381OlVy9pD30LVk3nyO1mhdOYTqr5E=;
        fh=dEMfSULZ4pAx4QHIuAFyCxFgzfvvzfDCyCb3RCOV65A=;
        b=Tvgr/25sonxbpv0iObS4lv/mKXprOG3IDZjiwvMQf21HLapuTV8Zi/KCOAtOlfoQSb
         PwklGreeu7yjLTO5L0YmhxIYTvkxmmamIyr3yYLMheDS/GwppwjCfLKO2xDolIYZxLGZ
         cW7WI4/J3A/lgdKYEikqn+abktq8NkqBMFum/IiBrsraEiiBOWhZG1fCRkwsN7OcpnBD
         0nmV1YMD7lnOatqCZLukiP4LaCz/MM/TaUwCJ3yNq0XYAIAmBwsHNLkqioEnNkJgPo5N
         BoEptF3iVlDCw/Rjb4kHqVLAw3b+GzhO6id21RYzsP7LPfDDK7L4qmf4iDakJKXko5vu
         FcGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783955969; x=1784560769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FG71CBoheueQ+381OlVy9pD30LVk3nyO1mhdOYTqr5E=;
        b=kFt3PI1QZw9DhboebyXuep+pJfRL8F396BztJKrxxhrAeQxzZSE8ligQkAk4PSz8Vn
         FKncFxU+Mu1cUE8efVmT9G01ku3WBjzY2BTMdSBUicG8paHVFxL2FoRCc7qNtIzQ6y69
         RP3ATif6Ex4uJOnnZHOFLGjDX11p4vOK5kehWNBvDek6uLZz6p7c4K2KDWhhZ/32ut5b
         MbXuqUXjyEaF/P0G7sqjWmcw2siHyneJ+HKJHyis1AkIMHQfcWhT1QU7KojlG6TQ22Rc
         5uLEZe8mOUc2LNXkGtzf7sKVrxl5Z0WNBu5P/B/15BWYmBEcbTAR1V3JWFZmwvDBQd/h
         +Zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783955969; x=1784560769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FG71CBoheueQ+381OlVy9pD30LVk3nyO1mhdOYTqr5E=;
        b=eQQm07wkBYi+fATxk1zqTLAK0TG4R9V02BLoIihvh15LkeecxMP7TnM4dETXmMRNKX
         1sI8yZqdxeAea6ZA5XWjT9omGyQcb6dynjZukfrU/3nKf7sL7TUzrs36RHuObGF21AG7
         Fuhmo7QWxGlRLb1uV4DfmtUS+kwGGrQ0JfSXHyezYoOP2avOH8O5+a1BgumPUI7ebjk7
         K3WQHyqSrrydPJ7NuRS8R3or9GYbZbw9PRhT9EqItPeb78E33I7Jwdh/j66O7sdPgFHZ
         kwfl9J9akv6BpPiMMyHvKN0JU6BdgCkC2bWCZ1eBGyf+n+iGBjORngpuKQ/mLX3qyd3v
         Hvng==
X-Forwarded-Encrypted: i=1; AHgh+RqdHKzm4aMwjYQF88pWG2K9OdTDMf4jGhJf3MGhKUICBfQu2/TTI/BMLxDoR7gMWh9Uq9HmLAQf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6RbaKpnBEcEGlkI3hAXwKZOsM2wU9X1sYG0LpyIYDiWW6Z+mB
	ER+L3SiakzcsV6cGFP/Jjfpt5YTUmuCp3hILhHAa+cnZ3f+KqvmMH/pS6NLblf5+IyiW9wVTLNP
	HAuPVZEOrRZK+nCjou515aDi1t3Nu1M54z2aLxkm7
X-Gm-Gg: AfdE7cm23pC5RPhw6cnDTzkw71sH1/mEEz+iEgGAI71dI2nAldqk6fQSSLzH5N4HKVc
	2LiVACMSrH8zCMhSFEQ0mvvNPd51ObvwmCYgRblg3WsCdAGN2U3M5Ox4mecMlN5tUFbSzGIBOBW
	atb/OfhRFSOSwOLkLW+4c831ZzwKGdOwzaipKFcWkM3uFl/E/FDlMGgYwu8Ys89EdErNCM4FXT6
	4BrZypBSUdksScOdAmCFvooe99AO2lgoslFzDQCNkrs92lvRbflo6KWk02QSNr2IB1K4lY=
X-Received: by 2002:a05:6402:5612:b0:697:be5e:3c26 with SMTP id
 4fb4d7f45d1cf-69ccf0e109dmr30478a12.7.1783955968197; Mon, 13 Jul 2026
 08:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712174619.3553231-1-tj@kernel.org> <20260712174619.3553231-2-tj@kernel.org>
 <alTsERFTlUKCLw4C@matt-Precision-5490>
In-Reply-To: <alTsERFTlUKCLw4C@matt-Precision-5490>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 13 Jul 2026 08:19:12 -0700
X-Gm-Features: AUfX_mwJphU_f7-jLqu_Z_Ua6JyGkcwumDuVDobQYNKxyxoqyxOYbk8wQ-qoTzY
Message-ID: <CAJuCfpGAx3t_ur3gkpvr8uxooM5=1pbA+ap_qtUvu=CjNzaYzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/psi: Create the psimon kthread outside of cgroup_mutex
To: Matt Fleming <matt@readmodwrite.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Peter Zijlstra <peterz@infradead.org>, Edward Adam Davis <eadavis@qq.com>, 
	Chen Ridong <chenridong@huaweicloud.com>, Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
	"ziwei . dai" <ziwei.dai@unisoc.com>, "ke . wang" <ke.wang@unisoc.com>, 
	Matt Fleming <mfleming@cloudflare.com>, sched-ext@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:matt@readmodwrite.com,m:tj@kernel.org,m:void@manifault.com,m:arighi@nvidia.com,m:changwoo@igalia.com,m:hannes@cmpxchg.org,m:peterz@infradead.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:zhaoyang.huang@unisoc.com,m:ziwei.dai@unisoc.com,m:ke.wang@unisoc.com,m:mfleming@cloudflare.com,m:sched-ext@lists.linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@cloudflare.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17727-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,manifault.com,nvidia.com,igalia.com,cmpxchg.org,infradead.org,qq.com,huaweicloud.com,unisoc.com,cloudflare.com,lists.linux.dev,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cmpxchg.org:email,qq.com:email,mail.gmail.com:mid,readmodwrite.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C829074D08F

On Mon, Jul 13, 2026 at 6:48=E2=80=AFAM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> On Sun, Jul 12, 2026 at 07:46:18AM -1000, Tejun Heo wrote:
> > a5b98009f16d ("sched/psi: fix race between file release and pressure wr=
ite")
> > made pressure_write() hold cgroup_mutex across psi_trigger_create(), wh=
ich
> > forks the psimon kthread for the first rtpoll trigger. As kthread creat=
ion
> > depends on the whole fork path, the commit inadvertently created a lot =
of
> > unwanted locking dependencies from cgroup_mutex.
> >
> > sched_ext got hit by one: its enable path blocks forks and then grabs
> > cgroup_mutex, so a pressure write racing a scheduler enable deadlocks, =
with
> > every other fork piling up behind.
> >
> > Fix it by splitting trigger creation so that the worker is forked with
> > cgroup_mutex dropped and the kernfs active reference left broken. The l=
atter
> > matters because rmdir and cgroup.pressure writes drain active reference=
s
> > under cgroup_mutex. Publishing the trigger last keeps error reporting
> > synchronous and preserves the of->priv lifetime rules.
> >
> > The trigger registered in the first stage pins the group's rtpoll machi=
nery
> > across the unlocked window, leaving only creation races to resolve. The
> > catch-up poll on installation covers scheduling attempts dropped while =
there
> > was no worker.
> >
> > v2: Retagged sched/psi (was cgroup).
> >
> > Fixes: a5b98009f16d ("sched/psi: fix race between file release and pres=
sure write")
> > Cc: stable@vger.kernel.org
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Edward Adam Davis <eadavis@qq.com>
> > Cc: Chen Ridong <chenridong@huaweicloud.com>
> > Reported-by: Matt Fleming <mfleming@cloudflare.com>
> > Closes: https://lore.kernel.org/all/20260710100441.2653477-1-matt@readm=
odwrite.com/
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> >  include/linux/psi.h    |  4 ++-
> >  kernel/cgroup/cgroup.c | 23 +++++++++++++-
> >  kernel/sched/psi.c     | 69 ++++++++++++++++++++++++++++++++----------
> >  3 files changed, 78 insertions(+), 18 deletions(-)
>
> Tested-by: Matt Fleming <mfleming@cloudflare.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>

