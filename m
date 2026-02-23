Return-Path: <cgroups+bounces-14158-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNAbNOeFnGm7IwQAu9opvQ
	(envelope-from <cgroups+bounces-14158-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:52:55 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E571F17A2BC
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B48283014F4B
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 16:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD996315785;
	Mon, 23 Feb 2026 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="MwyrwpKj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1667F31578E
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865548; cv=none; b=Lxmq7JVOZZ3jcGPQlTpTIaTcOTqxF9dGD7sD7hFrYSaKuqMIaC8cmfKeZOH3M9e7LMM8AA4cskUZ9+SRPiP6jMl8nmxjeJfzAJpX7IL07hbcHCIvi9r11/7UokyQhoWDI5WcPhCXXgXOJIYTJt9E8Qb5LEZsmoR0P7vOfBHwF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865548; c=relaxed/simple;
	bh=bx3iOV2ugLkpdJZcrJoQAabRqUf12TYssE63qknpYWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwTIyhqGNLaykEwzbaLFz76yvmZw2Czs8n8BFNFNMo7t+Oa9AJq6xIk0L1DKUVu3Pu11zDFBQBlnorGNld4Fx2VvjEocHnGBboN78XrS83UdkfiGHDzRYGw3JPw3HdB3sgIXr29w8SMQapiKhyJ0yYnSPJwYy7exRUEUlDRnzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=MwyrwpKj; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5062fc5d86aso43845311cf.1
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 08:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1771865545; x=1772470345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9p76BczVPf+ipMBZjWxZMf67W68G0E63s5eoAZ2wq80=;
        b=MwyrwpKjTdGFMtlIkDgFe4CxRoHf4akYRISDvmQPogMk4uSdA6gfs/AQiUF8pgkpCG
         1vUsb/ojyoQl5N6b2t9ngti5es99Zaq+MavSe/sBmLZDMj6DNWMkZ0Wt7BfGnpHwRRhA
         woI/RHrqNMMlgTrTkLssXA58M0IYm566Db2/8yU9tzS4ZFCmNI2A3/jQZFeXcYfKzAcV
         4IncVJqUihnnNyWiiWOY5YxGaqzUqYtxWh/cpTpbuJz2DoAsMYEhfjAQfLoMUg6InhX9
         seczxcxkbeEaH8Y1Hy2Ab6DTrrEm0FM14cH3n7fZcwFFcXIVjD85V8EFCKe0GKfz2MwW
         f55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771865545; x=1772470345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9p76BczVPf+ipMBZjWxZMf67W68G0E63s5eoAZ2wq80=;
        b=paII1qTxjVNy/MpQArxwSKVmyC2WC0YQcBTYSY9bmkodysJgjUmYEqr5rSBAWnQbLe
         MotLzwu6OuBrpPaUPv12k8JKIkmunOsaulhoz0ML1aRd8T4b/IlQE366vrw6u/iXYP2l
         iBytlRfa6i/IWOpf0loRR0sOEeLgglJ6UksWYsnQ6MAzA2OE0ItOTAqWXPL2V6v4taBX
         eim89J6mcAUiy19BC34Z4QvhlaGNWJ7sH/sBvC9AjUr8+kJI5r9oNrsq0pLfgeeOzGIu
         7aruKZdA7qZoG8AdXOpq5gdaoThnZw3P5oWeOesNI1eqf5kSxA2HnNsTUnsFl9w+qhqj
         IdIA==
X-Forwarded-Encrypted: i=1; AJvYcCWxCUwtja611l2qoUJT+Vbdqx0jt2Iwgdz42n+DXXn/jo0ucVQlF4T90l0oQJNXCG3BvmWNRMxi@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDjkSArGzmY7u4rVOUiXf+D8efG87WZim/65nj0/9COei65EQ
	cj8LfDXD3LZAgQz0yksHsf42nEimWDxR11nO/SE59fKa3luaiqlISBYQuqfw0HheAbo=
X-Gm-Gg: AZuq6aJXeVUBm4NyGfm5BYFsVrmcr4s5/LBZN0jafFQI2BPjwoglpBMxlBY+lvNT8Ln
	JBzSB+0zkzIrW8uJjtViGsUIIzi0r/T1VekqlvYExBjFmDYCHVPCILaMFnIZDq7BpE5g/6YyNWE
	I4yZm9MdrEoI+8s35JdIMMPWx+7+UkqKfQVOdWOveztlX1yOXl8lnvirV0GReGFdAm0Kv+Dcvmg
	pLOA0ECUHzezqm+yyxMvJLaefW9fPz0Z+80uAGimbl0iq0NdnH32nMyt2FaaF2dl3EipepM1lvI
	InyGc01XJaeDxNESjpOlBg1txdti8soqhtp4HrF+FSLFrOxuk5xRvDn5xIeODkh8Y0fkTevjpmi
	b/oTzYCa6gr29sVlyC50bAGgA+rfRjdGvrYMS/Oxa3WMrXOkPEm64N2PLDrN3n1YmQOmESqK9FD
	SzLgopYTSqdrqq1Y4zD+xrMQ==
X-Received: by 2002:a05:622a:11ce:b0:501:4859:c7aa with SMTP id d75a77b69052e-5070bbab6a2mr133092191cf.20.1771865544833;
        Mon, 23 Feb 2026 08:52:24 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5072afdef0bsm4637311cf.16.2026.02.23.08.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:52:24 -0800 (PST)
Date: Mon, 23 Feb 2026 11:52:20 -0500
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
Subject: Re: [PATCH RFC 00/15] mm, swap: swap table phase IV with dynamic
 ghost swapfile
Message-ID: <aZyFxKGXc8J6PIij@cmpxchg.org>
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14158-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cmpxchg.org:mid,cmpxchg.org:dkim]
X-Rspamd-Queue-Id: E571F17A2BC
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 07:42:01AM +0800, Kairui Song via B4 Relay wrote:
> - 8 bytes per slot memory usage, when using only plain swap.
>   - And the memory usage can be reduced to 3 or only 1 byte.
> - 16 bytes per slot memory usage, when using ghost / virtual zswap.
>   - Zswap can just use ci_dyn->virtual_table to free up it's content
>     completely.
>   - And the memory usage can be reduced to 11 or 8 bytes using the same
>     code above.
>   - 24 bytes only if including reverse mapping is in use.

