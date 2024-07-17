Return-Path: <cgroups+bounces-3742-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3562C934187
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 19:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5611C2127F
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB71822DD;
	Wed, 17 Jul 2024 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ia+k/mM7"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC6B469D
	for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721237897; cv=none; b=frCscbN5ABMhkAQ8Jl9+eVx+n0zgFBcyISZKCGzKk4zYk6IRhVdgGcRE1K8lET/qStWl+yd+L6JiiYDJm7hgAUyqzNn5EJomq/tF/pdhkr1bT7SUljj7zJpsn+dTtXnxmDBJBYcvNOE6jryarkPp5jxBRPFCRDqJd968gNSPAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721237897; c=relaxed/simple;
	bh=y4XpeGRxkRobm+17Rc4jFcUaNZp43qIiW26ADRi71zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rntK1//fQ5VgfBWWAQhLAnuoPWtNKcS0utXFGn0EzGHAU279eWwf1JbYtXgxRjK/qeqcWPnoJKl1Gai07c/wIrfMd1M7WiRbeNiCOEU957ltTASpTExTjF6Nn63cgWEAuztEUpJo7/2U58HMBZU4gzmNkQ8+QiE8762q+mnyR4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ia+k/mM7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721237895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ho73z9I5NiBU0wesdxPZDVws1RgteUppy4Fw+aIYmBI=;
	b=Ia+k/mM7LynJR6QP3xYS4LdYgpFFbonuHqGK2+21yPUb5fkZ/gGJNXbtbXM47alo4iZUm6
	CUQg6OBFp4dV2Fphkl3Qo0BnUkQNMBgefOi9TIY8+k8e6tGjHfxRzkLeedfRuBsDOnNA+M
	BsBR+QKS+g+sp6xrwNHeN4Tfy/umwVE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-LpNPs6eCMKmdR_gguvlxMQ-1; Wed,
 17 Jul 2024 13:38:09 -0400
X-MC-Unique: LpNPs6eCMKmdR_gguvlxMQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54DE619560B3;
	Wed, 17 Jul 2024 17:38:07 +0000 (UTC)
Received: from [10.22.16.209] (unknown [10.22.16.209])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B6A01955F40;
	Wed, 17 Jul 2024 17:37:58 +0000 (UTC)
Message-ID: <f448f66b-7a91-4281-8f77-159541cbacff@redhat.com>
Date: Wed, 17 Jul 2024 13:37:56 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] blk-cgroup: Replace u64 sync with spinlock for iostat
 update
To: "tj@kernel.org" <tj@kernel.org>, =?UTF-8?B?Qm95IFd1ICjlkLPli4Poqrwp?=
 <Boy.Wu@mediatek.com>
Cc: "boris@bur.io" <boris@bur.io>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 =?UTF-8?B?SXZlcmxpbiBXYW5nICjnjovoi7PpnJYp?= <Iverlin.Wang@mediatek.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>
References: <20240716075206.23121-1-boy.wu@mediatek.com>
 <Zpbify32lel9J-5I@slm.duckdns.org>
 <c5bcbcbaeacdb805adc75c26f92ec69f26ad7706.camel@mediatek.com>
 <5560c690cc6de67139a9b2e45c7a11938b70fc58.camel@mediatek.com>
 <1b19b68adb34410bf6dc8fd3f50e4b82c1a014e4.camel@mediatek.com>
 <Zpf3ks2drDZ7ULTa@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Zpf3ks2drDZ7ULTa@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 7/17/24 12:55, tj@kernel.org wrote:
