Return-Path: <cgroups+bounces-7951-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD614AA4AFC
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 14:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBBE16E246
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 12:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E1A248F53;
	Wed, 30 Apr 2025 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HeMSLxZh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E6Cdrk2R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HeMSLxZh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E6Cdrk2R"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3980235065
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015720; cv=none; b=bh+mCnPGod5TM+WKqx/mtdUQk1v7miz3ILp12yrTyJQgm7Pd7NSC6Ujtjw9gGqiB8KUz7AHWk49hDwT50agXF7GQyXJ84DwoOzs3oeBQMlneB8bLi+f63Yazdg7B7f17WbIfcXpR7krMFzUUedtD1rlfz/RvS6qqikIK6W8+wN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015720; c=relaxed/simple;
	bh=FxjYvxFBuJ/b/dO7PGExBedEzNFA1AzYRxnl7smiSn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxwEsZB+0OySrWWARuTFgumVi6VrLS11Olm1OhmRsoAlhio5MMUrT4Q3HHyvqadGbUrrESUwGgp92Qse3O4ELdZBbnYO40hARXookv4zAPoJLngcLkOIxGaMKVhfaBF4VS+OT9DdgQ88FbAD9p2YE9ngPerLLVou/6ml/SuQrAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HeMSLxZh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E6Cdrk2R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HeMSLxZh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E6Cdrk2R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 05BEE21859;
	Wed, 30 Apr 2025 12:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746015717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ugj9EHVwZhwWNd0uCOcEtD3nfaU2KTVfTszMNZAUfE8=;
	b=HeMSLxZhRtDsBfCRIFglkEDJWDn4NqVBweKxML1ZFQufgQYjM0NR1sShUOEca78UWc1qe4
	RGDepSwh6w53OicKJzA97TjM67OuQF1kdHY6/XN8mbsKP5/Z8asS1WvsOLKB0vPV/AZaqu
	YJ+isZtxt3NHROYMkE0s0Ye10mo8xw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746015717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ugj9EHVwZhwWNd0uCOcEtD3nfaU2KTVfTszMNZAUfE8=;
	b=E6Cdrk2Rx44HaShGLcmqCyPnY4BOh/LY9fthLReoGrlRaEGwcKIhIZFbhQhz1m/rPCKl8t
	+123BPuBrGCpPmCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746015717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ugj9EHVwZhwWNd0uCOcEtD3nfaU2KTVfTszMNZAUfE8=;
	b=HeMSLxZhRtDsBfCRIFglkEDJWDn4NqVBweKxML1ZFQufgQYjM0NR1sShUOEca78UWc1qe4
	RGDepSwh6w53OicKJzA97TjM67OuQF1kdHY6/XN8mbsKP5/Z8asS1WvsOLKB0vPV/AZaqu
	YJ+isZtxt3NHROYMkE0s0Ye10mo8xw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746015717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ugj9EHVwZhwWNd0uCOcEtD3nfaU2KTVfTszMNZAUfE8=;
	b=E6Cdrk2Rx44HaShGLcmqCyPnY4BOh/LY9fthLReoGrlRaEGwcKIhIZFbhQhz1m/rPCKl8t
	+123BPuBrGCpPmCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0DF1139E7;
	Wed, 30 Apr 2025 12:21:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0iiJNuQVEmgXXQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 30 Apr 2025 12:21:56 +0000
Message-ID: <5e54c286-7cac-4280-90b6-8ed15715871d@suse.cz>
Date: Wed, 30 Apr 2025 14:21:56 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] memcg: completely decouple memcg and obj stocks
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>, bpf <bpf@vger.kernel.org>
References: <20250429230428.1935619-1-shakeel.butt@linux.dev>
 <20250429230428.1935619-4-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250429230428.1935619-4-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/30/25 01:04, Shakeel Butt wrote:
> Let's completely decouple the memcg and obj per-cpu stocks. This will
> enable us to make memcg per-cpu stocks to used without disabling irqs.
> Also it will enable us to make obj stocks nmi safe independently which
> is required to make kmalloc/slab safe for allocations from nmi context.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>	



