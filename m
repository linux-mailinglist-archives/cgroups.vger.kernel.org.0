Return-Path: <cgroups+bounces-8231-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFA1AB993E
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 11:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E8D5031DF
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 09:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3CC23183F;
	Fri, 16 May 2025 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E2LiSY9t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fjtGVKr2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E2LiSY9t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fjtGVKr2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983C022A4FA
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388743; cv=none; b=EKZgzN9xpysjB6wt5awE/iP23G0O2rkSuXAUf0HUauK4WxMHJF3H22j+5BCt5lS0IG7YDbuHu6yEbVXs3TSA8YMr95kxygmaN1fS/XKeVNukDz51M5+D/cDRNFPIWEjykgxejqdpoqbacyzO/SLZYYYYURESjhGNTl600oD9Ljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388743; c=relaxed/simple;
	bh=7Bm6yd3q8eDSmAsfS/jyh5v4JWHukmbzYQSdpoEoWk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4hQY3KECH547zHrKv+6ZCnwMAj0nU+xo1oGW2WD6fnyqPH89YnbfYMxCd8UkC1/93Yn8bIZgxzmm9MG6WucAVPaNFwcRQMuSdCPT6VOQ7zWJtuHJ7GAwbJXGv/wAadHJEQO+ne5ishIP0urMVZaGCu+dOkfxKbk8FayMIP1pmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E2LiSY9t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fjtGVKr2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E2LiSY9t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fjtGVKr2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F1741F809;
	Fri, 16 May 2025 09:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747388739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WpIKKHmGcTGOMiGo191FHS/rzC9luV4pcbmSleL9Ho=;
	b=E2LiSY9t77zhDLEU1dEtdR2SAbSyz4VGtl58X+O5YgnxrT+1L9rxIHXtgrB0gUYWT1RRqq
	GnaxN9s4I6VyB3LdBTDrUYchAzxfRs+IWxvrTn7v37CdXe9R6TkzQWZyH2PBmMNtWKnk4h
	YYX9SJGoyls65x7+RNdnMk6amRaNNMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747388739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WpIKKHmGcTGOMiGo191FHS/rzC9luV4pcbmSleL9Ho=;
	b=fjtGVKr2fc1C6/15gm6kiGUDTtJyh0ooLIMWiEZaKh4n3chdDAihT41/TTk4iW//2o/Mbp
	D6gvzpf0rp2C8SCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=E2LiSY9t;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fjtGVKr2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747388739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WpIKKHmGcTGOMiGo191FHS/rzC9luV4pcbmSleL9Ho=;
	b=E2LiSY9t77zhDLEU1dEtdR2SAbSyz4VGtl58X+O5YgnxrT+1L9rxIHXtgrB0gUYWT1RRqq
	GnaxN9s4I6VyB3LdBTDrUYchAzxfRs+IWxvrTn7v37CdXe9R6TkzQWZyH2PBmMNtWKnk4h
	YYX9SJGoyls65x7+RNdnMk6amRaNNMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747388739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WpIKKHmGcTGOMiGo191FHS/rzC9luV4pcbmSleL9Ho=;
	b=fjtGVKr2fc1C6/15gm6kiGUDTtJyh0ooLIMWiEZaKh4n3chdDAihT41/TTk4iW//2o/Mbp
	D6gvzpf0rp2C8SCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7181613977;
	Fri, 16 May 2025 09:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ACVmG0MJJ2hGcwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 May 2025 09:45:39 +0000
Message-ID: <8114231b-ec06-44a9-9075-9ccf0809de4a@suse.cz>
Date: Fri, 16 May 2025 11:45:39 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] memcg: make memcg_rstat_updated nmi safe
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
 <20250516064912.1515065-6-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250516064912.1515065-6-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8F1741F809
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,linux.dev:email]
X-Rspamd-Action: no action

On 5/16/25 08:49, Shakeel Butt wrote:
> memcg: convert stats_updates to atomic_t

You have two subjects, I guess delete the second one?

> Currently kernel maintains memory related stats updates per-cgroup to
> optimize stats flushing. The stats_updates is defined as atomic64_t
> which is not nmi-safe on some archs. Actually we don't really need 64bit
> atomic as the max value stats_updates can get should be less than
> nr_cpus * MEMCG_CHARGE_BATCH. A normal atomic_t should suffice.
> 
> Also the function cgroup_rstat_updated() is still not nmi-safe but there
> is parallel effort to make it nmi-safe, so until then let's ignore it in
> the nmi context.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


