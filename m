Return-Path: <cgroups+bounces-8165-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB993AB5586
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 15:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163D03BAA0E
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 13:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D1028E56C;
	Tue, 13 May 2025 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kdd3OXEr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kTnCzx2N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KDOh7/F0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WeCsdAM8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EB9213E7B
	for <cgroups@vger.kernel.org>; Tue, 13 May 2025 13:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747141530; cv=none; b=Ec96hyX2GQ7kZInsPB8Wp6uonYS5I3IX/B5iogBDEOUy3uNrrGSgiRVBfKfgyYFScp8qbLWDstcTcWs57ttmSJwernlUolG+MYjpGoS/MBoIbHMMx2qob9KpSi2rpuwLXUeT49jFgq3gI3zKTbhE5gaE6oeWxxI6dofNqYnR1YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747141530; c=relaxed/simple;
	bh=FIJRMeYqArw7tYNudfdvcpb3fyaE5SzBJpqnuTVPs0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1zf33DEbAkXk7bxuG/2hPlXN5dogQ4eX21QN/7dO9v4iOGVymaHZ6aQx5bZ8k6zLyQiSBrWBLITHD/e+2S1Ga0Ue98n5VvRphJqgm+GYR/Q6WJmKTUSAaBV8pPQWutTF2zlQRBA/f15N1+Hw0zuVUlIVpthImKsS2OyE0/EzEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kdd3OXEr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kTnCzx2N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KDOh7/F0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WeCsdAM8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AF211F792;
	Tue, 13 May 2025 13:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747141526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRWUYikOIy/1r7u07D5ZCje1j34KlJyLQzknjjGOicY=;
	b=kdd3OXErue0VlynjlAhmsosCko1ctbMupCP7zksbeMwhVnc9QOlh2VtmkE9Zt3glm2rPsO
	Ej+vKj4k6yc7Hrz9Cu+mwD6G/ZJx3Ei/6FBxjxtVh73s0Tv/oNn52KfFUrRMWxYmZRWL+h
	SQdyEoLqYtiCbfvtxQczOkUfH9QL9GU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747141526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRWUYikOIy/1r7u07D5ZCje1j34KlJyLQzknjjGOicY=;
	b=kTnCzx2NBr9RUocyWdZITzopFDyYszz7wpbGJRMZatBsbtd64JTGImmN/6vcRvY7xAQ7bW
	nwfqch0H9bcmqVDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747141525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRWUYikOIy/1r7u07D5ZCje1j34KlJyLQzknjjGOicY=;
	b=KDOh7/F0eM08rczbeQl8PDsy52saiIb5A5bQZff/FYhwX5npXyDzt30hIopKMphMu8JPqR
	3VKZpmyTvwxz71/dyenSggvy3Tyh/ExbVNlRH8BD1maJasHhZPFew3G43W2PxLLmlnN6sd
	XqrRRWwHa3wgLLecx+V2J2GBrkVFT4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747141525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRWUYikOIy/1r7u07D5ZCje1j34KlJyLQzknjjGOicY=;
	b=WeCsdAM8aKEoA2ktaw+PoaIs0o764iCzfypdOFIZSen0MuyAFeCs9Jwd20uJDN43bNJQrh
	CyOLcasLEDPiazAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6AC1137E8;
	Tue, 13 May 2025 13:05:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TqprN5RDI2gjUwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 May 2025 13:05:24 +0000
Message-ID: <44489dcf-2bb1-45f3-a593-ac34da3f9138@suse.cz>
Date: Tue, 13 May 2025 15:05:24 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] memcg: objcg stock trylock without irq disabling
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
References: <20250513031316.2147548-1-shakeel.butt@linux.dev>
 <20250513031316.2147548-7-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250513031316.2147548-7-shakeel.butt@linux.dev>
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
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email]
X-Spam-Score: -4.30

On 5/13/25 05:13, Shakeel Butt wrote:
> There is no need to disable irqs to use objcg per-cpu stock, so let's
> just not do that but consume_obj_stock() and refill_obj_stock() will
> need to use trylock instead to keep per-cpu stock safe. One consequence

I'd rather say "to avoid deadlock".

> of this change is that the charge request from irq context may take
> slowpath more often but it should be rare.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


