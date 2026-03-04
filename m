Return-Path: <cgroups+bounces-14609-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMmKFSRmqGl3uQAAu9opvQ
	(envelope-from <cgroups+bounces-14609-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 18:04:36 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C80EC204CEA
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 18:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1825830B85A1
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 16:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D938A372692;
	Wed,  4 Mar 2026 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dScc6NZ2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116911DEFE9
	for <cgroups@vger.kernel.org>; Wed,  4 Mar 2026 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772642763; cv=none; b=BOudY6tc46dKf56WrwJ17PgFAuRwVY+MIyGloenoqGDG2WgMacTHMPrrfLVlmDtPRx+v6bGqsXOtdEiCZoOVInSyXz3niYp/C/qR5ROIS4QKH9HWqL/EpktXQSY+097YKlNdeXzXMo9pRRqOxMHHzOxh9W39SRctBfwvGuH9SBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772642763; c=relaxed/simple;
	bh=AhTOnMFysHR+r+BB39zBGqkEpVC36GukS5qbEHX2CcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R45aK8IvK9iGO4V2jc83/f8gk4GSMnIlBR/YrKM0V2xh0eWX7Ox8YiTHXHs8OIkGD3VfOgsAvwfFSMARfeVhJkJQPgEn3iV1V1JH9VRXDXwKfdpC7r7U626T4o2HAD3yHWQf/aY1FNG1b6D+WHIEoFgR5HF2BdJoZlx1vI5kkhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dScc6NZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965C7C2BCB5
	for <cgroups@vger.kernel.org>; Wed,  4 Mar 2026 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772642762;
	bh=AhTOnMFysHR+r+BB39zBGqkEpVC36GukS5qbEHX2CcE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dScc6NZ23rpQgRG0mnUtaHbs+phKE4alwTdDATYmyx+k/qMCkMvxIU/TMHgU2A1zX
	 NkA9mPrBPMiwMCzgcE5lcbGagTvz5564+PIn/fkl+qtUk3KL1mboy/EUS2pBSH+oCe
	 OUfV0W73ir4/QMlknh+JKUQR6qLEj/qpPYlH2oEfdC2WLXUHyN9qNJ20cyIsBx+u1/
	 verpiBBOZhORPo+bsYW/EVV1hvRcuP1Futk0QIF8X2cMqC0nAYsxpI8Y/dxnmLvJzL
	 PCdb8mvoc6wpYqgf4dstFwPu0Ar0ApmHF5GC6vpoOFda6iXp7dx6pSNABFEm6j1Akm
	 yY/qaQFl3ZcDQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b934fdced05so943663066b.3
        for <cgroups@vger.kernel.org>; Wed, 04 Mar 2026 08:46:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDjrGRwdTJ57t38YQDS4/FS3w0XiWwkqfDxmues7iATW/3NzmhWwGXeUWmmAw9AyRqdmyQnUz8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Au/h80PkRC8F2nuzIj9Npp2mV3VLzSY4isk+ikpRqRP78sAT
	hZQp4u5LkWnhkCeO2O9y2AgC1r+Dczl/7Vw8Kg/wFiG0RDEDi8ZetFbkr7U1aUIEGZTPqE8f+sJ
	3u/RK+22UdQgPeSaC5ICWxySOYO1RA1U=
X-Received: by 2002:a17:907:6e87:b0:b87:1d30:7e6 with SMTP id
 a640c23a62f3a-b93f1171ad5mr143317366b.11.1772642761216; Wed, 04 Mar 2026
 08:46:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9r8zOFS7zU-eGkErcjud=DW0t00_WqNqCzq_QDf061dOsYSQ@mail.gmail.com>
 <20260304151120.3512645-1-joshua.hahnjy@gmail.com> <CAO9r8zOJ5bkJzptM7+8V2G00dHuycAEAF4CDcaR1YMk0kWyktA@mail.gmail.com>
 <CAKEwX=ObFWm6cKbi4hL8JLDKui3MsRu-JpEFohBdkqHFY9tVfA@mail.gmail.com>
In-Reply-To: <CAKEwX=ObFWm6cKbi4hL8JLDKui3MsRu-JpEFohBdkqHFY9tVfA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 4 Mar 2026 08:45:47 -0800
X-Gmail-Original-Message-ID: <CAO9r8zMbU8ikA4jAUyOvvorsm3L4UD2X-KVcGyQaKwTZ0nV1Qw@mail.gmail.com>
X-Gm-Features: AaiRm51RdP-6QF1MGy0rT8q9i5bzC5Umqr3wPeGTQwIJROXe85VGcaFk_DtQxSE
Message-ID: <CAO9r8zMbU8ikA4jAUyOvvorsm3L4UD2X-KVcGyQaKwTZ0nV1Qw@mail.gmail.com>
Subject: Re: [PATCH 6/8] mm/zsmalloc, zswap: Handle objcg charging and
 lifetime in zsmalloc
To: Nhat Pham <nphamcs@gmail.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Nhat Pham <hoangnhat.pham@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C80EC204CEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14609-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,chromium.org,cmpxchg.org,linux.dev,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

> > AFAICT the only zswap-specific part is the actual stat indexes, what
> > if these are parameterized at the zsmalloc pool level? AFAICT zswap
> > and zram will never share a pool.
>
> TBH, if we were to start from scratch, these should be zsmalloc
> counters not zswap counters. Only zsmalloc knows about the memory
> placement and real memory consumption (i.e taking into account
> intra-slot wasted space) - this information is abstracted away from
> all of the callers.

I agree, but we cannot change the zswap stats now that we added them.
Keep in mind that when they were added zsmalloc was not the only
backend.

> And if/when zram supports cgroup tracking, memory
> used by zswap and memory used by zram is indistinguishable, no?

It is distinguishable as long as they use different zsmalloc pools, I
don't see why we'd need to share a pool.

> Anyway, Joshua, do you think this is doable? Seems promising to me,
> but idk if it will be clean to implement or not.

Not sure what you mean here? Changing the stats to be zsmalloc-based?
IIUC we can't do this without breaking userspace.

