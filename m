Return-Path: <cgroups+bounces-6929-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA433A5922F
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 12:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0577A3137
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 11:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1A6226D04;
	Mon, 10 Mar 2025 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YK5RY8ye";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+pFF7HOj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hS8yxrDz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7SeOIjCw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87417A2E7
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604618; cv=none; b=ALoyLHoc3h5RskRyxAc/gsaB0/wqrSxv4WMtlMp73AjByuLj3n87TRIUUzds4j4rRY3I/Eg7GzEqhW+iARY/e578obR0ZylsoHnEItVpamqEa3FZG5qwysW6S8N+83QrBJo/ip1hdsE9ZEXijkhQnKX2mYjwvZpcrJaxoWTSPTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604618; c=relaxed/simple;
	bh=0qhwJrWnliClWx/mbHEwSY+mxZKahmyDZmGlrljvN3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h81NRe9yYtMwvx8KpWCi71xOG7Uuc5DEFBx+DvIqSZDZbFigsoIg/14/jADdn1Fr2tlFMPpeMSYSu3UXk7JwEGB2r+IItOxvMN3eLxHSVqc7b/7/jsz2NXvNncjgaEvhuzzCd/qiNCNz02S8fdLEi72rp9wLG9M+hooBztayTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YK5RY8ye; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+pFF7HOj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hS8yxrDz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7SeOIjCw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF1D21F441;
	Mon, 10 Mar 2025 11:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741604615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWokT2IM8sYu7FZhG0F0lhGI2QCoe6MEh1ZciFacqfk=;
	b=YK5RY8yeI0XFeY+JEp8bdCLCzPDSmOK8H+woesKqLcNlJYnn8vLTpHeE359baqlnXo3AUX
	xUOhs0sx1j0aF0t6WWuw61Cg+Rvh7h0LptzGFzs5iQtJvwidbxbBTTCfAhOokWpq9CzPzG
	dhefgmLN6mtK1B2jPTGGXsavfy3Lz0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741604615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWokT2IM8sYu7FZhG0F0lhGI2QCoe6MEh1ZciFacqfk=;
	b=+pFF7HOjl8tMgaF65QVGAGnNkCPCASjsj3XfWzwTimAH/LmMRgPufx0IYr3oEour+qSzVs
	8aYDMR9rbQ2mU1Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hS8yxrDz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7SeOIjCw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741604614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWokT2IM8sYu7FZhG0F0lhGI2QCoe6MEh1ZciFacqfk=;
	b=hS8yxrDzaevWgM4q6jLS+Y7TyjdhV8sLQKKk7HwKNv/9F/jM20BFfyD0qiVWUSej9MMFl9
	ShruwSH5ueOtsze0NuND/4bITypcodOYcLrc8viULv96mBNRmnahrZzzkbSmRD0AoHMk4J
	AFkXDZNxUlsaqGoBdFuLDW4IXiLXECA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741604614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWokT2IM8sYu7FZhG0F0lhGI2QCoe6MEh1ZciFacqfk=;
	b=7SeOIjCwy/X/bgvcCBOH3pbrEHTQnrkBMGOpqKiw/Zgkx1tSj0ch/G46ck1IayTqFF0J2/
	qziexklndTh8/QAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7D11139E7;
	Mon, 10 Mar 2025 11:03:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bXVHNAbHzmfbdAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 10 Mar 2025 11:03:34 +0000
Message-ID: <9d8f5f92-5f4b-4732-af48-3ecaa41af81a@suse.cz>
Date: Mon, 10 Mar 2025 12:03:34 +0100
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
 <a30e2c60-e01b-4eac-8a40-e7a73abebfd3@suse.cz>
 <CAADnVQ+g=VN6cOVzhF2ory0isXEc52W8fKx4KdwpYfOMvk372A@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAADnVQ+g=VN6cOVzhF2ory0isXEc52W8fKx4KdwpYfOMvk372A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EF1D21F441
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 3/10/25 11:56, Alexei Starovoitov wrote:
> On Mon, Mar 10, 2025 at 11:34 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 3/10/25 11:18, Alexei Starovoitov wrote:
>> >> because this will affect the refill even if consume_stock() fails not due to
>> >> a trylock failure (which should not be happening), but also just because the
>> >> stock was of a wrong memcg or depleted. So in the nowait context we deny the
>> >> refill even if we have the memory. Attached patch could be used to see if it
>> >> if fixes things. I'm not sure about the testcases where it doesn't look like
>> >> nowait context would be used though, let's see.
>> >
>> > Not quite.
>> > GFP_NOWAIT includes __GFP_KSWAPD_RECLAIM,
>> > so gfpflags_allow_spinning() will return true.
>>
>> Uh right, it's the new gfpflags_allow_spinning(), not the
>> gfpflags_allow_blocking() I'm used to and implicitly assumed, sorry.
>>
>> But then it's very simple because it has a bug:
>> gfpflags_allow_spinning() does
>>
>> return !(gfp_flags & __GFP_RECLAIM);
>>
>> should be !!
> 
> Ouch.
> So I accidentally exposed the whole linux-next to this stress testing
> of new trylock facilities :(
> But the silver lining is that this is the only thing that blew up :)
> Could you send a patch or I will do it later today.

OK
----8<----
From 69b3d1631645c82d9d88f17fb01184d24034df2b Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 10 Mar 2025 11:57:52 +0100
Subject: [PATCH] mm: Fix the flipped condition in gfpflags_allow_spinning()

The function gfpflags_allow_spinning() has a bug that makes it return
the opposite result than intended. This could contribute to deadlocks as
usage profilerates, for now it was noticed as a performance regression
due to try_charge_memcg() not refilling memcg stock when it could. Fix
the flipped condition.

Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202503101254.cfd454df-lkp@intel.com

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/gfp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index ceb226c2e25c..c9fa6309c903 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -55,7 +55,7 @@ static inline bool gfpflags_allow_spinning(const gfp_t gfp_flags)
 	 * regular page allocator doesn't fully support this
 	 * allocation mode.
 	 */
-	return !(gfp_flags & __GFP_RECLAIM);
+	return !!(gfp_flags & __GFP_RECLAIM);
 }
 
 #ifdef CONFIG_HIGHMEM
-- 
2.48.1



