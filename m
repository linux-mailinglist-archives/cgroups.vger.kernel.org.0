Return-Path: <cgroups+bounces-8067-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA3CAADDAB
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 13:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A484A0DFE
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 11:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAE6257AE8;
	Wed,  7 May 2025 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xsB8VV/w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QTFCvD3N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xsB8VV/w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QTFCvD3N"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62148233129
	for <cgroups@vger.kernel.org>; Wed,  7 May 2025 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618381; cv=none; b=a4QPROmHVEdrjFM2+Xng51N7ZcuM6tPGnRVEzdsn3Vg5o4DEzfCzk0DbmBpXYKbPq9IGYPv/zY8b3h5EKTZVxoL2/rHfW2Wm4SiehjelwV7MlJgz14dwXlDAmG4Fou2nUIqTo3YwbMTg6GXZ2RV88Wcy00kJvPY3FK/Ppr9j5sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618381; c=relaxed/simple;
	bh=vzwf0tIYzNuQhU2aD2nOcCDkbhgSc+b+ohdnlMe0oWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nt6gcRBhleZKq1x9mbTe4fXFXJQ4+NFtO5my01yusZCC746s8Kj0mAgj7tZVgmDU6xJ5I2cJMtTULMglGHsgk+ooYaR6WKKkBwhiHlDVgfNVWl1xD7DPLpinNYCayzvxwVIFdcjO3wBo2+Y4J3q8P/8knE5gBkLmh4Jp03PGLy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xsB8VV/w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QTFCvD3N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xsB8VV/w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QTFCvD3N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D30E1F393;
	Wed,  7 May 2025 11:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746618378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uy7d/ZjeDgzXAL0tpPZUP+r0mJI7QK6Hc7BG5cAHyRo=;
	b=xsB8VV/wzKxOWv3JjdL4y9sQmiZtRmou+che2Gz6zp2spSn9+DcCINwEJWez4+P+69teeZ
	axm5ofnvbGPJoafoQSRnI0pgwzvXt6Ny1pPDCMzGd2rfNfN9a/THsPWQiN1b88/EwSsHeO
	iOSqpnhmhbMn+7grroA1AJWdilmBZss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746618378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uy7d/ZjeDgzXAL0tpPZUP+r0mJI7QK6Hc7BG5cAHyRo=;
	b=QTFCvD3NoBkIcmwZUzC3U/Sbx4odTDDQdBtPCbCw/gO/ofLmtbbV+TvKCHOnCVSzovweqq
	kdhdx9Wm00T4d6Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="xsB8VV/w";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QTFCvD3N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746618378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uy7d/ZjeDgzXAL0tpPZUP+r0mJI7QK6Hc7BG5cAHyRo=;
	b=xsB8VV/wzKxOWv3JjdL4y9sQmiZtRmou+che2Gz6zp2spSn9+DcCINwEJWez4+P+69teeZ
	axm5ofnvbGPJoafoQSRnI0pgwzvXt6Ny1pPDCMzGd2rfNfN9a/THsPWQiN1b88/EwSsHeO
	iOSqpnhmhbMn+7grroA1AJWdilmBZss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746618378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uy7d/ZjeDgzXAL0tpPZUP+r0mJI7QK6Hc7BG5cAHyRo=;
	b=QTFCvD3NoBkIcmwZUzC3U/Sbx4odTDDQdBtPCbCw/gO/ofLmtbbV+TvKCHOnCVSzovweqq
	kdhdx9Wm00T4d6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46CB013882;
	Wed,  7 May 2025 11:46:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ch4SEQpIG2gEJQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 07 May 2025 11:46:18 +0000
Message-ID: <3d99da0d-b08e-416e-82bb-cd44179a424f@suse.cz>
Date: Wed, 7 May 2025 13:46:51 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] memcg: separate local_trylock for memcg and obj
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
 <20250506225533.2580386-3-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20250506225533.2580386-3-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5D30E1F393
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.cz:mid];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action

On 5/7/25 12:55 AM, Shakeel Butt wrote:
> The per-cpu stock_lock protects cached memcg and cached objcg and their
> respective fields. However there is no dependency between these fields
> and it is better to have fine grained separate locks for cached memcg
> and cached objcg. This decoupling of locks allows us to make the memcg
> charge cache and objcg charge cache to be nmi safe independently.
> 
> At the moment, memcg charge cache is already nmi safe and this
> decoupling will allow to make memcg charge cache work without disabling
> irqs.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


