Return-Path: <cgroups+bounces-8213-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 567A4AB8A0D
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 16:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CAA163E38
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 14:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14CF1FF1B4;
	Thu, 15 May 2025 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CvVx4kFR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rxlkYI3r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CvVx4kFR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rxlkYI3r"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F051A08DB
	for <cgroups@vger.kernel.org>; Thu, 15 May 2025 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321034; cv=none; b=JAVqbGsRy9O0MJBIrIMNTWMlNT9QNREDO1OnWzsYdMjCFWvfq1gAdIYT8gerkfAtmybdbrKVAJ80PBJGU/sO2TDWPPZ6+Ohybg1jWFOICY3lLSlje5Dyq3hNTD1TnJhKAIHeNYyMg5Mni6Qp790pk93z53/dsKvwM2whboJ7utk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321034; c=relaxed/simple;
	bh=8fQq0PWQLuVp0FRzU6NvxKJHedMYCE+xtQUO7iyL6Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVJ+po5vri2P/3XuK9hpC3cdj4Z7eqmoLYytQoBvkD71KDZofbURkjfDAC0UKQ7ojVOwmz+D+T0sGx/nnOBS6hNd//Yr1UXkNZKWpRIVK18KDZlgt3v00tOIxgErJraACPmjZgFXFftlSWqet1gKyHoqcXqysOg0Hzfpmrh79d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CvVx4kFR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rxlkYI3r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CvVx4kFR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rxlkYI3r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 36B35211D5;
	Thu, 15 May 2025 14:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747321031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=275R20YMq0CMl3mWxLHSxXzp2q9navMzLEtYmOMEG1k=;
	b=CvVx4kFRIVHJBnwzffrXPD2IfV0JTCgFMMcYSzyBXMXx9qT+yYnWs2nc5z0szrXgturl0P
	Um1/tmg4APcIW+7f1QeKUN8Fx/aJNui8oUdaQp9LDJX0Wzvh7+TU3zmf7LG8/fRncAXGLK
	SH8FyWGIA6B1T8l8xhCTatyh/eBJSh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747321031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=275R20YMq0CMl3mWxLHSxXzp2q9navMzLEtYmOMEG1k=;
	b=rxlkYI3rlhrl4Bj6OZGwHlXSH7Fr5OXZtpvdr2NbixnFSFyu0a3WLgtaEV2LgQdp7k1mfQ
	KeQB7K8Rdzr4/xAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747321031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=275R20YMq0CMl3mWxLHSxXzp2q9navMzLEtYmOMEG1k=;
	b=CvVx4kFRIVHJBnwzffrXPD2IfV0JTCgFMMcYSzyBXMXx9qT+yYnWs2nc5z0szrXgturl0P
	Um1/tmg4APcIW+7f1QeKUN8Fx/aJNui8oUdaQp9LDJX0Wzvh7+TU3zmf7LG8/fRncAXGLK
	SH8FyWGIA6B1T8l8xhCTatyh/eBJSh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747321031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=275R20YMq0CMl3mWxLHSxXzp2q9navMzLEtYmOMEG1k=;
	b=rxlkYI3rlhrl4Bj6OZGwHlXSH7Fr5OXZtpvdr2NbixnFSFyu0a3WLgtaEV2LgQdp7k1mfQ
	KeQB7K8Rdzr4/xAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F748139D0;
	Thu, 15 May 2025 14:57:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yWrcAscAJmgHPAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 May 2025 14:57:11 +0000
Message-ID: <2d517f89-3bb4-4de2-8c14-8bb1e4235c7a@suse.cz>
Date: Thu, 15 May 2025 16:57:10 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] memcg: memcg_rstat_updated re-entrant safe against
 irqs
Content-Language: en-US
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
References: <20250514184158.3471331-1-shakeel.butt@linux.dev>
 <20250514184158.3471331-2-shakeel.butt@linux.dev>
 <22f69e6e-7908-4e92-96ca-5c70d535c439@lucifer.local>
 <CAGj-7pUJQZD59Sx7E69Uvi1++dB59R8wWkDYvSTGYhU-18AHXg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAGj-7pUJQZD59Sx7E69Uvi1++dB59R8wWkDYvSTGYhU-18AHXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:mid]
X-Spam-Score: -4.30

On 5/15/25 16:31, Shakeel Butt wrote:
> On Thu, May 15, 2025 at 5:47 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
>>
>> Shakeel - This breaks the build in mm-new for me:
>>
>>   CC      mm/pt_reclaim.o
>> In file included from ./arch/x86/include/asm/rmwcc.h:5,
>>                  from ./arch/x86/include/asm/bitops.h:18,
>>                  from ./include/linux/bitops.h:68,
>>                  from ./include/linux/radix-tree.h:11,
>>                  from ./include/linux/idr.h:15,
>>                  from ./include/linux/cgroup-defs.h:13,
>>                  from mm/memcontrol.c:28:
>> mm/memcontrol.c: In function ‘mem_cgroup_alloc’:
>> ./arch/x86/include/asm/percpu.h:39:45: error: expected identifier or ‘(’ before ‘__seg_gs’
>>    39 | #define __percpu_seg_override   CONCATENATE(__seg_, __percpu_seg)
>>       |                                             ^~~~~~
>> ./include/linux/args.h:25:24: note: in definition of macro ‘__CONCAT’
>>    25 | #define __CONCAT(a, b) a ## b
>>       |                        ^
>> ./arch/x86/include/asm/percpu.h:39:33: note: in expansion of macro ‘CONCATENATE’
>>    39 | #define __percpu_seg_override   CONCATENATE(__seg_, __percpu_seg)
>>       |                                 ^~~~~~~~~~~
>> ./arch/x86/include/asm/percpu.h:93:33: note: in expansion of macro ‘__percpu_seg_override’
>>    93 | # define __percpu_qual          __percpu_seg_override
>>       |                                 ^~~~~~~~~~~~~~~~~~~~~
>> ././include/linux/compiler_types.h:60:25: note: in expansion of macro ‘__percpu_qual’
>>    60 | # define __percpu       __percpu_qual BTF_TYPE_TAG(percpu)
>>       |                         ^~~~~~~~~~~~~
>> mm/memcontrol.c:3700:45: note: in expansion of macro ‘__percpu’
>>  3700 |         struct memcg_vmstats_percpu *statc, __percpu *pstatc_pcpu;
>>       |                                             ^~~~~~~~
>> mm/memcontrol.c:3731:25: error: ‘pstatc_pcpu’ undeclared (first use in this function); did you mean ‘kstat_cpu’?
>>  3731 |                         pstatc_pcpu = parent->vmstats_percpu;
>>       |                         ^~~~~~~~~~~
>>       |                         kstat_cpu
>> mm/memcontrol.c:3731:25: note: each undeclared identifier is reported only once for each function it appears in
>>
>> The __percpu macro seems to be a bit screwy with comma-delimited decls, as it
>> seems that putting this on its own line fixes this problem:
>>
> 
> Which compiler (and version) is this? Thanks for the fix.

Hm right I see the same errors with gcc 7, 13, 14, 15 but not with clang.

