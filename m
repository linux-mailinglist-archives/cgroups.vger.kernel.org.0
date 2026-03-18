Return-Path: <cgroups+bounces-14879-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAfMCOshu2lofQIAu9opvQ
	(envelope-from <cgroups+bounces-14879-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:06:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC912C3401
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5E51302961C
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F29A359A7F;
	Wed, 18 Mar 2026 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/o71APT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522092DF12E
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871590; cv=none; b=uqEfBFa5wRXkBsbjyurVoxEZFFERh0GKaR2f8/75S9WtHwsD8MKUJ91jlTvEYobLLDaiLjfr9XxkWxTxgxrufSphsoPTF4/FLy8VzPH9OiQv9tQZEotrujGGp+COrnAW/LuGof3ONv1l9kkQRszqUu0dHxwhWIw2pyZFUL4DVEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871590; c=relaxed/simple;
	bh=cFK4lKP7mEQHuFtvHtTgGVQETDhDWMoRtUuT1efy7+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9yHOw2rMEI3Ll9AaF5iOOexe0ENXzdy8tjHTxMmgH8JwipNYUIRLFKENRfWZ0zrO6fQW0dQhUjnJun1feAe7ryZ6agX084PoFfbZE4+5SmqJUzq4LOHEx+3b9ADCqC39CH5oXiKLPkHQ+xePqn5SlYsTwUThD56DZsSR6Y1Z6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/o71APT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F54C2BCB8
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 22:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773871590;
	bh=cFK4lKP7mEQHuFtvHtTgGVQETDhDWMoRtUuT1efy7+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n/o71APT7EW8zvjdIQJV66jpN6mRNHJDmDknvEkC1gSLtG/WQn314wJa00u2p0ugl
	 ny1JPr+kJntrO8uLHRHrPuzsuTwUyLGIIearzXN7vx/akZJj+FFTMO/bDgQqAi5WkY
	 AwM4WeReqp1ybaU6R+roPRQNpxM+A8VQrELCLsldCjNwf26tIlPOFxXybam2Ca48ur
	 sfAXS2lv2psr56IFw1BXPU9iJSV0cWfq0gwFVzsePMfVf9SyUuNu8nK1/2eINItoGM
	 Yz0MkNdPBQAwndyBmsdlGHAwiofE8LTrZHZ2prvHVxZLUGn943PneIB/yxO/K497by
	 UWCtzWtUh31HQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so43941866b.2
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 15:06:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1YAdQZpxN0/h8UrZA7x19Vs+KApeRTIFex3O1AfOgZWfeQA/apeEF82xsjCjZ7UFsm3/qMWh1@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5muBSek899Tskm0G8aRhzQNZAFjqDy3MJKyg1+h6fXpLQFAX
	77FbGyum7eYbRauu1LRSCTlojq4gU2K3KSEEZu+1KsQ9D/gfbpPZFSl4Mz+8O9NhEDVEOhoQy9f
	VO3yL12gDnQcu8ga0r/UNRn+7/qx47Rg=
X-Received: by 2002:a17:907:8dcd:b0:b83:95ca:589b with SMTP id
 a640c23a62f3a-b97f48bb814mr321477366b.10.1773871588721; Wed, 18 Mar 2026
 15:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <absRz4U_IMk0ofxl@google.com> <20260318215629.2849052-1-bingjiao@google.com>
In-Reply-To: <20260318215629.2849052-1-bingjiao@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 18 Mar 2026 15:06:17 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPL280HjM=LxRgKN7ChN-_aQk8Vaz_07NDY=XLCH+V-Lg@mail.gmail.com>
X-Gm-Features: AaiRm52IjfioOvk3BGqHIFAwmrD--TIsnh06TQDXNhYfJ9e9PpW9-OOH3NLiEKI
Message-ID: <CAO9r8zPL280HjM=LxRgKN7ChN-_aQk8Vaz_07NDY=XLCH+V-Lg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memcontrol: fix reclaim_options leak in try_charge_memcg()
To: Bing Jiao <bingjiao@google.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, baohua@kernel.org, 
	bhe@redhat.com, cgroups@vger.kernel.org, chrisl@kernel.org, david@kernel.org, 
	hannes@cmpxchg.org, joshua.hahnjy@gmail.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
	mhocko@kernel.org, muchun.song@linux.dev, nphamcs@gmail.com, 
	rientjes@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, weixugc@google.com, youngjun.park@lge.com, 
	yuanchu@google.com, zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14879-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,kernel.org,redhat.com,vger.kernel.org,cmpxchg.org,gmail.com,tencent.com,kvack.org,linux.dev,huaweicloud.com,lge.com,bytedance.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.883];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8CC912C3401
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 2:56=E2=80=AFPM Bing Jiao <bingjiao@google.com> wro=
te:
>
> In try_charge_memcg(), the 'reclaim_options' variable is initialized
> once at the start of the function. However, the function contains a
> retry loop. If reclaim_options were modified during an iteration
> (e.g., by encountering a memsw limit), the modified state would
> persist into subsequent retries.
>
> This leads to incorrect reclaim behavior. Specifically,
> MEMCG_RECLAIM_MAY_SWAP is cleared when the combined memcg->memsw limit
> is reached. After reclaimation attemps, a subsequent retry may
> successfully charge memcg->memsw but fail on the memcg->memory charge.
> In this case, swapping should be permitted, but the carried-over state
> prevents it.
>
> Fix by moving the initialization of 'reclaim_options' inside the
> retry loop, ensuring a clean state for every reclaim attempt.
>
> Fixes: 73b73bac90d9 ("mm: vmpressure: don't count proactive reclaim in vm=
pressure")

The Fixes tag is still wrong, see my previous reply.

