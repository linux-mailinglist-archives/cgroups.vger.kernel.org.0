Return-Path: <cgroups+bounces-14700-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDQINHWzrWk/6QEAu9opvQ
	(envelope-from <cgroups+bounces-14700-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 08 Mar 2026 18:35:49 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 487A3231733
	for <lists+cgroups@lfdr.de>; Sun, 08 Mar 2026 18:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA840300AEFC
	for <lists+cgroups@lfdr.de>; Sun,  8 Mar 2026 17:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2E537649D;
	Sun,  8 Mar 2026 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htMWwVrX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F3284684
	for <cgroups@vger.kernel.org>; Sun,  8 Mar 2026 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772991343; cv=none; b=mwqZfkTAPUUZiDq3yPx0ayLeNka5XEpeEtnK0Ac1JnJTnpy3q/rScUIDQGpIf9Eas3AoTP6gJ8qrEeaTUSOMYG7OHQgJLaqaI43Et/7KJWcKYhHAlc0sQERsw5EVfpLgi1FN5/kpgPQ/CzYr+f5q5MBUTfd8ylni7qONnPYQKio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772991343; c=relaxed/simple;
	bh=lfme5u9LJhgQpXmyam5J21ORBf0gVxgKo+2SpDTNOvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=YwWofSlcFECLLLYWusZjP1CedUhfgCNPljgPMn7BWHa6OnAUUOyPQRLeRpKaChTGunfuezS+YLZ52NqkMMp7VneKi6jIM7yYKElhLefQ1gaoan3YUVtS4JkGYaLByb3WUQzw/n9SaIrBBtV9h2JVysxHi1JwthuHVGIOyKUtEnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htMWwVrX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48374014a77so129814095e9.3
        for <cgroups@vger.kernel.org>; Sun, 08 Mar 2026 10:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772991341; x=1773596141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GC8HMKQ4ZWxWCtuNOfqYbNHW4R2NaicK2jQPUUta23k=;
        b=htMWwVrXlktLsJApiKrI9nyH07vg59daTLd6NWPo6k+HvBKaXeGGIsialK4oSdC/Gz
         HHrMAyPLogDZVqtJFAZyI5UXdnsjgN89aVkrVo33WVucz3rvmujEyC93qxmsnQus2+a0
         wOewmrsYQhUa4PnwozuzRYc7mq9StabLWldK2RnZc70oOnFbGgNYGmsXgqye6ahQLZ/O
         zXaZCS+70qbd0XN28i2vyTNOoto2fg3N/QpyBzCRMocTIVki/CqW8+Yywja5zgEHUvaU
         d1XmlZbr+L1h0lbllx7b07VsmNO7xWEpXs5bieOR+GDtBd+UStkaIIlYerPIdyBkf5ID
         FgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772991341; x=1773596141;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GC8HMKQ4ZWxWCtuNOfqYbNHW4R2NaicK2jQPUUta23k=;
        b=OpG2r0UxW9wwQi6oNSZ6DvP+av4NXfdacTKLITCShsMmghIO8j0q83nfbPkjhPKbjX
         ef8rddB1ZPMHJNat+7eTWEb3uIoOsJacrVLpDOql6taewocXQwGeAbWGBU/7vOo7J7xa
         sHJKeEdyZ91ie6F8Ngg072EC8OzWzhfqP0Dq70AbkdTAYoSMe3flMkLJ9nQP2Lyo8c5/
         JRQPvgyDmvNIHVS0iY3Mu6KPeP4AMRv6fhhxXJU+4nPNAViqKWYdFFDIASBOHwn2nfkx
         aecfiv5F19b7XgaKNKoCo4kJH73Bu4/hKCEYewB5TzDtSNCK7arKiEQrzkJG9VNJyN4H
         R32w==
X-Forwarded-Encrypted: i=1; AJvYcCWqRzVylFzADSOaE8O6clC/wrJoLZhQFmv3WY9NLmm/ozA1BYGwYrFsujpfk5TOqARq8eYwODBN@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxrp8gHKXk3pjRxBU67XvNYbou2WGpsjfYmdNWkbUOS6WChSEw
	7J05qgA2Gg5/wcoRL4/caxhgZI3oGtwyPsjN+4FBTnxv+J/36GzR1d8A
X-Gm-Gg: ATEYQzyw5iVmoO+nSg0g7wprsx2roZTj0xOMCDGFDkZKkCNSJ0tZJAwQPPRcVgCZ74d
	3Y9wvz/Axz3G+9N29DMu3elaOxS2iiRySEoIu9bYqRXdT4sYwjPTdLei5zQUx2mvse+1kTiUuSS
	/cQpfTweJ322+anYChGE5ntyYSxts0NcxxtGwyYO8L9wiiAguQ7UPOrhBA26JpO6FHdQiHi++VZ
	/9nhUaKtnHeK9FWAue8bCEANaS94r6VB/jkSsu8qiDJWGiO34gZe47nN5YsrykCSQDog1MNe07v
	Qpny5LhBCG96XUMRSXaNnMw4fHLOmKUvXw6CJFQCi5FonyOZ5lm0Ga1MLjZDBGHOVa++ty8/V4g
	oLiXNwxm/GxO+w0kejyEuXxr91bvUoYQKNrVwG8IHOL56UuSZojbOgoEtaUU4tOchZoZiwAjGmS
	ZkszRrlU692jmkXAT9R3ODHp/73ShKGFSg9JM=
X-Received: by 2002:a05:600c:a12:b0:482:eec4:758 with SMTP id 5b1f17b1804b1-48526967a7emr143636505e9.26.1772991340683;
        Sun, 08 Mar 2026 10:35:40 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:1b2a:fa01:9944:6a8c:dc37:eba5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853a310b8fsm37581865e9.11.2026.03.08.10.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 10:35:39 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Leonardo Bras <leobras.c@gmail.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 3/4] swap: apply new queue_percpu_work_on() interface
