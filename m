Return-Path: <cgroups+bounces-13256-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAA9D26F70
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 18:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98FC133387B0
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 17:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCA23BFE37;
	Thu, 15 Jan 2026 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aN/rWVsZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033893C009C;
	Thu, 15 Jan 2026 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499218; cv=none; b=Kof/3mzYzXMj3YtY8s7xgbZp2GnYOHslN7WZ/18J93JwxoTHRtw6ndPx7zLohRFZtkpeQZ0MH6bXRT0j1c16nHaYmcUi5nIZBgn93jSgV5+97/J8ci+X+EUOMUYsMtI4QUDEYbatmWKeaSSOAVVhMPaw3vZZCzOjb3u+hkCiXZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499218; c=relaxed/simple;
	bh=KG3/QqkLWkU5xCkH5gCixEue8EH45XFlDtjNOlWXOCw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SzwvtS4y2EdxoGU68nzZnOTzn8x8oXEfjB5VtetbRL/3BU9MVpMKy3RrjUqATI5KaubEIKjXNXmzJc0Ww7A86Qlu/Dz1gNF35Ar9R8i8uj//N/S7SAi7U0jQXB4cM3epve8RbpKps/2tm/UbC22DqkGE6PrLGWzbKs2oUv7o3Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aN/rWVsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDABBC116D0;
	Thu, 15 Jan 2026 17:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768499217;
	bh=KG3/QqkLWkU5xCkH5gCixEue8EH45XFlDtjNOlWXOCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aN/rWVsZhxyQxbAGV6aAfpnyTBmZHYIcOKfGC1RzU/XnkFJoUcqg54DQMyMrB0bVx
	 e7Q3rJu95EnLHQbb+26Bk/i4pOpgX9n77m/D6KBtlYai56hGy0xSSBLcLZq8rFCmn1
	 GJBKhnpi889zYGezWxiSrkp5SyvbQsRcNyoihPAg=
Date: Thu, 15 Jan 2026 09:46:56 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 26/30 fix] mm: mglru: do not call update_lru_size()
 during reparenting
Message-Id: <20260115094656.d34a828cc6bde0e0f8511071@linux-foundation.org>
In-Reply-To: <20260115104444.85986-1-qi.zheng@linux.dev>
References: <92e0728fed3d68855173352416cf8077670610f0.1768389889.git.zhengqi.arch@bytedance.com>
	<20260115104444.85986-1-qi.zheng@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 18:44:44 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:

> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Only non-hierarchical lruvec_stats->state_local needs to be reparented,
> so handle it in reparent_state_local(), and remove the unreasonable
> update_lru_size() call in __lru_gen_reparent_memcg().
> 

Thanks, added as a squashable fix against "mm: vmscan: prepare for
reparenting MGLRU folios".

