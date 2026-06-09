Return-Path: <cgroups+bounces-16790-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6I62HEleKGpKCwMAu9opvQ
	(envelope-from <cgroups+bounces-16790-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 20:41:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF13663611
	for <lists+cgroups@lfdr.de>; Tue, 09 Jun 2026 20:41:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PoEvoAEP;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16790-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16790-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F01C302F71D
	for <lists+cgroups@lfdr.de>; Tue,  9 Jun 2026 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F894968FB;
	Tue,  9 Jun 2026 18:40:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9BE2F28FC
	for <cgroups@vger.kernel.org>; Tue,  9 Jun 2026 18:40:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030427; cv=none; b=lrAmf9Pqignc2WLOm76Ejz3OAswlz2pLzj+CfcBYnZ4S7xoindf1FlhtTfUtAuUquUxBBDRyqMpFrRE3jA07+xPJEu4Mst7MwWG7YSOJ4U64SZlJsSO70v7Vv90QKsADZ1SQ+KhrWWjSvRDp/XLClmc8Q/Ae/sFdXxLE3514WqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030427; c=relaxed/simple;
	bh=65CJZdok3oEZsd2q+cvJ0TIoA8llHzQp0VLaqDaVRho=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=u4Q2deSpaeu98AnTmWB8KOC9wqBDwmnwIBaUfG4u/xy3HZ6RqxyhwrubeF++Ej0xkpizWlMANgkhI7EDKEUax3LWCoEU/UPUlZGMGWP4fBnROGTfCa5pqsyd9lwxlVf7w1sGL1PFJbHwaXqY7qKJaw7sD+U+W6FmySgcy9Bh+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoEvoAEP; arc=none smtp.client-ip=209.85.161.42
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69e32df92c1so2946805eaf.0
        for <cgroups@vger.kernel.org>; Tue, 09 Jun 2026 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781030425; x=1781635225; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65CJZdok3oEZsd2q+cvJ0TIoA8llHzQp0VLaqDaVRho=;
        b=PoEvoAEPElItO1imZZz7M/TzqPHUlPl6p4dBCjXtv4wFKimDtA+y+FoXSRKL+4MYYW
         Gwo10lpB28FuSNDXlOJH45/ayQhhkDY0QdDMiDSd0guo5jsrNskXdpKfyqAtEO5jpQr2
         9ZML3UZSWp1zIzWNAZVoIZLIUWG2pchcc4oC7LmidHu9oQnacshc/DrhPdDuPK9zr3G4
         qplNIQAIc6ONdBW2uffidFZbNplwiOcn6m8iK2n/3K8RCURcVB9w7wx7yfBHUbP3PfPv
         uSyJIg4+S72GhNKHb7NKdzP0f6vxeMrX2u+3Kyb8uTEArPB5TekObFMuUrvRI4jg1VbS
         zvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781030425; x=1781635225;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=65CJZdok3oEZsd2q+cvJ0TIoA8llHzQp0VLaqDaVRho=;
        b=PBh7PVGtdstsEkCtKZZMru81YJqIX7o2u+Kj3aAzt5u8zNSd2u4vdsA9gO70/RlcAK
         weqkkClkk3ActwB2xa9LB0PYWMRiKUQUnNW1coabP8DR6CxaYbzNTtIj6M1dl9KO7iDJ
         qhzwhnZ6jCYguZn4sZUaS00mVlPaS3qn9kaJ9H4igfrJJNL5WXDJzXWsCVkkF7s7Vz9H
         C5l48q1tKPJieeYWwSJN7CEX4G/0lPWEWR0JEZOBch3aHqPY+MNk4mV8ClOyIO/60sYw
         n+s6lhQtOz+qHPmuUbGiHYANN986yHEuBOYxPw+SZ+PbM72Vxhsgn9sS+Uy6JhXWx24d
         i6Cw==
X-Forwarded-Encrypted: i=1; AFNElJ/JnjNGNawFCCASTxtx8xwzGlUCWcBcditL18NZcOtN3n2JsCljY3nmFj/GAvW3Zt9g5p0cOwY1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy8OXpjYWQ9OEgc4TVWEWd7s5ktCKoLQlvnWVyRjIcAcY1wBAH
	bRQmzC27zJ4Y7OJz6HbKdwr6AEoLgpWrkok4x53stuedzUxY6PfT1KAV
X-Gm-Gg: Acq92OE6phUFQF/NdnQMMqd2x4oCVzyw16oN/u9M0O/yt5EqJBCG1UI3rCdLcGUKouT
	OohfLAunIff/NyPk3Vz8Xe5afNAol2iYJUvHQFhX7zz/KZ0BgfLJYx1uSyPKeUgHBw/coeCt4Zp
	VaPDkCYgDt2qAUM14xsOF9eg1H1veZdN8UQX58TlOTbJEBjyCorcaI63609KNCfq1xRtUX66Fxe
	ojMlgltQLoPxCYU3OabCM8fVgJ8+IevyQ7iBkHhyc9Er+XeuDiVtfSXdlPwDFJ0JPNFzYzxki94
	GuAxt+3WEEhSp+hH1gjv/BPEyjllwCUSK1i+Wb8U34I9A6A1VYnzxP9oHCO6OmFhNNVwNtAoSEi
	mMJMatqcXDSj+XtCtkBzvXdBylOJ3UOQCmc9WF6R7wEeH7CJOxXVDPxswUQio7Qcy7W0afye3BU
	8YZ/gKWVHB9RBY872qYdpxg9IN+USHjKZSLh8Tvulbpkcq53GH0fFONjiS06bAn20XvS56HsAId
	i7Sl4VHcyKWco2l83oQDTlTbxpn/SqoPLGa4Q==
X-Received: by 2002:a05:6820:c2c7:20b0:69d:f044:5dc3 with SMTP id 006d021491bc7-69e68b847d6mr8241185eaf.25.1781030425313;
        Tue, 09 Jun 2026 11:40:25 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e46405105sm11146756eaf.10.2026.06.09.11.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 11:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 11:40:23 -0700
Message-Id: <DJ4QLD7TWSOU.3LEDXKMML5DMK@gmail.com>
Cc: "Hao Li" <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David
 Rientjes" <rientjes@google.com>, "Roman Gushchin"
 <roman.gushchin@linux.dev>, "Suren Baghdasaryan" <surenb@google.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Michal Hocko" <mhocko@kernel.org>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "Alexander Potapenko" <glider@google.com>, "Marco
 Elver" <elver@google.com>, "Dmitry Vyukov" <dvyukov@google.com>,
 <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH RFC 00/15] mm/slab: introduce alloc_flags and
 slab_alloc_context
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "Harry Yoo"
 <harry@kernel.org>
X-Mailer: aerc
References: <20260609-slab_alloc_flags-v1-0-2bf4a4b9b526@kernel.org>
In-Reply-To: <20260609-slab_alloc_flags-v1-0-2bf4a4b9b526@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:vbabka@kernel.org,m:harry@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16790-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFF13663611

On Tue Jun 9, 2026 at 2:17 AM PDT, Vlastimil Babka (SUSE) wrote:
> This series is based on slab/for-next. If all goes well, it would
> hopefully go to slab/for-next soon after the 7.2 merge window, so any
> other work can be based on it to avoid conflicts, as it touches a lot
> parts of slab.
>
> Git: https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log=
/?h=3Db4/slab_alloc_flags

Overall looks great to me.
I would ship all patches except the last one for this merge window,
since I don't see anything controversial or dangerous in there.
Especially since it touches slab so much. My slab-arena changes
would need to adopt it and I don't want to delay the whole thing by two mer=
ge windows.
Harry's changes would need to rebased as well.
So the sooner the trees converge the better.


