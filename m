Return-Path: <cgroups+bounces-6927-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA83A5914A
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 11:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6309188B8C5
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 10:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D15918C011;
	Mon, 10 Mar 2025 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZMTtmDnt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gbicgfoi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZMTtmDnt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gbicgfoi"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD21E226870
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602895; cv=none; b=KzyUUFKan6dpY+lxh2IRTCUGSOouQrN4DCNDv8i6P0ZfAMZLRj2VCGHTdTXfLHaLuF4+bb45ttopAJ4Qml4UartVL+Wn2FqDul5FjGS+DxjbXCOandM/ie7B2xWcfrj2qCdrwmOcAn8OTpSTl0v8kruzvy0xLHyIpOFc9HIn148=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602895; c=relaxed/simple;
	bh=YrX9G7xY0k+NAn/Dv4bTyGCRHEHkgd21+90hLoFAOGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahgPsAAkPa3nQQFSbXzXqRPEKhG9L7GXvpqR4eFQQWeumKoFC6ThWxhxOxvKDBfqz474i29SSB/8uGB1wujBPqSiQN4gyqyUbR4gW761WeugC/0CoqqGnNiUD/nk5KXYA1vWQNP4JnAK3Tgp0Np9LguvNLfdi2ibtamTlRjfDUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZMTtmDnt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gbicgfoi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZMTtmDnt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gbicgfoi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 019A71F445;
	Mon, 10 Mar 2025 10:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741602892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OL2Jtr+IMvqvjb/CMqGeFxXeoZIVlzRqDlmMZHJ67DU=;
	b=ZMTtmDntJKGla57oONxZ0+Pdq+lZoSe5Rf0lth9XsjwkfhXf6zw+548dfazGD/LuGiAxxV
	Dl5d3qOVtvNdepm26CCudlOQ9RAo8WtEq3QhW36j+1hg/uQlWKEC+Y4AVMRGCwHddXBB0L
	aGvo5V/tlfWzq+dl7BraKaAuMdOd89I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741602892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OL2Jtr+IMvqvjb/CMqGeFxXeoZIVlzRqDlmMZHJ67DU=;
	b=Gbicgfoig8XzczVnYMHuER/2RSfIILVvVlLhPndHz9LPIUswyLLSETTsrH7Phei9aXTDHC
	+bjCDJQCc9zq1iDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741602892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OL2Jtr+IMvqvjb/CMqGeFxXeoZIVlzRqDlmMZHJ67DU=;
	b=ZMTtmDntJKGla57oONxZ0+Pdq+lZoSe5Rf0lth9XsjwkfhXf6zw+548dfazGD/LuGiAxxV
	Dl5d3qOVtvNdepm26CCudlOQ9RAo8WtEq3QhW36j+1hg/uQlWKEC+Y4AVMRGCwHddXBB0L
	aGvo5V/tlfWzq+dl7BraKaAuMdOd89I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741602892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OL2Jtr+IMvqvjb/CMqGeFxXeoZIVlzRqDlmMZHJ67DU=;
	b=Gbicgfoig8XzczVnYMHuER/2RSfIILVvVlLhPndHz9LPIUswyLLSETTsrH7Phei9aXTDHC
	+bjCDJQCc9zq1iDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E20C6139E7;
	Mon, 10 Mar 2025 10:34:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rfXcNkvAzmczawAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Mar 2025 10:34:51 +0000
Message-ID: <a30e2c60-e01b-4eac-8a40-e7a73abebfd3@suse.cz>
Date: Mon, 10 Mar 2025 11:34:51 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [memcg] 01d37228d3: netperf.Throughput_Mbps
 37.9% regression
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, oe-lkp@lists.linux.dev,
 kbuild test robot <lkp@intel.com>, Michal Hocko <mhocko@suse.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>
References: <202503101254.cfd454df-lkp@intel.com>
 <7c41d8d7-7d5a-4c3d-97b3-23642e376ff9@suse.cz>
 <CAADnVQ+NKZtNxS+jBW=tMnmca18S2jfuGCR+ap1bPHYyhxy6HQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAADnVQ+NKZtNxS+jBW=tMnmca18S2jfuGCR+ap1bPHYyhxy6HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 3/10/25 11:18, Alexei Starovoitov wrote:
>> because this will affect the refill even if consume_stock() fails not due to
>> a trylock failure (which should not be happening), but also just because the
>> stock was of a wrong memcg or depleted. So in the nowait context we deny the
>> refill even if we have the memory. Attached patch could be used to see if it
>> if fixes things. I'm not sure about the testcases where it doesn't look like
>> nowait context would be used though, let's see.
> 
> Not quite.
> GFP_NOWAIT includes __GFP_KSWAPD_RECLAIM,
> so gfpflags_allow_spinning() will return true.

Uh right, it's the new gfpflags_allow_spinning(), not the
gfpflags_allow_blocking() I'm used to and implicitly assumed, sorry.

But then it's very simple because it has a bug:
gfpflags_allow_spinning() does

return !(gfp_flags & __GFP_RECLAIM);

should be !!


