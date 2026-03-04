Return-Path: <cgroups+bounces-14597-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP56I9wGqGnSnQAAu9opvQ
	(envelope-from <cgroups+bounces-14597-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 11:18:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A0B1FE34A
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 11:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1E373025D34
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 10:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B462366836;
	Wed,  4 Mar 2026 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J31y4cKl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4F236A029
	for <cgroups@vger.kernel.org>; Wed,  4 Mar 2026 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619470; cv=none; b=AM6i+NM1qWWTw1BbqwkX1jiiNFhER4I4TRcdYMNR7PHme1lI/ZOJ05WggFhWW7R8y+T9RkPmJZ9mT/ebTC8+fMYESGuozOlCiOwEjKbdQIuf1KYjQKueD4oekVZKOJeo6iwmPds3Vpb9rzB23N/Riq6lrMDafgzJ5DDiUQox7tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619470; c=relaxed/simple;
	bh=SwIzlRPlqfSDrp319lbWKH5+yaj3K7TQ/FajYAitnaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3ONdXKr0CyvLCxF5L+FAQnExw62Niwcn0hMRfhWtfMiWKwOfTk69xP0/AcZL+t+YcM8A8x4QQWLUAmYh20zLONkt0taqv9ll7ZHiGEd2cyjKFH4zLvcUXUcMvKp04Dm57CIzMOC0zFdaGT+bhPiDXuS3KT1T0AWoagzDqIdtpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J31y4cKl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806fd9033bso11470075e9.3
        for <cgroups@vger.kernel.org>; Wed, 04 Mar 2026 02:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772619467; x=1773224267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5KoS4d1g/sHa9EtIML/M64KShORyKTnEsKbcSse0JEQ=;
        b=J31y4cKlXFzWwMcWx4vVHZ5bPq2YIihRcGjIXe6Eg5mHK7iEuVo/kwXwNk1VeUcNaI
         47Y48Hc8s7FD+G4WpYu94ppfqUz7Qd0sHJIUoW+L3jt0uSVJ1hifGTwNYp/+ikO8jp4g
         CFl095MuDePN2GjMtqrYSAGzAuIFSrmLIwKK5kMzgqSwdqyToeoMO8cx12+bTrGEL/yh
         VHCrGnpJd+hlVIJhFEWrnfSnAE11xJChq3k0jE02giKI0Io+EUTtVwcYunKvxussy7wz
         wJz+fI0XG+Ex0rbLibC5LkTcYNStR6NqHaOGgbj07ppkSmEDHV7gqpbIj1coaEziU4zw
         AeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772619467; x=1773224267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KoS4d1g/sHa9EtIML/M64KShORyKTnEsKbcSse0JEQ=;
        b=kjA3kxnSBVaizr3egeQMbt8rq4s7LqtV1N+Q2uATzk+eLUSqGG6uUMT1e485Nlo1Jy
         04LaDVwazaufU/Y+FXKNiqQRUQlwswUds3Oyz6o7EPKOQ6GXa5ojHB8D+WbDMEBxRLJW
         D/hggXEXRkqvHsKJpm7AxLBVnr3PIuHvhPC2cGsHovwmKfqGrVUBfWpUkd6yrhWrhlQ6
         PYHA5JaBQuOvSnwo7aoJRYrBA7757MqidDSnOOtSDgTB/tPufWwYsEF1QCARRWKQLHuK
         fsnBP2fZcUtYuX29lDfgmZdGM/cnKcUnKjtNg3yxgHLDqpWJycCWosMkiOntwDiDc5qo
         BxGw==
X-Gm-Message-State: AOJu0Yz3StZYyk45/10UmHvt1sFygA4IDF3/R6qaW6N8KBW/v/nwIwrt
	eYwnpVJgasND7adGeaWa1JzU9bCw00jCkeuH0HX/bxGyz0gWeHByOUMKIHUGKwkeJqo=
X-Gm-Gg: ATEYQzwsnWR+wkkDX6IJhdyuEAF+TQoJVC8upj5JvwJRr9qo/Y9lU1x7fpJ/y/rLpK9
	2gS0tuIE6G6pk4KsiUv1iUNJ5g+29QhACrtGPSaYu0vV2m7b8ORV+RAJP5scXQDrHgQbNrFp9ih
	tZWDX0u6eAryDaIkfUVKrevLl0wkZBZCoNoUbzSs5IBB6+c2IW2O1FtemsYBgUfjzg2IpzWyFqm
	XF2feBbjSzkx9ya5gHgT0UEpfliBsOY1ayQpz0/+dDzFahTFjtv1nghqHi2AT5V8plnpCVDRxwa
	IOmKoM20g3+WR8gV5eqKSgNaFoxZF8hVu08wEmkkJzA0jLY1hyjl4hNwaPoHyDTKqgT9rS6h6t4
	l5zS3vTMkG6Zd2TEg5J+lVy0rjW057HA36RRovFcyeldCU2h9AJk1Y9J4EIzym5J9/N9US59gt+
	y2oPQMOmGMszznElxcp4DAmQ18iGRJdx39WDmd3r4=
X-Received: by 2002:a05:600c:3489:b0:483:7631:befd with SMTP id 5b1f17b1804b1-48519896e6dmr14055045e9.7.1772619467328;
        Wed, 04 Mar 2026 02:17:47 -0800 (PST)
Received: from [192.168.43.36] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851880724esm79793035e9.9.2026.03.04.02.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 02:17:47 -0800 (PST)
Message-ID: <fe9dacdd-8b96-4375-8730-8fb9ed5fad60@suse.com>
Date: Wed, 4 Mar 2026 11:17:46 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: change stride type from unsigned short to
 unsigned int
To: Harry Yoo <harry.yoo@oracle.com>, vbabka@suse.cz,
 akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org, cl@gentwo.org, hannes@cmpxchg.org,
 hao.li@linux.dev, linux-mm@kvack.org, mhocko@kernel.org,
 muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, surenb@google.com, venkat88@linux.ibm.com,
 pfalcato@suse.de
References: <20260303135722.2680521-1-harry.yoo@oracle.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.com>
In-Reply-To: <20260303135722.2680521-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E9A0B1FE34A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-14597-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:mid]
X-Rspamd-Action: no action

