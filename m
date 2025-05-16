Return-Path: <cgroups+bounces-8228-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1617BAB9911
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 11:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FA550314D
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 09:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22047230BF9;
	Fri, 16 May 2025 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a5/QjHPv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s1HSFUVs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a5/QjHPv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s1HSFUVs"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C193230BED
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388587; cv=none; b=qd/u4FHTVLEazccjafXZ5vVq6o4ysNEnTdwKDBvITP2qffgOLLTmY76T2puAU21SZZGvmEPsPy+FiMih9qS2pa/2ftHyIgjANdQxtRZE4RUr71oQW29RaqihPMEqSlnigruOKjbhEkg+LT1fHsLz+RhrD5n0uc3qcyhTjOEm1qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388587; c=relaxed/simple;
	bh=RPcf8rE/illtLU4XBg4keVfeb7EWgZN+SUx/oGgel1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFFFxSPJILx7Q0pTG1YHa/KJaW/iwcV1FQUmwAnYm1DngCRC0WSFa7W5ew0zsXiRF7JdYS0DowGucIF+3dUQPZGGqUwTqs1uQLAVwKTWQM+wVeppG3KbDUHtbLwb0crOJlc3JfDrm7z+0qcUqRrT2+9NWTu/P/p7lHf5FsQEcug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a5/QjHPv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s1HSFUVs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a5/QjHPv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s1HSFUVs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 860121F7ED;
	Fri, 16 May 2025 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747388584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnGSLuTuPDHBaJa3BHzKadQwMoY8VUpO+ahaXJ4wyv4=;
	b=a5/QjHPvalNF86Ln/xKlczGcVUIolDFcY/mecGE0wPyiZDJ3IO5jFX4ja3LQceun6GiGlh
	n+/PJXnIybYYFOqRcfdxFD7foUsrKU7+2+PNvsvEeliVglkOybb68iRo2CljjuO23IyykU
	dP4+ygRa9mK5SKEERHNHJyIIyN7saug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747388584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnGSLuTuPDHBaJa3BHzKadQwMoY8VUpO+ahaXJ4wyv4=;
	b=s1HSFUVsiJx86SXMGtuAYNa+CwUIrNGrFYJ/w1OAdPKi8qbmrCJgFAfgf43jiIrqWI6PNr
	9S1UE5EuNONxcSCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747388584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnGSLuTuPDHBaJa3BHzKadQwMoY8VUpO+ahaXJ4wyv4=;
	b=a5/QjHPvalNF86Ln/xKlczGcVUIolDFcY/mecGE0wPyiZDJ3IO5jFX4ja3LQceun6GiGlh
	n+/PJXnIybYYFOqRcfdxFD7foUsrKU7+2+PNvsvEeliVglkOybb68iRo2CljjuO23IyykU
	dP4+ygRa9mK5SKEERHNHJyIIyN7saug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747388584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnGSLuTuPDHBaJa3BHzKadQwMoY8VUpO+ahaXJ4wyv4=;
	b=s1HSFUVsiJx86SXMGtuAYNa+CwUIrNGrFYJ/w1OAdPKi8qbmrCJgFAfgf43jiIrqWI6PNr
	9S1UE5EuNONxcSCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6424513977;
	Fri, 16 May 2025 09:43:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VNoKGKgIJ2hUcgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 May 2025 09:43:04 +0000
Message-ID: <e859d24a-4619-4214-a3c5-b547b430e525@suse.cz>
Date: Fri, 16 May 2025 11:43:04 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] memcg: nmi safe memcg stats for specific archs
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
 <20250516064912.1515065-3-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250516064912.1515065-3-shakeel.butt@linux.dev>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:mid,suse.cz:email]
X-Spam-Score: -4.30

On 5/16/25 08:49, Shakeel Butt wrote:
> There are archs which have NMI but does not support this_cpu_* ops
> safely in the nmi context but they support safe atomic ops in nmi
> context. For such archs, let's add infra to use atomic ops for the memcg
> stats which can be updated in nmi.
> 
> At the moment, the memcg stats which get updated in the objcg charging
> path are MEMCG_KMEM, NR_SLAB_RECLAIMABLE_B & NR_SLAB_UNRECLAIMABLE_B.
> Rather than adding support for all memcg stats to be nmi safe, let's
> just add infra to make these three stats nmi safe which this patch is
> doing.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


