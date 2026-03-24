Return-Path: <cgroups+bounces-15029-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBx6K9bIwmmIlgQAu9opvQ
	(envelope-from <cgroups+bounces-15029-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 18:24:38 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E018319F6A
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 18:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B871B3011A74
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 17:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679A0369996;
	Tue, 24 Mar 2026 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbTa0vl0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69704407562
	for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373019; cv=pass; b=kQjSSenvJCtBWrT5cjGxN0QxYqkVr/f7lCIzodEpStlNscLSPHdapFOhq2AXShqF323KFFBC/2ZNoOPUJiZJqi8l1DEMPuPyu9XsuX7ysPcfVbhWFtBMUpnA75VbqfixV0CWFZ+XyM0DO4Ha7AyppDSElhT4KuIIs4f+5l3v5Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373019; c=relaxed/simple;
	bh=ADQFV5wS3JCAtbpPelSvRH/EcbFi5KJMA+4XwSLSTOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZwynsYVnByt2M0020vgKcQPDiAvMkiPpx15ek1/m5wt+ZC/58JRR8f9RY89TtrZhXpVIiH/m1dFigFEX+8XaNKiLZfn86JY8wX4JgLs4xN1VL0VAsll2aKiL9emNho0rypstypDHcghU36I9hMz4QzQmRXkce4nNet/JDhnLhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbTa0vl0; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b4915161fso4033340f8f.2
        for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 10:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774373015; cv=none;
        d=google.com; s=arc-20240605;
        b=kCTmdCxswiwjtuWi2O2ubaWKdDeF9qLTZuu8SLFZ3KdZTGInrjEbomkJrQLw6SN29o
         4c4w5qw7d129Pt15U14aRwOMDbMfP3uzt6oOdyt6VjU5SquTouJC4f0hCgq5l//AQiRM
         jA0YQv6bSvyuxyHfWnuuJGAyH4VjTAXPt8otJeRPMiUEygwZy99THdhoxcY4szU2llsk
         HCgw8E2hf/CR9mxwyHCos3r2RoqE6JYSAaB2mVlTevcm8pKZBqQqTdgM1XvAadeGBTfI
         LIiKV/T8ZOwlgOBZl9Bt+jhEuMD1YuoqxWp7ceGoqpV9ybkmEe4at4e0MahzA9tugvVq
         E8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ADQFV5wS3JCAtbpPelSvRH/EcbFi5KJMA+4XwSLSTOE=;
        fh=BxbZjJUh08FWx6cfB0YHo+ifCurciMN3lUpPH/h2eJ0=;
        b=baCKrRZX6emysr8/tvT6cA3/Tj3ykyQ73FJZloGNicovml7v0SZampC8rOOazUqcHe
         FwdMVrXxeSmsppuAs76Dkf3L7WrzEQZywlnwLrYsCQBgcgfDYtw17WcoWJNTap5aMGMg
         9A4Qbpp8+vMNqsPg/oMGFQbRV0XbNdRM6UwjluH7PlyUYu9p9PdFOBVOX/BjkVAwfu2w
         T/xB12ouPji6HwDvF7+Lx+NICEZkVfkUA18N8VkWQU7Di+OFfYMURnO4HFFq2JJgYFAe
         KMYHLGR1Yd7GwlMpHreILyzHwE8FCYHLLMAN1hhlcj6xYEO13oDccrrzfg8adjK0q5Nz
         dIrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774373015; x=1774977815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADQFV5wS3JCAtbpPelSvRH/EcbFi5KJMA+4XwSLSTOE=;
        b=QbTa0vl0TfCraCZXg8A5WxS06CK+SnCFN0gfJV8GMmRIJohko8Q/3NxWZ2G/IOvZXZ
         d4omFGFmipRl5bbiPZjiUvCWtZDOrc9HEKAJHiW9imEND2pW1dB0U6U7nEphDG3xka0o
         JjOZ2/zh6GeVEqCanRKx2sfgfAaFkvdQdBFV+YaoZjP14VKVAxVELn7kvvNTVutzfOi7
         0hFufRHeHPWsUw44qWKhyEFBgbr4YrMxiZcIur2crcE/RAO/bi7PJyNeYCoVPI3jOwSD
         dKQbWnGn87K+NEb8OM7qq6VEg09KE1dRC4q58SP3FxHiH1SqqlZNRredealWSJClIaHq
         3D+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774373015; x=1774977815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ADQFV5wS3JCAtbpPelSvRH/EcbFi5KJMA+4XwSLSTOE=;
        b=ixxXJlWCjf17oWaIHOQueBelKb3JeJ/sFV40qt86Ys86i9zkEmpnHTT3jLWE9gWlvW
         nPzHnh2h3ucCsHFnu8hQyu3cNJZgotyyee1he+hoocWfdab6iW7ZivGiLQnSuGxbGtLJ
         3zPor1z0qgI3lqLQSOxntgVh1t8lU9IHUvLk010fgqr2y+uSGsA2Fo18z0Jd04Z3S4n1
         j+D9Xw9uQTfPWValq9sGR0PKBKWpfMy7v33TbWJP8Fp5YeopBo9lgZo/9wMM2zmi7uy7
         vcTrGQuoh4v8OQYTE+ad5IGDuhxjh3H48tr5vhVeuvqV2rawVZ4uRlIdiu+j42Wh9MuC
         /2aA==
X-Forwarded-Encrypted: i=1; AJvYcCVmoojIsdiBugqaFhRuu18x4GiZmYntR83tKdPbdD5rc8TNqG/HMVZNaAKw32BalaW/MrmuV/dL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9+1zh+eZjgFRaxtUGj8MeyQq59MxX4J00Uw86gMCOalIDrY/J
	1b4Xf2Pk3MGkgAmiGUE7H2c9ZNY2jCj+2aL7unwjgOR2wMiOo+6XVP3oa2M4S7erCJxbTpP9Z5k
	/yAALI0epcEx7iozZInEoVxXzCGKckeU=
X-Gm-Gg: ATEYQzwymZ0vL/ZLhwp6dNiloRZ68KIsA9f5KIiayJCzzuEY8jzAsrn+hrPmm4PRiDD
	4ts1fyG5rUuHAUrmoc7bJFGDP2r4KyZ1UwFvd/awlk7AuwNzneizcCs/p9k/K1p5AWSeW7R1Muv
	y+zO+s6ylj4btfY9LQ+gDjq/T6DR2eoOm2ppdRJx9idQrN6T8QpgSXBcrWCFiRWLvCDzDJB6YEC
	ODWwjdu91CICM4EYffTgg/xnM9pBvCpCJZOwprLMwWs8rIuaZE7uDBmfzrhJNovlwuwcf16CfH1
	ethDRPBELNoxFZ9+Y7ARN97lzHA4TBFBclQfnatE65IHVgYXX6zSazk=
X-Received: by 2002:a05:6000:4028:b0:43b:436d:781b with SMTP id
 ffacd0b85a97d-43b88a1acdemr451493f8f.40.1774373014027; Tue, 24 Mar 2026
 10:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <20260324131931.4004123-1-safinaskar@gmail.com>
In-Reply-To: <20260324131931.4004123-1-safinaskar@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Mar 2026 13:23:22 -0400
X-Gm-Features: AQROBzC3hVhU93LxfbLzywKCT0KcJoCMPUplZMLmSEgnO1rcgM2PnL8QUVFELHg
Message-ID: <CAKEwX=MgoPmiFdBQXK_4=XuR-8mVpGr+3Ku2MfjPmHCeuUdGJg@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Askar Safin <safinaskar@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com, 
	axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, kasong@tencent.com, 
	kernel-team@meta.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, riel@surriel.com, roman.gushchin@linux.dev, rppt@kernel.org, 
	ryan.roberts@arm.com, shakeel.butt@linux.dev, shikemeng@huaweicloud.com, 
	surenb@google.com, tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, Kairui Song <ryncsn@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15029-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,tencent.com,meta.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,surriel.com,huaweicloud.com,suse.cz,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_GT_50(0.00)[56];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3E018319F6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 9:19=E2=80=AFAM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> Nhat Pham <nphamcs@gmail.com>:
> > We can even perform compressed writeback
> > (i.e writing these pages without decompressing them) (see [12]).
>
> > [12]: https://lore.kernel.org/linux-mm/ZeZSDLWwDed0CgT3@casper.infradea=
d.org/
>
> This is supported in zram. The support was added here:
> https://lore.kernel.org/all/20251201094754.4149975-1-senozhatsky@chromium=
.org/ .
> It is already in mainline.

I'm aware of that work. It's an improvement, but my understanding is:

1. It only works for zram.

2. We still occupy the full PAGE_SIZE slot.

3. The writeback IO request is still of size PAGE_SIZE.

So we're saving the CPU work for decompression, but not the rest of
the potential benefits of compressed writeback.

For zswap, decoupling zswap and disk swap is a pre-requisite
(otherwise every zswap slot occupy a PAGE_SIZE slot in the swapfile
anyway).

Then, we have two alternatives. Either we implement a small-slot
allocator for swapfile-infra, or we writeback a full backing page for
compressed memory. The second option is a bit more straightforward,
but then we lose relative age of these objects - a backing page might
combine very recent compressed pages and very old compressed pages.

These approaches have different performance tradeoffs and need to be
evaluated. But anyway this is future work.

