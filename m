Return-Path: <cgroups+bounces-7064-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44106A60E28
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 11:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871EF3B1AD5
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DE11F2B8E;
	Fri, 14 Mar 2025 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y+MtLR9N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5uSpDDgx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HMxevyR/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JvLwXEWS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3611DF982
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946711; cv=none; b=YmrMQ+T88RRT9nGLGBRWmojXICIBPrhgItR9aPEy/S/UA4TjtMy2lsJ0oQyBAI3Y1YIvRjrBfvYNiLXnGjx96jos+G6cuwTequ8V2UMUUMMeft9IFWZn+MojtwBAtf+yfbemSGmpqJXpKB1gAQpkQyW9t/w3Ka+GF7c5cYheuDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946711; c=relaxed/simple;
	bh=UQWINJ4CdevpiBSS+OTgu5mvF4TXtRTWjgyqesjcjPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apv9kZCzT+W2LswjPpTvymkJECdYxNDlrJ6CDZfZlZQoYesl5k6wPqYPhZW6KqfxxKPTyzrdUIPe2fbUXH4A9ibS4iLgFNEon595IOOCgWg3N5kelIr4eII8b4kritZ0ZDfzAADHBruHtXie34gxq+dq+2nznUZ9r4Lb7lZsn9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y+MtLR9N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5uSpDDgx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HMxevyR/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JvLwXEWS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 18A771F388;
	Fri, 14 Mar 2025 10:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741946708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SfNg2EeQpKFTm9tPZnHwRNJhdpvIPoW38HrLlADOjV0=;
	b=Y+MtLR9NdgkXG4fd4Y6eEX4aduznf0WoYWGA6N2h0eNYRc/SO1bUvq3mTPKuHQXR45g20j
	caA9zO8WOPlCZGljC0HIk0mYKg64qxihtyfdzEdbO+YSOPqlqrTTz/de9yqNSS4jsV6gbv
	a5dFMHXr8/81gQkTaoOe29Yr+0WSq8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741946708;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SfNg2EeQpKFTm9tPZnHwRNJhdpvIPoW38HrLlADOjV0=;
	b=5uSpDDgx+RIJCzvgAIuTtrVOfR6ncz1XlFBkYWlTbNJ7Fbjsnnd9va7Rx/NOOnkIenJsRb
	UMXAmrF6JRQTsgAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741946707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SfNg2EeQpKFTm9tPZnHwRNJhdpvIPoW38HrLlADOjV0=;
	b=HMxevyR/6v47cDwzOp3/itjNmsqRxb62tCVB9BO6Od8sbknDKr2dghfbRv+dFjfCZCj6+6
	BCuOHGdFhj5OdMJmr0IcIuXYG2dr8HAraoZJ213yG3kLvMTlfeQ0vaOYF3G5MDQp0xG9sc
	E740f5IN+n3NqZ4gLhbV4RHAdhlKYi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741946707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SfNg2EeQpKFTm9tPZnHwRNJhdpvIPoW38HrLlADOjV0=;
	b=JvLwXEWSY/12HAQ4bhS3iiJLXnjEeEBuMK5S7P0iFomo8QHSKaJMeQ/VeqteDsC8od35/A
	2Dr0m13HfSJUCVBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01A5013A31;
	Fri, 14 Mar 2025 10:05:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3CIZAFP/02dBXgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Mar 2025 10:05:07 +0000
Message-ID: <e8cdee82-0a6a-4e7d-a9bf-dec475d49a84@suse.cz>
Date: Fri, 14 Mar 2025 11:05:06 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/10] memcg: manually inline __refill_stock
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-5-shakeel.butt@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250314061511.1308152-5-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,linux.dev:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 3/14/25 07:15, Shakeel Butt wrote:
> There are no more multiple callers of __refill_stock(), so simply inline
> it to refill_stock().
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


