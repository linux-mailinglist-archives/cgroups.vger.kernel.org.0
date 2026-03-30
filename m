Return-Path: <cgroups+bounces-15116-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHOdBiHJymmL/wUAu9opvQ
	(envelope-from <cgroups+bounces-15116-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 21:04:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B373601C0
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 21:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5278F3024283
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 19:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2408839478F;
	Mon, 30 Mar 2026 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOC1y4Yd"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61EB38F240
	for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774897369; cv=none; b=i1deincfklxrtjhf3+RRCOYOMwzRvLO5S4Bo4AubbcRX9WoebNRErIvh2WF8WyK4NGDubcJwtSlpDXcLnsHsnWrNeHjViYN6OXRqvbJmjz1HZdmXTdADD3aAmX4hqBlBxOnh9o6F4rFMUB1gucLJ/6V3eTmx2asL+68Th/UD+J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774897369; c=relaxed/simple;
	bh=V8UjiYxzfl/lZG1iwhIdVcgUjo7J2faQ/Wnx1HhOfRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxOkcglIaeoPXj+xh96C3JTHnGQ+QdaL3kebFl3+6YhtE01uC3924FrWUpj++xFcWzxqgWxNtL5YdggzO0neju62395HQps2eq29zIJYLEdjc5n5xFMadFhRS1wFgZUeZGxZPRd+qp36VktKft081qrJXo2gcCxLD1zqMXljkWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOC1y4Yd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDFFC2BCB5
	for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 19:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774897369;
	bh=V8UjiYxzfl/lZG1iwhIdVcgUjo7J2faQ/Wnx1HhOfRI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SOC1y4YdF+TE8yz5hNlXQ4JYtHhx8XCf13Ewvl3BZpJHD4HFntapHnOun+DQ1YiU6
	 sRBl0hbkAjT6GAtlyFdkJJFbBPUMs0ZNO4G94SE7JQRcmzFdh7Nx3E3bHdTfE5NZRf
	 eKDVMk038Ga0vDeZjdqbhQ2aVJ06JSxxuXgrJD98DVaGxArBW9tx40bADmb9Xqzl63
	 HgX1XbA1e5oa9k5lcIEaEWS8uiE68t1s3i5BM+90h9MfNUy91SPs+yCUMU0WqJvGaw
	 L26RWxif6II6ufNLGtCKuoT0XuQ6IXOYK9YUZwhjueZi8UgjGqwJHRfZuSRqOud4kO
	 vRpBHAklN3S3Q==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66bb4d4fcb4so3407362a12.2
        for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 12:02:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXS2h/9w0JIh8LOeGYHLeXmYj1dRVTv3DpOZprjixwxsbY2gulMkjMdFSlaNG0yl1B5aV6pHS3m@vger.kernel.org
X-Gm-Message-State: AOJu0YzkYoBiTvqtClBqi7amAhQaiZF7//gMcnhFrvs8/F1t8FG5tvxq
	n24hHAuuvy4+sQWP4xpZkthIAraKcKxWNbQyIzjjvd9bj3rJxCBRZMc6lVIxdXDqSxP/W6HfMsA
	jqJktyXFuVdrFVAcRrgkkyHqU+zuhWnk=
X-Received: by 2002:a17:907:cb13:b0:b96:e3db:9e04 with SMTP id
 a640c23a62f3a-b9b5094edf8mr570685066b.53.1774897368210; Mon, 30 Mar 2026
 12:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9r8zOKaPocJYMKL=A=6=qpWgwCa=fMC8EZsSW+632M1q1sZg@mail.gmail.com>
 <20260330185947.2427740-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20260330185947.2427740-1-joshua.hahnjy@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 30 Mar 2026 12:02:35 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM1My0cdMV4NomHL-zyconjjq6dP5iSqOyWm10Gnfe7fw@mail.gmail.com>
X-Gm-Features: AQROBzD5Q4JVONjgLXuHQnh-7_hxGvOUjkM2GvDUWYmix-4crTfbUhCwaZZfCG4
Message-ID: <CAO9r8zM1My0cdMV4NomHL-zyconjjq6dP5iSqOyWm10Gnfe7fw@mail.gmail.com>
Subject: Re: [PATCH] mm/percpu, memcontrol: Per-memcg-lruvec percpu accounting
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15116-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89B373601C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > You should probably also speak to extra memory overhead to move all
> > these stats from per-memcg to per-lruvec.
>
> Hello Yosry,
>
> Thank you for your feedback!
>
> Here are the things that I cna see from my end:
> - NR_PERCPU_B adds a byte per-node, per-cpu. I think this is manageable.
> - lruvec_stats_percpu grows by 1 long in 2 arrays (state, state_prev) since
>   NR_MEMCG_NODE_STAT_ITEMS grows by 1 from ~30. This is +16 bytes per
>   cgroup x node x CPU. Even still, I'm not sure this is too concerning,
>   on a host with 300 CPUs across 2 nodes with 100 cgroups (theoretical)
>   we would see a 16 * 300 * 2 * 100 = 937 kB change, less than a mB (and
>   I think this would be considered a big machine).
>
> What do you think? Do these numbers look acceptable?

Oh I wasn't trying to say whether this is acceptable or not, just that
this is a relevant context that should be included to help people see
the tradeoff clearly and make a decision.

>
> Thanks again for your insights, I hope you have a great day : -)
> Joshua
>

