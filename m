Return-Path: <cgroups+bounces-15298-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kZ0/Nf+i3ml5GwAAu9opvQ
	(envelope-from <cgroups+bounces-15298-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 22:26:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5BF3FE595
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 22:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C55433025408
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 20:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D171320A04;
	Tue, 14 Apr 2026 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXBQZCMJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4831E826
	for <cgroups@vger.kernel.org>; Tue, 14 Apr 2026 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776198397; cv=none; b=GLxaVOOuUvJrsBsEMy54dg/PMQR0NL/6pfaWoziqZhN+/71JkBA41E/HsT6i/SzhnB6PXWHw+LDLdbd4apEKhGdr0EmvCrxo2/yv9tQ8mi6Y0ONvCcFLdX9gqMq1gQwxm4J/ABdkXQM0I7U+NS0zGKNUsAuiQUWDoP2ISuTz8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776198397; c=relaxed/simple;
	bh=xiknWtZMkiU4Zkytv6RrDHEpBhs3dGZHdhPAOQp9tBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GreMv1lC81G/TRdk8sRRtpliLgNrjNWYPPwuZdlFktEXLFCcZCFyCsY4CuFQ2cuc/kR+HrM2seFuF1ReGLT5KQeqFuixfwmj5myQzWI6Kose4xW+uK9200QiCUz6Hng/BXsqtDUBwygLfukySHpgX1aaUszPmDI8f1zFJzjuGNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXBQZCMJ; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-47938ef848cso1393007b6e.0
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2026 13:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776198394; x=1776803194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UR4m3dl9VK+BroM75Hxq4WeXIJgGbxy3Rl4ETefDxA=;
        b=DXBQZCMJmGrDA4vI8ZSorRNw3V36/jAClsDxnE1mvmNYmYPo2pg/g8k3ZAXmUFIScz
         wznwujbmMmYXCwbTSF/XpSBPrVjXw8vqqIV1WdT8g6R4pt8qL34A8zsOOjZD7KIrsfbX
         uyvmov8QwTT0qkas+PjGsN1eYB5cj3lLxlQDB0fk2Gydt7QzULD8Dwq0tIVxjZx+aJ18
         kRjhNIqu+9DeemlzXDKRz5T0UxegxOSuedFmfRafFZtjpjcBCoBvoecFdGTU3a4OKioY
         ZFzcKpV3tmspXwlfKrWXgbtZGhED3ZbLRi1oj7Zl82hbdWA+RW4cUhxs25/vC4hUq5Zt
         gKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776198394; x=1776803194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/UR4m3dl9VK+BroM75Hxq4WeXIJgGbxy3Rl4ETefDxA=;
        b=JbXawQTMej4ZMT/j6ShlfUfDz9YcTUnviTjofpaPc0U2AXI6G5/Dibw2WJoPicxfOl
         PD6yQs3KT299uZso+KXU3OdwOIWD4Fl/9uZkawLfltN6zSmxvBpoZS69yPAElXqOPDld
         KcUSSDLHwb6TkLx7e1frpw9DBe0ruQ4U4rwIjfPpoXJv1bzcS3xNcMFjaTkAItlxMhj4
         yQPzURzyrcqO845ip3ine1OLp369XQdq17mhb/8QYdnjBudVrdYXN8uAriK4zpua+LHb
         HcDwKagytSfv1eoKHZb5+Sjpc4N2uC0VRL022vAL7N9x2x+7vVLPEDXjMkooT/ISrbrE
         KsGA==
X-Forwarded-Encrypted: i=1; AFNElJ/2dJbI1eB3j9ShOrC3xCKBAvix2Xi80WMBdJrw5PZpc4Qe7jRK71JE7Skhuv1cnG/hyVorSfro@vger.kernel.org
X-Gm-Message-State: AOJu0YxmHMuBoHCLVQA0iOywnbZM/DvUMwz1bwniBbB2GpWpah+JdfQx
	f/A0AeH9Bev6rbw43Hf+TxGFE3PS6SZD/3bCubVWOnSyCtc2z5Id1Q6K
X-Gm-Gg: AeBDieu+mDDvom+o7EIIFPqm5S+zQbnjBOq/TDizMIlElTT5FmMaQbDiLw6sY9nrGCL
	cczLSSBL3W1qGDzOutuU7phLk6fJI6C5NGDtTok5XN8ZItcm2kTs9d1RmZipVOlLDoNhssyQGJS
	YlF3Yx3SqUCtcERyV42gI9Y3D52Kn4th/un8Rhdbi2u6sXgG+/7RvXdITg21lrOzgHSsQQmK2Cc
	LzRqOtlKODgbFUR3MW2GkTlBK6Y6wXgAcbcqdCgTWBXhARhvwQaUxOtYsZ/Djeixeep+5vt2OgN
	IbU+u0tvrD5BHeiQhMYgmN0O2sAUtwSQfTYXMGZlIYNMt4Ev0uxFSEEQqm0s2TgNkTRTrmgnzjh
	BnZlImYykNm1EZZ2H4zsqEK6cYTGGHDy3BdVG1ipOv/zzQtQwyJ+wL5xTmiN1cCIEZ9es4o/vy/
	3+6CfF1go7ZTj5sXH4QwtE+w==
X-Received: by 2002:a54:4383:0:b0:45f:13ad:83c1 with SMTP id 5614622812f47-478a19124cbmr7485767b6e.51.1776198393796;
        Tue, 14 Apr 2026 13:26:33 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-478a0f1e841sm8167402b6e.5.2026.04.14.13.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 13:26:33 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Harry Yoo <harry@kernel.org>
Subject: Re: [PATCH v2] mm/percpu, memcontrol: Per-memcg-lruvec percpu accounting
Date: Tue, 14 Apr 2026 13:26:31 -0700
Message-ID: <20260414202631.2753640-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260404033844.1892595-1-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-15298-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E5BF3FE595
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri,  3 Apr 2026 20:38:43 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> enum memcg_stat_item includes memory that is tracked on a per-memcg
> level, but not at a per-node (and per-lruvec) level. Diagnosing
> memory pressure for memcgs in multi-NUMA systems can be difficult,
> since not all of the memory accounted in memcg can be traced back
> to a node. In scenarios where numa nodes in an memcg are asymmetrically
> stressed, this difference can be invisible to the user.
> 
> Convert MEMCG_PERCPU_B from a memcg_stat_item to a memcg_node_stat_item
> to give visibility into per-node breakdowns for percpu allocations.
> 
> This will get us closer to being able to know the memcg and physical
> association of all memory on the system. Specifically for percpu, this
> granularity will help demonstrate footprint differences on systems with
> asymmetric NUMA nodes.
> 
> Because percpu memory is accounted at a sub-PAGE_SIZE level, we must
> account node level statistics (accounted in PAGE_SIZE units) and
> memcg-lruvec statistics separately. Account node statistics when the pcpu
> pages are allocated, and account memcg-lruvec statistics when pcpu
> objects are handed out.

[...snip...]

> @@ -55,7 +55,8 @@ static void pcpu_free_pages(struct pcpu_chunk *chunk,
>  			    struct page **pages, int page_start, int page_end)
>  {
>  	unsigned int cpu;
> -	int i;
> +	int nr_pages = page_end - page_start;
> +	int i, nid;
>  
>  	for_each_possible_cpu(cpu) {
>  		for (i = page_start; i < page_end; i++) {
> @@ -65,6 +66,10 @@ static void pcpu_free_pages(struct pcpu_chunk *chunk,
>  				__free_page(page);
>  		}
>  	}
> +
> +	for_each_node(nid)
> +		mod_node_page_state(NODE_DATA(nid), NR_PERCPU_B,
> +				-1L * nr_pages * nr_cpus_node(nid) * PAGE_SIZE);
>  }
>  
>  /**
> @@ -84,7 +89,8 @@ static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
>  			    gfp_t gfp)
>  {
>  	unsigned int cpu, tcpu;
> -	int i;
> +	int nr_pages = page_end - page_start;
> +	int i, nid;
>  
>  	gfp |= __GFP_HIGHMEM;
>  
> @@ -97,6 +103,10 @@ static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
>  				goto err;
>  		}
>  	}
> +
> +	for_each_node(nid)
> +		mod_node_page_state(NODE_DATA(nid), NR_PERCPU_B,
> +				    nr_pages * nr_cpus_node(nid) * PAGE_SIZE);
>  	return 0;

Hello reviewers,

Since I submitted this, I have been thinking about the feedback that Sashiko
has given this patch [1]. Harry has already pointed out the points about
drifting due to CPU hotplug, but one there is one particular concern that
I have been trying to tackle with no avail.

The issue is, pcpu allocations for CPUs on node A may actually fall back to
node B, if node A is out of space and under pressure. This design seems to be
intentional, to prevent memory pressure from failing these allocations.

However, this means that we cannot charge percpu memory based on the number
of CPUs present on a node, because although the memory "belongs" to the node
(since the CPU it actually belongs to is on the node), the memory can be
serviced from elsewhere.

To handle this, I've tried several approaches. All of them were either too
expensive (iterating through all pages at allocation / free time) or introduces
new drift (I thought of managing per-chunk statistics as well).

To be honest, I think I'm out of ideas at this point :/ So I wanted to see
what others thought about how to track physical locations for pcpu allocations
that were allocated via fallback. Are these rare enough that we are OK with
the misattributing here? Should we eat the cost of iterating through all pages
to find out where it is physically?

Or is this patch not worth pursuing at the moment? ; -)

I hope this all makes sense. Thank you all in advance!
Joshua

[1] https://sashiko.dev/#/patchset/20260404033844.1892595-1-joshua.hahnjy%40gmail.com

