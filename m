Return-Path: <cgroups+bounces-14231-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOnIJf/7nWmeSwQAu9opvQ
	(envelope-from <cgroups+bounces-14231-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 20:29:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D914718C14D
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 20:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67EDC304FFBF
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 19:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABF43ACA53;
	Tue, 24 Feb 2026 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk9Vn72O"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D29639A7EF
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961340; cv=pass; b=efZ4beUxNqGwQ3JqDXZgC2XR/l1hINWs7RxXvrm3F8t3t9qptjB0Rub4+Im0JKh7W+bxZABQ8CLZCuhM2zOANTHw9MPSghx6aheLBewTx9ZfdIyjyMnerfFcbvqowTx8zKzwQgJFh3+E2gyW5T7q7XHH7g4hg6bRxRIhxtce7cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961340; c=relaxed/simple;
	bh=d0g9JSn5hJ3/0cUOdGHJ8XxsbIzvXLpEXYfQCv5H66A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHk0zxIbqXaQ9JpQy6/T3MGuqEgPjBoiuYNsRZJO3oTTkyXMUrwGG5oLa2XvvukFXUCvTxo2A5nCJH2o0bvN8xzFofI9yg3aOeo0aDLWjEq/Ypmj2Wms+3DuEgHpnNUYtCdiUWt0mFR4uJ11IHe/Hao7D5jZtw7USiKh7ZA6Gpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk9Vn72O; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb39647a70so578558285a.0
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 11:28:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771961338; cv=none;
        d=google.com; s=arc-20240605;
        b=jk7mpj+9zmHHb/UAnT0Rx7Mprr9DU8nNTnjIEmabgyjXC9ihcb8MEE9O6WmqMBLBG/
         vx2ILBVORrxis1IJ3FGsgaHAuOnDMdCCQmoMOjthMQjqa/qyNULQb0FwVxCYV4q1p75C
         zt78u2HtSMTXDjY1qIkyH0kvBJuVRwwBjxw5t6rkpuvceEMqlD2RVnAp9C3yJvej3mcP
         2ME9uj5enXnblwLYcriVXptS6dRawMlRMHnQMGclFtGgmVUXKr7bCH4ZtWXvA980x6qn
         VsHTLc5bE7cFG7iaSxVd5IVxt2RArN5KzWH7LG7n+1KVL1csB4tGHLA9UP6Jl9nSUolL
         T5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d0g9JSn5hJ3/0cUOdGHJ8XxsbIzvXLpEXYfQCv5H66A=;
        fh=88Xk59uljeVXfoohcWYkiHYrApo2GIsM2QE+fVbZXAc=;
        b=hhEqzSCX6Ay2U3MspRAX5Ci7UEX0/OrnzqA63+nBgVmxGTkV7SjT3WZjYBdEu15L5q
         +EucSu1qoiV9OqkEentyckOQtcKwSvctBSvelxGfEV7ctk/386aGW4+stf3JqoGbq1ro
         ghjG8kVoE8WkcMT4E2KxL3MN/FJgDpMPvQtJrM5zIGPYyxoCED39p9MGVHA/vlr4R98P
         OjsfjyIOrhjdnfbls9VcpDVNaBlDmZBN9NteUIcllimoSfNXmcLYxpuJb87S4UwHbdCV
         XHUvIPdiFfo8dFHmDUz41kqtUndRrBSZHiauQLigpuOZQTj0zub9RCxlkLM4jbWv8e0T
         DDCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771961338; x=1772566138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0g9JSn5hJ3/0cUOdGHJ8XxsbIzvXLpEXYfQCv5H66A=;
        b=lk9Vn72ObXx9WnAYtBIglt4NOo/yKZTY5UaQBmz5O1Pn3oJqEmmNOIxr2nUUbIa9ey
         O1KDNMd0YuuhrSF6qc9+C2XRe7gRU6rVx+mGmzvUkne9J92Rcti0lp31/k6d9NNEQnFC
         GiOecy3kHxz2ZMHCfiYSO2yR7zzNe09UxYFQFHTL2fSU6LD8w9QOMm4dI52bxmXKgYTS
         Z/TNlEr1/YnXHispo8niA7a98UVuw7pBrb8qR6XETIvvPmnmGameLw3CaHNlHWf/Bn/3
         aQ1X1gCQu92BKS+A0vFcGQGuzsm5rEFSZoXZ2TKEg9TdOC8L/+Zdbs/7B5XYMzoFd1fL
         5I9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771961338; x=1772566138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d0g9JSn5hJ3/0cUOdGHJ8XxsbIzvXLpEXYfQCv5H66A=;
        b=YkJz3/UAyclbE36aqhKHcCZt/RD7jyspQDdXO5lpMZ6ZGHCkMIK4ZwsTybAgFSZMQS
         0gv/PLH1ixpm2rlqx/awWbzaUbsad1TESYrJhge43EzsQ6YBS/ChwmMt6ebwQX/ZUdp8
         jd4y0m8D01akRQHdj1baQWPkYE/z0FrjAOkb2sZTOzil9IEi3ao7ehYq1ep43Ud6sciZ
         vy/DSK2BQT7R4QOGqeRZMMBgII7VdXnOmh9UOKpL6ZIBMfksYzRI1zRaFTHEE1lS7Rgr
         m4QCRgI7DOElnzmgzlG57BQ++2MHBdlN7P8PSJeav4vdyUuE09+eVodqD18KvOIrEmAS
         i89Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBn0D8/r2i7FxwDkGzsh+B/rXPvgex5byd+04WK+nQpWIldP77B0tfB8CDJLhsycLlXFUnosr2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3C5/SiaADjOz/Za0gKKHQeR6AGA9AnE+vKeFhx89C6KoXy+R6
	+OGXNT84g1RK+vEsLxodjSsNEAiVP/Q5Z5PivKfzE2Ou3L/1Cd+Ut3zYTwgbfgUChb/8zPJIKGa
	MVCLi9qwqPySc9z3rkfvM5Dc6xSmbrP0FtLvE
X-Gm-Gg: AZuq6aILfFf1BykqzbqfOMHWU0HHCM4VHERnBkSuguTrj50Ckg4K5bDtezj6EOqvPDn
	WnWMKW+oP9LJvQ7E6AVo7H9vUUDtsB7upLIvD3QxVFlGGvvfoi6FC1By1aD5lnAXoNmfHLmyYuA
	QeVuibDaK4tvTv28YqL35PGwnX3QwjUWCAIQT7ZKPmGDeiYTwetrDu3g4bebJbvpeAC7VK4dlHw
	ufFHHoQ6dxT3vsaHOlwXNz9tiCKW64jzcK6UrOKswg4FrsyiyIRXl8uJbRgb8DGYuvk/LT+G4Sq
	okRkebbLGZ5Ud8bNyZYNOfxbBLeGtnH4ErJ++MpvTww9RUHG+WVSSiiJWyW3r9mF5Ow=
X-Received: by 2002:a05:620a:3911:b0:88f:ee0a:3d66 with SMTP id
 af79cd13be357-8cb8caa1338mr1636967585a.80.1771961338031; Tue, 24 Feb 2026
 11:28:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224020854.791201-1-airlied@gmail.com> <20260224020854.791201-8-airlied@gmail.com>
 <ee914ffb-5c3d-4d41-abdb-5ed02db326c6@amd.com>
In-Reply-To: <ee914ffb-5c3d-4d41-abdb-5ed02db326c6@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 25 Feb 2026 05:28:46 +1000
X-Gm-Features: AaiRm50QKMBq5S5enORbZuDApNPwLLHkYHnIYA5Ik3gHmkQKI-riIj_9p1f_rEU
Message-ID: <CAPM=9txUuS-qzA+gX2DvTuYR2OZ79RG86FuDA6czkpuJ_SR6KQ@mail.gmail.com>
Subject: Re: [PATCH 07/16] memcg: add support for GPU page counters. (v4)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>, Waiman Long <longman@redhat.com>, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14231-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,amd.com:email]
X-Rspamd-Queue-Id: D914718C14D
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 at 17:50, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 2/24/26 03:06, Dave Airlie wrote:
> > From: Dave Airlie <airlied@redhat.com>
> >
> > This introduces 2 new statistics and 3 new memcontrol APIs for dealing
> > with GPU system memory allocations.
> >
> > The stats corresponds to the same stats in the global vmstat,
> > for number of active GPU pages, and number of pages in pools that
> > can be reclaimed.
> >
> > The first API charges a order of pages to a objcg, and sets
> > the objcg on the pages like kmem does, and updates the active/reclaim
> > statistic.
> >
> > The second API uncharges a page from the obj cgroup it is currently cha=
rged
> > to.
> >
> > The third API allows moving a page to/from reclaim and between obj cgro=
ups.
> > When pages are added to the pool lru, this just updates accounting.
> > When pages are being removed from a pool lru, they can be taken from
> > the parent objcg so this allows them to be uncharged from there and tra=
nsferred
> > to a new child objcg.
> >
> > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> I have to take that back.
>
> After going over the different use cases I'm now pretty convinced that ch=
arging any GPU/TTM allocation to memcg is the wrong approach to the problem=
.

