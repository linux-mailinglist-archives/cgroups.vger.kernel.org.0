Return-Path: <cgroups+bounces-15765-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPjlDGUQAmqIngEAu9opvQ
	(envelope-from <cgroups+bounces-15765-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 19:22:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BE351356B
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 19:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18AB831558B2
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB2D2749D6;
	Mon, 11 May 2026 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQAOv8Zt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B233D3D1C
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517894; cv=pass; b=UBOtMEBUQJuCJIEKHXTRZG3AYZGQIRoPnAUttbqoF/qzjKZ+6BLA1tWBkgsADZFEhCoiNS5Wippe4YjBRPnvQFXPKLlyY2TXsMPPtCXpjT8ZoM8/n+CwYXhWJOVOU+Nyl0l/t7eAE6F2CoB9zGjfsH9F0mBNNoeHMArqNXT7WJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517894; c=relaxed/simple;
	bh=yW8uytGuflTw9lvqYH/Aia0868CW1vKIuG0TgOoaFoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FH8fZ/0E5+9Pkzpbx50gggCHsLPZ5+D+r357osLWwL0ZLgywEYcrcqRNPu9X1xoeEqUPqpHZvQU4ot+ap7MHsI2FFM4FpD3zDTkA/tBjleS8TFp6fJXIPfYI1wg474btfFPKRZrBqCDnvYhI3rCaZISARna3crOT+WTomuZhMJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQAOv8Zt; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67f94c078e8so2326525a12.1
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 09:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778517892; cv=none;
        d=google.com; s=arc-20240605;
        b=OaL4jZKa2AVQ/ffPVfpVEQHS9kYKPOD6z0bLBxVbNdgS0pHTVWJl5orLLRKQK35gjq
         6nL5EYR/L5TTQ1ZcJSvv3TLk6qvGZD3vGxC/+eBfAO2T2Fw8mmkcS4fV2h2ug3I2M7eq
         xva5erELnVeP7lnKXAv1flF2BldXMemqKuJkkgphM3MZEWdAvu/a/wqSo+UOKsRxW8hg
         Qzk4gXpRjZQL4l7NV2ZlO8vV46y6Ao4gTlHVYT8wZu3WNq6kWGZ1JdcE6bwNhRQoCW2V
         ywujZ/Gfw//qttho5OBBGFtAitQEr9IH1uD+v0/kE1Z6UqZw0phu5n4fQSUBAFWZ0r8r
         er8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hv3Z/T/rDKetsPnNf4uqDj2NLpcvDmI8p9/YXJ0ZLU8=;
        fh=zMy1rA0vh3Sd7QZyZ8HEf0Ppa8+2UgFEq8lZCdxrEtM=;
        b=SE93oJh0PTD09hCXOWkHELPTayXC1Hqr6XtU/O1By0AAdqqGQsB6mo/7zM1sN8Ri7C
         h18v+zho07eqQnddrRuLOw9MjontpJzRMGklsCXBWZN+gk+VR/8QQvT3i5tK78AD9tZn
         KtwLITJhqK8+X3MN2e9MvdR+T7ker2GSwEhJRuGDCTYa93dy2ko8Qmj3tvMkO9E394q6
         b68F5gBocUT2UVa13GYxdaYTiObNBS3SZ2Y/QkUeWnHaYD0Ue0gA/b9cbGn7tdNaTYVE
         erRzV8plv+AjmQKNyf+MczMlqzWlU9WgdFUuIsLBhoYrcVmn1vJDY2kUYKSNavqFyfpN
         YmhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778517892; x=1779122692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hv3Z/T/rDKetsPnNf4uqDj2NLpcvDmI8p9/YXJ0ZLU8=;
        b=QQAOv8Zt3Oa9V3HfjDWdDMuDRXr9ZmKJCwbIGDz5eTPc2b4Rf+04FjyBO22ney2jCW
         DcZ57rxgbNNpzQVnVuoK969wrqfFoGzku0Sl/UCr7+iHdO8/xqJ3auKt0tPY5TfuqXJU
         wPOu18DW8Cvj/vZtTcvYP8U35ZoO3FgSlu95zkT+bZfEx6xjkcu5HTGrBWgdxLKH8AcS
         zwcIeB8NWgd+TRAFnpVJfLjwd6yoqxLfUy0e/l0Ps3lsOiEAX8TB6EaNL8Mj73IfR/7D
         L9hjmcB5CVzW/8UUkZ7JoJgabohWeczMSgOGpYmB+/Zq4+AA9KORdON/bndpAasKWAQx
         cxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778517892; x=1779122692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hv3Z/T/rDKetsPnNf4uqDj2NLpcvDmI8p9/YXJ0ZLU8=;
        b=TBe0DrFosfal6HaYH9WdKN1fwJXQiWwJExxw3ddaIQxv/je9eLtqv42/E/P5vYy9zK
         4XkMVJwh5DZAtcRdmkIy0t1PcCGCOV6CdnlAviiWXzMA4E2UswpFHfYqDieLJKsja/HO
         ZTE3q6BWvjcFJl1TM5p18zD9aby7gWuEAKoa0yfmUKmNIwiXu+emdDmVdlTZwrQsxpJS
         yj3nL8NyXfpPh8m7cmPwa+iHDEsezp+UGnuBK9LRBZTNTKw3vTp7JCorSl1Km6qlIm5e
         Q+m4oHN1KwQXIZMsmCl5rXn2b3x3AioZZUK1ZFRsUu0XAR+GZn1x04JAFt8jaoIwnre5
         pp8w==
X-Forwarded-Encrypted: i=1; AFNElJ8LCa9Zs06IAWW85sgfE4MuDzy2m1+QLC6EBibceoGYYvL0AfWelscCQW4mQwUKSjsHGxePOu9b@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7mBwvg173yjUXxO1C7tdnqZ04DyC3VHODc8wDoc+QmGTaBlU
	htcMRUwL1pDO7SjDI6KneZCw3kkj8NS+F5BKvVZno+b44BB08mM+W9M1/NAfaEvDQUE2dHldr8W
	Aq2O4Nwiad8/CUYeY2x54WLNWskpM/Fw=
X-Gm-Gg: Acq92OGHJlsVIEteuY6kfdLEiquGv8rOPh67/+h3Rw3fYUgcplwcSMkOvtpi6nftJ6C
	7vxNdKfJwZmoSrz7DcyRlNFtdYs/i5X6IVer/9leMnYXQDfxzlv1SQ2t4XjZ56hKYUhmNSr03yG
	EKfbmV+F0Baki1GfRzumTrGcpFxHyCXrROeFxGkU0e7HCezbumLF7jn7HBGCisi0W7PcfIoN2ja
	f6I7J4QbvPjibfSCMj3kMlxXExn0RGtKEsPghKBpC6BHKQiFjapXNBmOU9Jf6n63I2P7H1vSFco
	RY0j/URyAHIcYOdiHKqi0SDz+OaxXVvrvZDWsX0dcTj+SYjeoKI=
X-Received: by 2002:a17:907:98c:b0:ba7:b198:7d35 with SMTP id
 a640c23a62f3a-bc56be38696mr1454458366b.19.1778517891489; Mon, 11 May 2026
 09:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-5-2f23759a76bc@tencent.com> <675e9027-9fb5-47b5-9a2d-c9a416a27d0d@kernel.org>
 <CAMgjq7DegMz2ZEHOhHkAqDEWDuCSZ7Ktsxw1ibDY8axFzRRGnQ@mail.gmail.com> <c72ead41-0bb3-4da0-856c-315dc552c722@kernel.org>
In-Reply-To: <c72ead41-0bb3-4da0-856c-315dc552c722@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 12 May 2026 00:44:14 +0800
X-Gm-Features: AVHnY4Lqb9-Qjp1gLoCD6Wj_xSwNStP-lbWfmLcjcAc8JKIbMJcoyw45UeE5es8
Message-ID: <CAMgjq7CK7DPfHEXUY+mDeKu33n=CBrh1RKmpem7Arjsas9rxYw@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] mm, swap: unify large folio allocation
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 39BE351356B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15765-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,nvidia.com,linux.alibaba.com,kernel.org,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 11:15=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 5/11/26 16:37, Kairui Song wrote:
> >
> > Yes, the current status is a bit odd, about two years ago I also
> > wanted to name it `swapin_direct()`.
> > https://lore.kernel.org/linux-mm/20240326185032.72159-3-ryncsn@gmail.co=
m/
> >
> > But actually ZRAM or shmem would also benefit from supporting unified
> > readahead like this:
> > https://lore.kernel.org/linux-mm/20240102175338.62012-6-ryncsn@gmail.co=
m/
> >
> > So calling it `swapin_entry` seems more future-proof. At some point in
> > the future we might remove `swapin_readahead`. All swapin operations
> > could have a unified or at least a per-device readahead policy like
> > the one in the link above, instead of the current policy where the
> > caller must decide whether to perform readahead.
> >
> > But any suggestion on naming is welcome :)
>
> The other proposal
>
>         https://lore.kernel.org/all/tencent_CD11FE9B4A0B362E95E776C5F6795=
98FAA07@qq.com/
>
> calls it
>
>         swapin_synchronous_folio
>
> Maybe just swapin_sync_io()/swapin_sync() or sth like that?

Good idea, I can keep the swapin_sync name at this point. Sync io flag
still may remain for a longer time.

