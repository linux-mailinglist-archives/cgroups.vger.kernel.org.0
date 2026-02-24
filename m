Return-Path: <cgroups+bounces-14198-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MYfNcwInWk7MgQAu9opvQ
	(envelope-from <cgroups+bounces-14198-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 03:11:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD52180EDE
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 03:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 148A2304925B
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 02:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589BD25785D;
	Tue, 24 Feb 2026 02:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7zs6DzT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB6424A07C
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771899082; cv=pass; b=upH9kox4o+6Ru/aC8N54Y/UD6xjteIqumXO/D3Z6i9OBMLVs2W7AO7p+4E90b2N/DGl2ZR42iYCqOdXzjbphzuLzMFcF5onGqdUXOM6f8X7b8AlHLJrr6e6jp3QIh3PaeTRR1zNlu7uhKPYmT2xaqWXqrxktoCMtvOL/AzJJZh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771899082; c=relaxed/simple;
	bh=G/sOxQ2/3tQquWg2P4Ie/65TyReHtVOMzMTfaa1ea8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1iIekg0yO46NMEWJ3ZQfvpW49XBQfoRqh8M4WnrcGvHM9kuoQOpyDXQSHbN2KcxrVTCexNxCm/acaTTCgAeh5zXLEmKjyUPJtAp4NrYGo6axUjBTYpJG1r0RXq/d2xEDQmzIvFmjaJnfE3/roXUe8VxFfpAaQ3aDJy0A1RbRyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7zs6DzT; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8845cb5862so820149166b.3
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 18:11:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771899079; cv=none;
        d=google.com; s=arc-20240605;
        b=XUKN1DmHLn8sgvTdh+InG9F+MiUDx8fL1YN1ZDyISOb7XCqLt4CbucQIcltyjjQeVc
         E3CKp2KdCabX4ks5ETJscv830vXrxV8kSzPnHY4dQcNAX1AgGlAT53Emw83AJb8WEeT/
         FlpVU9Jh0YTJu5BY1/lEbFNDlvMJGlV+ow9IgFKeINzEipXMqL4idR5TkdVIo9hMnDbe
         HaXm1HYcYsX8+1ol3u+v3Htsb51cOQIaF+crPT8rlB8KFvQGjoMNoJ6VGVk49ZmomnO7
         Ug+49O2wtX5jTUAD4vlI2a4jvNPVTRxbZQCFWYE5RvS8uGaJHuAbiBEyPoVV5Vcl4WfY
         gP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eFA8Gu4szBvFtRfGkwR0vdAO1QkTVvSnODLMLCE2WIA=;
        fh=fsc8L0XFLU8i4xwgYX0qQMpgAwc8MqP9OS4uNI1h3iw=;
        b=gOCL1YJljFxBEkGwzRdZciCIUJiUR8Rzcbhgyoq34I02uVQw279xVnFeLz3nCXt1uQ
         botEYcMcTrzENywKccLOPQfK8KA3ujABnpQl1tA2i384zh5P+y7VqPoLXCC+/qUg2NFI
         3nGwPdiuiOx1SynVrEXnU5JmUZigh/lzDkXnDyJzh5K39FwnRJzy7kFECYzFqOjb3tKG
         5CoN/4vuCS7tPEqtMqNFpgOzLQhWbNklJo9FSQseR/WFUkWSH6KZUPbB1X5Pc+MXeW0M
         m1XwSeIM6402FQxN+nK1Y5yNdG8wk6HB3bqjppnFbvAx76dgv7a5c3YHJ4cLkKjAwTd/
         HCQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771899079; x=1772503879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFA8Gu4szBvFtRfGkwR0vdAO1QkTVvSnODLMLCE2WIA=;
        b=g7zs6DzTsUJtwh0il7F/4WBHo9E565Rpl+uGVI2jlxJ4uNZ+HvoaT7aJXPmjOir6f3
         YXNdAwDd46ZNo8nBTx1sp5QX81JHktcPsTx4u2kha+Do11jLKH8F5zFHt1xV5AHICBdj
         gW2B9a+kPyGQxNTFqOnQKtOCHdiBNJetdAtm+aZiIn1klUgw1AA92VsaSDybJwKQBGpK
         xOd/XmLBDjChZfSwLRfJbVKImVZ/nCnOAbh5W2hZuVpzxRw2Y31ON1bsed6pzS65lYAG
         uUrZdF9jakI6pSRvlfyGqrZxenJvVOxnRN3ePaAoZHTfNXtUF2vxogqUbtpTVBjvZzVP
         WARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771899079; x=1772503879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eFA8Gu4szBvFtRfGkwR0vdAO1QkTVvSnODLMLCE2WIA=;
        b=GBhBMz+obMoAfYQhLboHJyZwHghOKy1hmpVktMuMpD6HUjxOjmL96U5F8alRckd5og
         iWomTt3SBYhe0e1tM/DEjzO9f8y44hafMFaMdbvZEeGUWTzMqPQmRuJt2rp56GJ89Zkf
         M+brbDxcBBDjTICgOhyAkVOJHhY2YNKcWuLRhSDNPoGJjIaxmfqlv9aE1FNbqn4gR66x
         Kev/WeiMm15FBG7xWtPRca3whe9v2I62HjHNi6q4Tm6yWH/CO1YbOYru9doO6vaG44Du
         NR4n6bh+UrQIrocpVQJbmqhgvDqpP4fLvtm6Zs2MJtDYCTq3yqhNaJN32rHty9wJdWf3
         fY2A==
X-Forwarded-Encrypted: i=1; AJvYcCWRap/m3G9f3FWsg+AdEBTjYLKBz9WG73xXYgXCKnucxp05dUMj1VFwt83TnKY4XD56q008iK0m@vger.kernel.org
X-Gm-Message-State: AOJu0YwwyqCuslaCmL2kdV+swuRxoGqDNUn/x0EarXKwvoKkFaPDzGWf
	88QIs90Aupa+yWQa2b8unhxZ6VaS3eRH0/rWeW9YpQigzr0fmd0jUrPa6Z1WJeLwNO7BPwxauUj
	d6H4/WtZq1AODr7W1YtYmJmCVMFViiCM=
X-Gm-Gg: AZuq6aLvcysns9zpf4MnT/NxwnUupxc5Bi0RV1PGqD+QzJFZalitZ5KeB1HOkSX7DLP
	0zehTJlXCj2fhvdNWc8jo7Ez1oxXgXeMnS+1qk31tcWak9ctSlNFHPCXbLdL06XRvGovE68fEFI
	S4XbGJsFYQwgIDpTu1M64AL3sFGdi1qvvJ2LNeF0NdwhcGIZvONvhCiCgPjVn/VXknyX6889eUc
	1QaGUcN+1oNtJCZWGXsEnlUDMYUyVWLP7NYRyLIIZz/YU2y4KTs9IAjsC3LS54I4iojz1/nxW0O
	/2bdljVy4CNdxYl1MkIJCRpkgBIB4B22b5hyJzM7
X-Received: by 2002:a17:906:6b96:b0:b8d:bf4d:7463 with SMTP id
 a640c23a62f3a-b9081b4e964mr504856266b.31.1771899078951; Mon, 23 Feb 2026
 18:11:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com> <aZyFxKGXc8J6PIij@cmpxchg.org>
In-Reply-To: <aZyFxKGXc8J6PIij@cmpxchg.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 24 Feb 2026 10:10:42 +0800
X-Gm-Features: AaiRm503gqQwqplXGOPWtkC6hEz-XK9q1g7AWXt5tyf9jgc_DTnRm0pF7psYupY
Message-ID: <CAMgjq7AyL4=cN1mQ=i56j-kOvEaZXyT-3Wu063vM5JijXcFDLg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/15] mm, swap: swap table phase IV with dynamic
 ghost swapfile
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14198-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,linux-foundation.org,oracle.com,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,linux.dev,lge.com,bytedance.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups,kasong.tencent.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cmpxchg.org:email]
X-Rspamd-Queue-Id: 5CD52180EDE
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 1:00=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Fri, Feb 20, 2026 at 07:42:01AM +0800, Kairui Song via B4 Relay wrote:
> > - 8 bytes per slot memory usage, when using only plain swap.
> >   - And the memory usage can be reduced to 3 or only 1 byte.
> > - 16 bytes per slot memory usage, when using ghost / virtual zswap.
> >   - Zswap can just use ci_dyn->virtual_table to free up it's content
> >     completely.
> >   - And the memory usage can be reduced to 11 or 8 bytes using the same
> >     code above.
> >   - 24 bytes only if including reverse mapping is in use.
>
> That seems to tie us pretty permanently to duplicate metadata.
>
> For every page that was written to disk through zswap, we have an
> entry in the ghost swapfile, and an entry in the backend swapfile, no?

