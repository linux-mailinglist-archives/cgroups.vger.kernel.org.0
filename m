Return-Path: <cgroups+bounces-7952-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B29AAA4B1A
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 14:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702D97BBBFE
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 12:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963EF253F32;
	Wed, 30 Apr 2025 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V2UpSzfa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hCXx4fFh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uU/XDOlP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H4SlGNt3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B11DF25A
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015976; cv=none; b=In4zl9oqP8QMyApVcZRSIcbSgMCaIY8+lcrlQwE2VLx7bOFlgFDlvHeKaRFP2/hG0Zt00b9ZguPLEKgau31jvpCkNW3iLdFPCQLcs2952SHsd5QLJ1VovjM6P8btwkpd2S45ZKy1ThpWl8Kt0mkgLWhxKPWxSb3PzW4p4b8wPps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015976; c=relaxed/simple;
	bh=YMzETgjDji9IBqxi3AJIqogNPK3rCWR7xLHGOD6pIMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrBrmIpVMA85UtergBFLbMze9QeLhuQMjGkANPVBBFpp6FKfacMsVO5aH94W0UNKl3csJ5KpoeEFJmLiLi308WZrLa2tSYhpPNxksbX0NdvsjKlYsZtqVVKu6xAzfEc1brmqc/+jofau3CYFp4IdhmGr75WEAyDgo9c/Lnf6uHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V2UpSzfa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hCXx4fFh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uU/XDOlP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H4SlGNt3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D17481F449;
	Wed, 30 Apr 2025 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746015973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gY9W9ZPcorYk3BZB9sftT//K8NCsGTdu0UYiorZFpHo=;
	b=V2UpSzfa1B/GIwv4L+6EHheZCuaf/GQsh63ETA/WnPmwk81JPV0sfjE4H1rVyF65/+UuHp
	xj/e62ue1rouiYVv0oV9xYbHRR+8eparGQQpJ2sHpUDroaE9PXuHMeOkHE8hXDTtGBJ6ZB
	wmxkx8Pq+2DLTyoTzplrTMd0WX+AUqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746015973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gY9W9ZPcorYk3BZB9sftT//K8NCsGTdu0UYiorZFpHo=;
	b=hCXx4fFh26zP2Noo9M4RX6/tGgavOhftxFlGA8KfRd+ResFH6rjqerDuMg6WzzAnwwvG26
	cseYO3hn3ICvJZBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="uU/XDOlP";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=H4SlGNt3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746015972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gY9W9ZPcorYk3BZB9sftT//K8NCsGTdu0UYiorZFpHo=;
	b=uU/XDOlPFmCfherreyEfiVjx51RoC12sXp0K+qbGj1LawDte1K5obBg2d28xoVPbtQkKDS
	I5i5SkyIm95qgTS77R8hf9t8Enj0JTkLB3kVigNBA9mTp5xSGSraI914oKlXG9AuhmEQXD
	zliOF4WyJzoQYNY8LOooL2dBpijOKUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746015972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gY9W9ZPcorYk3BZB9sftT//K8NCsGTdu0UYiorZFpHo=;
	b=H4SlGNt3URQyUwi0/LIzGHFtG/42R1p4I+7/W/4OBk0vst9y2sZAA07IAnbITy6cF0ixCQ
	cknZPuCgUZIQtMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC6B7139E7;
	Wed, 30 Apr 2025 12:26:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id //KbLeQWEmhdXgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 30 Apr 2025 12:26:12 +0000
Message-ID: <69871de2-af48-4ce9-9612-f87132337a84@suse.cz>
Date: Wed, 30 Apr 2025 14:26:12 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] memcg: no irq disable for memcg stock lock
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250429230428.1935619-1-shakeel.butt@linux.dev>
 <20250429230428.1935619-5-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250429230428.1935619-5-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D17481F449
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/30/25 01:04, Shakeel Butt wrote:
> There is no need to disable irqs to use memcg per-cpu stock, so let's
> just not do that. One consequence of this change is if the kernel while
> in task context has the memcg stock lock and that cpu got interrupted.
> The memcg charges on that cpu in the irq context will take the slow path
> of memcg charging. However that should be super rare and should be fine
> in general.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


