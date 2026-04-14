Return-Path: <cgroups+bounces-15294-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG77E+Nt3mncEAAAu9opvQ
	(envelope-from <cgroups+bounces-15294-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 18:40:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A22B83FCAD0
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 18:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55F66302572F
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 16:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680F72ED866;
	Tue, 14 Apr 2026 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRQqD7U/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69B025F7A5
	for <cgroups@vger.kernel.org>; Tue, 14 Apr 2026 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776184537; cv=pass; b=pGzLwt9MNH0loz5rdZkJ8Ds5a4AW1Fz3UuXy9qBbXZNVWd6igZ95DUVrhjskY7O47Ka0zSaA5WhW/FoP5PvZsYR9FIh3SmbYqwmDwtLL3yYDABrQWEX/7zOb6BaJgo53beg9nDSSOXQxOGoXK4RYJRuavkkhTvDwqPN/4nk0zOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776184537; c=relaxed/simple;
	bh=xYiD8mPQzgv2ojv2b6lBy802NgdOj9ELcJpY/+bSZFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNmCAk2hkAAgQo4mOnRnurZt0n7A+vEkljyl3VwbrjpysiEot8kgtvsG0g+lPdg3LgZzmWy9oyIMSyGkMSCI9CT6dYIZuUYhBlcVF7hBgduzA87AydUleuwRTeJl6tiQYRVJI8aX8M237v5pDo1t5Ig5h2WpWqUE9Scac0KAMls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRQqD7U/; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d70c30767so1722712f8f.0
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2026 09:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776184534; cv=none;
        d=google.com; s=arc-20240605;
        b=Zts8WTKyE4glduCHh1pOy+JtGdGID1mwa+C8SgdRULDqJsFdjeL1vm9bcVdVNTpVTr
         nAdR88BF50M7ABFsBB6Fs8Gv8M81OfQtFujMYxPVD5fkePA6YAuo2C/25kXIZUkPG6Nn
         eo4HSJiwuNGZoFVyifXdjBKy9WNB8+KUXP/m0dG0usDGL9kFd8CbDVJt6YImvvOd2Gi+
         dp3dHzp0jnXZEnQjEjdt9cWHNluXeuGsieMzHYfuoY6RjfjzQR1JcBk/bT0kPx/aaUQk
         UYk/YDsQ1fwgqEGSPECTVEAnETszlv19gv/4uaAhxDmLDx3XNbiVZxDLUsSNmOEEW/Ev
         NDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fQleDbjaYYUSGdpynlKDYhzpuJpOjymZUKR/yJ1TCio=;
        fh=uEBSKJTUr2ENePUUU0IFNo/tV4dfmngA+sFiQ8u5D3o=;
        b=KQqkPeC9TraYd3hXFrCZkOXDv6r9VcIp9rHgg8R3tgAMqkoQsWEsTZOlr9ayfJ0zWV
         aGI7UkIJPyoIzR0fmQstqahCokbspFP1P2wgO73zDdG57zBV+hgDME1yd2EvpUHIZZfW
         b6ucWRSMUzZxgslHjV+uSaD4NIKUetQbJoqlv9tc/0nIB4we5IROjbkkphMYp3FTIXnO
         acbaLHttMrFZngGZAVl5UOvCL3w4sbsdSPkj8AtNHw/LCebvfveoflpFd0bJg6Tqdg5G
         7r01mn5Ps7DSsv+Muol0+3jFYNqzgiPnaqBP5MN2+xJ+hdEZ94eN/GxxZAACUucafI93
         c0fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776184534; x=1776789334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQleDbjaYYUSGdpynlKDYhzpuJpOjymZUKR/yJ1TCio=;
        b=iRQqD7U/7sTULcNbGNjYaQDl0Xrs7FNVw60c+DtlpI7ZmQN/fe+64cSQrjShAvZMLl
         YuRde/SR3rZiRKCgscsVSY/3sLiAdY83B/YPTmopOlr3fnw3jfkz/PKZX/xqImPeuBaT
         XaBS5QOarKISOJqVhPsxIfn6QvB7WOWX7jqU4qErzTlJ+4yLnKFd9ieFsJnuIqIHtZax
         p0x26LfT+JWaRSDKsVsyJExbm6zk8UwjZNMoKrlvRIG9fUW25p8jEPoFokZ0Q+CGFns7
         gqCc+v6I1ow7f0DphGWmExphDW/FABGqqdygM52tdN4yMR736CLcr8BULPlreiCShLdx
         NQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776184534; x=1776789334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fQleDbjaYYUSGdpynlKDYhzpuJpOjymZUKR/yJ1TCio=;
        b=hFxEIXS3rk4ulNErnyn1HOZB3UWx4w8oOpQGXhTlUEFbdZs2RXGKYfDXniLFe9a6Fi
         gMgg958gwOhFAPo2dx08V8cIfHo3eF0hhRzYFTJ67Fv7FZ3NdqomOvTqQhZCLXmHWG+9
         3bEv3y4LZnfoSsI1hSJ9XQ2XOmvC+OLdeQyC14V0YCKJH3AEkxfH0/w7MUWOeSk0NMFy
         9jZX/PISSLhFiPV4046LRco49ucoxkEtu8XCIbEC2vA6KiLAva1oF074QAjsg4mC/4J5
         hp5GzLaQndxDs94lTYzVePVgqfpCZP/DOGnKrQRdPLBZusExAKs0TgVrhydFvJNCdSz3
         vXlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+umrGhrZ7/2lMEIb2pyri1E3NJ94+QtUkPzA2QlE7yK4VLXLZ8ZxT1H0teFnp3+9Bw+WEVL5PV@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGYRvDe4h1HXBTlXfuVTfR7cknxLGtAQcxsdlkDAVkFmj+vyX
	uuqFKSX9QkQonVGi2K589E7OVywWuD6p0Q7KDJlbvfz30NdGOEj4BVa5vdmMvfTXHMWkYSAem9h
	rD4dOxz2Q3IJNo9rVnqO3ox+dtvFm/v8=
X-Gm-Gg: AeBDiev5QqW9nYUs1lyhxGMO9t+v8l5SJWQFB6cd9T+5g4jhNt0k6tngoWvOi4OdFCp
	eQu+D85TyDJ7P9Ly8FfSLHwcPv2GftpdGVSk5NXLsUJfU6yGhl9S+0EV5+pFmwXhEGTylUTDWb1
	MMNh8S3SsyjDBMT7Ylw+LvYQbIAbgeGDkj9EbxTbjpegTOqsEbsHdcPGiovj1vfpxRl8WT7vrDu
	akM7zEou8g5RZKDywEGoVMOWa/Iz/lJbKtpu7IjGgGf9n41uuWFp6qkRnomFP0rqun3jsuj+Z9U
	/f41L71IUgprsQyQ1UCP3YWo9AeM32l3CQ8ucnY=
X-Received: by 2002:a05:6000:25ed:b0:43c:fac5:d382 with SMTP id
 ffacd0b85a97d-43d5958e3b8mr30561697f8f.12.1776184533792; Tue, 14 Apr 2026
 09:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <acQrQYHJgqof0yx4@yjaykim-PowerEdge-T330>
 <CAKEwX=NnHxpQKp9qBg2=r_euyjgxw2nHXjbgof3MymHTgJmRAQ@mail.gmail.com>
 <ad2rYH9tUPthHFoj@yjaykim-PowerEdge-T330> <CAMgjq7BO6SLZPfNXDh1F-7RAOqDAfqMQ4PM=qjAq1mCsWyD0LQ@mail.gmail.com>
In-Reply-To: <CAMgjq7BO6SLZPfNXDh1F-7RAOqDAfqMQ4PM=qjAq1mCsWyD0LQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 14 Apr 2026 09:35:22 -0700
X-Gm-Features: AQROBzD5xGWfOWAJA-1nI1ObWe4VBmguR2Q9Syvbquy-jm8YJp-HL-l7rnLn-Mc
Message-ID: <CAKEwX=NtcGBnDpSuePqfK9G4jACC5gU95-69A4z5JzKkYRq1YA@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
Cc: YoungJun Park <youngjun.park@lge.com>, Liam.Howlett@oracle.com, 
	akpm@linux-foundation.org, apopple@nvidia.com, axelrasmussen@google.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, bhe@redhat.com, 
	byungchul@sk.com, cgroups@vger.kernel.org, chengming.zhou@linux.dev, 
	chrisl@kernel.org, corbet@lwn.net, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jannh@google.com, 
	joshua.hahnjy@gmail.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org, 
	ryan.roberts@arm.com, shakeel.butt@linux.dev, shikemeng@huaweicloud.com, 
	surenb@google.com, tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15294-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lge.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lge.com:email]
