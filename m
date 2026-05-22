Return-Path: <cgroups+bounces-16190-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NLtF+24D2qCPAYAu9opvQ
	(envelope-from <cgroups+bounces-16190-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 04:01:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C4E5ADD3F
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 04:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83A23300B445
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 01:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBF42BE7DD;
	Fri, 22 May 2026 01:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L2Lh02D+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B420D4E9;
	Fri, 22 May 2026 01:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779414727; cv=none; b=LF9MiGk8IrJJQAtZqbaPov/EsHiEBkEntXxKYjPjx7RWHQzecVKgmmRiZINGpLJQaAE7YhQYDuh9P0R+h62WUue5u46zH1Wzy1eqP/I4dhDj26fttpwEbRJaJCZvCXRbH3uWPynR9EVnSIfaSY8qLhC3frZuIDI+Lwa2/VfkA/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779414727; c=relaxed/simple;
	bh=3SyIRDl/2ZYw/U+KoPVPRqoM4BSNvIYZQ3+EC9K80iA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ii8QfelEN4t2OuBOnfRyEDDuBdMQTOXmzQ/2BasZd52HMyMTILMED/0jd5CWkUwR9N1bThMHUcypTs2sjIiGy5YT1DW1j7eX8x/IsL5fmRn0DRR72Cm+DJ5k3a5OenuEFRe8ag4mXqIzEiWQT4b/RxNkQmnEiSJKf7KknyW4DLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L2Lh02D+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A231F000E9;
	Fri, 22 May 2026 01:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779414725;
	bh=Dyfcsiq/DCFXpxq5yQbpU2tFM6IQFzSOs7Lzid8qTR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L2Lh02D+6lZ2EjThkr03oBOiuaO2ST3bKnMDgaqAUoV/V2ap+v5QhU49hIhzv5YIE
	 gTokUqnQb/0UGvN0asj/Aj/ZZ59YyBasIyRUxsL411orhSXQfXKpZzsnowk71dcsFi
	 3GWv1UkjvYatzyEj33JPVZk6lMsmZ6JMfSgH/lTU=
Date: Thu, 21 May 2026 18:52:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kasong@tencent.com
Cc: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>,
 linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, Zi Yan
 <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song
 <baohua@kernel.org>, Hugh Dickins <hughd@google.com>, Chris Li
 <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham
 <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Youngjun Park <youngjun.park@lge.com>, Chengming Zhou
 <chengming.zhou@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>, Yosry Ahmed
 <yosry@kernel.org>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH v5 12/12] mm, swap: merge zeromap into swap table
Message-Id: <20260521185204.a109bfcd1e0e8f52135c5ed5@linux-foundation.org>
In-Reply-To: <20260517-swap-table-p4-v5-12-88ae43e064c7@tencent.com>
References: <20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com>
	<20260517-swap-table-p4-v5-12-88ae43e064c7@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MV_CASE(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16190-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[linux-foundation.org:s=korg];
	GREYLIST(0.00)[pass,body];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups,kasong.tencent.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.576];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E6C4E5ADD3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 17 May 2026 23:39:51 +0800 Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org> wrote:

> From: Kairui Song <kasong@tencent.com>
> 
> By allocating one additional bit in the swap table entry's flags field
> alongside the count, we can store the zeromap inline
> 
> For 64 bit systems, zeromap will store in the swap table, avoiding zeromap
> allocation. It reduces the allocated memory. That is the happy path.
> 
> For certain 32-bit archs, there might not be enough bits in the swap
> table to contain both PFN and flags. Therefore, conditionally let each
> cluster have a zeromap field at build time, and use that instead.
> If the swapfile cluster is not fully used, it will still save memory for
> zeromap. The empty cluster does not allocate a zeromap. In the worst case,
> all cluster are fully populated. We will use memory similar to the
> previous zeromap implementation.
> 
> A few macros were moved to different headers for build time struct
> definition.
> 
> ...
>
> @@ -469,13 +474,21 @@ static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gfp)
>  		VM_WARN_ON_ONCE(ci->memcg_table);
>  		ci->memcg_table = kzalloc_obj(*ci->memcg_table, gfp);
>  		if (!ci->memcg_table)
> -			ret = -ENOMEM;
> +			goto err_free;
>  	}
>  #endif
> -	if (ret)
> -		swap_cluster_free_table(ci);
>  
> -	return ret;
> +#if !SWAP_TABLE_HAS_ZEROFLAG
> +	VM_WARN_ON_ONCE(ci->zero_bitmap);
> +	ci->zero_bitmap = bitmap_zalloc(SWAPFILE_CLUSTER, gfp);
> +	if (!ci->zero_bitmap)
> +		goto err_free;
> +#endif
> +	return 0;
> +
> +err_free:
> +	swap_cluster_free_table(ci);
> +	return -ENOMEM;
>  }

My m68k defconfig warned.  I'll do the below, which looks good enough. 
Please check.

Perhaps a custom guard() handler would clean things up here.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-swap-merge-zeromap-into-swap-table-fix-2
Date: Thu May 21 06:39:20 PM PDT 2026

mm/swapfile.c: In function 'swap_cluster_alloc_table':
mm/swapfile.c:488:1: warning: label 'err_free' defined but not used [-Wunused-label]
  488 | err_free:
      | ^~~~~~~~

Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Chris Li <chrisl@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kairui Song <kasong@tencent.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Youngjun Park <youngjun.park@lge.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/swapfile.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/mm/swapfile.c~mm-swap-merge-zeromap-into-swap-table-fix-2
+++ a/mm/swapfile.c
@@ -472,22 +472,22 @@ static int swap_cluster_alloc_table(stru
 	if (!mem_cgroup_disabled()) {
 		VM_WARN_ON_ONCE(ci->memcg_table);
 		ci->memcg_table = kzalloc_obj(*ci->memcg_table, gfp);
-		if (!ci->memcg_table)
-			goto err_free;
+		if (!ci->memcg_table) {
+			swap_cluster_free_table(ci);
+			return -ENOMEM;
+		}
 	}
 #endif
 
 #if !SWAP_TABLE_HAS_ZEROFLAG
 	VM_WARN_ON_ONCE(ci->zero_bitmap);
 	ci->zero_bitmap = bitmap_zalloc(SWAPFILE_CLUSTER, gfp);
-	if (!ci->zero_bitmap)
-		goto err_free;
+	if (!ci->zero_bitmap) {
+		swap_cluster_free_table(ci);
+		return -ENOMEM;
+	}
 #endif
 	return 0;
-
-err_free:
-	swap_cluster_free_table(ci);
-	return -ENOMEM;
 }
 
 /*
_


