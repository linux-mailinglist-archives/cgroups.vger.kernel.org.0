Return-Path: <cgroups+bounces-8052-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E952AAD274
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 02:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C083A9A6D
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 00:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9BE57C9F;
	Wed,  7 May 2025 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CkQtGhw/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5232C9D;
	Wed,  7 May 2025 00:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746579201; cv=none; b=BtmGa86E8a2IH+AbacxraDLyDda1fvWIFJ0aFyQjJhNkOoZrf3VYE2rdgUC74dDwW2yDB2HbLciV5LrUfPmKoZpOwnaYd9ERe8GP1bK4yzLTcj1weZfaoGE9VIzc+UjgjdWwEUNsPFk07BS8z/xWivQxz3sPcKWELYoyH/FnNXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746579201; c=relaxed/simple;
	bh=JwkdJHtqnzvr9ic2vjKO3jhMa3Gd1ozvG9IU1T7YEhg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ApVGp8+JcAE45CPwZfrRFlRxdVaFROTIZM6R4HAQ6x31VP/2yyZ3oWNC3fO8K2SipmGBsRrN2mPDuOUnSDUpWavB1bvII703Ychbamn7lsHS1Q6hduurYfnbfWNm8335nKfXMBYSB/PuVLZEML6IOyFHyanlK14GgyneTosHVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CkQtGhw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53F1C4CEE4;
	Wed,  7 May 2025 00:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746579197;
	bh=JwkdJHtqnzvr9ic2vjKO3jhMa3Gd1ozvG9IU1T7YEhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CkQtGhw/Yd9EkUf7MUO1G7J3nDCeeAlvtshzPKG5RPDaGLCAv5ipdLxRpGQN64lFS
	 S4t9XscXFAttV98w3NZsr2iIroFrSMbxknG1qvzju6HNRXZXQ3y8QhypNC1KDpSbbU
	 SwtMVkmbjHcUjisQaJ2Ac/JoguSKXTG8xHqtE5mw=
Date: Tue, 6 May 2025 17:53:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song
 <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, Greg
 Thelen <gthelen@google.com>, Michal =?ISO-8859-1?Q?Koutn=FD?=
 <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>, Yosry Ahmed
 <yosry.ahmed@linux.dev>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3] memcg: introduce non-blocking limit setting option
Message-Id: <20250506175316.1ca96d3aab2a28086fffa33a@linux-foundation.org>
In-Reply-To: <20250506232833.3109790-1-shakeel.butt@linux.dev>
References: <20250506232833.3109790-1-shakeel.butt@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Thanks, I queued this as a -fix:


--- a/Documentation/admin-guide/cgroup-v2.rst~memcg-introduce-non-blocking-limit-setting-option-v3
+++ a/Documentation/admin-guide/cgroup-v2.rst
@@ -1299,12 +1299,17 @@ PAGE_SIZE multiple when read back.
 	monitors the limited cgroup to alleviate heavy reclaim
 	pressure.
 
-        If memory.high is opened with O_NONBLOCK then the synchronous
-        reclaim is bypassed. This is useful for admin processes that
-        need to dynamically adjust the job's memory limits without
-        expending their own CPU resources on memory reclamation. The
-        job will trigger the reclaim and/or get throttled on its
-        next charge request.
+	If memory.high is opened with O_NONBLOCK then the synchronous
+	reclaim is bypassed. This is useful for admin processes that
+	need to dynamically adjust the job's memory limits without
+	expending their own CPU resources on memory reclamation. The
+	job will trigger the reclaim and/or get throttled on its
+	next charge request.
+
+	Please note that with O_NONBLOCK, there is a chance that the
+	target memory cgroup may take indefinite amount of time to
+	reduce usage below the limit due to delayed charge request or
+	busy-hitting its memory to slow down reclaim.
 
   memory.max
 	A read-write single value file which exists on non-root
@@ -1323,12 +1328,17 @@ PAGE_SIZE multiple when read back.
 	Caller could retry them differently, return into userspace
 	as -ENOMEM or silently ignore in cases like disk readahead.
 
-        If memory.max is opened with O_NONBLOCK, then the synchronous
-        reclaim and oom-kill are bypassed. This is useful for admin
-        processes that need to dynamically adjust the job's memory limits
-        without expending their own CPU resources on memory reclamation.
-        The job will trigger the reclaim and/or oom-kill on its next
-        charge request.
+	If memory.max is opened with O_NONBLOCK, then the synchronous
+	reclaim and oom-kill are bypassed. This is useful for admin
+	processes that need to dynamically adjust the job's memory limits
+	without expending their own CPU resources on memory reclamation.
+	The job will trigger the reclaim and/or oom-kill on its next
+	charge request.
+
+	Please note that with O_NONBLOCK, there is a chance that the
+	target memory cgroup may take indefinite amount of time to
+	reduce usage below the limit due to delayed charge request or
+	busy-hitting its memory to slow down reclaim.
 
   memory.reclaim
 	A write-only nested-keyed file which exists for all cgroups.
_