Date: Sun,  8 Mar 2026 14:35:30 -0300
Message-ID: <aa2zYkzFeexyObwj@WindFlash>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aaBrfg0ozWK4moxC@tpad>
References: <20260206143430.021026873@redhat.com> <20260206143741.589656953@redhat.com> <aYaQFM9sBbauUn5c@WindFlash> <aaBrfg0ozWK4moxC@tpad>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 487A3231733
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14700-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kvack.org,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,linux.com,google.com,lge.com,suse.cz,redhat.com,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leobrasc@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.975];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 12:49:18PM -0300, Marcelo Tosatti wrote:
> On Fri, Feb 06, 2026 at 10:06:28PM -0300, Leonardo Bras wrote:
> > > +	cpu = smp_processor_id();
> > 
> > Wondering if for these cases it would make sense to have something like:
> > 
> > qpw_get_local_cpu() and 
> > qpw_put_local_cpu() 
> > 
> > so we could encapsulate these migrate_{en,dis}able()
> > and the smp_processor_id().
> > 
> > Or even,
> > 
> > int qpw_local_lock() {
> > 	migrate_disable();
> > 	cpu = smp_processor_id();
> > 	qpw_lock(..., cpu);
> > 
> > 	return cpu;
> > }
> > 
> > and
> > 
> > qpw_local_unlock(cpu){
> > 	qpw_unlock(...,cpu);
> > 	migrate_enable();
> > } 
> > 
> > so it's more direct to convert the local-only cases.
> > 
> > What do you think?
> 
> Switched to local_qpw_lock variants.
> 
> > >  {
> > > -	local_lock(&cpu_fbatches.lock);
> > > -	lru_add_drain_cpu(smp_processor_id());
> > 
> > and here ?
> 
> Fixed lack of migrate_disable/migrate_enable, thanks!
> 
> > > @@ -950,7 +954,7 @@ void lru_cache_disable(void)
> > >  #ifdef CONFIG_SMP
> > >  	__lru_add_drain_all(true);
> > >  #else
> > > -	lru_add_mm_drain();
> > 
> > and here, I wonder
> 
> This is !CONFIG_SMP, so smp_processor_id is always 0.
> 
> > >  	drain_pages(cpu);
> > >  
> > >  	/*
> > > 
> > > 
> > 
> > TBH, I am still trying to understand if we need the migrate_{en,dis}able():
> > - There is a data dependency beween cpu being filled and being used.
> > - If we get the cpu, and then migrate to a different cpu, the operation 
> >   will still be executed with the data from that starting cpu 
> 
> Yes, but on a remote CPU. What prevents the original CPU from accessing 
> its per-CPU local data, therefore racing with the code executing on the
> remote CPU.


Yes, but really rarely, and contention even more rare.
It also should not break anything, as locking will make sure access to that 
per-cpu value is being serialized.

I was wondering on the extra cost of migrate_* on the hot path being an 
undesired effect for other code evaluating switching to QPW. But maybe it's 
not that bad, and we get rid of that very rare contention.

Thanks!
Leo

> 
> > - But maybe the compiler tries to optize this because the processor number 
> >   can be on a register and of easy access, which would break this.
> > 
> > Maybe a READ_ONCE() on smp_processor_id() should suffice?
> > 
> > Other than that, all the conversions done look correct.
> > 
> > That being said, I understand very little about mm code, so let's hope we 
> > get proper feedback from those who do :) 
> > 
> > Thanks!
> > Leo
> > 
> > 
> 

