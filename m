Return-Path: <cgroups+bounces-15106-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OsiJO6loymn48gUAu9opvQ
	(envelope-from <cgroups+bounces-15106-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 14:12:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 719FA35ADB4
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 14:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F56530ADBBD
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 12:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E5E3C872B;
	Mon, 30 Mar 2026 12:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LHY/T1bN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8733BE621
	for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872214; cv=none; b=j2yp7fgGFcigBkNuBmaZMGC65PVmdKcJm54ChcWzGLkgjQiFji1nK7nQAL3Zo1Iz0bJIkr1FkzpIwT7CoZ/tK6eWbvSwH2u1DLcUZldzAEC8buwuI2v4LnvDkxYE+hDCZf2FfItYEdDrlXWWayYvLtX2mLcm8Hyklx2LQWta57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872214; c=relaxed/simple;
	bh=br0uOsoE0+NMulw9aQ0iIRWRS5+7V6Os/D/c1fIeQGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTYtU92TN3BV8+tsc8ELe3KGCPw4ScgBRJ8nvaRUyveRejqzxqj5wQJxHWDdn6pfBpMD0dITDvupxPnWL7zaf69KsJq7+PC1YAd1tNcK7V/4U06HhvIjW7bsgN9iCNTrvDDnDxVtp4ttZqPUAgEbp6kdy877OiFGgkMr97godwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LHY/T1bN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cf7683a28so716129f8f.2
        for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 05:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774872211; x=1775477011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/pCkZp0kOo5osdLzRpybPSjj/VyMtaU3zoXyQksTzs=;
        b=LHY/T1bNfCLjQy0x3+rR+Vg0SfF+1GZndjhkYd2PnClPit9CAyuEs9H5nyzc5vro1C
         Ln/XpSnWQUvaQ5mYlEHw3sdCXERT+54URr0kMblMQxZV24pXvpPkCJ8tSdtanK4HNbhR
         3770uB6Dm29Y1QxGTz1C7MK2EwYkjx5mANK0r+bOIImkz0bx1wadsUeoE+ixlkvLMecp
         Slv6LwHwPjiOSayR/Jk2+gNveIf7VS/73ZH3Hidf+IRSfvVHAZLdTw0SrPLU5UonQfdr
         m3+ByiXoWI46o8VdT0HGIjOmQnXJUnzJFpEvw5cj9ily7whb/ZkmPWD/Hg/jC5WhEz7C
         zhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774872211; x=1775477011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/pCkZp0kOo5osdLzRpybPSjj/VyMtaU3zoXyQksTzs=;
        b=nPwXhiu9P39/3uqhYIabgS0wspSH2XoaxvL8GrnWoZxI8KAiNMyzUyQ1e/X2TmwfvU
         k4uKpUUJUDk7nSO/r6yMH+SsTwwuwXQMSJgkt0czQo7JXFOGV4Lm07msMCSJWTK1hf6/
         4Dm//7J0/66oCJ3J4Tcnpkz/a4yekaFvSobasUK/oKQ7w0b+NHJzJbKNXXDVPoEE4CxH
         DUpWQDLlUvDwJOmbSOHBvxGO0nLMhHhxg2MP/2dUDXHuMDcMP9cLpmpfJEfGtztqhaLD
         lt1wBfASQ5+BQgyz789RM3gucV/sMyNyQ6j0wkbKjC+vcd60Ft3w9lBxcIgKgreYD60A
         Mbng==
X-Forwarded-Encrypted: i=1; AJvYcCU3QXPC6Lhh/iFio/Ot/g5EGZ5dxCJbqYjQ8Pg/UkltgcXadY9c7ZFAJIm5eDcfep4b1GMc9+zI@vger.kernel.org
X-Gm-Message-State: AOJu0YwNf9u2XkqsJPf0Oq1pYlFcwBy/ZcLxq7qhZe4eSw31P8GmgnjD
	D9k2XcLWHCXOG08j5YBP41WwJycx5/YabV7NnFL+R4hlve7Xq9G7zGOK04y+csWYzNGYrQBhB/1
	/tWAfFPU=
X-Gm-Gg: ATEYQzwiHY/11BMhzIz1AAaKbtvHog2IFPhUoJaPJxNrOrCZi7rJpWm4CrBOXAzyreW
	J12DtUsQlniirFgblmnkvKdG92L81GRCgFvCrS7bPEDzptI/JUPpqBXCENeiGTbNAJVKMUaKw9q
	4bLMwXMwpvM6RDg2+jB08+MZvGPD7Elq4wNcslwtfGcRcH9WPi/sFZLYaSFt6WoQeiY/+XAPIxz
	Qe2Z4mV2uXo1iYLqpjMYexit7KK9A4dJP3lGmYzYHlhPT94uvjtW8v5BV/l31JQlxUQ2zRrb3cQ
	/ru/OtAA3ZEB0xkEuTBloOJG2dHIlCvqAQ55y1lYIjxzTKjiQdbdMAGDx80xVtCvoglAsJPRXht
	i36SBUYGgPNNosRAfEtvSyTx10oB/HlcGKrrRmP2ghWBPvxj4ZjhncU+FY6q80NbK3i4OUbL/gg
	k4RBZBQVKF+tpDVkUZHoUVtmFTfVgmRnfvimKo
X-Received: by 2002:a05:600c:1d8c:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-48727efabf6mr230701685e9.24.1774872211429;
        Mon, 30 Mar 2026 05:03:31 -0700 (PDT)
Received: from localhost (109-81-17-175.rct.o2.cz. [109.81.17.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48727192012sm79669865e9.32.2026.03.30.05.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:03:31 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:03:29 +0200
From: Michal Hocko <mhocko@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] mm/percpu, memcontrol: Per-memcg-lruvec percpu accounting
Message-ID: <acpmkY6_gWLdtJCB@tiehlicka>
References: <20260327191936.1980054-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327191936.1980054-1-joshua.hahnjy@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15106-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhocko@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 719FA35ADB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri 27-03-26 12:19:35, Joshua Hahn wrote:
> Convert MEMCG_PERCPU_B from a memcg_stat_item to a memcg_node_stat_item
> to give visibility into per-node breakdowns for percpu allocations and
> turn it into NR_PERCPU_B.

Why do we need/want this?
-- 
Michal Hocko
SUSE Labs

