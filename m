Return-Path: <cgroups+bounces-8162-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E070AB5303
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 12:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219CF9A3F42
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 10:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C68423C4EA;
	Tue, 13 May 2025 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BRfR+8ok";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EPZMvxDK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BRfR+8ok";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EPZMvxDK"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB61F3B83
	for <cgroups@vger.kernel.org>; Tue, 13 May 2025 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747132804; cv=none; b=G9dewpW25LZQ5oe8lNnh1U1ZyuDK/9fOo1BYJP0tia/tRPm5jHfUhi/tc+YerrY109fnEO35E4/wZvNXESO1XTAqkMx540gWLmk7XcUd4+bB09gKT+R58c1vpq4FRcrv0oBJRtsXmYWFTscwssPpsc+7zLEl6ge0x9h1gOAK7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747132804; c=relaxed/simple;
	bh=BeYsTuFMMF+78S8QItXZ34zWaQcnTv5lev10rCwVUnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kx6IH18eXNmk69jGiLgTiL44A8XxKNbUQUjsHSsSdblULIT0G8kznVKDVEoxcUlrouKfvtxOr1rsnkmvuA2EbSK8ZwFRrEDQ3ieOnSPmKXSA/4jN9uwgzFpfJEc8EHVnjMUVFCveXUEWINGw8Kn+ays8NXUZ4H9LmYv1l3iCKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BRfR+8ok; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EPZMvxDK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BRfR+8ok; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EPZMvxDK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00D5421197;
	Tue, 13 May 2025 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747132801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyl6ikRgcExL5pzSCPRicYoK/SSI4/2yziLBcvu9oRo=;
	b=BRfR+8okXd2l18KkyfpqZxh/vnpEu1Bl1LgGjgW+Rgd7ppHNa3tGd6cUyuS8zJY6B8Pgmx
	GndbG3GfbSObsSwA1q+a4VRvpsqudw35hrHclJLG+XH2rvuRw4k48e+p/euLV5Qdn8RNw5
	+QT5u3k3uBDNzNrPUUC5qLK2xeFm0zc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747132801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyl6ikRgcExL5pzSCPRicYoK/SSI4/2yziLBcvu9oRo=;
	b=EPZMvxDKyOnVnXBsttjlE584g5Yt4rVvf+V8ZaFPi9vi3zo7FdPrUgEaH5f1xxxWJ6bgVd
	uDWPEQCnbrM/CHAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747132801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyl6ikRgcExL5pzSCPRicYoK/SSI4/2yziLBcvu9oRo=;
	b=BRfR+8okXd2l18KkyfpqZxh/vnpEu1Bl1LgGjgW+Rgd7ppHNa3tGd6cUyuS8zJY6B8Pgmx
	GndbG3GfbSObsSwA1q+a4VRvpsqudw35hrHclJLG+XH2rvuRw4k48e+p/euLV5Qdn8RNw5
	+QT5u3k3uBDNzNrPUUC5qLK2xeFm0zc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747132801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oyl6ikRgcExL5pzSCPRicYoK/SSI4/2yziLBcvu9oRo=;
	b=EPZMvxDKyOnVnXBsttjlE584g5Yt4rVvf+V8ZaFPi9vi3zo7FdPrUgEaH5f1xxxWJ6bgVd
	uDWPEQCnbrM/CHAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4D66137E8;
	Tue, 13 May 2025 10:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yN2hM4AhI2hbIQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 May 2025 10:40:00 +0000
Message-ID: <d015a0b1-498f-4b7b-97db-27c4d92e884d@suse.cz>
Date: Tue, 13 May 2025 12:40:00 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/7] memcg: make __mod_memcg_lruvec_state re-entrant
 safe against irqs
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
 <20250513031316.2147548-6-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250513031316.2147548-6-shakeel.butt@linux.dev>
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
> Let's make __mod_memcg_lruvec_state re-entrant safe and name it
> mod_memcg_lruvec_state(). The only thing needed is to convert the usage
> of __this_cpu_add() to this_cpu_add(). There are two callers of
> mod_memcg_lruvec_state() and one of them i.e. __mod_objcg_mlstate() will
> be re-entrant safe as well, so, rename it mod_objcg_mlstate(). The last
> caller __mod_lruvec_state() still calls __mod_node_page_state() which is
> not re-entrant safe yet, so keep it as is.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


