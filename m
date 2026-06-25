Return-Path: <cgroups+bounces-17269-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JqRRFqF0PGrcoAgAu9opvQ
	(envelope-from <cgroups+bounces-17269-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 02:21:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A45656C1F7F
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 02:21:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DAzNOd2w;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17269-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17269-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 572DD304C2F4
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 00:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6BF1FCFEF;
	Thu, 25 Jun 2026 00:20:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393E51A9F96
	for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 00:20:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346809; cv=none; b=cOzriiSg4Ema01D6agnJuVZR26IZ3LRdvPfGQmXdLJkE6ySgQ42mjQn5ZL+HP9u58unmsG7yO78AnwFejx9YDpnTZxKX+8TfYvswd1iw6GYNzSJgl5+KBkBNvOQrxEeb1N8z+4nUaHUKQeu6ufGTiWzp3LHecPXebY5GlGPZJNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346809; c=relaxed/simple;
	bh=fY7+bUuxKJHhkMlg/OMsgTjLmFr5r1RNaNQITyHNXNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjOcJ/yGHSnmf5yqTqKykTKkTPwvjw3Tr/Di1Ex+mSNbvAoq1wIzZZXzW5EdJJlSkvcZb5hgdnqycRSiT0Wx9yJ3aNneWysI4rWmD2TX2ga0fEnNqQhC2fqOsBAskrsaeV1NTgiF16FBRN2yOGX+p/56m27aYiBhALH2mn9/poo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAzNOd2w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D9A1F00AC4
	for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 00:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782346807;
	bh=GaDTHNyPCuwGlJZtEErsLrra/tP7EwBADY16bGtkFLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DAzNOd2wfalPKQKwUMPXu4+xy4pbvkHFDKb+g31Xtt380+pfYj4MIdv0guKnqhxI5
	 6vXN9SDscGePYOmAkXA4UmcC5XFaP1qGIeaWq1BvHLwScIovSzX/bnLsGAjiWUouGu
	 rdzACn220InIMJ+zuELrQM6MB83joHc0TwYxs6fbpHErLOsxWFTeJrv2WIXQkZ5jOa
	 jQ8D0dagDRoY0llwRjg3pOWa/lgZk7GHon45zEegrqDC7Y0+YtMyVcKrRmahHtBa7P
	 xwhMSgGvUbSwb3LyzAtMGrUZkUKiVi5ifisZHsecYsL9BbR0Fi2wRsX8eGJ8hxg61P
	 vebkJhycHE61w==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bec49f7e35eso292456766b.2
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 17:20:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/GMDeDvmFR5EztSTjSjA2pja3QRCj2k5V16aD5gTYZ4R6Q0oR9o57arwMaX1bncH1aeiDRMieZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxcLTq52xQl9guzZnKn3TV/BGAsg2ezy8TZMs1NZmy3e2H4PKaK
	7NwfHpM9ZzEI9/moKHdz+BnE6XXZI3t7rLRO4Ol0WOel+oldA2ynRdJZ8YJlkwX3Yo6lGQcAicu
	LvnGhM/1CocJEeNI4yyBYdM7ANbdiQXw=
X-Received: by 2002:a17:907:9447:b0:c06:3880:69fb with SMTP id
 a640c23a62f3a-c1205d9708amr874266b.3.1782346806413; Wed, 24 Jun 2026 17:20:06
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612193738.2183968-1-nphamcs@gmail.com> <20260612193738.2183968-4-nphamcs@gmail.com>
 <CAO9r8zPXk2eRbVcEMQDTCH1j-w241h189=p04FenAfKAjkkQtA@mail.gmail.com> <CAKEwX=PT_ABx51--Qv9AAZwkuH+_Wp_TeiUYVQBY=1=SCf1HJA@mail.gmail.com>
In-Reply-To: <CAKEwX=PT_ABx51--Qv9AAZwkuH+_Wp_TeiUYVQBY=1=SCf1HJA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 24 Jun 2026 17:19:53 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOEceZYXdHTYgt0mtguSxUJSN5J2Bkw-pjrahJ4cZJpZA@mail.gmail.com>
X-Gm-Features: AVVi8CfGQ0RpYqrGMUl9fqUkWLSmyqqq_AxtQ_wAezMJ7rmI0W4t3fPDgzwvfBw
Message-ID: <CAO9r8zOEceZYXdHTYgt0mtguSxUJSN5J2Bkw-pjrahJ4cZJpZA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/7] mm, swap: support physical swap as a vswap backend
To: Nhat Pham <nphamcs@gmail.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17269-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:youngjun.park@lge.com,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,lge.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A45656C1F7F

> > > +       if (swap_is_vswap(si)) {
> > > +               if (entry != vswap_zswap_load(swpentry)) {
> > > +                       ret = -ENOMEM;
> > > +                       goto out;
> > > +               }
> > > +               /*
> > > +                * Allocate physical backing BEFORE decompress - if it fails,
> > > +                * no wasted work. folio_realloc_swap sets vtable to PHYS,
> > > +                * overwriting ZSWAP - the old entry pointer is only held
> > > +                * by the caller now.
> > > +                */
> > > +               phys = folio_realloc_swap(folio);
> > > +               if (!phys.val) {
> > > +                       ret = -ENOMEM;
> > > +                       goto out;
> > > +               }
> > > +       } else {
> > > +               tree = swap_zswap_tree(swpentry);
> > > +               if (entry != xa_load(tree, offset)) {
> > > +                       ret = -ENOMEM;
> > > +                       goto out;
> > > +               }
> >
> > There's a lot of divergence in the code (in this patch and previous
> > ones). Seems like a lot of it is to do xarray operations vs vswap
> > operations. I wonder if we can abstract these into helpers, e.g.
> > zswap_tree_store(), zswap_tree_load(), etc. Maybe the name is not the
> > best, but you get the point :)
>
> How about zswap_entry_load() and zswap_entry_store()? :)

Even better!


> > > -       xa_erase(tree, offset);
> > > +       if (!swap_is_vswap(si))
> > > +               xa_erase(tree, offset);
> >
> > Maybe this can also be abstracted into a helper, but I wonder what the
> > corresponding vswap operation would be. I think folio_realloc_swap()
> > will have already "erased" the zswap entry from vswap. Maybe have a
>
> Yup that's the right logic. We already change the backend to physical
> swap slot here, so there's no real "erase".
>
> > vswap helper that will only remove it if it's a zswap entry? We can
> > probably do a lockless check first to make it cheap?
> >
> > It's probably silly to do this, and maybe there's a better way.
> > Generally, I think the code would be easier to follow if we abstract
> > away the xarray vs. vswap stuff into helpers (where it's reasonable).
>
> I'm not entirely sure if its worth it either, yeah. Unlike load and
> store, erase seems a bit asymmetric in the sense that we only need to
> do it for non-vswap cases.

Yeah :/

Maybe just add a comment why no erase is needed for the vswap case.

