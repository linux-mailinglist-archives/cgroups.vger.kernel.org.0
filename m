Return-Path: <cgroups+bounces-8161-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B025FAB530F
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 12:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CA59A224D
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 10:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476FD24C077;
	Tue, 13 May 2025 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f7v8jFmz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4jAUwsPM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f7v8jFmz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4jAUwsPM"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45024C68B
	for <cgroups@vger.kernel.org>; Tue, 13 May 2025 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747132754; cv=none; b=UuDXX0DzhksFWNZNe9w9S1RM6vpkhTm/7Z72FW3Yf/ierDMYWXz3MwM1TKp9lbdZgKE0NS3nnvEKvwzOGy0r/jpnon+1t7YHVWylXPdnFw6I0E+Vfurc3r9CaX8Y4C0l49NUNmpWGFB/GzQAIWQHJogE8KBJfebdEHLuxDmil5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747132754; c=relaxed/simple;
	bh=SFEdalAw4cdX32pVklbXBz9BrTz637HV5YVHzDb36M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A18BftC82fXyRLnqs41rbU4brR/sU0p7YedgRktSeAvH9yOg/J+yU6/2Lb9jD0EYGgHC4RpEssHQ7ybxIDpFMoXI550fMS5WC+KKldOTtw6bDsMz4KcNvTNnHq6vtDyMCyvqAiDpwbyyjUOA41QXQLAqwn8yH3bP6RwaPgkKGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f7v8jFmz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4jAUwsPM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f7v8jFmz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4jAUwsPM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A88771F78C;
	Tue, 13 May 2025 10:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747132750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hxbMAZGtcmyIepkJJQaXLIyots0rkHD4hyWC3BPQoQ=;
	b=f7v8jFmzltzCs218hCbhOuVYeyJFcEgUF6NdXddsQIYHYpOhLyvVDbDeyeudE4oHVMeDqZ
	osS3feVgZXbdGvDjaiddNA7toQYe652tIYLI1qD18vSsc2BKM8d4hZNIxoNYQOs0WCanOl
	f7XBmmf4RZjQQPr4al9PBmpeYJPEh6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747132750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hxbMAZGtcmyIepkJJQaXLIyots0rkHD4hyWC3BPQoQ=;
	b=4jAUwsPMMM1gHwWKMPnKIBF+tUflkOFzFOqu6bVCMzg8Q6EvYKrH4jozAovJfYSuCv22bQ
	wVoZq4aD2J3D8OAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747132750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hxbMAZGtcmyIepkJJQaXLIyots0rkHD4hyWC3BPQoQ=;
	b=f7v8jFmzltzCs218hCbhOuVYeyJFcEgUF6NdXddsQIYHYpOhLyvVDbDeyeudE4oHVMeDqZ
	osS3feVgZXbdGvDjaiddNA7toQYe652tIYLI1qD18vSsc2BKM8d4hZNIxoNYQOs0WCanOl
	f7XBmmf4RZjQQPr4al9PBmpeYJPEh6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747132750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hxbMAZGtcmyIepkJJQaXLIyots0rkHD4hyWC3BPQoQ=;
	b=4jAUwsPMMM1gHwWKMPnKIBF+tUflkOFzFOqu6bVCMzg8Q6EvYKrH4jozAovJfYSuCv22bQ
	wVoZq4aD2J3D8OAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85583137E8;
	Tue, 13 May 2025 10:39:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zdqOH04hI2gFIQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 May 2025 10:39:10 +0000
Message-ID: <94f2532e-040d-4b09-a82c-3cfa9c67c469@suse.cz>
Date: Tue, 13 May 2025 12:39:10 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/7] memcg: make count_memcg_events re-entrant safe
 against irqs
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
 <20250513031316.2147548-5-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250513031316.2147548-5-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
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
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,linux.dev:email]

On 5/13/25 05:13, Shakeel Butt wrote:
> Let's make count_memcg_events re-entrant safe against irqs. The only
> thing needed is to convert the usage of __this_cpu_add() to
> this_cpu_add(). In addition, with re-entrant safety, there is no need
> to disable irqs. Also add warnings for in_nmi() as it is not safe
> against nmi context.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