On 3/3/26 2:57 PM, Harry Yoo wrote:
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

Added to slab/for-next-fixes, thanks!
Hopefully Venkat confirms the fix and we can close and try to forget
about the memory ordering can of worms again ;)

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
> and I discovered this while decoding ppc assembly suspecting memory
> corruption or a compiler bug, which came down to:
>   
>     "Hmm... why is the size truncated to 2 bytes?... OH WAIT!"
> 
>  mm/slab.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index f6ef862b60ef..e9ab292acd22 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -59,7 +59,7 @@ struct freelist_counters {
>  					 * to save memory. In case ->stride field is not available,
>  					 * such optimizations are disabled.
>  					 */
> -					unsigned short stride;
> +					unsigned int stride;
>  #endif
>  				};
>  			};
> @@ -559,20 +559,20 @@ static inline void put_slab_obj_exts(unsigned long obj_exts)
>  }
>  
>  #ifdef CONFIG_64BIT
> -static inline void slab_set_stride(struct slab *slab, unsigned short stride)
> +static inline void slab_set_stride(struct slab *slab, unsigned int stride)
>  {
>  	slab->stride = stride;
>  }
> -static inline unsigned short slab_get_stride(struct slab *slab)
> +static inline unsigned int slab_get_stride(struct slab *slab)
>  {
>  	return slab->stride;
>  }
>  #else
> -static inline void slab_set_stride(struct slab *slab, unsigned short stride)
> +static inline void slab_set_stride(struct slab *slab, unsigned int stride)
>  {
>  	VM_WARN_ON_ONCE(stride != sizeof(struct slabobj_ext));
>  }
> -static inline unsigned short slab_get_stride(struct slab *slab)
> +static inline unsigned int slab_get_stride(struct slab *slab)
>  {
>  	return sizeof(struct slabobj_ext);
>  }


