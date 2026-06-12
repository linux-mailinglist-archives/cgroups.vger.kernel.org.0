Return-Path: <cgroups+bounces-16905-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O0EHCZROLGqSPAQAu9opvQ
	(envelope-from <cgroups+bounces-16905-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 20:23:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF1467BA4D
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 20:23:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bnIqoz7q;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16905-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16905-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F19234CEAA4
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 18:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C5A38D407;
	Fri, 12 Jun 2026 18:15:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35095388E44
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 18:15:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288120; cv=none; b=H+xGam43C3mS9XlUr+L4mrNGP65FCVMNljDmHKu8bJGFxtubRrnSS8gIpY0pJ7IZ7+38MogdBilUIFolHKtptS+4Y+jhRrAc78S8uI4SglBTPap1v4ybeigXGu+SJ77J7zWmUJSNZoGNnutLaftk8Y/IHBFacYzKph3DOx4uG8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288120; c=relaxed/simple;
	bh=ASQR4l5FNm9ueZF0d/XxnJAt0ijP5fBfVzs21ObM2PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YT5VRKkasyGuDDa96qNRmhhUHKkEPUitDjnhjSj43z4gts5ivuEtXVqNIQtO5axvYoDC3kyn9nOlgYJGBxfQxEq30HHJHNs8PRByeH9AZYV7KoTNAwqxh6T5hk/zAGxYB4EWRe08ZwQkg+qSyDah6iGODiCPXIPtDrBo1Iy4gkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnIqoz7q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1501F00A3D
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 18:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781288118;
	bh=E+A3vWRlzyJq18Mba78WFP87hbq4qTdszzF1tMKBnlk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bnIqoz7qSh+S2RyIs62F6DLF33AEzbM7iksZd0fYVYh1eAQxcb9vrPsSTrwVuC2ts
	 4dPaNpDdxYVmwFqA9kH1VDKS1/xgpUkFL01o5n+4kDpjsk/ErdiBMIOmW45Ajx8c27
	 pMGUNGqMF0Wb12Q6hEE78u15QHno7yqfHcKK+MqQTMn/PZyMjd/qQz5nEprpyiI0Zs
	 vVq+Hgq/GfllTxiOw1V/jL0MeYV4Hux3fAguIa7E6Y5v9SjDQBM+wUUqRfWFJnytd2
	 0PHpLi8E5yTZ2yTRgbfEwJomykQzwE8HZQBzT0A0p9sFQd7ERZMSxrcuxZJtYlio+D
	 1499XhXFIUT3A==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bf1cdcfd6deso150882166b.3
        for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 11:15:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9zJJjN+E/VGfQ0HN8H8KkePhVMnLlQJmxCnybVVtaXFbj2OOksx8E3eY555w/sJOv7Yw+eu8SA@vger.kernel.org
X-Gm-Message-State: AOJu0YzWRqjy9HRnLh9wMUZRb/fTzrh8xVkG1sXo3k72zpnwAbgBpZGF
	H/i7RWbwdc198pXanyHfQxzb+j8uCEQPYlvarb5lWk2suYq3frL10gCCniO0zA94qNXRvLyRPsg
	rFYAAoiuhjovM5J0jgUON0TBwaQx/WMs=
X-Received: by 2002:a17:907:1c9f:b0:bee:426:87ec with SMTP id
 a640c23a62f3a-bfe2a21eb9dmr188658966b.23.1781288117842; Fri, 12 Jun 2026
 11:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9898f83d-fae9-e284-6b85-c7f4089840a0@gmail.com>
 <CAO9r8zPBH6-0SQ6-_ZOhTQeyu=rz4F=ugikCrU-JR_skm6fEWA@mail.gmail.com>
 <a60eedb6-f3fd-4092-b726-04a17a695ace@gmail.com> <CAKEwX=MQ3xXBAY-2H8vA+XSX5GHNBubJ2GCYAXGD+Hra++ZM7A@mail.gmail.com>
 <90730fa7-62e7-d5f4-b638-23b22a8509f2@gmail.com> <CAKEwX=PF9hfERC_QMq+rjkSc-BsJyawMgTe+EhwR_86HiQKm=Q@mail.gmail.com>
 <CAO9r8zN6VVZz7dpjNrh8n7wbLkqcrsROPm70MQQxO49HJSmMFw@mail.gmail.com>
 <CAKEwX=MCFbsh9ndBtR0-bGRr_=v-6bBwTo=muzd9ZSD-LAK1nQ@mail.gmail.com>
 <1c25650e-bf98-2863-d505-9b94c385668b@gmail.com> <airypNnKrJJ54k_0@google.com>
 <aiw2JB1lZV9xuNSp@linux.dev>
In-Reply-To: <aiw2JB1lZV9xuNSp@linux.dev>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 12 Jun 2026 11:15:06 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM=CMtUfV0RX3YyztqMNcw=s8M3WX6Q0epR5YHUvwTTKw@mail.gmail.com>
X-Gm-Features: AVVi8CfJgDpyGNP17lGySuExRPvTjQWDl5oLaxVnqf7oZO77PjDMo_CwkVZjPng
Message-ID: <CAO9r8zM=CMtUfV0RX3YyztqMNcw=s8M3WX6Q0epR5YHUvwTTKw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm/zswap: Make shrink_worker writeback cursor per-memcg
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Hao Jia <jiahao.kernel@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
	akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, mkoutny@suse.com, chengming.zhou@linux.dev, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16905-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shakeel.butt@linux.dev,m:jiahao.kernel@gmail.com,m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.org,cmpxchg.org,suse.com,linux.dev,vger.kernel.org,kvack.org,lixiang.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AF1467BA4D

On Fri, Jun 12, 2026 at 9:40=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Jun 11, 2026 at 05:39:16PM +0000, Yosry Ahmed wrote:
> > On Tue, Jun 09, 2026 at 11:18:26AM +0800, Hao Jia wrote:
> > >
> > >
> > > On 2026/6/9 02:01, Nhat Pham wrote:
> > > > On Mon, Jun 8, 2026 at 9:48=E2=80=AFAM Yosry Ahmed <yosry@kernel.or=
g> wrote:
> > > > >
> > > > > > But OTOH, this does seem like a recipe for inefficient reclaim.=
 We
> > > > > > might exhaust hotter memory of a cgroup while sparing colder me=
mory of
> > > > > > another cgroup... But maybe if they're all cold anyway, then wh=
o
> > > > > > cares, and eventually you'll get to the cold stuff of other chi=
ld?
> > > > >
> > > > > Forgot to respond to this part, the unfairness is limited to the =
batch
> > > > > size per-invocation, so it should be fine as long as you don't di=
vide
> > > > > the amount over 100 iterations for some reason. Also yes, all mem=
ory
> > > > > in zswap is cold, the relative coldness is not that important (e.=
g.
> > > > > compared to relative coldness during reclaim).
> > > >
> > > > Ok then yeah, I think we should shelve per-memcg cursor for the nex=
t
> > > > version. Down the line, if we have more data that unfairness is an
> > > > issue, we can always fix it. One step at a time :)
> > >
> > > Thanks a lot to Yosry, Nhat, and Shakeel for the great suggestions!
> > >
> > > Let me summarize what I plan to do in the next version to make sure w=
e are
> > > on the same page:
> > >
> > >  - Drop the per-memcg cursor and keep the root cgroup cursor
> > > (zswap_next_shrink) logic intact.
> > >  - Stick to using the zswap_writeback_only key, and change the proact=
ive
> > > writeback size to use the compressed size.
> > >  - Consolidate and reuse the logic between shrink_worker() and
> > > shrink_memcg(). Enable batch writeback in the shrink_worker() path, w=
hile
> > > keeping the writeback behavior in the zswap_store() path unchanged.
> > >
> > > Please let me know if I missed or misunderstood anything. Thanks agai=
n for
> > > clearing things up!
> >
> > Sorry for the late response, yes I think this makes sense. However, I
> > have some comment about how this interacts with swap tiering, let me
> > reply to the other thread.
> >
>
> I think the swap tiers interaction will be figured out over next cycle. H=
owever
> Hao can/should continue to push and we may decide to let it in orthogonal=
 to
> swap tiers.

Yeah I think there are a lot of changes we discussed outside of the
memcg interface, so maybe keep the interface as-is for now, work on a
new version with the other changes, and we can finalize the interface
at the end?