That seems to tie us pretty permanently to duplicate metadata.

For every page that was written to disk through zswap, we have an
entry in the ghost swapfile, and an entry in the backend swapfile, no?

> - Minimal code review or maintenance burden. All layers are using the exact
>   same infrastructure for metadata / allocation / synchronization, making
>   all API and conventions consistent and easy to maintain.
> - Writeback, migration and compaction are easily supportable since both
>   reverse mapping and reallocation are prepared. We just need a
>   folio_realloc_swap to allocate new entries for the existing entry, and
>   fill the swap table with a reserve map entry.
> - Fast swapoff: Just read into ghost / virtual swap cache.

Can we get this for disk swap as well? ;)

Zswap swapoff is already fairly fast, albeit CPU intense. It's the
scattered IO that makes swapoff on disks so terrible.

> The size of the swapfile (si->max) is now just a number, which could be
> changeable at runtime if we have a proper idea how to expose that and
> might need some audit of a few remaining users. But right now, we can
> already easily have a huge swap device with no overhead, for example:
> 
> free -m
>                total        used        free      shared  buff/cache   available
> Mem:            1465         250         927           1         356        1215
> Swap:       15269887           0    15269887

I'm not a fan of this. This makes free(1) output kind of useless, and
very misleading. The swap space presented here has nothing to do with
actual swap capacity, and the actual disk swap capacity is obscured.

And how would a user choose this size? How would a distribution?

The only limit is compression ratio, and you don't know this in
advance. This restriction seems pretty arbitrary and avoidable.

There is no good technical reason to present this in any sort of
static fashion.

