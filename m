Return-Path: <cgroups+bounces-1411-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFC984F8E9
	for <lists+cgroups@lfdr.de>; Fri,  9 Feb 2024 16:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C632828CF19
	for <lists+cgroups@lfdr.de>; Fri,  9 Feb 2024 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7222176030;
	Fri,  9 Feb 2024 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKDMGc3i"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7152E7AE51
	for <cgroups@vger.kernel.org>; Fri,  9 Feb 2024 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493920; cv=none; b=YAjZD8hwTo/hVNJpc+JM1/BY8CWCFBcWn/Gnxu6HyRoMQyZqVJmix9y05ph3pvy7sGAOcEF2u3yykZ+Q2cmXDSaoEgCTgqvRSzvo9eMEagqCgpVHzll+q2R/0URGSgatVY0Xcc+BiHbGcB5xQgMOaE0aivNBYHeBDI+Gxzy3zAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493920; c=relaxed/simple;
	bh=yz2Nr1DweN60wHh9IsTw0SqrJDJa+x15jlpg96Nnerk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m7LLz8hjnfv8T6CM3ptQGnuW3k4xDT64jNMBnnKI8BNzKi0Qd8/kL5FgGYk+pJOD4QYvE8iVYpRaJOfg+5QRR+ynuaoqDwtNvLA/mKAR7srlaASHPhbx+8jEof5WE1QQzk+HNIFb+ATRuAUUJknVXJsOJ4kt1NhZIkSAoHKsWI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKDMGc3i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707493917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlvbQZi1P7mX+Jkg4/jTVza52l+BoDWEGyKaCsrrIa0=;
	b=CKDMGc3iA8g5ipsy7GsrM7NAI6KSrDI4Sdshtru00Ek3fMiulMPdWzKGXAkbExyCKLXHOk
	zpOnswo7NYmF11VILnz5vZ6J/B0uIzdBi50T1Vgmti18Mp1fq6v6zT2Z8xQqpHjUgOf1/d
	jGpmOSIbuJnDi5lU07VR5PsA+2lLckE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-qkcf3MIGNTSk6qP35hmq4g-1; Fri, 09 Feb 2024 10:51:55 -0500
X-MC-Unique: qkcf3MIGNTSk6qP35hmq4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B25B811E81;
	Fri,  9 Feb 2024 15:51:55 +0000 (UTC)
Received: from [10.22.17.112] (unknown [10.22.17.112])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 77F0B2026D06;
	Fri,  9 Feb 2024 15:51:55 +0000 (UTC)
Message-ID: <284aefe1-fe85-48e9-b0f1-25e28be77198@redhat.com>
Date: Fri, 9 Feb 2024 10:51:54 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Port hierarchical_mem{ory,sw}_limit cgroup1->cgroup2
Content-Language: en-US
To: "Jan Kratochvil (Azul)" <jkratochvil@azul.com>, cgroups@vger.kernel.org
References: <ZcY7NmjkJMhGz8fP@host1.jankratochvil.net>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZcY7NmjkJMhGz8fP@host1.jankratochvil.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 2/9/24 09:48, Jan Kratochvil (Azul) wrote:
> Hello,
>
> cgroup1 (by function memcg1_stat_format) already contains two lines
> 	hierarchical_memory_limit %llu
> 	hierarchical_memsw_limit %llu
>
> which are useful for userland to easily and performance-wise find out the
> effective cgroup limits being applied. Otherwise userland has to
> open+read+close the file "memory.max" and/or "memory.swap.max" in multiple
> parent directories of a nested cgroup.
>
> For cgroup1 it was implemented by:
> 	memcg: show real limit under hierarchy mode
> 	https://github.com/torvalds/linux/commit/fee7b548e6f2bd4bfd03a1a45d3afd593de7d5e9
> 	Date:   Wed Jan 7 18:08:26 2009 -0800
>
> But for cgroup2 it has been missing so far, this is just a copy-paste of the
> cgroup1 code. I have added it to the end of "memory.stat" to prevent possible
> compatibility problems with existing code parsing that file.
>
>
> Jan Kratochvil
>
>
> Signed-off-by: Jan Kratochvil (Azul) <jkratochvil@azul.com>
>
>   mm/memcontrol.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 46d8d0211..39f2a4a06 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1636,6 +1636,8 @@ static inline unsigned long memcg_page_state_local_output(
>   static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>   {
>   	int i;
> +	unsigned long memory, memsw;
> +	struct mem_cgroup *mi;
>   
>   	/*
>   	 * Provide statistics on the state of the memory subsystem as
> @@ -1682,6 +1684,17 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>   			       memcg_events(memcg, memcg_vm_event_stat[i]));
>   	}
>   
> +	/* Hierarchical information */
> +	memory = memsw = PAGE_COUNTER_MAX;
> +	for (mi = memcg; mi; mi = parent_mem_cgroup(mi)) {
> +		memory = min(memory, READ_ONCE(mi->memory.max));
> +		memsw = min(memsw, READ_ONCE(mi->memsw.max));
> +	}
> +	seq_buf_printf(s, "hierarchical_memory_limit %llu\n",
> +		       (u64)memory * PAGE_SIZE);
> +	seq_buf_printf(s, "hierarchical_memsw_limit %llu\n",
> +		       (u64)memsw * PAGE_SIZE);
> +
>   	/* The above should easily fit into one page */
>   	WARN_ON_ONCE(seq_buf_has_overflowed(s));
>   }

I don't think we use mi->memsw in cgroup v2, only memory and swap should 
be used.

Cheers,
Longman

>


