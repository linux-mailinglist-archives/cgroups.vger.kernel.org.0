Return-Path: <cgroups+bounces-14866-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM3ID2t5ummTWwIAu9opvQ
	(envelope-from <cgroups+bounces-14866-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 11:07:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB5C2B9A1C
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 11:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9758C3058194
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 10:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AB93BA231;
	Wed, 18 Mar 2026 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZtDKNaZd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B403B7B7A
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828104; cv=none; b=NQ8+RAnziIRlPmCl6uBEIolb9e24/dI7qvmMvYqsVx8TkniUIgu5RI5OOJLGC6C1V+FeH9MQ3trx6kqAeAOjnUekv8pZuDAr7iFrq0XhAE7WGJ0FgFj0gu1wBOV0hzxALr+qT/ECSOKjDQF1m/GliwwOT5D/hNaZwMOv8uQjvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828104; c=relaxed/simple;
	bh=LC5MhTXBmrWgwfDOl+wr0Q6LGnjbn6Gf58JCzqtAsLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccvurvFXNpVz49ZuxDQfRvvyz6Au3a1Eq0SCRChD8TUprsL4Y3yq+HGehpqFBctws0xrLtKznmao/jfzKYfQ9fN6firIh28s6AS25UZFvm9p4uarnwFtt2Oxd1NRG66x9cM3cJxAghwzRIB1pfpW1+x32PnSKB3avbx5cWzGAIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZtDKNaZd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48534237460so71382135e9.3
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773828095; x=1774432895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=30lcLe83ZfeeJjPOw57FdUnRLS2QbPrl5sgOSEvO6uE=;
        b=ZtDKNaZdL0eWJpQhrfmVdfbgZBbMxJhFU9WFC4UOzt5eHzTVqDeRHFpM7iq30CW89U
         N4eY7Bl/V9vX3UTnN0nNmehWn+nFLu/VZdw3J2zCXIP+6MxEUjT5VhMlPa6m/TYhAabl
         tvdV8C0O+r8UdWcQiS9I/mnG84doBA/A5EMO069xg9q71VTsKncmXS8MrOLeORB3e2uw
         cf6xJVmeXa6Jh1s53JMjitJeaFUbtFJFFwH2lNX29m0KCoVyNtjfLIyLWsDaCF4KhMGg
         jNOMFqWTmKUjNShNXy2PRPDUIHT6w3tJQmXNofwh1Kb/htYvBTwTgPpz0mb1Tvg+5egJ
         gQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773828095; x=1774432895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30lcLe83ZfeeJjPOw57FdUnRLS2QbPrl5sgOSEvO6uE=;
        b=qMSlLGLI68NB0Om/IoiN/zgqwYmxKcBHNdFVjb0aS+DdjgtGXqyYuj5eOoDG2HSLIF
         nZkLjTzAfHuJjyEWQihvg8zaP0yU+wHKCD1wL8SlkebnbtU3Ax3bKAw4pLuqIB4RI+gs
         oj6x/RVRYv4GzlAFQWv9zcgciVWcb8k47Owo4uJ8NVqDa9PXtLYsnPsHekzGdj1/rDlS
         QviWRAfFu9zWNJmmIJXJkVtH5tOpiH23IRP8vF9JrPzVFsNieNnel5E7dxXqRCLVjl1+
         ukUGxywGm/lH2GGkWstzn8TOVG6Iy24+PnLrkYrrmNxRvLISVSuoQ3dg/g884Vkv7hHx
         fgNg==
X-Forwarded-Encrypted: i=1; AJvYcCUr+MjgZ73n1sCM/vBOyy6Je63YyThm2GWPgFstEQ7Oxvk384apuiKWjFnnM/sb4fTLemy5bBeC@vger.kernel.org
X-Gm-Message-State: AOJu0YzaBZzagURGCf/3K7gBxvZgygPUEqR4KkOll5/mH+mz+2+67dnY
	jznXfQemYoEsAfAn1ZlnBwuPs+hwoDof6Gn3WJwAHu7Y2sSIQnEmMY+gxdKtjUaW+z8=
X-Gm-Gg: ATEYQzz+itlac87YG1BqicmxCqLkZZ715atX0x4vq+5BFndiQEIThfla57BxbglPpXh
	b3s43mKiLSRUKDhOfDeKgVYkGuCo3n9t9d59HdfX0pqOng5QlFcoMmKYce8IQFFY5vLMSieceMa
	hS+deRALvqJGui/rjYdYnQDxshS2xxgSarUnyiADdjuYjhigkjUkyuUJ4UId7sdRASJzsPyUPfR
	SdMQuuPMW/SP1qxiIgbpLUlSIejdha1CGgwmmi30R2HbUbo9qJPTCPLru4S/6lbrz+ffCWY7Sh2
	c088x5Fp54lDa30W6ILFZRGTCQ9zHb/38deOKvsJhH7Efno7MszVIJSzOP9oHfYb+OeT14fA7kq
	AQqrXTxM5TT+H1UHH2tZnFsPtRhvqS6NFbb7XwBYBaZ0rHbKbFgzTvYyRxsbTqx5/UuUbe/FMub
	tlRRvYAexA0W0qEprSFl7aFrB9LmpIjLhys1we
X-Received: by 2002:a05:600c:4fc4:b0:485:3b00:f92e with SMTP id 5b1f17b1804b1-486f441bc46mr42711335e9.2.1773828095163;
        Wed, 18 Mar 2026 03:01:35 -0700 (PDT)
Received: from localhost (109-81-21-195.rct.o2.cz. [109.81.21.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f5e162d7sm10843415e9.33.2026.03.18.03.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 03:01:34 -0700 (PDT)
Date: Wed, 18 Mar 2026 11:01:30 +0100
From: Michal Hocko <mhocko@suse.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, yc-core@yandex-team.ru
Subject: Re: [PATCH] mm: add memory.compact_unevictable_allowed cgroup
 attribute
Message-ID: <abp3-iJbazCpygIm@tiehlicka>
References: <20260317100058.2316997-1-d-tatianin@yandex-team.ru>
 <20260317121736.f73a828de2a989d1a07efea1@linux-foundation.org>
 <3db237d0-1ee8-44b7-a356-f3015173f7c2@yandex-team.ru>
 <abphjNOYaNslTA90@tiehlicka>
 <7ca9876c-f3fa-441c-9a21-ae0ee5523318@yandex-team.ru>
 <abpue_k_9mjQAP6X@tiehlicka>
 <73322279-c6f8-4319-827b-938c20c96b9b@yandex-team.ru>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73322279-c6f8-4319-827b-938c20c96b9b@yandex-team.ru>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14866-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 5DB5C2B9A1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed 18-03-26 12:25:17, Daniil Tatianin wrote:
> 
> On 3/18/26 12:20 PM, Michal Hocko wrote:
[...]
> > Shouldn't those use mlock?
> 
> Absolutely, mlock is required to mark a folio as unevictable. Note that
> unevictable folios are still
> perfectly eligible for compaction. This new property makes it so a cgroup
> can say whether its
> unevictable pages should be compacted (same as the global
> compact_unevictable_allowed sysctl).

If the mlock is already used then why do we need a per memcg control as
well? Do we have different classes of mlocked pages some with acceptable
compaction while others without?

-- 
Michal Hocko
SUSE Labs

