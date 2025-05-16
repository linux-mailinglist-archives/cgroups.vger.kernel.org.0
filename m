Return-Path: <cgroups+bounces-8229-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34606AB9916
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 11:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86DA1BC5EC5
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 09:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6886230BED;
	Fri, 16 May 2025 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PfzLdruW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UfbizFVT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PfzLdruW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UfbizFVT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1181F418D
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388617; cv=none; b=oDcIaMia84eDPL8M17c2zu52vD7ilvD2k0dzUH7H78ia769XosNpyE7H4hCMcKcPY4hVfasxnLecom+uQ0waNZGbpSXLVr5R6MLQ7qYliYBYrNDDZBjvYIAg+jZEl0OqNCsYv6SnU302dXmWWV3GE07iIQ3mueHofEsWFVO65NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388617; c=relaxed/simple;
	bh=p97bHrpcAH8jlbAyO2a7U8GiB18SImVX2SgrAVchoyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+rIK0Z0boR35nLlkA65olnzCXMz7MPFZUuWKuaocOJgu1yI7d02Zx0K88Wws+NxJ2NwfE17WLqlyu2utZKQbpeQ+4MFUXkeG1COvnegsSAkSW7lDywmOwFEGN5T7x0FEJBmK2f3wCwscithvgvTqajhmRnFl0yT80ylzrj4FKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PfzLdruW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UfbizFVT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PfzLdruW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UfbizFVT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4CCC621191;
	Fri, 16 May 2025 09:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747388614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjOd1ItTK1nG6OKlv/p97/XYiGL/8fE56WZuFJ0H50g=;
	b=PfzLdruWbIB8XoxIUIAR0SLl6M05OUo5S1tgCIQklyhyWBfjCRUzQMAorNvPzUDoi9wyRX
	XJXGtNJM0r/rOCzE8XekpyTcqQPdCwVkPdHFjgFcBQVLZbNZilvzenEeKrYYWcJ/fbTCr5
	apw2DiLSxOGsPmFpuvfNRgh/A8ChVlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747388614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjOd1ItTK1nG6OKlv/p97/XYiGL/8fE56WZuFJ0H50g=;
	b=UfbizFVTTPP0CFUG7eX/rLQzZTXJrm4t1h+Ay62gYSXsIKSHtPp298JavaMpekZO7la82/
	gqf/AW64rjZA15CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747388614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjOd1ItTK1nG6OKlv/p97/XYiGL/8fE56WZuFJ0H50g=;
	b=PfzLdruWbIB8XoxIUIAR0SLl6M05OUo5S1tgCIQklyhyWBfjCRUzQMAorNvPzUDoi9wyRX
	XJXGtNJM0r/rOCzE8XekpyTcqQPdCwVkPdHFjgFcBQVLZbNZilvzenEeKrYYWcJ/fbTCr5
	apw2DiLSxOGsPmFpuvfNRgh/A8ChVlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747388614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjOd1ItTK1nG6OKlv/p97/XYiGL/8fE56WZuFJ0H50g=;
	b=UfbizFVTTPP0CFUG7eX/rLQzZTXJrm4t1h+Ay62gYSXsIKSHtPp298JavaMpekZO7la82/
	gqf/AW64rjZA15CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DCEC13977;
	Fri, 16 May 2025 09:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CmXaCsYIJ2h3cgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 May 2025 09:43:34 +0000
Message-ID: <1702504c-d42c-4714-83a3-7e455e36090f@suse.cz>
Date: Fri, 16 May 2025 11:43:33 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] memcg: add nmi-safe update for MEMCG_KMEM
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250516064912.1515065-1-shakeel.butt@linux.dev>
 <20250516064912.1515065-4-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250516064912.1515065-4-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,linux.dev:email]
X-Spam-Score: -4.30

On 5/16/25 08:49, Shakeel Butt wrote:
> The objcg based kmem charging and uncharging code path needs to update
> MEMCG_KMEM appropriately. Let's add support to update MEMCG_KMEM in
> nmi-safe way for those code paths.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