X-Rspamd-Queue-Id: A22B83FCAD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 8:29=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Tue, Apr 14, 2026 at 11:05=E2=80=AFAM YoungJun Park <youngjun.park@lge=
.com> wrote:
> >
>
> Hi All,
>
> > On Sat, Apr 11, 2026 at 06:40:44PM -0700, Nhat Pham wrote:
> > > > 1. Modularization
> > > >
> > > > You removed CONFIG_* and went with a unified approach. I recall
> > > > you were also considering a module-based structure at some point.
> > > > What are your thoughts on that direction?
> > > >
> > >
> > > The CONFIG-based approach was a huge mess. It makes me not want to
> > > look at the code, and I'm the author :)
> > >
> > > > If we take that approach, we could extend the recent swap ops
> > > > patchset (https://lore.kernel.org/linux-mm/20260302104016.163542-1-=
bhe@redhat.com/)
> > > > as follows:
> > > > - Make vswap a swap module
> > > > - Have cluster allocation functions reside in swapops
> > > > - Enable vswap through swapon
> > >
> > > Hmmmmm.
> >
> > I think this would be a happy world, but I wonder what others think.
> > Anyway, I'm looking forward to the future direction.
> >
>
> Yeah, I agree with this.
>
> And I do think swapoff of the virtual space itself is also necessary,
> we really need a failsafe, e.g. a clean way to drop the swap
> cache and data, kind of like drop_caches or shrinker fs are
> commonly used.
>
> > > > 2. Flash-friendly swap integration (for my use case)
> > > >
> > > > I've been thinking about the flash-friendly swap concept that
> > > > I mentioned before and recently proposed:
> > > > (https://lore.kernel.org/linux-mm/aZW0voL4MmnMQlaR@yjaykim-PowerEdg=
e-T330/)
> > > >
> > > > One of its core functions requires buffering RAM-swapped pages
> > > > and writing them sequentially at an appropriate time -- not
> > > > immediately, but in proper block-sized units, sequentially.
> > > >
> > > > This means allocated offsets must essentially be virtual, and
> > > > physical offsets need to be managed separately at the actual
> > > > write time.
> > > >
> > > > If we integrate this into the current vswap, we would either
> > > > need vswap itself to handle the sequential writes (bypassing
> > > > the physical device and receiving pages directly), or swapon
> > > > a swap device and have vswap obtain physical offsets from it.
> > > > But since those offsets cannot be used directly (due to
> > > > buffering and sequential write requirements), they become
> > > > virtual too, resulting in:
> > > >
> > > >   virtual -> virtual -> physical
> > > >
> > > > This triple indirection is not ideal.
> > > >
> > > > However, if the modularization from point 1 is achieved and
> > > > vswap acts as a swap device itself, then we can cleanly
> > > > establish a:
> > > >
> > > >   virtual -> physical
> > >
> > > I read that thread sometimes ago. Some remarks:
> > >
> > > 1. I think Christoph has a point. Seems like some of your ideas ( are
> > > broadly applicable to swap in general. Maybe fixing swap infra
> > > generally would make a lot of sense?
> >
> > Broadly speaking, there are two main ideas:
> > 1. Swap I/O buffering (which is also tied to cluster management issues)
> > 2. Deduplication
> >
> > Are you leaning towards the view that these two should be placed in a
> > higher layer?
>
> IMHO the swap infra should be doing less, not more, so we can have
> more flexible design, and different backends can implement their own
> way to manage the data and layer. e.g. Having one backend being
> flash friendly and it can do this without caring or affecting other devic=
es
> or backends.

I think that's what Youngjun already has, unless I misunderstand his
descriptions.

>
> > If it goes into ZSWAP, there would definitely be a clear advantage of
> > seeing dedup benefits across all swap devices. It's a technically
> > interesting area, and I'd like to discuss it in a separate thread if
> > I have more ideas or thoughts.
>
> Just branstorm... Why don't we just merge these identical pages like
> KSM? Maybe at least zero folios might benefit a lot if we keep them
> mapped as RO instead of recording them in swap, seems better in the
> long term?

That's our preferred approach too. We just didn't manage to get that
to work (yet). :)

