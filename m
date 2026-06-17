Return-Path: <cgroups+bounces-17044-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C+0UEfixMmrg3gUAu9opvQ
	(envelope-from <cgroups+bounces-17044-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:40:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A1069A9D9
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:40:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=oA8rh6Q0;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17044-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17044-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EAB2305A713
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84AE44A71C;
	Wed, 17 Jun 2026 14:40:14 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F143DB960
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 14:40:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707214; cv=pass; b=TDVYyKaKbMjYxJu7/5Q81PPBBu5AyJDFbi1XX3glJ3/hvbfqQrmz7MV8ZnbkWc0ZF6A0eUF/5od4j4vW0LfRoHf+TSaQZwuAqDiFlz9ApQM0yt7GBPDIJmzsTwh+0zed7tMShQSsN/VKG8ACWNFsqrsm/W1uUCodXhYupc5oyhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707214; c=relaxed/simple;
	bh=SrECtSXktFVmwe2HfKzsMsXW5gYWCynhrT414gDrZrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVhtjcrNbUL7yRI7YmmoLcWRI+FvdDMpGagASVs9Oqj8Zb6f/QX5DvgCBLLv4xxeEoVzQndSKeJ1S+7jlCikc5TQV3LMCa0szZ1tY1Kg1qsPlVMrLVBpKk3XaxeKAYXIsc0GygfE0EpXK7Q/WK2vBWhZGjjvnc8eiegyI2dLAy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oA8rh6Q0; arc=pass smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51765331535so263831cf.1
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 07:40:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781707212; cv=none;
        d=google.com; s=arc-20240605;
        b=KGgeqL5AzAi3CmU1A63TGcruW3TT+aT2aQpVoN4AVGtYMJB5AI7d05YdIEwTQK/fWk
         db5VwKE4rIzToy8GHR7vfRpBFoopYx+qlCsiwoGNItoMQLHP3OmfNbhxl8gEltwZOqH7
         5rbDzkgZWwVpgeVZOuYQ/3Df0SXQKzjykwpNAl9jp9Hp7/gV1ihPUXgWPSi2YsV+a70A
         qGx2365ptu2GiiaPuv6MijzS0jrXL30vKqk5cgnV4T+3sG1ZaBGe/CQTyi8fcJAaBtti
         d/Dkm2xjFAVZyF8tFrsBMDHspvakQuOXeHr6o6o+AiL3WYXfObcq1jAlDxz/xf5Q1LwV
         8Ihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SrECtSXktFVmwe2HfKzsMsXW5gYWCynhrT414gDrZrU=;
        fh=sflAe4+eaKjFEpMyJ8R4I0OQHzu/i3bhD3C/1I4IthM=;
        b=OTqXxJ1NRml7Y94nv5mLvg9lC26SUW7eWl9k2+W/CNx51bv2o8gzmmYryVr7NsBheK
         v08ucJpaZqapLZIFJS2mk1iF5vlW1a2qNRYm3hexdgzc8aZaqenngZ/ZpenKV+dTxUbv
         E+Mb8oJlFGdt73LOwXq6tdImrE+gIZpYQ06U/oOvsB0zNTllTPf9EC8CKh1LongcIQFa
         tr4aBJZNKJQuzwjPk1Wotndf/CwfJ41Qij8hGBDMnyW5tQgBQRk75gdth9dbY5q25PgD
         axP4uBCwfSVKXqvc8aiURbmsy29Lg6PGi7IZvdiBV4HU2yE3YuselwSB7YHFxf7eOC6o
         w9NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781707212; x=1782312012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrECtSXktFVmwe2HfKzsMsXW5gYWCynhrT414gDrZrU=;
        b=oA8rh6Q0pWYj51q2L+7TcECsPzR9YrONFVd3boSeaKzMz12Fn9aup0I5SFSIV0RpAm
         SKPyZqk+JUtO1bqWlo6CECqvB7ElIYQ+ifgvx2XahtzRH+Zmb9ZKS5Hl003MYOZIaZ3Q
         MW6LPTeSr5vkbrgAwILdkUdtMahEh4RIsrnl5q6A/ZYmGNa9CZOu+jTnmHX8izKhXoiV
         L/c4mqbwuL2te3msmIBNpZMyIjxpx8OFQ61bfQldmKThEa8ys3+9TZfIPSY3CfJP5Ubn
         CHIrksCEIkGRr+TgK2mF8my2Pci7Yop4uussxdfdudkTksdO1/LfsWWm++YXGMVvTw6+
         PJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781707212; x=1782312012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SrECtSXktFVmwe2HfKzsMsXW5gYWCynhrT414gDrZrU=;
        b=bW8tsa68kKDr9whRaiMp38sxakRU7XLvMZKPsWkkvbTTbWlU2iOPHnYd6oDH6utzJt
         4QHx+o6Bsutg4qF5SG3aRl43QORtYtQgB2kgkI7+9RGhuClTLryPGzEfrujxM5VVgtFy
         S/+EG4G2fI5LCH8IUuqbCMNPKtiY8HuqgMCjrmp6j/R3WtVnJWxhkeiNuKVCspesOru2
         q4qGXxEQpCH1qoGYingf9O8zSRLlebUqeCBGqB2alaSg2KlXfBHK1mv/6yo/HLhh6Dek
         Y7afuCxRPnrbFGszoe8Sc8ld725tD2SOgiNCxa0s7TUUw7BDoXTZW2MFooVYYrrARenX
         8ViA==
X-Forwarded-Encrypted: i=1; AFNElJ+sPQBgENftg98dq91FAUCk59d1cHONHHXE2WmZg1VvC6mx32h46/XsJdzboOQtZ7HeslJSR3AG@vger.kernel.org
X-Gm-Message-State: AOJu0YyfGqaOSOjD+R6ZPYDqffaz3Uyv/I03Il/r9pLKAOMx0hnwdBQq
	5kJus2OsmS+Vg/pzJOaZibBPKAdsNnaoa/5q/fF2TBvVwff35MrKpIo74/I65nz6g1TeM2CoNp2
	j/esKYn3ZTuo29rLLF8tWcvsIt7T/gvIvkL7CdtZg
X-Gm-Gg: Acq92OG52Osdpfi/bRcOAc8F47xqPPNIcYi28GqNk2+H919+ajG3BsqM6oaLA4z+vcZ
	QooCfrYbjq0VFpjjg3bQAV7qAmOU/1pu6DLA9sH895MW9mrzwHqdAJmihGPR0u+1f+j0ZiGCSj/
	cQwtqkTBotXhP7xJZkBhuF8dRo38c+CGGVxxz+DiwHmK79TZhBDLWbPGZ/JgofPqHDImeAO9tkd
	B4aYaw3liE/qOtzYOYL7wE3ainC5eY2PDNP6DpCCpTlS3vx7JVaen3SE9U8zTxkFj8YOweDIJz7
	T4iRWYzE06RLeBhWVyku3l4TZXs=
X-Received: by 2002:a05:622a:1809:b0:516:ccc0:ee38 with SMTP id
 d75a77b69052e-519ad992ba9mr7504101cf.9.1781707211224; Wed, 17 Jun 2026
 07:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-7-7190909db118@kernel.org> <f9b7935c-f5f0-496c-b55e-1f3feee5c87a@kernel.org>
 <CAJuCfpE3XfxLmV-DzM5nLqYqGsFJThr-1i4bmEEqMpGZ28RLFQ@mail.gmail.com> <1c63fbca-6ee4-466f-bfb5-5ff25a847607@kernel.org>
In-Reply-To: <1c63fbca-6ee4-466f-bfb5-5ff25a847607@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 17 Jun 2026 07:39:59 -0700
X-Gm-Features: AVVi8Ce_vCvZNT5yYs5Y8bQHsLpdQUSPne6OsjaB_y8AFj79h8otRJdz2a0FfJg
Message-ID: <CAJuCfpGiDKygFBTAwwiBaXL+dGJjTR232Rd_ARTyAtjEAMkDZQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] mm/slab: replace struct partial_context with slab_alloc_context
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-17044-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6A1069A9D9

