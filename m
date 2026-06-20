Return-Path: <cgroups+bounces-17088-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0wt0KLhDNmrh8wYAu9opvQ
	(envelope-from <cgroups+bounces-17088-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 09:39:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A7C6A8806
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 09:39:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LrqFVLcL;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17088-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17088-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA7DE3030134
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 07:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24FA372055;
	Sat, 20 Jun 2026 07:39:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE10341077
	for <cgroups@vger.kernel.org>; Sat, 20 Jun 2026 07:39:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781941162; cv=none; b=PkaF88sOJpRe4N5RUIN4lEtX2rxhz7WgERaUFF1PGfwTD7RGBVszXQohPuK799Ya8N+/es/PoF+zsuvJIealH1TUdJNBLCQtKX4EU+CAZdah8sbLRPUFSqEEqkBUxAo/E+OY3troR5u+s8NN1/yZDtfZ6rbjnPf1SiTy102k4GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781941162; c=relaxed/simple;
	bh=nKeQ7rrUKZ9THl2tDpoaBhzXk+kd8XwcuuWgSDqbwnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQz1OvvoThb/y4Ax7s7YZWZYlSrcJXgHZLsi40WAFdlO2B6c9/vatpXtT7rbbfqUWbksHZOdMf/DgDwmijz4xNc9Q3Xkcm5SP0nkQLaiwa/UhMc1QlJJPIZ+hA4u6xlxCBO+Zi+zfEL8dmwnyYtDWHierDC8MobbqJFqcv2SdwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrqFVLcL; arc=none smtp.client-ip=209.85.208.50
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6976c215e7aso1248498a12.0
        for <cgroups@vger.kernel.org>; Sat, 20 Jun 2026 00:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781941158; x=1782545958; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/Dx8yZbdV0tUU5+RWiOyp7h/hJ2ofnlgcFrB51X8kc=;
        b=LrqFVLcLHUWXFF+rzzCi+axFX9C0Dx0cz17VuUZmBctSOHEqsImm+x+Hnsc21ajAFn
         qH/k20wG4V4ltmjMyela5fqnK8A7jF579Y8MoTNpTkMm7JzlN6R3Yg4wHGx3cPfxjpZ4
         LjoAbJwCA62Wiv+J7qQItMK+g8Qxps8wVdITW9J8zEh3fycYQQ1PwNOX6XH6LMK8y13c
         W5Y3Z2f9r8E3JfVFpfcY0TvqcT1vqJK1tFV4qoWwFb/AVO/2JKse1khYj58g/unwbGJg
         OUa9dk6JaLT6P/SzmM8JTU6mpVhYbNkd5KVsSUYZIM+m3GFG4M+gobAuHshRLnOtNH9Q
         9KUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781941158; x=1782545958;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/Dx8yZbdV0tUU5+RWiOyp7h/hJ2ofnlgcFrB51X8kc=;
        b=SfYk0sv3U5+ZdIQ30Cf1zbX9GKLdNPDFpmObXyCu7PAqPGQF0ygX3yWVC3tVA8o+6a
         uEbV7uc897AhmUS15FS/OoM9EaDjVuGe2uTOlxBugfeIqd+Rhue7VKljNHzKSmezYRn4
         vdxx/nhjyK4Xx8YQcXyjB/CVX+HdwGTLOkrp02M9HBYdEmd244uZXUdi1ulPHjjV3OL6
         UZfrVLEtgT0EcphnvisttjVycLEm4NOEPVvxK/2JLp4Bmiy0VwNSD3ygcemxhxv7ahHX
         L5NHEj6UoyEm5g6Rv5mxLv+ImCOlMq3ZmOxs84yTCpK72ICCPi0xDvNZIlRy3AIIy1fC
         vjLQ==
X-Forwarded-Encrypted: i=1; AFNElJ95gWeO9bsp38jWHfPhRcz31EpV9bNVpEgGa8AjbWM5+Lt4MOAcwC+3WZ1rhMxjfNQI2sEFfMz2@vger.kernel.org
X-Gm-Message-State: AOJu0YxQB8z/zNq5Ay/Tw1kkXvfzZJ+iVW5GtlNxvk6m7Jr/Cx+CS9Mf
	ALAjLryJP1ldRjq31JaOogdwgxEEgQRsN+ct+WmtQQE4PKG5Hoa6spEL
X-Gm-Gg: AfdE7cmu/2Gs4OIZ7fH9G/chcpofNIU8Lo4F1yLHODPhoQIgk2xJ1OUq1Blxi1aA0DH
	tLYUiDPbVIlHZWrroCe4mvCmA+kkWJpuADlTBHP01A5NbObefcS9b1sCNNfh1UPQF6EDL2P4vsH
	w3ROCymDmUxqdbaqpPJ6NpC6gOxpejOgUoDOx/3FJjM/ubqfvTvfgnFSIVozxR3lto2BLKQRRYK
	PmG40cmyynRFHE3aMHRNz9vOjPXPiQsllondU44U+fjK2L7xDVfeP2F44YHxw8Hbzbw9ie2igoe
	QWBrlC6swA2zNKwvcs0zJSqnJvFItbvU0foZu8qgfWmlE1UFBQvGKltVsIviybwom8/uiHqCYJP
	UnfILQG3InuqP96NLdsizLRuFvZFJVIOjAJvnvxEXCG35cY3fWTkzbiBXUIb/muHb8OrdBmwrNd
	i/j2B+BmELlCA=
X-Received: by 2002:a05:6402:254d:b0:697:833e:9179 with SMTP id 4fb4d7f45d1cf-697833e999cmr53512a12.11.1781941158096;
        Sat, 20 Jun 2026 00:39:18 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977b856f92sm426279a12.11.2026.06.20.00.39.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Jun 2026 00:39:16 -0700 (PDT)
Date: Sat, 20 Jun 2026 07:39:16 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Kairui Song <ryncsn@gmail.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 9/9] mm: switch deferred split shrinker to list_lru
Message-ID: <20260620073916.ico5v2kji4skpf5m@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260527204757.2544958-1-hannes@cmpxchg.org>
 <20260527204757.2544958-10-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527204757.2544958-10-hannes@cmpxchg.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17088-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:shakeel.butt@linux.dev,m:mhocko@kernel.org,m:david@fromorbit.com,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:qi.zheng@linux.dev,m:yosry.ahmed@linux.dev,m:ziy@nvidia.com,m:liam@infradead.org,m:usama.arif@linux.dev,m:kas@kernel.org,m:vbabka@kernel.org,m:ryncsn@gmail.com,m:zaslonko@linux.ibm.com,m:gor@linux.ibm.com,m:baolin.wang@linux.alibaba.com,m:baohua@kernel.org,m:dev.jain@arm.com,m:lance.yang@linux.dev,m:npache@redhat.com,m:ryan.roberts@arm.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[master:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[richardweiyang@gmail.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[richard.weiyang@gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardweiyang@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38A7C6A8806

On Wed, May 27, 2026 at 04:45:16PM -0400, Johannes Weiner wrote:
[...]
>@@ -3890,34 +3804,43 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
> 	struct folio *end_folio = folio_next(folio);
> 	struct folio *new_folio, *next;
> 	int old_order = folio_order(folio);
>+	struct list_lru_one *lru;
>+	bool dequeue_deferred;
> 	int ret = 0;
>-	struct deferred_split *ds_queue;
> 
> 	VM_WARN_ON_ONCE(!mapping && end);
>-	/* Prevent deferred_split_scan() touching ->_refcount */
>-	ds_queue = folio_split_queue_lock(folio);
>+	/*
>+	 * If this folio can be on the deferred split queue, lock out
>+	 * the shrinker before freezing the ref. If the shrinker sees
>+	 * a 0-ref folio, it assumes it beat folio_put() to the list
>+	 * lock and must clean up the LRU state - the same dequeue we
>+	 * will do below as part of the split.
>+	 */
>+	dequeue_deferred = folio_test_anon(folio) && old_order > 1;

Looking at __folio_remove_rmap(), we check !folio_is_device_private() before
deferred_split_folio(). __folio_freeze_and_split_unmapped() is used in
folio_split_unmapped(). According to its comment, it could take device-private
folio.

This means for device-private folio, we still lock lru_list and try to remove
it from deferred_split_lru. The good news is this doesn't harm the system, but
does some extra work.

Would it be better to add !folio_is_device_private() here?

The purpose to lock here is to prevent shrinker seeing ref-0 folio. Since
device-private folio is not on deferred_split_lru, shrink won't see it.

>+	if (dequeue_deferred) {
>+		struct mem_cgroup *memcg;
>+
>+		rcu_read_lock();
>+		memcg = folio_memcg(folio);
>+		lru = list_lru_lock(&deferred_split_lru,
>+				    folio_nid(folio), &memcg);
>+	}
> 	if (folio_ref_freeze(folio, folio_cache_ref_count(folio) + 1)) {
> 		struct swap_cluster_info *ci = NULL;
> 		struct lruvec *lruvec;
> 
>-		if (old_order > 1) {
>-			if (!list_empty(&folio->_deferred_list)) {
>-				ds_queue->split_queue_len--;
>-				/*
>-				 * Reinitialize page_deferred_list after removing the
>-				 * page from the split_queue, otherwise a subsequent
>-				 * split will see list corruption when checking the
>-				 * page_deferred_list.
>-				 */
>-				list_del_init(&folio->_deferred_list);
>-			}
>+		if (dequeue_deferred) {
>+			__list_lru_del(&deferred_split_lru, lru,
>+				       &folio->_deferred_list, folio_nid(folio));
> 			if (folio_test_partially_mapped(folio)) {
> 				folio_clear_partially_mapped(folio);
> 				mod_mthp_stat(old_order,
> 					MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
> 			}
>+			list_lru_unlock(lru);
>+			rcu_read_unlock();
> 		}
>-		split_queue_unlock(ds_queue);
>+
> 		if (mapping) {
> 			int nr = folio_nr_pages(folio);
> 
>@@ -4017,7 +3940,10 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
> 		if (ci)
> 			swap_cluster_unlock(ci);
> 	} else {
>-		split_queue_unlock(ds_queue);
>+		if (dequeue_deferred) {
>+			list_lru_unlock(lru);
>+			rcu_read_unlock();
>+		}
> 		return -EAGAIN;
> 	}
> 

-- 
Wei Yang
Help you, Help me

