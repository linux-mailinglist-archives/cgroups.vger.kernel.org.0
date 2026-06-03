Return-Path: <cgroups+bounces-16618-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GTUsGBZvIGqo3QAAu9opvQ
	(envelope-from <cgroups+bounces-16618-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 20:14:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED02963A74E
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 20:14:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gPVDFSoI;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16618-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16618-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45B1B3011EA7
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 18:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6185838B7CD;
	Wed,  3 Jun 2026 18:14:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E8373C00
	for <cgroups@vger.kernel.org>; Wed,  3 Jun 2026 18:14:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510484; cv=pass; b=ECa1fhUTzs3rqBAn2ddvTLW7e8B65un65mLvnA79ZxUzeMUVBxG19BWYercyWRRD+W9paen3NuQDJ6AYsw4Isr/e7zF/xrpQpyF1hTXBAHJxpQqR2mzf6zlFfKW/Yiw4toc7i81+wz9tEz1UVMMXUxsdXeD0oGMJOylyfLTu0Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510484; c=relaxed/simple;
	bh=rLBQNq80cbBlFmup3PMClX+lcEA1lBPhCm7/9YNkcH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dh0WFDSkbcMBCO3Pm/kbuvBPIp+XSx9g0XRhWzczccx4yZUH+9GQTEa0Wtf0uyYtk7YlPr780NHMXxOnS/QGqtRBM93Bgm9WzHPLI3uTBUkc/inM3AQUZRZ+EIgSRdVh0Wi3B6ev0iehpsobvUjUYQ9rHGTT5kvlGenix8CV7jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPVDFSoI; arc=pass smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-46015dc517aso2810703f8f.2
        for <cgroups@vger.kernel.org>; Wed, 03 Jun 2026 11:14:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780510481; cv=none;
        d=google.com; s=arc-20240605;
        b=WaAShDTr3bTvG6sMsMnwr3QHyLxDaK+ZhBZpRGnw5pkppLJwP5wVE4Te/OFGe6nu/2
         wtfKbo1KbOFyxbtoDYO1Zp3kR0FfJzXy/Q0spdWTHZA+UkggJq1+BVjlqoi9hzub5mYx
         kT5s5Y5wIncoflEWWHjB3RAgdmTWop7AJEnBz7xZDEn5JKKGYr0RsolMjMX9B+ysMGrK
         C8pJ9Tnf+y/Yr/48jkH5wjyOIg52dpL5qrgDifxDqWLqE4ES+GTSVkPGahI3Gm1f1fQH
         +wi2EiFSZaP4o52fbbIKz+ctgg9/kGvG5wnYzNcC92Grunrq1cWh7ZO9+FhReeWykeUG
         Ul1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CWVsqrCr+/hgZzs1LZgrRbIPF4JwXDGlPOi2Fa4T98E=;
        fh=vDDgEcKNyfB1WwI8DM8TSbvoM8pqMThja1QD0B0cVxM=;
        b=hgGwyFVZo9/tuqPw6hYz5bjJoM6nDB4p14A2slZvDYOLe+0JBknebEdsEVREaT1HAN
         2DSACDPaENSxulpMvbm8Xj6tf3RkBubBTLBupKZW/mGklcub6Dk5yVSexhauy0H1fgMy
         ou08d3apbVLiS0FrCjzLt6HUX5DnC5oZ0nBjNoBoZ4j0ZjEiTCzvGeLGxROFqomw1Ujv
         d2kzln6/zyD6QwhqVExFj6356LpeeClt/JRA+wPJ0GPlUZqvTQ/f/tDzdxLdq4Mimhdp
         WsnZ/WPaOr6BYsmWOKC4tPCxv7SJARkYJGzB72yFU7cDpeadvZEhzAjOGRSYJJJH3BRQ
         jxzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780510481; x=1781115281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWVsqrCr+/hgZzs1LZgrRbIPF4JwXDGlPOi2Fa4T98E=;
        b=gPVDFSoIzNsbOUpsWtHPE23zrRNnz+IpeVbWK3igfTKFYQgONdxnkLoTWcSR9wCeH7
         fbJQWMQrEsjUcACsoyUSAJGGM2vF7D0Ik4wwGvbNFcrpu6fcV5r/c7g8HDTvtQcnxYr7
         PQ++c8OWLIH+/RXipJGcqEsPPmAaBwlL39jxBRVLvU5j9BFy3ziqogWRSRBfFxqoThXE
         XtwN8ijBEiZhnqV2MUxJzolDJNVh8U47CYaZOEXv4pGPP5uQWCorZoh/pxhZOx7zy4Zu
         5e7EOGvW8N48be7DH6npbDx97zfq+kwovKAg+CI3LaLNVcJWLbIvIFuwx6iOxQuaGUyX
         NnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780510481; x=1781115281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CWVsqrCr+/hgZzs1LZgrRbIPF4JwXDGlPOi2Fa4T98E=;
        b=U707RtpeLbhvOKfjxOgzOgLnAnTN2nn0ZvATLuIc12lcn/10p5IYy6uO42DRBPQfah
         bAKzTJJt0FY2yfRgd9bUUVVfRHxnJwbgxfw2xLIKlkryMnIfa6nGJw2amU2ZwjNtUUBj
         aVU/ZNlvNB3HTHMYJMwPbFvirZRG90eu8Sd1pYjmjAXL21VlW/NkVR4xKB/aptr2CTkN
         xo2bj9DF0H20LWuKhwwAZ0jnl8CQb2VNpO8ZAAjqfTInjo82CGmAf0b6p07ubOAf7MG7
         idnHI/wRROD7T157RmzLkKkHKCF+A88AuhMgWSC/peMC4gUrZQNaOUioLEJjavwmTRBm
         J2hQ==
X-Forwarded-Encrypted: i=1; AFNElJ8aqVzyYcCc8zK04w1/dKNQ8lEoUQ+Aw5FNIDh9qBAwMX1J5ruw2m9elN+XA0fKNPYdUry/fC7q@vger.kernel.org
X-Gm-Message-State: AOJu0Yyop0Y85veT/e2xCLXziJPxF31Q3vvgRwX6j33M0jlHHNPP0P/a
	YXjS/wFRUiwmKVWLftWV9v7BE3dUKLFVO3JZKAIx7njLvJXlibcH4jhlT0qbMcEl9uSXix6Lx8N
	kxi0s6IJKlVjmWI0f/I32+GDTx4rzAzM=
X-Gm-Gg: Acq92OFD6+lWtXzQzDkH9CBAogQlFqggCtZ99QPzHxOWPlmV7sqs9gaYN535cQUCqtH
	JvafbnNONv7IMqyYvrrdbnHYPd1I58ZTxvWhCxTvBaM/RZ8V1qyrpdkeEjaSNyhRF3eWcii3yXv
	NrQxtx7XaMzgfxRpc+zhmmjEkkZEqOVp2LKRzMWgLlQReSCpNcP5T+oTcBfkF04zJgI3F/m93mn
	YvbMMfRM/NR5OZPDgE5llmCwkj0Y8xiBHHB9w2aMTo9AHx44M0qTwQc8g4ZjXAdb8f/2vuCkJfj
	W+9oQLJB9ICBpYxwsXmes3xD11fAcJaWwnkjXVU901jttZelAQ==
X-Received: by 2002:a5d:4989:0:b0:45d:41e0:467b with SMTP id
 ffacd0b85a97d-4602178af87mr5170086f8f.3.1780510481099; Wed, 03 Jun 2026
 11:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526114601.67041-1-jiahao.kernel@gmail.com>
 <20260526114601.67041-3-jiahao.kernel@gmail.com> <CAKEwX=MQe_KFZe2vBXQYh0aa-x+E8AzNwmyjJGJk4tDoS9ML3A@mail.gmail.com>
 <aho_VtLCmIRsNyvO@google.com> <6deeaea7-3cd1-4403-29fc-d2dc55c297f8@gmail.com>
 <aiBqzOtEv5iAC_qC@google.com>
In-Reply-To: <aiBqzOtEv5iAC_qC@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 3 Jun 2026 11:14:29 -0700
X-Gm-Features: AVHnY4KZKWD3d0SaeD3tNM3fVPW6StZjCUd8WFWR-F3KM2I_lnoM-TIgG8bLJbk
Message-ID: <CAKEwX=OhxUxRCEfvZMnWzXy=Fa4jgzL3DuP-RmaVzdK65m4bew@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/zswap: Implement proactive writeback
To: Yosry Ahmed <yosry@kernel.org>
Cc: Hao Jia <jiahao.kernel@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	akpm@linux-foundation.org, tj@kernel.org, shakeel.butt@linux.dev, 
	mhocko@kernel.org, mkoutny@suse.com, chengming.zhou@linux.dev, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:jiahao.kernel@gmail.com,m:hannes@cmpxchg.org,m:akpm@linux-foundation.org,m:tj@kernel.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:mkoutny@suse.com,m:chengming.zhou@linux.dev,m:muchun.song@linux.dev,m:roman.gushchin@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jiahao1@lixiang.com,m:jiahaokernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16618-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,cmpxchg.org,linux-foundation.org,kernel.org,linux.dev,suse.com,vger.kernel.org,kvack.org,lixiang.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,lixiang.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED02963A74E

On Wed, Jun 3, 2026 at 10:58=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Wed, Jun 03, 2026 at 07:22:36PM +0800, Hao Jia wrote:
> >
> >
> > On 2026/5/30 09:40, Yosry Ahmed wrote:
> > > On Fri, May 29, 2026 at 12:58:09PM -0700, Nhat Pham wrote:
> > > > On Tue, May 26, 2026 at 4:46=E2=80=AFAM Hao Jia <jiahao.kernel@gmai=
l.com> wrote:
> > > > >
> > > > > From: Hao Jia <jiahao1@lixiang.com>
> > > > >
> > > > > Zswap currently writes back pages to backing swap reactively, tri=
ggered
> > > > > either by the shrinker or when the pool reaches its size limit. T=
here is
> > > > > no mechanism to control the amount of writeback for a specific me=
mory
> > > > > cgroup. However, users may want to proactively write back zswap p=
ages,
> > > > > e.g., to free up memory for other applications or to prepare for
> > > > > memory-intensive workloads.
> > > > >
> > > > > Introduce a "zswap_writeback_only" key to the memory.reclaim cgro=
up
> > > > > interface. When specified, this key bypasses standard memory recl=
aim
> > > > > and exclusively performs proactive zswap writeback up to the requ=
ested
> > > > > budget. If omitted, the default reclaim behavior remains unchange=
d.
> > > > >
> > > > > Example usage:
> > > > >    # Write back 100MB of pages from zswap to the backing swap
> > > > >    echo "100M zswap_writeback_only" > memory.reclaim
> > > >
> > > > Hmmm, so this 100MB is the pre-compression size? i.e if this 100 MB
> > > > compresses to 25 MB, then you're only freeing 25 MB?
> > > >
> > > > I'm ok-ish with this, but can you document it?
> > >
> > > That's a good point. I think pre-compressed size doesn't make sense t=
o
> > > be honest. We should care about how much memory we are actually tryin=
g
> > > to save by doing writeback here.
> > >
> > > The pre-compressed size is only useful in determining the blast radiu=
s,
> > > how many actual pages are going to have slower page faults now. But
> > > then, I don't think there's a reasonable way for userspace to decide
> > > that.
> > >
> > > I understand passing in the compressed size is tricky because we need=
 to
> > > keep track of the size of the compressed pages we end up writing back=
,
> > > but it should be doable.
> >
> > Agreed. Using pre-compressed size is probably easier to implement. IIRC=
,
> > interfaces like ZRAM writeback_limit are also calculated using the
> > pre-compressed size.
> >
> > I'll clarify this in the documentation in the next version.
> >
> > >
> > > If we really want pre-compressed size here, then yes we need to make =
it
> > > very clear, and I vote that we use a separate interface in this case
> > > because memory.reclaim having different meanings for the amount of
> > > memory written to it is extremely counter-intuitive.
> > >
> > Agree. This would indeed break the semantics of memory.reclaim. I will =
use a
> > separate interface for proactive writeback in the next version.
>
> But doesn't it make more sense to specify the compressed size, which is
> ultimately the amount of memory you actually want to reclaim.
>

I personally prefer compressed size to pre-compressed size. That's
kinda what user cares about, no?

One thing we can do is let users prescribe a compressed size, but
internally, we can multiply that by the average compression ratio.
That gives us a guesstimate of how many pages we need to reclaim, and
you can follow the rest of your implementation as is (perhaps with
short-circuit when we reach the goal with fewer pages reclaimed).

