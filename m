Return-Path: <cgroups+bounces-13157-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50036D19583
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 15:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D437300A3C0
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 14:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D3392C52;
	Tue, 13 Jan 2026 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yHRxIc+g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aH0TFDY2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yHRxIc+g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aH0TFDY2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FF4392C29
	for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313625; cv=none; b=p3tP6PxrlQ8ZlH/QbDofScO3gxgg7s9OmxPeF48C1tt0MFpRIfj6s2sbqs7bh9dxXHpXcqWBYHkbH0gFQzPtzeseOghfx5MMMv/wWTpFg6oX6qDZLkN+3CcNFf2rxnEFYz6yoOY5zEYMPe+fjvGvfeGtXK6n2tiysiBjOP8PlvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313625; c=relaxed/simple;
	bh=d3ej2TsteXeZKg8yUqSYs5JeHy10lEv1wGS+YEfi3mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+s0K+9lps6Wt0pUWsilX5c4h9Ph9s1kEkQp/SXmhCfn5eEVpMFpSmXpmmb01r8bCdzOp3R7lHwHMQ0EVKEE72AUMRp14qM/R2uJFUqT7kEdi8gIBsD9izii5KhknhuRjE+4ojTLzLxUkN5lhuWrue4y2/vTR0w7GcHjuGKVaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yHRxIc+g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aH0TFDY2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yHRxIc+g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aH0TFDY2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44A975BCCA;
	Tue, 13 Jan 2026 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768313622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewxiBRrNZaYohALbXtEzfnX/Vk+Fw/hKhgUAJ9escIc=;
	b=yHRxIc+gpCkX+kfXAPT/3p6zxCILpG5kw/9eLTT/KEp292/gn8MUwH2N/xzuNAohC4ArJM
	pylQ7/VpyV/Gv6U1OUO95fB2TQBmkoHZ2ha+O2p6hRfDwfnhXy1MX79tENIHdqiS3pYg+4
	+zcyMrBm+T/PQd3RNYhI4spv2Bnp5+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768313622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewxiBRrNZaYohALbXtEzfnX/Vk+Fw/hKhgUAJ9escIc=;
	b=aH0TFDY2S9oiLF/n9wDe+TChe6XDp2NllgSzFUlmgPcoXdO2XLCZP2UmckScBeKJwzM3Dr
	bqAxUPCr5JdMt9AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768313622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewxiBRrNZaYohALbXtEzfnX/Vk+Fw/hKhgUAJ9escIc=;
	b=yHRxIc+gpCkX+kfXAPT/3p6zxCILpG5kw/9eLTT/KEp292/gn8MUwH2N/xzuNAohC4ArJM
	pylQ7/VpyV/Gv6U1OUO95fB2TQBmkoHZ2ha+O2p6hRfDwfnhXy1MX79tENIHdqiS3pYg+4
	+zcyMrBm+T/PQd3RNYhI4spv2Bnp5+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768313622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewxiBRrNZaYohALbXtEzfnX/Vk+Fw/hKhgUAJ9escIc=;
	b=aH0TFDY2S9oiLF/n9wDe+TChe6XDp2NllgSzFUlmgPcoXdO2XLCZP2UmckScBeKJwzM3Dr
	bqAxUPCr5JdMt9AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29E0E3EA63;
	Tue, 13 Jan 2026 14:13:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wn37CRZTZmkqPwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 Jan 2026 14:13:42 +0000
Message-ID: <11e83aa3-0ebb-44ad-b814-a76fd244cbf1@suse.cz>
Date: Tue, 13 Jan 2026 15:13:41 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 0/9] mm/slab: reduce slab accounting memory overhead by
 allocating slabobj_ext metadata within unsed slab space
To: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org
Cc: andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com,
 glider@google.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com,
 roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, shakeel.butt@linux.dev,
 surenb@google.com, vincenzo.frascino@arm.com, yeoreum.yun@arm.com,
 tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, hao.li@linux.dev
References: <20260113061845.159790-1-harry.yoo@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20260113061845.159790-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,gentwo.org,google.com,cmpxchg.org,kvack.org,kernel.org,linux.dev,arm.com,mit.edu,dilger.ca,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

On 1/13/26 7:18 AM, Harry Yoo wrote:
> V5: https://lore.kernel.org/linux-mm/20260105080230.13171-1-harry.yoo@oracle.com
> V5 -> V6:
> 
> - Patch 1: Added Closes: tag for related discussion (Vlastimil)
>   https://lore.kernel.org/linux-mm/1372138e-5837-4634-81de-447a1ef0a5ad@suse.cz
> 
> - Patch 3: Addressed Vlastimil's comments
>   https://lore.kernel.org/linux-mm/e28c08e4-5048-429b-97a0-8d51e494efcd@suse.cz
> 
> - Patch 4: Fixed incorrect function prototype of slab_obj_ext() on
>   !CONFIG_SLAB_OBJ_EXT builds and kept pointer type in
>   free_slab_obj_exts() (Hao, Vlastimil)
>   https://lore.kernel.org/linux-mm/n6kyluk3nahdxytwek4ijzy4en6mc6ps7fjjgftww4ith7llom@cijm4who24w2
>   https://lore.kernel.org/linux-mm/473d479c-4eae-4589-b8c2-e2a29e8e6bc1@suse.cz
> 
> - Patch 7, 9: Rewrote obj_exts_in_slab() to check if the pointer is within the
>   slab's range, and distinguish by stride (Vlastimil)
>   https://lore.kernel.org/linux-mm/644e163d-edd9-4128-9516-0f70a25526df@suse.cz
> 
> - Patch 9: Fixed potentioal memory leak due to incorrect impl. of
>   obj_exts_in_object() (Vlastimil)
>   https://lore.kernel.org/linux-mm/8c67dcbe-f393-4da6-8d24-f9da79c246c4@suse.cz/
> 
> - Patch 9: Fixed incorrect ksize() implementation (Hao)
>   https://lore.kernel.org/linux-mm/fgx3lapibabra4x7tewx55nuvxz235ruvm3agpprjbdcmt3rc6@h54ln5tfdssz

Merged to slab/for-7.0/obj_metadata and slab/for-next, thanks!


