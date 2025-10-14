Return-Path: <cgroups+bounces-10751-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FAFBDB576
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 22:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C671353D14
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 20:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CB7308F19;
	Tue, 14 Oct 2025 20:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oGN+o8wC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cOtFzaah";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oGN+o8wC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cOtFzaah"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38754307AEC
	for <cgroups@vger.kernel.org>; Tue, 14 Oct 2025 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475510; cv=none; b=h8NNvnpZog8NX//wHRffr0W30D3b9u/u2lpXgM3XhI/cWzHtEhqY5E8h3N/PGOZeI+GloVJuLsEyMgBs69sJIFzswqouM0Y/SUmdVlBkKiV102UxsuM0/RY9DimunUNn4p1w8t9hvKFX4JtvPOhLnsKOqEvp0wQOJi2Frcghyy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475510; c=relaxed/simple;
	bh=TuLg/DGmouszRmZ2rOSPnZXOUg/MWqLAuMt9krc9L2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSxo+498G2Om5ZN4XXQ5iEgzdUrzcQlj0Zcth1FrJv2Wrd1UcNfcPtP5KA5Wp5GbBMdwe/Q3twdGG1IihaEe1CDy2ixlnkP588y5Js+QLTkeLmXY79EEJV6ASvt86XYA5tuHfhexT2OFQMD8KursxQiIbJf8zouwhtKWOe6P7lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oGN+o8wC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cOtFzaah; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oGN+o8wC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cOtFzaah; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26E7921D3A;
	Tue, 14 Oct 2025 20:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760475506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wO2GtN18Qmp1TJ+fhrVaxDRydqucSSBXteFXigvaals=;
	b=oGN+o8wCTZu50UFQiLJIUPnZriYTW67WZz/JqznCfBnaO5glSd4yF0o28DPxvDQtFcpNyw
	UvnQ5YOus1AucermzoR+QMm7MZQKiQeSDmHyj3UPLGgrVRkOcPLDVmyJzEOd74t+i8J1gT
	I3CMYWBXuLtT2QGB1M2hLHQfXl2Wsk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760475506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wO2GtN18Qmp1TJ+fhrVaxDRydqucSSBXteFXigvaals=;
	b=cOtFzaahIYrB+AYOJaPPs5jYup7eSOMfh94OTroNz/Y922AC/yGFaRKKZnNhFsXMAkWJ02
	R4ROTZBGOxz3/zAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oGN+o8wC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cOtFzaah
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760475506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wO2GtN18Qmp1TJ+fhrVaxDRydqucSSBXteFXigvaals=;
	b=oGN+o8wCTZu50UFQiLJIUPnZriYTW67WZz/JqznCfBnaO5glSd4yF0o28DPxvDQtFcpNyw
	UvnQ5YOus1AucermzoR+QMm7MZQKiQeSDmHyj3UPLGgrVRkOcPLDVmyJzEOd74t+i8J1gT
	I3CMYWBXuLtT2QGB1M2hLHQfXl2Wsk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760475506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wO2GtN18Qmp1TJ+fhrVaxDRydqucSSBXteFXigvaals=;
	b=cOtFzaahIYrB+AYOJaPPs5jYup7eSOMfh94OTroNz/Y922AC/yGFaRKKZnNhFsXMAkWJ02
	R4ROTZBGOxz3/zAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AC2913A44;
	Tue, 14 Oct 2025 20:58:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PYpSAnK57mh9cAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 14 Oct 2025 20:58:26 +0000
Message-ID: <df175b09-c0db-4dc3-a0de-e1c38f70147d@suse.cz>
Date: Tue, 14 Oct 2025 22:58:25 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] slab: Add check for memcg_data != OBJEXTS_ALLOC_FAIL
 in folio_memcg_kmem
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>
Cc: Hao Ge <hao.ge@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>, David Hildenbrand <david@redhat.com>
References: <20251014152751.499376-1-hao.ge@linux.dev>
 <CAJuCfpGBxUmvWoe2xv2-bsF+TY4fK-m1-Z_E3OcyTiSYz5KeAA@mail.gmail.com>
 <vdngz65wojqalim4xb6vxb6k7upbzmkfoogmbuswc4lowju3ke@32hgwjlzxibr>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <vdngz65wojqalim4xb6vxb6k7upbzmkfoogmbuswc4lowju3ke@32hgwjlzxibr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 26E7921D3A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,oracle.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:mid,suse.cz:dkim,oracle.com:email,linux.dev:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,kylinos.cn:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 10/14/25 22:14, Shakeel Butt wrote:
> On Tue, Oct 14, 2025 at 09:12:43AM -0700, Suren Baghdasaryan wrote:
>> On Tue, Oct 14, 2025 at 8:28 AM Hao Ge <hao.ge@linux.dev> wrote:
>> >
>> > From: Hao Ge <gehao@kylinos.cn>
>> >
>> > Since OBJEXTS_ALLOC_FAIL and MEMCG_DATA_OBJEXTS currently share
>> > the same bit position, we cannot determine whether memcg_data still
>> > points to the slabobj_ext vector simply by checking
>> > folio->memcg_data & MEMCG_DATA_OBJEXTS.
>> >
>> > If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
>> > and during the release of the associated folio, the BUG check is triggered
>> > because it was mistakenly assumed that a valid folio->memcg_data
>> > was not cleared before freeing the folio.
>> >
>> > So let's check for memcg_data != OBJEXTS_ALLOC_FAIL in folio_memcg_kmem.
>> >
>> > Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
>> > Suggested-by: Harry Yoo <harry.yoo@oracle.com>
>> > Signed-off-by: Hao Ge <gehao@kylinos.cn>
>> 
>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>> 
>> nit: I think it would be helpful if the changelog explained why we
>> need the additional check. We can have the same bit set in two
>> different situations:
>> 1. object extension vector allocation failure;
>> 2. memcg_data pointing to a valid mem_cgroup.
>> To distinguish between them, we need to check not only the bit itself
>> but also the rest of this field. If the rest is NULL, we have case 1,
>> otherwise case 2.
> 
> With Suren's suggestion, you can add:
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks, I added Suren's suggestion and pushed to slab/for-next-fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/?h=slab/for-next-fixes&id=711c435c89e59ee32bf8bb1c0d875a07931da5a8

Resisted the impulse to change the single VM_BUG_ON_FOLIO to
VM_WARN_ON_ONCE_FOLIO because we're still going to do that systematically,
right?

