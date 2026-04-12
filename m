Return-Path: <cgroups+bounces-15226-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB67JWfv2mnn7AgAu9opvQ
	(envelope-from <cgroups+bounces-15226-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 03:03:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 043743E2464
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 03:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88B14301BC33
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2026 01:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E66244667;
	Sun, 12 Apr 2026 01:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8iu7lh6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5962913D8B1
	for <cgroups@vger.kernel.org>; Sun, 12 Apr 2026 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775955800; cv=pass; b=lH7Hldu8PCL+ki3GTVeVUJgM6CTaXnXNZK1hjqbsXT3hRpufti8jfzWPVDlwYFN3eGau5JQ4GnO8t6Ayx2RJzgwZ50jnByuK9j7YOBcC0G0QOjorgqyeuetppKa+sJNhat9ZGgtuKodFw/ofHT+RqLbx+yt+fuiaAfN6rkLjedA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775955800; c=relaxed/simple;
	bh=PlZOaj5QMEwQ9f/NbjFyXWBBhXvCrxn2EYbvYVQJYV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZN+QCNYWl/EM8E8I9iZoqagMO3yhZ3X6uWCHXt8oBzYwY8KtXAQBjeAwBeBdFlRavNlMhIkueinpThS+HWuCTuED0vojcPWLsM8+vJt6DQ13PNEWv+5NTXBTEloIdzqrxziqO4g6BhrakzFrngVi52kb+cx4g3dJDdNjD8BLTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8iu7lh6; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d17bb1c1dso2621705f8f.2
        for <cgroups@vger.kernel.org>; Sat, 11 Apr 2026 18:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775955797; cv=none;
        d=google.com; s=arc-20240605;
        b=WiZSa4PDEkmSsSABT0jL3VszOQqWpk7XVxnGB/Dpup1KaDAr1lBA8975Vhhb+15sHA
         Qh6OSG0ekwrWaA/UwFOP/B1G3ZaEIldwlfFS97PLkftg00hONB2EcP7Iq1RIgI9mVOVU
         18UjH3pGjGw/vAkn17ajx3yv7QpxvAcCBZ7wYbv3FCaodODntVarANM3yTpNXmTo0NxV
         Exc/rd19uIZslf8tACNLJPtYai+IAOqFwt3jo96i3SjawAj7WLfm+JtNYAFeiRg8SY1k
         37WKSU7NBJTGxDIe4NK+epRkIBDO2jhexKSKRIBE9rzf1gWNtCfw0sAA3bWFm1a7RB++
         NgOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O/lCR/Upuk85s1KKtsj70aAhwIocyaRuQRg4fGGyx+k=;
        fh=Fl4BUVxrXs/cTyd/qH8kVIDfu/BC6GOBE+CJg6BEAeo=;
        b=ioZ/SdC8yAJX2T9PWhe1EJ63KF2STJ+TgBqzBjCK8HebjAIsgOF9+ke1YhHR3d8JKR
         seCPuv6pL0IHnBpqvdzJ5t9ccBcs2jqfGEwKLHv8U1/Lm5Gn7t3Dco4pKgOgMuaXO7JA
         t5KOEkMp1n6YKgWhURznH1OJrfdrStKn0AU50NaDFJNszliJaBkf4SHOrmC6xJ5JKniZ
         39FriP5dmppNujoLsAQ5La7HeznxXBXQo6/XteWQyLAAyeJ6TB9nFK3YYPljIh/0u2Wp
         PLmhHK3mt1nuLxEVFG6DqQeFCepi0AwwTohtPfAqd/V/6e60vnVFh1wY1Z/js/oXfzLA
         MgFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775955797; x=1776560597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/lCR/Upuk85s1KKtsj70aAhwIocyaRuQRg4fGGyx+k=;
        b=d8iu7lh682alIilkEG+IQW+0sw9tkdjLYdICcAXX41fGk1khJN1o/oRhp+a60E96jI
         5SUor9IK/3qHbp0MgFO45hMezpvW3IS4RiQFoHh3grpdUBVslchzZzc/qxmuIY1I6vl+
         KnQD8EQ7SQdU0nTD6FKFCh+lpuU578JondNumuZYuZX5x2S8Q9o5ew4w4HDj96+RI3C5
         GZnXatBbGfal/g4daouUA1IQJI72pB70si4J2JaIr+HiThjBHepX8YMM+HHlSZBsrDaR
         qBOKpE+dHijWTqCm97F+mYAtmb6thTxXn2mMkFyogokueMvSGQvIuRGBQpuZunOzlRt8
         L3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775955797; x=1776560597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O/lCR/Upuk85s1KKtsj70aAhwIocyaRuQRg4fGGyx+k=;
        b=P1sH6fBMkEnq80ERBICy32Ij5Xo8Pz1mDOSq+BBm/XQQrwsgRrrS6hTj8Nl8oLPMT6
         SxOG+xrs7R7KAFsfCK0WU07669iL66gY/w/6NmPkvUR+5OH1G50xWGotA1/BR4Qw8Tkb
         RDXis1zAnK3jL/cG78n+8Igjf8V2k3uwt61jxJzj5OC/wg0Ets6uoLDwh7NZezwqLy07
         Dbjbi/GjecYzdVLYB5DpHym8/4uPEexgGDU/n/T11pVHF3JqzL/ClphsSiZ8bWNTcFJv
         OfxlOxAqGaCuawH0H6jKuNHecYKbGYqrVn4F2lkLm9aTux8SmOF0NGVdkabL3H1MZbcT
         /6EA==
X-Forwarded-Encrypted: i=1; AFNElJ/XbkiEKcmuKsYdbnciTtKDgby3N2YJrC7RG4tj0Ucfgh0ygX38AzChLyDE84AYpH0q45wI5dGm@vger.kernel.org
X-Gm-Message-State: AOJu0YxdQbOlyv4XphFxDsKYdVD4hC+vn/blEcsZVf60eKgDtwYMRSPl
	Dzu6MbKW+DIsDGUBMaP/xHYfwMZqz06cgm9jBv1TbYfWpSH/2E3a4lHKqeGxAJLDA6ciwyKwAmg
	VTi63DRmUPdFLLkTZLpF25pAeXAbG9TU=
X-Gm-Gg: AeBDiesnJxq8oPbvGmR6GFa5xPLKKOtxucQsmT0a6r7ikfRhkJ+FSsrrntAift92bnM
	BHcEPpMMw1taWc8WibaYh/s0JFBEB+XFcl4JdZWN+Gr8aiMSZWl4UWprbk9Lw5AbVVe9W5rRU2O
	GhW8kZyeU8DxG0sWhkHiCmY7yAEd50NwffhDqSB3pj9lAFDoDBLKspwH1hH9jlM04/UImVQMzpt
	fQXfQFRZWbRHS4jeWa9o7BwjGcGMOjfONS6k7JTKhokj2iUHZGRMZMHNX5G+w8IqFZCsP8q/JkC
	Ptxmt0zWM4VGaiEUbq5Hx6iuJb8uJ82utg6USQ==
X-Received: by 2002:a05:6000:2dc7:b0:43d:2581:3053 with SMTP id
 ffacd0b85a97d-43d642d9d6fmr11425935f8f.45.1775955796453; Sat, 11 Apr 2026
 18:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com>
 <CAKEwX=PBjMVfMvKkNfqbgiw7o10NFyZBSB62ODzsqogv-WDYKQ@mail.gmail.com> <acQvNRLpHwnHt7i+@yjaykim-PowerEdge-T330>
In-Reply-To: <acQvNRLpHwnHt7i+@yjaykim-PowerEdge-T330>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 11 Apr 2026 18:03:04 -0700
X-Gm-Features: AQROBzD_Pt7K9MF5OX7eBfMwphwrIpDFPvFIpxySkOPErMwdGQw3LLfvFpdgRuc
Message-ID: <CAKEwX=Pt04pYfhYOwmtXJKU5OqcxBC14SAf1wpBxBo1D7rPpGw@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: YoungJun Park <youngjun.park@lge.com>
Cc: Kairui Song <ryncsn@gmail.com>, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
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
	TAGGED_FROM(0.00)[bounces-15226-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lge.com:email,man7.org:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 043743E2464
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 11:53=E2=80=AFAM YoungJun Park <youngjun.park@lge.c=
om> wrote:
>
> On Mon, Mar 23, 2026 at 11:32:57AM -0400, Nhat Pham wrote:
>
> > Interesting. Normally "lots of zero-filled page" is a very beneficial
> > case for vswap. You don't need a swapfile, or any zram/zswap metadata
> > overhead - it's a native swap backend. If production workload has this
> > many zero-filled pages, I think the numbers of vswap would be much
> > less alarming - perhaps even matching memory overhead because you
> > don't need to maintain a zram entry metadata (it's at least 2 words
> > per zram entry right?), while there's no reverse map overhead induced
> > (so it's 24 bytes on both side), and no need to do zram-side locking
> > :)
> >
> > So I was surprised to see that it's not working out very well here. I
> > checked the implementation of memhog - let me know if this is wrong
> > place to look:
> >
> > https://man7.org/linux/man-pages/man8/memhog.8.html
> > https://github.com/numactl/numactl/blob/master/memhog.c#L52
> >
> > I think this is what happened here: memhog was populating the memory
> > 0xff, which triggers the full overhead of a swapfile-backed swap entry
> > because even though it's "same-filled" it's not zero-filled! I was
> > following Usama's observation - "less than 1% of the same-filled pages
> > were non-zero" - and so I only handled the zero-filled case here:
> >
> > https://lore.kernel.org/all/20240530102126.357438-1-usamaarif642@gmail.=
com/
> >
> > This sounds a bit artificial IMHO - as Usama pointed out above, I
> > think most samefilled pages are zero pages, in real production
> > workloads. However, if you think there are real use cases with a lot
> > of non-zero samefilled pages, please let me know I can fix this real
> > quick. We can support this in vswap with zero extra metadata overhead
> > - change the VSWAP_ZERO swap entry type to VSWAP_SAME_FILLED, then use
> > the backend field to store that value. I can send you a patch if
> > you're interested.
>
> This brings back memories -- I'm pretty sure we talked about
> exactly this at LPC. Our custom swap device already handles both
> zero-filled and same-filled pages on its own, so what we really
> wanted was a way to tell the swap layer "just skip the detection
> and let it through."
>
> I looked at two approaches back then but never submitted either:
>
>   - A per-swap_info flag to opt out of zero/same-filled handling.
>     But this felt wrong from vswap's perspective -- if even one
>     device opts out of the zeromap, the model gets messy.
>
>   - Revisiting Usama's patch 2 approach.
>     Sounded good in theory, but as you said,
>     it's not as simple to verify in practice. And it is more clean design
>     swapout time zero check as I see. So,  I gave up on it.
>
> Seeing this come up again is actually kind of nice :)
>
> One thought -- maybe a compile-time CONFIG or a boot param to
> control the scope? e.g. zero-only, same-filled, or disabled.
> That way vendors like us just turn it off, and setups like
> Kairui's can opt into broader detection. Just an idea though --
> open to other approaches if you have something in mind.

Yeah for vswap it's probably going to be a CONFIG or boot param.

But in the status quo, we can always add a swapfile flag. That one
should work already, right?

Thanks for thinking about it :) FWIW I think zero check is really
cheap, but yeah it's just wasted work.

(ZRAM folks - do you feel the overhead here?)

>
> Thanks,
> Youngjun Park
>