You'll need to sell me a bit more on this idea, I don't hate it, but
it seems to be honest kinda half baked and smells a bit of reachitect
without form, so please start up you writing skills and give me
something concrete here.

>
> Instead TTM should have a dmem_cgroup_pool which can limit the amount of =
system memory each cgroup can use from GTT.

This sounds like a static limit though, how would we configure that in
a sane way?
>
> The use case that GTT memory should account to memcg is actually only val=
id for an extremely small number of HPC customers and for those use cases w=
e have different approaches to solve this issue (udmabuf, system DMA-buf he=
ap, etc...).

Stop, I have a major use case for this that isn't any of those.
Integrated GPUs on Intel and AMD accounting the RAM usage to somewhere
useful, so cgroup mgmt of desktop clients actually work, so when
firefox uses GPU memory it gets accounted to firefox and when the OOM
killer comes along it can choose the correct user.

This has been a pain in the ass for desktop for years, and I'd like to
fix it, the HPC use case if purely a driver for me doing the work.

Can you give a detailed explanation of how your idea will work in an
unconfigured cgroup environment to help this case?

>
> What we can do is to say that this dmem_cgroup_pool then also accounts to=
 memcg for selected cgroups. This would not only make it superflous to have=
 different flags in drivers and TTM to turn this feature on/off, but also a=
llow charging VRAM or other local memory to memcg because they use system m=
emory as fallback for device memory.
>
> In other more high level words memcg is actually the swapping space for d=
mem.

This is descriptive, but still feels very static, and nothing I've
seen indicated I want this to be a 50% type limit.

Dave.
>

