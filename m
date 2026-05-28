Return-Path: <cgroups+bounces-16408-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFJtENm2GGqkmQgAu9opvQ
	(envelope-from <cgroups+bounces-16408-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 23:42:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A415D5FA835
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 23:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 490E0300A119
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 21:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED673603D5;
	Thu, 28 May 2026 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls8wq3x8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D0E34D382
	for <cgroups@vger.kernel.org>; Thu, 28 May 2026 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780004557; cv=pass; b=lF9J6UJmJJNC48DwjOXEumNHoBXKkDPNkr3vf3YBLMur6/E21OVtxQD2v7uSrUtoB76MUobMCyjn6JRalwzZ8wB5OlSq1pg7YpheSde4OnEs4nUI/JuwrHJHhjVEbebHto7P35hN2uSkRLnwW3LTvQmFO1JKeBZuQ4xtYzEv6OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780004557; c=relaxed/simple;
	bh=9q/ZTSfTHT3ONJVmwny5oeOHsuAhfuQbux3JGsklk0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/ZFj4VV3LQQdXfWQQ2rqcFkuquNyJhYzT40Il8YE9u66FMKucUywtbOPKnl/lVVm/253Kjll9m9NhZU0O9TF5gcwhG9XWedg2diY+514UpWhfIPDKXh0AiQZvvMPKc0rpdDcCr8fSiDen516g4QwFCjiiYanrrYWZykaYno8+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls8wq3x8; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-393d6025f99so125513521fa.0
        for <cgroups@vger.kernel.org>; Thu, 28 May 2026 14:42:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780004552; cv=none;
        d=google.com; s=arc-20240605;
        b=SAND+mUlYxBd2SrxMKHtb/UWpafeQ+N6E14jrjfVZ+85wVOIBFd8+ZoPkkHWpG8hHb
         hFryxvfIY1Syr6Amvd9TA8cFlJnLTzUxOikkUHHendlNg/QcK41v6T3t7c7w5LWKV4tL
         D7h05IvUOGlGBRYZfHyu6ZGk/F3zr+MlJK/xwwjK7Nsdb5vg4uZ56qEk9qP45ag12q19
         ljt5sKJuj8FIlLm2q7oCck9CHF++QfxBWVURrZLUJ1yF5TCP05ikmTsD9TpwXkB1g6F2
         u3ZcCkYQ/WtWlGjid/4VY1YEk4+Oqob1Sj13HkH7DLqhYVUsuuzIFtT/J6/Jh7MnLvrU
         TnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9q/ZTSfTHT3ONJVmwny5oeOHsuAhfuQbux3JGsklk0A=;
        fh=GUjw8bZQdW6qxzuiv1WEcVr1jTxDZXKM9Y5O4BnCpq0=;
        b=l0/+QYebsv3jt1hhpy2aT1CvPMUn8z6hHl5eEt7uMCIeFbYiEQmYvw5uKzX0Vm5bjc
         7RRlLNaKCpwcH+lfGurKFw4y4+JPaBx/LWUTckZqUwyGsBdyLqRf4MxP7OjpGWLnuSvK
         CPxHiwEnEQT85dMjYXKG8Sj+cwEoRPAAVy0gjBJ1ZlTK4LJ1Y7n2GQXAY/qth3UD2tpb
         zFSGkrKwgBhp/3dc9pn8BjoJo375UNxVxEVBrn8N7mEkDcdueQXabUrJb2gg3+37bU2T
         aTA5X/x478W/O1H6/RMDMKNKLEbDTOQHEcTEgnpx4yp2H2cNSYX8JCUzi4FE4pf9zC9y
         rzww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780004552; x=1780609352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9q/ZTSfTHT3ONJVmwny5oeOHsuAhfuQbux3JGsklk0A=;
        b=ls8wq3x8kzyt7HiA06z5ov+GmK03Y5FbkxXShtTR8+zDslhmsPgzDkJItOwIO6496P
         XusRh2vZG8XbLp2bgEzTyavSpAKV2yNT//DBY1++FtyRKsFYwrHrrJHuLQwegE5BCcge
         2XXXa0IhGyzmQ23dNpLmvZ7gL5m55u2i6xcE4z3HpnPnj6BX6aHMThdRsKDvnhY78z1l
         c33mfHCdz3R8dVtuKD4rfjNhu/sX/EpgxRhmliR+AhQgciqyKu5q+4q4EUryG802VElJ
         n4kZbfpqnoA8XqN1jrhsMNdZ7paFJP9M//gZsLn3zZ97PJeucpT4TFYmt6Evwuygkvmc
         bLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780004552; x=1780609352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9q/ZTSfTHT3ONJVmwny5oeOHsuAhfuQbux3JGsklk0A=;
        b=ibQViKwKiZh7++/A2MQrFRz0K4OXodz3Yxl9IbDQLUlXAxZTLCUzVR87FSp7uyPsLq
         VlO2MqhkYp0ZIpqaW/Yb35YzIZk4gjBQyHmh5qYy7jOGkntBHqzBxe2QucZ2wGyYJ/04
         cV0X2SG32XhV7Ol5v60kvnoeDF9MuqspZ0J35GAjHvlsS0I6eXfszdmFaKiIiuXpgmZy
         euP2YdvWlYoznAc9bC5MnQzyZFdTaxHt8RaYqv9DoW+ats+qiCl3uENPwei8anI4EfKH
         1/mbSuYpNxUnjJGEnM3FuYpx7117BTpL/8MdRQp/B8xLBdS3pIO0nDoiDyve0GmliCHr
         9z2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/1+ren2jpGldx59Cm3MtMk4GjOBGIM5OA0M//tDTxAl+6pSUH9L2NyiFx+w4U2lyiJVU0pC/Zk@vger.kernel.org
X-Gm-Message-State: AOJu0YxVZ58Vl4PmRwE+KXP1s5Qeb3z1U9/zrci5lvnEAfwJUjheLDdn
	65N4SQ8TNJtpbPSTlreT6TvcO2u/Eyb7twBTkFQmVSxSsYcOlk2oNU3sxBzFb3RPcmCQBh/lz4C
	8ZVfxNoP8xVVw9ke02ynTnj5TQlhf4eM=
X-Gm-Gg: Acq92OGltg9zpPpsORGhWmdN1vKOqZlWCBBuvs82muc2MyO9EJgaff+lAR8f68iboDT
	XEJfT30bW7leYJeuawxza9FqZFpPRsB1+n6XOwijnBHE3a9CyiE/M1Pkds8gPZKlW5gVfyeJzd0
	sRH4GIZ/D0ou7VYuAu4JtRELvO7g8dPNkEQ7tI3jefJQIrRHD+0NKn8UTTO3PcLi+hFEGN6gO3e
	yBATQPSbskaS4z+3oPJ3IXFT4T4aTsXbx4au69CA9bXM5UaqjWwCJ/QV14vK307ZACj0FvyTSxE
	c7Bh+676wCQ7Jt4OuVr/0sA+T/pPcNkylPEpbOWs4WrmjFteOw==
X-Received: by 2002:a2e:a695:0:b0:38a:2a56:9546 with SMTP id
 38308e7fff4ca-396536f3de0mr174701fa.13.1780004551665; Thu, 28 May 2026
 14:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505153854.1612033-1-nphamcs@gmail.com> <20260505153854.1612033-2-nphamcs@gmail.com>
 <agJcCZuLqWwU_sSR@google.com>
In-Reply-To: <agJcCZuLqWwU_sSR@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 28 May 2026 14:42:19 -0700
X-Gm-Features: AVHnY4IQjMrNxr5cCHgyMIwBGAESeNQ717suquaX-CqDf9_dL7Z_N08muuwMcik
Message-ID: <CAKEwX=PZnKqfriUsPV2whZyqxfCRNy67z7gyrHObEvztDF0_zg@mail.gmail.com>
Subject: Re: [PATCH v6 01/22] mm/swap: decouple swap cache from physical swap infrastructure
To: Yosry Ahmed <yosry@kernel.org>
Cc: kasong@tencent.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com, 
	cgroups@vger.kernel.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	corbet@lwn.net, david@kernel.org, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jannh@google.com, 
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
	riel@surriel.com, haowenchao22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TAGGED_FROM(0.00)[bounces-16408-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: A415D5FA835
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 11, 2026 at 3:46=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Tue, May 05, 2026 at 08:38:30AM -0700, Nhat Pham wrote:
> > When we virtualize the swap space, we will manage swap cache at the
> > virtual swap layer. To prepare for this, decouple swap cache from
> > physical swap infrastructure.
> >
> > We will also remove all the swap cache related helpers of swap table. W=
e
> > will keep the rest of the swap table infrastructure, which will be
> > repurposed to serve as the rmap (physical -> virtual swap mapping)
> > later.
>
> I didn't look through the entire series, but let me ask the same
> high-level question I asked before. Instead of moving things out of the
> swap table, why not reuse the swap table as the representation of the
> virtual swap space? Seems like most/all metadata is already moved there
> in a nice concise format.

The honest answer is I wasn't sure it would work, so I was hacking
quietly a prototype on my own time :)

I finally got something that survives stress-ng and constant
memory.reclaim thrown at it though. I figured I should send it out to
get feedback before digging myself deeper into that hole:

https://lore.kernel.org/all/20260528212955.1912856-1-nphamcs@gmail.com/

There is still a small problem left (the metadata duplication issue
that Johannes brought up). It is potentially fixable, but I haven't
actually tried it out yet, so I don't want to overstate here. But take
a look at it and let me know how you feel about this alternative
approach!