On Mon, Jun 15, 2026 at 3:01=E2=80=AFAM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> On 6/15/26 04:36, Suren Baghdasaryan wrote:
> > On Wed, Jun 10, 2026 at 11:05=E2=80=AFPM Harry Yoo <harry@kernel.org> w=
rote:
> >>
> >>
> >>
> >> On 6/11/26 12:40 AM, Vlastimil Babka (SUSE) wrote:
> >> > Refactor get_from_partial_node(), get_from_any_partial(),
> >> > get_from_partial() and ___slab_alloc().
> >> >
> >> > Remove struct partial_context, which used to be more substantial but
> >> > shrank as part of the sheaves conversion. Instead pass gfp_flags and
> >> > pointer to the new slab_alloc_context, which together is a superset =
of
> >> > partial_context.
> >> >
> >> > This means alloc_flags are now available and we can use them to
> >> > determine if spinning is allowed, further reducing false positive "n=
ot
> >> > allowed" in the slow path due to gfp flags lacking __GFP_RECLAIM.
> >> >
> >> > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> >> > ---
> >>
> >> Looks good to me,
> >> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
> >
> > Ah, nice! The conversion I was anticipating in the previous patch...
> > I would do this removal of partial_context as patch 6 and then convert
> > ___slab_alloc() and get_from_any_partial*() altogether in patch 7. I
> > think that would keep the behavior of the ___slab_alloc() more robust
> > throughout the patchset. But I would say it's nice to have, not a
> > must-have.
>
> OK, so I switched the order of 6 7 and all the changes from
> gfpflags_allow_spinning() to alloc_flags_allow_spinning are now in the
> newly-later patch; the "replace struct partial_context with
> slab_alloc_context" part has no functional changes. Verified that the end
> result is exactly the same, and only updated changelogs a bit.

Thanks for the refactoring. LGTM.

>
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> Thanks!
>
> >>
> >> --
> >> Cheers,
> >> Harry / Hyeonggon
>

