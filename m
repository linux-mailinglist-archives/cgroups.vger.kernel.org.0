Return-Path: <cgroups+bounces-11657-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5D8C3E3EB
	for <lists+cgroups@lfdr.de>; Fri, 07 Nov 2025 03:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA7D94E3215
	for <lists+cgroups@lfdr.de>; Fri,  7 Nov 2025 02:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6BD2D8DD9;
	Fri,  7 Nov 2025 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bxrEYTaX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D5B282F5;
	Fri,  7 Nov 2025 02:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762482592; cv=none; b=hUF94vt4kq+oJKNjuiU3PUhGXK6rKwGc7m0Xxh/M6nHwvHSgWBrAyPLGEtyyluBemr9dLXrxIG/aUq3A9S1+q4ZyV9vJILi0TlWToPE7HNkJ9QK66sG8JgK8/SCJffw3RcbnoRsas1PMV6zfhhZ6F76xs2WkqHCNuHbmbq1nkmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762482592; c=relaxed/simple;
	bh=Yv7Dow2fFXN3wdJAsNrWkVg7HvQAvwMM83WA7IZetx8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tBrCOsS136yVnfTs7AUCt75v4ElgKwqffLxTg8Pjcr9e5wqwXZBXhLF+e4Kau/8Oy9R3hLNSPGTPVvzP6LNgfFw9P3ud+XOj/g9veDxfrvjNGeVyzsSfgl8LkZ4kK9gyx8QNBJ4zk2V/txD9DY8hWoBOqrqWgCduWrk8trlHGjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bxrEYTaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E61DC116C6;
	Fri,  7 Nov 2025 02:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762482591;
	bh=Yv7Dow2fFXN3wdJAsNrWkVg7HvQAvwMM83WA7IZetx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bxrEYTaXZiAEAf3Utu4PW8YAwIaQineyjR3u7q/cUBGMZCTM+t8+TCK2YyBhyq4Fo
	 fBtyH6kpFZuZcPr87ylM9PlvXxD5mEZlWPJfSKonQ4jdORR1QFF8uMm6/u/j/0klNL
	 0pXMNSwkyBLwOmRP/xZOPLsBfL6Qt4q+PzctlPoM=
Date: Thu, 6 Nov 2025 18:29:49 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Muchun Song <songmuchun@bytedance.com>, Qi Zheng
 <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 3/4] mm: thp: use folio_batch to handle THP splitting
 in deferred_split_scan()
Message-Id: <20251106182949.1ffd6f5529aa18139f2ba9f3@linux-foundation.org>
In-Reply-To: <20251106145213.jblfgslgjzfr3z7h@master>
References: <cover.1760509767.git.zhengqi.arch@bytedance.com>
	<4f5d7a321c72dfe65e0e19a3f89180d5988eae2e.1760509767.git.zhengqi.arch@bytedance.com>
	<20251106145213.jblfgslgjzfr3z7h@master>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 14:52:13 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> >+		if (folio_order(folio) > 1) {
> >+			if (!list_empty(&folio->_deferred_list)) {
> >+				ds_queue->split_queue_len--;
> >+				/*
> >+				 * Reinitialize page_deferred_list after removing the
> >+				 * page from the split_queue, otherwise a subsequent
> >+				 * split will see list corruption when checking the
> >+				 * page_deferred_list.
> >+				 */
> >+				list_del_init(&folio->_deferred_list);
> >+			}
> > 			if (folio_test_partially_mapped(folio)) {
> > 				folio_clear_partially_mapped(folio);
> > 				mod_mthp_stat(folio_order(folio),
> > 					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
> > 			}
> >-			/*
> >-			 * Reinitialize page_deferred_list after removing the
> >-			 * page from the split_queue, otherwise a subsequent
> >-			 * split will see list corruption when checking the
> >-			 * page_deferred_list.
> >-			 */
> >-			list_del_init(&folio->_deferred_list);
> 
> @Andrew
> 
> Current mm-new looks not merge the code correctly?
> 

It happens.  We presently have 29 patches which alter mm/huge_memory.c.

Thanks for checking.  I'll drop version 5 of "reparent the THP split queue".

Please check what remains, and send a v6 against tomorrow's
mm-new/mm-unstable.

