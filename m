Return-Path: <cgroups+bounces-17264-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ApMcIjJdPGopnQgAu9opvQ
	(envelope-from <cgroups+bounces-17264-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 00:41:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A1A6C1CCC
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 00:41:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DEwKlsvC;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17264-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17264-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAEFC303D308
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 22:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C82B3B3C18;
	Wed, 24 Jun 2026 22:41:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E368E3B3BF1
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 22:41:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340912; cv=pass; b=atVNFf8uUisG8GJuV16GRbcSNTGgu385+/4KSOsL8teeJiD3e0ufjP8QSnsJ7Sm286JtGlLMzH5zJ15JGiMxqEj+HMd68Z+pS/Q/K4Cgcgv3jfe57rbyI7TB8Z/fnNBVaaRhC1cGJ5rl5NWa2LwCp4ZiaovrF63K4kAT2rEqCMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340912; c=relaxed/simple;
	bh=44vcFT2zS81zuO/QITHQpzEjB4PfuTchVm77v5ONeL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEAC6Aq+3N+lzeE+fVA9iMleuwb1xxPV0hGFvx0uQ4GHX8qjyayGbioIO72GOgmB/hAqQmL8WNSvI7tcMw2qN4XXCXuw4QezvQ8oMSPoIHkv3opI86zT3l/QHdR0G2XqNnWbNZWBTnaR0czgUYpb079saSFL3mH6TGtcfU6IzRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEwKlsvC; arc=pass smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-46cf972f281so405535f8f.2
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 15:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782340909; cv=none;
        d=google.com; s=arc-20240605;
        b=JKIKdi/jk/KYVIHNDNYmP9Rg3CkRR41KMwB3mScoe5e8a5rShAhP1TNX4YSqotT5Ld
         esnzMqLBsUlP/5VV0XasJJtB0NMiyMVJOzxqYPpjaip4YaLBmREG1aIW7OcPfzIm0+EQ
         5B7qiyhAAwg0BooK83szHMDMUumd9RMWi6MT1UTTKPDIOgRgZlnJ/oZuNpHW5NbNfWhL
         MnHo2u2poidgqydyUhOjbrCSD3u3PshUi03DPu5rg3eYqgatq7D6BBhDLUGd7VBDC+Gm
         4rapZAQEAF/HoOOKhhlSON+NKHhPaNWL2AauyAnlW/qy61dK4IpG9RbY5oyMtFgCU+yt
         iEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WJs/bqJV28nRmEFkkVv0HdnYQ72Ru/Q9zWNCjXeVDns=;
        fh=Oby7TF3r+2dFoCqG8xxzDTgxiUZHdaB0CgLVwZ1PozU=;
        b=EbUwVncPx5AH6mX+gPV62ReTo5c7Es4rc4q8EJpsqNxyUu5lg9jMcuPbyOwWU7hiUS
         S5uRjr7cThKxParc1CBEtqg9jEAEtHhD5LvAdGpJ2PyOIuJxYkX0QMGBpG3Xsh44Gi0A
         mLehhe/gymLbfVPn8KQUJ5+vD527xc+o44G65BkR8riP6fzhWz3iQu9K++7sMqwka5KK
         kgJZfxFEHfDgBCO9SRv6dTX2DTlhgl6fYyyzbgMgQEhMN3FQNzYKTwrF1JJ2dB3GS8GZ
         GMZpRwaK+RBK6KNpe6xuc62MHhfd9ktUTg0KTJAnthWAhmKOKUwIRd7/uLRpLs9JsQEF
         2j4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782340909; x=1782945709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJs/bqJV28nRmEFkkVv0HdnYQ72Ru/Q9zWNCjXeVDns=;
        b=DEwKlsvCinJuFjIjF+71iBf4LBKFUneOinYk6iPGZZ+3qekkSh6J2bvkc9cqLps/pc
         84X0iJMKaRZYngnf7I2ApWUMQknHbuRWTFIJPBqUAXuubcHvniQwuy9IIR8Y3pafDwlN
         eSZcj7OzuxmLIrgQDNhuvWT2RCDQQFdIb7CY7gpnV/7HfFIkX06vrXWqjGBCky6HLMz5
         UndAahnDoUXQKesah6Q/jUqOg0DbnG971Iqyei53DMvmR5jrYLBbKv75BjTDWZZcNw3G
         GJUo1q2lyfwY8k/dndqdi2spHPY9n0HL6jXGclKdAXG90e5CFuJcDkuiNGvaobVCchIu
         CKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782340909; x=1782945709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WJs/bqJV28nRmEFkkVv0HdnYQ72Ru/Q9zWNCjXeVDns=;
        b=Ws7fXIYpbQmeQ/wTnZ6RE5MoabUUMM0sJv7G95PswRrKzGxMS5+tLBQnmu+y7YclNY
         4xx/rbF0w1gGzwnUtyCfketCRlKpijWRp01hyXSsYdSHJWsUQz6MflUBVUlIgHtmmIHd
         AwNLn1WCuKDYDXFwFZiPU4qF0n1CC7TZNlxalRHG5cqsckKIpFpBOs0x7LLTyslOOl9n
         IZ2tfA8bPIEExzty5yIxm+LlcujO0x4GFSN/Uh/uczPPDS+qcTR3UteKZjR2jl60xxcc
         Lp6ZULryI8zVDbD5PbSQVE1r8zo3iPyD339FeLyQDXPIdjfl4sJyN7UuI2InhOU6bAqq
         U4lA==
X-Forwarded-Encrypted: i=1; AFNElJ+eLV11B1CaMlCg9fgO+jw/wOVldxZTbUwPlLKpIZLERboqu+RnSV2O4gx4hrdp8YCCUQEwu0uD@vger.kernel.org
X-Gm-Message-State: AOJu0YyMqORuxCcNU8MIeLaaNlSHP9D0+HisPVfowd9ghnpz6NkOlUN1
	orLGoUDTbQPDjVgpTj8e24a+DIWW9dHeG15xXh+vgix/kKeB4a08/TbTB2AAt00L481JSmR1NMp
	FhnFtVVIIxhCnxHsqtWSK3J5YXbJiuz8=
X-Gm-Gg: AfdE7clgM9AfnwQ7RnwTywwmQmh3+0Uhf0ITXJEmWge4pXweFhFm2fz/NZ3X4KfB6tD
	OeQzRWlO294U5dH/dVWthhGiQnERKw6NrHQ7t5kNxK5Ntw8jVak+CL2tnEM7TndpBXkTXL7tKc7
	4etCc4684i07LyMrR38IpGGaGqtTGBXf9jE3LCOyAD+WNQERDH4JksUmcOrtoD5t9usFvzbNvpM
	Mv3A6RZYlmu/jIM3MEsuNsfL6mPu7GiXh9ZYv68pU18WXE4nY66mdoVQLIyrS4Q2pg83Y8I6i0T
	1NjVo5d3LY/u0GF2HlrhaxB5YVeKzU/EViC8lGeT9N/qMSDpGv5uzVY=
X-Received: by 2002:a05:600c:2256:b0:492:5cb2:aa54 with SMTP id
 5b1f17b1804b1-4926087ba9fmr54723185e9.34.1782340909046; Wed, 24 Jun 2026
 15:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612193738.2183968-1-nphamcs@gmail.com> <20260612193738.2183968-3-nphamcs@gmail.com>
 <ajnQxMY0W3VGyAUE@google.com>
In-Reply-To: <ajnQxMY0W3VGyAUE@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 24 Jun 2026 15:41:36 -0700
X-Gm-Features: AVVi8CcLr7H4jR5RtejdKP7Hpj9u7s-tS31S_dqbqyaFggMebkaysX3HiNPrzN4
Message-ID: <CAKEwX=PwOV1Oh8B=QyrfGXSR-Xu2wUBTE-VOQhXv9-YEhYGZEw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/7] mm, swap: support zswap and zeroswap as vswap backends
To: Yosry Ahmed <yosry@kernel.org>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, david@kernel.org, muchun.song@linux.dev, 
	shikemeng@huaweicloud.com, baoquan.he@linux.dev, baohua@kernel.org, 
	youngjun.park@lge.com, chengming.zhou@linux.dev, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	qi.zheng@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, riel@surriel.com, gourry@gourry.net, 
	haowenchao22@gmail.com, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17264-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:youngjun.park@lge.com,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,lge.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21A1A6C1CCC

On Mon, Jun 22, 2026 at 5:18=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> [..]
> > @@ -1623,16 +1642,14 @@ int zswap_load(struct folio *folio)
> >       if (entry->objcg)
> >               count_objcg_events(entry->objcg, ZSWPIN, 1);
> >
> > -     /*
> > -      * We are reading into the swapcache, invalidate zswap entry.
> > -      * The swapcache is the authoritative owner of the page and
> > -      * its mappings, and the pressure that results from having two
> > -      * in-memory copies outweighs any benefits of caching the
> > -      * compression work.
> > -      */
>
> Forgot to ask, is dropping this comment intentional?

Ooops. Lemme restore it.

>
> >       folio_mark_dirty(folio);
> > -     xa_erase(tree, offset);
> > -     zswap_entry_free(entry);
> > +
> > +     if (swap_is_vswap(si)) {
> > +             folio_release_vswap_backing(folio);
> > +     } else {
> > +             xa_erase(swap_zswap_tree(swp), swp_offset(swp));
> > +             zswap_entry_free(entry);
> > +     }
> >
> >       folio_unlock(folio);
> >       return 0;
> > --
> > 2.53.0-Meta
> >

