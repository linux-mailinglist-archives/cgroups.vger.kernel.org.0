Return-Path: <cgroups+bounces-1419-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33442850AC2
	for <lists+cgroups@lfdr.de>; Sun, 11 Feb 2024 19:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457E7B20AB5
	for <lists+cgroups@lfdr.de>; Sun, 11 Feb 2024 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B85CDEC;
	Sun, 11 Feb 2024 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9sPj64c"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FB05CDFA
	for <cgroups@vger.kernel.org>; Sun, 11 Feb 2024 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707674526; cv=none; b=jBRAQm/9ChsnCJgVwWdQIh1Ax6RD7AmyfmamahHpBJcFkwVslIDzH6LFV6RzO2y8OClF26bvMm5LAgs/nxzBRFg+7QKIESsIb72uSkPJGJI8o0vXBIa50cvn4AONT+GDQRzs8wtX6+5A5F2xS86DIc0QHISJAzO0tlOA6qChMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707674526; c=relaxed/simple;
	bh=t9H8QYOGCJwIWZF10aBYftbw0jab28DF810E7OGgHhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0sTmKjHSNbthEjKL8Xm0X5tqkxlmleaObc93CK0/OrI1YhWcSVzD1XkXzaQazDYFiFjvBOzoohPDtoGzzNbHq4L9SKPpZkRc6cwE+8uRWzBJS3pQDpxF3BwSBpUXPio0bArtQegkthYB0FbppgLRscjrkxGxBamuAZ0ho/ZGUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9sPj64c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707674523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9wb2032/qos7Yo695M8gn5eKpEdplqKuwaV3CrOPgM=;
	b=P9sPj64coFDUFBnWPzyKa1lSUlaBkPbxun537LiMg0dUNZFvo10sMYD9sPL7NOqEs4NsMT
	2W4BBeg+69GMdjLqk9eN7saTzPH6zO6pNWagcahhDpo8zdQYc87FX4VG+6T2HR+zYro15G
	BqM0X8cNvXE6WsgVNdr1YJVijZKoEXs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-z2_GwkDkNxOtn0rhradlbQ-1; Sun, 11 Feb 2024 13:01:59 -0500
X-MC-Unique: z2_GwkDkNxOtn0rhradlbQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46DE4101FA2C;
	Sun, 11 Feb 2024 18:01:59 +0000 (UTC)
Received: from [10.22.8.61] (unknown [10.22.8.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 22C35111D654;
	Sun, 11 Feb 2024 18:01:59 +0000 (UTC)
Message-ID: <42c24a38-0863-41df-b9c6-7f7cf1f42357@redhat.com>
Date: Sun, 11 Feb 2024 13:01:58 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Port hierarchical_{memory,swap}_limit cgroup1->cgroup2
Content-Language: en-US
To: "Jan Kratochvil (Azul)" <jkratochvil@azul.com>
Cc: cgroups@vger.kernel.org
References: <ZcY7NmjkJMhGz8fP@host1.jankratochvil.net>
 <284aefe1-fe85-48e9-b0f1-25e28be77198@redhat.com>
 <ZcjCXH8HJvshxUGb@host1.jankratochvil.net>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZcjCXH8HJvshxUGb@host1.jankratochvil.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3


On 2/11/24 07:49, Jan Kratochvil (Azul) wrote:
> Hello Waiman,
>
> On Fri, 09 Feb 2024 23:51:54 +0800, Waiman Long wrote:
>> I don't think we use mi->memsw in cgroup v2, only memory and swap should
>> be used.
> you are right, thanks:
>
> struct mem_cgroup {
> ...
> 	union {
> 		struct page_counter swap;       /* v2 only */
> 		struct page_counter memsw;      /* v1 only */
> 	};
>
>
> Jan Kratochvil
>
>
> Signed-off-by: Jan Kratochvil (Azul) <jkratochvil@azul.com>

Please send a proper v2 patch to the full list for review.

Cheers,
Longman

>
>   mm/memcontrol.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 46d8d0211..2631dd810 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1636,6 +1636,8 @@ static inline unsigned long memcg_page_state_local_output(
>   static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>   {
>   	int i;
> +	unsigned long memory, swap;
> +	struct mem_cgroup *mi;
>   
>   	/*
>   	 * Provide statistics on the state of the memory subsystem as
> @@ -1682,6 +1684,17 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>   			       memcg_events(memcg, memcg_vm_event_stat[i]));
>   	}
>   
> +	/* Hierarchical information */
> +	memory = swap = PAGE_COUNTER_MAX;
> +	for (mi = memcg; mi; mi = parent_mem_cgroup(mi)) {
> +		memory = min(memory, READ_ONCE(mi->memory.max));
> +		swap = min(swap, READ_ONCE(mi->swap.max));
> +	}
> +	seq_buf_printf(s, "hierarchical_memory_limit %llu\n",
> +		       (u64)memory * PAGE_SIZE);
> +	seq_buf_printf(s, "hierarchical_swap_limit %llu\n",
> +		       (u64)swap * PAGE_SIZE);
> +
>   	/* The above should easily fit into one page */
>   	WARN_ON_ONCE(seq_buf_has_overflowed(s));
>   }
>


