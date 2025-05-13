Return-Path: <cgroups+bounces-8159-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC33AB52F3
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 12:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E40E19E3A79
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 10:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88869248F55;
	Tue, 13 May 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YJK3VmFN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aDgPuz9m";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YJK3VmFN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aDgPuz9m"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1F245032
	for <cgroups@vger.kernel.org>; Tue, 13 May 2025 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747132471; cv=none; b=exOtRRIGaTmM+8T3gbTsBH78Lc6tlBlMDg9BEu5YVtSQfFOMcDGz5EC81NQT/hmC9jRLI4Qk82wKO+cYQ5B3FvYqJlfIX4gSKdoaWNGgmY0eqZGc1PcFNK61vWb8Or6mqJ93R0UsCO1y26XokS3zMAzddb3W4Zc1h51oaPCKRAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747132471; c=relaxed/simple;
	bh=Ku57Y7bfEaYk5w9jq5MQl52Z9pVvbWPXJ0q8zIPXnxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/BBIYOklo8bfytcWhaUDnv1QA8W14DByUCTM3weSJyQ3T8vomr32ISyMsR6tylbILzexIG8GhK11INKUq+qtbMmRVn4Vnh77XmQqcivuXr29UnpitFg/dGsWF9ov2A+XS8jqYikMvOQjTkY39WdfnFlTprK+GRdv/4tJKaVYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YJK3VmFN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aDgPuz9m; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YJK3VmFN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aDgPuz9m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B70F4211DD;
	Tue, 13 May 2025 10:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747132467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJDhadod13xdWIV40wX1pnuNXxPWqMNyG93g27zikYU=;
	b=YJK3VmFN18H8WWOpyaFTkDK2aoItEX7rjeqOCVMFYx9qt7LKFOY3BYm8ihwqEMwHRBneCk
	n/n5cIsmGSsi9OUB/JvLTJRUdH7mvLAsL5R8RjMpm5omLqW8JcidiE+ekHWHJtlIEuBnF1
	F1EWMowwf+vYSRm7t8I9J0Hgus/hTm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747132467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJDhadod13xdWIV40wX1pnuNXxPWqMNyG93g27zikYU=;
	b=aDgPuz9mvxx+a4PzejitkLiAa0y57irjzRQARH7a6aHIQ/PJKbNNjoQJPLv05q6mju7SPS
	bDL5VjEcTDC3ZiCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YJK3VmFN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aDgPuz9m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747132467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJDhadod13xdWIV40wX1pnuNXxPWqMNyG93g27zikYU=;
	b=YJK3VmFN18H8WWOpyaFTkDK2aoItEX7rjeqOCVMFYx9qt7LKFOY3BYm8ihwqEMwHRBneCk
	n/n5cIsmGSsi9OUB/JvLTJRUdH7mvLAsL5R8RjMpm5omLqW8JcidiE+ekHWHJtlIEuBnF1
	F1EWMowwf+vYSRm7t8I9J0Hgus/hTm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747132467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJDhadod13xdWIV40wX1pnuNXxPWqMNyG93g27zikYU=;
	b=aDgPuz9mvxx+a4PzejitkLiAa0y57irjzRQARH7a6aHIQ/PJKbNNjoQJPLv05q6mju7SPS
	bDL5VjEcTDC3ZiCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96E12137E8;
	Tue, 13 May 2025 10:34:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V+OCJDMgI2h4HwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 May 2025 10:34:27 +0000
Message-ID: <b0daf778-85de-4a4d-b506-fab01ea0395f@suse.cz>
Date: Tue, 13 May 2025 12:34:27 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/7] memcg: move preempt disable to callers of
 memcg_rstat_updated
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
 <20250513031316.2147548-3-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250513031316.2147548-3-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B70F4211DD
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:email,suse.cz:dkim,suse.cz:mid];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action

On 5/13/25 05:13, Shakeel Butt wrote:
> Let's move the explicit preempt disable code to the callers of
> memcg_rstat_updated and also remove the memcg_stats_lock and related
> functions which ensures the callers of stats update functions have
> disabled preemption because now the stats update functions are
> explicitly disabling preemption.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

A welcome cleanup!

Acked-by: Vlastimil Babka <vbabka@suse.cz>


