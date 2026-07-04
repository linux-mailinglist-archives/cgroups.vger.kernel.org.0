Return-Path: <cgroups+bounces-17484-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hTOQFWKiSGqhsAAAu9opvQ
	(envelope-from <cgroups+bounces-17484-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 08:04:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7AB706CBE
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 08:04:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XYFOk2kT;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17484-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17484-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9814030A6685
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2026 05:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E34738E8DB;
	Sat,  4 Jul 2026 05:58:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE338B7BB;
	Sat,  4 Jul 2026 05:58:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144705; cv=none; b=bolGQlWJ7zw/u0e+vkiy6TEEOl0EHTL7UpAxg9EmS2GLIeWELTLRz1SCeciTLhZT8qAUNY8FHbqb3OVRaj/LBI1DcdrU0zErZQPRclpNFHumS4+IKfwPidOJadi7FfeX1ZLn2IpZ+pGF+wvI7WnyjdB5xP554SlmNuSNvdHuhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144705; c=relaxed/simple;
	bh=hOn6we4RfMiN12EwAa+NNmEUJkAWQI4gee4tcRfPRxA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fcQn7+HCgwsb7BeugnmL5tgK3u6jlH/KX5bf+0AHUs4zHvoADA9GNWfskASTRv2FZT98pQYhYuP2n3BusCM1RuI1lUTts1cWKcFG5yJuRp/5zKDx3Wb/ztOwpgTunIMnn2JBawnHrdtPXdxn/u0Q98PAMZsSmc6k38GRuNT6/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYFOk2kT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5E41F000E9;
	Sat,  4 Jul 2026 05:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783144703;
	bh=V83zC+ABVvPZfpSItIVfm+fybD7L3iVSBZB+nvmmqYw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XYFOk2kTGPelgRFBCFOy1e5BFq8MR3j2nf5Ucpe7/CKek5scCr344MHbsGfXFuNmW
	 SM7L6Nm0FhGYcdqcF8sq95YTmN0Jhh+1bvL01+d4I8L3OqZb4nzcM0a44QZmuUkEqK
	 GL49THk2qh/CLM2VQDUspnlQBGKR/fve39dyxR7GqFTAptP9L5MO2Hq3rvvtkOWVZb
	 Tn2Lg0iLNmYHqqjLDR/XddQRkS9/G3DRPLcAYbxwcsrcrXuPBWPj2upPA87MZvt0mG
	 oG8Ag4kev34nRzv78qXAbeBSXty8O5zELZDATZ+bH8paUbrgk/ra1kgfGxNbJW11hx
	 muNf0rKM83uCw==
Content-Type: multipart/mixed; boundary="===============8802271696774654361=="
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c48aa4a4b43fe15d313761d70e2113405c73ad058911cd87d573946ae1740b9e@mail.kernel.org>
In-Reply-To: <20260704045617.487664-4-ziyang.meme@gmail.com>
References: <20260704045617.487664-4-ziyang.meme@gmail.com>
Subject: Re: [PATCH 3/3] selftests/bpf: add memcg_stat_churn_percpu BPF-vs-memory.stat benchmark under cross-CPU churn
From: bot+bpf-ci@kernel.org
To: ziyang.meme@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,bpf@vger.kernel.org
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,roman.gushchin@linux.dev,kernel-team@meta.com,linux-mm@kvack.org,cgroups@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ziyang.meme@gmail.com,shakeel.butt@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat,  4 Jul 2026 05:58:23 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TAGGED_FROM(0.00)[bounces-17484-lists,cgroups=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,etsalapatis.com,meta.com,kvack.org,vger.kernel.org,gmail.com,iogearbox.net];
	FORGED_RECIPIENTS(0.00)[m:ziyang.meme@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:roman.gushchin@linux.dev,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shakeel.butt@linux.dev,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:ziyangmeme@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF7AB706CBE

--===============8802271696774654361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_stat_churn_percpu.c b/tools/testing/selftests/bpf/prog_tests/memcg_stat_churn_percpu.c
> new file mode 100644

[ ... ]

> +static void settle_flush(void)
> +{

The settle_flush() comment explains the reset with:

> + * ~15% window asymmetry, enough to invert bpf_matched vs bpf_full on
> + * flush-dominated cases (e.g. "hot": few cgroups churned from many CPUs).

This isn't a bug, but the cases in this file are narrow/wide/widest, and
there is no "hot" case here (or in the sibling tests).  The timed reads also
always run with collect_full = 1, so there is no bpf_matched-vs-bpf_full
comparison in this test.  Does this example still describe this file, or was
it carried over from another test?

[ ... ]

> +#define CHURN_GAP_US	(50 * 1000)

The gap comment just above this says:

> + * pays that flush inside its timed region.  This gives all four reads
> + * (file/bpf x matched/full) approximately the same start state and folds the

This isn't a bug, but the sampling loop does one file_pass() and one
bpf_pass() per sample (bpf_pass always sets collect_full = 1), so there are
two reads per sample rather than the "four reads (file/bpf x matched/full)"
described here.  Should this be reworded for this test?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28695985027
--===============8802271696774654361==--

