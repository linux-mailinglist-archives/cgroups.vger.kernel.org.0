Return-Path: <cgroups+bounces-16036-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QErFGe0qC2oNEQUAu9opvQ
	(envelope-from <cgroups+bounces-16036-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 17:06:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D473956F906
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 17:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CE363076169
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A223286D60;
	Mon, 18 May 2026 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU8Xsr5w"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B3B264A97
	for <cgroups@vger.kernel.org>; Mon, 18 May 2026 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116258; cv=none; b=QUq7fqvtpWWdNA23V7xWUSqS6tEN0GFR/AkCpnZ/xIW9Cl6iwCS45lxnRcwuy8BrvnO7ns7WCZZjDnM1ByLmSuTSIeCOvTpQxlW/NaNBz8GrdMFWGlXVv3mybbhCiLZPqU0KdWbmx/4OpKuF7jdlFsvY/55huzLZdBH8OzMPUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116258; c=relaxed/simple;
	bh=doEBG4FWrclg53f5OimQdkX3ilrMxQW1X1gRSd5DV78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCVGF+2yjdq5WAbSTwEQ5XKaL6qDy+esfsiJhcI05svvDxnXzjIZFFl8jOrNAIScmVCZhAi+xWLxFnNh3m3wyq9Iz093qkXv7ZgS0sv3jGVvSNzkEiUmcz5sd/uaZDptBJIJo9PRWoPe2owfXjvN+nUV6JM8MWY004bLfCvFIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nU8Xsr5w; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dcd17e19b6so1260890a34.1
        for <cgroups@vger.kernel.org>; Mon, 18 May 2026 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779116256; x=1779721056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmbgY/AtPm2PbN1vZM05ZA7u4q3A7BXOzAlynye04/o=;
        b=nU8Xsr5wmviWpbDJPIuaUnQFsjSu8q3t1SWhpqVVCTHjUbdIA/4BXvCg2jQ1IN3Nae
         7E/FvnnW8/J2pf9f23VBp7iaScKR1ZBUSzvbQHUcyQCzcOPLWn3jySo8Q4WMoPuLr0fC
         +i6DWe3wDSyrDyG+evVUa2enqYL4OSGOzfxfMHunMVVUYvRqnD7n0274753IR3Y4ul1W
         w70wcoL7YVwtjA9mlSllZ9BRbO0UZQAGs9kZGYEt5llh8v/QXhnyps8TzgqdKtar3zzd
         Fxpa8asej/R6gYjTeUq8WZA+hjIV5wqUDURMu+zbRmohSP8DmzI2L9osiySxL+Pz/eYg
         vPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779116256; x=1779721056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jmbgY/AtPm2PbN1vZM05ZA7u4q3A7BXOzAlynye04/o=;
        b=Lp+rmmBWRRBslN0eEtqC1lY/w+dGcmToqdevGQ5naHSOr/LIdPLfYlHgxoq9WLb+8y
         XnIrpviDLBlLguJMosd3iBU3ajG5+12kWlx1+qpVpw19EahEe2qCMYXOemr/d49YzOOF
         vHsn7Dv3iU/QiFOugNz3Jxk54ZDW88Z2b2JhrplzRaH3IzjEyTBw6angHmCk3D2M4VGg
         OcZk5forglWM4WNqwsAUJuTr5QXCGLVd9biIO/tVTGkriJ51wQypPw0PJH9qcrXElksZ
         mRocydTL8jPVZDkbhtXzHVdpq85iA1d8bGbyRl9oWBtb28yg1dlu/akjvsO14CNRZ7fe
         Cd5A==
X-Forwarded-Encrypted: i=1; AFNElJ/9zfKQDyrEDoz7NOgSgZZqC2GcgfA0SKgYS7HBs1299PeOegoFoTBxaNVz8ohPlvc62S4C2fRY@vger.kernel.org
X-Gm-Message-State: AOJu0YyHCIMasV7xpsC6Yx2xhLED/YTa8lr13LteZgwzJjAOYorfm4rc
	m+JjDBQimA4OcnSSBgwzSrvN0EWwmuSwfaBI9I4xNDbGIK8JKR7PHSGc
X-Gm-Gg: Acq92OHzuE747TsgRkL0XC9IHQikujR6Yv6vql90l9iBfbReB4ZdyuPBZjGx4STZv+m
	ffYtBskXXCfz3R0csQJU/+i/yuzR2dlZe6naM12SnLOGDZzi49UbTNT9h9S5+cCmVd/eCZSmZwI
	InV5oHiYvAzliRhthwv4E+Wokqes+EvL5vRgVQnDAr38aJFOCY7NQZMdyQHvX3OxqY7Ll7TtKtk
	S/V4TQ1mRKJlMWJkWQj/cpHgJie3vU5MXaqJff+CxPzdJmpgXlHYetFrXXcP+grHmO8txq1JtXO
	RRPLMFVVzbBj9oErONUPAomhPSYlR1+FO6CFLbLWBWk0/pxCGXa6rvPn211xGvoIvKTQ8b4N/As
	EnQ7jbXXQAZWgHEnj3JneYHltKdVYAu+HoQmNAaa/M/QZqd/Iy4ot+SIKrjuka9uhmdhL6x0mtS
	dhkchMxKngZhDL7Ir3cs2SUKUolYvSBnYDfW42xOQQAP4k4UYwUWHeRg==
X-Received: by 2002:a9d:454c:0:b0:7e5:b3f6:c6ad with SMTP id 46e09a7af769-7e5b3f6dde6mr59032a34.4.1779116255749;
        Mon, 18 May 2026 07:57:35 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bbd10aesm7741729a34.18.2026.05.18.07.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:57:35 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH 0/8] per-memcg-per-node kmem accounting
