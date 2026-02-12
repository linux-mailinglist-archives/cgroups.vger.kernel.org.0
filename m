Return-Path: <cgroups+bounces-13879-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN56GhtgjWnN1gAAu9opvQ
	(envelope-from <cgroups+bounces-13879-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 06:07:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D1C12A5AB
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 06:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E30EA310E101
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 05:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92302749E6;
	Thu, 12 Feb 2026 05:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VThiPv5S"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA15264614
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 05:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770872853; cv=none; b=Z4DvCxY1gAAetlR3TfkCYk9a/zKNpN3KYuRv2p65j/Eku/ZvoCoCs4B7KCjheXMx5+uKpZub0CxDQ+3q8eFlVxm+bJGkWOABpeWC2OiZEjMyw4SkIdEmmMcFFIcV7T5DGhJXXXFFp5PoyycybwsiryvaksWnwQhVBige4OetLSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770872853; c=relaxed/simple;
	bh=EosASMTX2s9CcIWPWVdD9Epc98EOoJxCZ11MXv+yVnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzr4rpTJUCbkDplUAMo6WeOWS4EKISutt9HS35j+/YuFZz/ZbGmZwcfLdLS2bMdripgfzHEkXJ8BMtTmziu6YFuiXhQe4xRcz8HN1NLFYOyrsz7VT9X8aeey6Cfn38z/AXOdWojJhtMc1uVzJJP9yqvrEVYlL4znJCqrP/+vxKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VThiPv5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B7CC2BC86
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 05:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770872853;
	bh=EosASMTX2s9CcIWPWVdD9Epc98EOoJxCZ11MXv+yVnM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VThiPv5SMbZEL/DadPMgq+mMtrYpHmln/TSs8AhEw97M7Faeeuws9vFsH/bCmqQpu
	 33dlouVWkrWPCw1pE80IHQqSFazOJOEkWlHdV/UHniqoY/VJFSL4g6I0b2QF62SFjn
	 JphkosFI2fy9ggHqegdKfnsPbznEG7wdwxQwqeECOpU3r7Kl8FMDuqBIEBDBuoAA5g
	 BmhZF9+nJ/SxHVLT/fKJu1TJnGVT8I8kHATrFpK74MvOrTccFT6DqBAkxGiOvT7NHQ
	 EyH11HrBCNf+QHgfdcYfHSP2AnBin6I02bH3NyfJgOrOk+tAGLHCfD/oR1EwtD0rdS
	 5d/P67ie+zDRw==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79456d5ebf9so63190857b3.2
        for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 21:07:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCaCRvPhhvGHwzxf3GWP15iQhBASmifcK2BTrdgJS0+C+bsSnkNT2dNRP5/OjRy16eD0sKWGkk@vger.kernel.org
X-Gm-Message-State: AOJu0YyUukxzgSIki3PL7lOBafiNHiBFFjAAzjVuJz4fbnFEpN8z8M+i
	+hzRdmQNK6LoI0T0g7JbUfu06XWz4FDebG8TYuRZlsmbWP2018Q3K1mq3tBHPrv9qraexDLDNd+
	EiNs/ZLw+9EHRLXJpiWQAgPYRpxkQOIhRHVTe/STEEg==
X-Received: by 2002:a05:690c:fc8:b0:794:dac2:89de with SMTP id
 00721157ae682-7972f113502mr19419047b3.17.1770872852305; Wed, 11 Feb 2026
 21:07:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208215839.87595-2-nphamcs@gmail.com> <20260208222652.328284-1-nphamcs@gmail.com>
 <CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com> <CAKEwX=OUni7PuUqGQUhbMDtErurFN_i=1RgzyQsNXy4LABhXoA@mail.gmail.com>
In-Reply-To: <CAKEwX=OUni7PuUqGQUhbMDtErurFN_i=1RgzyQsNXy4LABhXoA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 11 Feb 2026 21:07:20 -0800
X-Gmail-Original-Message-ID: <CACePvbWCZhdF6vyP6BEhyCGXurST7EewNk=HGcE_qVGAwJpFPg@mail.gmail.com>
X-Gm-Features: AZwV_Qi4jBzTgP6vyYE2l1ny_j4kHipqIQCjBTH1peMA4w-c1bJcYp0Pl-VIEPg
Message-ID: <CACePvbWCZhdF6vyP6BEhyCGXurST7EewNk=HGcE_qVGAwJpFPg@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
To: Nhat Pham <nphamcs@gmail.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, hughd@google.com, yosry.ahmed@linux.dev, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, len.brown@intel.com, chengming.zhou@linux.dev, 
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com, shikemeng@huaweicloud.com, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, bhe@redhat.com, osalvador@suse.de, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, peterx@redhat.com, riel@surriel.com, 
	joshua.hahnjy@gmail.com, npache@redhat.com, gourry@gourry.net, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	rafael@kernel.org, jannh@google.com, pfalcato@suse.de, 
	zhengqi.arch@bytedance.com, minchan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13879-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kvack.org,linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1D1C12A5AB
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:11=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Tue, Feb 10, 2026 at 10:00=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > On Mon, Feb 9, 2026 at 7:57=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> > >
> > > Anyway, resending this (in-reply-to patch 1 of the series):
> >
> > Hi Nhat,
> >
> > > Changelog:
> > > * RFC v2 -> v3:
> > >     * Implement a cluster-based allocation algorithm for virtual swap
> > >       slots, inspired by Kairui Song and Chris Li's implementation, a=
s
> > >       well as Johannes Weiner's suggestions. This eliminates the lock
> > >           contention issues on the virtual swap layer.
> > >     * Re-use swap table for the reverse mapping.
> > >     * Remove CONFIG_VIRTUAL_SWAP.
> >
> > I really do think we better make this optional, not a replacement or
> > mandatory. There are many hard to evaluate effects as this
> > fundamentally changes the swap workflow with a lot of behavior changes
> > at once. e.g. it seems the folio will be reactivated instead of
> > splitted if the physical swap device is fragmented; slot is allocated
> > at IO and not at unmap, and maybe many others. Just like zswap is
> > optional. Some common workloads would see an obvious performance or
> > memory usage regression following this design, see below.
>
> Ideally, if we can close the performance gap and have only one
> version, then that would be the best :)
>
> Problem with making it optional, or maintaining effectively two swap
> implementations, is that it will make the patch series unreadable and
> unreviewable, and the code base unmaintanable :) You'll have x2 the
> amount of code to reason about and test, much more merge conflicts at
> rebase and cherry-pick time. And any improvement to one version takes
> extra work to graft onto the other version.

I second that this should be run time optional for other types of
swap. It should not be mandatory for other swap that does not benefit
from it. e.g. zram.

Chris

