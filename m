Return-Path: <cgroups+bounces-15545-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDK+HdsA8WnubgEAu9opvQ
	(envelope-from <cgroups+bounces-15545-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 20:47:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCEB48AD48
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 20:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8F3F30C87E7
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 18:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F4147AF6E;
	Tue, 28 Apr 2026 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ifd83xBd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0174740627F
	for <cgroups@vger.kernel.org>; Tue, 28 Apr 2026 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777402015; cv=pass; b=MFZO+L18yQ5XZc5cqPLuWLGL0sdA+GxEGTLg9X2niLXrkVQjZ4WlSXmBorb69QXEFE0paxy42FBxuObG2w6i3k/yjBFJ1z0HXjih7f6iHgCIch9zFGDFOBDTqo86R7bPYuN9VZ4gQwLoKpAb6j6SdMISPT5H5xuQLADUUpQmisU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777402015; c=relaxed/simple;
	bh=EKFG0RDVEK246wBeg1IKZgBSUBwwFpLrZPo+iyiQ1R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptsCEjZLjWR2oaidwhXYu2B3pKPc1OXRd7XjK4TQvzS4vu6M1NPkyhdzx/36Gvvuf2nANV1vw/g1sLvYb7E3bkVXStDPjZMNSNKy1DXCqcaAiYiMiGQd0aJlSNLB4iheIZTLnUwoDxX63xHlqDspg7Q4WiQeyqFAdbA+8lOQGuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ifd83xBd; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6788838d543so10722362a12.1
        for <cgroups@vger.kernel.org>; Tue, 28 Apr 2026 11:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777402012; cv=none;
        d=google.com; s=arc-20240605;
        b=Zba4Qt9OLUae4mJjbNaRNjbOyX3Zz/7RgNPMLYuxMfFSsE0if+PrP2V2SJaUAwBhti
         9WlU4+5ej1fqb9nHSXhcaPdaRJUlXe3vPmGu+uPsbSbzCcpvXaO18wooUuEYvzekbkSc
         UcGbRz+2VdgzqgP4srmWvE1c1Lcc5Ocuj87qeRcdw7Jmb6DXYaL0Ujiuq8udPUzSdSdV
         Dzu8u36cVuCli5maRE76B9fSCMEe0XYVy25i8LiGu+p5aYfR2DN4Ld+P1Wc+pS5j1hpe
         qBUScfWsCFxtoO+kcAogCR79ZKJODj5f3mZ62X8cKbVs4znkewWMPZ3YmyM9Zkvoq6JA
         KcTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EKFG0RDVEK246wBeg1IKZgBSUBwwFpLrZPo+iyiQ1R0=;
        fh=NredZwKVd5x8FNLWdMaaYCprxxCrj109y8pWAwhdcR0=;
        b=Gh+aN6tDrjKYj5P8o/Vw1bfl71AdwFpsLyu22YYc9MVIrGr+pDH38yLvzsvb+JmJKy
         OSBKjig9ObfNJ4wraNh9biY30nO395dgB5GLV2f+QmWqyhLE25IklVCemZtCPwa0pDBu
         vNvLssum7n5AmQEDFBRgABmluLdB9OCyv+SoaCSqXOy93zovYh6I2QDgn0cY4Hd2oUmW
         el/cToiilSX7erKIu19fKOw1G8i4XpHU6oPan+n/v/OasD/flr1YXtAI0aEQDYO2YyBv
         PuzCfkysbMpL/mud9BbIRnQeX11OWkRpm6J/X4FlBYWUGLFi6JevQwuxDLw3Xgjn04Yg
         dGhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777402012; x=1778006812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKFG0RDVEK246wBeg1IKZgBSUBwwFpLrZPo+iyiQ1R0=;
        b=Ifd83xBd9a48T6zVcOCH/JADVnoDZqlx2S+0AZOWlIAKt1nLA1ZB9lMupz6AS2uAHO
         SKbiml2TJZO4fnLBzpECnNjOydpHYwHIreTmEc9DjWUOnP/XWlEkXHAxolnIKBVGjgE5
         QpSQ5XcWoUPEi0w0yCYXUDX0lyqtoVsiiMwD3wGyW1fQbnjLoI9TKIi0WgCib7wh02B8
         L1OIbS6xWUfSv3oJRM1k0aJSLXuc54pLtKjb1qqUn+D9BoOjyx+mgo2R1hsM2awqFfzh
         bQr6Ii/AXWLwp/fDAukV5mNiw0l019VhZrdM4MzDwJO4PJ0sMPqAjTprua2wM94N5+bo
         MD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777402012; x=1778006812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EKFG0RDVEK246wBeg1IKZgBSUBwwFpLrZPo+iyiQ1R0=;
        b=ZiAfyGOkvgMlmaeSWJ9kbS6UhAp9TiFMDdPFuqJfIrFyZcw1DUhpsGZD+d5cLSrDCW
         txHgCw/4bPTbhLTsIive0fsbY/2/3xbrYtt2Xs+tmaGsGsP6bfE6WNKNu4Iordpl/Lxw
         1AHpuaBUBEzA6+ZHSy3stlJHEsfszenw8D2rDfJHVL3c2/jEu8+xdmwlxHrw6IaDzh16
         OXccTVG90SP9FlK5GHfGwBiE0s7P+cMr7aCST2AHW8mSsgessgvPwjzStcn8BqO07Ept
         ah/B6Giw24znKlfe9DxKkQOf1aaV5SO/UVabZ1NwPrBXUoQ7rJL0tJHyF24eg0KFs1Sv
         Audg==
X-Forwarded-Encrypted: i=1; AFNElJ+x5sWX1bMxvifUW+qcKy/5cMeDpPDsJMoZ5lqqCl9ReyNS9mt1VR8+cYidsw3rmzKKg0UgktoM@vger.kernel.org
X-Gm-Message-State: AOJu0YzacPGFBMYr8E2GZ0wCkxlKmZfdo6RfEc7vVHacQ5gLitaxBHdw
	xsBWQwK1rLP+OasQaa29yPZTjf+4rcSKFbGAzlsRr+DVDc4dMekcySS0h/icctoRReU6ounVaQU
	hIoQuG5sDDh9uDsZ0iWgGYZkSn7pPpW8=
X-Gm-Gg: AeBDieuMpHGt44RcMGZMcUqTDRpJmOKzOVJ8+RJSdsAhTtSO/yr886hb6H1r1OGT9os
	g4xmOhatKywRvZrJ9SE62jl43cxM+9jczDAF2VP7uphgrrxwo31vbenIkHrDd1kwVglLpBxMepB
	V+MdmRnkFVyzVrZWObHpWHXh+S+7IJMAg5thJKP6+YpuwWUo3+envH2z3UwVNtmbTOnNu0vd8R8
	P0aHRuoNlhX9tSVu4B1bjHDR6juY9TmESlVFIWSRXPi4GZwoauI16prfKRWtSybtm+z/2Z8nqET
	qCC2X9iCKvvTiQRX0yb8xP+daqM6Ixsr5QwZVOa1HnEc+DimalaxzqSQpOByGQ==
X-Received: by 2002:a05:6402:4544:b0:671:a18b:32b8 with SMTP id
 4fb4d7f45d1cf-67b1fce62e4mr516715a12.0.1777402012124; Tue, 28 Apr 2026
 11:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <aegUoOiUbjUAH5aT@google.com>
 <CAMgjq7C53WRS5oYxO157mX7JxhfoPoi34k+taiKLrMah-b-iRg@mail.gmail.com>
 <aektdlD4npMVThu3@google.com> <CAMgjq7DRrz4Hdy-s4y-C=3BmPt50LKOfdWjjf2mWmCybdRaJ4w@mail.gmail.com>
 <CAO9r8zPvApgxKiVy5NhiWup_m57huF3MTuPvo=iq5kAxjRZC8Q@mail.gmail.com>
 <CAMgjq7AGzBubCkmv7LubBjPLN1DzL472d4zUm+sGxo8ZptMgRw@mail.gmail.com>
 <CAO9r8zO+tm2J0FRC64VKCYOSuKPXX8cQG7C07SwMWKoLiwoV+w@mail.gmail.com>
 <CAMgjq7D1WXUHqAV1yuXvrUmEsE_m_+yx0mBq6teJhipx6mySbA@mail.gmail.com>
 <CAO9r8zMk7xTi-Txmj1+Z9=250fD8HuMQFyT1iwjTW9coLXgqoA@mail.gmail.com>
 <CAMgjq7A4+Sac9-CYkig1LFfEh5rq-4vLka8AXREei_m3svzJ7w@mail.gmail.com> <CAO9r8zMv6oYvqXti8dFfQd79Nd_Yge5g-EjjjhsEWj44gwJ-qQ@mail.gmail.com>
In-Reply-To: <CAO9r8zMv6oYvqXti8dFfQd79Nd_Yge5g-EjjjhsEWj44gwJ-qQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Apr 2026 02:46:15 +0800
X-Gm-Features: AVHnY4KwMPQSKOHLniO-vRRmC7fG6-z8dUk1aqr3V42lrdSb0J0CfA2hErWWeCU
Message-ID: <CAMgjq7BZpU5K1xHyFiqpsjeFe6CZUouGY_gOGMwbkM2Duq-vGg@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Yosry Ahmed <yosry@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	akpm@linux-foundation.org, Alistair Popple <apopple@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Baoquan He <bhe@redhat.com>, 
	Byungchul Park <byungchul@sk.com>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@kernel.org>, 
	Dev Jain <dev.jain@arm.com>, Gregory Price <gourry@gourry.net>, 
	Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Lance Yang <lance.yang@linux.dev>, lenb@kernel.org, 
	linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Brost <matthew.brost@intel.com>, 
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Mariano Pache <npache@redhat.com>, Pavel Machek <pavel@kernel.org>, Peter Xu <peterx@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Pedro Falcato <pfalcato@suse.de>, 
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Suren Baghdasaryan <surenb@google.com>, tglx@kernel.org, 
	Vlastimil Babka <vbabka@suse.cz>, Wei Xu <weixugc@google.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Yuanchu Xie <yuanchu@google.com>, Qi Zheng <zhengqi.arch@bytedance.com>, Zi Yan <ziy@nvidia.com>, 
	Meta kernel team <kernel-team@meta.com>, Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BCCEB48AD48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15545-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 2:23=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Fri, Apr 24, 2026 at 12:52=E2=80=AFPM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > On Sat, Apr 25, 2026 at 3:12=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> =
wrote
> > > Why >16 bytes? Do we need anything extra other than the reverse
> > > mapping? Also why do we need a double lookup?
> >
> > You will have to store at least the following info: memcg (2 bytes),
> > shadow (8 bytes), count (at least 1 bytes), and revert mapping (8
> > bytes, since you have to address a full virtual swap space). And some
> > type info is also needed. Part of them can be shrinked but still,
> > scientifically, merging two layers into one is considered a kind of
> > optimization.
> >
> > You need lookup the virtual layer, then the lower layer for many
> > decision making, is was discussed before to introduce more cache bit
> > or things like that and I think that is getting over complex, reminds
> > me of the slot cache or HAS_CACHE thing...:
> > https://lore.kernel.org/linux-mm/CAMgjq7DJrtE-jARik849kCufd0qNnZQs7C8fc=
yzVOKE14-O+Dw@mail.gmail.com/
>
> I think that's where the disconnect is. You are considering these two
> separate layers, each with its own metadata. The metadata should only
> live in one place.
>
> If we only have swap tables in the virtual swap layer (with the
> metadata), backends do not have to carry the metadata. In this case,
> backends should only have a reverse mapping (if needed), and some
> internal data structure (e.g. bitmaps) to track usage.

Ah, you are right. This is currently an intermediate state, that
problem might be gone if we unified everything.

> This is difficult to achieve if the virtual swap layer is optional,
> because then the metadata can live in different places. This is why I

But that's not difficult to achieve at all with an optional layer, and
actually will be achieved naturally without any design change with the
RFC I posted. Swap count / cgroup / shadow all stay in the top layer,
lower layer is "reverse map" only (the undone part though, it will
require to move the cluster cache from global to device level, which
is also required for YoungJun's tier or any functional tiering to
work, we may run into more and more detail issue like this).

Might even be easier that way, it's pretty close to the unified states I th=
ink.

