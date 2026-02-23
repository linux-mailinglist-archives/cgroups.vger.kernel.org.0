Return-Path: <cgroups+bounces-14155-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF4UHIR/nGm6IQQAu9opvQ
	(envelope-from <cgroups+bounces-14155-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:25:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB56179B12
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F65E3054303
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C45730E0FB;
	Mon, 23 Feb 2026 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="nvqtzL9K"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609BB30BBA9
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863764; cv=none; b=ahz2xK9gmPvCS76m/JzYtiFTpGoykouFL6luzWF5JlDtHIx/oW2466vKemnnSuOeLcBg2yh8BhYUR5naHaYSWXfy5+nWzTdXMUFMAaakFRkuwiqIpvnVs/69dg4ZEwjwBMjKOywaisWxWKtlo5yJujKWu1/CkrrYuhGk51B1WBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863764; c=relaxed/simple;
	bh=35e9HdDJb4AUDgpu7r/tl4U0+emTTuw0XGe4LiUPG0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1Q70lM6AAaY2alpxwe9awShLHqw7TdirNbLPx91z/09BYQvoEpDgAB7d2F6fPdcLLqhhsfLWOjZwzLZyRTmkav0Wzu5t4Po+sFjfndVtu/w1qWz7rRAUF5qK67uHcx4OyInaWwU8Bora8luyoQWNJ/2mpKiHDVUHw0t1e44XhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=nvqtzL9K; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-89549b2f538so57004116d6.2
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 08:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1771863761; x=1772468561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ycxCWrwyhN+Wc3e1z7uOIm6Q5HGlQzORk9QGrhvwpg=;
        b=nvqtzL9K6Nv53x5RQeltg8zYIm/ozBMjKt3m0uKGdH5F3FDfYHbnU962vim3dyfNqc
         jlDC7B9FIbNbXIeoxs5iRG7o2qhBPqKTHPIX7lm1Gp33l+cdaeiKX2U3Sc3h0H+AyKG1
         qDoMR64B993gq9Az7X8JxB11cNkTMhmfltU3rRKdqF7prLsWx4GBOo2BQCaxH7RSlwV4
         Fxb3kjNpgwqLWsBeSqddNnqiBSpaEAqc//CKZ+ToSsWPAdYsfZ8xRIUU7zjJ0P6sh7XZ
         dlXltzGp8UYSQquRCdTo8SSX4F7qWbjezsWzdPE5Ap8pJpgvpL/JfG9q0UnEfbLL/Bsv
         aceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771863761; x=1772468561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ycxCWrwyhN+Wc3e1z7uOIm6Q5HGlQzORk9QGrhvwpg=;
        b=e/mfPy7mjyGBw3UOfrXVgXgoj5aXqJ0lGiowOrVwR7PXNxOyjjiyMotlUXUPSaOHfE
         Eur/GKpCKL48Doy/C2RzkaJMq8+hd7ZgyBqJo0iNLE4NaP0+pQi6eR/kALDU5FCcSwlf
         2I4ehZb8VlKu7oWiHVKLt8AkctpOKZ//yz6HVhgMmXZ3lTsKsFN2RTt+iwmD/Od04FiH
         N1q623fFdGhHhzH6r5/vfh0njtzmFmdCk5NqUAia6057j3fPme+xIUHokdBioAtxnZJ+
         FDIpjve/Q7YVmIrgofJyfmREW3Y7sob3DLl0eFFu1ive47Ls2rWrnCPNKYg7WVWlyug8
         q2EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFTSxXYGSEbWfRz7s+2ELLPhe3eyC1VOhxSfAVErRagYC66nRJTVjKrnysP8REGHm28mdgdeVt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8OlLHH+s97uUOb9WbuwQlkz6jRRte0cuZSCCM9xuNrohnaRVx
	NGjWp18xCbj6pEj5yBq/XRPvcTdHP2OSl0CpqLR+DUJhKJLizEuf1yCdzFX626gC8Mk=
X-Gm-Gg: AZuq6aLtA5zcKyYWzkXOj9QJbDueE0o7PFK8DrwiVVw4yWBmfI0x4swK7nAx2C89vX7
	ZXviVXLt2xYXsqicRreBz2uGrGVB83edPgJiBYXSrhlGCSpCamDwipQ41/EHt4D6KxpoP8Nolke
	p8wGzPpze6LHIAu6PCvGsLr5r3bVbGnBen06ybrRlzQ9ETPHZEbjxTPyn5hdJ0UW+lXrhLaIlmh
	7nM1dAR84kXH5U4yhaNXCp1doOBzNiZmD5BUgdTpL22Ra1g66yo3nyLd/brIimp/LaUqvH0CPqR
	FTa1/rxjNOT3DDyEyspwjeeOiXM+MeqmK03QMHACwWFc8kBUz3Q4itRAtcCGTqKtydDV38wNWFv
	JBGPQkBnmGOQQfK+xr2xDqCbKmISAcE4ptnet9Gs0c/KK0vz40daM4ciPJV0/pTpnJcEUydHVrh
	LK6mNHzbHm53xB1MoIIs9VEw==
X-Received: by 2002:a05:622a:1647:b0:502:f0fd:1837 with SMTP id d75a77b69052e-5070bcf94d5mr123459931cf.70.1771863760960;
        Mon, 23 Feb 2026 08:22:40 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d50c920sm73283081cf.7.2026.02.23.08.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:22:40 -0800 (PST)
Date: Mon, 23 Feb 2026 11:22:36 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Youngjun Park <youngjun.park@lge.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH RFC 06/15] memcg, swap: reparent the swap entry on swapin
 if swapout cgroup is dead
