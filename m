Return-Path: <cgroups+bounces-14207-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJRBE31dnWmxOgQAu9opvQ
	(envelope-from <cgroups+bounces-14207-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 09:12:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A36D183739
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 09:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 222DF30523E2
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 08:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A4E364E81;
	Tue, 24 Feb 2026 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nV+TNY/Q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBD92765F8
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920568; cv=pass; b=DjEfmeHXFW3chlp1qAZUqcDQcK9JohAS3Yj0RzmguLGtTv0+0WGMzyhXx673G9DFUUsQD5Q7Zzrzfj+9BKeChvBNpy3/pXOiTlWcPkF+B36JF1vFdCf/17o8ndYtjlUG0EqBIOj03mvADlab8IUiqpkPLeWq1fk7Fv972BtM5S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920568; c=relaxed/simple;
	bh=FNPuP84vk79KL266z/45Fs7Uqy7CpD2+o8LZg3RRQ4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mt/A0NC58aQuCzDO/rrsk5K8AYwVB8Dd8T0/lH3RaN5N+F1boEPvOLLfQR2rRdTUCCl3qCzAEcoTs2wyLB5vqAmucLloS/8TehHtprbtHuiIeMegKVrqfNFx2rZU3Rf5nrCt4U2NFaEwvHGh7r9KO3RAUPDBun+PlDRcgw1kLSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nV+TNY/Q; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b88593aa4dcso733416766b.3
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 00:09:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771920565; cv=none;
        d=google.com; s=arc-20240605;
        b=WzAFi+STFvpw7W1kULn5jwJ/GyBcTOCEkavNk00TxqA7yYVY2Ddji7ePlQ+6SQwull
         xrTrL/nZOInKSRZ/EMHyJM8OoAsnPfYD/VWb8hsZT40AcJeuSXYyuu4STKgJhma8mK6l
         v2kKf0opx7Hq3ie3V9cUxUXGpFa2tRfgNfyJY59ZQpqipEfW0qNVWkwX+Z4DNQKlAIL0
         U+9YIvwfU9TUAOMWhKjRCXBWpOlR3CcN9TBwTAyC6kMPmLM/MuxXKnNBOMbzwUi1VWXn
         8wCJnjP/rRBnpNwKBAfwAncCCC1wr9gRmh2pqufavjGNSjgkhPBjfyRwBRfZO0W9uhwz
         7wAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FNPuP84vk79KL266z/45Fs7Uqy7CpD2+o8LZg3RRQ4E=;
        fh=jZei27DK3BKhjuPEWApo/cd8v0u3zjO/X1qcrzAeD2k=;
        b=NgBdaya8CaanfNs4RAc6B0P+Srs9n47AhxcODUxiz1gthXAu2T2nA4aGGbL2CaOYWX
         LpF803aokfNT9T22Vnz0rUkIyzhQxvjq1ai5PBrDafFs2rnMeAih+Q6gyHVfcsznbCNp
         s3Ngmm61z7LW+2PanRH9F7PVgoz/4Jg6nKvrLBIvAQuYwMA5LFY7iRmsfi9PW9FouKk0
         Ur8O4PNma5mv1epVWmaKgur9z5zlyApWE4uH0P41yoOg4EO5AJF7ZQL0sQJgTJA76IZK
         61AfjCCylWSjOUzXe7eR97LE8gUl8+WkiWhqrfTS/czvNtON95sQRc/7N7I5hXHx8YV0
         wj8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771920565; x=1772525365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNPuP84vk79KL266z/45Fs7Uqy7CpD2+o8LZg3RRQ4E=;
        b=nV+TNY/QgHXl+ppL3fHvVveBxMO/lsApY9mQ2moZKejhn48EgqDTOQciBH3htH38QA
         qEqfnxr/Wdh8bPVULzNGtpcpsCUEQwXO/6Q7m74ZdqTnWubh5nFEGs37+IRkEXUlaXPW
         9n/mDa9NKQVbOY3228EXL6FueRT1bsYgr9I0cd3moeMFTjMYx2pV1hea96rRvU35kmUu
         axbgr5zYA17o7CRfkIzzlvN1qbVSon/D1U5r+wrtOSnKqTGazbKwC/OMsKw8fGDaLl9X
         XttY/W1kgFrZLFx8OCpBAUMIFxoPAZe9OQTdvBqwCk3xiCMpZs48XFtTrtMr1ob4TIrB
         7jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771920565; x=1772525365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FNPuP84vk79KL266z/45Fs7Uqy7CpD2+o8LZg3RRQ4E=;
        b=c+SVh+4y1TMoSlb9h/FhDx/RxJTpKKuRoTSbkO/YYfwWHKMr7BoaZoYUSWwcWRvmRS
         POxyy0aSgbg2Nu0fUM6jkl4I28AuhI9oIUTB9ZmoUTGG+EzKkRJW02spw7/OBFlKtu+Y
         30apl9RjjoFqs48CZXRSD9S2tE/ClJPSEvpc/C7BUO5paJDVzOePqewPlfGUnbg7F2ln
         dApTx49OhQ4IuGq/H04+gqNYKmhEdrX4YzkVXasyQ8ldIESCg5B1sNUskMPzj9G1vBfx
         Zy9VATtgJK22NnhFkiakFja3xMqQgXXC3vgv/gFmhMVPo4AVQnGyu72nahuNtT6G+hb9
         jqEA==
X-Forwarded-Encrypted: i=1; AJvYcCWx/L4Ek/uUzrzuWow0GNWPqi7DDE9tjm8f4V54OjPbhV4y58tyrShipa8dn1hP0WodZKS+HIOu@vger.kernel.org
X-Gm-Message-State: AOJu0YyxL5dV8oIo/AMSxDj72svYm5n1m77hNidjwZk0w0qrTC7FQz6n
	sft6Snwi+S11P8joBLyiDLnTwVbJisC2nvrmj1yNswYb8k7LTtbZlLzSwdhoY1HOHAUYqzVkuPG
	Ddr/vZge8/8elso3lqMATinRdfvoUZ38=
X-Gm-Gg: AZuq6aIfTGvjxXw5bWXFYZz/c29UY1SWQtJpPoROKLbhTFM79AXf5D0mApj5u9nFU18
	mae6L7FSHrdr5s7QgwtTIkYbQEMyf51PGBCTkGszyUGmt6LZxeaqeAkx2dmVJIvVZyRTMPoxKeK
	5+ryLGgjld0t/uujPzBN0K9D2zRKUcFuY2iH9VJM2WfYGrplf3B7vf+YMkcB23XmTFeaBsUQm/w
	NZ10Rqa7TDauSwzJijXG/3LVesmApDim7U2KPgBdAfwbXfKt6/eUpk9J8dfdJ6LLQ+qvSFN2s7B
	sBnhWaYuP5tCfwk6C260rxZ9Aqb3hhtCB84ghvXn
X-Received: by 2002:a17:907:e105:b0:b8e:92e:d316 with SMTP id
 a640c23a62f3a-b9081bfed88mr370513066b.56.1771920564862; Tue, 24 Feb 2026
 00:09:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
 <20260220-swap-table-p4-v1-6-104795d19815@tencent.com> <aZ0oXHNMe7_3P9OT@linux.dev>
In-Reply-To: <aZ0oXHNMe7_3P9OT@linux.dev>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 24 Feb 2026 16:08:48 +0800
X-Gm-Features: AaiRm516C6c119n55RhFty8hjIzFAw2otJUtAgUiNrhV_yc3b5XfX7wnRNLLbjo
Message-ID: <CAMgjq7CRpM7no85OxMpDNAW=kCOr5i5CmKeJGd6VY8yYu6sEYA@mail.gmail.com>
Subject: Re: [PATCH RFC 06/15] memcg, swap: reparent the swap entry on swapin
 if swapout cgroup is dead
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14207-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,lge.com,bytedance.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9A36D183739
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 1:44=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Feb 20, 2026 at 07:42:07AM +0800, Kairui Song via B4 Relay wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > As a result this will always charge the swapin folio into the dead
> > cgroup's parent cgroup, and ensure folio->swap belongs to folio_memcg.
>
> I directly jump to this patch and the opening statement is confusing. Ple=
ase
> make the commit message self contained.
>
> > This only affects some uncommon behavior if we move the process between
> > memcg.
> >
> > When a process that previously swapped some memory is moved to another
> > cgroup, and the cgroup where the swap occurred is dead, folios for
> > swap in of old swap entries will be charged into the new cgroup.
> > Combined with the lazy freeing of swap cache, this leads to a strange
> > situation where the folio->swap entry belongs to a cgroup that is not
> > folio->memcg.
>
> Why is this an issue (i.e. folio->swap's cgroup different from
> folio->memcg)?

It's an issue for this series, if we want to track the folio->swap
using folio->memcg to avoid an external array to record folio->swap's
memcgid.

>
> >
> > Swapin from dead zombie memcg might be rare in practise, cgroups are
> > offlined only after the workload in it is gone, which requires zapping
> > the page table first, and releases all swap entries. Shmem is
> > a bit different, but shmem always has swap count =3D=3D 1, and force
> > releases the swap cache. So, for shmem charging into the new memcg and
> > release entry does look more sensible.
>
> Is this behavior same for all types of memory backed by shmem (i.e. MAP_S=
HARED,
> memfd etc)? What about cow anon memory shared between parent and child
> processes?

It's the same. If the memcg is dead and a swap entry's memcgid record
points to the dead memcg, then whoever reads this swap entry recharges
the swapin folio.

