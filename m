Return-Path: <cgroups+bounces-17052-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +8x4NA7WMmoB6AUAu9opvQ
	(envelope-from <cgroups+bounces-17052-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 19:14:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E63969B9A1
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 19:14:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TctmaP0+;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17052-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17052-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74A48305D5C9
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 17:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3AB4B8DF0;
	Wed, 17 Jun 2026 17:12:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9E3FBB6C
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 17:12:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716330; cv=pass; b=UawagCJtMaRV5s2uxwiIpgw2uXNDNVygl4EJt5H4NGSN4xLscLarb5OYzlgAZwEv9+QUE+mMk8w1kVk+atCyXDsWuVcBW52XhuGQEc0xFaQVPYlVEkmcNVh8aAckwbwyEz4kw0HYR9utUUHBVkyr7YwZusEpBZnhxLbPBBgb6/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716330; c=relaxed/simple;
	bh=hBgVYCVjdYfk0aVRhelrtdNC3fQCPGI1gI+8jkOtitE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4s38qFLuo7Gt8GpI12IHMbXS1K1PGWjbwFe1M9nBCvix0ZzX1Y+IJ4H5iLLexQhEmdNFBzWLRCyxSMfvNm/JJyZ2BmqCStmIyqvzt3niXTtyjn0Se02WMp5nqYosy/DWNYrR/TosespKjTxI8As7u0ygMtArqQpllB8tmyVJzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TctmaP0+; arc=pass smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4629051c9d1so44615f8f.2
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 10:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781716325; cv=none;
        d=google.com; s=arc-20240605;
        b=TEbxm11lpqh0EGcM9+0NA4lL7yLCiwUaAkWC8IE3XeYfvT540lDFyLGVzDcJPu68a3
         oY+FoOP4QFrn2OGHv3xPKwsz0NCXY/ifPnSHZSbcQPS4LuY85W0Mu5ddU+psrG/9qa6h
         SlvyQqTYP2GmhlVyvl+UCNylkxLyMPNvxAYhC+9ZTO/GCaSZJPSrlNahdC3yTMmyPUT8
         iAws480tSEJ0IHeE9NHWrxVaI1MmrcYzUqrSgTwFZhiyN3x5CxlfPhEq545i0r5gyR7M
         1wThhjb2jnmMMW9Ry4vbzvR5ZFzOuE4OaBnEnStBC9AQpna14Caz1nacAP3MfKNbhP0D
         MNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hBgVYCVjdYfk0aVRhelrtdNC3fQCPGI1gI+8jkOtitE=;
        fh=0BwGYHf3z8DMn5UiRd240tuh2V6iQWkdDCJN8fYgfNw=;
        b=jTnXlx9JvXUkSdIl+BDau0DLhGLnQyQsaxHO6BNlmOd44cgcLglx1/3tEOnSRSpDbF
         Iz6/aMc1nqwNtj0/lIXVFP+ejFiQGgcY67+pdoaBSB9Uh+hg+O7LZfoqoWfFrYxHcNQF
         JxSRTJcP9yAy29IxBZalxL1Ij7JjlwuwUWDC2s2Kc+L3/wkaVe+YiqYxyIZXlBr3oANp
         AqMx3F07CstBPDXRW+V7kxNbFyafec/crUZsvGirOs41N8A2v+jVx/8nb1bXrFENbPVb
         U7pDMMyfPYxjvYp4oFdY8lb4XtCK/09/Oi40dBo7LGYihxv0x//ps8OTVC7jHtO80x3y
         pYxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781716325; x=1782321125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBgVYCVjdYfk0aVRhelrtdNC3fQCPGI1gI+8jkOtitE=;
        b=TctmaP0+SsJf0Xp1fUQjka3BEJIPQAylgzC5xdczSKk++iaF2Pvk4mvoWljYyp7kGJ
         SduW5KQTXoxel89k+PAoDHIo9pqhTWSqlqf26I7dpu8Zjt3Wxy0dbmwhCh2gZPLOd+Vv
         HDrFJ7wUHGsKBEhm1LinXztnnfUZLqIYi5632wJ0NH3QWt4oXpmFl04oSIc2Fu67OJCO
         ibrjdebAcxpAE1uypDAzB36b8auhJQufdBcVOakDidu0PJA4hrLEN/A7cUGcPwqite8m
         Bh2TiglzJyLHpPNaaewdND8jV57CrVt9g+5miL0VI1ZbCiSplNnljsjc1MBsOMO1WNsB
         D2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781716325; x=1782321125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hBgVYCVjdYfk0aVRhelrtdNC3fQCPGI1gI+8jkOtitE=;
        b=qJK7WrjwYTWjziUrVvc83dbPheunTMlQOriVHd/FZPQNBS/NAp5SsyGUhiBypO77QJ
         IQRBS7bbikPAsoHq64MhO5hHSx+FdtvJxxwMrKbpMbr96nmx1URRfUIX+SGYUr9HAcJT
         pRG6IEuPgvH9B5C9jafNvJcCy6SqgWq+qIXzZC+/mJKCtLgBcqGH2FMN/+UaitiMtEVV
         Rq//dpvTv8J9hPDVLDDlnjl7bVjqrfNPqO7MBgEojq60wlcvmHHRlnZ/yvmu14w2E4iX
         UvbkFi5OgeP3EJ1aQh7a0vKzQCIkOg6wI1pbwxqzMXWdgV0erFn2nQXd/2SH0O2XSaZN
         r23w==
X-Forwarded-Encrypted: i=1; AFNElJ/JTTA7VYKe5OyvuQqj9DrPxs94nZ/Rg7t7TYOTT6WlOm6bi7NhAjlB5nallA/vcWtaNsl4gF/u@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1lLQhNvw9Qo1O1Jwe+rOyAZThudWeBjwqHizo27lLZZ8wryRo
	1YV7NQm/je3wFKeCg2Pf3OYI6l0Xvtoya0+U8oTeKLjplQlnDwGLLOTW9Ens3VTctfaFXpMaWtj
	vivwTnK7dWLTuZyMYrvDp7YQRdvtTQbE=
X-Gm-Gg: AfdE7cn9SnkXBP8jIi6jAvxcI2m5013USRvQVDuopCdWqje1GfilmMKLMdPb1BaMiwL
	sEK5o4qlwqxAybDlykn01+YIOOLT1VrKNbgHVRJUW08HEI0TsRpaXa3x9k7HWzBbzeO7za5nYQ3
	NZJs/XHwc4WHEM//AJmjbuaulUkbvrVX2HXL0eACMdunpmAh0qZUtr+7dEylUZaaNVSdavKywwI
	YHLmYXYgZy/sDuLDZhqBNzrJKsI3kvP22sDPCBmlBETWfwfwV5pW5V/iaeyT3X/pcDPtIHkhVbj
	MCal0v4BIDPfH2t22H8ljHJuf6W0q4zq9k9oKK8zUQ==
X-Received: by 2002:a05:6000:238a:b0:45e:eaed:afd2 with SMTP id
 ffacd0b85a97d-46233069660mr8853144f8f.0.1781716325060; Wed, 17 Jun 2026
 10:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aictKA0XWMWbxFdN@linux.dev> <CAO9r8zPvCaCqvoUhPdAN5Oi_Sj0mK-t7DJhOOz3Xf1DT-Wrgcw@mail.gmail.com>
 <aieUQUBHI+E3uNPW@yjaykim-PowerEdge-T330> <airzE7jD9UtyR17J@google.com>
 <aisEWnb3pzmVC4dl@linux.dev> <aiu06fbV7rWqY0Bm@yjaykim-PowerEdge-T330>
 <aiw2p5ANjsQUCIHA@linux.dev> <ai5y923elCSZp41j@yjaykim-PowerEdge-T330>
 <CAO9r8zOVqbJEaBqTHw=r2bYw7Lm1tO0TU9QuG+eH1rfqcTAJJQ@mail.gmail.com>
 <ajCgzNIPLhjTRSXR@yjaykim-PowerEdge-T330> <ajC+FNpkVpI4pbBz@yjaykim-PowerEdge-T330>
 <CAO9r8zMimM8n54BL1viuX3pYzO=wzQU89LhCF1HW0bAv97ZQtg@mail.gmail.com>
 <CAKEwX=Nz9SWcEVQGQjHN8P8OANJY4BG0w+iQOzoNOWuteoVjAg@mail.gmail.com>
 <CAO9r8zOD7XaJ0Uo_LLLDTRKbeTOmAwmM3q8q6rUyH3oS-X3Csw@mail.gmail.com>
 <CAKEwX=N=Umi94wdKcLxEWOqUwhz6=Lj909pc1Pr_5ivVnZmdPQ@mail.gmail.com>
 <CAO9r8zMHGFG_jcVeDPgowaQ2RNntp3KankwzQdgrJb9PrWu8_w@mail.gmail.com>
 <CAKEwX=NyfxfXhHESTLyirAgdVA6QaYAcam792-vSZdmo0Pz+bA@mail.gmail.com> <CAO9r8zOg0OP1Ak1v7CRzSfQq0D8b4Dw+_T0Jui6YTM_KwQQNOA@mail.gmail.com>
In-Reply-To: <CAO9r8zOg0OP1Ak1v7CRzSfQq0D8b4Dw+_T0Jui6YTM_KwQQNOA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 17 Jun 2026 13:11:51 -0400
X-Gm-Features: AVVi8Ce4F6qbwirh2XAnhjc2JRmFEEfVWsLJJms1CDA7q8x1ucZACpOoqMz3NrU
Message-ID: <CAKEwX=N_jcaGaPYsUvVi53+35mJhZe123a+6T2J-MsMQ+-cSGw@mail.gmail.com>
Subject: Re: [swap tier discussion] Re: [PATCH v3 2/4] mm/zswap: Implement
 proactive writeback
To: Yosry Ahmed <yosry@kernel.org>
Cc: YoungJun Park <youngjun.park@lge.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Hao Jia <jiahao.kernel@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, mhocko@kernel.org, 
	tj@kernel.org, mkoutny@suse.com, roman.gushchin@linux.dev, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>, chrisl@kernel.org, 
	kasong@tencent.com, baoquan.he@linux.dev, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:youngjun.park@lge.com,m:shakeel.butt@linux.dev,m:jiahao.kernel@gmail.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:tj@kernel.org,m:mkoutny@suse.com,m:roman.gushchin@linux.dev,m:akpm@linux-foundation.org,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:chrisl@kernel.org,m:kasong@tencent.com,m:baoquan.he@linux.dev,m:joshua.hahnjy@gmail.com,m:jiahaokernel@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17052-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[lge.com,linux.dev,gmail.com,cmpxchg.org,kernel.org,suse.com,linux-foundation.org,vger.kernel.org,kvack.org,lixiang.com,tencent.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E63969B9A1

On Tue, Jun 16, 2026 at 4:27=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Tue, Jun 16, 2026 at 1:24=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
>
> Ohh I thought you meant we shouldn't allow zswap to be a tier at all,
> not the *only* tier.
>
> > Or are you suggesting that if we set zswap as the only tier then we
> > can allocate from any swapfile (since we're not doing any IO anyway)?
>
> Hmm, technically having zswap as the only tier should be equivalent to
> disabling writeback, but you're right that if zswap is the only tier
> than the memcg is not allowed to use swap slots from any swapfile, so
> zswap cannot be used. Very good point :)

Yeah the coupling of swap/zswap makes reasoning about these kinds of
things so annoying. :)

If anything, with vswap, I'll stop having to explain to folks why they
have to provision on-disk swapfile when they only want to use
in-memory compressed swap, and that's a win in my book.

>
> In this case I think yes, we need vswap to be enabled to allow making
> zswap the only tier. That's one gap between zswap being the only tier
> and disabling zswap writeback, the former requires vswap while the
> latter doesn't.

Yup! Anyway, I think Youngjun sent out v8 - let's take a look.