Message-ID: <aZx-zFmQmC0zoWKs@cmpxchg.org>
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
 <20260220-swap-table-p4-v1-6-104795d19815@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-swap-table-p4-v1-6-104795d19815@tencent.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14155-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,linux.dev,lge.com,bytedance.com,vger.kernel.org,tencent.com];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups,kasong.tencent.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cmpxchg.org:mid,cmpxchg.org:dkim,tencent.com:email]
X-Rspamd-Queue-Id: DCB56179B12
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 07:42:07AM +0800, Kairui Song via B4 Relay wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> As a result this will always charge the swapin folio into the dead
> cgroup's parent cgroup, and ensure folio->swap belongs to folio_memcg.
> This only affects some uncommon behavior if we move the process between
> memcg.
> 
> When a process that previously swapped some memory is moved to another
> cgroup, and the cgroup where the swap occurred is dead, folios for
> swap in of old swap entries will be charged into the new cgroup.
> Combined with the lazy freeing of swap cache, this leads to a strange
> situation where the folio->swap entry belongs to a cgroup that is not
> folio->memcg.
> 
> Swapin from dead zombie memcg might be rare in practise, cgroups are
> offlined only after the workload in it is gone, which requires zapping
> the page table first, and releases all swap entries. Shmem is
> a bit different, but shmem always has swap count == 1, and force
> releases the swap cache. So, for shmem charging into the new memcg and
> release entry does look more sensible.
> 
> However, to make things easier to understand for an RFC, let's just
> always charge to the parent cgroup if the leaf cgroup is dead. This may
> not be the best design, but it makes the following work much easier to
> demonstrate.
> 
> For a better solution, we can later:
> 
> - Dynamically allocate a swap cluster trampoline cgroup table
>   (ci->memcg_table) and use that for zombie swapin only. Which is
>   actually OK and may not cause a mess in the code level, since the
>   incoming swap table compaction will require table expansion on swap-in
>   as well.
> 
> - Just tolerate a 2-byte per slot overhead all the time, which is also
>   acceptable.
> 
> - Limit the charge to parent behavior to only one situation: when the
>   swap count > 2 and the process is migrated to another cgroup after
>   swapout, these entries. This is even more rare to see in practice, I
>   think.
> 
> For reference, the memory ownership model of cgroup v2:
> 
> """
> A memory area is charged to the cgroup which instantiated it and stays
> charged to the cgroup until the area is released.  Migrating a process
> to a different cgroup doesn't move the memory usages that it
> instantiated while in the previous cgroup to the new cgroup.
> 
> A memory area may be used by processes belonging to different cgroups.
> To which cgroup the area will be charged is in-deterministic; however,
> over time, the memory area is likely to end up in a cgroup which has
> enough memory allowance to avoid high reclaim pressure.
> 
> If a cgroup sweeps a considerable amount of memory which is expected
> to be accessed repeatedly by other cgroups, it may make sense to use
> POSIX_FADV_DONTNEED to relinquish the ownership of memory areas
> belonging to the affected files to ensure correct memory ownership.
> """
> 
> So I think all of the solutions mentioned above, including this commit,
> are not wrong.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Those semantics look good to me. I think it's better than the status
quo, actually.

