Return-Path: <cgroups+bounces-14671-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C2XBkaHqWki+gAAu9opvQ
	(envelope-from <cgroups+bounces-14671-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 14:38:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 187A6212A6E
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 14:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFA6A302F210
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 13:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6384B3783D6;
	Thu,  5 Mar 2026 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GlXtjOuJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ckrEx+v1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v0vJbOVq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SjaIV6rV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D282020C477
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717888; cv=none; b=pnnLkgX5EpWLyag9nfJM0A/9K0pb4VD32R1DXCouhG69YHgk99Wl7w/sxXiGnGbFffaXqM56povN7lIL5qEZjCNBh1+/3aLEs2WWkiENHDkqLJ+oTdC2uXrFubcFIUSKGFbti1SnE1E87FQiOS0HF7rffeES/CQpzhdreervH5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717888; c=relaxed/simple;
	bh=pIpO7p3o/WufW9ELDK5IPQz5a/y2S8zLtUjxuagE0n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGPTUlDjdBgz4ZO9XQCwlRRfJn+sroC9iQlVh8YCvaemHiG7LMOEm+wtOyNZvixcNg3+0yW0odsYGfgdAOPiv/DeFqy0WebJQJ5g4pzWCniIdJ0XKD5WJQ+by0UhSuranqkAidnV+ECopojNp+dyO1eUlO/Xn4/Ko4uhGeQTfpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GlXtjOuJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ckrEx+v1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v0vJbOVq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SjaIV6rV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ABED43F845;
	Thu,  5 Mar 2026 13:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772717885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWiaf7JHO1yQMIZzhMHLzk5TF56RcSb1mn/7GtkevQw=;
	b=GlXtjOuJ0gwKMbkRVxjztv//Fwp7K3jYaYoqTR5jDj9m+rQ14tLrSTxCL3L2U1lz1MipS9
	pl03zkn4U31TBoU7ZIiz85NUyfZriKCL/XqIodWGnjsFbYs7U5FKvS6ZHJponkh499KykW
	XFEuTFJ6BjKFGbODYUpT4IncSZOumZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772717885;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWiaf7JHO1yQMIZzhMHLzk5TF56RcSb1mn/7GtkevQw=;
	b=ckrEx+v1zHHWCzgxKE788tHF/BtxC67UTkHevytiMBoQVaTUwa+oyh0tUd0QAMwZX28auY
	8HGFL5ePAx/Y4IDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=v0vJbOVq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SjaIV6rV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772717883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWiaf7JHO1yQMIZzhMHLzk5TF56RcSb1mn/7GtkevQw=;
	b=v0vJbOVqnQsz8U+MYjT84HjrJ5DFz1kpjm/wALajLHEsfHjFqoQbJQ84r8VLRcDt2Y+ir7
	kfu0+G+L2jYkeWPAIA+sI/geyx+2TEFPejRqGUt8gWf4sIcNNG1Pwmv7bgU8ACc62lBdfp
	DMbuxqyvjSkS56aHnPO8NOZEaGTILBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772717883;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWiaf7JHO1yQMIZzhMHLzk5TF56RcSb1mn/7GtkevQw=;
	b=SjaIV6rV0Y18j2O930WQqY4c/J45JieRbwT412/J9nFJGxy0kbU7KZJ/kEBxtSeQJPqiW+
	PsKZKb+HZXrtTqDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B186C3EA68;
	Thu,  5 Mar 2026 13:38:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7MYHKDqHqWloPgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 05 Mar 2026 13:38:02 +0000
Date: Thu, 5 Mar 2026 13:38:00 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	cl@gentwo.org, hannes@cmpxchg.org, hao.li@linux.dev, linux-mm@kvack.org, 
	mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, surenb@google.com, 
	venkat88@linux.ibm.com
Subject: Re: [PATCH] mm/slab: change stride type from unsigned short to
 unsigned int
Message-ID: <koh6zoceul7tixkkup7f5vfhfsuzeidra66qrfmojh2izt2epm@aryxsv62nfft>
References: <20260303135722.2680521-1-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303135722.2680521-1-harry.yoo@oracle.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 187A6212A6E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14671-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.de:dkim,suse.de:email,oracle.com:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 10:57:22PM +0900, Harry Yoo wrote:
> Commit 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
> defined the type of slab->stride as unsigned short, because the author
> initially planned to store stride within the lower 16 bits of the
> page_type field, but later stored it in unused bits in the counters
> field instead.
> 
> However, the idea of having only 2-byte stride turned out to be a
> serious mistake. On systems with 64k pages, order-1 pages are 128k,
> which is larger than USHRT_MAX. It triggers a debug warning because
> s->size is 128k while stride, truncated to 2 bytes, becomes zero:
> 
>   ------------[ cut here ]------------
>   Warning! stride (0) != s->size (131072)
>   WARNING: mm/slub.c:2231 at alloc_slab_obj_exts_early.constprop.0+0x524/0x534, CPU#6: systemd-sysctl/307
>   Modules linked in:
>   CPU: 6 UID: 0 PID: 307 Comm: systemd-sysctl Not tainted 7.0.0-rc1+ #6 PREEMPTLAZY
>   Hardware name: IBM,9009-22A POWER9 (architected) 0x4e0202 0xf000005 of:IBM,FW950.E0 (VL950_179) hv:phyp pSeries
>   NIP:  c0000000008a9ac0 LR: c0000000008a9abc CTR: 0000000000000000
>   REGS: c0000000141f7390 TRAP: 0700   Not tainted  (7.0.0-rc1+)
>   MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28004400  XER: 00000005
>   CFAR: c000000000279318 IRQMASK: 0
>   GPR00: c0000000008a9abc c0000000141f7630 c00000000252a300 c00000001427b200
>   GPR04: 0000000000000004 0000000000000000 c000000000278fd0 0000000000000000
>   GPR08: fffffffffffe0000 0000000000000000 0000000000000000 0000000022004400
>   GPR12: c000000000f644b0 c000000017ff8f00 0000000000000000 0000000000000000
>   GPR16: 0000000000000000 c0000000141f7aa0 0000000000000000 c0000000141f7a88
>   GPR20: 0000000000000000 0000000000400cc0 ffffffffffffffff c00000001427b180
>   GPR24: 0000000000000004 00000000000c0cc0 c000000004e89a20 c00000005de90011
>   GPR28: 0000000000010010 c00000005df00000 c000000006017f80 c00c000000177a00
>   NIP [c0000000008a9ac0] alloc_slab_obj_exts_early.constprop.0+0x524/0x534
>   LR [c0000000008a9abc] alloc_slab_obj_exts_early.constprop.0+0x520/0x534
>   Call Trace:
>   [c0000000141f7630] [c0000000008a9abc] alloc_slab_obj_exts_early.constprop.0+0x520/0x534 (unreliable)
>   [c0000000141f76c0] [c0000000008aafbc] allocate_slab+0x154/0x94c
>   [c0000000141f7760] [c0000000008b41c0] refill_objects+0x124/0x16c
>   [c0000000141f77c0] [c0000000008b4be0] __pcs_replace_empty_main+0x2b0/0x444
>   [c0000000141f7810] [c0000000008b9600] __kvmalloc_node_noprof+0x840/0x914
>   [c0000000141f7900] [c000000000a3dd40] seq_read_iter+0x60c/0xb00
>   [c0000000141f7a10] [c000000000b36b24] proc_reg_read_iter+0x154/0x1fc
>   [c0000000141f7a50] [c0000000009cee7c] vfs_read+0x39c/0x4e4
>   [c0000000141f7b30] [c0000000009d0214] ksys_read+0x9c/0x180
>   [c0000000141f7b90] [c00000000003a8d0] system_call_exception+0x1e0/0x4b0
>   [c0000000141f7e50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
> 
> This leads to slab_obj_ext() returning the first slabobj_ext or all
> objects and confuses the reference counting of object cgroups [1] and
> memory (un)charging for memory cgroups [2].
> 
> Fortunately, the counters field has 32 unused bits instead of 16
> on 64-bit CPUs, which is wide enough to hold any value of s->size.
> Change the type to unsigned int.
> 
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/lkml/ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com [1]
> Closes: https://lore.kernel.org/all/ddff7c7d-c0c3-4780-808f-9a83268bbf0c@linux.ibm.com [2]
> Fixes: 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Pedro Falcato <pfalcato@suse.de>

> ---
> 
> Hi Venkat, could you please test this on top of 7.0-rc2 (instead of
> 7.0-rc1) and see if the bugs [1] [2] are reproduced on your machine?
> 
> I reproduced a debug warning on a ppc machine and fixed it.
> The bugs are expected to be resolved by this fix.
> 
> p.s. After more debugging, I saw stride appeared as 0 even on the CPU
> that wrote it, which likely rules out a memory ordering issue...

More fun than debugging memory ordering issues, is debugging memory ordering
issues that actually don't exist!

-- 
Pedro

