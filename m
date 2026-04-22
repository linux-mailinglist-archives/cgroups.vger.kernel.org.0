Return-Path: <cgroups+bounces-15450-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNEFJEUy6GmeGgIAu9opvQ
	(envelope-from <cgroups+bounces-15450-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 04:28:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC6144170A
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 04:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C346730E5707
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 02:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C6F31714B;
	Wed, 22 Apr 2026 02:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjZn0BUQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720B1316197
	for <cgroups@vger.kernel.org>; Wed, 22 Apr 2026 02:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776824356; cv=pass; b=DX2pmNTj1pXuWTkuBxLgezGuSnFzdQBTpD+4nsn0KVOcBGy+ewpCGLRN5YiKqaSwAl6FmSX1mRbj5oIY02RuYWfjE7igJMOjcJzOkOsXmHwBSuFAax6qyuE2vFm02nXHwMxyQ2weHqCd78Az6bqNM/lavlljytpxPtDZUpud7nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776824356; c=relaxed/simple;
	bh=/P3Rk4TtuDYfsPdnBrw4iKE8r+bV3HKR+Fx10JBb+ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DF7irLnHF66YhFUQxSwwT2wFWopERmwczThkQaUdEhk2vwvFOzUdnXzU46VUQG9EQTBHNHLCbvR/qAn7fix7AV0Y4OIcF1tVwNN3cKdSxaPY3CWKVjry5HGmKwTg4l8/2u/qIlS6BVcqaDgZAi2L0nFI8EcKuWFxzuK2GZaAxR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sjZn0BUQ; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so2264392a12.1
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 19:19:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776824354; cv=none;
        d=google.com; s=arc-20240605;
        b=CTEtUQOt4pINN7lLqElD9BL3qJGDsC5zs4ZOtIpj1vFUZp6lq1otUlRk38xH9msifQ
         6bpkGJ0zwBzlJHu+T9ktdW94CXx4Kn20l4veTl0RbN4uJleiFvs0sRc0cDzb0IMfti6G
         dmUIW8s0QA3M5tvWkJpPCaYDFzE2dXdV4N3FJT5p+E5EuWzCbVGsTDEIDtFgrOr55IYU
         6hVHd9HyHJajKRlLjjikxp5MFUgTtJjjOYOm0OYSGTJ0ZeQmEY/L+aMAP3QDC4d4EIoc
         wA9hluHeSYe7D8R6WwziRrWBhOM2x4+u3V2by0QnYPB/ku8okDYqpkR10I6n5JYL0h/y
         jOqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/P3Rk4TtuDYfsPdnBrw4iKE8r+bV3HKR+Fx10JBb+ns=;
        fh=i/fQgUhOrCNr+1sBtrUk+RBO7zC2oiz3QfB2MfInifE=;
        b=PLaEjMkUIudV7NzK0y/FFCu5g3hmYp6Nbr0vtJpiHsbg4Jg+Li/0utOP1X57UF/549
         BzOVsW382/k2zlJVolw/m/EuaSsKW/emdcbtezHwHyG3QUzXD8kF7bl8nahGoUImtr6n
         ksvsKsDlfO4fA0oYt+A84XG7zju8WE0XG3RMCdPbT9PyeGUKJ/XXJULWRz+ETATeHYtz
         sek4wCA5/3B8OLgscBfoChx8JiOzaaA2TSEKeCCBBHNyCAAbGuSpKlbxmQEeeDr9akCi
         4qW2as7WrdvRDiAaQBWjtSWNZmMtbRo0u1Hawz7RL0fSeVaRae9+XhH3eiDvVttRvpqw
         Zxrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776824354; x=1777429154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/P3Rk4TtuDYfsPdnBrw4iKE8r+bV3HKR+Fx10JBb+ns=;
        b=sjZn0BUQljheTtpVl7ncqNF7+J9T11OG/6zfZHc9VdBEewdvtBX9uo0LZxv3sZ6QU7
         sJD5pmmU+ZjQt6AAl6Op4qvAK9geAUB7bkt8Z1UMbBXIciceeoZtIzKs7Nh1+g7xTUyC
         vIhjiOn5QpOYFmQpmVvgGOG/U2q03Z6JFLPe4k+42EvA/J7A3beQOoLAs7zEGneOuJlw
         iLo7wca2mXlH5m7Cn3vkzYQBisUnIlRtkz1DN+WcSs9Ixlg5U5Sd1uMaqncjtJH3YDQy
         zREFK03OAIaP2/4jpybYQOBi+FlXbWEDy7UzEpY3GYtPKi7VJxM0BJhW5dH2Qg6Q2hSm
         /Lag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776824354; x=1777429154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/P3Rk4TtuDYfsPdnBrw4iKE8r+bV3HKR+Fx10JBb+ns=;
        b=q/S03U5URqjCMb0HcMJJmbmtYuWyNEue1WduI4IhVWHpwkWsFCf/NYtDw5qjfQgCsK
         1K/Azl97B/6ud6TEhQeGzH4dDaUBhZB+kGvjq409NivhJYLl0Tq/rS3bRF2c5vI39srj
         784qJ8aHcTkr4pckozUraCeE1EyLPlPFwpqabzFF7jvbyIActO9D5RBHkL/ANcGIv3Ow
         lCXhK+0RQfe+zZJXyV1MNBd9/ngEw6A8XMvw8X+nDfV0kSf0JeWwEc9fREhEjnAPUvJk
         S6/Io4b/5xzJd2Dq37hDfVG0QhU4ysJDf1teDFLkI6BV6JT51myF4xT82D77OzQ81wqy
         ciEw==
X-Forwarded-Encrypted: i=1; AFNElJ/X/6GVYwrz4582xO3Tm3gFoFau3QrmoaXQs4cQr/7ovivVnn/BOzhGzEYhEascCxqDrZBND396@vger.kernel.org
X-Gm-Message-State: AOJu0Yz12sx1QWlxmlVnxX12CDn9qsUX2wA4vxPVETrhufjKHrvbnK42
	ZT8pMR/Bw81mkZFJ8S6YmBs9kGR2UjGO04JvGaWOUri51LW0Gmn5OBatTRKtggAPLTBHzihg499
	d2N0QP4P152ABwwSV0DWokBZAyDsxAd4=
X-Gm-Gg: AeBDieuaUxoloQl5+1owsn1lbdBU33XJ4yl1ey9t+CdhrAxWZ6ELgFjggn0eBenqx16
	FN1uGmgnjKuxaucCDaoWT0QSfnlGF+eTx+rx99htjuq3jIZsFZ6cdvavTeaO6j+1GjJFAwni+Jj
	HruWZ+XSSXtVftwRyQSQS/rbKoHI92qNTCAFonBd4ICkkWvJV16GBxVb9NJaDpBm1WmQEWEtRmA
	KT+Cyk2PrOTTV2NkblopO844zpCif7jS2LYgnzd2zW1QhOq9Ih62CCYqdp6+wbsrqVCvXgCKcAI
	YTIqoyymBrVL/b+BhxvdPlf5iXW/6wgxz3ZJoExi7ESIW/bq0K8=
X-Received: by 2002:a05:6402:26d6:b0:676:d863:ce29 with SMTP id
 4fb4d7f45d1cf-676d863cf85mr1407081a12.28.1776824353486; Tue, 21 Apr 2026
 19:19:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <aegUoOiUbjUAH5aT@google.com>
In-Reply-To: <aegUoOiUbjUAH5aT@google.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 22 Apr 2026 10:18:35 +0800
X-Gm-Features: AQROBzDy3s1eJBSM4ivRYyuVreJ6HWEvbaw8uJ7B00A6nArMH1jrA77MWD0vRmM
Message-ID: <CAMgjq7C53WRS5oYxO157mX7JxhfoPoi34k+taiKLrMah-b-iRg@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Yosry Ahmed <yosry@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com, 
	cgroups@vger.kernel.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	corbet@lwn.net, david@kernel.org, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jannh@google.com, 
	joshua.hahnjy@gmail.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org, 
	ryan.roberts@arm.com, shakeel.butt@linux.dev, shikemeng@huaweicloud.com, 
	surenb@google.com, tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15450-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3DC6144170A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 8:26=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Fri, Mar 20, 2026 at 12:27:14PM -0700, Nhat Pham wrote:
> >
> > This patch series implements the virtual swap space idea, based on Yosr=
y's
> > proposals at LSFMMBPF 2023 (see [1], [2], [3]), as well as valuable
> > inputs from Johannes Weiner. The same idea (with different
> > implementation details) has been floated by Rik van Riel since at least
> > 2011 (see [8]).
>
> Unfortuantely, I haven't been able to keep up with virtual swap and swap
> table development, as my time is mostly being spent elsewhere these
> days. I do have a question tho, which might have already been answered
> or is too naive/stupid -- so apologies in advance.

Hi Yosry,

Not a stupid question at all=E2=80=94it's actually spot on. :)

>
> Given the recent advancements in the swap table and that most metadata
> and the swap cache are already being pulled into it, is it possible to
> use the swap table in the virtual swap layer instead of the xarray?
>
> Basically pull the swap table one layer higher, and have it point to
> either a zswap entry or a physical swap slot (or others in the future)?
> If my understanding is correct, we kinda get the best of both worlds and
> reuse the integration already done by the swap table with the swap
> cache, as well as the lock paritioning.
>
> In this world, the clusters would be in the virtual swap space, and we'd
> create the clusters on-demand as needed.
>
> Does this even work or make the least amount of sense (I guess the
> question is for both Nhat and Kairui)?
>

Yes, this absolutely works. In fact, I previously posted a working RFC
based on this idea. In that series, clusters are dynamically
allocated, allowing the swap space to be dynamically sized
(essentially infinite) while reusing all the existing infrastructure:
https://lore.kernel.org/all/20260220-swap-table-p4-v1-0-104795d19815@tencen=
t.com/

The only missing pieces are a few helpers like folio_realloc_swap()
and folio_migrate_swap() for lower layer allocation and migration. I
prototyped this locally and it wasn't difficult to implement.
Furthermore, this approach works perfectly with YoungJun's tiering
work with zero conflicts, the dynamic layer can be runtime or
per-memcg optional.

To move this forward, I've stripped out the RFC features and memcg
behavior changes, and recently sent a V3 that focuses purely on the
infrastructure. It introduces no behavior changes or new features,
just optimizations.

It cleans up a lot of allocation and ordering, as well as memcg
swap lookups. Since some of these problems were also observed in the
vss discussion, I think this will make things easier for all of us:
https://lore.kernel.org/all/20260421-swap-table-p4-v3-0-2f23759a76bc@tencen=
t.com/