Date: Mon, 18 May 2026 07:57:32 -0700
Message-ID: <20260518145732.349196-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511202136.330358-1-alex@ghiti.fr>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16036-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linux.dev,gentwo.org,gmail.com,chromium.org,google.com,tencent.com,oracle.com,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ghiti.fr:email]
X-Rspamd-Queue-Id: D473956F906
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 11 May 2026 22:20:35 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:

> This series pursues the work initiated by Joshua [1]. We need kernel  
> memory to be accounted on a per-node basis in order to be able to  
> know the memcg and physical memory association.  
>   
> This series takes advantage of the recent introduction of per-node  
> obj_cgroup [2] and makes those obj_cgroup tied to their numa node.  
>   
> The bulk of the series is percpu per-node accounting: percpu  
> "precharges" the memcg before we know the actual location of the pages  
> it uses, so charging and accounting had to be split. All other kmem 
> users (slab, zswap, __memcg_kmem_charge_page) are straightforward 
> conversions (zswap support is limited in this series because Joshua 
> is working on it in parallel [3]). 
>  
> Thanks Joshua for your early feedbacks! 

Hello Alex,

Thank you for your work!

Overall I think the direction makes sense to me. Pre-overcharging makes sense to
me as an approach, we would much rather overaccount than underaccount and
later have to breach limits.

I do have some concerns on performance, though. Namely, I think there are
some expensive operations that I think would benefit from some performane
benchmarking with this patch added (maybe some simple microbenchmarks that
demonstrates kernel allocation overhead could be useful).

From what I can tell, there is some additional performance overhead that has
to do with iterating over num_possible_cpus() x pages_per_alloc, which
doesn't seem trivial to me.

Another concern that I see is the stock credit system. Maybe we could be
bypassing the stock check leading to more time spent doing the atomic
operations.

obj_stock caches a single obj_cgroup, which means that if we split the objcg
to be per-node (in patch 6), then the obj_stock basically gets invalidated
every operation since we iterate over more objcgs (even though we are in
the same logical objcg). Maybe I'm missing something?

I haven't taken a deep look at the implementation details but just wanted to
raise some high level items that I noticed. Of course, all of these concerns
are just theoretical, if you can show that the performance delta is not
noticable then all of my concerns don't matter.

I also want to talk more about the local credit system but let's first see
what the numbers are first.

Thanks again, Alex. And I really like patch 2 because it is a solution to
a problem that I ran into in my percpu tracking series that I couldn't think
of before! Thank you for solving my problem too : -)

Have a great day!
Joshua
   
> [1] https://lore.kernel.org/linux-mm/20260404033844.1892595-1-joshua.hahnjy@gmail.com/  
> [2] https://lore.kernel.org/linux-mm/56c04b1c5d54f75ccdc12896df6c1ca35403ecc3.1772711148.git.zhengqi.arch@bytedance.com/  
> [3] https://lore.kernel.org/linux-mm/20260311195153.4013476-1-joshua.hahnjy@gmail.com/
> 
> Alexandre Ghiti (8):
>   mm: memcontrol: propagate NMI slab stats to memcg vmstats
>   mm: percpu: charge obj_exts allocation with __GFP_ACCOUNT
>   mm: percpu: Split memcg charging and kmem accounting
>   mm: memcontrol: track MEMCG_KMEM per NUMA node
>   mm: memcontrol: per-node kmem accounting for page charges
>   mm: slab: per-node kmem accounting for slab
>   mm: percpu: per-node kmem accounting using local credit
>   mm: zswap: per-node kmem accounting for zswap/zsmalloc
> 
>  include/linux/memcontrol.h |  27 +++++--
>  include/linux/mmzone.h     |   1 +
>  include/linux/zsmalloc.h   |   2 +
>  mm/memcontrol.c            | 150 ++++++++++++++++++++++++++++---------
>  mm/percpu-internal.h       |  16 +---
>  mm/percpu.c                |  90 ++++++++++++++++++++--
>  mm/vmstat.c                |   1 +
>  mm/zsmalloc.c              |  11 +++
>  mm/zswap.c                 |   9 ++-
>  9 files changed, 242 insertions(+), 65 deletions(-)
> 
> -- 
> 2.54.0
> 
> 

