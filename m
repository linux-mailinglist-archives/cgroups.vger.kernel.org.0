Return-Path: <cgroups+bounces-8230-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41547AB9925
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 11:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FBD3BF04F
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 09:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2175230BF9;
	Fri, 16 May 2025 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yv3PR99Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ymXivejJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HmHH8Gke";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UBgDKGUK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C54231838
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388659; cv=none; b=O3JSduySV/7o/lf6J1tti8EilgQZ5KlMNQXSG453bw5/c+nsFzkSrnHbsP2CbLPTpiTl7AmeZ+2MkqxZtL+dHDWIA79UMoZGRH45YMtrOmLdyR21cFlYUCYKPhTiqAvcpIuy1vV6iK7Oh4wFIRPUuFsMYqzhAXgTFgPX10/mE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388659; c=relaxed/simple;
	bh=O+1SLPJ31vnWMhAWpwQaajz1jJQBKLHRmmZ59bV1CY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJX+/gboY4wIaV3LctZTFBkCA4iFNpI0Vv/9X/+PmFNrbvWeCAuZNKPw9Ja8hs5h+3o6zC9il3yLbeGCNsn5p65iwiAVcLzDIyf8yNTvvhTAHgu7t3hWHlrpcXOhaUn3hw7a+blRjATwkrO/ag8xgZgE3YXShQKn4fQEo+pjR/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yv3PR99Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ymXivejJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HmHH8Gke; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UBgDKGUK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBA0D1F7ED;
	Fri, 16 May 2025 09:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747388655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BqPCXIOc5zFdtIoBAcba6W/MibnyaR1k2nQmNTjpq7A=;
	b=yv3PR99QA3ZN2oHVFq6QeY3S33+M39RKD8rg1+cL9avROJBgzz9MpKs2GO/gocaQXtaPA9
	MK3F7duMzQYZSCXfM9/SXlAScoiieg2nM3Cbzfc0qpyYUZXn6aPOM2SLPQykg+LVhlbopo
	yR0oB5gy8GhLrMGDu4EqYWc8fpsHJNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747388655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BqPCXIOc5zFdtIoBAcba6W/MibnyaR1k2nQmNTjpq7A=;
	b=ymXivejJ+5hRwcrJCwQ6EYGqgqTNzxVr8pjHHttUuOQvCuKiW7wC7saAnOQd6vO46SS5BQ
	PEli4K0fWlZR4JCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HmHH8Gke;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UBgDKGUK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747388654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BqPCXIOc5zFdtIoBAcba6W/MibnyaR1k2nQmNTjpq7A=;
	b=HmHH8GkeDq4IFZBNPL30g4Oa66jqeQDUFD28AoulF9XDr9zoUgGcPa0zOv1KNI57eZhPSV
	T+aeDPSUJgaR1AY+Nz1miYW9y3fObjNJFvX9gH93Y3QPb2TgrmsdPh7q2+Kblb/YHcUx4F
	B9Y2DNNnFRbg+DRsLxeGuxRpuj9YZVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747388654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BqPCXIOc5zFdtIoBAcba6W/MibnyaR1k2nQmNTjpq7A=;
	b=UBgDKGUK0JyAFy0slBHWyTO/g8hvQV269ao9QWWOLxVcg8OZKkkXDA+TdyJ4rLu75AIvNt
	O7LQs8Kml4zNTqAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB83813977;
	Fri, 16 May 2025 09:44:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IzyIKe4IJ2ivcgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 May 2025 09:44:14 +0000
Message-ID: <2b57766f-d4ac-4193-8c00-27b558073934@suse.cz>
Date: Fri, 16 May 2025 11:44:14 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] memcg: nmi-safe slab stats updates
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
 <20250516064912.1515065-5-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250516064912.1515065-5-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: CBA0D1F7ED
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:email,suse.cz:mid,suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 5/16/25 08:49, Shakeel Butt wrote:
> The objcg based kmem [un]charging can be called in nmi context and it
> may need to update NR_SLAB_[UN]RECLAIMABLE_B stats. So, let's correctly
> handle the updates of these stats in the nmi context.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


