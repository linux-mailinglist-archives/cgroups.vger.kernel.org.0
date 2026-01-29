Return-Path: <cgroups+bounces-13526-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK20JmXke2nBJAIAu9opvQ
	(envelope-from <cgroups+bounces-13526-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 23:51:17 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D04B5850
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 23:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED6FF3049EDB
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 22:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796AF36B05E;
	Thu, 29 Jan 2026 22:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKDYP9I+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCF36B059
	for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726971; cv=none; b=gJdHK8XS4l1WT+Wan/lqO04lhl6Uo+iDgI/naOTCO5WaTwknbrA34Q8VmP4FJ+PuTzdY8vR5ibY8cCS9RUMZ7sXV/d3BsB5xERfOsmUDlfvQn2/gRLhhFax0uMNu2vwfAewwQdzo73UdX0zv4/+bnqWJe0DnzPJLNOVKiNbRm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726971; c=relaxed/simple;
	bh=0vN9vE+Xxz2aoRvKyShdy8kl+S0ypCq/XVsfcQDkNSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cp4wmzFh12G6y8orfYi/DInY/vOvwSk3cxP4sjS3uOLXAxyf4OpPrucFmaQvFTV47AZSbouObCubDyRh1Mgp1GRmEUkfhQYxbfOa4UciB3kKYN6Cx2YjSl+A2l7p/3TFWGFFY4an3GvioylbLd2hwO0zYaY6iFHr+OiTgBT+hFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKDYP9I+; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so922181f8f.3
        for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 14:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769726968; x=1770331768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHnhQSU7iuKe1wvcKkKvWgrmHsO0QtdxT1/2Mr9iW+U=;
        b=LKDYP9I+sm065m/MPfN4jfp2GCp2N2AcAqK3AAgOlktJcYhztb6sYV+g/DejNUGXSb
         pI0tU8ZELGtl2vDqooj2Lr4oh6u38yuJkNVM6vwy7I6H2gwdVgVfr5LjdZy1crMuYqDt
         /QZPofQJiHf1ZupnnSYsLASWoRLsNzXUdi5tIbgoobsYQOlAcWgP7hWx3Gv9kTClnMgd
         xkwZxmwFSEcnb1SeB31ceCHkzStbdlk1RhQpvSAucb9pHE6hfK5w5Q5LimAXlA977jDn
         U7UnYoHYBwHA1QC7zwPFCRsYooffXW/2UtxutGf10yJxCHoDMQumYuJYhJE4ypK9o28G
         hIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769726968; x=1770331768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHnhQSU7iuKe1wvcKkKvWgrmHsO0QtdxT1/2Mr9iW+U=;
        b=tCGS6/n4ZT0NnmzjLDbMvMtFgoQMjtlz58y9pEcwOGa1UAFXaDK+cNReBC7mr0R7P1
         YjH6URryOXOuJx+XGzQ1/+H9I4jgqxGK64gDBute7QwFZjrtcyUnODIxIKwa2CXGsTnl
         eNBWIAjlJ/DmegFrmty2sJcM8x7+Hs53hoZHV2LXbQj/jdAUofYG/vM70Oc/gIScmBPw
         p/cvzzKPwE7OyySW3VjE/bzy04kr1rJUwRb1O/DlWltQ9Gc7IpGotIav+q7/b3HF/4VS
         EwtjgZANmA632qvtycglto6RqHo154lwmsuvYq0RPq9S5zVc4kpczEwE1I6w++CgSZJe
         p8Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVIlYFSbwjXR8GBcfha8IawpSl23g/DTxJ0RjTrgLcvJLespgQjdl5x9l9dIaZvcxZSYSEjFnlk@vger.kernel.org
X-Gm-Message-State: AOJu0YyFk+KvUMjM985OCU8pDvLpiGaGZyBckJRpJd64stS92ZDvxaco
	VJDq5Lo+oSR3rVYWfisn+mG/MPXuZRF1juIvTylJF84vqBZynVWPbxQx
X-Gm-Gg: AZuq6aK6X/l2MLcXUz75l+OmLPIacPsTzas6nwIr1HpIPRRfymMeJ+hBc0hbu7zK88H
	BLQX7W4t5mLR6iAK6nW0CmboL3VD6ZaSj/fZruln7Nh4ZwuClPfWJHW/9l3DdhRGJanKMpM7Wz8
	M8xGcI3tiWLVNiGDiIqCYacG27rky2Y45/7fGXkP4LBbFkbfRrEby5+uGfG7D++Yw0qkyfcspDe
	BUdUGE6IpI4ZN3AJOAzW3SpvtOYQShy+pk77JsZG1UxCM6bB4ErCGMvPQfH30wEEinIjMCFwhFn
	RjSD5wZ+n/10pWrvhD8IB18y/3NT16GlwKJWcZ/NCFRTZm4jOz4JO47upEBkCnDlhEHQs4rLuzb
	AbVcwYcciuhDOUBoe3ul1F8G1uvirEcKieb1IEZtZOnPenYV6aH1T7/ZAo1hbZjY6TmiHpLBUKX
	IjOiFCMNMxgNC6YA8Z2adBjwYlXJq8vhkSJk2CGrBKIP0gfhxLsAXOFVrwONglG5XS8Fb0leGIR
	iVCRX4VNDWXZ20=
X-Received: by 2002:a05:6000:26c9:b0:435:9756:d4c4 with SMTP id ffacd0b85a97d-435f3a7bcd0mr1743299f8f.17.1769726967582;
        Thu, 29 Jan 2026 14:49:27 -0800 (PST)
Received: from ?IPV6:2a02:6b6f:e752:5600:1cf6:3834:b349:c738? ([2a02:6b6f:e752:5600:1cf6:3834:b349:c738])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1353ac2sm19060165f8f.38.2026.01.29.14.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 14:49:26 -0800 (PST)
Message-ID: <fd9d20c3-1bc0-4bad-bc5e-7d9549ddf8fa@gmail.com>
Date: Thu, 29 Jan 2026 22:49:26 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: khugepaged: fix NR_FILE_PAGES accounting in
 collapse_file()
Content-Language: en-GB
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Rik van Riel <riel@surriel.com>,
 Song Liu <songliubraving@fb.com>, Kiryl Shutsemau <kas@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Meta kernel team <kernel-team@meta.com>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260129184054.910897-1-shakeel.butt@linux.dev>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20260129184054.910897-1-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13526-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usamaarif642@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1D04B5850
X-Rspamd-Action: no action



On 29/01/2026 18:40, Shakeel Butt wrote:
> In META's fleet, we are seeing high level cgroups with zero file memcg
> stat but their descendants have non-zero file stat. This should not be
> possible. On further inspection by looking at kernel data structures
> though drgn, it was revealed that the high level cgroups have negative
> file stat which was aggregated from their children.
> 
> Another interesting point was that this specific issue start happening
> more often as we started deploying thp-always more widely which
> indicates some correlation between file memory and THPs and indeed it
> was found that file memcg stat accounting is buggy in the collapse code
> path from the start.
> 
> When collapse_file() replaces small folios with a large THP, it fails to
> properly update the NR_FILE_PAGES memcg stat for both the old folios
> being freed and the new THP being added. It assumes the old and new
> folios belong to the same cgroup. However this assumption breaks in
> couple of scenarios:
> 
> 1. Binary (executable) package downloader running in a different cgroup
>    than the actual job executing the downloaded package.
> 
> 2. File shared and mapped by processes running in different cgroups. One
>    process read-in the file and the second process either through
>    madvise(COLLAPSE) or khugepaged on behalf of second process
>    collapsing the file.
> 
> So, the current code has two bugs:
> 
> 1. For non-shmem files, NR_FILE_PAGES is never incremented for the new
>    THP because nr_none is always 0 for non-shmem, and the stat update is
>    inside the "if (nr_none)" block.
> 
> 2. When freeing old folios, NR_FILE_PAGES is never decremented because
>    folio->mapping is set to NULL directly without calling
>    filemap_unaccount_folio().
> 
> These bugs cause incorrect per-memcg accounting when the process
> triggering the collapse (MADV_COLLAPSE or khugepaged) belongs to a
> different memcg than the process that originally faulted in the pages:
> 
>   - Process A (memcg X) reads file, creating 512 small page cache folios
>     charged to memcg X (NR_FILE_PAGES += 512 for memcg X)
> 
>   - Process B (memcg Y) triggers collapse via MADV_COLLAPSE or khugepaged
>     scans B's mm. The new THP is charged to memcg Y.
> 
>   - Old folios freed: NR_FILE_PAGES not decremented (bug)
>     New THP added: NR_FILE_PAGES not incremented (bug)
> 
>   - Later, THP removed from page cache: NR_FILE_PAGES -= 512 for memcg Y
> 
> Result: memcg X has +512 inflated pages, memcg Y has -512 (negative!)
> 
> Fix this by:
> 1. Always incrementing NR_FILE_PAGES by HPAGE_PMD_NR for the new THP
> 2. Decrementing NR_FILE_PAGES for each old folio before clearing its
>    mapping pointer
> 
> For shmem with holes (nr_none > 0), the net change is still +nr_none
> since we decrement (HPAGE_PMD_NR - nr_none) old pages and increment
> HPAGE_PMD_NR new pages.
> 
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev

Acked-by: Usama Arif <usamaarif642@gmail.com> 

