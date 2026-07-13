Return-Path: <cgroups+bounces-17730-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aDLEOtgJVWoDjQAAu9opvQ
	(envelope-from <cgroups+bounces-17730-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 17:52:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C7274D48C
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 17:52:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jGYvq+lC;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17730-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17730-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CC03303F874
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 15:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D52E274B5F;
	Mon, 13 Jul 2026 15:50:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA92C0F6D
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 15:50:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957851; cv=none; b=qcWAoiHkMGloFxmUfK+FLBOnXJurQmn0943jgYfTelPMIfMOqlwj/Y4Lsg76Gz3MvWWCu99dEQF6FvGWEs2gjmT2yVe5yxZAuLB2sm7KPKHmNFdSj8Ny16epiUa2PplH+klDj7ewhF9zX6hrRgMIZdwNhuYHdKyCui25Q+67+Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957851; c=relaxed/simple;
	bh=R9UsT6TIGaoWj/F85QeLUfDc+xfvWj4telTWCxXJt2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHbge3ocmqr4veZAHEITnein3GRopm6roHJzNuj+BKdI96u2nIjmR+Xm5FoMdXOHTSUTwewLPXpbpADulQseiKLG6VLhdHUWZzMDArRCPkeG0/znTK/uwTW8zJ8gDyYLM6DTwpqYROvhe0MdgtpQjUZGII3DmNvnsGAkOImTm/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGYvq+lC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CA21F0155A
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 15:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783957850;
	bh=0nEqidDEll0lFKQJRsBXv+q0TtERg9N1HIHV1PMhX58=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jGYvq+lC6AlLm5YUKylCcrjuPR192nylqWrEF79DC0BQGB1d5CMzhkZfqOIn5rE4e
	 DdrSgNZQeQYrzGQYpUaOwiZlBq73sCQapbziXXMo+B8dfiZ3F1t4yfup0C/y/xebTA
	 akueadAxOnLGfJho/RENMon3ZUhXeZq7SLeuuAl6CPWe+ZqDmFUm8aI6sGk9dWIG/z
	 eCkEGVqL+U1RpuZ7KtoGDPXpFEDHBWb5ral03WxMz+IPDo6U1lgHCPbLdJ69nNHtN/
	 ljZdnDGUnxCOBdDDF2ekeNCeDKpQQC4Qbhf2iOgUXppVVlk0HKMXPs+XgLLMhX47Mb
	 FTvUArODxiFqg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15d111ca99so318388166b.0
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 08:50:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RooVTBFq5kkKmbIcPj5DjGEqJGeuhXEhCL3M9Y/Bj28eowElMQIDhkiuLdfUS4TRbdFHOuNfEkC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxue0T9gMDg2D/HRJIR9maPv0pyq1fVk1IGEKSny3OAQWNlnD0
	g4tYd81YAHDFivnq6rCFJXYL9RPxRXILX3HlpSmQyrCj/ERW/5t6hupWXjxV0Id7CKW7crxyHhE
	vMv4UC4CHEkox90hC6tZq2ZqmdBFowLI=
X-Received: by 2002:a17:907:3f05:b0:c15:cfd7:fdcf with SMTP id
 a640c23a62f3a-c161e9d8a53mr349487966b.29.1783957849053; Mon, 13 Jul 2026
 08:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713025644.170839-1-youngjun.park@lge.com>
In-Reply-To: <20260713025644.170839-1-youngjun.park@lge.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 13 Jul 2026 08:50:36 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNJfhirbzvJzDWRaBQOM7XZcf_Jk0Bz=Y4dB4QK4W-MwQ@mail.gmail.com>
X-Gm-Features: AVVi8Cdhp3gmWcPxNKGi9xzKpj1txCkZgTK1iUjawQjsfXysMd41K64C1ZX9ciw
Message-ID: <CAO9r8zNJfhirbzvJzDWRaBQOM7XZcf_Jk0Bz=Y4dB4QK4W-MwQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/6] mm/swap, memcg: Introduce swap tiers for cgroup
 based swap control
To: Youngjun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
	baoquan.he@linux.dev, baohua@kernel.org, joshua.hahnjy@gmail.com, 
	gunho.lee@lge.com, taejoon.song@lge.com, hyungjun.cho@lge.com, 
	baver.bae@lge.com, her0gyugyu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17730-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:youngjun.park@lge.com,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:joshua.hahnjy@gmail.com,m:gunho.lee@lge.com,m:taejoon.song@lge.com,m:hyungjun.cho@lge.com,m:baver.bae@lge.com,m:her0gyugyu@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,lge.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,lge.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70C7274D48C

On Sun, Jul 12, 2026 at 7:57=E2=80=AFPM Youngjun Park <youngjun.park@lge.co=
m> wrote:
>
> This is the v10 series of the swap tier patchset.
>
> v10 folds in the Sashiko review fixes for the selftests added in v9 and
> rebases onto the current mm-new. There are no functional changes to the
> core swap or memcg code since v9; see the changelog for details.
>
> For context, the bulk of the series is unchanged since v8, with great tha=
nks
> to Shakeel Butt and Yosry for the reviews and discussions [1] that shaped=
 it.
> The main change in v8 was the interface change to use memory.swap.tiers.m=
ax
> with '0' (disable) and 'max' (enable) values. This mechanism was suggeste=
d
> by Shakeel and Yosry.
>
> This change allows for future extensions to control swap between tiers an=
d
> aligns better with existing memcg interfaces. It is confined to patch #3'=
s
> user-facing interface; internally, patch #3 still uses the existing mask
> processing method, which is implementation-efficient.
>
> We also discussed tier extensions. Thanks to Yosry, Nhat and Shakeel for =
their
> valuable feedback.
>
> Here is a brief summary of our tentative conclusions. Please correct me
> if anything is misrepresented (details in references):
>
> * Zswap tiering [2]:
>   Zswap can itself be a tier (typically the fastest one). But, until vswa=
p lands,
>   zswap cannot be the only allowed tier,
>   since it still needs a physical device for allocation;
>   that restriction can be lifted once vswap is supported.

Does this series support zswap being a tier? I cannot find any mention
of zswap in the patches.

