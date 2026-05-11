Return-Path: <cgroups+bounces-15784-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLHoHfE6AmrmpAEAu9opvQ
	(envelope-from <cgroups+bounces-15784-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:24:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E54C8515CC7
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07632309DC62
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BCD3822AA;
	Mon, 11 May 2026 20:21:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF73859EC;
	Mon, 11 May 2026 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530917; cv=none; b=P1Qtb1KE4voGnBPa3w3pm8QfnjGsDMnmhDwAds5AaYWNUW+NTCD+WQ1/xRdSspPcO+GxjVKyOxIiYa7w6y1iw7ACgAzTBhTNfGY0XiYGppijbpUD0swNdZ0FdNRpgoFH6SZBlKBxfTyccSn2KZrcb2KcFaLZfannrF5LC0rQFFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530917; c=relaxed/simple;
	bh=hKa11nughbzuCN4WrwZgufv36HjYjsG2DmBz37UsXeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k0mZ6wwb/RlGt3p7DMwAAQrfUW6B8l/+LDFHTTCtLlDnkfw89tNFd5l0gzNBYsJMk2es63/eKaVNvhxO2afrvS9VZ7VD4Ssn18YspvqhqU6dSubXmKKXx/pjuFcNdGOgngmElGYSoMx1Ok7pJ0d2iF9yYtGu06TpifdrXUD4mMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF23F205EF;
	Mon, 11 May 2026 20:21:42 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Barry Song <baohua@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 0/8] per-memcg-per-node kmem accounting 
Date: Mon, 11 May 2026 22:20:35 +0200
Message-ID: <20260511202136.330358-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGquq6RgtNh3qAAxG94VEBK0qIBmDDtoo/Zzcjxcpub7oP1RvXprwh05ms8DIfSfYwk911N5nCX8LFMrx+zdijkay9SXXntyv3aAc2iYuK82uOnILo39/ReHTeKjYXm2jGDzj68yb3e64ySMICR8r5EDpQfqweR7crbFhK6YXiJ7WFWpOlFkz3nekraGBCR5kMb/hNFVRvdHlEskriYh9kOGsO7rEwRpKjYyVoNiiy40BNfc9dBXB6YhrOqKB5AkYQMXuyJAZmvwH4eZjWFTuLv2jQRdJxTA/HZi9ea1FJrc1hijrQl0nHC6ck2jD0ovPyV7rEmReY6PE3doqmNCxTsbJEYcgA88Zrr0xTNFHihxWAOLqgB4q9gdAXWnvGoZFOJXgAidn8qkUEIKHmb9vlfi0hYKxVd1R35cjil0UNpgd7IJGSULKtAerOMBKojfvoZpyAfuhwFmVKa+gB7CnRafXK0eBHVaGg1YScD6eb6l7Au0fU3b9fbLDh5Vlxuo8AeIC3eGs0PVHsHUepf70VednVQcovy6ss1tDjxEfQkdL3XbO594VcmGuQUjBLoJDrnhZ3qLy+AxfhNziJlITymzO5LlxHLSxCOiIIsTlKXRYryU74AKwOrcm2OOR/cAIuoT24rgTPQ0osWEsXawRBnIVXx6t7T4+FbV6VaV7J1iQ
X-Rspamd-Queue-Id: E54C8515CC7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[ghiti.fr];
	TAGGED_FROM(0.00)[bounces-15784-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.375];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,gentwo.org,gmail.com,chromium.org,google.com,tencent.com,oracle.com,kvack.org,vger.kernel.org,ghiti.fr];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ghiti.fr:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series pursues the work initiated by Joshua [1]. We need kernel  
memory to be accounted on a per-node basis in order to be able to  
know the memcg and physical memory association.  
  
This series takes advantage of the recent introduction of per-node  
obj_cgroup [2] and makes those obj_cgroup tied to their numa node.  
  
The bulk of the series is percpu per-node accounting: percpu  
"precharges" the memcg before we know the actual location of the pages  
it uses, so charging and accounting had to be split. All other kmem 
users (slab, zswap, __memcg_kmem_charge_page) are straightforward 
conversions (zswap support is limited in this series because Joshua 
is working on it in parallel [3]). 
 
Thanks Joshua for your early feedbacks! 
  
[1] https://lore.kernel.org/linux-mm/20260404033844.1892595-1-joshua.hahnjy@gmail.com/  
[2] https://lore.kernel.org/linux-mm/56c04b1c5d54f75ccdc12896df6c1ca35403ecc3.1772711148.git.zhengqi.arch@bytedance.com/  
[3] https://lore.kernel.org/linux-mm/20260311195153.4013476-1-joshua.hahnjy@gmail.com/

Alexandre Ghiti (8):
  mm: memcontrol: propagate NMI slab stats to memcg vmstats
  mm: percpu: charge obj_exts allocation with __GFP_ACCOUNT
  mm: percpu: Split memcg charging and kmem accounting
  mm: memcontrol: track MEMCG_KMEM per NUMA node
  mm: memcontrol: per-node kmem accounting for page charges
  mm: slab: per-node kmem accounting for slab
  mm: percpu: per-node kmem accounting using local credit
  mm: zswap: per-node kmem accounting for zswap/zsmalloc

 include/linux/memcontrol.h |  27 +++++--
 include/linux/mmzone.h     |   1 +
 include/linux/zsmalloc.h   |   2 +
 mm/memcontrol.c            | 150 ++++++++++++++++++++++++++++---------
 mm/percpu-internal.h       |  16 +---
 mm/percpu.c                |  90 ++++++++++++++++++++--
 mm/vmstat.c                |   1 +
 mm/zsmalloc.c              |  11 +++
 mm/zswap.c                 |   9 ++-
 9 files changed, 242 insertions(+), 65 deletions(-)

-- 
2.54.0


