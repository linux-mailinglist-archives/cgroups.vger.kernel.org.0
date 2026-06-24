Return-Path: <cgroups+bounces-17249-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ilPaGhkGPGoaiwgAu9opvQ
	(envelope-from <cgroups+bounces-17249-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 18:30:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EF26BFF9D
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 18:30:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="crhrza/W";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17249-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17249-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74383300AC81
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 16:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B749B30C156;
	Wed, 24 Jun 2026 16:30:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD2233923
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 16:30:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318612; cv=none; b=j3xbP29HCWk2vfl/CvZe2Vj0Ad3p2Os9tCkQ0IWw51srbxFVeZGYaDQzZVm9vOkMtbrlI1+FXTMwMZO5RUWnXG7HW2tsv2cjKVMdBQiiFlDgf7HFkrRLQc/GIxJp+Fn/05Lg4xBJUtn8hgIMvfAOx6iSHwKlysDExWF5WLrFiDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318612; c=relaxed/simple;
	bh=f4Q5tTzUw3dIHq5IKDitX92kWGt0Qu9vdWkJH7Q35Jk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=J/k7X69W1Ie+KPPLF2j+adZOOsh3YM+F5OSLWTbDQRgr4W7I36q+YJVhh8CdWrBz0qVGE0Zq4g76aD0jV9iIfAUjGpaCNbBFVbsEu6IJlgI/DgHm6muamUaJ17H2P8uWnTz5iqz2MQPUgZQvrW4HhNwMu//yLEvzfvaZfPgpv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crhrza/W; arc=none smtp.client-ip=209.85.160.44
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43d3a0dabb0so907067fac.1
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782318610; x=1782923410; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4Q5tTzUw3dIHq5IKDitX92kWGt0Qu9vdWkJH7Q35Jk=;
        b=crhrza/WLbngnIdRw1HQJ79XUYHZFtLWbF0EM6sZ/LoOZmBi6ofUu9+JNlpZ/zmgc+
         7xXmTqgsKxkzc96de9zXLHYR+aiFYHVxbjsryE/PjvrUZXHVYsCu/wIPXoqu/PiSKYIt
         SidqLIkqaVLKz9rvu6VPB87BMQ+/TYGjg/kH6M/QJsY+WkJIJDNq61KtC795r4xgbIAr
         1otyGQ14zLVmWV3GtNwvSwsNde8J8c6fULMHYAR1QGFd6z47Rkl38GeUPDMcUWceg4Y9
         abg+mck+Dks+FhHACpBA9b4QDXyXOj3gKLOwGw7xdRvEDKRd9Zm/Oa9cjKTp3o+CLMxe
         N/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782318610; x=1782923410;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4Q5tTzUw3dIHq5IKDitX92kWGt0Qu9vdWkJH7Q35Jk=;
        b=Mqsea5OUku42QxgcKwZiP6PC7VLqTBddKLvia8yxELGoB8PKCyHO5kjy3YA4lQRXOJ
         W8lwDdbe5QFif459YjflXSmx8zDNHpo3UlmUmN61iHxXWxg9t6H2KWpjV2bjLNqBSHlP
         /QIcHLdoCmiqqpXvXE4hYAEiiOt976f7AD8CO4OjdY8Q7uifK5CW6WJip2qCs+naDmn5
         AjvoYBltxC1PMhGiGY+2AIW14MGcsqLuiOjECI1BwuW2RIZGQTc83lEpbDMDt9rVWHZP
         hU2tKqznkJp+Z9w0zvWFVdgm7CDOkHzszyaR6Ox0h2JTx8bT35zXKaXTgS/kAUA+AfD9
         nheA==
X-Gm-Message-State: AOJu0YxvcA9jCCCo24IuLcxbur6omg+zjCvzoOg0Ti3Q8v488azIJgfk
	FOpdZcNj9mP44ljth9m044+tZx311+z3OUgm8cqTJEb3V8a6/dRqcrpZ
X-Gm-Gg: AfdE7cm5JzSKwEAfoHP+fwSTGW8DQM4Oh36sM9Ub4O/zbh6STGg1NDewI35+i9RWYWW
	eKIx5WcuYk6n30ypgM69In+1o3fq9cGkW4tG7eJ9Gh1/uTYe4bbC+3obsk942jemtIJa7cS9Ztw
	C4oilB60yYvjuT0Btjlb0yaQnC2hPmOhkwFjbO0gDhbhlzqZN3EI0ZOvPcmVS2s6A/VL70bf3dq
	LxfyXD3sDNJhHRJnhBezqmMg5V72F+/2eOQM4W/3V5pKlEceFMRWLWK3lPX53ya3kMDIzEE0lol
	H42M9NctK5XlBGL7D/Y0a9hwJqG+6FH9y/qqcbcewhRhurZPCtMiQZmuNwwXIiLM61WUT4Xuo+V
	0Eu/t4AFK0QXGGvrRUXlJ8pRXLNTTnkfkzhZD2O/OJpVIVknPg5bXoWFYg0QhvdlSqRszpTYIzd
	m5YFVdqSJEcIh78YxE5Otr2LcGYSk3ZA8uFaIVqSL6aoSE2r6cMop8aevaYZHibjq/2ZgjH45FJ
	XmL7TE=
X-Received: by 2002:a05:6820:906:b0:696:1e45:9011 with SMTP id 006d021491bc7-6a1231f9adbmr2366325eaf.28.1782318610157;
        Wed, 24 Jun 2026 09:30:10 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9faf29asm9654118eaf.8.2026.06.24.09.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 09:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 09:30:05 -0700
Message-Id: <DJHF7S039QNX.KNVMFISSMLMU@gmail.com>
Subject: Re: [PATCH RFC 0/4] memcg,slab: kmalloc_nolock() fixes
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Harry Yoo (Oracle)" <harry@kernel.org>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>, "Roman Gushchin"
 <roman.gushchin@linux.dev>, "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Muchun Song" <muchun.song@linux.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Hao
 Li" <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David
 Rientjes" <rientjes@google.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Pedro Falcato" <pfalcato@suse.de>
Cc: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
In-Reply-To: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:ast@kernel.org,m:pfalcato@suse.de,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,cgroups@vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17249-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07EF26BFF9D

On Wed Jun 24, 2026 at 6:11 AM PDT, Harry Yoo (Oracle) wrote:
>
> Bug 1 was reported by lockdep, and bugs 2 [2] and 3 [3] were
> reported by Sashiko.

... and in fixes for sashiko complains sashiko finds more issues.
I don't think it will ever end. I suggest to fix realistic scenarios
instead of one out of billion cases that sashiko think is plausible
but will never be hit in reality. The chance of server crashing
due to cosmic rays are higher than such bugs. Hence do not fix them.

> To BPF folks: do we need to backport kmalloc_nolock() support
> for architectures without __CMPXCHG_DOUBLE to v6.18?

nope.

> There are still few users in v6.18, but I can't tell whether it is
> necessary to backport it to v6.18 (hopefully not as urgent as other
> bugfixes).

imo none of these 'fixes' are necessary. Humans are not hitting them.


