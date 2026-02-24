Return-Path: <cgroups+bounces-14209-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFHsH7RinWksPQQAu9opvQ
	(envelope-from <cgroups+bounces-14209-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 09:35:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED510183D23
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 09:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 073193065F15
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 08:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E6D366813;
	Tue, 24 Feb 2026 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9BNenl5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F32F36683E
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922080; cv=pass; b=dDGOsR492wX+QJrUywmvH1PdzPHJAZvLtQFqevG4paYxK/O/Q7lLeJpokkb38AZ1CfahVnjIU5UjeYLDJDbfsJS1pWypD36tdy6TfQ7y821/dnynoJuhHhT4mrMO7+s00VTb1tisEKa7T5CXgJt8db08SQO/ZNGlSqnZx4N7JNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922080; c=relaxed/simple;
	bh=znXHW9n/+MokWp37xWDCKYppH1hLZZhDTU4jhuelsIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkXAu6Kuvg7ldAcFSCbe4isrq7wKQXD1cRgv2VKQBHwfJh+2pzmUnLvCLA1J3/jyjAm+Detx+YKaiL3jcvnMJq5GsWT7iylbwy7mWmYw3BotSfBaZzhNgu0CTIUiATRZYUnYZjz2M05rRzjzZP4PpKdt2MvLXh2Gjyr+lWFahNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9BNenl5; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b90bc00578cso176757966b.0
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 00:34:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771922077; cv=none;
        d=google.com; s=arc-20240605;
        b=LpU6B4hM4or/t4X9738U9ZiMEudaZnin29HZc5NACc6w9qfs5Nh5EUHoapVuxKJ574
         YILegxZt9WRkAS03EZUR+eD1aMbcLIj6ermgCWUtbexbSgkgn0E328ka7C+hkL/4NTOi
         J1mQQ7aisO1WAoEcmbWkMU5a4HSsZlFHXDh2Uyp0zPxiRwHvtUKhVQ1k4X8sOdffmnFe
         ZfSY5xBjN0l9M0g5CIbG4ihJ+hJR+ghe4KbdJ2XygRnlV81QiavkmTiTCrlR5CbaA75P
         s74bzcFLkW3I+boUD5D1iXiT8sZ3dWR+/ocgMqeacU/gOsdkx+ZI1HU3/2u5eAl3yZjL
         iiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=znXHW9n/+MokWp37xWDCKYppH1hLZZhDTU4jhuelsIw=;
        fh=BcZJSph3yI7l3ukMpRhKikrDW1Z5iYXRvB+IcsHTzPU=;
        b=SUU3A4DKlCl4GpwPR8u8nC5EXTyclIc6GHK+uSAvoQifp1+X9szPQcmRsornN4HPvD
         e1c9TKK1RQXtsgf605+CB4AqjQLhGeshcIeu+b1soPptRaEezSAavEQmFcDcd73U9t+U
         O3nw4iVKyBKyiFzyR6fj988aFy993DgsC6qyjO+jHcwWCGV34eNTfw9lREEFWiT/2klr
         GikHdLKTdvk/yRMjFahXjuuTkpx3NALL+qq+DkLVgSl8hiePX2G2rwywS5aRqiSISenC
         av5t6hTrGYJ+5i5pG/zGAHzPbgXFBOOUakckyDdLFOox2BtrzTVWZi3rYOTlbHDO1q1F
         WP6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771922077; x=1772526877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znXHW9n/+MokWp37xWDCKYppH1hLZZhDTU4jhuelsIw=;
        b=b9BNenl51tWccleK87ahRDVLDNQOjS5VL+Hxnfs2wl8JqAeQ49g7DDHlN6vYqZddjJ
         Ne8RfvrAf13RWQrfE49JoAuRefMcGsRxH3E0NW2KG/0YT2DFim03WhqbKzB9wPmfNjxS
         10ynrNRF/BAc36HVSFTWKhrQ8hfVf4EnG8q6qdQ3zLW2GdMnAcXVWff2cZhFC6ZRsrPK
         i/Rozx432Xt7o8b1voZ2wY4pZyjsJk1BfA1zgoXJXPhfNOULJdyHHt4+riqLJEhdO6PX
         up5rjoj2guwVgmuTZ1/oEnR3+KfmEsD17cEpeaQmXEOAITIfTMPQhL0yQLVUNit4MlYw
         7TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771922077; x=1772526877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=znXHW9n/+MokWp37xWDCKYppH1hLZZhDTU4jhuelsIw=;
        b=YiGjwnCFiWrE7bPgipaiXJUJvudFXh/dFca1uqZWds/ZEA6XVCFaVI0QLH5k8Wzqed
         HA2KPeopgT/huw8Ua5hwXV0mWQa71KmCVvl5MOg1vPAPPV/KHXTNrsUcW5LlkTiktjyJ
         DxhAeojAvWGH6/grjvBS78VbAXwPDtw3zUBUrz/zwUMfgyMceYgU6m/WNXiddSYwiNEL
         5Ume96wmZNZWnrrNWAk6w8wTP1KtbfbAYw13qP1NRz3M7Lmtj6AX7CFgNBiuXY9PVeM1
         7YSN+bk7srmIKbde/LikoZuzJ1vVeLp1sI2ZO9ErzOUq8Avt8PykPALTcrI2sRu7t2Wt
         /Atw==
X-Forwarded-Encrypted: i=1; AJvYcCUzRDvOAu7NQyX00n7AI3u5Hsseu+lYtsWp6JaXNqRSBgHAEDttG+5c979rr6nXCg+4E6pz2iRD@vger.kernel.org
X-Gm-Message-State: AOJu0YwvtxcGwK8qYK/bwf7QUSstL9DBBXCT8aCQkgNCtBwaicsUjrcW
	/QFn//Tsjri8ZwfdSXAWZ1layCQPfBDX4jRskJNkUFmZSZJZgddE6yZop8/x0zB677IKbGpnRVO
	+gbiVG8iE3TNn8aFykMvUzA70+YfLZ2Y=
X-Gm-Gg: AZuq6aJTmYeKT1VqeKMCKLsubP7vxm/O4pv8yPiK5Hja42g4warb/rOGypavh21QsyS
	d5hrN08FLNoiL+ajBLg9SeLMazfAZjQ/9VK1yoSNYenoRrjfHJdgeJsmvzOyoUiift0hJmoF5K4
	LbzQP1brsSkf53uoTVWdfzZ0fSejz1fjXzlBr5H7au79NXaz2WeDbPViojuhoWhyErzZqexvXfl
	4NzHBoOXG2zNhmOVRob62kjEqtpakG4Ys5EvWcoSc8H0cjBM4H0Omw9fqFbzcumXdnXqh/RqOkh
	vb0fhsCVrtg0t7cjyHz95sOd48C2xwA1T3TpYNXHAppQIdZmn1k=
X-Received: by 2002:a17:907:5cd:b0:b86:f999:15ba with SMTP id
 a640c23a62f3a-b90819bf271mr738575366b.18.1771922077181; Tue, 24 Feb 2026
 00:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
 <20260220-swap-table-p4-v1-8-104795d19815@tencent.com> <aZyCJ6pH4hey-ZoU@cmpxchg.org>
In-Reply-To: <aZyCJ6pH4hey-ZoU@cmpxchg.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 24 Feb 2026 16:34:00 +0800
X-Gm-Features: AaiRm53rAvIIoLImS2kI3nJgno-CbLxDv74dTHqbZXtKN15KdUZ64c26Zb5nj1k
Message-ID: <CAMgjq7Aq5ckraKtNtet8+1ANuqnitFsXxefbDJQZpBxNmaW7Cg@mail.gmail.com>
Subject: Re: [PATCH RFC 08/15] mm, swap: store and check memcg info in the
 swap table
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14209-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups,kasong.tencent.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tencent.com:email,cmpxchg.org:email]
X-Rspamd-Queue-Id: ED510183D23
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:46=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Fri, Feb 20, 2026 at 07:42:09AM +0800, Kairui Song via B4 Relay wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > To prepare for merging the swap_cgroup_ctrl into the swap table, store
> > the memcg info in the swap table on swapout.
> >
> > This is done by using the existing shadow format.
> >
> > Note this also changes the refault counting at the nearest online memcg
> > level:
> >
> > Unlike file folios, anon folios are mostly exclusive to one mem cgroup,
> > and each cgroup is likely to have different characteristics.
>
> This is not correct.
>
> As much as I like the idea of storing the swap_cgroup association
> inside the shadow entry, the refault evaluation needs to happen at the
> level that drove eviction.
>
> Consider a workload that is split into cgroups purely for accounting,
> not for setting different limits:
>
> workload (limit domain)
> `- component A
> `- component B
>
> This means the two components must compete freely, and it must behave
> as if there is only one LRU. When pages get reclaimed in a round-robin
> fashion, both A and B get aged at the same pace. Likewise, when pages
> in A refault, they must challenge the *combined* workingset of both A
> and B, not just the local pages.
>
> Otherwise, you risk retaining stale workingset in one subgroup while
> the other one is thrashing. This breaks userspace expectations.
>

Hi Johannes, thanks for pointing this out.

I'm just not sure how much of a real problem this is. The refault
challenge change was made in commit b910718a948a which was before anon
shadow was introduced. And shadows could get reclaimed, especially
when under pressure (and we could be doing that again by reclaiming
full_clusters with swap tables). And MGLRU simply ignores the
target_memcg here yet it performs surprisingly well with multiple
memcg setups. And I did find a comment in workingset.c saying the
kernel used to activate all pages, which is also fine. And that commit
also mentioned the active list shrinking, but anon active list gets
shrinked just fine without refault feedback in shrink_lruvec under
can_age_anon_pages.

So in this RFC I just be a bit aggressive and changed it. I can do
some tests with different memory size setup.

If we are not OK with it, then just use a ci->memcg_table then we are
fine, everything is still dynamic but single slot usage could be a bit
higher, 8 bytes to 10 bytes: and maybe find a way later to make
ci->memcg_table NULL and shrink back to 8 bytes with, e.g. MGLRU and
balance the memcg with things like aging feed back maybe (the later
part is just idea but seems doable?).