> Hello,
>
> Does something like the following work for you?
>
> Thanks.
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 37e6cc91d576..ec1d191f5c83 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -329,7 +329,6 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
>   	INIT_WORK(&blkg->async_bio_work, blkg_async_bio_workfn);
>   #endif
>   
> -	u64_stats_init(&blkg->iostat.sync);
>   	for_each_possible_cpu(cpu) {
>   		u64_stats_init(&per_cpu_ptr(blkg->iostat_cpu, cpu)->sync);
>   		per_cpu_ptr(blkg->iostat_cpu, cpu)->blkg = blkg;
> @@ -632,24 +631,26 @@ static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
>   static void __blkg_clear_stat(struct blkg_iostat_set *bis)
>   {
>   	struct blkg_iostat cur = {0};
> -	unsigned long flags;
>   
> -	flags = u64_stats_update_begin_irqsave(&bis->sync);
>   	blkg_iostat_set(&bis->cur, &cur);
>   	blkg_iostat_set(&bis->last, &cur);
> -	u64_stats_update_end_irqrestore(&bis->sync, flags);
>   }
>   
>   static void blkg_clear_stat(struct blkcg_gq *blkg)
>   {
> +	unsigned long flags;
>   	int cpu;
>   
> +	raw_spin_lock_irqsave(&blkg_stat_lock, flags);
> +
>   	for_each_possible_cpu(cpu) {
>   		struct blkg_iostat_set *s = per_cpu_ptr(blkg->iostat_cpu, cpu);
>   
>   		__blkg_clear_stat(s);
>   	}
>   	__blkg_clear_stat(&blkg->iostat);
> +
> +	raw_spin_unlock_irqrestore(&blkg_stat_lock, flags);
>   }
>   
>   static int blkcg_reset_stats(struct cgroup_subsys_state *css,
> @@ -998,12 +999,10 @@ static void blkcg_iostat_update(struct blkcg_gq *blkg, struct blkg_iostat *cur,
>   	unsigned long flags;
>   
>   	/* propagate percpu delta to global */
> -	flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
>   	blkg_iostat_set(&delta, cur);
>   	blkg_iostat_sub(&delta, last);
>   	blkg_iostat_add(&blkg->iostat.cur, &delta);
>   	blkg_iostat_add(last, &delta);
> -	u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
>   }
>   
>   static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
> @@ -1134,9 +1133,9 @@ static void blkcg_fill_root_iostats(void)
>   				cpu_dkstats->sectors[STAT_DISCARD] << 9;
>   		}
>   
> -		flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
> +		raw_spin_lock_irqsave(&blkg_stat_lock, flags);
>   		blkg_iostat_set(&blkg->iostat.cur, &tmp);
> -		u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
> +		raw_spin_unlock_irqrestore(&blkg_stat_lock, flags);
>   	}
>   }
>   
> @@ -1145,7 +1144,6 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
>   	struct blkg_iostat_set *bis = &blkg->iostat;
>   	u64 rbytes, wbytes, rios, wios, dbytes, dios;
>   	const char *dname;
> -	unsigned seq;
>   	int i;
>   
>   	if (!blkg->online)
> @@ -1157,16 +1155,14 @@ static void blkcg_print_one_stat(struct blkcg_gq *blkg, struct seq_file *s)
>   
>   	seq_printf(s, "%s ", dname);
>   
> -	do {
> -		seq = u64_stats_fetch_begin(&bis->sync);
> -
> -		rbytes = bis->cur.bytes[BLKG_IOSTAT_READ];
> -		wbytes = bis->cur.bytes[BLKG_IOSTAT_WRITE];
> -		dbytes = bis->cur.bytes[BLKG_IOSTAT_DISCARD];
> -		rios = bis->cur.ios[BLKG_IOSTAT_READ];
> -		wios = bis->cur.ios[BLKG_IOSTAT_WRITE];
> -		dios = bis->cur.ios[BLKG_IOSTAT_DISCARD];
> -	} while (u64_stats_fetch_retry(&bis->sync, seq));
> +	raw_spin_lock_irq(&blkg_stat_lock);
> +	rbytes = bis->cur.bytes[BLKG_IOSTAT_READ];
> +	wbytes = bis->cur.bytes[BLKG_IOSTAT_WRITE];
> +	dbytes = bis->cur.bytes[BLKG_IOSTAT_DISCARD];
> +	rios = bis->cur.ios[BLKG_IOSTAT_READ];
> +	wios = bis->cur.ios[BLKG_IOSTAT_WRITE];
> +	dios = bis->cur.ios[BLKG_IOSTAT_DISCARD];
> +	raw_spin_unlock_irq(&blkg_stat_lock, flags);
>   
>   	if (rbytes || wbytes || rios || wios) {
>   		seq_printf(s, "rbytes=%llu wbytes=%llu rios=%llu wios=%llu dbytes=%llu dios=%llu",
>
bis->sync is still being used in blk_cgroup_bio_start(). Replacing it 
with a global lock may kill performance. We may have to use a per-cpu 
lock if we want to go this route of eliminating bis->sync.

Cheers,
Longman


