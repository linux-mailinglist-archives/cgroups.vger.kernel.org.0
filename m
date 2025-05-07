Return-Path: <cgroups+bounces-8066-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71141AADD97
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 13:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A581C07442
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 11:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0021F242922;
	Wed,  7 May 2025 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Vs0EHE2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yIpHJvFt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hBp9QEAI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rn7ktXyD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377BB241673
	for <cgroups@vger.kernel.org>; Wed,  7 May 2025 11:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618157; cv=none; b=efl6rYX1N3KpAgOSwdUrh/sNBy4QzMI4VfGx0v4BZpuMgqVmg4usNTViXF4hWth9w6Em0fql9XPclo2kslrgGsgM3WVTDth0Xr3Pz7p1q7dtjP4twbjRhu4YX7eYvrNzOn8u8Mrk0MXTaCS5xczB+h5CJYLQswztXN4/fbvwI7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618157; c=relaxed/simple;
	bh=/Bh3jW1bNzFgkJnbT2NX6ZtY9kjOWTe3mvKAmdAXJ4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1W4yp6xKsyPDv9gLOJEhg42ELRxGOQ4HhS/mInBpjL0JAOdiSXEzMiW8D/9Ba/+xl/fL8BjJM4Rbc0QK00PTIkHtSLTotXs1JcWRhNY1ejkxYT2sn2SS7mtzH7LPXbtt1zl/QYnqhIpHw6cGU0omwNKGqI5+UbAMhJJFrgoGMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Vs0EHE2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yIpHJvFt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hBp9QEAI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rn7ktXyD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 620051F393;
	Wed,  7 May 2025 11:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746618154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcYaw+phsHmb4CGjsUuKwwWNlP8Li19pE0M34m/c9G0=;
	b=0Vs0EHE244sqvREDBAkoVSSnEa9OI5gy5G0DfJgtPF4OukOQgCxxgqJ3RdutiCUvimU29o
	WrBt7QHlNbRIFH60nR6D9OOLczkLwspzoyPK4gY5wJo1A6V9jN0ZUuaoP8qYe/9Vuqy+uf
	213Ap+emco6ovEzha7P3pDX3kj1FVqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746618154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcYaw+phsHmb4CGjsUuKwwWNlP8Li19pE0M34m/c9G0=;
	b=yIpHJvFtWUUasSt0l91z4u3dP3B5HxWS5hllAtCM9xkgJvaBCWFuw86276sWka5uayhoFA
	jqtUdZph2o1TI4BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hBp9QEAI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rn7ktXyD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746618153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcYaw+phsHmb4CGjsUuKwwWNlP8Li19pE0M34m/c9G0=;
	b=hBp9QEAIcq4vHt5+ICzOYvdzia4ggsVcKpscnwcNIs2eoiNFmPaS0V1Zro+1Ba6Gk5CcDg
	Of6NAIYpzg552hdPaq9MXIS4yYZXgc0JAUvUaJQdZL97YLM6xAqoZJP7MItRmXQVcD+16E
	rJtw0aq/cW/HwOIozKxCvh4UawHD3rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746618153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcYaw+phsHmb4CGjsUuKwwWNlP8Li19pE0M34m/c9G0=;
	b=rn7ktXyD+voIbvaXlQd7Ie8eb1CRs2GRi+ZNfzpG7Kbn0sYISqGp1QSpPVPcY2vZuMj2rL
	05T1c5z1ZdmsI5AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 493DD13882;
	Wed,  7 May 2025 11:42:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cheRESlHG2iqIwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 07 May 2025 11:42:33 +0000
Message-ID: <a2925f3d-9af0-4299-aafa-70dfaf0f3230@suse.cz>
Date: Wed, 7 May 2025 13:43:06 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] memcg: simplify consume_stock
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250506225533.2580386-1-shakeel.butt@linux.dev>
 <20250506225533.2580386-2-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20250506225533.2580386-2-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 620051F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:mid,suse.cz:dkim,linux.dev:email];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -3.51

On 5/7/25 12:55 AM, Shakeel Butt wrote:
> The consume_stock() does not need to check gfp_mask for spinning and can
> simply trylock the local lock to decide to proceed or fail. No need to
> spin at all for local lock.
> 
> One of the concern raised was that on PREEMPT_RT kernels, this trylock
> can fail more often due to tasks having lock_lock can be preempted. This
> can potentially cause the task which have preempted the task having the
> local_lock to take the slow path of memcg charging.
> 
> However this behavior will only impact the performance if memcg charging
> slowpath is worse than two context switches and possibly scheduling
> delay behavior of current code. From the network intensive workload
> experiment it does not seem like the case.
> 
> We ran varying number of netperf clients in different cgroups on a 72 CPU
> machine for PREEMPT_RT config.
> 
>  $ netserver -6
>  $ netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K
> 
> number of clients | Without series | With series
>   6               | 38559.1 Mbps   | 38652.6 Mbps
>   12              | 37388.8 Mbps   | 37560.1 Mbps
>   18              | 30707.5 Mbps   | 31378.3 Mbps
>   24              | 25908.4 Mbps   | 26423.9 Mbps
>   30              | 22347.7 Mbps   | 22326.5 Mbps
>   36              | 20235.1 Mbps   | 20165.0 Mbps
> 
> We don't see any significant performance difference for the network
> intensive workload with this series.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