No, only one entry in the ghost swapfile (xswap or virtual swap file,
anyway it's just a name). The one in the physical swap is a reverse
mapping entry, it tells which slot in the ghost swapfile is pointing
to the physical slot, so swapoff / migration of the physical slot can
be done in O(1) time.

So, zero duplicate of any data.

>
> > - Minimal code review or maintenance burden. All layers are using the e=
xact
> >   same infrastructure for metadata / allocation / synchronization, maki=
ng
> >   all API and conventions consistent and easy to maintain.
> > - Writeback, migration and compaction are easily supportable since both
> >   reverse mapping and reallocation are prepared. We just need a
> >   folio_realloc_swap to allocate new entries for the existing entry, an=
d
> >   fill the swap table with a reserve map entry.
> > - Fast swapoff: Just read into ghost / virtual swap cache.
>
> Can we get this for disk swap as well? ;)
>
> Zswap swapoff is already fairly fast, albeit CPU intense. It's the
> scattered IO that makes swapoff on disks so terrible.

I am talking about disk swap here, not zswap. Swapoff of a physical
entry just loads the swap data in the virtual slot according to the
reverse mapping entry.

> > free -m
> >                total        used        free      shared  buff/cache   =
available
> > Mem:            1465         250         927           1         356   =
     1215
> > Swap:       15269887           0    15269887
>
> I'm not a fan of this. This makes free(1) output kind of useless, and
> very misleading. The swap space presented here has nothing to do with
> actual swap capacity, and the actual disk swap capacity is obscured.
>
> And how would a user choose this size? How would a distribution?

It can be dynamic (just si->max +=3D 2M on every cluster allocation
since it's really just a number now). Can be hidden, and can have an
infinite size. That's just an interface design that can be flexibly
changed.

For example if we just set this to a super large value and hide it, it
will look identical to vss from userspace perspect, but stay optional
and zero overhead for existing ZRAM or plain swap users.

> The only limit is compression ratio, and you don't know this in
> advance. This restriction seems pretty arbitrary and avoidable.

Just as a reference: In practice we limit our ZRAM setup to 1/4 or 1:1
of the total RAM to avoid the machine goto endless reclaim and never
go OOM.

But we can also have an infinite size ZSWAP now, with this series.

